Return-Path: <netdev+bounces-298408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7bnlHglJK2rr5gMAu9opvQ
	(envelope-from <netdev+bounces-298408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:47:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A012675D8E
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:47:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RXsge+EM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298408-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298408-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EE8C303CD50
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDBE37DEA5;
	Thu, 11 Jun 2026 23:47:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E421039E6FD
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:46:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781221625; cv=none; b=E5NhnJiQXX5x+1+FmWduBP7n4ZYfSSR4QAPj9/VsKVLKvYZWHznyV4wehsGA/Kn0+zuKDRqYoigbPtUimJHRRA2g1th6Pf3a+4vNFjW43Rkgqv0lBpD5wBDvWbA9UGfMcjd6mHQXYqJ/U3A9WOBFBXPS7uVwC8ka9vv4RtCRyHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781221625; c=relaxed/simple;
	bh=BB3c3/vd49rpkz7DprA4dwKzkMaThLc8gZ9yVjLiOVo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PO5S7Xh25n/6m6/z0EpBczIAnIQxsvSBp++5qJDR6Kdw7an1hX6h9togNF/2PU2OmAK5J51FPJz09YYEmIyZLTGI/Yy2Uhk+4HRlQP5OUu0bNjMdVVU2sw527He+nfR9uHnO0FCgpMeDU7x7Haj65ti9q6WZUZHa8K6jY8wX144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXsge+EM; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c40397e3caso1455715ad.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781221619; x=1781826419; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CxPjH6UcmiDoX9BBBlPsMDv0JQBEqCABrE66FK+77Ps=;
        b=RXsge+EMiYjRT6pJQWv6bsWgCTDLiUMg52RnI/EtW2DzvajS6vo3U+jtaOXL706nt0
         Ee/PVvvRGmH2mn5+54IaOmtI/v3FcH2Orm2bsf5LQh9wSzFFfjjvOAZiIkdA4gdl0kuC
         /uiczAtT7dxvUX4vZmZG1nbOEVbePovj7mGAPZMQB6bsBIe7pvc+X/1G4cqazHpPnxQX
         5gL6UQvnTFPDfeSuIJh16dPsI+u+gmaqFP+it5OsIEQTrFLVFEbxOcYtoQgcbw3iFA88
         mg12i2dVB9sO9fsGE3Wl+xMPwP8rR3CyMAUK2KkQE/GdGYEZl2SIdXlY6pfy/dmtdGYW
         ht9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781221619; x=1781826419;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CxPjH6UcmiDoX9BBBlPsMDv0JQBEqCABrE66FK+77Ps=;
        b=p8RxE1oG+/98DPH71VcVIw1yjy4rymK4zHoaFfDT6ctxXfcvXBEgbtTgdIxuLGTbGC
         SEKSe+VZmhrRl/ucfO0tzH3a0SVqjdx7FshMOc4w1Nrvy33MfEX5CyXJ3XCLkV+3kcXf
         DOql41fEsxJUrQai7UqX4e+KMgK6aOev83fDzGyBMxL7DXRswjYhtDlsVltdEJqx43kf
         99hF1sKEqH4orZZu8lD6+DZ6xQAsomIrl5sEGwHskmvIAicTDrAnWK07DM09mXy1+PaO
         jTIXMuhMXLv8zg/opp8FPByepWnBngxMHd4OWjxdIoet5DPzq008lzYZJFcTq156YU9h
         bTLw==
X-Gm-Message-State: AOJu0Yy375ckVTZVL96TnEg+T3nXfI4AQZDRrn57MoJVKh9zC0r8Ym+/
	FxupMX44gLFZJPOkijzvjBWL+CmRP52u9L2J6FxueLCAziCZeCQcXtD8
X-Gm-Gg: Acq92OE8ub+FYVy4e9/L2qhiYypQ0ztIcRMF5s11f/2sCvCzvEwoNI2wSNosF2mgCt3
	OEOR0iofqzvsG+O5aMmLrq9WlDnzlI6wega7sU7xM0wzUEhKabWUwARiE1qNHL2iP10EF9kOzAc
	V/kdHv3sX9uuu3QgmBPsYm8imaUHMKkNfO1GicWkqpq5M2ZG0JnVgT+2StbS2eU9G/wuSpPqMXU
	X4wGf6Ybm83WOC5UccamMabErMzK/qOzj23Z/TOUIVZEzgq0tRj9ehqjwfELDXLpZnD75/xHIzr
	AZ5abSUYht1DEsc7siPDVtO8+evmm/gEbL4WzqGi4SOqQEWmdI3yJe+7xZyBWKncGx8TYuZV5ne
	p7lHZdgqU2mzDs17PPwgbM9VXFFqV5+3UllvN+mdiGM+hsfiYE9/lDJPgx0o1sTkk+AUVtGaN5w
	jxOxJiQTVU4r3uwLeoE0B7002UL8BLtjQeAluMAIHD+YI=
X-Received: by 2002:a17:903:46c6:b0:2b0:6a22:5165 with SMTP id d9443c01a7336-2c41050a155mr6446235ad.7.1781221619139;
        Thu, 11 Jun 2026 16:46:59 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432d8a039sm464925ad.62.2026.06.11.16.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 16:46:58 -0700 (PDT)
Date: Fri, 12 Jun 2026 08:46:54 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, andrew+netdev@lunn.ch,
	kuniyu@google.com, jlayton@kernel.org
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net v3] net: protect egress device access in the output path
 with rcu_read_lock
