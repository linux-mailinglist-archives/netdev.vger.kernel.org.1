Return-Path: <netdev+bounces-145334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D2C9CF15B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 17:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BD8293C3E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B100B1CF7B8;
	Fri, 15 Nov 2024 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="oSHjg56A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66B81632F0
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731687693; cv=none; b=FtxN6fyJyZaS2zOkjcqETuHnh46NVznMf0BWE7wsbIkkb9nr7N6yjfGlSLt0YNRC83cfIOc5EwVXSJonvJ8/AEqIzrGlLz/7ujybaYySY/qGDkfv3Blixc1AkpOPqOhwtvoHCmz9l0AJmPbyg8F9VvdoXHKBACQCBCrD6ubJXUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731687693; c=relaxed/simple;
	bh=BzURog2WR1lvzdpQjIEB5UrUcLKtSO92TVEom4p7DnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzlhMnsgGS8uLTREAjz/Ah19TNZRHymE/Dp8G2BMuYDr57SHaCMr/6m7cEv5EVC+UfpUZhgteaHDMnxJfchn8DHrR91WLpZP/4Gl0qgQd9B234gQPtis7jZFO6Wet3CvQgNZkbNHJY0tXUnEbACOLL/8jGp0T8F44GiL3X/Mew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=oSHjg56A; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53a097aa3daso2078225e87.1
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 08:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1731687690; x=1732292490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PBb8OTHxpga1dUPSRILcj6Z6qMT16617s30DMNtiCJM=;
        b=oSHjg56AwqYsLc6tBvazhdnfBBicJZisFupl3u1o3tJv0tFNh/tvDUojtw03v/k28/
         Bpg8ecLwBOZB7aZcBfpVw7od7KaIaudiTr4V1Qkqpt/J1jBkMenJkZzfJ5YZOsE4tPmd
         hKj27CDvoKDWsvYdB1Ms9BA0Vxrh+Rb4iSdNqyGZ9EjVHdGDHf8UrUFMG1aPtJp3g3VR
         HEZIPbrHiDkbO+pCXhhBkL94CnlO8tJ25F+wkqgJYiI3KrlHm5oDWLGY+hMia0j5/YXW
         fP0WNVo7ao/+gEH333Hap3edpI4F3VY/XfnwNKmrxkZEC8+NZeOnuzRc3MddM7oUm2Xj
         d6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731687690; x=1732292490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBb8OTHxpga1dUPSRILcj6Z6qMT16617s30DMNtiCJM=;
        b=dGMDt6O2GwTJrDqMosoyWb0L35atPwAsK4g++sJcsiMaSXB6baqiMkIWSraLsiZyIY
         OSprk1a1IvCx+R1DT3ivK941O7rDDn7QdMiROUO0ctR1v8q0B51he1YYlFAZ/EdTskxT
         lBlvhx+S+TXY6uK73E+jd7z2KGlGP4F7S8/ax8/XBUXAlYmS7FUHiX34YpXGnLrT8wcu
         S+C6Jo8WbUQBGDNxtg1WyyTHzy9VB4n0ekjkgTH7KH7zEjrAzNfsMbTW16gAXPQvJ7gR
         0gsZIR7H7tZ0+dvRYboKbMxL4OYaqF8fdANNSxMJQmPy7B5Ta+b9pil6ZBl/6mNZ86m9
         /uFA==
X-Forwarded-Encrypted: i=1; AJvYcCUtt1Y5+wYE0FI+E9LdJBOHJKojQZptaKrmnwLWomKnSw7RpO2m3A5g5BLQ1hGgyT6U9K9rTWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvS5w0pSSh/LfZXweAoedBFH7PChoSCUcbKDmw7r0UTpxW/1bK
	sjBmWiBykyMsGnLaM7B0C5z876ysu/k4Fc6D0G+1Z1wyUuQV2STPWhbwMHIIvsI=
X-Google-Smtp-Source: AGHT+IGQaeefNvej67769wOg5MhvFAQbO92cQ4eqXqJpyq2omxsheBuQJGiQ0mULBdiTPTaNS+ivHw==
X-Received: by 2002:a05:6512:28a:b0:53d:ac13:795 with SMTP id 2adb3069b0e04-53dac130809mr1256281e87.0.1731687689697;
        Fri, 15 Nov 2024 08:21:29 -0800 (PST)
Received: from localhost ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6548876sm617971e87.230.2024.11.15.08.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:21:29 -0800 (PST)
Date: Fri, 15 Nov 2024 18:21:28 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: roopa@nvidia.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bridge: Fix the wrong format specifier
Message-ID: <Zzd1CPHRIXAx8Vpk@penguin>
References: <20241114025820.37632-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114025820.37632-1-zhangjiao2@cmss.chinamobile.com>

