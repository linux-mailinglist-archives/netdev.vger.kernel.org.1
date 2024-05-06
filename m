Return-Path: <netdev+bounces-93888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1668BD84B
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 01:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7C51C21AB6
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 23:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F9F15E1FF;
	Mon,  6 May 2024 23:53:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E287F15DBC7
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715039591; cv=none; b=Bnb+00PGqzvFfAquAUNInXjfgJ4TkQ6dqsy956s3JsA3IxOLdVPCQ5Qejt1urZuhOoAfYGokSmROtJG2mN2vyc9LRP0QL9tBCES2wvox/RnP6B/uebtGnJ7TkpyFTYMVsNgKWy1iXtLO2KVaQGoqhbfwCTzM9SEe5TmFnxeMd+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715039591; c=relaxed/simple;
	bh=0kMHijtJEnwOCypAw8I3Tk4yxrquPkUA2tXllxG1yVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rX+s7Wdvj15rPxoMo/YdLGG76igOfkehTSZWGmx+11Gui2OeNQ1Op7SLEDJdFmYzNcFI2+fMFhy65h5TwUM51gYx9WccGVyZkt63vxDHwlT7Tb2qlKDhVMbod/CTd4+PkMMRCaazuD+jyJ7mC0jqx3Z+zzLhIDdax5xioMMLmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	laforge@osmocom.org,
	pespin@sysmocom.de,
	osmith@sysmocom.de,
	horms@kernel.org
Subject: [PATCH net-next,v3 06/12] gtp: pass up link local traffic to userspace socket
Date: Tue,  7 May 2024 01:52:45 +0200
Message-Id: <20240506235251.3968262-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240506235251.3968262-1-pablo@netfilter.org>
References: <20240506235251.3968262-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to TS 29.061, it is possible to see IPv6 link-local traffic in
the GTP tunnel, see 11.2.1.3.2 IPv6 Stateless Address Autoconfiguration
(IPv6 SLAAC).

Pass up these packets to the userspace daemon to handle them as control
GTP traffic.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 drivers/net/gtp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 8e861778c4e9..939699d6cf6f 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -251,6 +251,10 @@ static bool gtp_check_ms_ipv6(struct sk_buff *skb, struct pdp_ctx *pctx,
 
 	ip6h = (struct ipv6hdr *)(skb->data + hdrlen);
 
+	if ((ipv6_addr_type(&ip6h->saddr) & IPV6_ADDR_LINKLOCAL) ||
+	    (ipv6_addr_type(&ip6h->daddr) & IPV6_ADDR_LINKLOCAL))
+		return false;
+
 	if (role == GTP_ROLE_SGSN) {
 		ret = ipv6_pdp_addr_equal(&ip6h->daddr, &pctx->ms.addr6);
 	} else {
-- 
2.30.2