Message-ID: <aitI7sLX8SIC5RqQ@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298408-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:andrew+netdev@lunn.ch,m:kuniyu@google.com,m:jlayton@kernel.org,m:netdev@vger.kernel.org,m:imv4bel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,v4bel:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A012675D8E

The locally generated output path reads the egress network device from
the route attached to the skb (skb_dst(skb)->dev, skb_dst_dev() or
rt->dst.dev) and uses it as the 'out' device argument of an
NF_HOOK()/nf_hook() call, or for direct field reads, without holding
rcu_read_lock().

dst->dev is protected by RCU. When a device is unregistered its value is
replaced with blackhole_netdev and the previous device is freed after an
RCU grace period. A section that reads dst->dev and uses that pointer
must therefore hold rcu_read_lock(). Otherwise a LOCAL_OUT / POST_ROUTING
hook consumer (nft meta oif, selinux_ip_postroute_compat, etc.) or an
early field read can reference a device that is no longer valid when the
egress device is unregistered concurrently with transmission.

Rather than taking the lock in each dst->output leaf, take it once at the
common ip_local_out() and ip6_local_out() level. This covers
__ip_local_out() / __ip6_local_out() (the LOCAL_OUT hook) and
dst_output(), and therefore ip_output(), ip_mc_output(), ip_mr_output(),
xfrm4_output() and vrf_output(), as well as the IPv6 leaves ip6_output(),
ip6_mr_output(), xfrm6_output() and vrf_output6(), in one place.

raw_send_hdrinc() and rawv6_send_hdrinc() do not go through
ip_local_out() / ip6_local_out(); they run their own NF_HOOK() and also
read the device (mtu, LL_RESERVED_SPACE(), needed_tailroom) before that
hook, so they take their own rcu_read_lock(). The device fields are read
under a short rcu_read_lock() at function entry that is dropped before
the blocking sock_alloc_send_skb(); the NF_HOOK() itself runs under
rcu_read_lock() (added in raw_send_hdrinc(), already present in
rawv6_send_hdrinc()).

xfrm_output_resume() is left unchanged. It reads the device locklessly
and is only reached either under the rcu_read_lock() held by its
dst_output() caller (now including ip_local_out() / ip6_local_out() for
locally generated traffic) or with softirqs disabled: the async crypto
completion runs in BH-off context (cryptd and padata invoke it under
local_bh_disable(); hardware crypto drivers complete it from softirq),
and the IPTFS output runs from a HRTIMER_MODE_REL_SOFT timer. For the
same reason __ip_local_out() and __ip6_local_out() keep the lockless
skb_dst_dev() accessor: they are also reached from xfrm_output_resume()
via ->local_out() in BH-off context, where the rcu_dereference() based
accessor would trip CONFIG_PROVE_RCU.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v3:
- Take the lock once at ip_local_out() / ip6_local_out() instead of in
  each output leaf, and cover the IPv6 path as well (David Ahern, Ido
  Schimmel).
- Drop the xfrm_output_resume() change; its resumption paths already run
  with BH off (Herbert Xu). Its synchronous entry is reached under the
  rcu held by its dst_output() caller.
- Also protect the early device reads (mtu, headroom) in
  raw_send_hdrinc() / rawv6_send_hdrinc(), split so the lock is not held
  across the blocking allocation.