On Thu, Nov 14, 2024 at 10:58:20AM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> The format specifier of "unsigned long" in sprintf()
> should be "%lu", not "%ld".
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  net/bridge/br_sysfs_br.c | 8 ++++----
>  net/bridge/br_sysfs_if.c | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 

Hi,
I think this patch is unnecessary (also should be targeted at net-next).
We may change the return value of br_timer_value to clock_t to be
consistent with jiffies_delta_to_clock_t(). It cannot return more than
a long, so %ld is fine here.

A simple patch like [1] can be considered to better show what is
being returned.

Thanks,
 Nik

[1]
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index f317d8295bf4..fbdadef68854 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1986,7 +1986,7 @@ void br_stp_rcv(const struct stp_proto *proto, struct sk_buff *skb,
 /* br_stp_timer.c */
 void br_stp_timer_init(struct net_bridge *br);
 void br_stp_port_timer_init(struct net_bridge_port *p);
-unsigned long br_timer_value(const struct timer_list *timer);
+clock_t br_timer_value(const struct timer_list *timer);
 
 /* br.c */
 #if IS_ENABLED(CONFIG_ATM_LANE)
diff --git a/net/bridge/br_stp_timer.c b/net/bridge/br_stp_timer.c
index 27bf1979b909..7b09fe3abd22 100644
--- a/net/bridge/br_stp_timer.c
+++ b/net/bridge/br_stp_timer.c
@@ -154,7 +154,7 @@ void br_stp_port_timer_init(struct net_bridge_port *p)
 }
 
 /* Report ticks left (in USER_HZ) used for API */
-unsigned long br_timer_value(const struct timer_list *timer)
+clock_t br_timer_value(const struct timer_list *timer)
 {
 	return timer_pending(timer)
 		? jiffies_delta_to_clock_t(timer->expires - jiffies) : 0;

> diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
> index ea733542244c..0edab3910d46 100644
> --- a/net/bridge/br_sysfs_br.c
> +++ b/net/bridge/br_sysfs_br.c
> @@ -266,7 +266,7 @@ static ssize_t hello_timer_show(struct device *d,
>  				struct device_attribute *attr, char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%ld\n", br_timer_value(&br->hello_timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&br->hello_timer));
>  }
>  static DEVICE_ATTR_RO(hello_timer);
>  
> @@ -274,7 +274,7 @@ static ssize_t tcn_timer_show(struct device *d, struct device_attribute *attr,
>  			      char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%ld\n", br_timer_value(&br->tcn_timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&br->tcn_timer));
>  }
>  static DEVICE_ATTR_RO(tcn_timer);
>  
> @@ -283,7 +283,7 @@ static ssize_t topology_change_timer_show(struct device *d,
>  					  char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%ld\n", br_timer_value(&br->topology_change_timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&br->topology_change_timer));
>  }
>  static DEVICE_ATTR_RO(topology_change_timer);
>  
> @@ -291,7 +291,7 @@ static ssize_t gc_timer_show(struct device *d, struct device_attribute *attr,
>  			     char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%ld\n", br_timer_value(&br->gc_work.timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&br->gc_work.timer));
>  }
>  static DEVICE_ATTR_RO(gc_timer);
>  
> diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
> index 74fdd8105dca..08ad4580e645 100644
> --- a/net/bridge/br_sysfs_if.c
> +++ b/net/bridge/br_sysfs_if.c
> @@ -155,21 +155,21 @@ static BRPORT_ATTR(state, 0444, show_port_state, NULL);
>  static ssize_t show_message_age_timer(struct net_bridge_port *p,
>  					    char *buf)
>  {
> -	return sprintf(buf, "%ld\n", br_timer_value(&p->message_age_timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&p->message_age_timer));
>  }
>  static BRPORT_ATTR(message_age_timer, 0444, show_message_age_timer, NULL);
>  
>  static ssize_t show_forward_delay_timer(struct net_bridge_port *p,
>  					    char *buf)
>  {
> -	return sprintf(buf, "%ld\n", br_timer_value(&p->forward_delay_timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&p->forward_delay_timer));
>  }
>  static BRPORT_ATTR(forward_delay_timer, 0444, show_forward_delay_timer, NULL);
>  
>  static ssize_t show_hold_timer(struct net_bridge_port *p,
>  					    char *buf)
>  {
> -	return sprintf(buf, "%ld\n", br_timer_value(&p->hold_timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&p->hold_timer));
>  }
>  static BRPORT_ATTR(hold_timer, 0444, show_hold_timer, NULL);
>  
> -- 
> 2.33.0
> 
> 
> 

