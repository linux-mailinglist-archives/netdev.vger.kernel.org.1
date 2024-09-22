Return-Path: <netdev+bounces-129169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D78F97E10D
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 13:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D55B281356
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 11:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2961813E41A;
	Sun, 22 Sep 2024 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="Zfw/N6WP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA8661FCF
	for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727003754; cv=none; b=ENhw+E2h8rwxrRENVTOy9chdI64vFCwKe4PLI1wiI05ief+sIsNCmB0/HymfV6Kl+gVJQfHKrxsEp1LGiVgFuGgThaTaVoxOzbWJZ9rxHxZ8B9y/wMFfpuQM6HvGrsR6erUfWJKaLNNEAZZZl6ejpAKCigcpHj1aZgnd1MqtCdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727003754; c=relaxed/simple;
	bh=4/dScP+2VQqp9NFo5BKqQJm+LB0XzWQueMyqbRCUJGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVD5awLFfLpQ5fA5YGUDn+DaXTvjW+zWFHi+OLWYOP19WL5GcC739yLxU0MCACIJJ9KJBoR8yQb64uiADGi9UaZSafbKvh+QlE/IciRvevn8F5WLh3JXDh2OOcWXt8iCVLuKAhAOPzumzzuiLNmGAFkRaRqJrrTtGlIw8AFTDuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=Zfw/N6WP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71829963767so555353b3a.1
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 04:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1727003752; x=1727608552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kV9jAwUKEZ+8tKEPZlUQ5QDr08hfJQBG5o5GR2sFVE=;
        b=Zfw/N6WP1vrOuuhWlXVhj4TecuFveVcd3W/fsBuebjzb35Kffjc2jNbDnJH/UJGRIy
         jW2tECZp25YAxDaH07bHBE4hcknCBB7H3Qux2xnqiIUuqOXAfED6oZK4nkr943e/jSwI
         5PeASC5l4Evln1XEtrqKqPUmvvzs1gIXXRw/yV8X5yKzQBD36RNVn0yedIkFnsj2MUZI
         lUPCucXOHzaDb/Syem4Yv6YpvG8oWE8tm7EOnQ3MAr05d9ioVR8em0f29Lz383zCGtxP
         wu1H8Tjbhbu9j7SswonivzrgqSx3B4XEqoBGa5M9AWvg5GKaoIOvcXfJ70qbclbLonoO
         162Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727003752; x=1727608552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kV9jAwUKEZ+8tKEPZlUQ5QDr08hfJQBG5o5GR2sFVE=;
        b=m+fs/U9Vd+Tvz9zjkpcbB8c/jlS6fsRcIoJH8/KZzHkAnfFI9rE3LGeOGK4+6zdP/z
         6o2MbDaXY8NyuYRLng/Xma8H16VifJk774g+9NjS3z5gYJr0B1uvOZoXA7DJRT04xeUt
         5ECqsoidrPF+EUi5/TJsuvOGb4ap6P0D3e0jZiszIbK9HrXc586uTEAZALR+F51bfcvC
         5fhGZWdAa3xqTEm4EQogiKkCSZ0Vyjl32z05g4BKHRDIY8b1i3mN8lwOToN2V26QMT8N
         kxjrTJqu4qwogVsES0uqdWRMmP/fA9XGd/hpjyTnmXOECO0FYy+506ytXAydzBHqtUVI
         C0+g==
X-Gm-Message-State: AOJu0Yw7unUVJz7hebcSMo8drmqqehZw7FU10LcM8aiMrlPf8QzP0LgJ
	7nyBZRzh18UY7dI5/g31LScRuLW4+5MTqzGE8KP7dfcu953XBx0C/dXgQA20isI=
X-Google-Smtp-Source: AGHT+IE5MjTVYzrl2d8pU+oadwG+bK6ciogNKH4nYOjHCfD0YV6tB1eRzdMqfGZePYuIyMKLOORTYQ==
X-Received: by 2002:a17:90b:538e:b0:2db:60b:eec with SMTP id 98e67ed59e1d1-2dd7f6db764mr4222811a91.7.1727003750258;
        Sun, 22 Sep 2024 04:15:50 -0700 (PDT)
Received: from [10.0.0.211] ([132.147.84.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd7f7ba647sm5283445a91.11.2024.09.22.04.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 04:15:49 -0700 (PDT)
Message-ID: <890714d7-bc6a-45b2-854b-d1b431f8a0eb@shenghaoyang.info>
Date: Sun, 22 Sep 2024 19:15:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] net: dsa: mv88e6xxx: correct CC scale factor for
 88E6393X
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
 pavana.sharma@digi.com, ashkan.boldaji@digi.com, kabel@kernel.org
References: <b940ddf9-745f-4f2a-a29e-d6efe64de9a8@shenghaoyang.info>
 <d6622575-bf1b-445a-b08f-2739e3642aae@lunn.ch>
Content-Language: en-US
From: Shenghao Yang <me@shenghaoyang.info>
In-Reply-To: <d6622575-bf1b-445a-b08f-2739e3642aae@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/9/24 03:14, Andrew Lunn wrote:
> On Sun, Sep 15, 2024 at 07:57:27PM +0800, Shenghao Yang wrote:
>> Sending this as an RFC: no datasheet access - this
>> scaling factor may not be correct for all boards if this
>> 4ns vs 8ns discrepancy is down to physical design.
>>
>> If the counter is truly spec'd to always count at
>> 250MHz other chips in the same family may need
>> correction too.
> 
> This sort of text should be placed below the --- marker so it is not
> part of the commit message which actually get merged.

Hi Andrew,

Gotcha - I'll move things around in the future.

> There is a register MV88E6XXX_TAI_CLOCK_PERIOD which indicates the
> period of one clock tick. It probably defaults to 0x0FA0, or 4000
> decimal which should be correct for the internal clock. But if an
> external clock is being used, it needs to be set to 0x1F40, or 8000
> decimal. It would be good if you could read it out and see if it is
> correct by default.

Thanks! The register appears to contain the correct value on this
device - 4000ps using the 250MHz internal clock.

Would you happen to know if that register is valid for all the
families currently supported? 

I'm preparing a few patches to read off that register in 
mv88e6xxx_ptp_setup() and choose a correct set of cycle counter
coefficients to avoid introducing more device-specific handling.

If that sounds reasonable I'll send them for net - would you also be
okay with a Suggested-By?

Shenghao

