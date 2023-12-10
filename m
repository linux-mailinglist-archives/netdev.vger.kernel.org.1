Return-Path: <netdev+bounces-55607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C7680BA79
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 12:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4647A280D7C
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 11:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4758C8829;
	Sun, 10 Dec 2023 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="L6EbpxL+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C8F102
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 03:47:29 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54f5469c211so2665664a12.0
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 03:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702208847; x=1702813647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SmrfVEAYT+EdtX2prQBa70EX5gokQZAuJTytc/ziT1w=;
        b=L6EbpxL+5W1mGT8eCbQPtHWcGW3PRjcTDhlj7x6Ugw4DX8LEYI+hJL4lWBpq4gDJrH
         d1h6QbIiml8rZTiyLpEOBtC2ctteZBZLja0PH9H1LZ4SXVyKTek3FIKAIiW0zomkODN9
         84z1EA8Cd3xPnn/GUjmVcjTTjXviETIm+9MqvGASar/Bt6b/oiadbUyEKO7djrUyU73X
         8V6aZkdJwCV5ogk2NbxxDM1nBL3933gbAQUOhr/vcT1pMOGwwE8DzkGmJ9gI0ldHhgYn
         +oHe8eLM+TiNz4IKjxpP0yrloQ7KPpIOtdsCOl7cpns+sEEIuFYcfsTZYWHp1vdFAhsa
         oycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702208847; x=1702813647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmrfVEAYT+EdtX2prQBa70EX5gokQZAuJTytc/ziT1w=;
        b=mAIyFwedjn30Rwk2biDDWRfOBDE9TKSZCpy9xROyfrLM718pP20aq340b6wZaWPjK/
         DZwYQSAQLjMoZtQL9HinAMmKrKcnFei2sP7TmfI9LwyN6NA8Q4XEUX82Tu9D3flJqJaJ
         UGofFPYa7rA5f0woT8o+vgynIO5U9IgnFNhRp/zYIDJ2GZ7Llv2Wih2oPRvA6o64Z01m
         sjRj/JDhAzG7WTX5DnvKQvTzNn74COjwm/uBBUJCUNPBexkw+9W8BODGHGbqtUdCSioS
         KeYbJY8gqQmzDJa7mu7Uvi5gDyoWdSQzD/cOq2ioArOPX0dHhqvAAdxIPacZyJ3/NVde
         tPkw==
X-Gm-Message-State: AOJu0YwuUmCxGz+LalP+ak3McpetI1/JkPTN1wsA3zI6f/H4oF6/+K60
	QLRpbIxL0bAPR3M3Qns2nQzY2w==
X-Google-Smtp-Source: AGHT+IFoD8RRDp70KKKn6lToA0tmuSVEYXzOSd7L/BQ2NXHTTAr7bbdfwIUGvOgmM+tXkSjPeZ9+6A==
X-Received: by 2002:a17:907:2cc6:b0:a19:a19b:c713 with SMTP id hg6-20020a1709072cc600b00a19a19bc713mr2270485ejc.99.1702208847489;
        Sun, 10 Dec 2023 03:47:27 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id ps3-20020a170906bf4300b00a1dd8945d31sm3319490ejb.34.2023.12.10.03.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 03:47:26 -0800 (PST)
Date: Sun, 10 Dec 2023 12:47:25 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: swarup <swarupkotikalapudi@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next v5] netlink: specs: devlink: add some(not all)
 missing attributes in devlink.yaml
Message-ID: <ZXWlTYyPF0nj1wof@nanopsycho>
References: <20231202123048.1059412-1-swarupkotikalapudi@gmail.com>
 <20231205191944.6738deb7@kernel.org>
 <ZXAoGhUnBFzQxD0f@nanopsycho>
 <20231206080611.4ba32142@kernel.org>
 <ZXNgrTDRd+nFa1Ad@swarup-virtual-machine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXNgrTDRd+nFa1Ad@swarup-virtual-machine>

Fri, Dec 08, 2023 at 07:30:05PM CET, swarupkotikalapudi@gmail.com wrote:
>On Wed, Dec 06, 2023 at 08:06:11AM -0800, Jakub Kicinski wrote:
>> On Wed, 6 Dec 2023 08:51:54 +0100 Jiri Pirko wrote:
>> > My "suggested-by" is probably fine as I suggested Swarup to make the patch :)
>> 
>> Ah, I didn't realize, sorry :) Just mine needs to go then.
>
>Hi Jiri,
>
>Please find answer for some quesion from you.
>
>1. I removed the Fixes tag.
>
>2. I removed Jakub's name from Suggested-by tag.
>
>3. I added new line as suggested.
>
>   value: ## or number, is used only if there is a gap or
>   missing attribute just above of any attribute which is not yet filled.    
>
>4. dl-attr-stats has a value 0 as shown below for this reason:
>    name: dl-attr-stats
>    name-prefix: devlink-attr-
>    attributes:
>      - name: stats-rx-packets
>        type: u64
>        value: 0 <-- 0 is added here due to below mentioned reason
>                     but mainly to match order of stats unnamed enum declared in include/uapi/linux/devlink.h

So, by default, it starts with 1?


>      -
>        name: stats-rx-bytes
>        type: u64
>      -
>        name: stats-rx-dropped
>        type: u64

