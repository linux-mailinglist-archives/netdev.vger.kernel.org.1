Return-Path: <netdev+bounces-134894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C99C99B862
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 07:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23CA7B20925
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 05:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752A42AD18;
	Sun, 13 Oct 2024 05:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="hgp8jpwt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E108F17FE
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 05:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728797220; cv=none; b=DKuzKUIPHA3dW7fPz7snUdiQf5BVwS7g5OVEA8DOaDcMhbtUu1DZcDQODz/Qb5H4oH8JVE8od4E8vIVllGK/EDBgrVXLC5JG2Jztl+MraS/jtk0eFj7h7ulUyXI3Aanr7tzu6BlHSHfmXGoXW5GqvB0hEl3ovCqLPAHPQcUgIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728797220; c=relaxed/simple;
	bh=7Uk7OcuY3UsKDkeTFo1sU1Lk2dGYbQcfKn5jt6I0p7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmLMnkJPra6cYPFjfA0q//nGjmTwKa3iibuv7ZlW+DSDIVb3qVh2gWsGJoUIzjVO6ynUV0avfUHeQLaCxJyIa424xycEpGB/QA2GezLCB6khxa8Sfok6tQ+HhTbgnxVXtokZIPfz2+qRSHLk8rFmpevQxsS783zYrjvxxyJGlr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=hgp8jpwt; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2d83f15f3so545772a91.0
        for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 22:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1728797218; x=1729402018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J30sTpo+/8Jq4SiE6mz4sDossUSCVQFGrQyf81sFG6w=;
        b=hgp8jpwtdk+GYY39TAdaxa3RnVdQRHlZ/AJTNgTZWeLuO3kUgu5Mxwh9Lsn8MSLdZF
         LTy9YTapIBTI8xUJGtTEBEyjAUCVAQgzovq44m3cW10jV6+J71/2Gc0HARd1EbbSvrLL
         GLT7kdGCWXVtmsjfptdGW0CQh8ylTUWvMWWkYzrXXdFhlVSASmr8J/i8eIfBUIrBm71r
         weZIUxdDYNXWfW3cqhmZ055fkdx/HfAzRF//9LEszYkvDaMMjg5gZ/mVkd6qcCR9theG
         x6CTdIvoChfyBcL4+N1Tb0MUCSYuG1mFvO8THyCetbdi4zuBN8pp1H4xEd2SvExza7eu
         yjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728797218; x=1729402018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J30sTpo+/8Jq4SiE6mz4sDossUSCVQFGrQyf81sFG6w=;
        b=j//1lAsKLH62pp7gLuAb3oHe28EbsrhMCw9MWC4OncMhJPUslxhn/1IELGKOaTjer4
         mNPBInzfuPEYARJWGl1HHQ1olmAuzhaYXRrDw53ydA6wlfh3rfhtg15WREm4AWbFGUCp
         rK6lollHYjnohXycyLKWYlhvK3Sou4lmFl9op8r4ij1b71jC0PvIb1Flq8j6e/aIfrPN
         907/vny173yU/ZLQ/UIRJ9OLnWDbrscmp0jPYhS6+RpQb5/hNx71KRd5gcnnqIDG+E4j
         a5qbO5lupBkCCW2h/6ZTIMh9tqBTX9KWTg4V4dfeFbTBREhUz+knK5DygMZOAwkUAmOc
         sBoQ==
X-Gm-Message-State: AOJu0YyaTS0DpLJpVTo8NaFiOsKcFZcYdMbZsecgG+ZZDQ9FjIJ0w2Jt
	badiSnOk7KTuhkHVQI1TGoyArPu6ca60wKZzvzZ1QGMBl7GUaL6XUWglNpzRUOhJ7Ej7asGL2Qi
	fi63ABw==
X-Google-Smtp-Source: AGHT+IFUJOgRGusVCIMUm1LnShhOu+To2vzjupRPE8JKxVhaqbO+f2do7sXupyryOM5b1MrWhUPNhw==
X-Received: by 2002:a17:902:e2d2:b0:20c:a7d8:e419 with SMTP id d9443c01a7336-20ca7d8e5d1mr41677205ad.4.1728797218113;
        Sat, 12 Oct 2024 22:26:58 -0700 (PDT)
Received: from [10.0.0.211] ([132.147.84.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e751fsm45009505ad.139.2024.10.12.22.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 22:26:57 -0700 (PDT)
Message-ID: <1c768936-9306-4bb9-8a2f-1e21e09e4b56@shenghaoyang.info>
Date: Sun, 13 Oct 2024 13:26:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 2/3] net: dsa: mv88e6xxx: read cycle counter period
 from hardware
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
 pavana.sharma@digi.com, ashkan.boldaji@digi.com, kabel@kernel.org
References: <20241006145951.719162-1-me@shenghaoyang.info>
 <20241006145951.719162-3-me@shenghaoyang.info>
 <9b1fe702-39b2-4492-b107-f1b3e7f3c2a9@lunn.ch>
Content-Language: en-US
From: Shenghao Yang <me@shenghaoyang.info>
In-Reply-To: <9b1fe702-39b2-4492-b107-f1b3e7f3c2a9@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


>> diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
>>  struct mv88e6xxx_ptp_ops;
>>  struct mv88e6xxx_pcs_ops;
>> +struct mv88e6xxx_cc_coeffs;
>>  
>> -struct mv88e6xxx_cc_coeffs;
>> -
> 
> It is better to put it in the correct place with the first patch,
> rather than move it in the second patch.

Hi Andrew,

Thanks! Happy to spin a v3 if preferred.
 
>>  	memset(&chip->tstamp_cc, 0, sizeof(chip->tstamp_cc));
>>  	chip->tstamp_cc.read	= mv88e6xxx_ptp_clock_read;
>>  	chip->tstamp_cc.mask	= CYCLECOUNTER_MASK(32);
>> -	chip->tstamp_cc.mult	= ptp_ops->cc_coeffs->cc_mult;
>> -	chip->tstamp_cc.shift	= ptp_ops->cc_coeffs->cc_shift;
>> +	chip->tstamp_cc.mult	= chip->cc_coeffs->cc_mult;
>> +	chip->tstamp_cc.shift	= chip->cc_coeffs->cc_shift;
> 
> Once these patches are merged, it would be nice to remove
> chip->tstamp_cc.mult and chip->tstamp_cc.shift and use
> chip->cc_coeffs->cc_mult and chip->cc_coeffs->cc_shift. We don't need
> the same values in two places.

I've looked around a bit and this doesn't seem possible - the common
timecounter code in time/timecounter.c and linux/timecounter.h has a
dependency on the cc_mult and cc_shift fields within the cyclecounter
tstamp_cc.

We can't remove that dependency without specializing it for mv88e6xxx.

Shenghao


