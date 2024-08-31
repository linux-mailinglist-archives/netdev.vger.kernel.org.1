Return-Path: <netdev+bounces-123917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4A1966D84
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 02:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4161F238D1
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 00:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B9F1D1319;
	Sat, 31 Aug 2024 00:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AbpOMhUU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48B91D12F1
	for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 00:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725064064; cv=none; b=JnqNGyo2pOjszafFZE3Fo14DpzkwZE2Y9DX0kqpBSm1gazY2EpDHhK8l602qwoMl2S5eb7Lq3lcsx8NV6S2jkMphBH9JN+98Af9P3BT4Gq0VIFR8bH6yZ5stkkAi7NqSrzenDX7nec4IGV/GwaEOnv93s9fbWYyl+cl5zkTny9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725064064; c=relaxed/simple;
	bh=XD3UyF4ucxrrGn8yBNqldCRojcXGYf4CpHbfttEnyAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljRLRNgD7otOkoWHxT9cgl9h01V5KB0vy4lIHHtuSoQBf5Pd9D1DqbXSN5cQnNeNkPkUuYiX+bgscQSjneL1owlGqIPdhLFCVfeR0rnuXFOePGAJ5lDvpkC5nvkn5pLKfmfY3SdX0rt9bWMNTmtTXO66LpNsOIsZHWFXR37+N2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AbpOMhUU; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53346132348so3056260e87.2
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 17:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725064061; x=1725668861; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XD3UyF4ucxrrGn8yBNqldCRojcXGYf4CpHbfttEnyAY=;
        b=AbpOMhUUegX2EcqsJ3JxBIpYCZuhLtZ0NLR+etl6WyryT4D5J45KY/RMPVXJL+k3ZE
         8YGL19NGuEoL/X+dssnpXRGUZ1TZbHXnekEYz/JltdyCvnbk88pzTIJdVTEYusmexGeR
         TAtgyln+Xcnp6/gfXlHVZ+SBIT3kPf05nIujJ8oIAJyOr8IvQJOPmxUUwlSZTcYuMjr/
         xKO+umanB6yzWHkACqpdRlg0dQkreRNXEJhVVyphkKP152tpoXTyhJBd9Eqxj+21Ssx4
         /Tr7gaYrKdNJ8WtsHQB/NxFZSPdfSHmGDmUVyxXyvQz8zoyG7aCNh7uQOPTom7a0jFD6
         WpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725064061; x=1725668861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XD3UyF4ucxrrGn8yBNqldCRojcXGYf4CpHbfttEnyAY=;
        b=dDvQ4y+R+3u3sMpFovvXpgUbAK1tRTB4UvDptnEtJF1UMX6jqu3Czm2ozZx74F2tuM
         rdqlt4QYyXoC4DOnIMfU0NTI4wJFLPMRl/tDJNb1/b9qg9URp8gR9sWGr2zr2D+vf2Ft
         0TfKSW8C+PSDSFcbJI27mlyR9r7RD+EzHf4caUBBeSqQmN6ygVY2rjjE0RPA0d9dTCko
         8KHSzhfoxvIv3m24lDXiWtv2B3yLzP397DHO8FORyCQwURRDVlSvMmrvVOmqG63swieR
         VTyyaCdxO7vSLy89hHeKdWE3DsDe/B+D8CRtYnen/UsSOfSzY0G8nP8/4Q5rVfdGXj3s
         YYqA==
X-Forwarded-Encrypted: i=1; AJvYcCXFz1Fk8vJORqg3bOgo4lVeJgH/wfoukh7irPCaXF2gINqAr4oryAWP0D7Bd6c0bP96GREEhhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNv34jJjwCFDrCaE346JnqHx76YWaL9JYJfOLJXORSBFVcbQIh
	84W5OB5d8+/Wbj/BfpAUuiTorq8Nm4WpOQVBEWkGGKl9ryQ+0LaLye8gW08nR2ExZef0UChElCw
	629K5e7hLhU73pE1isp09QGOwke+Txj1M3Twfe2ETIIu4FfjPZcYG6cQ=
X-Google-Smtp-Source: AGHT+IHc0rl9VeSL57YdWlFMwEoLeCzgfejvX4SXrv0nrsPMFUsNQkWzfq4zXN4o37PcuYMD0LKESoOuVnjj3KPhXlI=
X-Received: by 2002:a05:6512:ba7:b0:52f:c24b:1767 with SMTP id
 2adb3069b0e04-53546aff12cmr2552441e87.19.1725064060067; Fri, 30 Aug 2024
 17:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822200252.472298-1-wangfe@google.com> <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240828112619.GA8373@unreal> <CADsK2K-mnrz8TV-8-BvBU0U9DDzJhZF2GGM22vgA6GMpvK556w@mail.gmail.com>
 <20240829103846.GE26654@unreal> <CADsK2K8KqJThB3pkz7oAZT_4yXgy8v89TK83W50KaR-VSSKjOg@mail.gmail.com>
 <20240830143051.GA4000@unreal>
In-Reply-To: <20240830143051.GA4000@unreal>
From: Feng Wang <wangfe@google.com>
Date: Fri, 30 Aug 2024 17:27:29 -0700
Message-ID: <CADsK2K8+sEGwLSX_Q2nxcOosbGFFKjfKb2ffRXK2E1sp_Fbd+Q@mail.gmail.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
To: Leon Romanovsky <leon@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, 
	antony.antony@secunet.com
Content-Type: text/plain; charset="UTF-8"

Hi Leon,

I believe you are right about the mlx5e_ipsec_feature_check function.
And it shows that the driver can indeed make use of the SA
information. Similarly, in packet offload mode, drivers can
potentially leverage this information for their own purposes. The
patch is designed to be non-intrusive, so drivers that don't utilize
this information won't be affected in any way.

I'm also curious about why the mlx driver doesn't seem to use the XFRM
interface ID in the same way that xfrm_policy_match() does.
https://elixir.bootlin.com/linux/v6.10.7/source/net/xfrm/xfrm_policy.c#L1993
This ID is critical in scenarios with multiple IPsec tunnels, where
source and destination addresses alone might not be sufficient to
identify the correct security policy. Perhaps there's a specific
reason or design choice behind this in the mlx driver?

Thank you once again for your valuable insights and collaboration.

Feng

