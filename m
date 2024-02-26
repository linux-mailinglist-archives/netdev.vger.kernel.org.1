Return-Path: <netdev+bounces-75012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B50A867B35
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316F229030F
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CF612CDAE;
	Mon, 26 Feb 2024 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kYZJSMmE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2572B12C7FC
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963774; cv=none; b=PYzZykiw05b7+Ly5hdrvRBr+VxbuCEAxrrWnKbvDbq2ho0f7tuigEG4NOJaH29NlkDQCjpftq8GpD46wf8MH8DbCjTA8t1osKIAkuOQwzACgTldv35wtfErjo91d2uj7oYRtK3ka0umc58qe2OGF1EGhtUY9w3aO2QOVIPMmUFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963774; c=relaxed/simple;
	bh=ushyNRLQqe6VeQVh+RfKFVyn75cKET1I7VzQfPBLQSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmB++AqLVQQaCmfzVXqeVdenO+oktzKFwYuKuECKK0RB8u8svDnO90fNslUDxBvgSnVHqZV+yO2c3FdpNXj+QPvah7NH5zKqlM7N13Cd6MM1EzPzdFzKnuBwMIsafpNAuI5ikd27WbZNvaNNnyLmSQWuDi0gozjierRuR5GDgn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=kYZJSMmE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso4290240a12.2
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 08:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708963770; x=1709568570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vFBl7Jn71l55zZP9xjczXemHwAm8kjJixBux3kFWRD8=;
        b=kYZJSMmE/N/C3s9THKtjCnUsaBbrmzY2l2Xw9JZ85GRDX7ver3lx+CRlSq2Vb4FIBJ
         66KFSavNi2ZQF3E6cWh/Nynw5PmaypicpEVfrSRQerrLM7yViEd1CxGw0M1zQlYdZt7i
         L+5FcX1ewnukl/aDBQzO5g1+FkbIf8DFY4aX4MGjYv3UDbRxSO1wWumT47iW+rIKzlE/
         2SeU1ApO1Rda2OwQpDUb2DhD4DVDnNjih00zj6fffuSqB6E4FqvklM4gmyjc/dN9J/R4
         xQxh5oJtUNa3tD/dLrPw2olrv3S1bV1aZ9zNzKcJW8Nu+9aN8c9ueQG9nyYu68di2xPh
         Lmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708963770; x=1709568570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFBl7Jn71l55zZP9xjczXemHwAm8kjJixBux3kFWRD8=;
        b=lsW9rpci8q7fRNvy+91VGTi2QJegDNpO4lm5MP/piXo0DrUgjKKtlrc4Pe46k6iVlK
         uuc+YP+ni4VQqVb/QhTJqPbcv+FJIE01jjFqLru++9n+jqU8PDMO0lLFf5O9A+5UwbXM
         7aNf6utjqi0Y8bIzowvlwzMVYtAI4ELkC/nynbgeCCNd2MEBHuGm/qPTFozi3PdcyYZs
         t0LvQli/dtMxFqX26vFDVvKCQP4GdFnLt5hx+NHxBvzIqYR+klTaYqPJghe0Qkhxdp4/
         7A6Jfg0YjfyW8WF1t2JuNmleWCss4gGBWoElFcYQcypPk2adkDW1nPPNt25nxsY8+mhE
         bW4g==
X-Forwarded-Encrypted: i=1; AJvYcCW3R1n5MIN9B6gIloj0ptwwucjnGnm43k6n2UolJsVjqJEj1AeyxojZE1i47ivh8Y2fxMck888GXWuQYvS7R6gTNT494yNZ
X-Gm-Message-State: AOJu0Ywle6/qpBUercBxsmsi4HWm7CXQ9YCCq4K0/VrMJnnVHSlX4MSE
	cxu3p6tEGLrqnfrlnprzX8EB7NJYGGzuWyvwXZGQNIIJqf1lJYQh7zfd8g4E+jw=
X-Google-Smtp-Source: AGHT+IGJ0JJ50zRsg+10V9LkLY6Ts3MHtVCEwvIWzeQS5XoBzJFt3oEv/1RjbKlR+TmC5IIsu8vLzA==
X-Received: by 2002:aa7:d5d5:0:b0:565:3aa7:565f with SMTP id d21-20020aa7d5d5000000b005653aa7565fmr4848578eds.8.1708963770439;
        Mon, 26 Feb 2024 08:09:30 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ek16-20020a056402371000b00564d6840976sm2459379edb.80.2024.02.26.08.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 08:09:29 -0800 (PST)
Date: Mon, 26 Feb 2024 17:09:26 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 02/13] ipv6: annotate data-races around
 cnf.disable_ipv6
