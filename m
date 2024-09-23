Return-Path: <netdev+bounces-129268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9596C97E92E
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 11:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E661F21ED9
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 09:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AD7194C6E;
	Mon, 23 Sep 2024 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9juZO1T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B8D7DA95
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085542; cv=none; b=Bp2dNFmJA4oM8yPWf5PvvTcDpPwg5BVVXUhMROoVvzgIjFnSUrFU3ooI5Y8Drgwu9lPychxjIUg92syVlt5BDbkCseQexmErKPrECXlX92aQl/CBntQeQYlzVG0AGDNsBPy2w3mPmpEScql9Eb/CRyDGV5t1Kn8/tLDTt1Am+qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085542; c=relaxed/simple;
	bh=SVnMwy/VSz/VnkPWFA6CSILV2u7xgnc3DmEYC+zGT9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I7c9vGMpGEQvlZRLdyr6tugCHMmlKIfrRFqyf74u75JSQry/Pk+ytBUK+PIFaN8qjDaYLq+CfM0HJRGdCfic9FkXHGrLbo9d3nd0Uj2PdNYf5RHLEf355i2QrFArVQq5NvRK9KNGFv+oz0xo+NXwfBZNiFyxqo9RsQsQJKh24Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9juZO1T; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so53323995e9.3
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727085539; x=1727690339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r8O2ApgBWgUCVW2L0HfzBAB9+aWmyF7u4P1EiYJoies=;
        b=A9juZO1Tiwn/ZxMVLIWDt0GKvGYdglJ0vrPkxRPafQDLoApyhEQrSyedhxWy8M3iD2
         B5VKsX8nfKlOGIpy+s2/H4pfTIOUthvIsor3cpHaGo76kx3eG5Zi2BzS2thwELvy480P
         jiW9ZA1d3axokjQSQ4/D5TklyazdLtgTCsh/x+CVlZDRuYog5mxHhd/B2mU3gMazKB5v
         PbhBlZ/8Rn2qjleCm8JED2+ejDaem4pnd6z/IYmLU3VnXsD3nnvHnPQDE6B4WgDN8Q9n
         gCKVVXk8gV2i/4pWmoFhFaXK4IvYseJ1/c2IUFLXu3IySIqAV54RLlFrLojS1t360jFB
         ih4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727085539; x=1727690339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r8O2ApgBWgUCVW2L0HfzBAB9+aWmyF7u4P1EiYJoies=;
        b=KrLOyEzdQAol6PmgVc/D18T25YySO0JJlNLOgQL/r4vQ+vt6lwGhb7XlxIuPb3s3h1
         IyrKkecj+/68w+sJbTtSUKLHVlE5fKde6LfnAkBHl5eY7Tdc9BtmxOL78oVbQYC23cGP
         agyG4eFCnX+bgzoDwvuRemhCtS3E1uYBRyf/VPH2SrA3hdHCcjOk4QdTfTf0KFvRxPKT
         dpDEsQnLTF+SlrHvTO9Rm5i5m+ejNXetJIJULN6q3K+dsRVIOZ49RUeyZUvDk+9fKvUn
         VjA15Hf78K40uJxWAPf9614l/kQ9nBzR6y1fk1ujEu2uOfv/CQoS9nND4McOBKRVLnyG
         F2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj+gwzB9xKLWgsSEjQ4/xHcYHq57wGUpCTe9LHmwJTsyqPiGGpC5eZfL27bZ5UQKIpB6fafxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUF8wMT2tvqWWySk917Z5MR7Ozh/QSvLJHfC9LqAAvzliKrgY1
	xxZUAzZZPXfzKoodIEBgZyxFatsQGs6bQTR2QsODeop5PZ+G4W5z
X-Google-Smtp-Source: AGHT+IEvd+SsgpeWnjOB0l0/MLKErawh2yDLuzyKuBdeHI6BlAygDWdNPGdVKI+NozzCljMGsKXbjw==
X-Received: by 2002:a5d:6291:0:b0:374:d07a:c136 with SMTP id ffacd0b85a97d-37a42367b04mr9553710f8f.36.1727085538914;
        Mon, 23 Sep 2024 02:58:58 -0700 (PDT)
Received: from [10.0.0.4] ([37.166.216.132])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780defdsm23813558f8f.115.2024.09.23.02.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 02:58:58 -0700 (PDT)
Message-ID: <adcec26e-7e08-41a0-afa6-943ab3c5a43e@gmail.com>
Date: Mon, 23 Sep 2024 11:58:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Adding net_device->neighbours pointers
To: Gilad Naaman <gnaaman@drivenets.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <4122BAE8-E48F-4C3B-9505-D0E033342416@drivenets.com>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <4122BAE8-E48F-4C3B-9505-D0E033342416@drivenets.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/23/24 9:46 AM, Gilad Naaman wrote:
> Hello,
>
> We're required to support a massive amount of VLANs over a single link.
> In one of the flows we tested, we set the carrier-link down, which took
> 10s of seconds. (with the rtnl_lock being held for the entire time)
>
> While profiling I realized that a significant amount of time is spent iterating
> the neighbour tables in order to flush the neighbours of the VLANs. [0]
> (~50% of 40s, for 4000 VLANs and 50K neighbours of each of IPv4/IPv6)
>
> We managed to mostly eliminate this time being spent by throwing a few more
> pointers to the mix:
>
> struct neighbour {
> - struct neighbour __rcu *next;
> + struct hlist_node __rcu list;
> + struct hlist_node __rcu dev_list;
>
>
> struct net_device {
> + struct hlist_head neighbours[NEIGH_NR_TABLES];
>
>
> The cost is that every neighbour is now 3 pointers larger,
> and that every net_device is either 3 pointers larger,
> or, if decnet is removed in the future, 2 pointers larger.
>
> In return, we are able to iterate the neighbours owned by the device,
> if they exist, instead of the entire table.
>
> I can say that we're willing to pay this price in memory,
> but I'm uncertain if this trade-off is right for the mainstream kernel user.


This seems a good trade-ff to me. Please send a patch when net-next 
re-opens.


>
> I would love to find a way to see this patch being upstreamed in some form
> or another, and would love some advice.
>
> Thank you,
> Gilad
>
> [0] perf-Flamegraph: https://gist.github.com/gnaaman-dn/eff753141e65b31a34cd14d14b942747
>
>

