Return-Path: <netdev+bounces-163772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27EA2B830
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A1D1673DA
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDC614F9FF;
	Fri,  7 Feb 2025 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIznSwv+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86B6219E4;
	Fri,  7 Feb 2025 01:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738892483; cv=none; b=ucaqHAM6DVrbi9MkaKCI3Xsj5W5N3UYh0PMefhkBKCJgv6uit2WBlk1Ki7HnRai81b9v1n65nelVXcFB94k9R9U5QOwQHsdtLafAwBtr4u/pBpzWfck1AE+SfKmItkUP5oBp2AVbXY94Bsbb4xia09Eopeh1FY66UhL6cWaFq70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738892483; c=relaxed/simple;
	bh=4J72SjBP+Hhw7Zhif3LzI7h0PT11jtAY1m+XbIZtFkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Huv0c7xelWvL63dTnIAYz/6pJGMcJO5GSldMKSy/oBLpqqxgeBAFQRRIiWhrlC+1uqTwnZy5tytI8WMMDoK9ixgAbWIHLfkCOxTlsW5XaccbrqQQ2VIOTYgwTLyH7BBMq5apGMN+xv5QPKbs/urOEqvP4XeVwGAdafN9Ul4JGGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIznSwv+; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f42992f608so2407050a91.0;
        Thu, 06 Feb 2025 17:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738892481; x=1739497281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7bJxC4vhptO7C3AIog58y1CXmFnqgjmRB7S+JtCosg=;
        b=IIznSwv+EVaSHEOlOZL/z2cPxcWnMFj9ChtRW5EzW4t7B0EoKg+rfJYtMsS8Q4JIOE
         elnd4+UrmJipom6KJvUckAEonVkRRGV/txZx+RzOt8Lge4jxNyG+QTFtTTZ0MmOblpMC
         DH+ahZLwykIm6QSvqhyOZ5s1rxXR2SLPJkPPIo5C/gnbJIQvLdg+yI+eaSgY3qXQuyWp
         EiwNd71b3HDJzwBtD0VGs4sw/9bnTfmIyd8I6XOjbEJ5fDJl2jmqooZLuCs9ZxKKs+q4
         FnevSLuKEglrMXifdHsT0J+knIYPuD+oibNDiRJjcriUKdrB6nocYAC6SjdfwVdUue55
         /SYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738892481; x=1739497281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7bJxC4vhptO7C3AIog58y1CXmFnqgjmRB7S+JtCosg=;
        b=H6Zp7vbx1Jj9iSo5+EIXwEqZRCRDhZ5BdfscecSNJt8ON0dgAW/CbFVIVUjhroBpTS
         Fm0j7FTax2cz9Jp2HRCamcV2bHmW+XnyIiZPCzMAaS/0mXw/RdC5koWqyn9T1lhp4pdz
         wrfaDM2RqdhDu/H+x2QBo087E6yXwGYK4ZhJusR7YMout9Uf+D6nsJhNtHFHaM8V8XPv
         fnQhoMQXqDm0DA6ZiUATvQWBAt1WlARFqL6nZpYp+tmdSdZDHZGH+q6vPxw9i4TQBbYz
         NaCsh7j1rpuqvUzofomFQ+hBT/yo9EWjOYkPtTjOj8EAfNy8XVZz3SXNaDWgYjl8ioMs
         vTFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL6pEOnFIKGKTxOkEkog5ApNvyV4BKEzp7UEesadjvXM9MImVH/3zNh3Hh5uOhFibkB5dq4qmDqRGK0QE=@vger.kernel.org, AJvYcCVf8M6XDz376v1ZQzo+cbiQDzXBLCUtrGj0pWc8V+P6LeNMr/hM5KNgDMXhyI2JBPPjNNW4k2YW@vger.kernel.org
X-Gm-Message-State: AOJu0YzTmojJ/Hhg8QEgc72hcJfwn7m/vndfK0VRB0U4GcppAKbHiVhy
	dkWBfaLy7ZXE5TogDly/+xY473QRSQpriAza9EnY6LpWW5z68Q8n
X-Gm-Gg: ASbGncsE9o/CaxcHv66f8l06X+p5E/teffokpJgXKercq6o0xw0ZCL5pNYYXnGtUHTa
	XTHn64+YDL9yB9ucoasAAU+Wb7uT2yRST1PMcRIVx6P89u2SuEk6Yf6LtDgoNRnvbXTiZzg7CPq
	RNOcwWoJRpOWTOlTEDiYKzWMhVAt8HTEv7wCexK6g0raghhjnDmX6vxDpqzaVCziypmOwu8u4lY
	lXuPaBnXMvg4oXndaulis9zQ/NL9/qKjRFnGPSDqTKwesit8JoSwW3Z+H6lU1uAlM9V3H69cN/v
	NYEke7v9cvjawaHkQdLskzA3eqE=
X-Google-Smtp-Source: AGHT+IGkjsxSIpMR8N5aOBiM+JAavbG1h0TRVGqnQsrHa1qTyTKOKMb2Yl8aDc9uyV6HKiLcIQWL+Q==
X-Received: by 2002:a17:90b:3552:b0:2f6:be57:49cd with SMTP id 98e67ed59e1d1-2fa242d9f42mr1948119a91.25.1738892480802;
        Thu, 06 Feb 2025 17:41:20 -0800 (PST)
Received: from [192.168.8.112] ([205.250.172.175])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa286ed9bcsm133145a91.5.2025.02.06.17.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 17:41:20 -0800 (PST)
Message-ID: <a804e0a4-2275-41c3-be3b-7dd79c2418cd@gmail.com>
Date: Thu, 6 Feb 2025 17:41:19 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] net: dsa: b53: Enable internal GPHY on BCM63268
To: Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250206043055.177004-1-kylehendrydev@gmail.com>
 <1317d50b-8302-4936-b56c-7a9f5b3970b9@broadcom.com>
 <9bd9c1e4-2401-46bd-937f-996e97d750c5@lunn.ch>
Content-Language: en-US
From: Kyle Hendry <kylehendrydev@gmail.com>
In-Reply-To: <9bd9c1e4-2401-46bd-937f-996e97d750c5@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-02-06 12:17, Andrew Lunn wrote:
> On Thu, Feb 06, 2025 at 10:15:50AM -0800, Florian Fainelli wrote:
>> Hi Kyle,
>>
>> On 2/5/25 20:30, Kyle Hendry wrote:
>>> Some BCM63268 bootloaders do not enable the internal PHYs by default.
>>> This patch series adds functionality for the switch driver to
>>> configure the gigabit ethernet PHY.
>>>
>>> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
>> So the register address you are manipulating logically belongs in the GPIO
>> block (GPIO_GPHY_CTRL) which has become quite a bit of a sundry here. I
>> don't have a strong objection about the approach picked up here but we will
>> need a Device Tree binding update describing the second (and optional)
>> register range.
> Despite this being internal, is this actually a GPIO? Should it be
> modelled as a GPIO line connected to a reset input on the PHY? It
> would then nicely fit in the existing phylib handling of a PHY with a
> GPIO reset line?
>
> 	Andrew
The main reason I took this approach is because a SF2 register has
similar bits and I wanted to be consistent with that driver. If it
makes more sense to treat these bits as GPIOs/clocks/resets then it
would make the implementation simpler.

Best Regards,
Kyle

