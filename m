Return-Path: <netdev+bounces-130917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4A798C0AC
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0101C24120
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F241C8FBC;
	Tue,  1 Oct 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="IpF5+HgT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A333A1BF7F8
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794219; cv=none; b=HGr8vwkA1SvUolXKDUlOU6Qd1qKxkcLUSxwkx+tdN45URRq2KTYZ+x8VrORa2UNmE6eN9X6cHYEDWkE5z2XtUPQsWGJOmBZJLyZxO0sG4U2Y0T+GHl198HVUyLA5UMOTx9wYo4i14V4nnhj99c8n6RVqqCSsR9yi6//IucExvSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794219; c=relaxed/simple;
	bh=iD1cUDQCa4lYfSs+5B2cOqVtRkuOH/7Vjicb+whrYBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RT900TeUjDZ9uGciDN1uOF5TWlbYrRtB4prydSH2qX7dsnsCDG83YNldj3qssm6Z1LpywXXDDgqoZmwZHoFASF/veCOtanOWNMVrInAweD4PJBUVmBvtUFDI3+WCQ9zcoaI3bd4VQKfb9EtSQBDMULWI6c6wGlZkAAx9xr31PvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=IpF5+HgT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb1e3b449so7337495e9.3
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 07:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1727794216; x=1728399016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JyFqzGTIL/JydTQM9pGMPWQu+Jd+gnB7gRGMJk2LCAU=;
        b=IpF5+HgTELZfpKYGLoDZ5QuDezc+bICMUP6ugyYux5QEek8RU21SWJBZnbEj+lOCW0
         VtxFA8pgp/N7AOWVhtRP5J6hSFsBotxDSL7YkArITq81fhRWRc/yKF17gMcAS6VXCjMu
         gczOMHgXK4bh/jpclLfZ1BHc6mJZ8cSZPAp+ZA6mMG3M6GYiLHwDA7fN+9KAZV4Y13CJ
         GoCFmZDhYSlPstQ/HnWKz8D1KpVSwuCA0WuUeXeZ0E/BpUqowgR5hjz1bWVHx/7VBtr9
         jMvD5oyW/vu460YVgOsw4zGYMymT0tM9LsCcZ9BNNtPYW5NdOckPJI3f0EOjpQflMTT5
         0+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727794216; x=1728399016;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JyFqzGTIL/JydTQM9pGMPWQu+Jd+gnB7gRGMJk2LCAU=;
        b=G0O5joerI8RoteCQoaJTVqJZzMgf7Srtt1PzcFX6ZqB0mqGzoJPwLhQyp7MdfsNTOw
         82RHrpptZ/rK82oS5cPVE4Her3Fvga40heHM90qfn5daL9T3VkjSIxrYbQz0odx9uAZx
         4+N6aYq5o8/eQgObhxp79y2Ohh3735shEpteo2LpzrMLOpvsyjMovKwIlQRujvD9GfP7
         q4cZ07b7OtDAlNu8vhUUYl/RWKDA/lwfK4QpFD3mAOnHs3A5hVrKbsjcDNHq/B/bUoWc
         AV4E2mnbeWO4ffS4H20PDx2fQWVFAQShD9G+/nIbu3tP/s1g5IHJdVpz9GN2O7uZqnl5
         HLdw==
X-Forwarded-Encrypted: i=1; AJvYcCVLONRMW/jAolreXdiOtnAHkeKM1zqgNFOKuKx1O9aF5cvQlWw9SequN+BB/UyQkidJLx1Z1e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuSFJLaitHIhaW60whpvX5uhYSioIvfztaaxvKNfo+xGyb/qnv
	ezHMELyuXQ7mbxXs3ghPdCBfnipTj2JxtgSyCcN+/ydGVX0OPtAE6cIEskNcnNs=
X-Google-Smtp-Source: AGHT+IEps5crVYH5i9gcfvEcU9NadY2mBtzYP43oONboxOVwHoj0syM/gmmWce359iQUnJVKfRyryg==
X-Received: by 2002:a05:600c:1d1f:b0:42c:b172:8c53 with SMTP id 5b1f17b1804b1-42f5e3ab824mr42049555e9.5.1727794215953;
        Tue, 01 Oct 2024 07:50:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:aa9d:4d55:f3bb:3405? ([2a01:e0a:b41:c160:aa9d:4d55:f3bb:3405])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e13a1dsm138081005e9.32.2024.10.01.07.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:50:15 -0700 (PDT)
Message-ID: <797edfa5-60f3-4440-9384-bb9037c60c74@6wind.com>
Date: Tue, 1 Oct 2024 16:50:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: Doc on kernel.org
To: Jonathan Corbet <corbet@lwn.net>, linux-doc <linux-doc@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>
References: <4d6edf70-57fb-43a1-bf15-330bd5f6405b@6wind.com>
 <877car7ulg.fsf@trenco.lwn.net>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <877car7ulg.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 01/10/2024 à 16:42, Jonathan Corbet a écrit :
> Nicolas Dichtel <nicolas.dichtel@6wind.com> writes:
> 
>> Hello,
>>
>> I'm not sure to address the right people. I wonder if it's possible to remove
>> some obsolete docs from kernel.org.
>> For example, the ip-sysctl page exists in two versions: txt and rst, but the txt
>> version is obsolete (removed from the kernel tree 4 years ago, in v5.8):
>>
>> https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
>> https://www.kernel.org/doc/Documentation/networking/ip-sysctl.rst
> 
> Everything under that URL is somewhat suspect, actually; the best thing
> to do is to look at https://docs.kernel.org/ instead.
> 
> I agree that it would be good to clean up that stuff, I can't do that
> directly, but I know who to talk to about it.

Thank you for your quick answer.
Yes, it would be great to clean this up, it's misleading :)


Regards,
Nicolas

