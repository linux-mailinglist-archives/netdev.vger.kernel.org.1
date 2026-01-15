Return-Path: <netdev+bounces-250313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 263E3D285DE
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 21:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F45B300B34C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6335431B80D;
	Thu, 15 Jan 2026 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5IBRNEs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D480C318EE4
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 20:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768508342; cv=none; b=cPZ55TcNZhkKqFTNq2fkvpKoTTCoSkgkRafcR7CC9vAAncnI0S4YrpCWTSUF8so8M6HEeGPTEhE3HsBnCO7vt4S4FH/I4K6WfiXUH5nrFR6WP9S5sAb6D557w740bBxWEns18TngMaREfpCBksaCK39Xka5k4Yw1bpZ6LU7FeuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768508342; c=relaxed/simple;
	bh=eh+kBRyz90Egas7KTTUMuggMZfmSELLpVeZFZwhRQKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBErqf0N/tUvA2WZY4noHb4LzoI/JJgLtFXhQcZHn3KrbsSSDKFjZmNWWyl6DaX2BZ+B6E/aktmEErmxVlbnPVjFVay6gxYCVS+9uYcskHuZuMyyRFUiMIrqwPd3bxXB0pqAM260o3EM7b7bG3GRWCBhOmeVoQv0Zxc3v1/tYr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5IBRNEs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4801bbbdb4aso5331075e9.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 12:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768508339; x=1769113139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9dKQcYgWyb162lQDNUk/o/1MWqwzqk7rHOzrFb1oG9I=;
        b=h5IBRNEskQDvTKUQ5PLkIphzkUtH9IEF4I5BHtjVEAs4u5A/OnkTujsx/PauXCrW3f
         nlhmJiEAZUCpfnkaZ9pl7l4sCJzbS966hKoFETw5fMlm7v89ETlY+GfufufkA03bDOe0
         fiPwy3AUvUqlcHob70BdXTzHEvS7KRpA6hKAsQl6He0TJ5WU7zDj8VEGnXoLSE22T052
         BjBUHVn2tdtNggAhmPFlBur0P81BI2eQv7Qr73z3H/ARs6L1fGna4UGLCLx56dTxLYaE
         D01x3eUVWUmrI41QUZ5zkbd7x3G4YsiA+gScHElgnmKoqP4eQlcec4GzUG91E/SALKP6
         F+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768508339; x=1769113139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dKQcYgWyb162lQDNUk/o/1MWqwzqk7rHOzrFb1oG9I=;
        b=BlNpELYXwAWBuHaQwm+dl1BQEtAek6520VRotMFGckQx2l5gQ1UnwdKsGToEOtgoxm
         pA9toxbwOrz1/pCqW5BL6IkLcrNuqdyBOOLwMzVnUD9FI9Q6pYG0HsfWCwVzAUpnOMIW
         dUsztW6jC93U2FVUWUkGvztP68Kv1udVWEwEigFRhReMqaj0S2cUjE297N2B5u0xjDK7
         NG6EB3By1HuAEID9lK+a1rgGGWVuqWuoZ236LjItWjywOQQnQmJUzETSCbCgQSt9YSvq
         shFQh5YEpden4VXPu39VQ5CYJX3S5Y/J56zAwPXlTdEqc46ldz8xwJ46ogSRMsAl9ELM
         H8GA==
X-Gm-Message-State: AOJu0YwJEBCAiTeGlWCuMFr7KtkC0r6W+XTE8SFM4FHAW9DgsBXNeLGg
	tNi3nWIRRU5WHsn872LqSj+TJjaLCnJ7Cgtzse2NTlg6qp2Dhbk7v60p
X-Gm-Gg: AY/fxX5hfgD4VOWp82pgOp1U1FMrNAzsSVSiv6EP9uBe2eVDA5g35718zvu/AetU2Uk
	2JUD9OU3g53sm+2+IxR5IXPrtimhymZPyWqc1FKbSZm57vOMJJ7LqStWn3ULotUsjE1xqHMW9aF
	D4R5ii+jsz7j4dAREKg6xYb8Xf2ERE7FE8m3MhSk5p4P9Cf3MTUn19DJqCHdGvAGdu0s3Gd0ceC
	TXKASKdZc6kH4+3oteVXaZtw8fuj8ffBpCjt2SLToh2VvCSUWgpnKDe/E/zb3kOiGaoY8HDha1J
	wEcMtKL6ZaxF34uGI2nHCu1c9haxZ6v9bVkhheReDeutFtc5c316UkZJ9vhsXRFokph2L/YVvK9
	nnaF7CduKOpqDqGrreQG23/y8LZYlQWmXR2I3uZjYgesPrdqieA7WUPlv4yR9aGCT8nLQ6UXRa0
	/MEh07d+jpm9IvRg==
X-Received: by 2002:a05:6000:2484:b0:430:fcbc:dc4a with SMTP id ffacd0b85a97d-434d75c16c1mr5425911f8f.19.1768508338952;
        Thu, 15 Jan 2026 12:18:58 -0800 (PST)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435696fbea8sm1034255f8f.0.2026.01.15.12.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 12:18:58 -0800 (PST)
Message-ID: <f73b6acd-7674-44a5-8ffb-79c66f940cb1@gmail.com>
Date: Thu, 15 Jan 2026 22:19:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v7 8/8] net: wwan: mhi_wwan_ctrl: Add NMEA channel
 support
To: Slark Xiao <slark_xiao@163.com>, loic.poulain@oss.qualcomm.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mani@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260115114625.46991-1-slark_xiao@163.com>
 <20260115114625.46991-9-slark_xiao@163.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20260115114625.46991-9-slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 13:46, Slark Xiao wrote:
> For MHI WWAN device, we need a match between NMEA channel and
> WWAN_PORT_NMEA type. Then the GNSS subsystem could create the
> gnss device succssfully.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

