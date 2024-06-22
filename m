Return-Path: <netdev+bounces-105888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3929135F5
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 22:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9EFE1C20B18
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 20:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9708758ABC;
	Sat, 22 Jun 2024 20:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0RPBgVK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D300126AF0;
	Sat, 22 Jun 2024 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719087096; cv=none; b=FRuVnV16QtsqfU+66StwvMB07aCf6ipTQ/Tl2otallx98iAAPE9qrXoU+YbLsOwTzGUllC5luwtS4dGqwXH7/9BqkDTifsifg0MdoBWrJROEKXurlxArFhRj0pMxlArlHKAcH3iLU/uZvISjh7z+J8iJSYVTJ6+Y/Lz7dIxNQgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719087096; c=relaxed/simple;
	bh=+zXOwbMkBziGkH1T0R/5PmJNVe24xZpz4eiv1eSe3OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fad4fa/AsYLRT9FlkG8ZNTFd74XLegLb0axQwSx9IjGjI9CVgTECXKFofq4yUbNBdcxdruygb9C1wI0TAFIosjky6ul4n6nKEFpv5853n7X2526GQXm6Z+k6re0BgvB4Sg+NKviwUXNeETZNcCKZnVokPEGi7ecJzyJAutm2Q54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0RPBgVK; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5c1b734383cso1359586eaf.3;
        Sat, 22 Jun 2024 13:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719087094; x=1719691894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=poMItkc0awxNCUZaVOb8H2ye3xNgX1XTsKLqSsFt9+I=;
        b=Q0RPBgVKrGStSmTZIDPOGTNxQ9evDORX6ZGqQd0RRbjLM6I9pi2HVO8JPARVKj9qZa
         Bewe/n0EneOjsndFNRV13JFB+T13L3mik8yNShXrF/ulzKtASPeexL5P6HKxTiFNBhkx
         o0rgrg+gzJaijUwzoknveFMcE20U6IrvMUhja5LNksVpetNQjjydvi7fTSKBmOTN9MN/
         SMTCFdccLmgrhNzmUpuLOK53B+qai6gBAYN2b3zcQvIE76RhVF10kd2O7alZz10eDHCN
         IFIAKLD8hA0t6tTUcJMuMFFljgK69wbkpBcXFgZZNMrdvK3EQ8+9F6bBNMbYJpMff7yv
         woLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719087094; x=1719691894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=poMItkc0awxNCUZaVOb8H2ye3xNgX1XTsKLqSsFt9+I=;
        b=Z61PAbsc3LuTG2iYfaNFv0HZT89Xz71tuauvC8MIT/wGengnmACaCosIfrTmSwCYYQ
         FhZwFea59jc239oyNQubkOU4RFLLKanfqY67FjFMU61/0xOb9xd/oAZ9+zo7YYAR0InM
         jekZlcD7ZJ51UK58/TwaV8CJTPB/z9DWdWdDSp3bcPqOaTLO3bKs8z4Zh4p4x/Oyqgjz
         B7VYoQN+c2lV36KDev00wgfiymbopsvX8jUvOX6IxDAKHdI7aixw4x81dcIyXq3sC4dX
         IaT934LfXFrIAqE3adYbnIlcjwQXzl/AaEdtPRl9mDZxeujQi89quqfb+ECnGkVU4Azi
         pWBg==
X-Forwarded-Encrypted: i=1; AJvYcCWlxJX4PouDzo9zEmHwoNsi9vdmX1J4elzadBKQy9wEX/O2c2mhgbEQyttEYF3nIJdEPv1llL8Id11U+VAp+oz/9zGe/KTIhR0+wy1cf3pk1dPa14JQUsmVoY8HakB7sDqonftZv9/zWq1gUF6ucWOhhL0taiva7Qo+vB+vE1LG
X-Gm-Message-State: AOJu0YyL2wcSERaPOKw7G6AIFZK+KYF/jkk0Zr7WxbWYd27nroN5lQs/
	UGTbY32uLf/IqCA3Tv4uxMQtd3FPCDnb0Mg4JY6I2YcMukmkF+Ad
