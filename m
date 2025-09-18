Return-Path: <netdev+bounces-224235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B637B82ACF
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 04:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31F91C07388
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 02:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7AF2264B6;
	Thu, 18 Sep 2025 02:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clyQyUL6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971EA23958C
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 02:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758163509; cv=none; b=fmJR5py6kXe5kE3GZkrAvsXG0kczXrm8BprOSE6V8dTAY/tdguVPbkYAXWFau1UP/qQJcKYcNWpNzSzRh8fbBNN1hZNSPR5Q86OeKKj2a9Xo50kBJHTBzLljZj/UYCyz8QFf1MK/tl0bdT1DuhzcqWik6whrF9SiitvSVnYD2Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758163509; c=relaxed/simple;
	bh=u36eOn2Sk4m7nqh1JUSmjhiKmc25S+UJGskBcZXSj7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpWc4QmRWlLNWsZDxnq3Dk3ZctZMtFNN7q+BJ/XAJtN42MtRHFbTpj2WP//gaGv02xJhj9gTFf8WoHJjrcZEGVjmejZv87rRBSdBPVZ8JabwDUz3zfJsDhoulDzfoMV+RidFwYjfSzVIQvtLQWtWr9X/lg0MgLFZmZ3EWHBdQgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clyQyUL6; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-424144fb09cso2429765ab.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 19:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758163506; x=1758768306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tn1IQOhKemkK5wNJBb6Rec4gvENvC25HHxI5G0VtWNM=;
        b=clyQyUL6UjZqBhXfcXlwSAE8Xz9TidtG0gqyR3ieDcsA5CeZd9J82reRchlmfMSOWj
         yrgo35RQDJdeubC13XJgsNzelYBesxQQg4JBT9a+GX8e5zDnqms0iAlJi29snxxhgaF1
         sfJ+xNaTBPkWrdmba2RiFxX9SQ0XXrQYCbtNMcNXgdyHhxIm7OvTObsxz2T3pDmdZIUg
         9wMf3MHp/Mldhi6ULEaK+kVwNLpCwW0RjuJ/p07QaKOB+jBIcLHfiTDy2XTQQtnYH4hl
         MMi1AZ0+GJr9DUP25RFMirFBoAxQmni/rVIV6JgymnvuJafVu2WPvf2YxhZ2Vhpmt75r
         qoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758163506; x=1758768306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tn1IQOhKemkK5wNJBb6Rec4gvENvC25HHxI5G0VtWNM=;
        b=nbnLXQP0TZ5AFO955u+dAPjixdkr1sAIfzQhoh8TKjV/2esooq7sAivTuSiMkbatSZ
         hA/zUeETaDU0AWu02k65K9bj22aLVV6PL5vFrk72AIdjppKHDwYzNSBLd5gdSmXKVK8w
         coYuKHhuf+11m9aqzUXoQdWNcJdHDIIZmrm6k2Q7J02nBhj6pgzCzXEah73Joic+qPtM
         t0/TbI5Jo2IDg8Xpt/rOKF6kNnGTzRJAueVbkdoRBUL6l0vpJkdgx4cTnyHDyl71HyXq
         7IpXazg33U2lquLl49I+9wnZMG/fKxicCsEVrZ0hAA8RHJWh/X+jDWF0KmKFHSbUcgBf
         Nqlg==
X-Forwarded-Encrypted: i=1; AJvYcCVZDSY4l2WDfIpqSHLPLX9G7qx0roZpMLL6cC9YjVxioZTZmlCW3tQ2dhRJ+ptmiHnUFY2P2Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF5ni3qPFQuw+10FwV93yiwKzqJfYxweirCTc/PxqNAmw259Pj
	Ozt1vc5amuGrL+oOoabJhSH98Kfcbe2LtEzOQ6+rZBsC85fFZX6Ua42oqFr/dw==
X-Gm-Gg: ASbGncv8C/CxKCUJmg2NOIAOBDZH6Hi8DiH3zmd0dCW0Ij3UrZ0B5vqs2d4HW0eRzGO
	F3jdxtddZtYdM/K/fGU7SHUpQ3uUw9jXr0Yaxz0FOXRzvS0r+hSS+2w0p+2lSq0X6ZVFml6OCA3
	tMdbt71bFMuNuSWUpo6q5fXPCHytQd2sR8McFz4mh//JPzMWLjBiJmqyZuJAOZOpMjBShzvZGug
	Kpckj+rrBNyTtE6ENN9TDXMX3vWleGFifp6B9VHi+dugOdE3P+OOh7Zs1ds9Aer/oJUcULta8Qm
	8ffY26xn35nn3j63v0I26fYBg3m4csJRTTWzEJH+59rX7PU8SMwGmTUR7prJChZrajXPnGX4edx
	s7F/bIztGKlhW2B0PgOWTIAac8aaeA+9IpjDlf5hFzHAgj/ooZWGuHc/gmoMnrLE9MToj6jb41x
	x5ot9oApSBOLMbAzG38WLxDKlLUic=
X-Google-Smtp-Source: AGHT+IEJ0xQuRJbtSZMnKRq+mA+vvMi44DO1azKypYmbCssqOBfLNZFoucSTtKwIbQWtz9aSzSt7nw==
X-Received: by 2002:a05:6e02:184e:b0:41d:5ef3:e06 with SMTP id e9e14a558f8ab-4241a4d008emr64296005ab.12.1758163506467;
        Wed, 17 Sep 2025 19:45:06 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:a8ae:235a:67f1:4523? ([2601:282:1e02:1040:a8ae:235a:67f1:4523])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-53d3a590fecsm426953173.1.2025.09.17.19.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 19:45:05 -0700 (PDT)
Message-ID: <8eba0896-3156-474e-8521-c345d6d2e11c@gmail.com>
Date: Wed, 17 Sep 2025 20:45:04 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND iproute2-next] ip/bond: add broadcast_neighbor
 support
Content-Language: en-US
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
References: <20250914070609.37292-1-tonghao@bamaicloud.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20250914070609.37292-1-tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/14/25 1:06 AM, Tonghao Zhang wrote:
> This option has no effect in modes other than 802.3ad mode.
> When this option enabled, the bond device will broadcast ARP/ND
> packets to all active slaves.
> 
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: David Ahern <dsahern@gmail.com>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> ---
> 1. no update uapi header. https://marc.info/?l=linux-netdev&m=170614774224160&w=3
> 2. the kernel patch is accpted, https://patchwork.kernel.org/project/netdevbpf/patch/84d0a044514157bb856a10b6d03a1028c4883561.1751031306.git.tonghao@bamaicloud.com/
> ---
>  ip/iplink_bond.c | 16 ++++++++++++++++

you need to update man/man8/ip-link.8.in under the bond section.



