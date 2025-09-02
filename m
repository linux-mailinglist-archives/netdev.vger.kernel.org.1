Return-Path: <netdev+bounces-219340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB61B41062
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 00:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B699516F86C
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD52277CB4;
	Tue,  2 Sep 2025 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Svp4bnH3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B452777FC;
	Tue,  2 Sep 2025 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756853777; cv=none; b=FYgLlkzZUDcG1NjM671L90x6pizz56HKMi6ejgObRyC1nzEQ3hbqtAAAyeRqWsvXT7QymxnBOgmPiqejf15FDLVlxUYQtkVjFWWjP7MspFlSw/vxMYq1FVw/ZKki+Mcq9m+wsrzwJVc4i6rWmpO4duvXT3iuxBvpVRec3mfoIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756853777; c=relaxed/simple;
	bh=L1aSF83k8T/325D8EFCetHBmvrLfymIgil/+0GT0i+k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AQxebH5yxclnASXRe1b35THzEcGkA5hAGKX6Uq5htfvdQjHEmL9VrcKdWk9G1wZ1S3s4nygIgECankhhRm8jZbSlKmz7kfydnlzfQSjsklpLMHDeLHB/4LGin+0sYrKOUkiq3Jk1MemxRBgZrXaViEu9IzcIHO3sBEusitQRaOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Svp4bnH3; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-7240eb21ccaso728696d6.0;
        Tue, 02 Sep 2025 15:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756853774; x=1757458574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6y60fL7NODA3Mze50fVdidlqngxPgWIM1G9KmQ67B7g=;
        b=Svp4bnH3wZ8kt3gIU9FYnj4DBbp/Gk+ILbtpM+j//Sy1NsGb9ISFHQX/7b2KgwHTnG
         O85zQIrSRdGP7kZSskEr0pI7yJxxxbw099GaX3zgqztrpYKKqdg3iFytc+vMa527hQR0
         pLiDhtgie333E+Mspusmk7A2T3eYaD7iZt6PbbmPpwl0ApbQRtoBt93bliRb8fDfPsW+
         tO4qoN0LkDJRCUgkhvAhhuK/VuNlRBSLwmVqRubBMSCT7wJfi6haOWusGaYDkT8wRPWn
         waOi06h6AR0ytGNW18eT6IXLcWbxge9AEajXeQy3AkWHfBMueZSbYUSL1F1toyP9A39W
         1c0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756853774; x=1757458574;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6y60fL7NODA3Mze50fVdidlqngxPgWIM1G9KmQ67B7g=;
        b=vEU9BSWqG6axN9FLwyd7kA19GLEZ99ylPEVid1BRV4LL0vanI055zHdveflpZtr3p7
         gJ5JE4MFn8tw+VbnMRuHAKKPX3FBu1DBOuKQkN9/RVrr+SdfddKjJUHDwmunLTreT1x8
         am1db1A4R2UwE6pcR8owkHJhxqW3xwtlX8Efj+r/PdI5XJg8qRlqSbbUnWogdvdueUMK
         5JS6IkZBqt0uSMK8MRauFiKN+lmJ7ygKFVBtzEMfLy0ky9LLAX0g8JzMb41wxfO+Qj88
         HlcrWyfQLu4QYLM2cpC93n/ehRJwezK9Vcq07F65LX1lmMmeQ7L0/0Z5QYfqe4JvXmBA
         bHag==
X-Forwarded-Encrypted: i=1; AJvYcCWJgyLrUcl7waEfPyAjTKNkwaPcIOyOAvJ/sctIuLi+3Mr6B7gyRcCrcyKk6d0VvQk3h9TeIHqNNg4b/xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUaVxnuifzgbsDwSeEf1MKDj/gMOW7S7Wqre5MNNb2Baendti9
	pjDo/jQu7+ydMGuOiJpcxaSR/a7exIHNkDLmqemaLTPG7pgqGVjvENZU
X-Gm-Gg: ASbGnctYIq+qTlrObyxhOioOtpDF1sNzbUa2+2nEx3xbGTfYYNFmPVexlqsylcHJEro
	HYECpF+kr1FhRMECWdfRCkzTS0i8av8ifxyo2cqQUfY0rWiRYBLh2dZRt+jCNikQXU3HdBH5r4S
	5J7KHT7lmbWlKDs5k3SOeQngXE+GPvWoDJPIRNiSokLaGyu95e2EBvHPfWkXXCcpK5jn1gS4e7I
	+cZDz7cnBpElTVcdxgcwnEnek7s0NgkMNjwse/AsvCi7Qb9lTJxNCgQEofXlsZ2wImD1aQmNIVp
	FsWxwfAe3cNDyqG3y5s6fRwGEmkoezPusYFiZiy+mKerp4v2cp5DFJksfotIXqKWn9q7V8ZGNL9
	wRL+kSLZ/3Mib/4CRtmyO4NuKpEKPwdggDs/AXrnWe6gJWCozrkytSVmG2ccADxe17NWHh1MXCI
	U56O1H1p8p7h0gPqoiURhD68I=