X-Google-Smtp-Source: AGHT+IEFb5N47Q3F+FnjSvLjyHe+WVPPRSLpJ7o2xocgsv5A52VALJxhlmBSkYq6FBiGkJYUqPw2mA==
X-Received: by 2002:a05:6820:2210:b0:5c1:eef3:3971 with SMTP id 006d021491bc7-5c1eef339ccmr928586eaf.8.1719087093668;
        Sat, 22 Jun 2024 13:11:33 -0700 (PDT)
Received: from ?IPV6:2603:8080:2300:de:3d70:f8:6869:93de? ([2603:8080:2300:de:3d70:f8:6869:93de])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-700a8037e37sm340635a34.78.2024.06.22.13.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 13:11:33 -0700 (PDT)
Message-ID: <6d51478f-2311-4f33-88d4-ff20d89fe621@gmail.com>
Date: Sat, 22 Jun 2024 15:11:32 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation: fix links to mailing list services
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240618-docs-patch-msgid-link-v1-0-30555f3f5ad4@linuxfoundation.org>
 <20240618-docs-patch-msgid-link-v1-1-30555f3f5ad4@linuxfoundation.org>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20240618-docs-patch-msgid-link-v1-1-30555f3f5ad4@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/24 11:42, Konstantin Ryabitsev wrote:

> There have been some changes to the way mailing lists are hosted at
> kernel.org, so fix the links that are pointing at the outdated
> resources.
>
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> ---
>  Documentation/process/2.Process.rst          |  8 ++++----
>  Documentation/process/howto.rst              | 10 +++++-----
>  Documentation/process/kernel-docs.rst        |  5 ++---
>  Documentation/process/maintainer-netdev.rst  |  5 ++---
>  Documentation/process/submitting-patches.rst | 15 +++++----------
>  5 files changed, 18 insertions(+), 25 deletions(-)
>
> diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
> index 613a01da4717..ef3b116492df 100644
> --- a/Documentation/process/2.Process.rst
> +++ b/Documentation/process/2.Process.rst
> @@ -392,13 +392,13 @@ represent a potential hazard to developers, who risk getting buried under a
>  load of electronic mail, running afoul of the conventions used on the Linux
>  lists, or both.
>  
> -Most kernel mailing lists are run on vger.kernel.org; the master list can
> +Most kernel mailing lists are hosted at kernel.org; the master list can
>  be found at:
>  
> -	http://vger.kernel.org/vger-lists.html
> +	https://subspace.kernel.org
>  
> -There are lists hosted elsewhere, though; a number of them are at
> -redhat.com/mailman/listinfo.
> +There are lists hosted elsewhere; please check the MAINTAINERS file for
> +the list relevant for any particular subsystem.
>  
>  The core mailing list for kernel development is, of course, linux-kernel.
>  This list is an intimidating place to be; volume can reach 500 messages per
> diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
> index eebda4910a88..9438e03d6f50 100644
> --- a/Documentation/process/howto.rst
> +++ b/Documentation/process/howto.rst
> @@ -331,7 +331,7 @@ they need to be integration-tested.  For this purpose, a special
>  testing repository exists into which virtually all subsystem trees are
>  pulled on an almost daily basis:
>  
> -	https://git.kernel.org/?p=linux/kernel/git/next/linux-next.git
> +	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>  
>  This way, the linux-next gives a summary outlook onto what will be
>  expected to go into the mainline kernel at the next merge period.
> @@ -373,12 +373,12 @@ As some of the above documents describe, the majority of the core kernel
>  developers participate on the Linux Kernel Mailing list.  Details on how
>  to subscribe and unsubscribe from the list can be found at:
>  
> -	http://vger.kernel.org/vger-lists.html#linux-kernel
> +	https://subspace.kernel.org/subscribing.html
>  
>  There are archives of the mailing list on the web in many different
>  places.  Use a search engine to find these archives.  For example:
>  
> -	https://lore.kernel.org/lkml/
> +	https://lore.kernel.org/linux-kernel/
>  
>  It is highly recommended that you search the archives about the topic
>  you want to bring up, before you post it to the list. A lot of things
> @@ -393,13 +393,13 @@ groups.
>  Many of the lists are hosted on kernel.org. Information on them can be
>  found at:
>  
> -	http://vger.kernel.org/vger-lists.html
> +	https://subspace.kernel.org
>  
>  Please remember to follow good behavioral habits when using the lists.
>  Though a bit cheesy, the following URL has some simple guidelines for
>  interacting with the list (or any list):
>  
> -	http://www.albion.com/netiquette/
> +	https://subspace.kernel.org/etiquette.html
>  
>  If multiple people respond to your mail, the CC: list of recipients may
>  get pretty large. Don't remove anybody from the CC: list without a good
> diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
> index 8660493b91d0..3476fb854c7a 100644
> --- a/Documentation/process/kernel-docs.rst
> +++ b/Documentation/process/kernel-docs.rst
> @@ -194,9 +194,8 @@ Miscellaneous
>  
>      * Name: **linux-kernel mailing list archives and search engines**
>  
> -      :URL: http://vger.kernel.org/vger-lists.html
> -      :URL: http://www.uwsg.indiana.edu/hypermail/linux/kernel/index.html
> -      :URL: http://groups.google.com/group/mlist.linux.kernel
> +      :URL: https://subspace.kernel.org
> +      :URL: https://lore.kernel.org


