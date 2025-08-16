Return-Path: <netdev+bounces-214317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D76B28F67
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 18:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A71B1B62CBC
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 16:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C422980DB;
	Sat, 16 Aug 2025 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="fUKtGtTA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA63A1F8ADD
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755361260; cv=none; b=gm/xfqeBNy+WPdO3He6V8XVF7lp9MIeL9xhMqkSotZ6Gd4aR81BMxa02e/BhE91EJ9WQPHiCl1cWzZfHTSwwYUNIe+oiO+8dA8AWhXZ4xOTbpsRCGR0uKv9HGBrlraNNlnD45De2YTcMAwjPPnQAyH/jiwkM2QPZWyY3zO2+bnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755361260; c=relaxed/simple;
	bh=QIQyVqvGPcDps6iIwEyiu67tal0bJZVozwf33kMwlww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mr7NlSgTKyKzCqVfRAdgmlSdDOyZJe4kkfpr2H+j8BU4fFHWHv4eqpQADQiAjZg63Nw5yojdS47dEfL4AKr4xzBmk4+JmkBR7QGRXdGWYzKtjvIKyEqVC/NNnc/C0K21iiSKWeYviVA74LAEQojTeTAC2Vxi/iaxJsk8CKQsbgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=fUKtGtTA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9e413a219so2370021f8f.3
        for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 09:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755361256; x=1755966056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAW99pktxnORz2JMcW6AE4MbCE1J5F4f+hfGP6yT0pI=;
        b=fUKtGtTAyriyRABKahKsgAkJaBvpP+esEAyCE/DA9jM98S4CAbRyUSGBPkrORcYjjJ
         dLW9gghvOVIoWobIf5KpufhHnRWS1OuYGS+AA4XAyGpMaNxjhtylmc9dSiJkNa3J/rZY
         GlLOmDk3AwNIDO5weMtO4YB3URR/RM7s2jOtuOdta4Km2qqGEbWEazbLbm3i7WaMAoWM
         VlE8Gg7uYAX/CLNWDRPaq0denvKuFJQV4qkDCT7jAAUqoPqyGjQ3bi9Gbed8u9/+1gfV
         y0K5F6fdH7jy12kNnwtpGNavJaGMeBR3ixsjCVULFyEUlAPJ2iFOsfgG6Se4DccY3z1D
         Sv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755361256; x=1755966056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAW99pktxnORz2JMcW6AE4MbCE1J5F4f+hfGP6yT0pI=;
        b=oeIn/EM7y/dlYoE9Y+HdFOoRlUF/IwK0oAnLsD6E2Tmykvfn6DBsUxECa3HMtXUDSD
         slR1u/pFfyK2eQ2Zll9waXk0J0p3kdKuWrdajF+TQnrAhWcARpxzGipEDG1JAS4pRP1u
         0uwdR7hX+swa/3K9ZSpkSKnTOMPn32K43smbbTkm5ypOvsfs7Wuswdybj5Dbz6IlEu0v
         SoUWaj5QPbgVn1UDoXWeS7eeTlXCtdz+69HwQemkKtCJHzeqBhSoa5agy2c/PBB18/Q2
         8usACMHkxVpPBHGRCWgPzbC8JLn9Un+fCsxB0LGdr7rP2VMUGyDbj6d//6U50AALu/mZ
         cWcg==
X-Gm-Message-State: AOJu0YzqGp3tiWXisZaqC7OaRDHPu7F/kvgW8F1YVvQnMMJLTR1KRA/T
	hCHETtoBQ9C1LPg2GqoDOrYULopGkrmBV92gIFNY7KkSggk8THk+7sMMTKOz+S4CCRw=
X-Gm-Gg: ASbGncteBlfccoG1TVd+9K+q1GVVVcB9eJ4RlX7odRs3H8BnHbV2lEQREyqEdeBhiS9
	imAzHCuqYLcTirMpWurL7ipdqxMdymPUNMndDdhjnjiOfFzSXrcqqOFru4dFD2UExU6ovfCw+Ix
	9L8+S/H+m/Rpr83+ngrWEznlI/k4VcY774QDlhXJYKQaae4jstfDHX0PdYjrIR8mv2mMyY5eBzZ
	BguHVlo96vSlvUzrhg1GoWe/8mPYLOZS0+J6kAtzJ/b2bKROK2Cf/7eEoi5NqH6HX6NifPPfIVG
	tq87RdSFgfwOx8VQspxGVlS/SieKkNPQfl7u2paLcrxrb1wTwNFqCxDF/uebfXT1Hx3bKQPa5vH
	Hyagy4H1h6XKaS0ND86NH+xx1KOEslsZCTFn/vQYrA+PWcL5gONLiCAnehEVrTWzixLoLz93Isq
	E=
X-Google-Smtp-Source: AGHT+IFIdLm/8s6uFqTKjY1SIvUTTq6eT0IObfEJpq371TF19ellWY9RGpF2V/ATCR8bWiT//jgWbw==
X-Received: by 2002:a05:6000:3110:b0:3b8:d69b:93b with SMTP id ffacd0b85a97d-3bb69c71c8cmr4696818f8f.52.1755361255973;
        Sat, 16 Aug 2025 09:20:55 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64758436sm6326160f8f.1.2025.08.16.09.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 09:20:55 -0700 (PDT)
Date: Sat, 16 Aug 2025 09:20:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mrinmoy Ghosh <mrghosh@cisco.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
 mrinmoy_g@hotmail.com, Mike Mallin <mmallin@cisco.com>, Patrice Brissette
 <pbrisset@cisco.com>
Subject: Re: [PATCH iproute2] bridge:fdb: Protocol field in bridge fdb
Message-ID: <20250816092051.1a8e4ed3@hermes.local>
In-Reply-To: <20250816031145.1153429-1-mrghosh@cisco.com>
References: <20250816031145.1153429-1-mrghosh@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Aug 2025 03:11:45 +0000
Mrinmoy Ghosh <mrghosh@cisco.com> wrote:

> diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
> index 085bb139..1ff9dbee 100644
> --- a/include/uapi/linux/rtnetlink.h
> +++ b/include/uapi/linux/rtnetlink.h
> @@ -314,6 +314,7 @@ enum {
>  #define RTPROT_OSPF		188	/* OSPF Routes */
>  #define RTPROT_RIP		189	/* RIP Routes */
>  #define RTPROT_EIGRP		192	/* EIGRP Routes */
> +#define RTPROT_HW		193	/* HW Generated Routes */
>  
>  /* rtm_scope
>  
> diff --git a/lib/rt_names.c b/lib/rt_names.c
> index 7dc194b1..b9bc1b50 100644
> --- a/lib/rt_names.c
> +++ b/lib/rt_names.c
> @@ -148,6 +148,7 @@ static char *rtnl_rtprot_tab[256] = {
>  	[RTPROT_OSPF]	    = "ospf",
>  	[RTPROT_RIP]	    = "rip",
>  	[RTPROT_EIGRP]	    = "eigrp",
> +	[RTPROT_HW]	    = "hw",
>  };
>  
>  struct tabhash {

This is iproute2-next material.

Where is the kernel patch for this?
Iproute headers are synced from kernel headers.

If you add new RTPROT entry also need new line into etc/iproute2/rt_protos



