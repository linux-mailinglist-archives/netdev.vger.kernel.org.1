Return-Path: <netdev+bounces-172612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FB5A55876
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA71F18952CF
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6C02063EB;
	Thu,  6 Mar 2025 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHEjWPx2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281C51FFC47
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295619; cv=none; b=Cw3zU3A4T4AP16JibJVgORhVyHLt30b33KLY2k0hGwVHENXs1hpRozYThUSXK05wbr83PJDLKROnGhZIwCn10ZUsab+7QKd6XU/0mpFFNB2EJY0ekBgYJ/Cw9ypdMjQmp3G8FB9g8tHVldWasqHJTjgz21cepezDzOFIpUURl4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295619; c=relaxed/simple;
	bh=7vBiwYGcBRfFpGS24BZEqxXbgGRgHQCVAy8id2b2oLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLishSbJsj/WAcJPBtnnnQ8sbpK/0nU+1eN1oJYph9foFVfs2kjaDseDC+j4EcxZ0I6Aaka+c2SNusfAzOyEg3U/KeVKCQtaSl/+bN/t1WohLuDF8IIGW+lANThIGh5J7qsPBmqzbGSdRdHywc0YRIlfc27XxckKK0VlfIjd6gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHEjWPx2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-391211ea598so845638f8f.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 13:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741295616; x=1741900416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3ZWdCBYRo/mCB5K2mT13CwcgIhXabRyTEGjOq9drwA=;
        b=AHEjWPx2l27EFx08dVMuIQYS0+w0AxhiBkETmfDo1xuqBJNCXacu3/+bLkpptA9uY1
         JJ1IG1NzrXQv7feFhWVMk6Wq2z9hvarWJCeFqjqgv30PfJBJhPTkctmCPccGX0SE4Rm1
         o76n/OrNNTBYuXhTqxtHYs+xTDfJBvTCkZKRBUyGIfQmTcwAbbxIBimnP50qIZsGTgVX
         zDurmqv+PXgFxOwDdSdd4Nf8hnKXY4JM9JCwJIy6RWKZUzNEmjwXYVpNP4pDePm/wPAv
         3S6hpCmpy4H41JMsg296driG3fNi+WQ5os6KjnDrQJTWppKT59EX3to8sXi1+32B/XAk
         npsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741295616; x=1741900416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3ZWdCBYRo/mCB5K2mT13CwcgIhXabRyTEGjOq9drwA=;
        b=BBepgLDL2wqXvOSBxSettZj66V9hvlNv1YPrgWJ7pBpq3FJOtkyiK9zu1085azO1as
         qBwGg0PUoOTvEGNz56kY4icRHk4xBuzKEj7nKEeUkYksbG++v1oebCA5BvTZWXj3g7ov
         wS7lN2nOaOUTSfLj+uPnr5oYtSaV6bw/xUampmVxLSv8mL1PWWDT05vtFPGhXYid03al
         8NY6xZrXkzF/yzr1It0JS4J2fhJnfsXODRf95KQX5SPl19bb+fz1njE4u5VCblvJqThU
         QuttnfL3BoInIk/E9zYSDRrR+TDjZhiH6ayMF8LyMTUhBp1sc8HiyIYZ04GOVcEH4YXp
         k4Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXZgullJ0QCGwIixW3f0afsE8Z//s9jjLXL1ZtfHrAgm+iarqJkswBAOF2uh+P0w8ZHgqF19/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrrIsxCVDpyIhDWi190ysPj4XgET7z2gONgRbEKMAJghY0/z9Z
	BZOQZ8RhO1yAj8gHrwyQqm93V+aRC1pMsPsJ7jxhtAi2j68zwtyl
X-Gm-Gg: ASbGncus3PaYESvM4KoPDCgW4qRwf7DpAYXOX8eOVNIJPd6MsQim6Z2lyxoaskxGHu8
	4iu1tZHWuLM3ifa2eFAtOXFJGEoAFwqhXTI5bNMiX3IICCd3ua3JqI+3cXHrx3fY8ccUH9Q76V3
	P4FsM/eI29nnMKk3nbBj0zFFNaAxvg1C4ULoGz+BbbWG6BWaA4+p3QezW6LWo5h2+S/2Xd9Q9+3
	vAe+/6vEvR6nrZkMZ/8YdLHd36iac+BP9PSG6clYwbrSsiZaRvUhHVjlr+WWAMdDD91zq49M7qa
	OhYJevBZ4ADU7DJ/HIRJc69eIgX7+oYdxTiKhHGr/7GEv4NkNg6zcTMEMhlT0C6TiA==
X-Google-Smtp-Source: AGHT+IH/yEZtSviL5gIy67IldHUv8skW8SR/qCANnl11kjuNXxqrd60cxk+EYS8c4Pie5vy+9K6VNA==
X-Received: by 2002:a05:6000:18a3:b0:391:2df9:772d with SMTP id ffacd0b85a97d-39132d3bad8mr419368f8f.13.1741295616078;
        Thu, 06 Mar 2025 13:13:36 -0800 (PST)
Received: from [172.27.49.130] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e1d67sm3129366f8f.74.2025.03.06.13.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 13:13:35 -0800 (PST)
Message-ID: <6ae56b95-8736-405b-b090-2ecd2e247988@gmail.com>
Date: Thu, 6 Mar 2025 23:13:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, Gal Pressman <gal@nvidia.com>
References: <20250303133200.1505-1-jiri@resnulli.us>
 <53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
 <20250305183016.413bda40@kernel.org>
 <7bb21136-83e8-4eff-b8f7-dc4af70c2199@gmail.com>
 <20250306113914.036e75ea@kernel.org>
 <3faf95ef-022a-412e-879d-c6a326f4267a@gmail.com>
 <20250306123448.189615da@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250306123448.189615da@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/03/2025 22:34, Jakub Kicinski wrote:
> On Thu, 6 Mar 2025 22:12:52 +0200 Tariq Toukan wrote:
>>>     The exact expectations on the response time will vary by subsystem.
>>>     The patch review SLA the subsystem had set for itself can sometimes
>>>     be found in the subsystem documentation. Failing that as a rule of thumb
>>>     reviewers should try to respond quicker than what is the usual patch
>>>     review delay of the subsystem maintainer. The resulting expectations
>>>     may range from two working days for fast-paced subsystems (e.g. networking)
>>
>> So no less than two working days for any subsystem.
>> Okay, now this makes more sense.
> 
> Could you explain to me why this is a problem for you?

Nothing special about "me" here.

I thought it's obvious. As patches are coming asynchronously, it is not 
rare to won't be able to respond within a single working day.

This becomes significantly rarer with two consecutive working days.

> You're obviously capable of opening your email client once a day.
> Are you waiting for QA results or some such?

No. I update when I do.

