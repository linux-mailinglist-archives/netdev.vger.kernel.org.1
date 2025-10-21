Return-Path: <netdev+bounces-231117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 943C2BF565E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89E564FE5F5
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BA9329C40;
	Tue, 21 Oct 2025 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JXqgQRiC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC70303A39
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761037350; cv=none; b=uIxcZX5tCFssnvd9lgCojX5RM8HDMZk7El+pv1EZjtkwLfsk+gVxuvPlU7vBu6rKNqbZR71cUOuPqyfwbvR4cFGoHqh3jNLLWqNqdc3xDbYokR/7jUb9ghitKbwgphT4QhpdJXQCUlhywYKYBCjZACOA9SmzZL/V73JCrI8IFjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761037350; c=relaxed/simple;
	bh=OffQ204+Nyj5VGiYdW6PGJRNUJ3xhRI9Iw3cpA0RNp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRe2PHbPSNjd3Z/lEORoWpz2KM9CHhzsLOMcxeNQNytJQ7XsfAmI613EcybzAgXXu+eKtoKmK7hh+Ade53DayDb6S07EogIcJqBzcXcGNAgTTPssDhtZqlS6+CdWRmle9Zwl1Dwu5rq5mK8oiyr80ODoS7r/uIpwBxGN+fQCJ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JXqgQRiC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4283be7df63so1532744f8f.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 02:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761037347; x=1761642147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uV95Izl15icyzjNabiyKCGR1CIjMB77dOSJKauGty+Q=;
        b=JXqgQRiCeO/6bZC53J0LtiasJjjfxtp7weqhbCvhvkJRsME2Uo4sLgIb5X3jKHDL7w
         MoOv88N18VE/CP8yIPTL2pV+vGyUGhGAgaEVr/how2NtaFpsi9zsu74gBChM3S+g6UDw
         R59c69MOghHXFoywwC7yDdFc/QoAqfelLaBxbt/Os01BpwqmJG0uxWbTSwAQ6GwbNmkX
         piPGYdocSnbvwq3j8PRMkhQAUzTDRET5mLsXercyiRb2R0eFxCkIm11aevDhawPzf4ZF
         Kf1YrESL6oTZMuFqNCmAZvh1xAox6lyaK6yxAS461WzJIjQaevvRJEYMoOMLycRAB4eb
         l+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761037347; x=1761642147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uV95Izl15icyzjNabiyKCGR1CIjMB77dOSJKauGty+Q=;
        b=tvhdNDGZxTfw+J6Hc003a8i+7/HWV6yHOP9b17evAjBoZyqLH75wd/n0Ayyy/qrYIo
         dmw0Yz2X2DzXxj72tVzJtsXQqNOTX2jbV3t8HXMKgYPGMcDf6pWAZ8oNx/tG2WjCsZ9G
         /2/BO5MyHoCXUECMnMdj8ijpanMhGDiM7KbtfB3MhcUuSZPeBK8pODqM5L8D9KEZvJGx
         v8haLQLvMPMXdKGFZ5PluyvK0EVZ+/R6jU8vTTeYlgrE0pAUpHQFSpee1SiAO/Rytx/d
         EozvJ1HMyqMvEHbP5rrV+qn3XagzHlG0pI15SVyHS8Y2R6i1RSQ2mvyhZx9g/EaOyKjt
         OkYA==
X-Forwarded-Encrypted: i=1; AJvYcCWG6xlRLo1cPie/6jhay5LIOgF1Qnn0AoUypRGtIafFkrUHpqfQBH1ESOKSvkAmKcDFbhTCxsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe1tY6OXSXl2xVCbmWbDamPAA8eJyCMzCzstNy4rCgGGMA7w5y
	NBFlRGFR+8nonRvfQUqldm7jwZytHhq1Y0F2tleXt+pnN/HIDfUKIqZjasWryFbZOz4=
X-Gm-Gg: ASbGncvsD4E87m/awgIuW7ik5k/K/jyPEE0JNYw30LQzwPFtNqN0ECMubTFXUrYnAGQ
	aG3099RmSQRFSeStnyAWuWUdVJ5M6VbK2nMXsrsmC0n6yhkNYigCybCnOohVv1WMzqbpF/V+MBx
	fBq4qIh+X9w8HtjRDC9xVknFXgLH0j2Wkwkrkp8R4czrRPkUSOTMwX4/LNNfUK+FeCtSZhKpT3+
	0eGFd2jKMsg4FpyiRRzCMUBkrbOWAMgDTSD/PSAcB3wDw/jqYbE3Wm7GeWDLm+2ostyzxwvzNev
	onD7Dk4NmjzQB5i+RcG1UcWzMbpWkpLCdQ+Xfw4ExPqY02Gcmf9pNT7UfLV6DOUxQD6a9/SrwwN
	qIWpCoTj6jzRMWKJDVoIgXRDlkGkSTBtWuskBdWDhGdJnAj1icv2sBQ9qumAGqPBCemDh5cww9u
	WyTPz3/ZP46ohCFW3JSLgLOvoWcBuIsChlOBRYj8Cl1Rpd1HSrNl92
