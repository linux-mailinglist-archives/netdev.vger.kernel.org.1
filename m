Return-Path: <netdev+bounces-238806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB13C5FD35
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 94E2A3406A2
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 01:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D1C19644B;
	Sat, 15 Nov 2025 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8YqCfLn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6FE15539A
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 01:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763169729; cv=none; b=J9u5T8dtF354TSuvNxn1mcAzgSVOKC2b+VGCMRZ1+jD4V7E2/kaZg6YZ1UwF4Fhp9TNXy+Imyg/Q/KawjoNMtjork3xjopSlltSAh9I9SPKkbZ23F5aeLFSk+PID0OP/xdr0s9MmW5JvYgx1qnQYB34fcjE59AEIDA77wm/36BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763169729; c=relaxed/simple;
	bh=nAjPGSMykcwfyvHEItbOrzVRxjFJAgO0MMaKaJ7s6Is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3kDVoEO6iooosiBRLiztFMUsfmjWfyZjUU763bJ1ht3y1AP588onhFsmrDCHCQoc0o4QNbfsAEpSiEIdvF9moDcWvc2F02p3m+SIg0Oil+BvWbdump2nIClnKQUQ0SthGRLBUWNyQWEhyI6RqZKwp7Iiiy8luVsb2KjSmUZ+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8YqCfLn; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-9486251090eso98226839f.2
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 17:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763169725; x=1763774525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=az6gEsJkxHovFWKMSLmwg49QAnCBp+806sYXLoWT6UE=;
        b=f8YqCfLnRnmEWeRDDxof/uJ5Cxn6kNyJbqAsLf7OXf4FuQmz0M/SgFyiVSR5mH37/y
         JkuGKR1G+hyBM/0F2K867Jy/WfXHMwM26Gt8lQxHkjgMyIhj995ognO8SicEOlkBuqpf
         4p5WxxyR4hXyrkh1w7Fuh7puQOG13dwl79u3OLfKPfXRlTlidHIdPwBkf8+Iq5OmqBHF
         /rADynZ/wDu3JsioBo93Waw49VmSZuVozlK5LiWmFuDhHaOVB8NeTJEimUgrp1SHMzJj
         amn6w/e3J+3Y/WinxfB4Vt/uiBvpyDPJ6rDvjYe2e7B5j+oZYKciImPSPFvCoNbgA0o8
         mcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763169725; x=1763774525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=az6gEsJkxHovFWKMSLmwg49QAnCBp+806sYXLoWT6UE=;
        b=FBdM4b1xb4p5ax/gWONMPjOBOI6050xUlxyROlfPVd8UlfkFQdWdOEInSNZUXSQ5Cp
         Ws8fekaw+KBqd0ByWQ7G+x6iHSQJbI9TTHp5zYsyjsrhRRoiFCpW+fA2kvmhxdZmEzck
         rpoiboFDV2lvTieUX6hdbJfHtUyfDC4+C7FeqWfvCHAyZMQLsGCZI0aWwd+ZbhZcgXDV
         pFfRTw268SWagLezC56Mpkq3cvT3u0+qngo3kryk2ZN12NuuxD5jUx6idm+zW6KWZjJz
         D3F5A6U97nC7lGaEWsgEh4K0mYyjJKTud9C95yzcZhIeplnCU9i2GpyFCLgoRh80IPML
         rqMg==
X-Forwarded-Encrypted: i=1; AJvYcCWVBmBWBolu5o38t94rF50iDIHjopGyfVyHyRDceMK9m5rW7ydLjV917UCZoJgMq607NWe3ln8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1aZgWMBqjg+onVelUCLAoNP14U3YC9dZqjQJfawe/E22Iw3lK
	XnmpkNbAdp5vr3S4vU5MGpkOZQ592z/+wyXH0P0mkMNOjxzAHBBL+gCITwqFQg==
X-Gm-Gg: ASbGncthKYD46rHFZECSi96pHPnlDV6hOGVHfoI0CBfA8YnEHsF7sn5B0vA8+vo6Gfs
	QvVs8gSydc6Rvi+c+2nKACitWNj+xG8FMMjYM3ZAwN6uwvE7d8+L+Q8WhMlLSB1dUODrvInSWW9
	pZkiw10V+jsVNrlRv0p8C90xtaQP2yebmuTp1jPBQkESKzwfHRJCwuJyKOHKb0t9pSYPuohI83t
	u6RYab/CC3Jsu9ScahaFc6RZ8MDiGB5WrkmLYCHK6mzpjxTqN6xBlP8pl1dqV0PkWr4efVvR+2F
	nG4K7+U6W6s6NqV2mxOV7qDwEcFLI1KZVUbRexHjdcjZRUOwPw/pbZszdvSUpG7AI+B9aYOJySD
	eMVfnsi9SPMTU1mDtujlUkPcVJh7ZivFEsJwkojXnH68qVoYTaiCfFyF8X/WzqDGHzdLxbxTu6k
	65rXgMo6UMblibpBj7iGPT4eqSHkQmIJaG5/tcwBi3tDwr36ShGyPWcEogyX/xexUDPrD2gtO+y
	JN/1g==
