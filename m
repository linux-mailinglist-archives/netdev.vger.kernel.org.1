Return-Path: <netdev+bounces-180934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BBEA831BD
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 22:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3088A169CBF
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 20:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FAA1E3780;
	Wed,  9 Apr 2025 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZfqbmPI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3541315665C
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744229879; cv=none; b=iwrwqWI8bz1lOWDtRF1xSy187smJNJt6BDEL6C+44R1LgAfNnKCzygiCZIDuRG4ICumWSRqtXbLVP9SPDZdWPDXkn/eKGZCmY80Td9TyjQraI42gwJuITRNmAquOc1vdIq6maSnsNEohdXbqbIOwowDNJVFlBdc2ncqn/JB9unI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744229879; c=relaxed/simple;
	bh=FJiaSgmCY7rgMyGiFxCwyRHK5ZdMcPLZdOv2AnKfby4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYcYVIhFKUZ+RsTGVuikug1pS3Vq24DmniqNVWgjP78cXlO6Yf6lb+7r0iTLwcel/FTmyYtPt12bm7246lMcgjthsx9WDI3mJEJKtywjkycspaDUWVdXoAok8LW0qydFaP96DVXLcU2rSPIra7lwzG/czBwrBkNgaxHVTPPX2iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZfqbmPI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so1252965e9.3
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 13:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744229876; x=1744834676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s4obEN0V1TGPfVWmiagjSmC7qoocBvMsBc8A5ew3ezk=;
        b=LZfqbmPIHWgRq1L9TjscfI4Reuwx/f2P9DI6abPs8vAcRR2ynanaKtfplu1/U2it3o
         VLGEIJRjSQGEdx/oAN5wSuDaKrdfWlM0tMx8BszN2s+wj4Ad9E1p1lTBwSpIQC/+vZVA
         BFThV4Eh7JhO5HHLe5Sz4T8j/ed/8VazSmPWlSS5HI9224vu/4Kde1WOgJL1H3+HupzT
         JpfWguZIa97k+kq5WaLasIcRadchM+3LEWgwBKyrSXG0yhsQxukKMwdJ/6HnE9UsRCV4
         CbidnwZ+DsvxP7VQbE3pgaoNARvvE7KioLYL5wqG6XFzCnuIKXwYEAFAnI1GUVqTYLd7
         lRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744229876; x=1744834676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4obEN0V1TGPfVWmiagjSmC7qoocBvMsBc8A5ew3ezk=;
        b=WARLny2x430z4C7vjQN/vb/L0VsadUEd8dOobaxceCJUDKLkxgrO4/65pAVSAaLE+j
         HwhRfflWyGGz8SZj2zRZDhpYVD4UFO+Y2qNUH/SBd7U66Wo2boqo+4Z72vkRMmq9hP/u
         Lf97Goaa0iotinIX5J3GIE8Vv9gkSzFn9yDg7cEew6zmqAAjp/k4IhdCYNi2A4zPUaBA
         holHTBdymZRY1slOo3gGuPW0YwVr9QfLt9eIllVF04YvOlwS8EwDGtf01unGOJRVmVFX
         evXY5q2moYcYleTljVrfDNio0sVPB5a4gHd1vQM7hOLz02NlDOW0ID8yb7o7Kj56MlaA
         mWdA==
X-Forwarded-Encrypted: i=1; AJvYcCX4BCx++iv/v9KKgprp9aDll7U7gyJMu3yrwwVDJG34sCYenGN+8r32ySC1lZTmYlTAy3WD4mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvsbMZVMW6QBpwfvZtaXtFMMZhpsk2SQ444R5dNnADCgnyoDeI
	fjd08gbLlPtRrcwkGLhJ0TR2z3W1cVFHEVOwoCovDxadnhOvIGy5
X-Gm-Gg: ASbGncsNhBgNIdnVkVRnqxF81pWXgTeI342o9aZsQvjaNy3V4FhaDL8e8wyZQwGCGPZ
	xUoouGRk5NkWpvUEejs8PNlxrWihr8O8Yzpm4cWUusQaSUL0oYC9Dt1JRCF80PFFOykwu05laun
	a2PUGlAqaRXkmP/rseTv3LQFI+sLlkp+QMTq+QOYAJmUAt7+eYvrWWbDYiWSEQJXmYlCajdI862
	qqOeITmR4rN89RfHDgGSkRqSyfxLhekpeW2haCNgCxDRIfrW1EtUVkTNlTNaYd9/cfC+thmI1kV
	vm9jolQMr7QmpbD/JkMRUjApVV8jpgsr4zkTpuLHNwxL
X-Google-Smtp-Source: AGHT+IG+P5l6toy18lw8tsY6IpvXXSjKeopj9J2Ll2Oy0J/9lb+S5xYfyvi+oLON+SSheNCYRuWhfQ==
X-Received: by 2002:a05:600c:4e54:b0:43c:efed:732d with SMTP id 5b1f17b1804b1-43f2d7da910mr3869655e9.16.1744229876285;
        Wed, 09 Apr 2025 13:17:56 -0700 (PDT)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c8219sm26538735e9.21.2025.04.09.13.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 13:17:55 -0700 (PDT)
Message-ID: <2c2bf904-fc91-409c-9ac3-cce132793594@gmail.com>
Date: Wed, 9 Apr 2025 23:18:24 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] net: wwan: add NMEA port support
To: Slark Xiao <slark_xiao@163.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Muhammad Nuzaihan <zaihan@unrealasia.net>, Qiang Yu
 <quic_qianyu@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Johan Hovold <johan@kernel.org>
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com>
 <20250408233118.21452-5-ryazanov.s.a@gmail.com>
 <2fb6c2fd.451c.19618afb36b.Coremail.slark_xiao@163.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <2fb6c2fd.451c.19618afb36b.Coremail.slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Slark,

On 09.04.2025 06:54, Slark Xiao wrote:
> Hi Sergey,
> I saw you add WWAN_PORT_NMEA here. And I have a concern, shall we
> add it into mhi_wwan_ctrl.c for mapping "NMEA" channel in
> mhi_wwan_ctrl_match_table since previous QDU100 device has added
> NMEA channel(So only "NMEA" channel is valid in pci_generic.c, but not
> "GNSS" in future).

This patch introduces NMEA port support to the WWAN core which is 
generic entity. Introduced enum item needs only for a driver to interact 
with the WWAN core. How the driver implements support is up to its 
author. If it needs a new definition for MHI implementation, then feel 
free to do it.

--
Sergey

