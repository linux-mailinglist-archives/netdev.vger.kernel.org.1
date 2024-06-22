Return-Path: <netdev+bounces-105887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C689135F2
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 22:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1581F224D9
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 20:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9B357CBC;
	Sat, 22 Jun 2024 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1GrBgMc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230BE26AF0;
	Sat, 22 Jun 2024 20:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719087048; cv=none; b=FRYXJJDFQT/2Sec9MemlLI5HrJKyTd3sa5+2MClvoEyoawStyy2u5bjcogg099dqkqmTKLyL8sB8elY0nom5EMPVq9lSkOF9nBjJ5mNBtMrL5QtVqYMV5kWTVjmk93Y5lSltrpH5JNXlsUrLsMk0v52FVZqn3Q1EiYPCJPInM84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719087048; c=relaxed/simple;
	bh=fwmdlWbIiXExgoJhGW10urHmbfOMiDt8yk/9TNg0xVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpvxoywEvQPygPV0WEFF9skNix5fczViPr5yKcvS51+yzTogpgXYcmxkwZmb3W20HhwpyfR6R+YQ3dfyna6qGSRlqZQeB0BdXSsh1y7GGeCONVlFXmXO3PX5eyZ9tIabLFYSkHQFfdCWQ0t0Ng8PXAojj6fTIAXE3EejJVLCwnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1GrBgMc; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d21b3da741so1657713b6e.2;
        Sat, 22 Jun 2024 13:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719087046; x=1719691846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Cp87DnzZ8ubh+P4vugkHALA0amyLWY1eDfV3e8BFDc=;
        b=h1GrBgMc+b30DdktYUQTG6+C/06Ub/j/niK/tW/D30fsPlZJr3FkZQCnOxcV8CSeNL
         xznr38vpoTalRG3uw3RyVEZ7iPvXMX1IAnXytniqgv6O+laczbhygFC9C5ugsCfuZkj6
         w8GACrgvoW9HJ4LqYWtQCu+MeLiYtMXatqntKBuGGdCVSeba1Tf6AIkncRiMnB/ENN5i
         WtdstDpfpoXqEAuMYbmVFl4eJ4rtsaz+S5xIOPTpqR/mAMyn0xmLOFev/MH7QC+uFV/H
         LfxCP+D+29+RjyTtDvkg4xtVnyiBZUF+75rgYO88TN6OZEByTgEiV8eAQinAPIAOAHMm
         hZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719087046; x=1719691846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Cp87DnzZ8ubh+P4vugkHALA0amyLWY1eDfV3e8BFDc=;
        b=Vw/HCIl8LBUdxlJYQqlQKhx7OTr4AukPqY/nMCh/1LWkJuFeKftMJu6cvOSymNALld
         xu7EhEGayDzF1J2CkfyjFWi4zcujL00ZMPocsGwngdItVRQFGzovw5z5Sc3QcKT7Lhak
         F4Fdkdk8YrfGhXxvODpWYeqRgNU9FlqkLospj5VY97KVdosBFxbOwSYk2yfgO22IJJY6
         GLgKuUDBKOMOuexh03ajZXv8aXTZEQ3yTafZDyGPYIZGIcRL8WgA2cwIfe1p1eekPUva
         i6QbIMCXS2oTy7uRHdd402UNUMjIbM7Fon+0ZUiQCxD9CX6hrLRib44tVlzJsU74tNaz
         gwKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/89+yJGKY3zY3UIp11v5TcxNKYWIrYLHd3bDQALlvvKOYOSQ3YLG1M2Zd/gyPW5zvgNS3Dwj6O5GFFdilF2RoI0oOZeCYEM69/TzjWYpzVwJ2o49qvH3+/v2ju9eNUw318mktHoz42Pf/SBxr2aSDiDX5K/xaFzaq+NFnX7qF