Message-ID: <Zdy3tnU-QZUda0HI@nanopsycho>
References: <20240226155055.1141336-1-edumazet@google.com>
 <20240226155055.1141336-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226155055.1141336-3-edumazet@google.com>

Mon, Feb 26, 2024 at 04:50:44PM CET, edumazet@google.com wrote:
>disable_ipv6 is read locklessly, add appropriate READ_ONCE()
>and WRITE_ONCE() annotations.
>
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>---
> net/ipv6/addrconf.c   | 12 ++++++------
> net/ipv6/ip6_input.c  |  4 ++--
> net/ipv6/ip6_output.c |  2 +-
> 3 files changed, 9 insertions(+), 9 deletions(-)
>
>diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
>index a280614b37652deee0d1f3c70ba1b41b01cc7d91..0d7746b113cc65303b5c2ec223b3331c3598ded6 100644
>--- a/net/ipv6/addrconf.c
>+++ b/net/ipv6/addrconf.c
>@@ -4214,7 +4214,7 @@ static void addrconf_dad_work(struct work_struct *w)
> 			if (!ipv6_generate_eui64(addr.s6_addr + 8, idev->dev) &&
> 			    ipv6_addr_equal(&ifp->addr, &addr)) {
> 				/* DAD failed for link-local based on MAC */
>-				idev->cnf.disable_ipv6 = 1;
>+				WRITE_ONCE(idev->cnf.disable_ipv6, 1);
> 
> 				pr_info("%s: IPv6 being disabled!\n",
> 					ifp->idev->dev->name);
>@@ -6388,7 +6388,8 @@ static void addrconf_disable_change(struct net *net, __s32 newf)
> 		idev = __in6_dev_get(dev);
> 		if (idev) {
> 			int changed = (!idev->cnf.disable_ipv6) ^ (!newf);
>-			idev->cnf.disable_ipv6 = newf;
>+
>+			WRITE_ONCE(idev->cnf.disable_ipv6, newf);
> 			if (changed)
> 				dev_disable_change(idev);
> 		}
>@@ -6397,15 +6398,14 @@ static void addrconf_disable_change(struct net *net, __s32 newf)
> 
> static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
> {
>-	struct net *net;
>+	struct net *net = (struct net *)table->extra2;

How is this related to the rest of the patch and why is it okay to
access table->extra2 without holding rtnl mutex?


> 	int old;
> 
> 	if (!rtnl_trylock())
> 		return restart_syscall();
> 
>-	net = (struct net *)table->extra2;
> 	old = *p;
>-	*p = newf;
>+	WRITE_ONCE(*p, newf);
> 
> 	if (p == &net->ipv6.devconf_dflt->disable_ipv6) {
> 		rtnl_unlock();
>@@ -6413,7 +6413,7 @@ static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
> 	}
> 
> 	if (p == &net->ipv6.devconf_all->disable_ipv6) {
>-		net->ipv6.devconf_dflt->disable_ipv6 = newf;
>+		WRITE_ONCE(net->ipv6.devconf_dflt->disable_ipv6, newf);
> 		addrconf_disable_change(net, newf);
> 	} else if ((!newf) ^ (!old))
> 		dev_disable_change((struct inet6_dev *)table->extra1);
>diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
>index b8378814532cead0275e8b7a656f78450993f619..1ba97933c74fbd12e21f273f0aeda2313bd608b7 100644
>--- a/net/ipv6/ip6_input.c
>+++ b/net/ipv6/ip6_input.c
>@@ -168,9 +168,9 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
> 
> 	SKB_DR_SET(reason, NOT_SPECIFIED);
> 	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL ||
>-	    !idev || unlikely(idev->cnf.disable_ipv6)) {
>+	    !idev || unlikely(READ_ONCE(idev->cnf.disable_ipv6))) {
> 		__IP6_INC_STATS(net, idev, IPSTATS_MIB_INDISCARDS);
>-		if (idev && unlikely(idev->cnf.disable_ipv6))
>+		if (idev && unlikely(READ_ONCE(idev->cnf.disable_ipv6)))
> 			SKB_DR_SET(reason, IPV6DISABLED);
> 		goto drop;
> 	}
>diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
>index 31b86fe661aa6cd94fb5d8848900406c2db110e3..0559bd0005858631f88c706f98c625ad0bfff278 100644
>--- a/net/ipv6/ip6_output.c
>+++ b/net/ipv6/ip6_output.c
>@@ -234,7 +234,7 @@ int ip6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
> 	skb->protocol = htons(ETH_P_IPV6);
> 	skb->dev = dev;
> 
>-	if (unlikely(idev->cnf.disable_ipv6)) {
>+	if (unlikely(READ_ONCE(idev->cnf.disable_ipv6))) {
> 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
> 		kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED);
> 		return 0;
>-- 
>2.44.0.rc1.240.g4c46232300-goog
>
>

