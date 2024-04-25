Return-Path: <netdev+bounces-91264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0211E8B1FA5
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 12:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1DB0282A52
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 10:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270912BAE3;
	Thu, 25 Apr 2024 10:51:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536E91EB3F
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042312; cv=none; b=DvH6e0N/wpzGpR0eE5L3sFafw6PKJ+PkTHChmqY7PQQ+fvRAY/n4Awkki6VMvBDMuAroo7kSrgZNu4RWqrmZgq/sbGs7eB/Qr/agXwGa3ctdpCRtP6ie1x4dmbBOp9eb4Z27/OvIUoMn9hLwdw2SHqERS5BS02wmI/Sm3skQp0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042312; c=relaxed/simple;
	bh=rLIg6JOz6gDMxBpfcjJhmMEqYka+BuPc3gtrZMgQMH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Exr7cPr5gXLHthE6eukKOgbSb0WKhS2Dgv3OCUV0si//frdMa5+gcqciFm6oJ+Tf7v+VOWRvgemKMVYJPRzvPWvFktMHv97iXDkK8iWizwevauVhyxQIFvQkoERT8g0OzQMOHi9dFyysAG/7m4ll8NsRZVOTQWAOYKjNqMhT3BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	laforge@osmocom.org,
	pespin@sysmocom.de,
	osmith@sysmocom.de,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 02/12] gtp: properly parse extension headers
Date: Thu, 25 Apr 2024 12:51:28 +0200
Message-Id: <20240425105138.1361098-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240425105138.1361098-1-pablo@netfilter.org>
References: <20240425105138.1361098-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently GTP packets are dropped if the next extension field is set to
non-zero value, but this are valid GTP packets.

TS 29.281 provides a longer header format, which is defined as struct
gtp1_header_long. Such long header format is used if any of the S, PN, E
flags is set.

This long header is 4 bytes longer than struct gtp1_header, plus
variable length (optional) extension headers. The next extension header
field is zero is no extension header is provided.

The extension header is composed of a length field which includes total
number of 4 byte words including the extension header itself (1 byte),
payload (variable length) and next type (1 byte). The extension header
size and its payload is aligned to 4 bytes.

A GTP packet might come with a chain extensions headers, which makes it
slightly cumbersome to parse because the extension next header field
comes at the end of the extension header, and there is a need to check
if this field becomes zero to stop the extension header parser.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 drivers/net/gtp.c | 41 +++++++++++++++++++++++++++++++++++++++++
 include/net/gtp.h |  5 +++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 4680cdf4fa70..9451c74c1a7d 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -567,6 +567,43 @@ static int gtp1u_handle_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 				       msg, 0, GTP_GENL_MCGRP, GFP_ATOMIC);
 }
 
+static int gtp_parse_exthdrs(struct sk_buff *skb, unsigned int *hdrlen)
+{
+	struct gtp_ext_hdr *gtp_exthdr, _gtp_exthdr;
+	unsigned int offset = *hdrlen;
+	__u8 *next_type, _next_type;
+
+	/* From 29.060: "The Extension Header Length field specifies the length
+	 * of the particular Extension header in 4 octets units."
+	 *
+	 * This length field includes length field size itself (1 byte),
+	 * payload (variable length) and next type (1 byte). The extension
+	 * header is aligned to to 4 bytes.
+	 */
+
+	do {
+		gtp_exthdr = skb_header_pointer(skb, offset, sizeof(gtp_exthdr),
+						&_gtp_exthdr);
+		if (!gtp_exthdr || !gtp_exthdr->len)
+			return -1;
+
+		offset += gtp_exthdr->len * 4;
+
+		/* From 29.060: "If no such Header follows, then the value of
+		 * the Next Extension Header Type shall be 0."
+		 */
+		next_type = skb_header_pointer(skb, offset - 1,
+					       sizeof(_next_type), &_next_type);
+		if (!next_type)
+			return -1;
+
+	} while (*next_type != 0);
+
+	*hdrlen = offset;
+
+	return 0;
+}
+
 static int gtp1u_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
 {
 	unsigned int hdrlen = sizeof(struct udphdr) +
@@ -616,6 +653,10 @@ static int gtp1u_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
 		return 1;
 	}
 
+	if (gtp1->flags & GTP1_F_EXTHDR &&
+	    gtp_parse_exthdrs(skb, &hdrlen) < 0)
+		return -1;
+
 	return gtp_rx(pctx, skb, hdrlen, gtp->role);
 }
 
diff --git a/include/net/gtp.h b/include/net/gtp.h
index 2a503f035d18..c0253c8702d0 100644
--- a/include/net/gtp.h
+++ b/include/net/gtp.h
@@ -78,4 +78,9 @@ static inline bool netif_is_gtp(const struct net_device *dev)
 #define GTP1_F_EXTHDR	0x04
 #define GTP1_F_MASK	0x07
 
+struct gtp_ext_hdr {
+	__u8	len;
+	__u8	data[];
+};
+
 #endif
-- 
2.30.2


