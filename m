Return-Path: <netdev+bounces-228489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E62FBCC593
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 11:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CCCC4E1449
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D7A202976;
	Fri, 10 Oct 2025 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5P0z8Ne"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F64D1E1A17
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760088659; cv=none; b=DFQCQlaKBJDE+1GAgo9cQ1UmfNwfVwEXrL3bhws11se37vE39HyLHEvk6fIgQxTUJjonOsrPTke80a+DOJXCGUCdN6LOvdalmifav8lp1bC7A6Q/EGe0TK/LKF2qWJZkItlmgvcPMU9iNyWOIqzO3/Gj1oK2vfXCI60c8P1IjDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760088659; c=relaxed/simple;
	bh=4/XrG5PFmpmGq5nwHCDDNxEsjc4lGUshvcIpVr75m1g=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=TqpZA5dCuiyp0olgkQmJUSAeKZLEAiVzUwYAPBKDtk0en7JJ5AtgqV8cRDHSKFKRRSlKPesaJErhNXI5P0Okcv4eIyEURRcXt0IVsXoVzs7gltAMIV8d/4ZZNwCrpVMJwTn2ad/aK7sXFLYfBH4VWAC3YejVjU/QDfREoaQX/tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5P0z8Ne; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso1344172f8f.1
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 02:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760088655; x=1760693455; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TFJ6old9nUlBmY/4fR9bSen5WXePWEpLvyE08+MYzgM=;
        b=D5P0z8NeOwhC+ncd3ADAQMH+fV3tqJqCF0Mg/gDI/fD+fzpKH1LE3UK6yIwtDbSS+b
         1fdoih6cGfObO/zb6qJ0ikLnar5QH+zuBQnMYzRrk6WpJIf6U+1iwZhkKno4k8yfh4n8
         sAwL8wAFPvOIl0nwmT2jNyHTaSpwxjGBvfbnzMxKxmcpNDoe3Ob+jklSssXBU9Fk63ek
         5+/0RusTFnnDakOwrblB6SS8hxhp/XhQCT9ITTz7CHBbu2bFfjp4RkofJslJvbYLyqtq
         v7928ndWsRRQrHegEAJ6q3fnInnY2FxI6nLrwiwGkj/skE7m/6UsPqjqG6TDR4tK8Iwu
         /Nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760088655; x=1760693455;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFJ6old9nUlBmY/4fR9bSen5WXePWEpLvyE08+MYzgM=;
        b=p39OTVAiAT/KA0TXPS9nXqXZa1WwUr5bvjLNZg+mgo7sehl5zHEt7Mz4NNfT56Zf6s
         /q/c1V5xXErx23RntAbqKjVIfpD3QRclbU6tYDW2Bx/TqKDWFL/Lfkvs2mzHbTmjssr3
         nbi95MdIxjugeustjHLx+AdkzfJPqieXKKqh01ZwHr4TvPMmAIrf+zA6MYQWr7kw4lYa
         MSgQKS+t7tDETtwVRlJ00AVN+NiHCtLO7cmyKAglmHgUYG4D/QhlAb9G2MUX8PBgsQk7
         u7m4gHAS2mgP7+DcDdFfhLbU8hVwC4Ll1J7MeLLhhEuqbKJ/Cpb3iiBihJpw5JmCevQT
         mHKg==
X-Forwarded-Encrypted: i=1; AJvYcCVGe/pYdqjCo76v/df/yyQ5R6Ho/I1/B+9FCoU+gzD0TBry87Oav2Zfyfc3nPmJeg2qx5Oi7EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwuTd7mA/jVRDr2oC6DyEAAfI6DPga6q5x0yGHcwZ9MYneMwe7
	gU/JCnWgR1LIzYU2Oh6tkESOZ8Fx1m+qKQjkROtJOtVye4HLahcoid2EsvxM9EbN
X-Gm-Gg: ASbGncusS3kRPcn6oxAngqiS1HNc0YNb7Kyrth8l9iBurxddeGwUZoZFCDUgIib/wzA
	766VtfFdMGVoS1V5EJIb06zW5af4y4ZtCS5SlPWfY0xfUuca4TtK90ETlB3tXBVtDn1/qnPIYD+
	5oidCLmUAu2M4vX5EUys7VEtjQYmKfYnPfs9vI1xvXeIlxtAFAt+g5CUflhuuxIb3eJgQClBZNH
	/D47S8xV4Atul8nzpYPfp/5cNi47PTMLv0HoHzIaWdyvloEyiApwFKFLFMX4vuE+Og0Vqby856u
	dlqu/TvPUrVWcekKo4wSqSa1Ok6zNHQuGuWHEj6vCnNzBpMagleD76YneTBIp6p80R6yGajjFEJ
	nS+5iY5+EVmf92WB+YKAhCGHL79QR00dz9Y2nLuEA2aXSVxTlYDGxET4t+NE07F01
X-Google-Smtp-Source: AGHT+IFt1xQ74S5Ke1UQseKyET1bLEGVp+DpW6Ffi8A4nhrpaTuLG8N5bOYRpVweYCjrPKJn0DiHug==
X-Received: by 2002:a5d:5f54:0:b0:3ee:1586:6c73 with SMTP id ffacd0b85a97d-42667177de1mr6757870f8f.19.1760088655365;
        Fri, 10 Oct 2025 02:30:55 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:38af:2eee:bf04:9187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489ad27sm38636895e9.15.2025.10.10.02.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 02:30:54 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  netdev@vger.kernel.org
Subject: Re: [PATCH] doc/netlink: Expand nftables specificaion
In-Reply-To: <20251009203324.1444367-1-one-d-wide@protonmail.com>
Date: Fri, 10 Oct 2025 10:21:23 +0100
Message-ID: <m2v7knqfho.fsf@gmail.com>
References: <20251002184950.1033210-1-one-d-wide@protonmail.com>
	<20251009203324.1444367-1-one-d-wide@protonmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Remy D. Farley" <one-d-wide@protonmail.com> writes:

> Getting out some changes I've accumulated while making nftables to work with
> Rust netlink-bindings. Hopefully, this will be useful upstream.
>
> This patch:
>
> - Fills out missing attributes in operations.
> - Adds missing annotations: dump ops, byte-order, checks.
> - Adds some missing sub-options (and their associated attributes).
> - Adds (copying over) documentation for some attributes/enum members.
> - Adds "getcompat" operation.
> - Adds max check in netlink-raw specification (suggested by Donald Hunter).
>
> Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>

Hi Remy,

Is this v3? It should say v3 in the subject and it should contain a list
of the changes since v2 and v1. It's hard for reviewers to follow what
is going on otherwise.

https://docs.kernel.org/process/submitting-patches.html#commentary

> On Friday, October 3rd, 2025 at 9:04 PM, Jakub Kicinski <kuba@kernel.org> wrote:
>> Please don't send a reply in a previous thread and 4 min later a new
>> version of the patch :(

You did it again, reply and new patch minutes apart. The commentary in
the reply could instead have been in the changelog of this patch.

> ---
>  Documentation/netlink/netlink-raw.yaml    |  11 +-
>  Documentation/netlink/specs/nftables.yaml | 656 ++++++++++++++++++++--
>  2 files changed, 617 insertions(+), 50 deletions(-)

I think this should a 2 patch series since the schema update is a
logical change that is independent of the nftables.yaml changes.

Also, net-next is closed until Oct 13 so you should resubmit when net-next
is open again.

https://netdev.bots.linux.dev/net-next.html

I will review the rest of the nftables.yaml changes in the meantime.

Thanks,
Donald.

