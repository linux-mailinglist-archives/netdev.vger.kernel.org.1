Return-Path: <netdev+bounces-257025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GsaJ+ZLhGm82QMAu9opvQ
	(envelope-from <netdev+bounces-257025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:51:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BE3EF98C
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1CC073002533
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E10235F8B6;
	Thu,  5 Feb 2026 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SYfEq2pT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDDD35EDDD
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277858; cv=none; b=pnaSnCMRRK7T2BZcrcpwsRB2jNcQiUusYXbGAZ6PKdAjcrvYCgGMFq3kBhplmX2RR4trMpmPphrkfNHFS9hTiyavpndIzL2UTd6vUoQf4/MFHOfoJYlHAWWi0nqoRQzSEtG+9Qn8L7RFdvaV6t/P0qjwZ9cAyG3w7PP31BQ/RWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277858; c=relaxed/simple;
	bh=JyGRnFnWXYKREoWVJoTjnH8Ki9I7rBqgCKkWILXrJ3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gdPbI+ZWjavHJUCBcfKfIOaLSQOO5amycDCAM//kTZGjcST11Pw22IBavXWxsROgFUsIdS2cTuAd5pGqNwP+0gsXCqdjDVXfq4OnYUsjhQ+TPLLrN0BQYBOl69ScRvdwk7I3ImYt1XItcn33UK4EZFVMO2CEQOcnL98PF+E9ReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SYfEq2pT; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-c6139292ed7so24921a12.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770277857; x=1770882657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TSEFqGFDtEPF0mGKcpvzCirZypCr4KunIPUFFgq2YU=;
        b=QZ0ozq3j9PmFyA8Zp/H89WvKAyfArOMvhOvzbxFKC3yv0VWMKtk8WX/wutEq18gZuX
         Xrwgxa/qS7KJM+jySjJaDpCUsZTE6z1HHnxY7QYQk/73OLolUxwd/EqcMtv012AU5RGC
         kR3WD4e4kW6RqLs8xe1amZJPZdmj0TDUQEW32AzqoAlIkHdvtccKL8vWx/KYikCRXUPo
         nMlT15gFDDMck3YFQkJvWPXPr06izngIbnFYkc1WN3H0ML0fra0plsHTVs2QAtMbC25x
         4ycMAMzDsH6PF7sP7jCmqiHGqvNf+60sYyJmQIqXw/WJGeX6q+nU9ZB/RApspTJUOTif
         R/3g==
X-Forwarded-Encrypted: i=1; AJvYcCXdn7NlBM2z3MyIIeDSNy9Buo65EwYjdAIsSSVmhB7FTh8UFFMCL1Wq8x/0OmfKohRRt9kOMAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpk3M8IZeiqtvE1GBR7Z1f4HtBRBLcyvXzVW3O7rjMPcbhSpoP
	7BgKruRe33VESWVqXGR76aKQB8/nJwLt9CI8Q2Dz6nSNXDQSzp6xpHQyNG7uT3hCkqfC/JGevio
	+NXq8QjYeUA9+V2CReYFpgq1ouoYty3qzfpKT+BhkhrI1MoPOZ69jdEvDF9ytjNKtZaF5GQFGem
	q7kjACvhY8+pr3uhHA826v1hrZlCP0YN/9Tmw/kDTUyFOdF7KDNiXTCGhXUsP6OfMCAi53LHgUd
	0TXnbFUxtnM7zbyxrwoA8eXV2a2f2A=
X-Gm-Gg: AZuq6aIfAUqat2kS+W6nmCQViCfE9CICBxity4OrGO7r7Gys/pM3WA/tyVUC8kkuPYm
	V32PMC43DttFPH911uOJ9kS4NZk6+kemVd4grd1C36JbPFwnutBTW0clbYhO+TwpbhMESI/v1yQ
	Ojp+dQljh0d02ZBxcxYaa+SdCq0d/M/NVuyi2UoDYz5mK3zEw9/RDzwWawkekgYgX48WVH1RLq4
	bhT6YCoFTnAqZx6JIR+LB8tfvlOw+4167Tx/0f07tIMOhrMInUOnjMpVc+sxTsWx1li9x4ljcej
	kmkZN9YGSvjalrZA+K3f4Bmlcb4Sjxtpg23YUX2ckhjtGwFuWFWejDsgCAIr3U/fBw8CzQbyQLC
	PonojcLMrbkcNUqSZRwEG1dC+9fZZ/2fnijVrkzSprgdeUuGgfWewB2MEyTg8Sd8Cee/uIEQsPW
	sUERNwJYdOsXJz/S7/q46QCMawzaGnUEupm1sKdCSuA0h3iANOtSUb/A+6ogA=
X-Received: by 2002:a05:6a20:2591:b0:342:1aab:4c79 with SMTP id adf61e73a8af0-393791e3d8emr3738573637.3.1770277857271;
        Wed, 04 Feb 2026 23:50:57 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c6c8591743asm289839a12.11.2026.02.04.23.50.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Feb 2026 23:50:57 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b796c874a9so27078eec.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770277855; x=1770882655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6TSEFqGFDtEPF0mGKcpvzCirZypCr4KunIPUFFgq2YU=;
        b=SYfEq2pTMsYznxj/Te7raCN+W7usL29BRXO1urFFPPwvLfYkiaY2W2Ik0l1S60TW3n
         Nm7DBxQd6rhHctK4aHdwJf+KG+aw0ZhX/WnJwhUn/vCkvtEJJ5sTnHvutK87QeIVH3cG
         84n1jOpzu13zQiQqNZb4ZCOaZeGMpuIXoCkxw=
X-Forwarded-Encrypted: i=1; AJvYcCVqkjmvJofzCGpqeFZASdazCNehba99oyerARVO5NYB8e1if6XPqdJ4jygmVS7b2tZ932nrgiM=@vger.kernel.org
X-Received: by 2002:a05:7022:50e:b0:119:e56a:4fff with SMTP id a92af1059eb24-126f60ba802mr1109940c88.4.1770277855236;
        Wed, 04 Feb 2026 23:50:55 -0800 (PST)
X-Received: by 2002:a05:7022:50e:b0:119:e56a:4fff with SMTP id a92af1059eb24-126f60ba802mr1109932c88.4.1770277854649;
        Wed, 04 Feb 2026 23:50:54 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e10935sm3383959c88.6.2026.02.04.23.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:50:53 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
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
Subject: [PATCH v5.10-v5.15 ] ipv6: use RCU in ip6_xmit()
Date: Thu,  5 Feb 2026 07:46:44 +0000
Message-ID: <20260205074644.2091266-1-keerthana.kalyanasundaram@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257025-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_NEQ_ENVFROM(0.00)[keerthana.kalyanasundaram@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B3BE3EF98C
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
 net/ipv6/ip6_output.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 426330b8d..3411da42a 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -255,33 +255,34 @@ bool ip6_autoflowlabel(struct net *net, const struct ipv6_pinfo *np)
 int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	     __u32 mark, struct ipv6_txoptions *opt, int tclass, u32 priority)
 {
-	struct net *net = sock_net(sk);
 	const struct ipv6_pinfo *np = inet6_sk(sk);
 	struct in6_addr *first_hop = &fl6->daddr;
 	struct dst_entry *dst = skb_dst(skb);
-	struct net_device *dev = dst->dev;
 	struct inet6_dev *idev = ip6_dst_idev(dst);
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
 	head_room = sizeof(struct ipv6hdr) + LL_RESERVED_SPACE(dev);
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
@@ -329,17 +330,21 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
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
@@ -348,7 +353,9 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 
 	IP6_INC_STATS(net, idev, IPSTATS_MIB_FRAGFAILS);
 	kfree_skb(skb);
-	return -EMSGSIZE;
+unlock:
+	rcu_read_unlock();
+	return ret;
 }
 EXPORT_SYMBOL(ip6_xmit);
 
-- 
2.40.4