X-Google-Smtp-Source: AGHT+IFq6w36inwR7PpG+ZkZbBwkFGa55fsBXWBVdNad663sGiVEFpxwXvkazBKvYy9SUPhOCmUAYg==
X-Received: by 2002:a05:6000:40df:b0:3ec:42ad:591 with SMTP id ffacd0b85a97d-42704d9899emr12228828f8f.36.1761037346574;
        Tue, 21 Oct 2025 02:02:26 -0700 (PDT)
Received: from ?IPV6:2001:a61:1369:8e01:d78f:5536:188:1544? ([2001:a61:1369:8e01:d78f:5536:188:1544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ba070sm19511194f8f.42.2025.10.21.02.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:02:26 -0700 (PDT)
Message-ID: <806d82e6-6db6-4ec8-a49c-665a97ea36f8@suse.com>
Date: Tue, 21 Oct 2025 11:02:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device driver
 for config selection
To: Michal Pecio <michal.pecio@gmail.com>, Oliver Neukum <oneukum@suse.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, yicongsrfy@163.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <20251013110753.0f640774.michal.pecio@gmail.com>
 <20251017024229.1959295-1-yicongsrfy@163.com>
 <db3db4c6-d019-49d0-92ad-96427341589c@rowland.harvard.edu>
 <20251017191511.6dd841e9.michal.pecio@gmail.com>
 <bda50568-a05d-4241-adbe-18efb2251d6e@rowland.harvard.edu>
 <20251018172156.69e93897.michal.pecio@gmail.com>
 <2fae9966-5e3a-488b-8ab5-51d46488e097@suse.com>
 <20251020175921.37f35e5a.michal.pecio@gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20251020175921.37f35e5a.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.10.25 17:59, Michal Pecio wrote:
> On Mon, 20 Oct 2025 11:59:06 +0200, Oliver Neukum wrote:
>> On 18.10.25 17:21, Michal Pecio wrote:

>>> @@ -1255,6 +1257,8 @@ struct usb_driver {
>>>    
>>>    	void (*shutdown)(struct usb_interface *intf);
>>>    
>>> +	bool (*preferred)(struct usb_device *udev);
>>
>> I am sorry, but this is a bit clunky. If you really want to
>> introduce such a method, why not just return the preferred
>> configuration?
> 
> Because I wanted to introduce exactly such a method, rather than one
> which returns the configuration ;)

Well, then I have to state that your patch perfectly implements
your wish. >:->
Would you allow me a follow up question, though? Why have you
developed that wish?

> The point was to pull configuration selection *out* of those drivers.

While I appreciate the goal, it is not clear to me how adding
a method to the generic interface driver template achieves that goal.
In fact this approach seems counterproductive.

In particular a bool will not work for the generic case.
If you really want to make this generic, you'll have to face
the unfortunate possibility that a configuration have
multiple interfaces whose drivers disagree in that regard.
At a minimum you'd have to be able to return a "don't care"
value to compute a reasonable pick.
  > They already do it, and it makes them copy-paste the same trivial loop
> which iterates through configs until it finds the vendor interface.

If the concern is simply getting the code centralized (which
is not wrong), then Alan's original proposal of having a flag
(let's not call it a quirk) in usbcore for devices that need
the logic in the heuristic for picking a configuration to be
inverted would seem to be the simplest approach.

> The idea is to have a maximally simple check for a known-good vendor
> interface driver before making unfounded assumptions like:
> 
> /* From the remaining configs, choose the first one whose
>   * first interface is for a non-vendor-specific class.
>   * Reason: Linux is more likely to have a class driver
>   * than a vendor-specific driver. */
> 
> Unfortunately, that's only half the battle. The other half is forcing
> configuration reevaluation when such a driver is loaded. I hoped it

Exactly. Hence don't put the information that the assumption
must not be made into a driver but into usbcore. Problem avoided.

It looks like this is an issue we are not going to find a perfect
solution for. Hence our priority should be finding the simplest
change. IMHO that's a new quirk just inverting existing logic.
Sure, it is a bit ugly because it depends on the kernel configuration,
but that is what we have a preprocessor for.

	Regards
		Oliver



