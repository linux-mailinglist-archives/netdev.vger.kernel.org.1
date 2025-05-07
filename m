Return-Path: <netdev+bounces-188650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA2FAAE0A0
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F7D189827B
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 13:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DC625D20E;
	Wed,  7 May 2025 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw9LS5Zk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2F5258CC1
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624193; cv=none; b=UcdstAAFcWu8jFZ9Z8hU/NpyunHRJHwJ+KutDXVf9dCsi4zVrZqVaPgu6H5vMN6AnMu2mOs8LAKL1ylTPHhEAJAUMY8+Re+NDsCDMk9p7P6Qou6GOJsq0l4IwMhbk61kT4iTQLV1SsdquhisYJ0c2140o8d8tPAXVRCyPVrJSUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624193; c=relaxed/simple;
	bh=oovM9oInfMFry3rq5msqSb3tOHhCZDAXYS+G21GXeA8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fyxDktAgPKiN1dHeytRuyCT/XcL84sKZlFFOQbl/VeYTT/uF7kAuFndvGua0grlAtCoVn532OrX6pm4fYyKdbpz6B7kGugahDUluOMrUCV1zzB4foob4Hzeql5av584581JCT2+EF4mAk9z2BXnXaMYSGfc1BR4cyqQQ2dAHVm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lw9LS5Zk; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6f5499c21bbso2134766d6.3
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746624189; x=1747228989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVQCgol4pHEYkXFyhqCJGDpWyHh5mZNVIqJzWtQqDZ4=;
        b=Lw9LS5Zk+CpGc7rZu35zbLIhFLbPSS0f0KI/nMR6od9XVD3hhboG0ZeobhFGl+J6Vb
         dxvfQ+OGnDB3fVQOmA44whMomrYmFltRG+/ow6cNMgBqjEMejxrz8RtNC1HPlsj52S87
         G4sxLh9w6TaooFPR/T7quG4hhRBiwFctPcjAGEENXqhlhDv4hneMr991iEVgKGWgXqds
         ZafYVpHoxa3riYOuJKBGhAhxJgem6rc6PS+xcVhAvWkeVtVAksFx4J62bWQreooP2Lkq
         aTLFE/LFgySKybAnVt6nNv2E2W7mcUAJc6mX9wOD1RdMoceBfykAp5ezTbWFUGUja3W2
         QUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746624189; x=1747228989;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rVQCgol4pHEYkXFyhqCJGDpWyHh5mZNVIqJzWtQqDZ4=;
        b=ALSeXIDPhjSLbyWIvNQPhUjt0Z9y08W+zx9NgVHDfl4dkya2SF2ygupvGIDspeBZmw
         id/N1LlIJOsPY4ZmwbPJCfFsZjD42049E8nTwOur2m3xg+MPIRW7esruGQ4UAwNqQ1s+
         LelsV2G8utbCY4PTsgC5szszPn8q/PMYOXIqWFifY0/8X5s2/GT3EtKSXOkBUD2sLwgj
         RerL0ULGARF8rLhuDN7kVTNpqqMFiX5knKCWZVbCss2FflTTZQF0+oPQuQVpxPGAcawX
         vhs7Yn99Vf6hy6gykTUVR9/S8KY7ND63YpyvNrc4FN9xLmSyzBsqyXaKdmgbqaW9Xcaw
         itxw==
X-Forwarded-Encrypted: i=1; AJvYcCVpRNR/LggOCw61CCeJXcOeJ83bcyHRERwOnb7u63aab6dMCQpaPtkKZxjh8zRdzbC7YWkzZbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZIpRRjQIwO6sRp3hWdYFStVnfCpqbr7c/PydKOs0Tt8YyvwIx
	0csSwPrt33E1CzhSUGOA5AELGABWp6BdQPVR6VgVeGQwxLWztQMF+QSxjw==
X-Gm-Gg: ASbGncv/5epaLZkia5yodqoWGoNbeMIa2r3MU4MAnAqtZ8DBcgF0cweVr/ziH8SGEJr
	lLrHMns2wSGNd7nbmjEDsoepwQFi13U38y05ZQZnMMU3oOED8leUaemSj5RiLaI03O4UaMrxtL0
	yUtw7qsFGp0t25I3axUZuWjSj9epp0CbYz0W4wNwN28I4bdnUQDtem5Qp+oHsW6TwwFxQZbvM1t
	qegoG09wbBprFYorgyjgSeFvk3ttF+RPtQ2RSdep1pafPcJ7h+rq/PPN5iuALh9V2uCCDmy+FhH
	sFadDqo73Bbz9BoDfuip6sTZ0XPa0n5zW1fPzX+yj1Azz5NwFKLgn3EU4pMZ+hn+R9JfMGfeWDf
	BBW09jokyWXTHScin4DlR
X-Google-Smtp-Source: AGHT+IGw9zFvQzhsnQJx2KylHinzZ1CicUi3HmuYemzfpRLT6lEp99L4vAVhTeNIaVwipM6aKEmGYg==
X-Received: by 2002:a05:6214:226d:b0:6f2:b0a7:3982 with SMTP id 6a1803df08f44-6f542acc44fmr53423916d6.37.1746624189303;
        Wed, 07 May 2025 06:23:09 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f5426238c2sm14081686d6.21.2025.05.07.06.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:23:08 -0700 (PDT)
Date: Wed, 07 May 2025 09:23:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 sgoutham@marvell.com, 
 andrew+netdev@lunn.ch, 
 willemb@google.com
Cc: linux-arm-kernel@lists.infradead.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <681b5ebc80a81_1e440629460@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250507030804.70273-1-kerneljasonxing@gmail.com>
References: <20250507030804.70273-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next] net: thunder: make tx software timestamp
 independent
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> skb_tx_timestamp() is used for tx software timestamp enabled by
> SOF_TIMESTAMPING_TX_SOFTWARE while SKBTX_HW_TSTAMP is controlled by
> SOF_TIMESTAMPING_TX_HARDWARE. As it clearly shows they are different
> timestamps in two dimensions, this patch makes the software one
> standalone.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> index 06397cc8bb36..d368f381b6de 100644
> --- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> +++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> @@ -1389,11 +1389,11 @@ nicvf_sq_add_hdr_subdesc(struct nicvf *nic, struct snd_queue *sq, int qentry,
>  		this_cpu_inc(nic->pnicvf->drv_stats->tx_tso);
>  	}
>  
> +	skb_tx_timestamp(skb);
> +
>  	/* Check if timestamp is requested */

Nit: check if hw timestamp is requested.

> -	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
> -		skb_tx_timestamp(skb);
> +	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
>  		return;
> -	}

The SO_TIMESTAMPING behavior around both software and hardware
timestamps is a bit odd.

Unless SOF_TIMESTAMPING_OPT_TX_SWHW is set, by default a driver will
only return software if no hardware timestamp is also requested.

Through the following in __skb_tstamp_tx

        if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
            skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
                return;

There really is no good reason to have this dependency. But it is
historical and all drivers should implement the same behavior.

This automatically happens if the software timestamp request
skb_tx_timestamp is called after the hardware timestamp request
is configured, i.e., after SKBTX_IN_PROGRESS is set. That usually
happens because the software timestamp is requests as close to kicking
the doorbell as possible.

In this driver, that would be not in nicvf_sq_add_hdr_subdesc, but
just before calling nicvf_sq_doorbell. Unfortunately, there are two
callers, TSO and non-TSO.

>  
>  	/* Tx timestamping not supported along with TSO, so ignore request */
>  	if (skb_shinfo(skb)->gso_size)
> -- 
> 2.43.5
> 



