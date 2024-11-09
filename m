Return-Path: <netdev+bounces-143535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569589C2E79
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 17:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A5A282732
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 16:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB6619D082;
	Sat,  9 Nov 2024 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="BlZP/Cc3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C045146A71
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731169652; cv=none; b=Vvb1CZDeSbt751k/rc6sSpNCmVDTaOw9goyNviuvLP0wsZ/FeF24kfSRiP6jW6w3e1Ao1AUeJwZvvZgwWC2tsHjqnA+syAv4TP6P2TpVDn6SekURFq1f7Kft7kDipszE/0ANQZKTpdZ7G+2vQCLiQOZkiu8h9G/WwEynGHWsPGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731169652; c=relaxed/simple;
	bh=WZzrxyimjWciWISaxFsmtsOekAeVLezIfgaSDyweimI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7g6QLpVAI14X9TDFMt3c+JX2/tsEVG8gXtoCedhdjRAC5T5BPsMV48QclDDVJ9eqH4mxdwPz/LmseRmLS4h5rhghdpx66KJ/qlXnl2cPtlxwKWtAZoOjLSICwW8ZL4/qaIu6FqfoGsvQRnKhbxIRe+KYe5XH1qrFBqTQbZYH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=BlZP/Cc3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cb47387ceso34585545ad.1
        for <netdev@vger.kernel.org>; Sat, 09 Nov 2024 08:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1731169649; x=1731774449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udRqs/iTfP7vusxv5DMs8DstYroHU1Mrt42xjhPxN2Y=;
        b=BlZP/Cc3zbjHkJdlyK+HT94LhiNrUgcQHuiTRsumKliRQmCRRDZLBtai857qBP055p
         wnVIuEde0Dd9s8Vn1ttuBeCXnmWZ7xTEdmaBRjtX+QJOuEGSPbabq2demh0jaF9RaFSv
         JacHBc09Ht7IMpyPCbSsp55La8Kgar8FXbWaP10Kg8Td+O4pfOHxnKCVtOzDkQm3VlxA
         d0UmYW6I50PAjcuHRJ3AAPw8kuxDpcmpK9KLn4TkHdg34FNcO0RZKJQREo6pPxddGKOd
         z6i4CIiM/eFI1vANvFFKWB7ebOQ1bLWtYg4kWsccKtPS4h0fyRWuwV7DaIXdoAUZMEKv
         L7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731169649; x=1731774449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udRqs/iTfP7vusxv5DMs8DstYroHU1Mrt42xjhPxN2Y=;
        b=gGsdEeHQQssz+DMcR36U2Yr59DCXcdDihZ950/uEWQRsgzlA8BUjWG+yjqUqBE07Zt
         XiPu7MOEiEzLlUKGPlqarkWQ1TlUoNJ3KxULNzhL+LAY/8oA3He4lETfwnE8mAw0BS/Z
         7ACNCZwTwr4UmvDDJ2nqQnYK3a3U5gfP0yXRl4C9Ovq0cRZz8N5Kh5fe8ejno/P4G8hW
         /M7j++cjMDum75xt4G05qxpsNloKvdonOWoE6ve28yYrZwbNt/0gNNAXvk0tQpbyKb8U
         tQ6csoJW4PHT7tBBYVrJqdGH8SDOaBszdWKCB3szBDxr5byg/01923rrkCrU7op8ICoR
         HLUA==
X-Forwarded-Encrypted: i=1; AJvYcCXz9/M4SQsMV8G1Q13zCrChB3PdSNnSbBX6s4FkPVjFI5g0nzJUIWYUD3h6cNlpTF0KkNgQ6TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzroVfKctI/9galDwW5Fv2UR1utzJzbn3incDDc9PRGjDBmDFDB
	VsdRsrlt7CgOyZO7jHr/trQHk9spTir6RBm+4l+ZqetZSjkAPJy0X+WpZNeMsBSBiHhGNIPL1sB
	C
X-Google-Smtp-Source: AGHT+IHsYrwMexcU/Cq3dysUbeGuH/SNVtaVVp8Oclii6GFudzZ6IT+ZP6rTkw2ZpgpLcGo/Gp+mqA==
X-Received: by 2002:a17:903:24e:b0:20c:e8df:2516 with SMTP id d9443c01a7336-2118359c161mr74281765ad.42.1731169649619;
        Sat, 09 Nov 2024 08:27:29 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc804esm48525625ad.31.2024.11.09.08.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 08:27:29 -0800 (PST)
Date: Sat, 9 Nov 2024 08:27:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: linux-man@vger.kernel.org, mtk.manpages@gmail.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH] rtnetlink.7: Document struct ifa_cacheinfo
Message-ID: <20241109082727.40ed6f74@hermes.local>
In-Reply-To: <20241105041507.1292595-1-alexhenrie24@gmail.com>
References: <20241105041507.1292595-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Nov 2024 21:14:20 -0700
Alex Henrie <alexhenrie24@gmail.com> wrote:

> struct ifa_cacheinfo contains the address's creation time, update time,
> preferred lifetime, and valid lifetime. See
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/if_addr.h?h=v6.11#n60
> 
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  man/man7/rtnetlink.7 | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/man/man7/rtnetlink.7 b/man/man7/rtnetlink.7
> index 86ed459bb..b05654315 100644
> --- a/man/man7/rtnetlink.7
> +++ b/man/man7/rtnetlink.7
> @@ -176,7 +176,15 @@ IFA_BROADCAST:raw protocol address:broadcast address
>  IFA_ANYCAST:raw protocol address:anycast address
>  IFA_CACHEINFO:struct ifa_cacheinfo:Address information
>  .TE
> -.\" FIXME Document struct ifa_cacheinfo
> +.IP
> +.EX
> +struct ifa_cacheinfo {
> +    __u32 ifa_prefered; /* Preferred lifetime in seconds, -1 = forever */
> +    __u32 ifa_valid;    /* Valid lifetime in seconds, -1 = forever */
> +    __u32 cstamp;       /* Creation timestamp in hundredths of seconds */
> +    __u32 tstamp;       /* Update timestamp in hundredths of seconds */
> +};
> +.EE
>  .TP
>  .B RTM_NEWROUTE
>  .TQ

This is for man pages, not iproute2. Resetting in patchwork

