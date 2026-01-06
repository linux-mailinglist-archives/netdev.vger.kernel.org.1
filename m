Return-Path: <netdev+bounces-247329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AC0CF7859
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 10:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C475303F9A9
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 09:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEC42777FD;
	Tue,  6 Jan 2026 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBP4lFnR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB47E1E520A
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767691618; cv=none; b=DUT98sSe9TF25eVwtHcb4VYj4s8kbFkDqj/Iu9ki4rLy1l7sckkrMj3hfPz3lxWXVNSdKdFo3b8sNidWBx5bH2cpJ2FAmC8yYG4kFG1pqTvGIPVhtfQBEuPaqm07oTP1ZHYVMARu74nScKMgWdvvKY4IZvdciChEudWlYmyBX3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767691618; c=relaxed/simple;
	bh=k+2yh29D/r4cHzEXCCMjS4xDwvcDjt6HDBOlHRa7CpQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=JHCtB/DMKDDxw7JMXyYM+BzXTL/PPA7pEAP0RJJqiK7UdBFatsRRLa36SVJPvDatZq75oBpunfbX56VKYYLrmNGej69yMlnmvKEyFHARPL4i2bjBliLTGPYs8Krr7so+5r1e3HBwR4b5QufPjkBT9yuxIOYjec8OUlzI2/v3fs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBP4lFnR; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-6447b403647so109553d50.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 01:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767691615; x=1768296415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ACKG1j74eCqAcdiLm6+GOrVF3br2bLGHB96EkfR1KY=;
        b=YBP4lFnRWEfTJDuYMYWvjBwvno/byyxyAzVmxowihYf8P6SMWhqm+m9VL794heMUhe
         4a+I7Wzd67c4drW+5ukU++IXybzbYzuuGhDw+ueMNxjBm9iU0suuv1lyTJofNsne1X3+
         M1P6CwLv3XMTkFA41TqimJLHtjeygGNhYzUMMud1M1YTqT8CpiezsE1tHBY4JVjQKHel
         lox45a/FZ8oupgP7hSnUB5u5LalcXjkxu9U1Gi34DAlwQnZTFDLOsW/14IskoYkbz83P
         vqFUF/D95rCFUgTCdKzIxR1JRaz7FPt5V7Yhd7JmSxsql5f8qF6CPqnVfPj7aSVbSUbk
         O3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767691615; x=1768296415;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ACKG1j74eCqAcdiLm6+GOrVF3br2bLGHB96EkfR1KY=;
        b=tZ5SYZJPvGN4Cy+SSP3mXtjFTRNF9X21YLAsV4aQcf76OzqgtUyWtgvJZmUNxJn1DO
         vM850zxxlPWezf8QMe/FrCHBWW8TZGgDhR3oXIXqmtt6oRTDg/KHLoTyEPZcwJSRxvaf
         mVsVPe4B+lJyCHriKVieWQ1qP9PyDnAx81LepY04Me5VEtcw+nMmxV/7GZVcxWJ5eE75
         IZeDdcPzuAJ2sO5jZVr74S+fcxUqdcX7nimmNjbb+koAl9FlPrSZHCq85dB194o2UCm0
         7S5GX/4YUspn+vBjav9vYu8E1cJRypfXgiuo59jlJ5JuUFWnRmYrjfyC6nXp+ouT9YJK
         ByxA==
X-Forwarded-Encrypted: i=1; AJvYcCUzegIEu/mvQrWCPkNipQs/PuMqk68j4FpXNHipP00FZrCZM9ddBkRp8BE2S53JLKzd7ZqqPU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZgyD3C0x/rqSdwhSYxd4r0ayFr0NtiUV92+tdbDTqGHlfVKFk
	4fHQDzNu/EuiCzfKX9qvt6J2tHfLDQr/73ahs7KBvF2xn5aFGJ/Wuv8I
X-Gm-Gg: AY/fxX6tomHI/koFhMe+WslUDqUiiYk2qA6IrR4blBLk91p3tJOMbXPvP6GcBNYfo2E
	agjkL+ijvapE8NttbRbhMoNtRQXu6AuLkb/BVafKBUT1OfwR3/cUU4otFn9Kzu2Vd6QKMLdgiz4
	6NUqk531SglNddNWZhgMtYGWSegC5S8tk3pxyu5oXFdnPaP8VOzOj1JRSI9odzMsPH5sjFwMHUJ
	U/6rgTkF29GCWgbL8a22/z8ZNQUpHhaKheVPBs449X+3B4+0/KMdD0vY9CrDjUQNowfDvEOy81B
	/xSaAgXWslbbkfHLr8X++x6QNad9N1B2Z7N///aL4o4jW1dZ3vy8b1TYI82bKzWYkDHRwOzvSw9
	XozKuIxj/8imyclJe4rTh6shdG/oqRExx66CunQ3qNg4/wSKf6mwK6cOqVyeuR+dziB/C5Vp0d8
	F/G+8i8GLe
X-Google-Smtp-Source: AGHT+IEOpiAp/u9fw+nfZ+f4gAcfVLvEYSe4BH29U0CikNyPnWm+/srcAH7sBfFtVq1YAziyA1yQ1w==
X-Received: by 2002:a05:690e:1687:b0:63f:aa52:8994 with SMTP id 956f58d0204a3-6470c8454a2mr1737036d50.1.1767691615550;
        Tue, 06 Jan 2026 01:26:55 -0800 (PST)
Received: from localhost ([104.28.193.185])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d80da68sm696089d50.9.2026.01.06.01.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 01:26:54 -0800 (PST)
Message-ID: <d252363c-4791-43da-89d7-4410eb16af5c@gmail.com>
Date: Tue, 6 Jan 2026 10:26:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] selftests/net: remove unnecessary MTU config
 in big_tcp.sh
From: Mariusz Klimek <maklimek97@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20251127091325.7248-1-maklimek97@gmail.com>
 <20251127091325.7248-4-maklimek97@gmail.com>
 <8fd45611-1551-4858-89b5-a3b26505bb00@redhat.com>
 <1dba15b8-64e8-4ed6-b3d3-9bfabacd2d1b@gmail.com>
Content-Language: en-US
In-Reply-To: <1dba15b8-64e8-4ed6-b3d3-9bfabacd2d1b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/25 17:46, Mariusz Klimek wrote:
> On 12/2/25 13:01, Paolo Abeni wrote:
>> On 11/27/25 10:13 AM, Mariusz Klimek wrote:
>>> This patch removes the manual lowering of the client MTU in big_tcp.sh. The
>>> MTU lowering was previously required as a work-around due to a bug in the
>>> MTU validation of BIG TCP jumbograms. The MTU was lowered to 1442, but note
>>> that 1492 (1500 - 8) would of worked just as well. Now that the bug has
>>> been fixed, the manual client MTU modification can be removed entirely.
>>>
>>> Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
>>
>> While touching this self-tests, I think it would be nice to additionally
>> add the 'negative' case, i.e. egress mtu lower than ingress and bit tcp
>> segmentation taking place.
>>
>> /P
>>
> 
> Good idea. I'll update the tests.
> 

Actually, this idea doesn't really work. When lowering the egress MTU, the MSS
is also lowered, so no segmentation will (or should) occur, and so the negative
case will never fail.

-- 
Mariusz K.

