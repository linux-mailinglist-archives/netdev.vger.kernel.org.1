Return-Path: <netdev+bounces-255234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM5CEjIEfWmRPwIAu9opvQ
	(envelope-from <netdev+bounces-255234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:19:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D22D5BE0F9
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 179F53008D53
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F753876CC;
	Fri, 30 Jan 2026 19:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ans4m2S0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2B63876B0
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769800750; cv=none; b=L0nfT1s+AZFVz0uMszJrhYZ+HoFZtlda/KVgIfD3oNkKohAxpEIJNgx2cpbj0L1HFd0r1ura+jEItNwJvL++gPNVvrgKwCg4q8E9PUB2NsEtbomefRHRJi82GQuEd/LPIn4rkGonGX34U4wGy+/q5qsg3ts0mUvu5urc2CZEDQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769800750; c=relaxed/simple;
	bh=o1hke0QIyu4gHl1GaICw9kCzPdlm+XTFOvyLdnvxTd8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ni9SlUY0dJNWL/8HsJ0x3VAu/LwEkysYxg0ziyMDR76ejdPGTclMIMS9Jkkdmd9rKXTHZcHZYCJcbnL4EyzLtKyL2dGXYoZPRnkJfTzwIA3AGYaxxRDlN4vVaurZNLVI1sIiDNXi7Z3sdvidHPjyaznWBwJFrSObhi6ccNBwWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ans4m2S0; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-645535ac027so3621589d50.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 11:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769800748; x=1770405548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nBwSycvAATKs6athiLo7mH7KoA0xUNuGgi4ee8XCp9Y=;
        b=ans4m2S0J3nxN2sr//h24pFVO+kY3tkrZAn2kRgZ3vz10p2U5nQSYOVcrjsRsg/QDJ
         +Rww+iaU1ERjw2jU9DW3pJ4ORvh6U0/F1dakfci5wEqhr2OFtaQkW+yEr5AMp6K9uSTH
         cZFsJsv8LaoglepRnPDsmnJ96eaxpKyHoKEJ/ef45tLHApO+z4XwxbJWO9oOSF7K0g+S
         et/2/b7W90cj4nboElHikJ6SaVj1u+tPwXCKoV+DagTz9uCfuVzdH1y7LwaitOmL5LQO
         tRzCaLa1ML9XwAIoJ6HIsXHKdXSn3y2uZPocbWBwQJqhnEYW1gkwdH85pE3iRbYyg4vz
         43lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769800748; x=1770405548;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBwSycvAATKs6athiLo7mH7KoA0xUNuGgi4ee8XCp9Y=;
        b=QwtjTyRSlqzTOPSzmvIZO2w9fBbldjXUMlFuiCZoEYDD5TTLoSZvyZuGb8gcZNCtE5
         W4YIRTLYilBZIAnt6NuEeaSkp246ajtgwYhO6zXrVYJSVFaUFuPgioKP3SKxpTljzkgB
         wKaiwO7UAQMR2KSM7wadOWzVaa46K1FMMI/midZDOKyBMThl4av5fGfZPDcP9kgLo1Ad
         hJOvKOnvstXcvsg9Kd6nbz/KU0uNYYtXr1/XTWDm+5Rg3jpMiPrge85Ow+CWU51Xf8Pr
         Q4RW73LZTOWMYN2cbf92eC4xroMZr1v/VNtmDxF5mgOpsgywgRfeVCyGEL1TEzs6tuIG
         6N+A==
X-Forwarded-Encrypted: i=1; AJvYcCWxN0z2o3S/qk28Hpk5iTlNMxhw9bv9YrC/IBAlGmJ1z5FCn6CNCOe3rfGl+iMAMS8w+MsF9fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGkm2embQSOf0crkjyeB1YONEEdz4oPtZOqKZ13tE/tJolU728
	fYZokop9q8UkfEVXCVPTnCOa0SA/4QkMVcZWq5ekBgUr7qwEFkbZ4Ll6GhlLi7ZnpMEVywul3bA
	QbRGw42rmxurgNA==
X-Received: from yxrr22.prod.google.com ([2002:a05:690e:2556:b0:649:9616:aafe])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:144d:b0:640:dd02:a777 with SMTP id 956f58d0204a3-649a84e52f4mr3089356d50.69.1769800747997;
 Fri, 30 Jan 2026 11:19:07 -0800 (PST)
Date: Fri, 30 Jan 2026 19:19:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260130191906.3781856-1-edumazet@google.com>
Subject: [PATCH net-next] net: l3mdev: use skb_dst_dev_rcu() in l3mdev_l3_out()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255234-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D22D5BE0F9
X-Rspamd-Action: no action

Extend the RCU section a bit so that we can use the safer
skb_dst_dev_rcu() helper.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/l3mdev.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/net/l3mdev.h b/include/net/l3mdev.h
index 1eb8dad18f7e35baf26db23b44e182540395bba0..710e98665eb36d6154b914bee27a767ecf4f6fac 100644
--- a/include/net/l3mdev.h
+++ b/include/net/l3mdev.h
@@ -207,18 +207,19 @@ struct sk_buff *l3mdev_ip6_rcv(struct sk_buff *skb)
 static inline
 struct sk_buff *l3mdev_l3_out(struct sock *sk, struct sk_buff *skb, u16 proto)
 {
-	struct net_device *dev = skb_dst(skb)->dev;
+	struct net_device *dev;
 
+	rcu_read_lock();
+	dev = skb_dst_dev_rcu(skb);
 	if (netif_is_l3_slave(dev)) {
 		struct net_device *master;
 
-		rcu_read_lock();
 		master = netdev_master_upper_dev_get_rcu(dev);
 		if (master && master->l3mdev_ops->l3mdev_l3_out)
 			skb = master->l3mdev_ops->l3mdev_l3_out(master, sk,
 								skb, proto);
-		rcu_read_unlock();
 	}
+	rcu_read_unlock();
 
 	return skb;
 }
-- 
2.53.0.rc1.225.gd81095ad13-goog


