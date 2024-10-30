Return-Path: <netdev+bounces-140461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEC79B6956
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28D11C21289
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFB02144DF;
	Wed, 30 Oct 2024 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltw3ARVi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705E72144C9;
	Wed, 30 Oct 2024 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306264; cv=none; b=rQi5nTkwOrGwEq0pJ2HWHoJrxDOxgxgTlO3bBVJDOPX/NXOfhnN5QAdnjG/teR3GxkN1rzFzdzxP3ZwCxAqv/bWHM9YIQkZY8VVVX9C4lDnQZvXjojFiZE6pzLK3LLLsbaOkAqdVpkuzfNSnjmCV13KzFpNQWO2eiOQlnoeXx60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306264; c=relaxed/simple;
	bh=sCY0w3VD4odRWekYObGS894m4RuwrInm7tMT0C1bEqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KiCY73iIVrCT3CYUTpK4JnsPaJS8aFOrwrTyInCRc45FhK0+KVg/OBz/7HwS4c0R3APyR/r4qcM/88k68D5rzk4lu2SLy5AxA9uTSe1vKs+zld0sdoKjdsAkc5jy9ZrOe6wOkAGfk6tQUhDweA4Jl42cigojFoBOiQ1mquOvm58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltw3ARVi; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbcc2bd800so639266d6.0;
        Wed, 30 Oct 2024 09:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730306261; x=1730911061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qrjSxxZFNepfrOGkNe6olzeXIV0Uuplhou7dNohvm2s=;
        b=ltw3ARViytl8/ar3a53d3wwcrOk/LNed0eBDGpYUPvqNwyNe++nJSIO5yZzsrm/5Qk
         l7dFsZBkbax/Uoy19b8cBpwf2H3be/VucKwjm/vZreH9+1clWuQ87PM5reQYD6+mVC94
         z2i0bUvNwXv/HW8K7NEBVU7GFBO6VBnWIWp8NCWxzGiAJvlZoOTI6otuUzcI0gjYeCvc
         ldSlTuqz4xkhfx3rKbeZVLDm9TBjcaZyuIGfsTOLqfSUNa8DzIzB9vRemrTjTJQd0RBc
         UyHwy0V0D2dR7FS4FSaN48hQM1O9miRnXZsr5UTu4Kwd8wdFrDInFHXbwlrAqB866i1W
         I29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730306261; x=1730911061;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrjSxxZFNepfrOGkNe6olzeXIV0Uuplhou7dNohvm2s=;
        b=uMsNRaT0IG4W3OocO4m5MDqVVC73C662equ/6ZTN+fMyAR69XkgJF0hPvl1IEGke42
         Lv2TeMS0AwlRyDCe06IsHabkGSRaEu3Ucr2xR3EumVRHGW61ZeRZDYaLYcHpD4B0AFp4
         R4Z3WqDl2oIzOE81oVhsklpUB5Ela8ScFgy4AtK42HW7qDr9ynC35Y03cuddJUkXMN1t
         P74kE0lBs60atQ2VOlbqI+DPmRZAzjbFANAU97HuROvKDbRpHY0UTz6iD5hy5YGGb7UQ
         nKHDT/3CsZQQUKXRbgmRcpp2YTdl6lcZMrvEcYvcLL5WejfRSNwPKHfmJ1R9xi//Alb2
         31hg==
X-Forwarded-Encrypted: i=1; AJvYcCUwtCFm8Fvi7mwL7DxFH1HPSiKjnnkjj6T7A8UJIZR0oqTqjRFUYJdgdkBVdUfz6ij7FVMQ6nSZy51k268=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnbIlKFn2uFp4bVbmJc8lL1vU9sBMxHT6SZpaFeiUREFX4Z+fF
	xkbhvf6SjQ+Et8lYVHLOkzfNHOK+JIyBhK9WKNRu0bImZs22ZfmLy4yGcA==
X-Google-Smtp-Source: AGHT+IFcfo/oFHyE/4sxV/qekT9fnbfD3S9MMpwsJAR0TQIEsgJ4+TXghKYO+6sz845pmslJ9ACCAQ==
X-Received: by 2002:a05:6214:2f82:b0:6cb:49d2:c700 with SMTP id 6a1803df08f44-6d2e7269b06mr102766516d6.22.1730306261221;
        Wed, 30 Oct 2024 09:37:41 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17991329bsm53270256d6.58.2024.10.30.09.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 09:37:40 -0700 (PDT)
Message-ID: <a66b52f3-f755-47ae-858d-ec784c985a06@gmail.com>
Date: Wed, 30 Oct 2024 09:37:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] MAINTAINERS: Remove self from DSA entry
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch,
 open list <linux-kernel@vger.kernel.org>
References: <20241029003659.3853796-1-f.fainelli@gmail.com>
 <20241029104946.epsq2sw54ahkvv26@skbuf>
 <20241029003659.3853796-1-f.fainelli@gmail.com>
 <20241029104946.epsq2sw54ahkvv26@skbuf>
 <d7bc3c5f-2788-4878-b6cc-69657607a34c@gmail.com>
 <d7bc3c5f-2788-4878-b6cc-69657607a34c@gmail.com>
 <20241030145318.uoixalp5ty7jv45z@skbuf>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20241030145318.uoixalp5ty7jv45z@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/24 07:53, Vladimir Oltean wrote:
> On Tue, Oct 29, 2024 at 09:05:51AM -0700, Florian Fainelli wrote:
>> On 10/29/24 03:49, Vladimir Oltean wrote:
>>> This is unexpected. What has happened?
>>
>> Nothing, and that's the main motivation, most, if not all of my reviews of
>> DSA patches have been extremely superficial and mostly an additional stamp
>> on top of someone's else review. At this point I don't feel like I am
>> contributing anything to the subsystem that warrants me being listed as a
>> maintainer of that subsystem. There are other factors like having a somewhat
>> different role from when I was working on DSA at the time.
>> -- 
>> Florian
> 
> I see. There's nothing wrong that priorities change. Thank you for the
> benefit you've brought to the DSA subsystem with your journey, starting with
> transitioning non-Marvell switches to it from swconfig, to papers, presentations,
> being nice and patient to newcomers (me at least).

And thank you for having stepped as up as maintainer when being asked 
to. I am really happy to see what has happened since your tenure, and 
that the unstated world domination of DSA in the SoHo switches is 
actually working :D

> 
> I kinda wish there was a way for people to get recognition for their work
> in CREDITS even if they don't disappear completely from the picture.
> Hmm, looking at that file, I do recognize some familiar names who are still
> active in other areas: Geert Uytterhoeven, Arnd Bergmann, Marc Zyngier...
> Would you be interested in getting moved there? At least I believe that
> your contribution is significant enough to deserve that.

OK, if you feel this is deserved, sure why not, thanks!
-- 
Florian

