Return-Path: <netdev+bounces-273720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WATDMKMJzGn+NQYAu9opvQ
	(envelope-from <netdev+bounces-273720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:51:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA4E36F67C
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73AF4300461F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A8D43DA2D;
	Tue, 31 Mar 2026 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUH41bpr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0190C3AA1AF
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979248; cv=none; b=nbVlIPmQoN1XPa2tBKuJlYfDjR/byBU0fTXrpS7avplWy8H76EV3RMx1pbxLF4ysLpVpNOXBCG0O0HO+dMrMxIsktiNjRYTs07hr9u16lb3+BHxdfJm5/0gcPOgPDCmhwzWZGgnJu9ig2HLELbUcoiwcbQSA94QQlFcLwtRXCkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979248; c=relaxed/simple;
	bh=36v49/fbV4VRJB/+NrcVTAmFSFn0FhRq1Tz1wEyUG4k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SEe1EdwajAXe3SmqAitUAmIuKz7TnEKxs6MIe9FTxRpRmbvwL5hlXBn1ZxF8dreUvM2+UboDtqXx/YTGbhLKrdiBVgijQXeLXtgv9ybkGQFCR12+/61am8OvgYPIhmzyoBsqB2dz2cIyryje2HHdokv4nFW9Lz6vpaqfUrMjgNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cUH41bpr; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-5090e08dcfcso52597001cf.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774979246; x=1775584046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pS9Lmi7r6BF7CSKJWWcfP9WovjVQImzGq2W57fNtUXc=;
        b=cUH41bprMh9+j9VXGCgVvVDnsovSvXu57jqcsn77/TAM3GKkoo+t6KPfzIwtpeSNpV
         hwA3eI/HYxRDMTNQWCfH4RCmbrKeboj0Luj+L3Yh1mY7TD0F2k+P5EqQ1MjNnkYdKooR
         2LeCRwjzH3SUBbc6t4JtGmuoJbZjBwrHK2ZA64o/sJponFHnWlJb6D8XavSFREGIRMEo
         onhsbi6oKV0y03dRcOYOoo1ZYiZ8LzqfXYvPAHkugE9o5fl7bCNGF8Zft7mfGPowPqjo
         ozQ5sVOkAUfkSXsGOKP3irUrafCPS+WwuC7Ci0vlST3B/m6lq7Upqt52b8Bd4PpTyhw4
         x9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774979246; x=1775584046;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pS9Lmi7r6BF7CSKJWWcfP9WovjVQImzGq2W57fNtUXc=;
        b=c8OWZpcPnHXqtofK1aNmmY2gTPG/i3rk9AM++IB8eajU6yFi103ualMy0V72j4K0U/
         sdXt501NvRIGAZRT+NU7ACvaAd/uc5OGpPNIVBcgVynt2Bt2pksNzrV+U6r/8AjYv6UR
         C0b2IP3d9wDYQxhZVqtcnO/OJhottYJGC7uEIWbW3PCjJzVGj4Yyd6W9vUBilv/8Pc8b
         ozJo1ojR8azp2zC4IUuW6VUsCr/a+tbZna4IJFPELNnfJ2i3y3QG08GEklhQuYM6A+Ca
         nDMtvWpzQlc7NH93kapuZXRqJjTTEr9haq0jZnwSnKusJmQGCGdYX5Np+p8+Bwt3sWIV
         eKbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2EeOm2ZMtPvm4BacVj97uAmjgFWoarIs9jGG5a4vXw1oIPwkoqzzLFAsP1wbksWu8s/wI6Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyju2bxIXk7EBUlo9bZlZccGV0sM8Mz08+hVMPH+G90lIcE/fnq
	D6blXR0NCDtVqc0AjaWeblGKKZ6NBNdL50gqaWCeIkKjVqvTNF2CICOHV/8rm4Kfx/hdKr9blqp
	Ae5qW0rqn/yIaMw==
X-Received: from qtbhx9.prod.google.com ([2002:a05:622a:6689:b0:503:34fa:ca78])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5715:0:b0:50d:2a76:43c5 with SMTP id d75a77b69052e-50d3bc2d98fmr7231731cf.2.1774979245543;
 Tue, 31 Mar 2026 10:47:25 -0700 (PDT)
Date: Tue, 31 Mar 2026 17:47:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331174722.4128061-1-edumazet@google.com>
Subject: [PATCH v2 net-next] ipv6: move ip6_dst_hoplimit() to net/ipv6/ip6_output.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,suse.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273720-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FA4E36F67C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move ip6_dst_hoplimit() to net/ipv6/ip6_output.c so that compiler
can (auto)inline it from ip6_xmit().

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux.1
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-11 (-11)
Function                                     old     new   delta
ip6_xmit                                    1684    1673     -11
Total: Before=29655407, After=29655396, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Resend after IPv6 is no longer a module.
    Added Fernando and Kuniyuki 'Reviewed-by'

 net/ipv6/ip6_output.c  | 21 +++++++++++++++++++++
 net/ipv6/output_core.c | 23 -----------------------
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 63abc4fddaee8e9cf2ad2ef0873c963eaea63247..7e92909ab5be3f86b10bf9527e97f3bfe794e9e9 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -259,6 +259,27 @@ bool ip6_autoflowlabel(struct net *net, const struct sock *sk)
 	return inet6_test_bit(AUTOFLOWLABEL, sk);
 }
 
+int ip6_dst_hoplimit(struct dst_entry *dst)
+{
+	int hoplimit = dst_metric_raw(dst, RTAX_HOPLIMIT);
+
+	rcu_read_lock();
+	if (hoplimit == 0) {
+		struct net_device *dev = dst_dev_rcu(dst);
+		struct inet6_dev *idev;
+
+		idev = __in6_dev_get(dev);
+		if (idev)
+			hoplimit = READ_ONCE(idev->cnf.hop_limit);
+		else
+			hoplimit = READ_ONCE(dev_net(dev)->ipv6.devconf_all->hop_limit);
+	}
+	rcu_read_unlock();
+
+	return hoplimit;
+}
+EXPORT_SYMBOL(ip6_dst_hoplimit);
+
 /*
  * xmit an sk_buff (used by TCP and SCTP)
  * Note : socket lock is not held for SYNACK packets, but might be modified
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index cba1684a3f30ff98517d873ddb8e97f32adc9791..64b1eeb79b572b8b412c60f832c4a7984ac8276f 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -100,29 +100,6 @@ int ip6_find_1stfragopt(struct sk_buff *skb, u8 **nexthdr)
 }
 EXPORT_SYMBOL(ip6_find_1stfragopt);
 
-#if IS_ENABLED(CONFIG_IPV6)
-int ip6_dst_hoplimit(struct dst_entry *dst)
-{
-	int hoplimit = dst_metric_raw(dst, RTAX_HOPLIMIT);
-
-	rcu_read_lock();
-	if (hoplimit == 0) {
-		struct net_device *dev = dst_dev_rcu(dst);
-		struct inet6_dev *idev;
-
-		idev = __in6_dev_get(dev);
-		if (idev)
-			hoplimit = READ_ONCE(idev->cnf.hop_limit);
-		else
-			hoplimit = READ_ONCE(dev_net(dev)->ipv6.devconf_all->hop_limit);
-	}
-	rcu_read_unlock();
-
-	return hoplimit;
-}
-EXPORT_SYMBOL(ip6_dst_hoplimit);
-#endif
-
 int __ip6_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	ipv6_set_payload_len(ipv6_hdr(skb), skb->len - sizeof(struct ipv6hdr));
-- 
2.53.0.1118.gaef5881109-goog


