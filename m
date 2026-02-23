Return-Path: <netdev+bounces-260002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNkkBYs5nGlCBgQAu9opvQ
	(envelope-from <netdev+bounces-260002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:27:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6681F1757D2
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8573305DA53
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FD935DD1C;
	Mon, 23 Feb 2026 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q2lb2ihs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C413335CB8B
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845839; cv=none; b=pygUx8cZZbJPGN1vIN21m5WN/XzP8jn9enu3ptE5SKPZp4g+uHteoW26bU3AChvc273EmmtQ9nucETLvD1JK0P5DRYjS1YqJnvgSIU6dNGqR/E1fGlWP6Un0C5wId59P+W+F0eqyzOzYwnQiEn64S7ZClqUNA0LUuJR0Su8HTuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845839; c=relaxed/simple;
	bh=JPgultTIWgbNYxA4vXArnqWlMkM/RR4GlNiyDYUXKLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNCY8fsrBRQBSMDKjeYVLtyQ8L608SJrdPKh2m0oqJ1o8VZxSHF7qbmAyQBNuV41YuFgLPKuCrN7Fu13zMRJRKWgZ4c6Jhwn2C9RS+AGVl3Y0EPD4tzqFH/YSETAYpHXUCXuaZCr0MAPa+dtZUGc1dWMRZ8Ul2n57Rg8ye7KaCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q2lb2ihs; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-c6de5ea6879so493261a12.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 03:23:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845837; x=1772450637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9EWl9Y2Ycs1HrHu15KRF0sV4Ewn7s/wLLI95hZv0i4=;
        b=mMPc964vNQt/Ww/BtVl78OpYdoVgB742N9RScZvBQwYVOIj0ekXOoKrUd4Qm7feTKG
         lhO0DS92iikVE3ys3ya20xevw2zHpCDo78RE7SAR4pLG6+63/ik6ae+XpDos63HngXGX
         WmTlLqXKqXWsLklYn5g8/HkIbRonzAOSEIP4tCKJOB9J6zPyyFjnoff491JSBmMqzhEq
         au/ly3peb4vMH6lad6S5deOgr5gIoDsgpg05M8nAKM1UsMhLTG3tvLX0qO2XxnkAtJdD
         hdXHMpDaZH1OmkiHf+kVYNZ3EvMB06JO0ccqGKCMEyRS2S7K5BzHA+RUcB957ajZ8D42
         MbLA==
X-Forwarded-Encrypted: i=1; AJvYcCV8ODUwIpDFLjz5sGqmUpKX0ZTIw1NWMzeGUGOARolZV+7F9oPPd8rGL5wpTItbAsDt1JRYTCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3D3yj+XUXr4y4JR8+jChrXQ3oLoy7349dvMtJtICaFUvaoCQQ
	1iTvwawpQOVGgCwReyrbOxm2t7BiRTq+QFWyndB4MPsID/WXvHmvi+rTxU3wZ6o/3zdDhxrQbUC
	j6+5sPHDALYJnDMRrLgeUg8QSp4DR8rhCJQA1QY6UBppadjkyW1rNip1c1Z24gs7prfc1MdsLI9
	WEaIbYT37tzHVZJ91Acr4DIoEZ54xrCnkaK8lYu9WT/nL3JqRaZutPDScecgfgFV/V05ZXWLlX5
	c4B374frURcvo3/HOQkFGh3SY1p9zU=
X-Gm-Gg: ATEYQzwaaHJENNPc1Fe2JvTZKpo++HZxp3Zi5uLs5mizReBn+4xhjs4PS6RTWa7sY2u
	efhjnmzxicO0pQndDbLojVtnqpAnjCQSN2Hmsvkc3XhnoOS1lZtc5qUAP/jX69NR9kvwmDsW0Dt
	HCRikoRNUP/ca8cmQSdLp8Dv8m4FLK+61ZmBODlhEhRDttf9OGbYxozuErgbUa7WNAvUDPSilIw
	+50Tu1ksCChoF4q4tVXFCzFbtrI39NI740gGmUwhEpLe96O/M6xD2Md3b7/hqbvwuFRTDSIeyW4
	Xqe3dw/TArihl9Ovzkc2Z9y/evSOEVl3nfsV2KOxd/wFrx96AjeDWE55/U9Ww1BtScOR941ex9R
	o/ZAZ9znhubnoLiQCmMcp9cZqsf5nHgz3ZweN1AIPdOiM/V2SxeqQq6kPcERW9apT1sTl8dtkb0
	1ZJadcu1paYbJyC0azcWNn4Xg0+emUy6O08DcQMp/Oyq1qq2GJwcaOljx3ydahGjMfaK3HQ9D2c
	g==
X-Received: by 2002:a17:90a:d645:b0:349:2cdd:434a with SMTP id 98e67ed59e1d1-358ae8c3000mr5206444a91.5.1771845836991;
        Mon, 23 Feb 2026 03:23:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c70b717d4f4sm988182a12.2.2026.02.23.03.23.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 03:23:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8954937be97so60849316d6.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 03:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771845835; x=1772450635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C9EWl9Y2Ycs1HrHu15KRF0sV4Ewn7s/wLLI95hZv0i4=;
        b=Q2lb2ihssqbq6RlsYb0F/fBARy8lHelBo04AIS1+osNQR0AJBBfbGcRfdnu+eJUcEY
         Zy37Wa8DL+zO6fyDJanKNJMUuaSie0kAk/voTgMDNI4pyWlbnVZOPzYzP3UoilYN+zOH
         XsaYlfP+zN4F1wSD7RS+VCfo8DC65ZsR5mxIM=
X-Forwarded-Encrypted: i=1; AJvYcCV/ij/UY53BGr3+aEb6k0lZhV5wzDijg0E4PLMOcrbfdsf1J8r1fLQubx3jQe5yM73fmpzYQrw=@vger.kernel.org
X-Received: by 2002:a05:6214:4f1a:b0:897:1d50:2336 with SMTP id 6a1803df08f44-89979d74070mr82436566d6.6.1771845835403;
        Mon, 23 Feb 2026 03:23:55 -0800 (PST)
X-Received: by 2002:a05:6214:4f1a:b0:897:1d50:2336 with SMTP id 6a1803df08f44-89979d74070mr82436216d6.6.1771845834866;
        Mon, 23 Feb 2026 03:23:54 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d1224f6sm682922385a.46.2026.02.23.03.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:23:54 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kafai@fb.com,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 v6.12] ipv6: use RCU in ip6_xmit()
