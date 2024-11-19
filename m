Return-Path: <netdev+bounces-146056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB619D1D99
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB4E3B20BF0
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 01:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030613398A;
	Tue, 19 Nov 2024 01:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asG2kWQl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC8C4C79
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731981015; cv=none; b=AzORTIvFJJ7lgcpZO6tqte3WtGYYsjsueeEfZp8ZnQ7e316eEsC32yvt/ahUl3UIUqTl6zlakuRmy5cuwvJVF+vYa8S24hq9aMeMEpFt/eemO94+i8Z6GHt2geCCmPuVpHUnAGBZYFd69kAFW7U33fblNdwtvN5ZEABqo0s9ssQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731981015; c=relaxed/simple;
	bh=XmZaWXP8lPpVl5bq5eIK+W/qcxcqwDu/KBzYweKyTVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Blblef1nr6GWqIg+iGB2sEh1CVBoXBwL+NEo/xJyKNUKr5iDn18Ip42bztDmMlvW83YEpOfxjjV2gn6qgGFiXGwtkPJ4LCOIdn9pH/4ilPgfUv5BtjOMh6H4/4i1paZCGqTxRS3O2wKZN2dUWi48ILoC9AqB6GqOGiNapiNV99o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asG2kWQl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38248b810ffso303419f8f.0
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 17:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731981013; x=1732585813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZU9m1MkdWx4i6vZAKzVum+IVfxNM41Y0ukpBjBroxA=;
        b=asG2kWQlKltsIRASGT8W6iZiTZ1s35EimHifXYAZ1eBkJtwCFmHD4U/4d7XvJLC5xW
         zqTa5ieMstggEbw5A3PeKH7ysKTEwzwiLAiSxZwf9tUEJck6G267a9wSvT4WOJ2pet44
         SLk8wH0y9jsVpqwB2S0KhzRAct+OGPJFcmiQpGni5cMepDumZSYY+6FVCk72tmKk+HbO
         LdOSkKbIGxKyyTG2BX7Cv0KfBCHfCbDEH5R+b7H8qNy+fu7Ju4A/bvSrKwbMX4SLtEuQ
         wmLBYitjGIEpbVa6pvsUL+PMrjjEbBT0v8wjURqBG7H71zihFJOnn9i4aQXgPiZDp00h
         rzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731981013; x=1732585813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZU9m1MkdWx4i6vZAKzVum+IVfxNM41Y0ukpBjBroxA=;
        b=wr2Y2kr7hXd0iagQLGcMUvCx50zIAo4PH0sklg5OT26/7bjVdJdb7Y9zLZXsZfrlko
         vLnVf0PpvKPFs8qfj9PzQlRfDcJfh/wBksGi+pYXffFTxwv0xA1Yugj3eM1QM6MEKseB
         3jMYbzRNV0PF1jjO8Lo6HQxWlv/pbquDxhrpziegQjE8cT2aF2wbXy6Udf3OfSsbcqRp
         pGAgfsHe3aMFCCtj+gx3Z4LoTP2XvhVsfvFzZOBL3EmT9Z8AdbDpeVzYCWZ9qr/0OHJz
         fZANKmFUwQcJV6JnAbv4gL7cWzsOPX5xUQISJc/szxzcoS13aaYLi/4dbugWTzZLs6+9
         xXTg==
X-Forwarded-Encrypted: i=1; AJvYcCWWEmWj5f5br99lKAm1ivV5sYrUlhQcqlSWcm8Uxadub4U5YLdMvdAHA7TjcZDp84eMs1cjGXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVfHmr1Kj5xc9fAGMLj2N/hFBUrsHEO02Kfl8ZLMmMptjHy6/O
	4VPwW3qFYF2mMbKHZy/PCD0Ppst9NOWfAO8bij70TUQBzyIjPrTp
X-Google-Smtp-Source: AGHT+IHlOI4F0kpcJOGv0iEQ33+t3UPrLsLMx4Chv12jG/53XXfwtQzEFnpW7KqtOrTwbh7/wRbVtA==
X-Received: by 2002:a5d:5d89:0:b0:37d:4647:154e with SMTP id ffacd0b85a97d-382258f10b2mr12237535f8f.9.1731981012634;
        Mon, 18 Nov 2024 17:50:12 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3822eb34170sm10389757f8f.11.2024.11.18.17.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 17:50:11 -0800 (PST)
Message-ID: <de5f6ecd-e3c9-4a14-a9ba-12614f19f191@gmail.com>
Date: Tue, 19 Nov 2024 03:50:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v2] [PATCH net-next v2] net: wwan: t7xx: Change
 PM_AUTOSUSPEND_MS to 5000
To: Jakub Kicinski <kuba@kernel.org>
Cc: wojackbb@gmail.com, netdev@vger.kernel.org,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 angelogioacchino.delregno@collabora.com, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com
References: <20241114102002.481081-1-wojackbb@gmail.com>
 <6835fde6-0863-49e8-90e8-be88e86ef346@gmail.com>
 <20241115152153.5678682f@kernel.org>
 <7e5e2bda-e80d-46ec-816a-613c5808222e@gmail.com>
 <20241118174456.463c2817@kernel.org>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241118174456.463c2817@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.11.2024 03:44, Jakub Kicinski wrote:
> On Tue, 19 Nov 2024 03:01:47 +0200 Sergey Ryazanov wrote:
>>> He's decreasing the sleep timer from 20 to 5 sec, both of which
>>> are very high for networking, anyway. You appear to be questioning
>>> autosuspend itself but it seems to have been added 2 years ago already.
>>>
>>> What am I missing?
>>
>> Some possible funny side-effect of sleeping with this chipset. Like
>> loosing network connection and dropping TCP sessions. I hope that 20
>> seconds was putted on purpose.
>>
>> Suddenly, I don't have this modem at hand and want to be sure that we
>> are not going to receive a stream of bug reports.
> 
> Power saving is always tricky, but they say they tested. I think we
> should give it a go, worst case - it will be an easy revert.

Make sense. Then let's merge it.

Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>


