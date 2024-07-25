Return-Path: <netdev+bounces-112905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B1A93BBCD
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 06:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90636285A1E
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 04:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0956718C31;
	Thu, 25 Jul 2024 04:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mccDyrD5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791CD17C91;
	Thu, 25 Jul 2024 04:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721882574; cv=none; b=FvfN7IE6nEvTUkDDr1k7O3b7kPV/syMFkp0lAPQoe1XORcu0B1rNIWJpSUWXrxfDteqYSoAWx399ntow+pyLYeMJa/j8bneO35NLu/rnk4bmeRLNHlWThZ6VB5ZlPaA+AddkMw+3d2A4r5IdqQCM00TK9r0QJiEVlCp/3GTZZ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721882574; c=relaxed/simple;
	bh=jz4m2oY5u4+GI8ZHla+gHQ9Eo4WSDheCjNNKC8IJZFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7Tcj0/pem5aggyzn/SWrHL3AEla3Z0hB0fTF7TACHCVjGvp75Q3Gtni2FqLrOgya12Y1Bjd8x1dk4lAkQeHNw89whF0WTMGVgaxgwZHsHAOGxZrv348emN1f+pX62Lf3p3ifIp+MtvVuY32jGdDsy5XJJTNTeW/pa4PKCWIZ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mccDyrD5; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6687f2f0986so5329777b3.0;
        Wed, 24 Jul 2024 21:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721882572; x=1722487372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BM0WaX2xBRI+P6wBphQ3Tx8B31SXeSZp7jX6Hq9nAPs=;
        b=mccDyrD5fX3rw0SQyCW4W9oesUdqF1KxGxH8zi59xoUZb6oSo8OHIE10N8aW6FfUFG
         /pVOsmqDOe/fjz1ruEjDa+WzvBueg5IRG4CCz3RvULI2F3eTHvjH/R7bXGemYwhaOJN3
         xpkJBjs+VAcHEZAKvoz0brD1ia9E2tDCydly44hwTQpEnQDuKWDJmvNYWMz1BYZn8T9i
         NyA9ie/INfPoopI2Gc9b49z1vEqq8hvKDBvLEBfAP6855d8O823kWJxyJkTHWKDHB6re
         +asQmoi03WMyDNRjRLmStTtSYzAmsfYqpPilc8Xd0QMq2+xt466tPgdDdQ28+hupf7Zs
         0eVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721882572; x=1722487372;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BM0WaX2xBRI+P6wBphQ3Tx8B31SXeSZp7jX6Hq9nAPs=;
        b=IxV8BBciN2fDTPevxngYoAN5BElbFgvyBT0/Wo75wyHrFkqK4JuDWYAYJ1f62oNQcL
         ph4mSGGXG/TMqpOGDHzGhOneELh805JoCqtreH8vss/cdKMJxfYE5n4cRYvUFjAOgO0O
         5waw7NdBzVplSWlEM0CIglz7FNEUIzpSrLzpV7YjnCiEVtII+MXfvWFdTzawL6Bytl0Y
         ukHmEQYJsVugN9uKjCra97DgQX7p2moufDyQ8dFdOflo5k6ONU0mS5ZAKCP/dGHA9aw9
         x9X1zmUi5v71LlpkS8MjT2dwQdimJPnXlFU58eZ3q9DtKudZZsLBhIAPavImb4yTIeZB
         7Yww==
X-Forwarded-Encrypted: i=1; AJvYcCXyJvqjIp9ccT++JByphmAWjWYhn5qYKeu7zLWSxfMwPrU63GlTa4Gxs1Wg2PFHYQGii4Z1nUwLFriXbOhvjFWgn1UoCgEKQrFBGc8xrpvBFcK2SOYGrMerAMFHEI4BcQFoNTQozm8Nwf329hVfRyzrBHn5XoUvE3UPIHWhERSI
X-Gm-Message-State: AOJu0Yx9SAAihaz6RnmkTpZdQzjwjrsqgDtbHhdbvhq2lcfZOOwp+qLN
	QUjnjEsW70EB4tKv6bdSeyXEfu1diHKgYl1Df2wmM76LzCwWZ6SI
X-Google-Smtp-Source: AGHT+IFNQ4DeNsUdj+8WTej5DpL+p2nkyzhkb6sKbcXGUsQGssDiAK7pUORfI4OXAPspm38fqIVLbw==
X-Received: by 2002:a0d:e701:0:b0:64b:69f0:f8f2 with SMTP id 00721157ae682-675b51296femr7324417b3.3.1721882572253;
        Wed, 24 Jul 2024 21:42:52 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8749cdsm356545b3a.152.2024.07.24.21.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 21:42:51 -0700 (PDT)
Message-ID: <32be761b-cebc-48e4-a36f-bbf90654df82@gmail.com>
Date: Wed, 24 Jul 2024 21:42:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: lan78xx: add weak dependency with micrel phy
 module
To: Lucas De Marchi <lucas.demarchi@intel.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
 UNGLinuxDriver@microchip.com, davem@davemloft.net, edumazet@google.com,
 gregkh@linuxfoundation.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mcgrof@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, woojung.huh@microchip.com
References: <20240724145458.440023-1-jtornosm@redhat.com>
 <20240724161020.442958-1-jtornosm@redhat.com>
 <8a267e73-1acc-480f-a9b3-6c4517ba317a@lunn.ch>
 <v6uovbn7ld3vlym65twtcvximgudddgvvhsh6heicbprcs5ii3@nernzyc5vu3i>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <v6uovbn7ld3vlym65twtcvximgudddgvvhsh6heicbprcs5ii3@nernzyc5vu3i>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/24/2024 9:25 PM, Lucas De Marchi wrote:
> On Thu, Jul 25, 2024 at 12:57:05AM GMT, Andrew Lunn wrote:
>>> For the commented case, I have included only one phy because it is 
>>> the hardware
>>> that I have, but other phy devices (modules) are possible and they 
>>> can be some.
>>
>> So this the whole whacker a mole problem. It works for you but fails
>> for 99% of users. How is this helping us?
> 
> no, this is the first instance that was found/added.
> 
> if you declare a softdep what happens is that the dep is loaded first
> (needed or not) and your module is loaded after that
> 
> if you declare a weakdep, you are just instructing the tools that the
> module may or may not be needed.  Any module today that does a
> request_module("foo") could be a candidate to migrate from
> MODULE_SOFTDEP("pre: foo") to the new weakdep, as long as it handles
> properly the module being loaded ondemand as opposed to using
> request_module() to just synchronize the module being loaded.
> 
>>
>> Maybe a better solution is to first build an initramfs with
>> everything, plus the kitchen sink. Boot it, and then look at what has
>> been loaded in order to get the rootfs mounted. Then update the
>> initramfs with just what is needed? That should be pretty generic,
>> with throw out networking ig NFS root is not used, just load JFFS2 and
>> a NAND driver if it was used for the rootfs, etc.
> 
> that works for development systems or if you are fine tuning it for each
> system you have. It doesn't work for a generic distro with the kitchen
> sink of modules and still trying to minimize the initrd without end user
> intervention. So it works for 99% of users.

OK, but 'config USB_LAN78XX' does have a number of 'select' meaning 
those are hard functional dependencies, and so those should be more than 
a hint that these modules are necessary. Why should we encode that 
information twice: once in Kconfig and another time within the module .c 
file itself? Cannot we have better tooling to help build an initramfs 
which does include everything that has been selected?
-- 
Florian