Date: Mon, 23 Feb 2026 11:18:50 +0000
Message-ID: <20260223111850.4165186-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260002-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_NEQ_ENVFROM(0.00)[keerthana.kalyanasundaram@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6681F1757D2
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9085e56501d93af9f2d7bd16f7fcfacdde47b99c ]

Use RCU in ip6_xmit() in order to use dst_dev_rcu() to prevent
possible UAF.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250828195823.3958522-4-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
Changes in v2:
- Modified to apply on latest v6.12.y

 net/ipv6/ip6_output.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 24b68e996..0aedb2007 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -267,35 +267,36 @@ bool ip6_autoflowlabel(struct net *net, const struct sock *sk)
 int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	     __u32 mark, struct ipv6_txoptions *opt, int tclass, u32 priority)
 {
-	struct net *net = sock_net(sk);
 	const struct ipv6_pinfo *np = inet6_sk(sk);
 	struct in6_addr *first_hop = &fl6->daddr;
 	struct dst_entry *dst = skb_dst(skb);
-	struct net_device *dev = dst_dev(dst);
 	struct inet6_dev *idev = ip6_dst_idev(dst);
 	struct hop_jumbo_hdr *hop_jumbo;
 	int hoplen = sizeof(*hop_jumbo);
+	struct net *net = sock_net(sk);
 	unsigned int head_room;
+	struct net_device *dev;
 	struct ipv6hdr *hdr;
 	u8  proto = fl6->flowi6_proto;
 	int seg_len = skb->len;
-	int hlimit = -1;
+	int ret, hlimit = -1;
 	u32 mtu;
 
+	rcu_read_lock();
+
+	dev = dst_dev_rcu(dst);
 	head_room = sizeof(struct ipv6hdr) + hoplen + LL_RESERVED_SPACE(dev);
 	if (opt)
 		head_room += opt->opt_nflen + opt->opt_flen;
 
 	if (unlikely(head_room > skb_headroom(skb))) {
-		/* Make sure idev stays alive */
-		rcu_read_lock();
+		/* idev stays alive while we hold rcu_read_lock(). */
 		skb = skb_expand_head(skb, head_room);
 		if (!skb) {
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
-			rcu_read_unlock();
-			return -ENOBUFS;
+			ret = -ENOBUFS;
+			goto unlock;
 		}
-		rcu_read_unlock();
 	}
 
 	if (opt) {
@@ -357,17 +358,21 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 		 * skb to its handler for processing
 		 */
 		skb = l3mdev_ip6_out((struct sock *)sk, skb);
-		if (unlikely(!skb))
-			return 0;
+		if (unlikely(!skb)) {
+			ret = 0;
+			goto unlock;
+		}
 
 		/* hooks should never assume socket lock is held.
 		 * we promote our socket to non const
 		 */
-		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
-			       net, (struct sock *)sk, skb, NULL, dev,
-			       dst_output);
+		ret = NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
+			      net, (struct sock *)sk, skb, NULL, dev,
+			      dst_output);
+		goto unlock;
 	}
 
+	ret = -EMSGSIZE;
 	skb->dev = dev;
 	/* ipv6_local_error() does not require socket lock,
 	 * we promote our socket to non const
@@ -376,7 +381,9 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 
 	IP6_INC_STATS(net, idev, IPSTATS_MIB_FRAGFAILS);
 	kfree_skb(skb);
-	return -EMSGSIZE;
+unlock:
+	rcu_read_unlock();
+	return ret;
 }
 EXPORT_SYMBOL(ip6_xmit);
 
-- 
2.43.7


