Return-Path: <netdev+bounces-130596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAB098AE3A
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCE41C226CE
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E781A2842;
	Mon, 30 Sep 2024 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZnp3U2U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6741A2542;
	Mon, 30 Sep 2024 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727881; cv=none; b=l72pC+YFq1Xirc0+RxdsuSsBMfnoNDnemJ/rUMLpLd+pnT7JelbuxeoRkvWheZcwVAdf+aZDYz/p71eCPZmos7/E+dwG/CzzescanyV+W1/0xCE/xF2qLARpNeylPukddvwCrsax2J+pemQlQL5B+Dq8W8otDRZ3AtYIuHKOOPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727881; c=relaxed/simple;
	bh=QzlfR37DzfZaUsOffevyoRtZ9UI8+ui3Uqk8FiZejGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYvjG9OyKzGAkvYnlyQAvW7pD3N3wz0ZBpAwPrj6hMtqaj1Px3FBT1VQEwgLuYgddUgxGw0Egn93IXUcecBQvBAFG7ESwWPgbCsvd9QLOOBa9K2K5ALOxbPQWlbFtkQohzN/jzsj/j+pskZ9aOHJFRBt7OZyIOfMW+ojcXWzeOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZnp3U2U; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a90188ae58eso610721266b.1;
        Mon, 30 Sep 2024 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727727878; x=1728332678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BatVCYUdmUjNkqenCgcvEEyqFfrpcUNnyszqZhMUhCs=;
        b=mZnp3U2UW1IaDZFZRmHoHUz9TXI1KTfnSf2R3D2ubDbqQXYB1DHPCbf6oY/owbHxTD
         CZci5agZ1Yn8sNebsAuKY/c8MQ6K4vHBOVCQ6IyXclMzAbM17AzO2EuDTBARVbFiBc/Z
         UiVm3KfU6+wNU+Gyeyi/ied1eaBQuwQKSY1jY45zaWapISbk1UuSGZ77mENumpmBjr39
         aqJ/TRR2gBUA3K/dgHqDZbTrAkDgViXC5BdgdU4/syCiwPmSRp3s4nPmPE/gK0hRkH2G
         Z/WU7ghwl7y6tpFqVZ9YPkC03bE6Y2IB0pXcSMrzk/uPp5EK4/OGVde/U2DPEBE2XhV9
         0AtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727727878; x=1728332678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BatVCYUdmUjNkqenCgcvEEyqFfrpcUNnyszqZhMUhCs=;
        b=TG1WQlNDGxenhUaxF2Cp4mjdVZzbszj22flELM3Lblzc+39RX/320+zINHpaEy/fpX
         emtZBjgF9oln8FvQCXoIjRscM+vYLY2ZcbwIMzZnXch0824fgml6X4fCaCeSaFQuVP4M
         BVkS7C6q4VRCn3Pg2ua7YhIHlreCCjIREf3OwRgbiBsOBWF5DBBS/RYxNpLVec4xf2e9
         k0eCYGToqqa6hlC6o5EKQ5CqZ96RCxzkfHIOKZmCOkBZoK8zkWuNE6E4VEq5q3bBg7FZ
         n6bA+ZMB0P25PaHYsayroY8+DAwV1GbDvHW0lPsMwnDBHY1shhWoymFaTtnVR6AgrLS3
         h18w==
X-Forwarded-Encrypted: i=1; AJvYcCUXC5UESuc9L10/UQJ3oVyLhbSmP7zh0puweL1CXvp68uAX0Qjp3DtJOem7Ne5LD7ReVeKgR59t@vger.kernel.org, AJvYcCVKWm6StbqTSp5SexWGmJFSrXwkY1CF4XTfb8KWb3loye5DvJQMmSxhEo/elIvS6Smk9o9HH4uDb9N4QbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDCT9PKpwrqnQ/TmVNVtLC6OYu8jqnTJirfvym3GPIgyoRAKaM
	EHwv964KPVwlPpJJ0QjEtD0pdgXp6bU3cUlNZ0ySwVwrxBS+thfW
X-Google-Smtp-Source: AGHT+IFnu6oOIeSSNf8YIVY3dGjhkAyQY9sdAC5bF0WBQluIz8KjIhvPHiJsJZoQArJiGvP86b0MuQ==
X-Received: by 2002:a17:907:9307:b0:a8a:7bed:d327 with SMTP id a640c23a62f3a-a93c4946ce0mr1214425366b.36.1727727877995;
        Mon, 30 Sep 2024 13:24:37 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:91b0:e3db:523:d17? (2a02-8389-41cf-e200-91b0-e3db-0523-0d17.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:91b0:e3db:523:d17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c299ac8esm583054566b.222.2024.09.30.13.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 13:24:36 -0700 (PDT)
Message-ID: <bd3f8e4c-fec2-4057-9afe-c8841b2f334d@gmail.com>
Date: Mon, 30 Sep 2024 22:24:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: mdio: switch to scoped
 device_for_each_child_node()
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240930-net-device_for_each_child_node_scoped-v1-0-bbdd7f9fd649@gmail.com>
 <20240930-net-device_for_each_child_node_scoped-v1-1-bbdd7f9fd649@gmail.com>
 <2ebbc75e-6450-464b-8c65-7f8b1f752fbd@lunn.ch>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <2ebbc75e-6450-464b-8c65-7f8b1f752fbd@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/09/2024 22:10, Andrew Lunn wrote:
> On Mon, Sep 30, 2024 at 10:03:29PM +0200, Javier Carrasco wrote:
>> There has already been an issue with the handling of early exits from
>> device_for_each_child() in this driver, and it was solved with commit
>> b1de5c78ebe9 ("net: mdio: thunder: Add missing fwnode_handle_put()") by
>> adding a call to fwnode_handle_put() right after the loop.
>>
>> That solution is valid indeed, but if a new error path with a 'return'
>> is added to the loop, this solution will fail. A more secure approach
>> is using the scoped variant of the macro, which automatically
>> decrements the refcount of the child node when it goes out of scope,
>> removing the need for explicit calls to fwnode_handle_put().
> 
> Hi Javier
> 
> I know you are going across the whole tree, multiple sub systems, and
> each has its own rules. I think naming patches is however pretty
> uniform across the tree. Do what other patches did:
> 
> d84fe6dc7377 net: mdio: thunder: Add missing fwnode_handle_put()
> a93a0a15876d net: mdio: thunder: Fix a double free issue in the .remove function
> 
> netdev has some additional documentation you should read:
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
> The change itself looks O.K, its just the processes which need work.
> 
> 	Andrew


Hi Andrew,

thanks for your feedback. I used the same name I found in the first two
patches for that file, and I missed the 'thunder:' because probably
those patches applied to more files. And the same applies for
hns_dsaf_mac.c. I will fix that for v2 alongside anything I might find
in the netdev documentation that might be missing too.

Best regards,
Javier Carrasco

