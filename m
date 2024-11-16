Return-Path: <netdev+bounces-145598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCA79D0063
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 19:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0107B2705E
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988C6191F9E;
	Sat, 16 Nov 2024 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPviKddE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA84718E75A;
	Sat, 16 Nov 2024 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731780368; cv=none; b=U2r6CMWZ1rWavlUJp3rAfaISlp5RBa+iCl9S6jnWLlL28H0jQiO1dGmyQOAf6M/pnW/bfRn4dONs7eXCA0+KIRveXVWeN0mQ4BVOb39T1bo4YQoyf20mkJ2RTjGKGCQXT9Fr9CPhknbRAPLg8eVbrAwIDZ+/OPcWN3pWUo/a7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731780368; c=relaxed/simple;
	bh=Eb6VXLn0GUu925enYZ0CfwS/5PFDI7m9Ebe/clpgkWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSfm5/2949ni8zvmSuu+YmiHzEgA8Zp3vu5vwJkgZVSF65tzxNetgRVXP7JKayU3M5SATMa89Cxqb+Awrz76vQgdgVZ/2qqz9Vu27JJ/HanujADBzyQJQFZ4C6EqwB3B9MPbGrgmmqP3ZbzTd7OCLRvTNvwLwixUY0G3BlVmTBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPviKddE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so484054866b.0;
        Sat, 16 Nov 2024 10:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731780365; x=1732385165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5MbkWbTcMyJCBwwGFH5mzKdQbrS61TByU2lSza0tBxM=;
        b=jPviKddErqWoyzFm8UCqtpASvlOzGP5ekXbBIhFP8pKFBD6DeQ9kYH8ijrexMxnnVf
         08J0KI2JBxnkUjQT3rEUAOCvJuX+K8PwFoEm7bkX+PGAe9qAVmwNwahasqiPVlxsfDdS
         vgd0IswADXfORwkJUswwgDEth0lTPOXuiINWyeZgQvF3qdzwtKkfyCICQSspe+5ewPbC
         BnWit1SKbHTa/kHXxq8gobDBAoO+I3STyjTnLr90/vXwYNC/0AdccgYtrrM2eVd0ai6p
         ct8ln0diFXS8+EVmX9Ih/C1pwXd7WxFbFpvNuW++AsJD9gUbyFZNHsz5j9x28Hp2zmkl
         B1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731780365; x=1732385165;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MbkWbTcMyJCBwwGFH5mzKdQbrS61TByU2lSza0tBxM=;
        b=Lt0JcO5hoKDW2o4UjOwXnaJtSkY8HER33p4xQ3s9rwlrUBq+xuurxcdsvNuIncEqzf
         tBqK6t3lX0cn5u2q1VslJREZAIWQW0CfLU7pRG85A85fNIZFZXG+j4U3Iw9j7uieaMpc
         A0CTau6rN77WkuGZuOiyP/OWu94TUcemwxZIstpbKHcXY0zuMU1LkD1x7QcUobK+XKwq
         Ijj4AbxEoMWMxs7g1OnekX31gJdO8skzmPKh/fPtlZWvCGqHG/QOmGRgwmZx6igjIvNL
         3Uo2fMYsLBJdXneQWojRduH0/kFv5gG2jrG6g/ptzo3jgGCXfIDEqlFyPCGISXy7JLV6
         bmGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIPC2TA6kERUvnnEmd5GN0OpJNxMM8zo4rAC0UqRF3SLO59PN3UPrlRV16tgHauu2yNeo7YdyK+ijqrMA=@vger.kernel.org, AJvYcCWqauoG1wdQXBVijEVcOIIWK27mZGucN6LwTdJtWGHKsPQv9fB9gtPEp92DxGLu0vdaOxzwOIGk@vger.kernel.org
X-Gm-Message-State: AOJu0YyFVpEP31S4jAsTWaZDqBJIyRJAa8HHMzgw9/eumegininlqJXe
	iPlZM+FaKjvqgqbRH9GWB8BMUPhNxXkO3r3/c5Xe17oqLkmUzhYh
X-Google-Smtp-Source: AGHT+IHYpJ1CGdDFTs7irKG37tG9/+9C7qVIWSkB/PHZ4zOEvRGVYzWs6HkJAviEiLY8BUqkL7tqjg==
X-Received: by 2002:a17:907:2d11:b0:a99:5234:c56c with SMTP id a640c23a62f3a-aa48345440amr645629766b.33.1731780364840;
        Sat, 16 Nov 2024 10:06:04 -0800 (PST)
Received: from ?IPV6:2a02:3100:a557:e100:45f4:697f:1405:21be? (dynamic-2a02-3100-a557-e100-45f4-697f-1405-21be.310.pool.telefonica.de. [2a02:3100:a557:e100:45f4:697f:1405:21be])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa20e080a90sm329627666b.174.2024.11.16.10.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 10:06:03 -0800 (PST)
Message-ID: <913e6891-51f3-442b-8af1-351d96ff018f@gmail.com>
Date: Sat, 16 Nov 2024 19:06:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] Fix 'ethtool --show-eee' during initial stage
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20241115111151.183108-1-yong.liang.choong@linux.intel.com>
 <403be2f6-bab1-4a63-bad4-c7eac1e572ee@gmail.com>
 <ZzdW2iB2OkbZxTgS@shell.armlinux.org.uk>
 <170a8d59-e954-4316-9b83-9b799cb60481@gmail.com>
 <Zzi7dqqZLCCVvlHq@shell.armlinux.org.uk>
 <3915908d-d70b-4fbe-b80b-990d02211965@gmail.com>
 <ZzjZ8EcwpU-YnZrz@shell.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <ZzjZ8EcwpU-YnZrz@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16.11.2024 18:44, Russell King (Oracle) wrote:
> On Sat, Nov 16, 2024 at 06:41:13PM +0100, Heiner Kallweit wrote:
>> On 16.11.2024 16:34, Russell King (Oracle) wrote:
>>> Hmm, don't we want to do this under phydev->lock, because network
>>> drivers and phylib may be reading from phydev->eee_cfg? If we
>>> update it outside the lock, and then revert, there's a chance that
>>> the phylib state machine / network driver may see the changes
>>> which then get reverted on failure, potentially leading to
>>> inconsistent state.
>>
>> Good point, then the patch would look like this.
>> BTW: Saw that Jakub applied your patch already.
> 
> Yes indeed, so I hope Jakub will apply your follow-up patch soon!
> This LGTM.
> 
OK, then I'll submit the followup.

> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Thanks!
> 


