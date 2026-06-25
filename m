Return-Path: <netdev+bounces-302013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QI5JOO9OPWpP1AgAu9opvQ
	(envelope-from <netdev+bounces-302013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:53:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AEF6C72FC
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:53:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Vfec3vHM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302013-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302013-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BF5D304F418
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA792E6116;
	Thu, 25 Jun 2026 15:53:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BA123BD1B
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 15:53:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402796; cv=none; b=Hc3L4cZ5bzwpvLiTn5o1pRKJBJlf7XJraWvGrkG5vaI5nMyzxys0zhfOdfrx8XLRxfVUg7osJF1FFEAr7eA5JyIavlZKqdciG82sG8AZu6B2rFdCH/zBYwfhcH4DgT1Q75qwFrJiXOOdynWyMXL4+ozuFSniGu1TgRlOGkT/PmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402796; c=relaxed/simple;
	bh=Og4C+MaKmLZf2JGAM2OHBn7Ig4cAXYb1eQ5nglnohRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yz4q/sve9FYdZtxMF+XS+RDrp0qfwSKepLg/rp5007oBeB6Ep10oqMjT2sUifgvfvKrfoYW/HA0lS4cMYfwHjaFRex1TYhFOUshCYS0Rmm15E4vmAzef/lsH003ZTUqr2Trf7CVb0WN9qfFb5XQy6Av8ef+1sukRrpKJTSwcoC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vfec3vHM; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84540760dc9so3281073b3a.0
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 08:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782402794; x=1783007594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rqq6IGdnrj8L6K/Vi13GJ/747gQZalzJyYJwzbs/ueg=;
        b=Vfec3vHMDJyrBz7aiZGFzK20XD8SlSlqdv2tAqRia9pE0THxPko95iOaIFEse6hhDn
         UKZR0EbpbxerMF6PW98ApbhAUzeOk9Ru8pn6k+Ni3GRt7Mal8M913t3ZVt/v3XBalmA3
         +aRTCCGgK2uao866zmS/Zx0xAR0VRME2cX8nADxoz6/Z6C00TQvyM5j4CBUCMO8MmowO
         pJAoT3a+MFDFFDHDCxOswkuv7WHNpgr3KmfM3yn/qo0aBfUKC9JxG5KMtnB92VATrPrM
         2prc5zHz0I/NHHd95ukr2WZw7cs7K5xXFp7upomLKMvQnHSLwLgSVYV1kDa9DyMGf0T3
         j5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782402794; x=1783007594;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqq6IGdnrj8L6K/Vi13GJ/747gQZalzJyYJwzbs/ueg=;
        b=Fnbqh5vQPueaOcHqCWMUZ0U4u6/X/ACPHhhNWuI1gDohJOIm8HBb3Ou2sIeS+atO2K
         VeH3LUusK1A0/Kw9jeVhw56r1pUt36EtJ0R0gISkACpQyBooqSK8pGL7zjM9tnEsabiM
         AAg8UMJEev2chQfu2/Iwjj3QtH/kegTusrlGAQ/Y9cTyvpYFFJ6OXGDIYO/gaFyzGZlQ
         W4RO6ctiPq+Ylje9lS8X3Zq6a0W4t9Hou/WAEHxNvdCZK1NtAKOEEf1iT23fWnlle15p
         eQE85fXjLsXrLxzTOmwxbR/J2wHELzU+vUpEcNkgJecmQe6OUAF3XsvlkiLF6qUdvp7n
         I59A==
X-Forwarded-Encrypted: i=1; AFNElJ/6Ol+Qq8vCBdfJHdwcXAx+CVo+/gTOM7bhr0HL5qxjeMid6IG2N0K6ubB71F8Ei/8D4PKe3cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgOsevPXUChPKgbuVn0OHNOUUbDm3+K3XEQz7Hb1JP55HEhpaU
	jPAOxTutb7YpFNvxaaAjmt+8zQJe+EguNeXuxbVhVhYyPAkwemDsRTFafPZ6/dZQ+TpunwIpUHz
	b6w74cQ==
X-Received: from pgc15.prod.google.com ([2002:a05:6a02:2f8f:b0:c8b:d999:75ee])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9183:b0:3b4:b276:a789
 with SMTP id adf61e73a8af0-3bd4af04b93mr3574816637.36.1782402793879; Thu, 25
 Jun 2026 08:53:13 -0700 (PDT)
Date: Thu, 25 Jun 2026 15:51:54 +0000
In-Reply-To: <036a0c95-f5d4-46ab-88e7-1eab567d7a84@uclouvain.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <036a0c95-f5d4-46ab-88e7-1eab567d7a84@uclouvain.be>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625155313.847098-1-kuniyu@google.com>
Subject: Re: [Regression] Broken MPLS routes with multiple nexthops
From: Kuniyuki Iwashima <kuniyu@google.com>
To: anthony.doeraene@uclouvain.be
Cc: davem@davemloft.net, kuniyu@google.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.doeraene@uclouvain.be,m:davem@davemloft.net,m:kuniyu@google.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-302013-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55AEF6C72FC

From: Anthony Doeraene <anthony.doeraene@uclouvain.be>
Date: Thu, 25 Jun 2026 17:07:41 +0200
> Hello all,
> 
> According to my experiments, it seems that ECMP with MPLS (i.e. an MPLS 
> route with multiple
> nexthops) is broken on the master branch of the kernel.
> 
> Indeed, whenever adding an MPLS route with multiple nexthops, ip route 
> show the route as
> a dead route/link down, even if nexthops are reachable.
> 
> Example to reproduce the error (tested with virtme-ng and the master 
> branch of the kernel):
> ```
> modprobe mpls_iptunnel mpls_router
> sysctl net.mpls.platform_labels=100000
> ip link set dummy0 up
> ip addr add fc00:1::1/112 dev dummy0
> ip addr add fc00:2::1/112 dev dummy0
> ip -M route add 16000 \
>      nexthop via inet6 fc00:1::2 as 16001 \
>      nexthop via inet6 fc00:2::2 as 16002
> 
> # Check the route
> ip -M route
> # Output:
> #     16000 dead linkdown
> #
> # Route is not present, even if accepted
> ```
> 
>  From a git blame, it seems that commit 
> f0914b8436c589b7ab32c614d8d7868eb4ebd5bf
> broke the core logic for building nexthops.

Thanks for the report !

It was to balance refcount with netdev_put() in mpls_rt_alloc().
I'll post the patch below.

(Updating rt->rt_nhn is not strictlly needed for netdev_put()
 because it has NULL check and rt is allocated with kzalloc(),
 but it's a bit error prone, so I'll keep it)

---8<---
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index ca504d9626cf..4a81514e919a 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -922,8 +922,7 @@ static int mpls_nh_build_multi(struct mpls_route_config *cfg,
 	struct nlattr *nla_via, *nla_newdst;
 	int remaining = cfg->rc_mp_len;
 	int err = 0;
-
-	rt->rt_nhn = 0;
+	u8 nhs = 0;
 
 	change_nexthops(rt) {
 		int attrlen;
@@ -959,12 +958,15 @@ static int mpls_nh_build_multi(struct mpls_route_config *cfg,
 			rt->rt_nhn_alive--;
 
 		rtnh = rtnh_next(rtnh, &remaining);
-		rt->rt_nhn++;
+		nhs++;
 	} endfor_nexthops(rt);
 
+	rt->rt_nhn = nhs;
+
 	return 0;
 
 errout:
+	rt->rt_nhn = nhs;
 	return err;
 }
 
---8<---


> 
> This commit modified function `mpls_nx_build_multi` by setting 
> `rt->rt_nhn` to 0 at the
> start of the function. However, the loop `change_nexthops` just below 
> depends on
> `rt->rt_nhn` to know the actual number of nexthops that it should build. 
> As `rt->rt_nhn`
> is set to 0 just before, **no nexthop is ever built**, leading to a dead 
> route. Even if we
> remove this modification, this commit incorrectly increments 
> `rt->rt_nhn` at the end of
> the loop (`rt->rt_nhn++`),  such that the loop always end with an error 
> as it tries to
> constructs more nexthops that actually provided.
> 
> Commenting these two lines fix the issue, and allows to create once 
> again MPLS routes
> with multiple nexthops:
> 
> ```
> modprobe mpls_iptunnel mpls_router
> sysctl net.mpls.platform_labels=100000
> ip link set dummy0 up
> ip addr add fc00:1::1/112 dev dummy0
> ip addr add fc00:2::1/112 dev dummy0
> ip -M route add 16000 \
>      nexthop via inet6 fc00:1::2 as 16001 \
>      nexthop via inet6 fc00:2::2 as 16002
> 
> # Check the route
> ip -M route
> # Output:
> #     16000
> #            nexthop as to 16001 via inet6 fc00:1::2 dev dummy0
> #            nexthop as to 16002 via inet6 fc00:2::2 dev dummy0
> #
> # Route is accepted and present !
> ```
> 
> Overall, I think it would be interesting to discuss what this patch was 
> trying to achieve,
> and how we can conciliate both use-cases.
> 
> Best regards and looking forward to hearing from you,
> Doeraene Anthony

