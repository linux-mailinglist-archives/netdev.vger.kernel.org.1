Return-Path: <netdev+bounces-132378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12284991732
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 16:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8841F21685
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 14:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176291DFEF;
	Sat,  5 Oct 2024 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="XMXsH7UB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7481B960
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728137221; cv=none; b=Q0lv2zi+9fa3yA6KJKTOkBsi6pp50waHNhQpZsCZMKWOZKId2rVVIPjMiacwqfNa7WDkzyLCW1WCsKzr4ICo4Rt4j+FCq4t/ZTClipNXhvGFCQASccpEOGSPJRqmyu9mDe4DCX/0OERcbmDyN78GkPUYp//rMaXHsennXj7l2co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728137221; c=relaxed/simple;
	bh=w7hv67Bv4jGJL1OIuMDm5zDOxYIxf51jzM1/fXgu7r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flSLFoHjOi5YBgWU6fbVv+JGraVgBVfrGA/QdRiS2goZNjobVZWZx5/Q4zLG45WBctvMnnG3YTsyQ7t5irVylPKOfa1MNzTwwhacwyMcr+KEWnhSwJ0Jcx6zrF3f7k0Pp0PoMz8yvdTEl+Z7B3XPHtsAnSJKsfuxwwcXwtpEGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=XMXsH7UB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42e82f7f36aso25527135e9.0
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 07:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728137218; x=1728742018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=73RXbNvNBQEszJaut+1wcFfhljNaK/Kf2dgm13KEtRw=;
        b=XMXsH7UByCws1GjGhVTsm4xVSbrtuARNZNX+4XQnnWbHxxcjXhgITx3qX6+FltINkU
         jj8q1x2enmHTZXVkTEnjXQjAol43OjXUvWWU1zCb8urywlqWljA6JS1k4U50K5I4aVv5
         DvbRNwvsZ5Kmyocb2iktmfGem6EhNYa93ARFmPSXQG6z56BxELrMTGBjgtpoxyUNzi6o
         +P2Y0Hd/pxWM3L+3kVxYy8MozCnFXS4Z1KcZPTpu+XOY63IUWuF2WNRPi4WEJAXPAJE2
         TNATzig3ocfvOGFVpsVfwZEKxcrq/Rdkz2djJmFQRtukaL2kz772z/EH898InaB5WA3J
         ZlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728137218; x=1728742018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73RXbNvNBQEszJaut+1wcFfhljNaK/Kf2dgm13KEtRw=;
        b=Tf7adfRSVJ18oD3yKijsIodVPGxL3Fmx0x4Df5i6tv3EfPu2d7j1W03YCTKOOhc432
         J/RY+Ag0JA0KEiQ6jyi0+3qZcWWvsrgqqEAilXnjMeDtpYE2y0U4EWJd0dNLHbQptQxU
         Siew44lgw+G5R1QwLvMvN0/KsLrxfKiN0gepCHXNSK62KPeDsJKFyC7qlgk48hYW6mdm
         8sMeV7efp17Jf/NM71JJ2N3piDDrxCuf54qMlysWtw0XxnDRFLuJNvL4yd5EnABTqxGG
         SE0VdGVJ9tWRJL0RhX01/qMpc9xMqBSOIxdnt5wfgN6sqKBLCPQzaAi+YGL4DrT637ZI
         aIQg==
X-Forwarded-Encrypted: i=1; AJvYcCXM/danr6CBE1Zel2HT9ZbQ/Vb2Feql9hT0RgSuatMhT+i7G2XyQOH7/QQdOTR3CtALXbkr5Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUiyU64MZzNTj2KfcMorDpalj0Tl3e1ZGHWCxvqHTBFIzjWd8t
	RReu3eaHAtyL0GzjSX1j/gQgvUdrYNVOeXWSw8oQZ6/73ds2aA7VGxA0UuNPpVU=
X-Google-Smtp-Source: AGHT+IEop7QV/LQ0/ci7yuPRtnBcGOvevIn7tuDVlQ8/zdMwhtTaLfoE32mNc8E+fIIZYTUwqHvxHg==
X-Received: by 2002:a5d:510e:0:b0:374:af19:7992 with SMTP id ffacd0b85a97d-37d0e6f361bmr3281936f8f.7.1728137217667;
        Sat, 05 Oct 2024 07:06:57 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16920cc7sm1838947f8f.61.2024.10.05.07.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 07:06:57 -0700 (PDT)
Message-ID: <c06d9227-dcac-4131-9c2d-83dace086a5d@blackwall.org>
Date: Sat, 5 Oct 2024 17:06:56 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bridge: use promisc arg instead of skb flags
To: Amedeo Baragiola <ingamedeo@gmail.com>
Cc: Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pablo Neira Ayuso <pablo@netfilter.org>
References: <20241005014514.1541240-1-ingamedeo@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241005014514.1541240-1-ingamedeo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/10/2024 04:44, Amedeo Baragiola wrote:
> Since commit 751de2012eaf ("netfilter: br_netfilter: skip conntrack input hook for promisc packets")
> a second argument (promisc) has been added to br_pass_frame_up which
> represents whether the interface is in promiscuous mode. However,
> internally - in one remaining case - br_pass_frame_up checks the device
> flags derived from skb instead of the argument being passed in.
> This one-line changes addresses this inconsistency.
> 
> Signed-off-by: Amedeo Baragiola <ingamedeo@gmail.com>
> ---
>  net/bridge/br_input.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index ceaa5a89b947..156c18f42fa3 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -50,8 +50,7 @@ static int br_pass_frame_up(struct sk_buff *skb, bool promisc)
>  	 * packet is allowed except in promisc mode when someone
>  	 * may be running packet capture.
>  	 */
> -	if (!(brdev->flags & IFF_PROMISC) &&
> -	    !br_allowed_egress(vg, skb)) {
> +	if (!promisc && !br_allowed_egress(vg, skb)) {
>  		kfree_skb(skb);
>  		return NET_RX_DROP;
>  	}

This is subtle, but it does change behaviour when a BR_FDB_LOCAL dst
is found it will always drop the traffic after this patch (w/ promisc) if it
doesn't pass br_allowed_egress(). It would've been allowed before, but current
situation does make the patch promisc bit inconsistent, i.e. we get
there because of BR_FDB_LOCAL regardless of the promisc flag. 

Because we can have a BR_FDB_LOCAL dst and still pass up such skb because of
the flag instead of local_rcv (see br_br_handle_frame_finish()).

CCing also Pablo for a second pair of eyes and as the original patch
author. :)

Pablo WDYT?

Just FYI we definitely want to see all traffic if promisc is set, so
this patch is a no-go.

Cheers,
 Nik