X-Gm-Message-State: AOJu0YzCpm7A/gZbx+YZjcTE5f0mlWQSTru1caaKX+pKXCDUfm7F8L0m
	B7uKPOT3zz9AayLL5Md/AUYoOYffOm5KEa5i7mtzBySd1F0mOtEElAQptC8Z
X-Google-Smtp-Source: AGHT+IE4IvNVJ2jnOFTUyi+tw9zD7x6mlnie3P5tbq7r4wwQymw1PqhvbVkDZd7gts09MtoxOns5cQ==
X-Received: by 2002:a05:6808:1a1e:b0:3d5:1bd8:ab17 with SMTP id 5614622812f47-3d5459b4aa5mr1034519b6e.27.1719087045248;
        Sat, 22 Jun 2024 13:10:45 -0700 (PDT)
Received: from ?IPV6:2603:8080:2300:de:3d70:f8:6869:93de? ([2603:8080:2300:de:3d70:f8:6869:93de])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d5344fa290sm810713b6e.14.2024.06.22.13.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 13:10:44 -0700 (PDT)
Message-ID: <28e229d9-253a-4c83-a0f8-09da8a9bf78d@gmail.com>
Date: Sat, 22 Jun 2024 15:10:43 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Documentation: best practices for using Link trailers
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ksummit@lists.linux.dev
References: <20240618-docs-patch-msgid-link-v1-0-30555f3f5ad4@linuxfoundation.org>
 <20240618-docs-patch-msgid-link-v1-2-30555f3f5ad4@linuxfoundation.org>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20240618-docs-patch-msgid-link-v1-2-30555f3f5ad4@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/18/24 11:42, Konstantin Ryabitsev wrote:

> Based on multiple conversations, most recently on the ksummit mailing
> list [1], add some best practices for using the Link trailer, such as:
>
> - how to use markdown-like bracketed numbers in the commit message to
> indicate the corresponding link
> - when to use lore.kernel.org vs patch.msgid.link domains
>
> Cc: ksummit@lists.linux.dev
> Link: https://lore.kernel.org/20240617-arboreal-industrious-hedgehog-5b84ae@meerkat # [1]
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>


Nice! 

Acked-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>


> ---
>  Documentation/process/maintainer-tip.rst | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
> index 64739968afa6..57ffa553c21e 100644
> --- a/Documentation/process/maintainer-tip.rst
> +++ b/Documentation/process/maintainer-tip.rst
> @@ -375,14 +375,26 @@ following tag ordering scheme:
>     For referring to an email on LKML or other kernel mailing lists,
>     please use the lore.kernel.org redirector URL::
>  
> -     https://lore.kernel.org/r/email-message@id
> +     Link: https://lore.kernel.org/email-message@id
>  
> -   The kernel.org redirector is considered a stable URL, unlike other email
> -   archives.
> +   This URL should be used when referring to relevant mailing list
> +   resources, related patch sets, or other notable discussion threads.
> +   A convenient way to associate Link trailers with the accompanying
> +   message is to use markdown-like bracketed notation, for example::
>  
> -   Maintainers will add a Link tag referencing the email of the patch
> -   submission when they apply a patch to the tip tree. This tag is useful
> -   for later reference and is also used for commit notifications.
> +     A similar approach was attempted before as part of a different
> +     effort [1], but the initial implementation caused too many
> +     regressions [2], so it was backed out and reimplemented.
> +
> +     Link: https://lore.kernel.org/some-msgid@here # [1]
> +     Link: https://bugzilla.example.org/bug/12345  # [2]
> +
> +   When using the ``Link:`` trailer to indicate the provenance of the
> +   patch, you should use the dedicated ``patch.msgid.link`` domain. This
> +   makes it possible for automated tooling to establish which link leads
> +   to the original patch submission. For example::
> +
> +     Link: https://patch.msgid.link/patch-source-msgid@here
>  
>  Please do not use combined tags, e.g. ``Reported-and-tested-by``, as
>  they just complicate automated extraction of tags.


Thanks,
Carlos


