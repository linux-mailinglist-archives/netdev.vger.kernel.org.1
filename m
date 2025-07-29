Return-Path: <netdev+bounces-210816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDAAB14F02
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 16:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44A0189157C
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 14:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD7619CD1D;
	Tue, 29 Jul 2025 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ni02x7/J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBE3200A3
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797851; cv=none; b=d5c8xVtJK3aW9ZOcuOaTB0Ymqtqw465JCvbAUmbn1mSAmDVcGtHCi/w/AjT2VpSc9/LLHImHRhS7QPcBlHNkZK/TFiAe/y4sLMLPFGWaIIpwsfZP8t5G0dbioT0LUEURzj/OXrxcipxoN2CPoYDRTEHdmUJlerpmwaQqHbLHmlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797851; c=relaxed/simple;
	bh=HG0L901SQW7dYqRs5No/HjKyeNRxtDPIjvwnlgEGIlw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=B4McfKsqQGJTPZgjO2OCkQ3H4jF1IgQzzA4eo/hyamurgSIFy18/92jfLrlycLiaZ9+/74D8KWguJx9+NwtDLpQIVdoiRE7SyCb3rS6RaJvlC7BpnnrJp5wQ6/XW34gc1uEZZJwle2tqd7XICW+hIGcEi7atrwLAfn4O1PbUb7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ni02x7/J; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71a206ec3a0so12202817b3.0
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753797849; x=1754402649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/c8qNRZq6dF2fTMiROJwT32zXJbH22X4WykIATL1MA=;
        b=Ni02x7/JmqmJL+RhR83oHgu+ceNPlUFdB+mWcmKHoPXzVTvEl77zoGYuN0GBsnOPGS
         4Q13O66oBHZEDxkCny41LaKnHzMeJAU+LUHkvszHWDe+CL9vrMlk5XkdjWZHXmxMEKDi
         ixPO1Li5Ljp6s6WhDyXYr2noCXJl8bpbjx1Ozv2+SccbutbPRWRyzzcf2GosNBkpmsXm
         IJntS4IVz+dZfioqf8t1kdAUmivsI/gQyDUCt+w0Q6u6Ahrl0yzeat2eLfLoICB8qQBa
         jhU6CKk7/mujl0gmDWbY59hjSmNLipKc1pjvLhfYYtT87Cvll+PKgVUrtSgu1n+XMv1q
         RAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753797849; x=1754402649;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T/c8qNRZq6dF2fTMiROJwT32zXJbH22X4WykIATL1MA=;
        b=KnvwpGpupBEJvoykS8qW/sT5316N/F7vQz4sW3k0ZKi3EaGtNc40fq1DB9dRr7WA03
         EklNbb+VJCmCFCUh/5478ML+TRb//Ahr3vr0eNrBf7C7omQqK5IHEKEOsu2rhTWmgYe/
         53otAqMns2YEiQV6NCHPbowjnALhWRMlQ2FEvgk8cE/+LExkxZYuZ/5X2QDt8YWy6Nwb
         1YqOmiHV4vGM8dZIfi1wfwjo3h9yddXiH6oN7dBJz0STTA52yVwy1covc4fAVNtIi2Vq
         ksn5ZzMnLbdvvWrvigj3RyOPW3r2G/5gsGH8AHKw3O9dN8m/oJsFys3f8nhx6cSgoq/e
         ay+A==
X-Forwarded-Encrypted: i=1; AJvYcCU6JUpR8OUglFc+w/wQh8rtTohceYsc30UbjPulvx4+tvgaLTNVdUTfyUdXSGBhLDItvBHXiXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YylqD6/IlEXAI7fT8HSMJPZ9Bsa/DRS05LupEojKNxl2ozEXx8/
	jZlJsE/I1/3zlWx0coHlO8eky2w4tJ1yBLc7iEjROoxa5TwfuZtcS4Ee
X-Gm-Gg: ASbGncttJsyLV99GPBQ895Xh/pDmaQtD5uNsiCmCeY6Iyx1fMLEI0V/9yUs1+z6jfDK
	Y4D/GU8/EuJef1TyLOznkcolu+PKbEJqLQEMNbKPevrSLmhDbK0KTibNk1CALTumu9rMGP/v/qF
	XI6SbfbX3f6EM4NGW39seMLtbqJ9Ux99M/8TdP2AvJYUR5pXtlCgmPv1/wIxRuPYAHt4Psu3rzQ
	mcMtbXrEir7zUYgr4Ctyzr0Ipgz2XWeW5xOMR7MsrA55K15HvFLk2SrG39ISmtJG6VweGVrV2Fg
	5dw6gGQNbjslhHjF4qaR2vrbN111NlWSZh52b70nqAS2CPv9QN8Ou5tHUKoxsaj2khI0rlh1ymn
	LgLaKpWVhYHPEZ9LVk41gCkSsmvDW6wVtZiJtUDny5zBJBxsazPyu5L0SjUc4TZJ1auGRCw==