- The now redundant rcu_read_lock() nested in ip_output() / ip6_output()
  will be removed in a follow-up.
- v2: https://lore.kernel.org/all/ahveCu-zzFlpeVut@v4bel/

Changes in v2:
- Changed to a net-wide patch that also fixes the issue in
  raw_send_hdrinc(), xfrm_output_resume() and vrf_output().
- v1: https://lore.kernel.org/all/ahqIg6vURwYI0LJ5@v4bel/
---
 net/ipv4/ip_output.c   |  2 ++
 net/ipv4/raw.c         | 19 ++++++++++++++-----
 net/ipv6/output_core.c |  2 ++
 net/ipv6/raw.c         | 16 ++++++++++++----
 4 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 5bcd73cbdb41c..26b51ef0763fa 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -126,9 +126,11 @@ int ip_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	int err;
 
+	rcu_read_lock();
 	err = __ip_local_out(net, sk, skb);
 	if (likely(err == 1))
 		err = dst_output(net, sk, skb);
+	rcu_read_unlock();
 
 	return err;
 }
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 68e88cb3e55cb..1b7b291410cf8 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -336,11 +336,20 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	unsigned int iphlen;
 	int err;
 	struct rtable *rt = *rtp;
+	struct net_device *dev;
 	int hlen, tlen;
+	unsigned int mtu;
 
-	if (length > rt->dst.dev->mtu) {
+	rcu_read_lock();
+	dev = dst_dev_rcu(&rt->dst);
+	mtu = dev->mtu;
+	hlen = LL_RESERVED_SPACE(dev);
+	tlen = dev->needed_tailroom;
+	rcu_read_unlock();
+
+	if (length > mtu) {
 		ip_local_error(sk, EMSGSIZE, fl4->daddr, inet->inet_dport,
-			       rt->dst.dev->mtu);
+			       mtu);
 		return -EMSGSIZE;
 	}
 	if (length < sizeof(struct iphdr))
@@ -349,8 +358,6 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	if (flags&MSG_PROBE)
 		goto out;
 
-	hlen = LL_RESERVED_SPACE(rt->dst.dev);
-	tlen = rt->dst.dev->needed_tailroom;
 	skb = sock_alloc_send_skb(sk,
 				  length + hlen + tlen + 15,
 				  flags & MSG_DONTWAIT, &err);
@@ -410,9 +417,11 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 				skb_transport_header(skb))->type);
 	}
 
+	rcu_read_lock();
 	err = NF_HOOK(NFPROTO_IPV4, NF_INET_LOCAL_OUT,
-		      net, sk, skb, NULL, rt->dst.dev,
+		      net, sk, skb, NULL, skb_dst_dev_rcu(skb),
 		      dst_output);
+	rcu_read_unlock();
 	if (err > 0)
 		err = net_xmit_errno(err);
 	if (err)
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index 64b1eeb79b572..ac058af198986 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -124,9 +124,11 @@ int ip6_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	int err;
 
+	rcu_read_lock();
 	err = __ip6_local_out(net, sk, skb);
 	if (likely(err == 1))
 		err = dst_output(net, sk, skb);
+	rcu_read_unlock();
 
 	return err;
 }
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 3cc58698cbbd3..73ac6ef2d3168 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -601,11 +601,19 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	struct sk_buff *skb;
 	int err;
 	struct rt6_info *rt = dst_rt6_info(*dstp);
-	int hlen = LL_RESERVED_SPACE(rt->dst.dev);
-	int tlen = rt->dst.dev->needed_tailroom;
+	struct net_device *dev;
+	int hlen, tlen;
+	unsigned int mtu;
 
-	if (length > rt->dst.dev->mtu) {
-		ipv6_local_error(sk, EMSGSIZE, fl6, rt->dst.dev->mtu);
+	rcu_read_lock();
+	dev = dst_dev_rcu(&rt->dst);
+	mtu = dev->mtu;
+	hlen = LL_RESERVED_SPACE(dev);
+	tlen = dev->needed_tailroom;
+	rcu_read_unlock();
+
+	if (length > mtu) {
+		ipv6_local_error(sk, EMSGSIZE, fl6, mtu);
 		return -EMSGSIZE;
 	}
 	if (length < sizeof(struct ipv6hdr))
-- 
2.43.0


