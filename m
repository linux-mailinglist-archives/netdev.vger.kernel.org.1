Return-Path: <netdev+bounces-109776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D88929E75
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D06B284EE8
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33CE39FDD;
	Mon,  8 Jul 2024 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mb2PhkP7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C381DA5E;
	Mon,  8 Jul 2024 08:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720428364; cv=none; b=mPeUVE/dyXER5z6JtyCArg9eX92mqW8KbS90sqiacX6afINH0cc49UDTI7MIoYnAP+03ppFj8ZJhQr9SjGtB/W+z/xgIg7y8pX2dwJrYcmtPaGjta1sYNXBlmZ3MLIlnI3FyCAEJjn+gMv7G+TliGG/QIpKq8gFz8C9/omEsK3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720428364; c=relaxed/simple;
	bh=HZtHo05hPphqk4S6sWcGv5dS2QEo74V8XVbFSm4zlxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPV07G74ry7gCvt4/82/MV+742bDdaZ54zxVbb1wVV8Q3iY5dfb5HGEnqLNbKYWeFEh+wFNEP9sJhWUS01JHvPpHfIIHgt5a/7iV6qjNbcHuFSqncUcBxQsJOmMAjWSx0LkrgVe3lsKHF1OoD9IOd8J3IY4vGVmC/dvajYYEPtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mb2PhkP7; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4265c2b602aso13629155e9.3;
        Mon, 08 Jul 2024 01:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720428362; x=1721033162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yf9c+gWWyHhDNT8WR0f5legPZdyoGSsszOe0uE9no8M=;
        b=mb2PhkP7a1T2v2xlB6hMxEjsOTUl0X1d2kgg+vK7LTFXAuWGq0WZDZYB/iIa4IdCVr
         Di5f+iq+uGOB20oIVm7rAcRqIyzHvsrr0ZyO6smjpiedsHoajfM0HSIZW8ygr7/d1SpE
         /8fgE0dTjea5RKZDOhpo/ld+l4NATC6oQL7XfiDMxooiTIVA7GcyVGPm19fnafOK36kd
         4PhlnDhXvmuGpsi0u5FfPXfER6PabhsxcoyifyJ6/g5m3706MTvsT3/7wIRYxDyF/FAa
         EcVAiGAM81rTffM01+BvlFp/NdMZjOEwQrQpS5YqNZqgg3VxX/K3iGwQ9L1BuNDF1mIf
         MZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720428362; x=1721033162;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf9c+gWWyHhDNT8WR0f5legPZdyoGSsszOe0uE9no8M=;
        b=DNpcf7iWQi/KSX+OFiY+zn4Z/IzCoXO4H2/cseiLsUobRM7nE+ZnJvBn8jig7xAfhL
         cmmupCf/On1A7R/W1nTY8kl2cG79Kh9OjggFXzR/RGMGAxYRN0+n1Npz7IM2axhainIt
         phb1yDGhRgfpZInl9/lcAqEepJYkfLR4yS9pdgQMw87e5x3PeeFfZcLYsBH5FILiwMy/
         F/yapkysVfq/3TZOEUSx9Tkf7nUKicjoVD6KfDwqurN94FuAfh54lm8QBH/WCuksM4Tx
         bdcazJCnugEKkxbgEGuGL1R4O2eLyuFnIN5i8o9K1xeCe6pNqvbQ4VTwLrWroH/h3mhw
         tXIA==
X-Forwarded-Encrypted: i=1; AJvYcCWkrasMQLVogv4c1Gs3q5WNmat7XFiid4cut76PoQGYJuvm29JSLZq3Jj6t061GrSCnQZBlQ3/F11HUmygVqAIhkPxIhFjqY8C5mt/aoYDcDUYWKh2W7VUR1hTvG89bXKD7WYFc
X-Gm-Message-State: AOJu0Yxs9IRfIuJk9KUCu1NZxHBUhhVm4FQVKwVdOJtaHHVaQWDBVZRX
	SPEBQ3Kl42ijfPFYZBPcB6b1ltgNJwcKEPhlCbsrdcvTjKu64ISpWh1idK8i
X-Google-Smtp-Source: AGHT+IFEwH3xuMN5oA1+hyVVEJZIpInjOfNy6kq4NSBG2Ia1UyiFCWX8Q5VwZgCpeUt4MNXYKsU/6Q==
X-Received: by 2002:a05:600c:3ba2:b0:426:627e:37af with SMTP id 5b1f17b1804b1-426627e3c7fmr27791205e9.3.1720428361443;
        Mon, 08 Jul 2024 01:46:01 -0700 (PDT)
Received: from localhost ([45.130.85.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266e84a34csm3002525e9.12.2024.07.08.01.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 01:46:01 -0700 (PDT)
Message-ID: <b6fcb866-f24e-4508-97f5-eb2b63f6eec7@gmail.com>
Date: Mon, 8 Jul 2024 10:45:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/4] net: dst_cache: add input_dst_cache API
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, willemb@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240702142406.465415-1-leone4fernando@gmail.com>
 <20240702142406.465415-3-leone4fernando@gmail.com>
 <CANn89iKLWtyVP9-YU4a8cnE4Mj0zMNtzQkzkHgM0uqdQV-mcPQ@mail.gmail.com>
From: Leone Fernando <leone4fernando@gmail.com>
In-Reply-To: <CANn89iKLWtyVP9-YU4a8cnE4Mj0zMNtzQkzkHgM0uqdQV-mcPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric

> It targets IPv4 only, which some of us no longer use.

The same optimization can be implemented and applied to IPv6 as well and
I'm planning to do so.

> Also, what is the behavior (loss of performance) of this cache under
> flood, when 16 slots need to be looked up for each packet ?

I did some more measurements under flood as you asked, those are the results:
Total PPS:
number of IPs(x# cache size)    mainline        patched         delta
                                  Kpps            Kpps            %
        20000(x40)                6498            6123          -5.7
        35000(x70)                6502            5261          -19
        50000(x100)               6503            4986          -23.3

I found out that most of the negative effect under extreme flood is
as a result of the atomic operations.
I have some ideas on how to solve this problem. it will demand a bit more memory
percpu, if that's reasonable I can do V3.
IMO the boost in the average case is worth the flood case penalty.

> This patch adds 10MB of memory per netns on host with 512 cpus,
> and adds netns creation and dismantle costs (45% on a host with 256 cpus)

Is such a memory penalty a deal breaker considering the performance gain?
Also I think adding a sysctl to control the size of the cache might be a good
solution for those who want to keep their memory usage lower. what do you think?

Thanks,
Leone

