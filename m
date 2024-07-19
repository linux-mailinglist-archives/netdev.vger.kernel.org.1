Return-Path: <netdev+bounces-112270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C95E937D87
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 23:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39CE1F218BD
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 21:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D7414831D;
	Fri, 19 Jul 2024 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="SK7ubIk3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDA3149C4C
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721425201; cv=none; b=GvXEnRXplq0Dr44aClKZEYOZxezmvGcfO099meRc5d4ajfWyxJGL00/y4ArEvRjRHShC0criWzIMoaujDi4C6xqX83RCpgF56yNJ3sDs6wWDOc+v/awi18abAkCJQtqVG2Zu3YsbSoamJNjYQZ/LX3U/ncMZSgihF3UCl4DTLVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721425201; c=relaxed/simple;
	bh=+rK727bJDKyDqHk+yxAz9jWW/4ivJjyJrvOfkoGOJ3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uf9cWnXYeB5LrxQ6SafNq7tpikt5NjNgGIB0YDA+4UIcNVuy+SQL+wn8oCDq4JzPyRoGmwtH7M5tlw2RCKMyM9mIMmBR9aK5hItcGvUZ5nvNBq9l742LaEhoIOTnKsJXnbYLODgKh7MmTFl0kDPX3D3jfvhgyCAR+uMNf7ZLIsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=SK7ubIk3; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70445bb3811so1268353a34.1
        for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 14:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1721425198; x=1722029998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxURwrQjaWVMnPupTe3e2QhQiBnQCCXPKt1vU7CQERU=;
        b=SK7ubIk3EdYeBat73ZYGhPWdCbT3ai8kPz8OWyYooyZ3vcPRJtbuQd4znYkw9VEwGk
         c4o4HMJ6zT9ftno4l7GGQSAV+TMghyjUa8Uj405FT6GByEe0YImwqpLBHLhNN6Bu4DuQ
         Y7wPa3Gdt2k+PG29oLc6mHUDBVjHsUg2flwXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721425198; x=1722029998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxURwrQjaWVMnPupTe3e2QhQiBnQCCXPKt1vU7CQERU=;
        b=c3iUJTvJ7geXVcOnxPsmnjdoi/f1PoLanXoIquPe3tOWVjLyJL5IfF4CBSIs7kgFO7
         mKvr0h/+AMNiAvfWTWCu18oPHXQ1jylJMWeJzlYR5xF/RPAy2YPAMi1HhxlmlAb7KEi1
         wT0DzVWJuBSALH8tHGHAupxQ3ujt8cruBSOQvahu7OvOnE1MNc8cToNPYzZMVLs9Azc3
         awNAWA3MFfDUuWcMMHJKA410Cxxv+7N0kgs8Q0ppMhYRD3g2Jow54fqRHwiBOM3+oH8S
         UmKnc3pm6aJSGgy66izGTH/My85s/P5OJR+yizpgUWHLSm5b9qp8EUVPpyp4B3qNquSn
         460g==
X-Forwarded-Encrypted: i=1; AJvYcCXl2sjo6sm1/Rqli3neWoc2EuImfHIpoysYhBXmUXmJEIGFbMKsPI2D1j5CWxz+jPDK+WDlDugMzD9LWhwfVLdc0M6dK4s+
X-Gm-Message-State: AOJu0YxDNuyh5zRro/aVTXKbbkT+9NoX5H8+D7cefCxoLWAlkZz9trnw
	QUBBFwm4SR3vmTaDNuFKSxunyCjQ0jfIP6GAKC6n/K4fe7YqZ/enyqW2W8KXOg==
X-Google-Smtp-Source: AGHT+IE74f2iNObwpJtxfcq8M2viSwuF/AsMKv4hekSdNy/d0euPZyuEg0mshxbk4LRUVX4+1T2w8Q==
X-Received: by 2002:a05:6830:418e:b0:703:7786:edab with SMTP id 46e09a7af769-708e379aa81mr11905980a34.4.1721425198123;
        Fri, 19 Jul 2024 14:39:58 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-708f6189bd5sm460642a34.65.2024.07.19.14.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 14:39:57 -0700 (PDT)
Message-ID: <e7e88268-a56b-447c-9d59-6a4eb8fcd25a@ieee.org>
Date: Fri, 19 Jul 2024 16:39:55 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] greybus: gb-beagleplay: Add firmware upload API
To: Andrew Lunn <andrew@lunn.ch>, Hariprasad Kelam <hkelam@marvell.com>
Cc: Ayush Singh <ayush@beagleboard.org>, jkridner@beagleboard.org,
 robertcnelson@beagleboard.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 greybus-dev@lists.linaro.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240719-beagleplay_fw_upgrade-v1-0-8664d4513252@beagleboard.org>
 <20240719-beagleplay_fw_upgrade-v1-3-8664d4513252@beagleboard.org>
 <Zppeg3eKcKEifJNW@test-OptiPlex-Tower-Plus-7010>
 <b3269dc8-85ac-41d2-8691-0a70b630de50@lunn.ch>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <b3269dc8-85ac-41d2-8691-0a70b630de50@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/19/24 2:15 PM, Andrew Lunn wrote:
>>>   drivers/greybus/Kconfig         |   1 +
>>>   drivers/greybus/gb-beagleplay.c | 625 +++++++++++++++++++++++++++++++++++++++-
> 
>>> +static u8 csum8(const u8 *data, size_t size, u8 base)
>>> +{
>>> +	size_t i;
>>> +	u8 sum = base;
>> follow reverse x-mas tree
> 
> Since this is not networking, even thought it was posted to the netdev
> list, this comment might not be correct. I had a quick look at some
> greybus code and reverse x-mas tree is not strictly used.
> 
> Please see what the Graybus Maintainers say.

Andrew is correct.  The Greybus code does not strictly follow
the "reverse christmas tree" convention, so there is no need
to do that here.  Please understand that, while checkpatch.pl
offers good and well-intentioned advice, not everything it
warns about must be fixed, and in some cases it suggests things
certain maintainers don't agree with.

					-Alex

> 	Andrew