X-Google-Smtp-Source: AGHT+IEHOMlnMLI/4abakgM4dw/CDYgxrfe0rgKYH/D9kkyfbXFb9cvdqMUiF2M9y1biE+Dh7MUCUQ==
X-Received: by 2002:a05:690c:46c9:b0:70c:ceba:16 with SMTP id 00721157ae682-71a34a43067mr46500027b3.17.1753797842605;
        Tue, 29 Jul 2025 07:04:02 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-719f24067f3sm18023587b3.91.2025.07.29.07.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:04:01 -0700 (PDT)
Date: Tue, 29 Jul 2025 10:04:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 netdev@vger.kernel.org
Cc: quic_kapandey@quicinc.com, 
 quic_subashab@quicinc.com
Message-ID: <6888d4d07c92c_15cf79294cb@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250729114251.GA2193@hu-sharathv-hyd.qualcomm.com>
References: <20250729114251.GA2193@hu-sharathv-hyd.qualcomm.com>
Subject: Re: [PATCH v2] net: Add locking to protect skb->dev access in
 ip_output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Sharath Chandra Vurukala wrote:
> In ip_output() skb->dev is updated from the skb_dst(skb)->dev
> this can become invalid when the interface is unregistered and freed,
> 
> Introduced new skb_dst_dev_rcu() function to be used instead of
> skb_dst_dev() within rcu_locks in outout.This will ensure that
> all the skb's associated with the dev being deregistered will
> be transnmitted out first, before freeing the dev.
> 
> Multiple panic call stacks were observed when UL traffic was run
> in concurrency with device deregistration from different functions,
> pasting one sample for reference.
> 
> [496733.627565][T13385] Call trace:
> [496733.627570][T13385] bpf_prog_ce7c9180c3b128ea_cgroupskb_egres+0x24c/0x7f0
> [496733.627581][T13385] __cgroup_bpf_run_filter_skb+0x128/0x498
> [496733.627595][T13385] ip_finish_output+0xa4/0xf4
> [496733.627605][T13385] ip_output+0x100/0x1a0
> [496733.627613][T13385] ip_send_skb+0x68/0x100
> [496733.627618][T13385] udp_send_skb+0x1c4/0x384
> [496733.627625][T13385] udp_sendmsg+0x7b0/0x898
> [496733.627631][T13385] inet_sendmsg+0x5c/0x7c
> [496733.627639][T13385] __sys_sendto+0x174/0x1e4
> [496733.627647][T13385] __arm64_sys_sendto+0x28/0x3c
> [496733.627653][T13385] invoke_syscall+0x58/0x11c
> [496733.627662][T13385] el0_svc_common+0x88/0xf4
> [496733.627669][T13385] do_el0_svc+0x2c/0xb0
> [496733.627676][T13385] el0_svc+0x2c/0xa4
> [496733.627683][T13385] el0t_64_sync_handler+0x68/0xb4
> [496733.627689][T13385] el0t_64_sync+0x1a4/0x1a8
> 
> Changes in v2:
> - Addressed review comments from Eric Dumazet
> - Used READ_ONCE() to prevent potential load/store tearing
> - Added skb_dst_dev_rcu() and used along with rcu_read_lock() in ip_output
> 
> Signed-off-by: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
> ---
>  include/net/dst.h    | 12 ++++++++++++
>  net/ipv4/ip_output.c | 17 ++++++++++++-----
>  2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/dst.h b/include/net/dst.h
> index 00467c1b5093..692ebb1b3f42 100644
> --- a/include/net/dst.h
> +++ b/include/net/dst.h
> @@ -568,11 +568,23 @@ static inline struct net_device *dst_dev(const struct dst_entry *dst)
>  	return READ_ONCE(dst->dev);
>  }
>  
> +static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
> +{
> +	/* In the future, use rcu_dereference(dst->dev) */
> +	WARN_ON(!rcu_read_lock_held());

WARN_ON_ONCE or even DEBUG_NET_WARN_ON_ONCE

> +	return READ_ONCE(dst->dev);
> +}
> +
>  static inline struct net_device *skb_dst_dev(const struct sk_buff *skb)
>  {
>  	return dst_dev(skb_dst(skb));
>  }
>  
> +static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb)
> +{
> +	return dst_dev_rcu(skb_dst(skb));
> +}
> +
>  static inline struct net *skb_dst_dev_net(const struct sk_buff *skb)
>  {
>  	return dev_net(skb_dst_dev(skb));
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 10a1d182fd84..d70d79b71897 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -425,15 +425,22 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  
>  int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  {
> -	struct net_device *dev = skb_dst_dev(skb), *indev = skb->dev;
> +	struct net_device *dev, *indev = skb->dev;
> +	int ret_val;
>  
> +	IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);

Why introduce this?

> +
> +	rcu_read_lock();
> +	dev = skb_dst_dev_rcu(skb);
>  	skb->dev = dev;
>  	skb->protocol = htons(ETH_P_IP);
>  
> -	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
> -			    net, sk, skb, indev, dev,
> -			    ip_finish_output,
> -			    !(IPCB(skb)->flags & IPSKB_REROUTED));
> +	ret_val = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
> +			       net, sk, skb, indev, dev,
> +				ip_finish_output,
> +				!(IPCB(skb)->flags & IPSKB_REROUTED));
> +	rcu_read_unlock();
> +	return ret_val;
>  }
>  EXPORT_SYMBOL(ip_output);
>  



