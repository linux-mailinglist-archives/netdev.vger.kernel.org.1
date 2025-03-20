Return-Path: <netdev+bounces-176509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA6DA6A94B
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0735F48272E
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317C41DDC0F;
	Thu, 20 Mar 2025 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmYrSnJV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A75F8F6E
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482834; cv=none; b=h9FIEheIkUm7yFBu29ux1LbmghSu0pRP2vlrLn6jvAVkxafaPkIqSCfut9n0Qz2PUzmve7hsm6U0inxMoIIAnPPL+ASir2cMzVmfrpBWOTeAIGZLC8Usu4jqWTXMUo4dqyJ/C4H5AH2FhdxnIUT1FAgD5qwpuMsp9FnYzAcl0jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482834; c=relaxed/simple;
	bh=eTu9CGP9ZaL33b5B0E3w5J7AcGuKJ26cZz9K1XZeOEQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KUXA2bsBz7W+I3PGdU2Vsr8xVtPnz1/8FSKurQdKVuj1Rsw43l19V9OE1URUw6WZ4lu1EZH9l8BpYnXaErOUsOLOnKBxfM647eIuH66YBvoJW03b/Eivad++SdC+pI+T3sD57M5cQ8xwzhxCU2l1+PyEwv+rOgtD5cZzGHSX99k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmYrSnJV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43948021a45so7864395e9.1
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 08:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742482831; x=1743087631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SEIwPpy7iMTmumn0Wg6kjIDrxofDmtuRLuwaEdPyS8=;
        b=mmYrSnJViKD+/7z0QhgnXIlTlWeW4xE3qztEPbLISMe7PfTNsgXBEotYvDXgJXFhDg
         ZChryNwg91YmzXjhnRv/WVTLPDb5y2B53oKd0TNlpzC8d9EeKalAc35XAsllt8uRBdat
         h9vo0fsO8HbZCJ7yqSp+Tt/A8W/a1w9pbQsrkc6lUtEmqOB0pMtOJTtcNJkfsn+5c7NZ
         kyQo9OU/qFaESOvi22s2vAMk/0EXq8qmTm7udDB5Y2qXtGzjKHQ6kgYiNRW4vAOw8DbY
         AEroNs8LjOeJLUAdASvOS06HxAazZ/T3DPQ0K5i6m+9AhCTwUPvdEjvVwZmVnP1Qm3cz
         98fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742482831; x=1743087631;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SEIwPpy7iMTmumn0Wg6kjIDrxofDmtuRLuwaEdPyS8=;
        b=OVPuEgg0i/VpBBSy9OwoA9cpJCanNGXuwLQKVQdMkMI51k92DzG+bjeH9hXwJ2f5qf
         b7MMTezsNfH/gjRvV30Cqtjpkr56TuK+b4rIoGZmZHx2Cme4/h2sV0IDbs5zna79Yy4T
         rs3GIaSBNSIWo5j2AFQ6gKmxigpB2PmHlzfqFfGuVm+YUXr3IUj/JmCvtmfZXLDw6tlh
         TQ0OKsfyiWcaUao7wlJPqYlLjVBgvMesLFzGd+ji1u9/aYltUI7VSR/A+5+2ftXELQfS
         GpSr56aSb24FIUtgzdIDxF4WopCYtvozJ7EQU/HZms5Z44REauLJIBxvTuYyD2SZgjuI
         3WxA==
X-Gm-Message-State: AOJu0Ywn18IZw2jWoib5W22cKhlGyrCfhUdbAoczZV88uwpKrAg7V+vR
	EPHccL2SRFWf+oHVusTlBYW5qggRQkYywvEwNrKevi6elmjuQmyUwn41ug==
X-Gm-Gg: ASbGncsre0VHCa3PMkLmLndG8lgOlyrJb6pR6RAF2YImIGWwI4SaoJ6Oo0XVmTwgX5N
	yEFrSLVyFvXiTYahYkF4U51oiSs8pnYGAwXj1b3QTpKfgHs9QPoqozT0icb7HSWASssSSFaorZn
	9fxGx+VuC1TqoIjmjeoCilgzjUugAYvdNSaZ//g8Ye7c8P9L0bICHmpKrGWP51WvejAOI0zMiBN
	sxuJkhgRWSr9nEhHYwsBTDUIwzH+/lbt0p8PmNUvcdKPARkYHUBGnbdGVxNnMdTbM0HPnlz4PUQ
	vCZxjK45J1gYgmiWqV7aECMI5fIjRrt8yei49q2oJtzTTWltfsbQYpTREyspx2lbG+iFkVB7dfV
	jVZquZOfLcLIYAlgTiHSM7F5+DFpE7kFHe1ZCPrRwBu8=
X-Google-Smtp-Source: AGHT+IFVXLsa9Dj2UxMrlcmXAZ20OL2iCVxYsH1iPQluMK6K19XETjcot6KM96SNgFVJXgZR+Wgd0g==
X-Received: by 2002:a05:600c:ccb:b0:43c:fbbf:7bf1 with SMTP id 5b1f17b1804b1-43d495b084bmr34235765e9.30.1742482830498;
        Thu, 20 Mar 2025 08:00:30 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c888167bsm23963166f8f.45.2025.03.20.08.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 08:00:30 -0700 (PDT)
Subject: Re: [PATCH net-next 3/3] sfc: support X4 devlink flash
To: Paolo Abeni <pabeni@redhat.com>, edward.cree@amd.com,
 linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org
References: <cover.1742223233.git.ecree.xilinx@gmail.com>
 <6309a6a1b81e7d6251197c8c00b8622e6b17e965.1742223233.git.ecree.xilinx@gmail.com>
 <df4c25ac-8929-434a-9363-2d3761f8fafa@redhat.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <46cf0fb7-74a6-4ed3-10dd-c2c187af96f3@gmail.com>
Date: Thu, 20 Mar 2025 15:00:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <df4c25ac-8929-434a-9363-2d3761f8fafa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 19/03/2025 07:50, Paolo Abeni wrote:
> Not a full code review, but on this error path the reflash_mutex is
> apparently not released.
> 
> /P

Yep, thanks, will fix.

