Return-Path: <netdev+bounces-181871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBA4A86AF9
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 07:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DCEA16391F
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 05:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A84616BE17;
	Sat, 12 Apr 2025 05:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvpMkGA6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3A914C5B0;
	Sat, 12 Apr 2025 05:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744434518; cv=none; b=LJNNu5iF0or8CSBt8/E4R9q5AOKIM5+WRxR33yA25gsHJP+J5X58j+8KnvcC74AtwV0ev/9qhMTaGgediWc6HfQPCXxS4vjnnAJ4UN06GfRI8xeJHd9Mx7X0C+iQZdfckJD/ynDpTt96gYwR04cjF7RS2Qnkk43WyVxgEEb/y6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744434518; c=relaxed/simple;
	bh=rj12iUgxA7Udn/SJKWvTNJypF8jyZrWGvK9iSvp3vbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bm+hB/5jXuG7tw/VxRKvVYC6Uq7Ymh5v6wVTzr/t3YfM43kK7AoT6Ous3wCw6helWgNqymMqRK1ze14JxwhHQoyGTKSdV7T3KVI4vpO/Z2eMX55kAn0njLJd13a9ngGPemrqwaM0kRmOQfaFa1ZU2gl7KGtAwvH9Ny8h87TZd2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvpMkGA6; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3054e2d13a7so506897a91.2;
        Fri, 11 Apr 2025 22:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744434515; x=1745039315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhOmZMRqYppVnUKcge32grxQ8tPBj7VzBuC0NKHh94g=;
        b=kvpMkGA6iZwAVr/giytZqzudoM7NPidRdo4iXolhSvuO24O5q73T0S3lj6U0iZoyhk
         QMJ4vYgY7RNXXqXJZkZwpXzHvzUcVKFkQcC+46DxhJREDyZxc4ev1hUQbiZ8LJFAFWKe
         jPsdCNvnSCRXiAXe86cpN/KkN1f6qYkwZOjh7q9IDPBOsomonvF4Hafglak9Dbp3iha7
         2Okep3Jskq6lU/DJ98Jo43hYPVW8IBCz+c1EY7ZpjBf61syAF14G+izq4s7GgjB9VtbG
         FQ2Dh7O6mVDi8eSR54/EDt+jDVJOKX3a5Rg68qvRd4qKuYmLmIMYydP9nuAtKJ4SrMFR
         /H/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744434515; x=1745039315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhOmZMRqYppVnUKcge32grxQ8tPBj7VzBuC0NKHh94g=;
        b=JSgr3XDgg56+79Cv2SGoyfLfVR6csta0gTM+XvrWDyv93MXJq/U2qtjTUASPDvsfc8
         XWXT/Q8MnAjgvHGMCeTvmJzsC5wlJBQSo8YmqklyqF048s/atbES87urchErAPaL1IJE
         9xmSrC+mxPP47dF9I/5oLRyyZMSienHy0v2DbnpXhAp18z+JGbK7TITAwl4UEFcUkWkP
         42cxHAIxTzt4Q5s3+Equb7axrMP685Qq2vJwdKY28oA9I+bKczuKIVBIbymf37q47PJH
         NHMfhzwlWTRoVD5uT5OUpN1v16WPEt6jWXE0yOYzAQU5JNAPCpybeAV+kov80UUVIuXd
         6qjA==
X-Forwarded-Encrypted: i=1; AJvYcCUK9zQdpAZKppRvrXPGciNeBD407i1hG4GLjXFWsvEiRAhEeCFMsBqr1Zg3DOMqU3RKo2PcLlPh@vger.kernel.org, AJvYcCWBfucIt/Vl629L2SNod0rxPCIJ+28attrXmd6wfc9sAmJUQny1EhkVTjWCPSjyHxtwYObt5vrAXJ304Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjVMeye6Gpj3oHd97+FFhA2/ZDb6+nHQyR5jyRTqu1zFDhM0UV
	jUDr7NIjZPwzGNukP8cGaCwP/R9vQnEenNaVSUNnUsuHZNw2d7Zm
X-Gm-Gg: ASbGnctLb7gGQjhGIGIPHpRxjGUFFlR5lsLzsKLA/Y49HJ5C1JfdKFdim0RIGEOzmp8
	3vrf7aEiALGBtN0iTDGrUWoOSwQi+lZ7WNBQdM6AsRml8Xf5LL1YAA6wa1B6VN3C3LtBO5mJMEl
	hMmzk+CVrM+pF6Az/aqYjtSRLu6v5SXpCd6tKxk1gXF1q7wCMo2TJqPPzTzeh2OaA/wmCU7QNjD
	pxvg/D3VmJANvgjZmoOLlP8zGilQAF4f9JwMAvmnPxuOiN/p5Ih+dNOi0coMJhO3GFvBjR9HzUz
	79rRxHZJzeXksVi2sBRAmfnfJy/W5FnSBrxEpxXvuatdR96YxvMc9YBlIUHD
X-Google-Smtp-Source: AGHT+IH/9KKSlXTgfG2gzb8jrgxGKh4HZyuaPppT6Q8UMkZvzTGRxFIzHkNr4opC+YEfJefEGCIovA==
X-Received: by 2002:a17:90b:3ece:b0:2fa:6055:17e7 with SMTP id 98e67ed59e1d1-3082378c79bmr2977888a91.8.1744434514628;
        Fri, 11 Apr 2025 22:08:34 -0700 (PDT)
Received: from [192.168.1.7] ([110.78.157.64])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-306dd10c447sm6896535a91.3.2025.04.11.22.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 22:08:34 -0700 (PDT)
Message-ID: <e1c64e01-2076-4d87-8814-8124bfa76d0b@gmail.com>
Date: Sat, 12 Apr 2025 12:08:29 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] rndis_host: Flag RNDIS modems as WWAN devices
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>,
 Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-usb@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <20250325095842.1567999-1-lkundrak@v3.sk>
 <20250412004203.099e482a@foxbook>
Content-Language: en-US
From: Lars Melin <larsm17@gmail.com>
In-Reply-To: <20250412004203.099e482a@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-04-12 05:42, Michał Pecio wrote:
> On Tue, 25 Mar 2025 10:58:41 +0100, Lubomir Rintel wrote:
>> Set FLAG_WWAN instead of FLAG_ETHERNET for RNDIS interfaces on Mobile
>> Broadband Modems, as opposed to regular Ethernet adapters.
>>
>> Otherwise NetworkManager gets confused, misjudges the device type,
>> and wouldn't know it should connect a modem to get the device to work.
>> What would be the result depends on ModemManager version -- older
>> ModemManager would end up disconnecting a device after an unsuccessful
>> probe attempt (if it connected without needing to unlock a SIM), while
>> a newer one might spawn a separate PPP connection over a tty interface
>> instead, resulting in a general confusion and no end of chaos.
>>
>> The only way to get this work reliably is to fix the device type
>> and have good enough version ModemManager (or equivalent).
>>
>> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>> Fixes: 63ba395cd7a5 ("rndis_host: support Novatel Verizon USB730L")
> 
> Hi,
> 
> This patch appears to have caused a regression for some users,
> who opened a bug against the USB subsystem here:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=220002
> 
> Regards,
> Michal
> 

Hi,
the problem seems to be that the patch matches devices by their 
class/subclass/proto attributes assuming that all rndis devices matching 
those are rndis usb modems but it also catches rndis tethering with 
phones/tablets.
Better is to match by vid:pid as is done in the cdc_ether driver to flag 
ethernet interfaced modems to become wwan devices.

Lars



