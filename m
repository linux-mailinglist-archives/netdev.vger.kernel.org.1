Return-Path: <netdev+bounces-247536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEF3CFB92C
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F044230BBA21
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D560231A21;
	Wed,  7 Jan 2026 01:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UShakIsv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B09B20B810
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767747957; cv=none; b=lbJPYJVW9vwJH2XRs7O+EYVLf63lv5BB/3oPdW4yhdjN6zciADYU0lJc+9q8Wg1QG7zz1tLKZd1T6VdefvGCa1aW0Mxz6JXYwtZZO2A4lrhcgCX+RAbldn3BefwY/LLE+xfQGRiNXocvW0ATkm8s/9t21ROOo1uNqzf1PcHoEag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767747957; c=relaxed/simple;
	bh=3D/Z/R3tHFXur5aFsTPzJ9pnmJyxUWXGhoE+JwfEF98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itUhSKHOIg1MwMHwuLinw7IWqyJyHAsbvjz4bYHg7ej5ZGEP/aK8oKl5PFkkbWuXHuH5hbTqVauTEbLYpzgPNglsPsR3pjppFJfnA3g+YeudDYTAeLhdRwXE21v+Zs1/1R1mqQ3P6Kkfyp+tSi+0ETDlOHzPerbcBjeJvxAls7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UShakIsv; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso10923825e9.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 17:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767747954; x=1768352754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZ7z6k/mdg3aeb4UUXHS8N+QdziURsYk9wSHDGAPWlA=;
        b=UShakIsvSmWBM1FiONLo4pjkFSo7qEBdsp+x7mIZ0HTTz5NTpEAk8nEL/tc9o1RI3M
         RZHY8Cw3kNzy4CyAZrwIXBDKUvaceZUFr8ZTjV20Qzz7xYIGTgJV1MFq7tgsIvEMvoAk
         gH2Z5jMDY+ZsdyplNrkFIGdrN9D5s+LFGiygr4MvGBEktOb+X8t69IesNCxq3TNvnbPM
         IuAcpTXX07lSiWUCjS1ybhUDbcel7YMvORSbEsApDDGcOexv6dTlTp20o3NwU0+bx12b
         DkUwgKP2fXATN9n1JvtiMzNBBS9ibJkoOg1MF0Uvse9sQ1JsRi1OS+BO7Up5IXCzJIUl
         8Ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767747954; x=1768352754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZ7z6k/mdg3aeb4UUXHS8N+QdziURsYk9wSHDGAPWlA=;
        b=tTj+bAp6MRcLHiqA9RLnxGjxByVUMV9ma649hDqx73qWZnX8TSQa1hmnFYxDGbmrAd
         35W/vOcmlGTpwqsQOu06/3ArShvAfzZvt083Wuc4cSQw1yFyjWmiYnT+bdLl1IbGjMCi
         fxQ7aS0FqXrgR8bZT2OLNTWxn8ZYdODrWD47K6tm+gaEUY1fwFnCcqoTGOSK5ld4KzjC
         2AxW/ROTX7LLQjppRY/6R7aneiaxrv2FfGqK58QoPKL8mSsmUf0OxH6meZm8bRNR6yQP
         l+YOxXpbYd6ZoCtkSAGi5SP/NuecC8sB6axmyEZ/bv33aYbCP4CBjBJHmZVAVltCJbRg
         Modg==
X-Forwarded-Encrypted: i=1; AJvYcCWdoS/yLQFkcUsRKiwsWHs/MHPMg4eDmJE0uJnSgGyMEAHKpgM/FBulCspGXrCe++JqieE3T3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpsmBUC76C/Pq9ARmu5P9quaVuvA8b5UX7A/uilnwegBP9z4SU
	r6Bz66mxoC/7wfElCEphrGe9Ykw51mWgDQHHuXweCTj/hMVEEPRa/75+
X-Gm-Gg: AY/fxX6BG+sw/WXm76ZP6EqzIMzFYKPsCMdSU1rdSgdPELtGBkj+k3L2Yq4DYajuDdp
	HxKdSuWMC2q/VKX8419r+5xKMWpGUH/rKCdksBQffD0Is6TjWwJzemQZnIvjXfuuGv1hy3gqG8l
	/e6dzM5nBpiZfvU6fzmR3Xt/PU90UiyBnu5/cGUPKepP3JVD0JicwQTyjBRSy8SkuBX6d6l6mQb
	pHWeROa/tUGfbGp3xlwinszLgbTUj7TBA6HeQUdXlsxXP5++griAnWJP67ldNQtIrgSArPahcnY
	OXUSLcBNyztWllfODIffKsLrI4cHx3mX4PwKCcOaqdng6/49P4AeUQmkf6pI7HSl9HWDqeku4l3
	xLcy6hpNrD1IJ5RWljxJyM6iwb+71DzkzEyPcFwXu5GxWrO8yXLFBh0JqWTGQd1/I4HoQpfbTDk
	o6ELhx/8T04vxp6ErwQ1GZccw5
X-Google-Smtp-Source: AGHT+IERDNJCq8k87UVbW0RyawA/iHoAcxUbYcwO0//cg7ECWUBahAJU1pWM60NUKnflNKLsh6+jQA==
X-Received: by 2002:a05:600c:b86:b0:479:3a86:dc1e with SMTP id 5b1f17b1804b1-47d84b41007mr7537025e9.36.1767747954236;
        Tue, 06 Jan 2026 17:05:54 -0800 (PST)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7fb65ed7sm27843825e9.19.2026.01.06.17.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 17:05:53 -0800 (PST)
Message-ID: <83c51a99-038d-4283-9a39-97129966a500@gmail.com>
Date: Wed, 7 Jan 2026 03:06:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v4 7/8] net: wwan: prevent premature device unregister
 when NMEA port is present
To: Slark Xiao <slark_xiao@163.com>, loic.poulain@oss.qualcomm.com,
 johannes@sipsolutions.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mani@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>
References: <20260105102018.62731-1-slark_xiao@163.com>
 <20260105102018.62731-8-slark_xiao@163.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20260105102018.62731-8-slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Slark, Loic,

sorry for late joining the discussion, please find a design question below.

On 1/5/26 12:20, Slark Xiao wrote:
> From: Loic Poulain <loic.poulain@oss.qualcomm.com>
> 
> The WWAN core unregisters the device when it has no remaining WWAN ops
> or child devices. For NMEA port types, the child is registered under
> the GNSS class instead of WWAN, so the core incorrectly assumes there
> are no children and unregisters the WWAN device too early. This leads
> to a second unregister attempt after the NMEA device is removed.
> 
> To fix this issue, we register a virtual WWAN port device along the
> GNSS device, this ensures the WWAN device remains registered until
> all associated ports, including NMEA, are properly removed.

wwan core assumes whole responsibility for managing a WWAN device. We 
already use wwan_create_dev()/wwan_remove_dev() everywhere. But, we are 
checking the reminding references in an implicit way using 
device_for_each_child() and registered OPS existence. Thus, we need this 
trick with a virtual child port.

Does it make sense to switch to an explicit reference counting? We can 
introduce such counter to the wwan_device structure, and 
increment/decrement it on every wwan_create_dev()/wwan_remove_dev() 
call. So, we will do device_unregister() upon reference number becoming 
zero.

If it sounds promising, I can send a RFC, let's say, tomorrow.

--
Sergey

