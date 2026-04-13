Return-Path: <netdev+bounces-277982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG+XKD6k3GkEUgkAu9opvQ
	(envelope-from <netdev+bounces-277982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:07:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B64FC3E8D10
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 946E83025165
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 08:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5483A4520;
	Mon, 13 Apr 2026 08:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="HBI81EW2"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C051A1DD525;
	Mon, 13 Apr 2026 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067477; cv=none; b=PJqx49OnoIyT/SwXon+XgL8bNTLoKlh0LUKdIoPLQuLTpYsU2vorUnli5/b6tWFS6Jtj4KCMBWDAa4W+m00wluEdrXyCiQOlHrPdaAp7NXQbYiewwfAbwsz81dhybbyljup+8rdbjhXCzjFTaIrzHhuV3/mFVd9283GeAXRHpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067477; c=relaxed/simple;
	bh=XrQXo6XMhykepeRVxPMIsG+HJmrNavK7m6d11VND484=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eLbRdOayX0NT38Zr6KPrbWVClEIUZcrVRhqwzLI6Bc3D4kr/+HK70IDJvS3Dr7DtESxoZTlLYUDpF2aPqJfv+t+ipqR+Iq4b9sEFrCGmg/vHWgQxM1GRUj1PQ2gK244AyFdatzJMrNoqFmWW0b4pWQUby49/KtpOmPDFI3aZROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=HBI81EW2; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/a
	u4QYNETB6YPLLfe9q3AVHuigBjp3RH3DP3ODwItXQ=; b=HBI81EW2MR8GiW3ZEV
	cPnW95tg7DBNUUzO3ea1roA1Tsd2KDDCDqu8cQObb3Q5ABH6XWXcBcUISxifzTSi
	hGqCPnyx++YdQFT9xCuX2LYj+zRC9SH57jshIYLR0UJRG5kkHXRcKHyMq0pa89WE
	UfW7ZZRKhcjHrdkFOmuorWMHw=
Received: from YUANZM2-F4WK0J3.lenovo.com (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgD3P3VXo9xphRR+Cw--.61877S2;
	Mon, 13 Apr 2026 16:03:35 +0800 (CST)
From: wit_yuan <yuanzhaoming901030@126.com>
To: jk@codeconstruct.com.au
Cc: yuanzhaoming901030@126.com,
	yuanzm2@lenovo.com,
	matt@codeconstruct.com.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: mctp: don't require received header reserved bits to be zero
Date: Mon, 13 Apr 2026 16:03:33 +0800
Message-Id: <20260413080333.73086-1-yuanzhaoming901030@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCkvCgD3P3VXo9xphRR+Cw--.61877S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFW8urW5uFW5JFy3GFWUtwb_yoW5XF1rpF
	1UKayj9FWkKry7Kw4kAan5ZwnYgws5Ka43Cr4Igw4Iy3ZIgr18WFy0kr1UJr1DurZrGF93
	X3yag345X3ZrXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEtxhtUUUUU=
X-CM-SenderInfo: h1xd065kdrzxtqjziiqqtqqiyswou0bp/xtbBsBiQm2nco1hbogAA3U
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[126.com,none];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-277982-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[126.com,lenovo.com,codeconstruct.com.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[126.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[126.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuanzhaoming901030@126.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lenovo.com:email]
X-Rspamd-Queue-Id: B64FC3E8D10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yuan Zhaoming <yuanzm2@lenovo.com>

From the MCTP Base specification (DSP0236 v1.2.1), the first byte of
the MCTP header contains a 4 bit reserved field, and 4 bit version.

On our current receive path, we require those 4 reserved bits to be
zero, but the 9500-8i card is non-conformant, and may set these
reserved bits.

DSP0236 states that the reserved bits must be written as zero, and
ignored when read. While the device might not conform to the former,
we should accept these message to conform to the latter.

Relax our check on the MCTP version byte to allow non-zero bits in the
reserved field.

Signed-off-by: Yuan Zhaoming <yuanzm2@lenovo.com>

---
v2: https://lore.kernel.org/netdev/20260410144339.0d1b289a@kernel.org/T/#t
v1: https://lore.kernel.org/netdev/ff147a3f0d27ef2aa6026cc86f9113d56a8c61ac.camel@codeconstruct.com.au/T/#t
---
 include/net/mctp.h | 3 +++
 net/mctp/route.c   | 8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/net/mctp.h b/include/net/mctp.h
index e1e0a69..d8bf907 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -26,6 +26,9 @@ struct mctp_hdr {
 #define MCTP_VER_MIN	1
 #define MCTP_VER_MAX	1
 
+/* Definitions for ver field */
+#define MCTP_HDR_VER_MASK	GENMASK(3, 0)
+
 /* Definitions for flags_seq_tag field */
 #define MCTP_HDR_FLAG_SOM	BIT(7)
 #define MCTP_HDR_FLAG_EOM	BIT(6)
diff --git a/net/mctp/route.c b/net/mctp/route.c
index e69c6f7..62517c9 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -439,6 +439,7 @@ static int mctp_dst_input(struct mctp_dst *dst, struct sk_buff *skb)
 	struct mctp_hdr *mh;
 	unsigned int netid;
 	unsigned long f;
+	u8 ver;
 	u8 tag, flags;
 	int rc;
 
@@ -467,7 +468,8 @@ static int mctp_dst_input(struct mctp_dst *dst, struct sk_buff *skb)
 	netid = mctp_cb(skb)->net;
 	skb_pull(skb, sizeof(struct mctp_hdr));
 
-	if (mh->ver != 1)
+	ver = mh->ver & MCTP_HDR_VER_MASK;
+	if (ver < MCTP_VER_MIN || ver > MCTP_VER_MAX)
 		goto out;
 
 	flags = mh->flags_seq_tag & (MCTP_HDR_FLAG_SOM | MCTP_HDR_FLAG_EOM);
@@ -1316,6 +1318,7 @@ static int mctp_pkttype_receive(struct sk_buff *skb, struct net_device *dev,
 	struct mctp_skb_cb *cb;
 	struct mctp_dst dst;
 	struct mctp_hdr *mh;
+	u8 ver;
 	int rc;
 
 	rcu_read_lock();
@@ -1334,7 +1337,8 @@ static int mctp_pkttype_receive(struct sk_buff *skb, struct net_device *dev,
 
 	/* We have enough for a header; decode and route */
 	mh = mctp_hdr(skb);
-	if (mh->ver < MCTP_VER_MIN || mh->ver > MCTP_VER_MAX)
+	ver = mh->ver & MCTP_HDR_VER_MASK;
+	if (ver < MCTP_VER_MIN || ver > MCTP_VER_MAX)
 		goto err_drop;
 
 	/* source must be valid unicast or null; drop reserved ranges and
-- 
2.43.0


