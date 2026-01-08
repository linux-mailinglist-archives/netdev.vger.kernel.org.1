Return-Path: <netdev+bounces-248287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBF9D067FE
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 00:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2CE93032E8A
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 23:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCF532B98A;
	Thu,  8 Jan 2026 23:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIDEuas0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D209532ED42
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767913239; cv=none; b=jiznPUNnlcN9SOj5qIO3dU+e5WRkCfny2mkpD5kjhXe+9W5ePGmaMJaQR6keC72UWbfx/ZhIm2ZrY264+5+xR+tPKnbg084YDJc1UfuNnYWxWZ0Wm8ySI5mqn1/QzX7KYC4tG2wWgppX9fmVbxD2tZRaa3nhWBnF8TWvtA6IajY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767913239; c=relaxed/simple;
	bh=7uTjsH5gjDU9zpsTpDuUn7p7VXGiNcg2iXBbtGllmF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7mlnJ8vuohGMzBmS66RQ7x2CNQ8AEDhratVbVcLyKIquEQWujqckysYNkx2wyZY9PhiCsgbj9ewFhkTzmt8tOujfa+bRcl+qezPmIHeiqmdbPeb1N4MU4XJMubd7CbtC6jg+mQ/Kxu1pGOkT8WVOrtu1bYYLu0jdDx6NVHgY08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIDEuas0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47d5e021a53so27781185e9.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 15:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767913236; x=1768518036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kTs5F2JHv0vLkSOoY06Hetp6FjpguwAewpS9fSwegYA=;
        b=dIDEuas0L3HEj2dlhjFS2r1c70QMFzWhFP3avr3tpHyeWTtIqfU+d/IgWGovOQJWJl
         rsM2Ltq1bQhFt5iDo2MmyC9RScGJm6kW70qZOZTOdou0yAhC/+azdm70I00/DxbuNo8q
         F4gTaebqcLToDekIGj3YGt7OubuPFnswGh5oeqPSFeRAqqT9Te3PTZnWVdXK/iwG0tnA
         b8RfOJ5biAiweftGsIxRZTCHBov7fFv7+MHT2Q23qO6WcGGnziZT8CaDQZftO8i2pmtA
         a07puAsXFbHVXxIugt4oJJyxAlCsKGmA1eb+TA1MXqF/QbMr5aXNYvfhjKCijKJT9WgH
         utVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767913236; x=1768518036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTs5F2JHv0vLkSOoY06Hetp6FjpguwAewpS9fSwegYA=;
        b=X4V2zN9EoQ2TIr+xj/V+bCzKUtm71UHFdmfHq150dXKgbuL2+dmM0RWn5TCrzf758q
         eA28EfwYbFYWN4SoafxZSV9LF6feA8fJn128kOQJT42r6vNeZez8XE46yFT/Yblhhadd
         LuzJSPtJqmkFwH63iweMaM1vn7JS4d4qmSzakE31uLd57GngkqERQzt6KM0XLbK4mZBX
         3IiqTFPJ6nvYuJue9NRdAApjOwYJth+s8IpLH3ZkttASYPeeorHsPHLliFj7zym9NCoh
         GBaw3yX8WnbSuf09bhes5SAkDH34Xjy0a2CMgzmZ8G9Z2pmxBTo6KjXYEzXirEt7NjDK
         h6cw==
X-Gm-Message-State: AOJu0YwluCfemPF9Bj6IbIUPZnRiZjAhgTMl1kpP3596YYTE5zg/sUcf
	SpCSncxc74bAPbZhjaUQw8mQJGoLbJfw2pGtvNckyiYB7H8lAEWb30Ju
X-Gm-Gg: AY/fxX7gO5t8JxKnluZXEpaVXoE97AAup3UfeqxAUigbN974IMWkl6PG3o4hAN0253q
	ssuvHnIZ4iKGCsVOzxt1lV78j2yGQGVrZRX0mVDlkhid45fP7TlDOAci6aLJjPxzhknK2t4fIg0
	eyPK9ve0hI7tWYk5IPyzg/CFzf5MTXstUucJaq2eKZHdK51bHQOgiO7fCpOD3I+88EmqAaVYdXH
	LDm+qlpjQpT+ULt8ot23u8lQUopVkh7KOZVrGwR7R9tJc+X/Y2zTeYKxVaGrx6XgDQNEejjFCQz
	IGTFIenpNn1Brg7kLOroEbwNClGBcDEY9cjcgeS0EpMicr2kiWZr+WD+ZP6onVlFjcIB/04O6Nn
	UTsI2e7E/JdAr7IyZGbNGFdbej5iC+C25AN8B7A3ZnoKu93qU9sC3BgOTsO0Poh03DN7uBWwPBL
	EUrlP0OLdaH5Lo6yqtCYSrWGFk
X-Google-Smtp-Source: AGHT+IEuU7ujUQDT65TdTzOKfQ2Ae2kq/1YVQ03DSFVdErxbkmkwOz8rJiBGKnYVtJPy0CDZ/hc5lw==
X-Received: by 2002:a05:600c:4e8a:b0:479:2a09:9262 with SMTP id 5b1f17b1804b1-47d84b18037mr97353125e9.9.1767913236018;
        Thu, 08 Jan 2026 15:00:36 -0800 (PST)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8715b5f7sm50302885e9.4.2026.01.08.15.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 15:00:33 -0800 (PST)
Message-ID: <599905d9-19ac-4027-85d1-9b185603051c@gmail.com>
Date: Fri, 9 Jan 2026 01:00:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wwan: t7xx: Add CONFIG_WWAN_DEBUG_PORTS to control ADB
 debug port
To: "wanquan.zhong" <zwq2226404116@163.com>,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, ricardo.martinez@linux.intel.com
Cc: netdev@vger.kernel.org, loic.poulain@oss.qualcomm.com,
 johannes@sipsolutions.net, davem@davemloft.net, andrew+netdev@lunn.ch,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 "wanquan.zhong" <wanquan.zhong@fibocom.com>
References: <20260108125207.690657-1-zwq2226404116@163.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20260108125207.690657-1-zwq2226404116@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Wanquan,

On 1/8/26 14:52, wanquan.zhong wrote:
> From: "wanquan.zhong" <wanquan.zhong@fibocom.com>
> 
> Add a new Kconfig option CONFIG_WWAN_DEBUG_PORTS for WWAN devices,
> to conditionally enable the ADB debug port functionality. This option:
> - Depends on DEBUG_FS (aligning with existing debug-related WWAN configs)
> - Defaults to 'y',If default to n, it may cause difficulties for t7xx
> debugging
> - Requires EXPERT to be visible (to avoid accidental enablement)
> 
> In t7xx_port_proxy.c, wrap the ADB port configuration struct with
> CONFIG_WWAN_DEBUG_PORTS, so the port is only exposed when
> the config is explicitly enabled (e.g. for lab debugging scenarios).
> 
> This aligns with security best practices of restricting debug interfaces
> on production user devices, while retaining access for development.

This security argument sounds a bit weak. Debugfs can be enabled easily, 
and devlink allowing a firmware replacement is enabled by every 2nd 
driver. Proper privilege management contributes to the security better. 
ADB is hidden by default, and a user have to write a file in sysfs. What 
does effectively mean that he already has the root privileges.

BTW, why does the patch disable only ADB? MIPC is not so dangerous?

On the other hand, I agree that ADB is not a port for daily usage, and 
it might be beneficial to save some resources on excluding it. Proposed 
patch eliminates one array element, what does not worth burden of the 
new configuration option maintenance.

Considering the above. The patch is NACKed by me.

--
Sergey

