Return-Path: <netdev+bounces-69269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F0184A8CD
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7862B21CD8
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08D51DA4F;
	Mon,  5 Feb 2024 21:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KStEYuci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE7D1DA24
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707169839; cv=none; b=TCFoXvcpHzOHb5rnbpGEPuSJmZAoew90juxHccAx28hvjSV14J7T/rOLjYs7VRnhqz0OAhXrozurKnJ24or5RLVUEFBnNIwp2sidbVIWaaNQcNPRiXtBOcoZxVM/8fNcDX53BMXABz53Z6fWYN3RPcBAtTy4a5Pxak0gCOqUU9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707169839; c=relaxed/simple;
	bh=2qtdM/RW3Qo3d9j+hX1GT4l/+HNOZAnYDYooMm2hVAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kokH2B9T3gd+qOse96mzQ7X5eHbIJhlPWJnYBA0WFDKZJ9yVGU96lWyNA54Mggf8yT9DLtJXKSh3oAgIouzj3F0HaUqSZnaUSDeYOaIbtnMvKKdfmmiLJGpVFDT5fRYuS+O6eKjZ5UZyry1ZiJPuHdoxco4yYGbiQqaE0hO1+AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KStEYuci; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3beab443a63so3879621b6e.3
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 13:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707169837; x=1707774637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5FNsHW3FBVMgexZ4WHrukCC2LGz2frVd4K4npLWqRQ=;
        b=KStEYucila0YcAoD+wYp4djDWp92hCTGoACcMfJmm9y9ieTiLoXxP748chL0CMewXh
         hK+K2fn9hdpE7lPkgZRoUZIUbYn281dkpWvIAxnTqWH/ZWIeAvi4Du1yXkSjmr5tqJ2h
         3K3hKEDkDh0JMBQHhWV+ZgQNC2Ji1m/x/4BKIBEbnTYApdRoRLsQGT9X4CnPKzo2gKaX
         Zq4CiaeNi5e+TPPMBC4DZPMm5ZxOmbLqMq4+tXd/wj2V5BB59MnAwqBmZB0B02cvpt5/
         BRR6NGOJI6Uk00rX3aZakM4ElM5RtPM9kVN+j98rDvEfJGVQvMZfn7k8b1oo/ChzFyGd
         SSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707169837; x=1707774637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5FNsHW3FBVMgexZ4WHrukCC2LGz2frVd4K4npLWqRQ=;
        b=vyXFeMRa9DusRZ2Ck0tsUoZ+elHcGA0Llxf63qRyNvme4eEo/hbxeKHqtTetzg3BrD
         4L1ZqomTxEWc2Wnm7rIB5qD4H4IPe2EOSLYfhcBCloiZsn71eR8W0TNXA+v1lqCXn8Rg
         z/LNItzDLcv3rV70AfJ9EieQxS98o+rk7+S519lDa0VmEW44dJAPkeP+ItqsZfr1Sth5
         rH0sppkpoi1W9TzYj4ZTncUFjqsy6R3meXLCf1gsO8pOae+uE4B1uGBGPfV3FKIQKvvZ
         ydQAHXqEI1w6/+jh2PQAX6M5xLzNOccXrb2yMPJguJKQi97m/tvkAct01NFM8jLFpwRP
         eYOg==
X-Gm-Message-State: AOJu0YwUYNmUjlsFqNtrjhG5GArsvG7M05osLd7NqrSEz5fTAHjSoLR3
	MXQ9CAuaDXqpc6IovKpCf0hBKm02cqPAyGAIi9Ry6BzLONxTibSd
X-Google-Smtp-Source: AGHT+IFTI/xH9JW4Bj572CNiScIYgzWTsG0mT5xp3HwcGdPoNkefvqf2LlYEjfAnHu8fRZIFzNeFLg==
X-Received: by 2002:a05:6358:3408:b0:176:5b4f:492b with SMTP id h8-20020a056358340800b001765b4f492bmr1062261rwd.12.1707169837281;
        Mon, 05 Feb 2024 13:50:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXP/1eeqwY+8KB9DpmTvrj/H3cqsUMAMvM2fFf29bBNpwfjxjHPIzL2RyJSRPXS3rpYDFiPfrG+d/HfUygz4mZY0LjB+mdZMU6GTzQfOB46pr79vtabgblSnYtt/AeckqJiIC2uxZUu6nccx9irRW38LCoHgcmhRJVdIkbGSelrS0dIFZqfkwlf7ra+qAnJPiRZjKtdxNEjoFdfOv74WWaDyMRdeB76nVpGywmCkjgHIH5mBjtEvDSP6ihyFCyBDTaGgRLDArVt2GVUy4a4AUkyZylBpMt9ACsDFBtsGvA=
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id a34-20020a634d22000000b005dc120fa3b2sm535884pgb.18.2024.02.05.13.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 13:50:36 -0800 (PST)
Message-ID: <0ba9eb60-9634-4378-8cbb-aea40b947142@gmail.com>
Date: Mon, 5 Feb 2024 13:50:35 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: stmmac on Banana PI CPU stalls since Linux 6.6
Content-Language: en-US
To: Marc Haber <mh+netdev@zugschlus.de>, =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?=
 <petr@tesarici.cz>
Cc: Andrew Lunn <andrew@lunn.ch>, alexandre.torgue@foss.st.com,
 Jose Abreu <joabreu@synopsys.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Jisheng Zhang <jszhang@kernel.org>,
 netdev@vger.kernel.org
References: <Za173PhviYg-1qIn@torres.zugschlus.de>
 <8efb36c2-a696-4de7-b3d7-2238d4ab5ebb@lunn.ch>
 <ZbKiBKj7Ljkx6NCO@torres.zugschlus.de>
 <229642a6-3bbb-4ec8-9240-7b8e3dc57345@lunn.ch>
 <99682651-06b4-4c69-b693-a0a06947b2ca@gmail.com>
 <20240126085122.21e0a8a2@meshulam.tesarici.cz>
 <ZbOPXAFfWujlk20q@torres.zugschlus.de>
 <20240126121028.2463aa68@meshulam.tesarici.cz>
 <ZcFBL6tCPMtmcc7c@torres.zugschlus.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <ZcFBL6tCPMtmcc7c@torres.zugschlus.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/5/24 12:12, Marc Haber wrote:
> On Fri, Jan 26, 2024 at 12:10:28PM +0100, Petr Tesařík wrote:
>> Then you may want to start by verifying that it is indeed the same
>> issue. Try the linked patch.
> 
> The linked patch seemed to help for 6.7.2, the test machine ran for five
> days without problems. After going to unpatched 6.7.2, the issue was
> back in six hours.

Do you mind responding to Petr's patch with a Tested-by? Thanks!
-- 
Florian