X-Google-Smtp-Source: AGHT+IE8eigWzoEE9t3mDIDQms9qFe71psPrdvja2/GrWq64P3LmSHdQvvcjXhpM4eeOF92EMZl02g==
X-Received: by 2002:a02:cc84:0:b0:5b7:24c7:e78 with SMTP id 8926c6da1cb9f-5b7c9db5213mr738532173.12.1763169724671;
        Fri, 14 Nov 2025 17:22:04 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:85e7:c261:d08f:ac20? ([2601:282:1e02:1040:85e7:c261:d08f:ac20])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-5b7bd3171cbsm1577116173.32.2025.11.14.17.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 17:22:03 -0800 (PST)
Message-ID: <296bed71-34b3-48df-8799-0701083712f4@gmail.com>
Date: Fri, 14 Nov 2025 18:22:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] devlink: Support
 DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE
To: Saeed Mahameed <saeed@kernel.org>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, Jiri Pirko <jiri@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <20251107001435.160260-1-saeed@kernel.org>
Content-Language: en-US
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20251107001435.160260-1-saeed@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 5:14 PM, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Add support for the new inactive switchdev mode [1].
> 
> A user can start the eswitch in switchdev or switchdev_inactive mode.
> 
> Active: Traffic is enabled on this eswitch FDB.
> Inactive: Traffic is ignored/dropped on this eswitch FDB.
> 
> An example use case:
> $ devlink dev eswitch set pci/0000:08:00.1 mode switchdev_inactive
> Setup FDB pipeline and netdev representors
> ...
> Once ready to start receiving traffic
> $ devlink dev eswitch set pci/0000:08:00.1 mode switchdev
> 
> [1] https://lore.kernel.org/all/20251107000831.157375-1-saeed@kernel.org/
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
>  devlink/devlink.c            | 7 ++++++-
>  include/uapi/linux/devlink.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/devlink/devlink.c b/devlink/devlink.c
> index 35128083..fd9fac21 100644
> --- a/devlink/devlink.c
> +++ b/devlink/devlink.c
> @@ -45,6 +45,7 @@
>  
>  #define ESWITCH_MODE_LEGACY "legacy"
>  #define ESWITCH_MODE_SWITCHDEV "switchdev"
> +#define ESWITCH_MODE_SWITCHDEV_INACTIVE "switchdev_inactive"
>  #define ESWITCH_INLINE_MODE_NONE "none"
>  #define ESWITCH_INLINE_MODE_LINK "link"
>  #define ESWITCH_INLINE_MODE_NETWORK "network"

These modes really should be an array that is used for both set and
show. Then eswitch_mode_get and eswitch_mode_get would not need to be
touched; just update arrays and the new entries take effect.

> @@ -1428,6 +1429,8 @@ static int eswitch_mode_get(const char *typestr,
>  		*p_mode = DEVLINK_ESWITCH_MODE_LEGACY;
>  	} else if (strcmp(typestr, ESWITCH_MODE_SWITCHDEV) == 0) {
>  		*p_mode = DEVLINK_ESWITCH_MODE_SWITCHDEV;
> +	} else if (strcmp(typestr, ESWITCH_MODE_SWITCHDEV_INACTIVE) == 0) {
> +		*p_mode = DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE;
>  	} else {
>  		pr_err("Unknown eswitch mode \"%s\"\n", typestr);
>  		return -EINVAL;
> @@ -2848,7 +2851,7 @@ static bool dl_dump_filter(struct dl *dl, struct nlattr **tb)
>  static void cmd_dev_help(void)
>  {
>  	pr_err("Usage: devlink dev show [ DEV ]\n");
> -	pr_err("       devlink dev eswitch set DEV [ mode { legacy | switchdev } ]\n");
> +	pr_err("       devlink dev eswitch set DEV [ mode { legacy | switchdev | switchdev_inactive } ]\n");
>  	pr_err("                               [ inline-mode { none | link | network | transport } ]\n");
>  	pr_err("                               [ encap-mode { none | basic } ]\n");
>  	pr_err("       devlink dev eswitch show DEV\n");
> @@ -3284,6 +3287,8 @@ static const char *eswitch_mode_name(uint32_t mode)
>  	switch (mode) {
>  	case DEVLINK_ESWITCH_MODE_LEGACY: return ESWITCH_MODE_LEGACY;
>  	case DEVLINK_ESWITCH_MODE_SWITCHDEV: return ESWITCH_MODE_SWITCHDEV;
> +	case DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE:
> +		return ESWITCH_MODE_SWITCHDEV_INACTIVE;
>  	default: return "<unknown mode>";
>  	}
>  }
> diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
> index bcd5fde1..317c088b 100644
> --- a/include/uapi/linux/devlink.h
> +++ b/include/uapi/linux/devlink.h
> @@ -181,6 +181,7 @@ enum devlink_sb_threshold_type {
>  enum devlink_eswitch_mode {
>  	DEVLINK_ESWITCH_MODE_LEGACY,
>  	DEVLINK_ESWITCH_MODE_SWITCHDEV,
> +	DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE,
>  };
>  
>  enum devlink_eswitch_inline_mode {

uapi changes should be a separate patch that I can drop when applying
the rest of the changes.

Requests for future patches; i applied this one to iproute2-next.