X-Google-Smtp-Source: AGHT+IGZcGFPDQK2aRbRHnSfA7r8wxVj7nChgols/TbbtyMaQgQza900R5sHWoInyWm5NemHw4jthw==
X-Received: by 2002:a05:622a:2d2:b0:4b0:66a3:f13c with SMTP id d75a77b69052e-4b31b8895eemr134350461cf.12.1756853774064;
        Tue, 02 Sep 2025 15:56:14 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-80aa60dbf87sm22282785a.3.2025.09.02.15.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:56:13 -0700 (PDT)
Date: Tue, 02 Sep 2025 18:56:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 kernel-team@meta.com, 
 efault@gmx.de, 
 calvin@wbinvd.org, 
 Breno Leitao <leitao@debian.org>
Message-ID: <willemdebruijn.kernel.a0f67bb6112a@gmail.com>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-5-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-5-51a03d6411be@debian.org>
Subject: Re: [PATCH 5/7] netpoll: Move SKBs pool to netconsole side
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> Since netconsole is the sole user of the SKBs pool within netpoll, move
> the pool management into the netconsole driver.
> 
> This change prevents other netpoll users from allocating and holding
> onto skb pool memory unnecessarily, thereby reducing memory usage when
> the pool is not required (which is all the cases except netconsole).
> 
> The skb poll struct is still attached to the netpoll, but, eventually
> this should move to the netconsole target, since it has nothing to do
> with netpoll.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netconsole.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++--
>  net/core/netpoll.c       | 44 ------------------------------------
>  2 files changed, 56 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 90e359b87469a..3fe55db07cfe5 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -57,6 +57,19 @@ MODULE_LICENSE("GPL");
>  #define MAX_EXTRADATA_ITEMS		16
>  #define MAX_PRINT_CHUNK			1000
>  
> +/*
> + * We maintain a small pool of fully-sized skbs, to make sure the
> + * message gets out even in extreme OOM situations.
> + */
> +
> +#define MAX_SKBS 32
> +#define MAX_UDP_CHUNK 1460
> +#define MAX_SKB_SIZE							\
> +	(sizeof(struct ethhdr) +					\
> +	 sizeof(struct iphdr) +						\
> +	 sizeof(struct udphdr) +					\
> +	 MAX_UDP_CHUNK)
> +
>  static char config[MAX_PARAM_LENGTH];
>  module_param_string(netconsole, config, MAX_PARAM_LENGTH, 0);
>  MODULE_PARM_DESC(netconsole, " netconsole=[src-port]@[src-ip]/[dev],[tgt-port]@<tgt-ip>/[tgt-macaddr]");
> @@ -172,6 +185,33 @@ struct netconsole_target {
>  	char			buf[MAX_PRINT_CHUNK];
>  };
>  
> +static void refill_skbs(struct netpoll *np)
> +{
> +	struct sk_buff_head *skb_pool;
> +	struct sk_buff *skb;
> +	unsigned long flags;
> +
> +	skb_pool = &np->skb_pool;
> +
> +	spin_lock_irqsave(&skb_pool->lock, flags);
> +	while (skb_pool->qlen < MAX_SKBS) {
> +		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
> +		if (!skb)
> +			break;
> +
> +		__skb_queue_tail(skb_pool, skb);
> +	}
> +	spin_unlock_irqrestore(&skb_pool->lock, flags);
> +}
> +
> +static void refill_skbs_work_handler(struct work_struct *work)
> +{
> +	struct netpoll *np =
> +		container_of(work, struct netpoll, refill_wq);
> +
> +	refill_skbs(np);
> +}
> +
>  #ifdef	CONFIG_NETCONSOLE_DYNAMIC
>  
>  static struct configfs_subsystem netconsole_subsys;
> @@ -341,6 +381,20 @@ static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
>  	return -1;
>  }
>  
> +static int setup_netpoll(struct netpoll *np)

Having both netpoll_setup and setup_netpoll is a bit confusing.
Maybe netconsole_setup_netpoll?

> +{
> +	int err;
> +
> +	err = netpoll_setup(np);
> +	if (err)
> +		return err;
> +
> +	refill_skbs(np);
> +	INIT_WORK(&np->refill_wq, refill_skbs_work_handler);
> +
> +	return 0;
> +}
> +
>  #ifdef	CONFIG_NETCONSOLE_DYNAMIC
>  
>  /*
> @@ -615,7 +669,7 @@ static ssize_t enabled_store(struct config_item *item,
>  		 */
>  		netconsole_print_banner(&nt->np);
>  
> -		ret = netpoll_setup(&nt->np);
> +		ret = setup_netpoll(&nt->np);
>  		if (ret)
>  			goto out_unlock;
>  
> @@ -2036,7 +2090,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
>  	if (err)
>  		goto fail;
>  
> -	err = netpoll_setup(&nt->np);
> +	err = setup_netpoll(&nt->np);
>  	if (err) {
>  		pr_err("Not enabling netconsole for %s%d. Netpoll setup failed\n",
>  		       NETCONSOLE_PARAM_TARGET_PREFIX, cmdline_count);

