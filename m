Return-Path: <netdev+bounces-112456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE22A93927D
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 18:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AD31F22E59
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AE716EB4E;
	Mon, 22 Jul 2024 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="0m1ytvMv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C022F16419
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665614; cv=none; b=TXyrdwTVGFtJ3uqAouKkZo6op/oAMuj66+Eh0lhIGO1ALQn2+7UKJff/+xfS7j4s6KSCDyDEsn5gVfzu3f0gnA9xEM3aWkfmNnj7/0p0nOibMkhiCjFH3RLtADbH+eSSy4MZJQaVzXEsQWkMErMHKPEfxpHP3HDNyOHM0jDpbPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665614; c=relaxed/simple;
	bh=YJW7q3q2WZHhpZIPz9nxBqD6po22vKuw4Z4gDTh5Plk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uNN51lczvGSuBWUDIRyRzJeOp6qxYzUAL+FFiQs3GztplHsN6goX20THKeQGZrYAiyYvC2hqo0UilKfK5YGx7bp5/AWoluP8PNP1dPT/O3135W+J3rUT+V4ZpmM+nOTzgB9RBgwteE9G7lZpprUiMG5hHGQLiCMaE0CFE9uwndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=0m1ytvMv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc566ac769so27474695ad.1
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 09:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1721665612; x=1722270412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O2MDjAiJsDfpaxf+csmoyTFJ/vmu35DDclluklta+TE=;
        b=0m1ytvMvzz62dFfgBu8Xnna8VhexTRcIkOTaepxkvmSmN2E5INeV/Ifo5KhfODbTYk
         Z9S8MBCgUEJV0koga4gCM2U9pyEoAskqEqOuMCVZ8FtL0mdkoTxUt1D2Kj9uAxA+j4jz
         EiEYUlXq8+IhFJ4lz7dgPI43JHy3/sMvqVAD1c/fwlKol3axRa7r2re/ENVFmGLXTap8
         OYIsPhW+sLjCAVmhpIN1KBqbSjMcNPJdA7s/2tGjCPRnsDdy5QLS11bqp8HP/u99TC21
         aaFvmn7dWW/34aIttOPXhpnU/xj39ORqyN30VHXi03XArHcZn3ozVWQYCYxzapW7u1kL
         fgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721665612; x=1722270412;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O2MDjAiJsDfpaxf+csmoyTFJ/vmu35DDclluklta+TE=;
        b=OWuoQUbNsbIPP/ibgFjsALfehWqCZWLiebhHJyVyGf/nIXviBy8QMd7btDAZGT0eGP
         AQMb3Mzej74DVkUL4XSxGyZhIOMqdOlUqByZUSSTHH4yWJX87kGCHmvZkFX0PvHMd0jq
         LyOoP83Uttk6DAfgQWXuRTS9joe1Vz+Ut1+8TGZ6JzivTNK+L/TNApgAeffYwc9wJ8ir
         K6Mu1fp/VlyEr3B6pAGavDWB6B7GVNw8CtGP7+zG1sFSpvbQRwEzlBNbutPusZMuacLZ
         tjz4jdkmMNeMuqm2D1qkxkglVTnLUJ9xDHs7upw7XAoAP1jt1ckNAgspmqMvBrgK03nT
         djiA==
X-Forwarded-Encrypted: i=1; AJvYcCVt/weGbY/hTOq/o7hAWO05o3c8dofnmO3ziFjv0jXNO5wWj1MvlTk4WN52XQsjafrn/hzcW9wc9ah5FlvLaNql1D02Jsk3
X-Gm-Message-State: AOJu0Yx/pizxxjjv5AUuLc5lu2YpcUNvtqHiBuhA15LflLlFioU3fKKi
	aVSt/aMH62H4wtBkN5R6TW7kgw1Xv5xndhhjL5sR0HZ8EoFQeplDdfTApQw4byk=
X-Google-Smtp-Source: AGHT+IGW6KxIbtIOPURhaiUNsS7Z65IeWegrq8MIGwM9GpixAG+Mp9d+73i+f2IW2qGAT5G8Ib9HGQ==
X-Received: by 2002:a17:902:dac9:b0:1f7:11c8:bdd3 with SMTP id d9443c01a7336-1fd7456c07amr42900965ad.29.1721665611950;
        Mon, 22 Jul 2024 09:26:51 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1256:1:80c:c984:f4f1:951f? ([2620:10d:c090:500::4:54f3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f436cf6sm56566975ad.205.2024.07.22.09.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 09:26:51 -0700 (PDT)
Message-ID: <5c870247-f2b3-4f03-a41f-5ec109f2ffaa@davidwei.uk>
Date: Mon, 22 Jul 2024 09:26:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] bonding: Remove support for use_carrier
Content-Language: en-GB
To: Joe Damato <jdamato@fastly.com>, Jay Vosburgh <jv@jvosburgh.net>,
 netdev@vger.kernel.org, Andy Gospodarek <andy@greyhouse.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>
References: <2730097.1721581672@famine>
 <900054ae-be78-4d5e-aa5a-cb3ad91599e5@davidwei.uk>
 <Zp6GgddK80vPZbCX@LQ3V64L9R2>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <Zp6GgddK80vPZbCX@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-07-22 09:19, Joe Damato wrote:
> On Sun, Jul 21, 2024 at 11:28:23PM -0700, David Wei wrote:
>> On 2024-07-21 10:07, Jay Vosburgh wrote:
>>> 	Remove the implementation of use_carrier, the link monitoring
>>> method that utilizes ethtool or ioctl to determine the link state of an
>>> interface in a bond.  The ability to set or query the use_carrier option
>>> remains, but bonding now always behaves as if use_carrier=1, which
>>> relies on netif_carrier_ok() to determine the link state of interfaces.
>>>
>>> 	To avoid acquiring RTNL many times per second, bonding inspects
>>> link state under RCU, but not under RTNL.  However, ethtool
>>> implementations in drivers may sleep, and therefore this strategy is
>>> unsuitable for use with calls into driver ethtool functions.
>>>
>>> 	The use_carrier option was introduced in 2003, to provide
>>> backwards compatibility for network device drivers that did not support
>>> the then-new netif_carrier_ok/on/off system.  Device drivers are now
>>> expected to support netif_carrier_*, and the use_carrier backwards
>>> compatibility logic is no longer necessary.
>>>
>>> Link: https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.com/
>>> Link: https://lore.kernel.org/netdev/20240718122017.d2e33aaac43a.I10ab9c9ded97163aef4e4de10985cd8f7de60d28@changeid/
>>> Signed-off-by: Jay Vosburgh <jv@jvosburgh.net>
>>>
>>> ---
>>>
>>> 	I've done some sniff testing and this seems to behave as
>>> expected, except that writing 0 to the sysfs use_carrier fails.  Netlink
>>> permits setting use_carrier to any value but always returns 1; sysfs and
>>> netlink should behave consistently.
>>
>> Net-next is closed until 28 July. Please resubmit then.
> 
> AFAICT, the subject line is marked as RFC (although it is a bit
> confusing as it mentions both PATCH and RFC), but my understanding
> is that RFCs are accepted at any time.

Oh you're right, sorry my mistake.

