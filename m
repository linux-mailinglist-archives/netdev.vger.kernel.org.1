Return-Path: <netdev+bounces-63762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3491382F480
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 19:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D0528443F
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 18:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C051CFBD;
	Tue, 16 Jan 2024 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgQCU6Xd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AD11CFAF;
	Tue, 16 Jan 2024 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430589; cv=none; b=g/io5n5MoMG0BAIptmozpxAIcg69P/sBS65DctskZmNoV5PCQGXmhr98lXbRrNzb9QViVDZ+2qlQEyRZpkQJ1yqmhdfybnZWtbkbn3hTgN4PoUKdbSLrpuuLIcHC6zIwpJf9QWd5i1F2v4yjFmIjEiy7+kbkZPrQMnop1QVI/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430589; c=relaxed/simple;
	bh=rrXCIACSz2VKSYbomB22s2eNldDuZRugBrdN6o1o9Ik=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=m+yGc+8NELSNPZgc+26SoBcFtcF4ASTiGdPrkFjTDEsOJEIuxih00geoWAMqP80FcYI0OuzuDUiqxEidZtlWH7kG2M/shIkjEBijw/c9A1cP9KNhRZJZSkl9wDw1nDhdXIFfzTnPZTGl1sLeO28gDExMJILqQGw3EsQ1htFRUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgQCU6Xd; arc=none smtp.client-ip=209.85.161.51
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-598bcccca79so2676376eaf.2;
        Tue, 16 Jan 2024 10:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705430587; x=1706035387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BkaTD3XQ3icbm8biJaeCeY6hiUXnM/nhP+ZeZfSx7wI=;
        b=TgQCU6Xdfj9kmyYEw5wU30zPDh4hKReYOeuRZVCKumbFJ7YFAXhHNGcg2LGAtkuO56
         aVmuM5bg0kI6hYAgJ6BdNas/8BkHlJbsBQqwKYbOdfIQA8L63q72AOhWHAl0UWLYQ3E0
         aNmQUa6RuDSW8YfediKxveDaK4spRMCV4X4GnUm7SnWcvyweiTvzlAlWQa2cdCi4klr+
         +bmWUEM0EhtMbCgDGYI5SGRItriIkmxozWQ1t9pn/c7XGc3nj5BgGAJuG9Iu3zPPIuSD
         9F9K+jQkYEhXOKbM+G+orXMpAf9EkAdyMPdMV0dHLY61l5qMLEFb2MZBn44EAOQDAa0c
         EiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705430587; x=1706035387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkaTD3XQ3icbm8biJaeCeY6hiUXnM/nhP+ZeZfSx7wI=;
        b=Ai44wmLEeWSbAgD0x9AJTmBTzJ0Gqaly6wgd/yJjxXBwo6yy+/bZ4zQ1fYQAUK1r3E
         CDfdbX8D/BMaXaqti9/rFTdIqOTuZ/jPfzekfBNpU3h9IoWSQ+xQ4XWjdRtBz6UdkYtR
         C+FgBzh4nX9/l3BjXKreH7iWPrTMYBJaQQJTLR1hgVk94GT9xaiscpoVimQZxt2WGQPb
         e3l5Asuy8SinnOgjZcpsXIPLcEz7qkiD2FKPuXuuEHlptAtmfaZqga4xgav2qfTx6PiN
         W8OdBwagIhUg5IAH4cKhULsjaTbQzQkQCgF6V6JIAk4ojWr0SHTFxiGRXQiuerZUq7Wn
         q9GA==
X-Gm-Message-State: AOJu0YzoclXFY6w6bd8nSfoqXSX4gybPI+OTU3TnUt+QYWq19auii/v/
	+kUqOHg7p5P3Sd52lA4yXhg=
X-Google-Smtp-Source: AGHT+IGF3RZvyOjDn9GOp8pwnUQWcuMYXXcGg/MAYahEK+njLrTUS5PYEaJn9uMSYvTK6v7IcJEOnA==
X-Received: by 2002:a05:6358:c107:b0:175:e287:7278 with SMTP id fh7-20020a056358c10700b00175e2877278mr2726056rwb.45.1705430586821;
        Tue, 16 Jan 2024 10:43:06 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i126-20020a62c184000000b006da96503d9fsm10032245pfg.109.2024.01.16.10.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 10:43:06 -0800 (PST)
Message-ID: <4afe24a1-9281-41ef-98ff-7d32872afe66@gmail.com>
Date: Tue, 16 Jan 2024 10:43:03 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] netdev call - Jan 16th
Content-Language: en-US
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 netdev-driver-reviewers@vger.kernel.org
References: <20240115175440.09839b84@kernel.org>
 <Zaaek6U6DnVUk5OM@C02YVCJELVCG> <65a6a0cf8a810_41466208c2@john.notmuch>
 <ZaapI9zDaP1YI7AA@C02YVCJELVCG>
 <52a1f5ed-37d0-431b-8faf-b2e5bbb659f7@lunn.ch>
 <Zaaq6kh1IgDdy9SW@C02YVCJELVCG>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <Zaaq6kh1IgDdy9SW@C02YVCJELVCG>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/24 08:12, Andy Gospodarek wrote:
> On Tue, Jan 16, 2024 at 05:10:31PM +0100, Andrew Lunn wrote:
>>> Thanks, John.
>>>
>>> This one is a bit odd what happened is that by the time this problem was
>>> reported (on an older kernel), the code changed out from underneath.
>>
>> Hi Andy
>>
>> Talk to Florian
>>
>> He has dealt with Fixes like this in the past. It generally works out
>> fine so long as you are explicit about what is going on, in comments
>> under the ---. That, plus correctly marking what kernel version the
>> patch is for.
>>
>>      Andrew
> 
> Will do!  I know where to find him!

Hi there! It looks like doing a "targeted" set of fixes for pre-6.6 
kernels is appropriate so you would just want to submit them with a 
[PATCH stable X.Y] subject to clearly denote which stable branch they 
apply against, and have a cover letter that explains why.
-- 
Florian


