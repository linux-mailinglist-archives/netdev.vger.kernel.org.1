Return-Path: <netdev+bounces-120919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB7195B316
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF072B229FA
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 10:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D45181B82;
	Thu, 22 Aug 2024 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lucMqYMv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0151E17DE16
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724323213; cv=none; b=Du4fjjS5aSHbMWJbNlXnqAvBdbZPTmqT4jCti7PwwRg8LOjacfJAbfew3J7RvX4Aanp+1yrKWH+MfQU6BUg8AjM7yGMQj+Sieud+hy3VNZtnoRBNjOzzQH4hiqlKb6W+gotRRac89+yKUl+UzDdJXRaZNZ46IBzjRDIkiVENbfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724323213; c=relaxed/simple;
	bh=fq6WxlddeTPwRmrjo9kprPP5PAIJy0zQ4SnYvgRtKwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hz9qRSlb3vqnhI08LptodoAcDP0g+98nqnmzFuWRa+WI6YWVPj7wf0zGAi7dGoTjjEr2IBGiR/mkVa//FlTYTADftptNOM5kSsOD9eqPk8b8ZxdyhjKNc8gudd4ysCrCNRFt15Ce9r72HcVmQxLpqBmpiQikqdftCSXewXvLI/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lucMqYMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E180C32782;
	Thu, 22 Aug 2024 10:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724323212;
	bh=fq6WxlddeTPwRmrjo9kprPP5PAIJy0zQ4SnYvgRtKwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lucMqYMvFlq6JNTdcdUQucSJnyOba56S2T0vVPi5OgwlXx2m2HygCMCj0SvVqyPcA
	 QcZXEN2d9/14ueoh/XJwqdxO5JMS1qFbqIvxJVwyfq1810egn9y074dyc9BzCON9fk
	 mAgSclfFeKy3dsZK8LPUJF467MRDE9CAQ0gjGY91nhzoqsIapwGWEU2fHNUrv8n2Fx
	 yc99oAwM9SsTAbHyXlqn2xREG8+2F9AMTN/97EbjmMvkLBv8vbfUxSq05UpdNr1sOr
	 Emf1Sfvur3IuKDL0AMJYJ6T+TCyNM5MQiYEPxb8AaVZzSgtMxSw+ibcMd3/d5/0fef
	 XOxSApbsLagEQ==
Date: Thu, 22 Aug 2024 11:40:07 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Jiri Pirko <jiri@resnulli.us>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, apw@canonical.com,
	joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org, willemb@google.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [PATCH iwl-next v3 3/6] devlink: add devlink_fmsg_dump_skb()
 function
Message-ID: <20240822104007.GL2164@kernel.org>
References: <20240821133714.61417-1-przemyslaw.kitszel@intel.com>
 <20240821133714.61417-4-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821133714.61417-4-przemyslaw.kitszel@intel.com>

On Wed, Aug 21, 2024 at 03:37:11PM +0200, Przemek Kitszel wrote:
> From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> 
> Add devlink_fmsg_dump_skb() function that adds some diagnostic
> information about skb (like length, pkt type, MAC, etc) to devlink
> fmsg mechanism using bunch of devlink_fmsg_put() function calls.
> 
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

...

> diff --git a/net/devlink/health.c b/net/devlink/health.c
> index acb8c0e174bb..b98ca650284c 100644
> --- a/net/devlink/health.c
> +++ b/net/devlink/health.c
> @@ -1241,3 +1241,70 @@ int devlink_nl_health_reporter_test_doit(struct sk_buff *skb,
>  
>  	return reporter->ops->test(reporter, info->extack);
>  }
> +
> +/**
> + * devlink_fmsg_dump_skb - Dump sk_buffer structure
> + * @fmsg: devlink formatted message pointer
> + * @skb: pointer to skb
> + *
> + * Dump diagnostic information about sk_buff structure, like headroom, length,
> + * tailroom, MAC, etc.
> + */
> +void devlink_fmsg_dump_skb(struct devlink_fmsg *fmsg, const struct sk_buff *skb)
> +{
> +	struct skb_shared_info *sh = skb_shinfo(skb);
> +	struct sock *sk = skb->sk;
> +	bool has_mac, has_trans;
> +
> +	has_mac = skb_mac_header_was_set(skb);
> +	has_trans = skb_transport_header_was_set(skb);
> +
> +	devlink_fmsg_pair_nest_start(fmsg, "skb");
> +	devlink_fmsg_obj_nest_start(fmsg);
> +	devlink_fmsg_put(fmsg, "actual len", skb->len);
> +	devlink_fmsg_put(fmsg, "head len", skb_headlen(skb));
> +	devlink_fmsg_put(fmsg, "data len", skb->data_len);
> +	devlink_fmsg_put(fmsg, "tail len", skb_tailroom(skb));
> +	devlink_fmsg_put(fmsg, "MAC", has_mac ? skb->mac_header : -1);
> +	devlink_fmsg_put(fmsg, "MAC len",
> +			 has_mac ? skb_mac_header_len(skb) : -1);
> +	devlink_fmsg_put(fmsg, "network hdr", skb->network_header);
> +	devlink_fmsg_put(fmsg, "network hdr len",
> +			 has_trans ? skb_network_header_len(skb) : -1);
> +	devlink_fmsg_put(fmsg, "transport hdr",
> +			 has_trans ? skb->transport_header : -1);
> +	devlink_fmsg_put(fmsg, "csum", skb->csum);

Hi,

One minor nit here, which I don't think needs to stop progress of this
patchset. Sparse warns that:

error: no generic selection for 'restricted __wsum const [usertype] csum'

I believe this can be addressed by casting: (__force __u32) skb->csum,
perhaps incorporated into devlink_fmsg_put(). Which seems fine enough for
this case.

However, my observation is that there are a lot of sparse warnings
present in the tree due to similar issues around the use of __wsum.
And IMHO naked casts are error prone and not obviously correct to the
reader (me). So I wonder if there is some value in introducing some
helpers. E.g.

	wsum_to_cpu()
	cpu_to_wsum()

To my mind, that would clearly be out of scope for this patchset.
But It seems appropriate to raise this as it's been on my mind for a while.

...

