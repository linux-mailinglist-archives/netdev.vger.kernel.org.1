Return-Path: <netdev+bounces-277270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP6MG/uZ2GkgfggAu9opvQ
	(envelope-from <netdev+bounces-277270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:34:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A943D2D25
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA2243030D40
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 06:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C7038A707;
	Fri, 10 Apr 2026 06:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="p606waPd"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E2138836D
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 06:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802830; cv=none; b=TrLrSXytryXXqs98s0c00p1GJlB0oziqnvpNQbXLmi5PZrkCqAAWwwZrS/GnjG/YnRv27pqWYg6SN62ar9Yid5tdRFGyx/5z8To+pdnkWbXIuiYUbWVr6mxUyqFCbPpBgz8JS7BfkwlqVRpJQYoPG1oBCld2GX3pEpKkWQCtpDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802830; c=relaxed/simple;
	bh=k7Bl40ND0izrraTo2iqYR9VWnNM9qb0c1MGMEVehBv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PlyJh97whJPSo7oRl+hzju122YStak2EGpV7eZDlt3/XLYNff1BxgKOJF0lMgmC007hce/Y+sups/dZGVny73bY2ChRftkaZrNSkNrO8hNFuz6Dn5TxtvN9R+IhrrQurFgNd6cWlw60+ckxwrASMuLnaflqYhBJMw5LSEznOaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=p606waPd; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=eP
	lj0l3Pj4+bjFqZ6o5saRtTsk6tAaSXaEymjlhAFEA=; b=p606waPd4SVNwSAD/E
	fr/+BqZd0n01ijwsGYEuGW7ZoUSE9RNZOInkUNtGz6A6rgEGY6qij1E4G5ddSlAU
	/u+yfsIzPit9PktnD4zRWwaGLXEq1QWjESCir5o9hAdJa9xFS+2n/yyHx1vmEB8O
	mLbFsEywnXpFNVcS6eukquqN8=
Received: from YUANZM2-F4WK0J3.lenovo.com (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3fxq_mdhp439QBg--.60348S3;
	Fri, 10 Apr 2026 14:33:38 +0800 (CST)
From: wit_yuan <yuanzhaoming901030@126.com>
To: netdev@vger.kernel.org
Cc: Yuan Zhaoming <yuanzm2@lenovo.com>
Subject: [PATCH next-next v2] net:mctp: fix setting mctp hdr ver reserved field cause  data dropped
Date: Fri, 10 Apr 2026 14:33:34 +0800
Message-Id: <20260410063334.7531-2-yuanzhaoming901030@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410063334.7531-1-yuanzhaoming901030@126.com>
References: <20260410060957.1336-2-yuanzhaoming901030@126.com>
 <20260410063334.7531-1-yuanzhaoming901030@126.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fxq_mdhp439QBg--.60348S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFW8Gw1UKrW8XFWkGFyUWrg_yoW8Cw4UpF
	1DKrW09rWkKFW2gr4kAaykXanYg3s8Ka4Uur4Sgw40qwnxXr18GFWIkr1UJw18urZ7KF93
	JrWY9w1UJw47XF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVmhwUUUUU=
X-CM-SenderInfo: h1xd065kdrzxtqjziiqqtqqiyswou0bp/xtbBsQInMmnYmcJvfAAA3f
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[126.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277270-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[126.com];
	FROM_NEQ_ENVFROM(0.00)[yuanzhaoming901030@126.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[126.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lenovo.com:email]
X-Rspamd-Queue-Id: 12A943D2D25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yuan Zhaoming <yuanzm2@lenovo.com>

from spec dsp0236_1.2.1.pdf page 26, the mctp header contains the
RSVD(4bit) and Hdr version(4 bit).

mctp_pkttype_receive invoke mctp_hdr, and get mh->ver whole byte 
compare the MCTP_VER_MIN, MCTP_VER_MAX. the reserver bits may be by 
misleading used.

one type hba card will set pcie vdm header Pad Len the same with RSVD
bit, this will not work on mctp kernel solution.

Signed-off-by: Yuan Zhaoming <yuanzm2@lenovo.com>

---
 include/net/mctp.h | 1 +
 net/mctp/route.c   | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/mctp.h b/include/net/mctp.h
index f481007a6..1392fafe7 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -35,6 +35,7 @@ struct mctp_hdr {
 #define MCTP_HDR_SEQ_MASK	GENMASK(1, 0)
 #define MCTP_HDR_TAG_SHIFT	0
 #define MCTP_HDR_TAG_MASK	GENMASK(2, 0)
+#define MCTP_HDR_VER_MASK	GENMASK(3, 0)
 
 #define MCTP_INITIAL_DEFAULT_NET	1
 
diff --git a/net/mctp/route.c b/net/mctp/route.c
index 56c441e90..aa0e89d67 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -464,7 +464,7 @@ static int mctp_dst_input(struct mctp_dst *dst, struct sk_buff *skb)
 	netid = mctp_cb(skb)->net;
 	skb_pull(skb, sizeof(struct mctp_hdr));
 
-	if (mh->ver != 1)
+	if (((mh->ver & MCTP_HDR_VER_MASK)) < MCTP_VER_MIN || (mh->ver & MCTP_HDR_VER_MASK) > MCTP_VER_MAX)
 		goto out;
 
 	flags = mh->flags_seq_tag & (MCTP_HDR_FLAG_SOM | MCTP_HDR_FLAG_EOM);
@@ -1345,7 +1345,7 @@ static int mctp_pkttype_receive(struct sk_buff *skb, struct net_device *dev,
 
 	/* We have enough for a header; decode and route */
 	mh = mctp_hdr(skb);
-	if (mh->ver < MCTP_VER_MIN || mh->ver > MCTP_VER_MAX)
+	if (((mh->ver & MCTP_HDR_VER_MASK)) < MCTP_VER_MIN || (mh->ver & MCTP_HDR_VER_MASK) > MCTP_VER_MAX)
 		goto err_drop;
 
 	/* source must be valid unicast or null; drop reserved ranges and
-- 
2.43.0