Nice!
Reviewed-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>


>        :Keywords: linux-kernel, archives, search.
>        :Description: Some of the linux-kernel mailing list archivers. If
>          you have a better/another one, please let me know.
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index 5e1fcfad1c4c..fe8616397d63 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -25,9 +25,8 @@ drivers/net (i.e. hardware specific drivers) in the Linux source tree.
>  Note that some subsystems (e.g. wireless drivers) which have a high
>  volume of traffic have their own specific mailing lists and trees.
>  
> -The netdev list is managed (like many other Linux mailing lists) through
> -VGER (http://vger.kernel.org/) with archives available at
> -https://lore.kernel.org/netdev/
> +Like many other Linux mailing lists, the netdev list is hosted at
> +kernel.org with archives available at https://lore.kernel.org/netdev/.
>  
>  Aside from subsystems like those mentioned above, all network-related
>  Linux development (i.e. RFC, review, comments, etc.) takes place on
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 66029999b587..f310f2f36666 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -119,10 +119,10 @@ web, point to it.
>  
>  When linking to mailing list archives, preferably use the lore.kernel.org
>  message archiver service. To create the link URL, use the contents of the
> -``Message-Id`` header of the message without the surrounding angle brackets.
> +``Message-ID`` header of the message without the surrounding angle brackets.
>  For example::
>  
> -    Link: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
> +    Link: https://lore.kernel.org/30th.anniversary.repost@klaava.Helsinki.FI
>  
>  Please check the link to make sure that it is actually working and points
>  to the relevant message.
> @@ -243,11 +243,9 @@ linux-kernel@vger.kernel.org should be used by default for all patches, but the
>  volume on that list has caused a number of developers to tune it out.  Please
>  do not spam unrelated lists and unrelated people, though.
>  
> -Many kernel-related lists are hosted on vger.kernel.org; you can find a
> -list of them at http://vger.kernel.org/vger-lists.html.  There are
> -kernel-related lists hosted elsewhere as well, though.
> -
> -Do not send more than 15 patches at once to the vger mailing lists!!!
> +Many kernel-related lists are hosted at kernel.org; you can find a list
> +of them at https://subspace.kernel.org.  There are kernel-related lists
> +hosted elsewhere as well, though.
>  
>  Linus Torvalds is the final arbiter of all changes accepted into the
>  Linux kernel.  His e-mail address is <torvalds@linux-foundation.org>.
> @@ -866,9 +864,6 @@ Greg Kroah-Hartman, "How to piss off a kernel subsystem maintainer".
>  
>    <http://www.kroah.com/log/linux/maintainer-06.html>
>  
> -NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!
> -  <https://lore.kernel.org/r/20050711.125305.08322243.davem@davemloft.net>
> -
>  Kernel Documentation/process/coding-style.rst
>  
>  Linus Torvalds's mail on the canonical patch format:
>

Thanks,
Carlos


