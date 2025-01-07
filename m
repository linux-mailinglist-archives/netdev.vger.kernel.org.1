Return-Path: <netdev+bounces-155738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FE7A0381A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B16207A1B17
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE901DB362;
	Tue,  7 Jan 2025 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="FMjr2fBv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D715D1DC9AD
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 06:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736232272; cv=none; b=Nv8f4Kr3QwRRS3dWR8uLiA3NkX3hjLDMtV7ruhG0VELWnayFTfNtYQ6xp0QL1vEd2DPMDUKIjI1lqc18bf5skv8wuJo3UxMiUGMxsAqEMxWB+kSbcW+NXF/MVry+HYCExH9wE0cRv7E5es6zunQPZzt4pWXJ9z6UgmCFCxOx87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736232272; c=relaxed/simple;
	bh=24Gs1hfYEkmrBzE6YRfYR5NsqRt6zTyY2vpt0m0Lyy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GijnER4a+ZcXkOaNU7v/ryRbuMOYYog0/V2eA56agNKHQVaKacr3wYP/yxgOAbED1cowEFO2NAOTEOGLaZICj3pvL0EivvlvmwYV2d8AbOGb8tXjIWcHshAmZSGtpYkFAPbfZnmSv8d+X1vJQXnBBUzt1NfTCPENYoV/wlzPKlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=FMjr2fBv; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d932eac638so4832827a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 22:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1736232267; x=1736837067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2xHiwn/QvEe5yf3P8YfvmCadBbV8lQ6kRs271ykQ4Y=;
        b=FMjr2fBvtA7e672Qvg3cNVb8W73yldUeGt0xMUhyh/7zptnrYqlyz1LONyc5hGvZlh
         G0AHERFS+0pda1DK5SsXBEe6tq/nRz7YixWfOBnhozriXR9cBiJaUodIPnMlWuS5/DPg
         ARZoSryUAyq1OhKnsXBDXbAqWrbSH47O/eUfqzIhjknRj8F7BSUY03od26b37bSisCbQ
         mbI8pgbusUzk857IleXg2tidlSF2DvRYFHoyXOkeFbaZ6aB4uyBFCjbVMv6AgBNZEbBv
         hfumuhG05652mumQyUObHtqUM49lXrPuDrlINOJMXjgeh0piTIeiVn4q3nYsYMUCvBuJ
         SPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736232267; x=1736837067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2xHiwn/QvEe5yf3P8YfvmCadBbV8lQ6kRs271ykQ4Y=;
        b=IF5fLUSSWATiT3t7MQHpjUEJ2g1fIKWqWqgGzvpwM+RumcHPW9eUIvRv661If4zf6o
         hBB4XCl6u6lOFDk/vvsvrt297B829MpICXc6X9llb/W2Lwi/OnUWA1orUXY7Yi1gT0BQ
         puHMI4CPKnKFGFkshRQg8cxnIGjhbGQylMFtk6kBoNYbHAYYPXTAtdgKmjMUQUXzUrr5
         hDtitKhCc2RR9JPLZ2bQUfMgnr0cbhW5BM4y1ty8tD33WEQi9+aDxEdp9TxcCot/t7LK
         tpA309YVfS8y0ygMbyiECjBbqv/aCMUKW7nz3UBACZSwpbxI1n6fqIasAtR7Rq96nrUQ
         rOWA==
X-Forwarded-Encrypted: i=1; AJvYcCW7BoIiUXGCogkqvi1HmckK6qM+w0jdvb9X6iXVpV9uUNws+EMVfyrdBPAs+hXvkoIxeu+m6+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJFQIFyp5KiPPDWd/sAULf7Lz1uTVS7Elt1E514Tm2lGj0Biu1
	QvQpobh7CQatYCb2ZT4exiypNHBldtbyeHCycqcJebHvQ9P0YIGkDtVMxGTv4ois32CUbhbsELN
	q
X-Gm-Gg: ASbGncvyFYcnr9Gd1dzpdJ8LMnkal5SfcSsypJtFxb12vslerHeMBC5nbfrmTeUfBUO
	s8j7xHu+9gAY/GO1EfNVvGVNk2oMAuvoEdXEVuFcOrG0rrrV8EdEAKxHlWEOqLdrHuiYIWult6M
	sglOGwrDHooJ0rt/rLZx+a0fLTd/V7IkqeRh7bITVBrgykVUcuTEs7iqypU96wZNBsFsqsGvm6c
	eN57pQiE9iJOQP22sB3z1LqLmsv8PP/usLAwtjXGaDLO11T9tRLYYDQgY45I+0E6hlr66qjo+T0
	GCK/vrE9i4DV
X-Google-Smtp-Source: AGHT+IERNQj90jD2U/FELiwJNPFUYVVycFoMRlwDUtfIbhUHGO3epXQt6xAQOaym96nBlCCpPkyaJg==
X-Received: by 2002:a05:6402:350b:b0:5d3:bb6f:2675 with SMTP id 4fb4d7f45d1cf-5d81de5e2e8mr59567601a12.34.1736232266996;
        Mon, 06 Jan 2025 22:44:26 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f23bsm24556754a12.32.2025.01.06.22.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 22:44:26 -0800 (PST)
Message-ID: <415e9728-83d4-4720-9790-42d4e4d8acb7@blackwall.org>
Date: Tue, 7 Jan 2025 08:44:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/8] MAINTAINERS: remove Andy Gospodarek from bonding
To: Jakub Kicinski <kuba@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>,
 andy@greyhouse.net
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch
References: <20250106165404.1832481-1-kuba@kernel.org>
 <20250106165404.1832481-4-kuba@kernel.org>
 <2fda5a09-64da-40a4-a986-070fe512345c@blackwall.org>
 <2982753.1736197288@famine> <20250106153441.4feed7c2@kernel.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250106153441.4feed7c2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 01:34, Jakub Kicinski wrote:
> On Mon, 06 Jan 2025 13:01:28 -0800 Jay Vosburgh wrote:
>>>>  BONDING DRIVER
>>>>  M:	Jay Vosburgh <jv@jvosburgh.net>
>>>> -M:	Andy Gospodarek <andy@greyhouse.net>
>>>>  L:	netdev@vger.kernel.org
>>>>  S:	Maintained
>>>>  F:	Documentation/networking/bonding.rst  
>>>
>>> I think Andy should be moved to CREDITS, he has been a bonding
>>> maintainer for a very long time and has contributed to it a lot.  
>>
>> 	Agreed.
> 
> Sorry about that! Does the text below sound good?
> 
> N: Andy Gospodarek
> E: andy@greyhouse.net
> D: Maintenance and contributions to the network interface bonding driver.

Ack, sounds good

