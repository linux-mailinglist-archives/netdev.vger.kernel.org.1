Return-Path: <netdev+bounces-261181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO8UF0jFn2kRdwQAu9opvQ
	(envelope-from <netdev+bounces-261181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 05:00:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C801A0BA9
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 05:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 290FC303CED2
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8781389DE0;
	Thu, 26 Feb 2026 04:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A+zqachk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8623876B2
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772078405; cv=none; b=i6CJvb5eYZiolSkIdFuewbWPio65DfJeQWXku5Xq8HVgEM+K3RT8T4N31+aPrK/juDUCdtF8li2BA+4fbId+yhBaKY1jda4UA7z02CYTOjADvlESnH9vsnKfqzUEgAA9IjSAS3Z+q5OG7W/rFKANLhGak5oynh1RyYJim7+K1vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772078405; c=relaxed/simple;
	bh=yUL8W7q3973HgXkMv9YNfI6lkImeogNMi/pAL3ytizw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qFWsxJG8TaaoBeLQOg/43sfCRnobMB5kQSPFMtmeEV8IxTecvklAPGz5gv0xDmLmYV09cBF0S3N2/6usBZBaPNKZZiO6u1LYD5v5cwUFlyFgmTjx6Iv18IDZDGBxC6hBLvMg1z34TbkIGMC6rilaxzj4WAHECw5AnYPgKsZGQw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A+zqachk; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2ad2b375e58so717375ad.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 20:00:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772078404; x=1772683204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2vekJc+TZLbqZ8ynAz/dWVNNz4zBmku0WGBUmEYr8g=;
        b=MO12GhCIy2sqrvkQ0ZV4dmVu4L0kxDmOLcFqVQz3DetA2UH3j6JdbotRjV9e2yI5+d
         mRu/8wXUbqy+Td+0lHhTqgQZBLEFf3fY0eqZsOjXwMuO0aIRZ1J05+Fe5JMfoP7c2bxG
         M59fTeUv40/TXoZL8YVCUkl+1RuUwxWD23E2avaC3oUPMA4v2xlU35YT0BzQpsv4meDo
         +iJYFgycLhc2kltOXMv/EDgh9Z9qiVfgbutIfCc9EzInlI7pzDNil+MrlHFSKGLrN4zC
         KMaBV+SeXwEvgAhE1EL0fESjzz0mYdFrMvE/fjT7IPa0iRGQzfxJSiBWabaEkuNYnE+f
         mdtA==
X-Forwarded-Encrypted: i=1; AJvYcCWRPHhLwk5CKj5Cn6w7pHFs82SpvErtQtCTkAR89g9jag93mSIcQw4xFcoOuSXKRED4vhk/ppo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5mqWVWI5LVxGTn5WjFEKICbtxFJPzGn20ZK7jhwkTMKLeVgWE
	d5/HnpdrczhmWyfnBRxkigDqCwSDZAcgYLeO1xiNEEU4SUoL80jYVTCv4DBRbOP24B1zY8P3Jp8
	eqIMPBVcv4hqvLc9XVK1afZr8lxHkIeE/W8DK6idu1/KAAPb2VHsIq9QyacRVdGBg8ef9w1H77j
	l/lxGWqlK4Usy4XHHb6XWTFAQfmNbNzaDuRl2yDnTsP9g+XiBNsGMuPGgOE7LUPNrrmB9leHUsv
	AVkkjqO6y9S4eqretRdOYS9Km7wAWM=
X-Gm-Gg: ATEYQzwgnLFWRIiywZbvVjfROeskj6jh7zs04lRbnjSaE0fEs+1dG5PLvxTpxZl+cq5
	GvvU2z8Dgr7KAri8D5Y+iVqLOT55vRSjWZMlKd9/KS3Wv1Imr69q92arHpqVLeQwsCgMjREfhLT
	hb9QXoWSZXNRv0TjnqSt19kQxtZIunOe9314XOjDh60Qky8mSA4eo+a035W3x7qijPw0i+axcql
	D9kc7hNaKOXLlaFE2VnDhOE6ban+/3eNVOvP6aewU6nd7IQRlC2U83KoTpjhAR2bNmmOKlUopAO
	QZoNMefELHHYxJUUNc20e+z5Dmw4WrFGo5PvKr+8pvziINaIN0sMDL3HKPoleelmZSpRlIpWsYm
	eXIKyg/nLjNljrkCE8dqeq2hECpAvb3Lp8IhqNn0oqfJu8tr93eEdU5B57RBkpixAs5MUPhDbgB
	SfYH0dk4G4idTf9L9PRVrah4wPIy+54WOKi2OOC4wZHBxcmK8LRwTSwdCmHvS9OyPvl7eu9YQ5I
	Lc6
X-Received: by 2002:a17:903:3d10:b0:2ad:c66b:f5f6 with SMTP id d9443c01a7336-2adc66bf83amr37124245ad.0.1772078403625;
        Wed, 25 Feb 2026 20:00:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb5fc19asm1180745ad.50.2026.02.25.20.00.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2026 20:00:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50698374e33so4249831cf.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 20:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772078402; x=1772683202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i2vekJc+TZLbqZ8ynAz/dWVNNz4zBmku0WGBUmEYr8g=;
        b=A+zqachk6matRI+5fpEXHmXfKlrqdfM2yLcDcfZrVAJlykTS3cBbzB1kRSoKbOpV6v
         +yqH1rukCpOspQEFGDe8Lrz7Ke8VEn3dyDcJI1ROQInOKpHQgOsaGO6kvQuw/oPhRe8x
         8MKBnPVhwJmqiIpj2phFecaTOQUYifxQLDA5c=
X-Forwarded-Encrypted: i=1; AJvYcCU6ix39z6JI0U3NCnveW+85OduxKA9oXtZ2KQjVOa4M78tOPRuMdKIee9z67LLE4kb9QhB7tY8=@vger.kernel.org
X-Received: by 2002:a05:622a:34d:b0:502:a1bb:632a with SMTP id d75a77b69052e-5070ba7b201mr197204531cf.0.1772078402121;
        Wed, 25 Feb 2026 20:00:02 -0800 (PST)
X-Received: by 2002:a05:622a:34d:b0:502:a1bb:632a with SMTP id d75a77b69052e-5070ba7b201mr197204271cf.0.1772078401594;
        Wed, 25 Feb 2026 20:00:01 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5074496300fsm10415161cf.2.2026.02.25.19.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 20:00:00 -0800 (PST)
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
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v3 v6.12] ipv6: use RCU in ip6_xmit()
Date: Thu, 26 Feb 2026 03:54:49 +0000
Message-ID: <20260226035449.3222120-1-keerthana.kalyanasundaram@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261181-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_NEQ_ENVFROM(0.00)[keerthana.kalyanasundaram@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 03C801A0BA9
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
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
Changes in v3:
- Updated authors

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


