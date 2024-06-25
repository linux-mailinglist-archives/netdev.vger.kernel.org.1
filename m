Return-Path: <netdev+bounces-106675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD69B9172FC
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 23:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800041F230E5
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 21:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A0B17E470;
	Tue, 25 Jun 2024 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdEj75Jo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24CD17E45E;
	Tue, 25 Jun 2024 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719349776; cv=none; b=GxZoRDAyBEBhM9Hpc+QeI/WZrm7ObsbgMksrInSDDiqoNLChvRXmplx8wBNWcCBUXczVNY3cX053BakPmV3z55qwDdzrgPJjxjVXXy038s6lmGb4NO1CN/7ogEl3JB+Nn/Kn0UWDJMmt91J8qcFKYwSZbl9393yiFzkLQc1qgZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719349776; c=relaxed/simple;
	bh=Xu45uIzQHdnypNu7DRxZUJKcaTZ3LfhhfhPhOKXp9W4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HczYaTwFUpSnqiB+Q7d38iOe/t19kKIikb/Tj+CbuuHYLYtlEpoGpdDvtDzs8BzoueYCSSo9O64jaS9ygKLPKEFel50PTOHLQdkqw4YincJ3zsmhfnvyPB9PyYjyU00tGP2rYfgGVsnYcfcDpD9Ly4FIHWV9mBWm7VPFdarZYkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdEj75Jo; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-36532d177a0so3903967f8f.2;
        Tue, 25 Jun 2024 14:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719349773; x=1719954573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4iWDNUDVTphG1rgmjgNH/czm3AGoDZYTbFR5lheSg+0=;
        b=OdEj75JoBW0EwJE0+CLOhYpWZlm2MjIh4K/F5ksgzgXavWJrxXI8QM/rWA5JgUiH+o
         M7qSDe8Y73AZKjbmowdmB9qTYzG92vaPvWyiCh8voZdN2uNQw5Ead4xVhftqAc9BQocB
         tlWIOBzRR3di2IOoo+2YpEoAizUOCnD+eWmmnI57GaI1YOP8PrSiA43pr0tgge5qkfbM
         gcV27pCGZgT/zr2E0g+CpR7mQguWQfhwcqK3KxpLx0BVJNe93L3xrREqiuKedLd3CN0O
         qGnuZAVA+utUb6zGH85IeKner/Yt9LVWSZAGaQ8azZ0SkUXKQ1jy7uoDXwJ9XlY6xxEj
         hWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719349773; x=1719954573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4iWDNUDVTphG1rgmjgNH/czm3AGoDZYTbFR5lheSg+0=;
        b=RWwm0KqwYJGjGZFVm8xS1C0pVfoniYmEtTuqQkzRp2GeSkl0poa99w22x3auUbuILT
         5kA9gdy4gLEyD6GkYcoKMorS+yFW99iEb5rp/JPED/3FKiXGOmrTfEBASqidhRu2bUON
         Btwr95KkbRlzQLsfGBG220cM9WdUVEi0eB5VxPob2XoKcPdw0FgY8hwSycEqmu0qIEVn
         r0C6g1GLS/KxN5qQkkwA8xKtwx3Kw99uSbZeK7INR9pYLyAJts5GvtzCALEkjq6KaPGK
         VAodUeQqA3l3sZ/1nl24yhtpWwH2qUEAgFl/jF+5EVl05Kbhjcju7f5DSnBDBSPa1EYN
         3FMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIzUR2Kx0NY9Scr6iuhw6NJ50tdkhAFB60GKAI/XZ/gxw4feZQFMdLXB8qFFeBnZ4XzYLpp/7VO7+UUfODehwIjmnDhYf7YvQrM4nIvklR0fOaWpG2V3rwTUbiBokQJKc15u2s
X-Gm-Message-State: AOJu0YyIj4p7x2tPMU0J5y1aGPnNE8uQ5vHplmmymS/Qxcg6H+ejkxUU
	Gc73ioo0bEYnZ5NFS9OwOxUWr0LeFnZC41mAnmIN72/VcN0eo4/R
X-Google-Smtp-Source: AGHT+IGpkdza6v3HIR6EYmPjuP5pORubsucqBrjXsVVPRRFCfvTrd2WX5oxTGyVhmVlVtNHbyrBklQ==
X-Received: by 2002:a5d:58ed:0:b0:362:f291:6f97 with SMTP id ffacd0b85a97d-366e4ed2eb5mr5801190f8f.18.1719349772647;
        Tue, 25 Jun 2024 14:09:32 -0700 (PDT)
Received: from [192.168.0.5] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366dc9c855fsm13097320f8f.84.2024.06.25.14.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 14:09:31 -0700 (PDT)
Message-ID: <62976019-1e36-4e2b-a0e1-9053abaa658c@gmail.com>
Date: Wed, 26 Jun 2024 00:10:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v2 0/2] net: wwan: t7xx: Add t7xx debug port
To: Jinjian Song <songjinjian@hotmail.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, johannes@sipsolutions.net, loic.poulain@linaro.org,
 ricardo.martinez@linux.intel.com, m.chetan.kumar@linux.intel.com,
 haijun.liu@mediatek.com, chiranjeevi.rapolu@linux.intel.com,
 chandrashekar.devegowda@intel.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <SYBP282MB35285822CB2270DAC2533DF0BBD52@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <SYBP282MB35285822CB2270DAC2533DF0BBD52@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jinjian,

On 25.06.2024 11:45, Jinjian Song wrote:
> Add support for t7xx WWAN device to debug by ADB (Android Debug Bridge)
> port and MTK MIPCi (Modem Information Process Center) port.
> 
> Application can use ADB (Android Debg Bridge) port to implement
> functions (shell, pull, push ...) by ADB protocol commands.
> 
> Application can use MIPC (Modem Information Process Center) port
> to debug antenna tunner or noise profiling through this MTK modem
> diagnostic interface.

It looks like the mail server mangled the message id. Id supposed to be 
'20240625084518.10041-1-songjinjian@hotmail.com', but it was replaced by 
'SYBP282MB35285822CB2270DAC2533DF0BBD52@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM'. 
So, the messages chain become broken. Could you check it please?

--
Sergey

