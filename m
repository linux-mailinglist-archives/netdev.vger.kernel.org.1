Return-Path: <netdev+bounces-150889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611359EBF96
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 00:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540F8167587
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 23:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDBA22C35E;
	Tue, 10 Dec 2024 23:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRIL/FEd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FD822C352;
	Tue, 10 Dec 2024 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733874498; cv=none; b=hE6EVlwyKQuB4OlDFuoSiinv5HvLZNeQ8vclmrRxeH9R8mq+RmgKy8dvoQ61FzKYSBM7l6811R791mCI4E8xmCqyEk3+3oljfbFJF2UGMHqw2Bhr0KAe8t1D6tjytclF4P5hkt4fK9IkwfdwPLRdSykOjo5BFHu4tOgCIliM0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733874498; c=relaxed/simple;
	bh=Lp09MjOylsSyKIAgxhxl0bO4y+Lm//RliCsSA7mpCW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYDag+qvQ1zY8b3tkokRkIBwRF7XBbMnpPicyZeO58i+pNABH5HbjUTlFilTAbh0DkpbpGxoLpdrRucb3zDqvmJRAhLz8knrRzWTi3oHRmtWll5dKp4rWqQctGPya/R0lBL9hefNx02OMyPcxTie/Qb7nW7JqYe0Z1AIzpTmIu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRIL/FEd; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so907856566b.3;
        Tue, 10 Dec 2024 15:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733874495; x=1734479295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukbIms0t1DZTxH1MdXNsTj5uHjkdpiYZBUWkKbFqYeU=;
        b=jRIL/FEd5Ki4XwYrM80ESceWLeuH1Pwhazcw2E/NikZ+tAesms+bixR+aYOKktl2Ui
         ZE0Hq8MkS+goSbA9oZYOREJ9uSox70QohobtgGiZ2RJwwWYm4nfmX2inzvX0J/Vuo4sU
         eJ0QPVwnzHHvHdjgf3Hdw25Kn7Zsm19MQtoWdTAiAP20b1HbVAnDaLut7X8i5R6Os6AO
         BbydG2EYs/sYbIDUyjbMPNj7ClMOTvgeS+DSCeMZIODUo2tfEKt/tGHlKJykxc9iBdCg
         eVkZsLRo7G4WK/pr69HDBIv+6oKTGZc6p6S0hrIHLg4oJsJcqFAu/FM9TmHgaemYF8Be
         azeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733874495; x=1734479295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukbIms0t1DZTxH1MdXNsTj5uHjkdpiYZBUWkKbFqYeU=;
        b=qFdfBLxDo7HfnIq6A1O58j2D5SE/dHuioEU2wS7ZT/sFIj+2jEYKqG4cjA6NoUEC9J
         wN0u4BAkbUgMFn6qWrWVOGtsgcSKer1xt/76hxPNLclnmxAGfjcQp8HsQewOn7rLZoov
         EkcNf7JbP66K1RExxyfKshl3vgoEVIglEIT4P0sRs0l8/6WxMEBnM004PwWt7F7vR3eI
         7zjtQEkFaODRFKdfTmDmliQq1lwmxElf8lT8M17CYN4VEbeVhaUssHY5UTywouMA3x3p
         kA0zKx7QmURQcvjhi7bfGpvVX7KU207nutvvIBm9OYhu3Air+9K/IE/pr66LakuFF0eO
         GWfg==
X-Forwarded-Encrypted: i=1; AJvYcCWf/5ah2Th8Nd9uaTEUVmOiudBZmls6f1I7JO2nfhepFs+9ZTvkF+US2rmz4n+uUhTYN92e7KuJyMdLaU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRCy6hcvDwPgSI5aUatrPzkkqU3jpWYtFiSyCFyuM2ODmH9sWp
	wbEOs9v9GASa/kBInB6nzs6w0aAB1+MDVj+nY/9H/djK+7RFoC/l
X-Gm-Gg: ASbGncvpwADWvNZNCxkU6tPhDOFjYWPt//15OqTOrcImLqSwyZXYhT/efPymJRu5B8j
	0KoLnrVPXorixVPx4/Cj8tzbCzT1HNwUzt7D8Kdu/4YNjkV1WdYhVvZS6OttI3cWUckpR2fHHZJ
	cwAFodu+ifCV12LB7g9rZ6HSs5yHDuRxBn/mvWTh5QUREhooyKcmV5n04f0/R1vNi8jZt7plbqL
	uqFj0fbIvs4G+awbt7X1/105+sPY+DDGsR2C6kd2BiFHt/q6cS2WYw=
X-Google-Smtp-Source: AGHT+IG4np9YAocjxEFLm7x39/SQp1jbMm3P4nLtiba8Smoyscql8ySPb2yi/8a3fCNXNrboToIipA==
X-Received: by 2002:a05:6402:5207:b0:5d4:55e:f99e with SMTP id 4fb4d7f45d1cf-5d4330a5c7cmr1438120a12.18.1733874494920;
        Tue, 10 Dec 2024 15:48:14 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa69964872asm270956366b.103.2024.12.10.15.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 15:48:13 -0800 (PST)
Message-ID: <6dc095f8-00ca-4f4d-885e-735ef6c2fa80@gmail.com>
Date: Wed, 11 Dec 2024 01:48:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: wwan: t7xx: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>,
 Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
 Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
 Liu Haijun <haijun.liu@mediatek.com>,
 Ricardo Martinez <ricardo.martinez@linux.intel.com>,
 Loic Poulain <loic.poulain@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241206195712.182282-2-pstanner@redhat.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241206195712.182282-2-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.12.2024 21:57, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
> PCI subsystem.
> 
> Replace them with pcim_iomap_region().
> 
> Additionally, pass the actual driver name to that function to improve
> debug output.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

