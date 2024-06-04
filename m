Return-Path: <netdev+bounces-100739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6854A8FBCA9
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 21:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E004BB21049
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 19:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A898B14B07A;
	Tue,  4 Jun 2024 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eubmOaYP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17957147C91;
	Tue,  4 Jun 2024 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529919; cv=none; b=cltUQAmjLo4Xe6hX8FQg/Joh0Mh/qWbrD8VrwIjvwfCEGiMku+t2PAuSRjd1Wj/Fh14hQyrnvopBosDXCx0DJ5GOQAEELNq8dQBE8pGW8JLeMPpPNaGYKHtkA+fasag+RimjfwFkpA7n7IQKl5skz5kenQT3ds6v4803CaR1fos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529919; c=relaxed/simple;
	bh=vzpA7PhiRZMIE5wHE8wHo0Nvafg+sm213PxA91ONTYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSgqeGoL373B9IkNnIJlVbMC/t3ODZtgX/+EjlPfvgyxsSpDC6s2jiuezXIrqq4/zumkl91sQJm3bg5jMZ+ANm0EPCSerri2y7V2hfcD5Sxu/NG3Z4jiD+q8T2k/bwkE9eaPrmN37gsgvoEEVNcEDkMy6RnyWMk9Jx10dXZz4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eubmOaYP; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35dc04717a1so4476374f8f.2;
        Tue, 04 Jun 2024 12:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717529916; x=1718134716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4t2g0PVVuuW+v+1R4uuv5ecvQtI5NuL9WT54hihDiE=;
        b=eubmOaYPggZMRWJ3QqGv7kWv/DDYrsDi6tu4q7yl9/Osf+/FpB6CtRjcoGi2pgVz1F
         tlLhcPl13piOwoGBvMiNne1aQOm3HoXHGfbrz/HGMl08XV5jF8BmYuBIVm/c3M0rtyhA
         mNrxussSc1wCxjW19VoXXCi5lEb1zxVzyCZNGhBEVL04UFQDNPyXuBQzbelZAABiR9qA
         atV4EReAnjpp7GnJbjrMTO55qE9ns0TgZwbiyIwkoS+PA9C9x50j4PU1DhzFlJTXKBzE
         IYj1lh9bLnvzXeatbqY2FP40MVO181XS2nsSrvAVl73WbAnTgRVeB+x/2q1FU0okXMGC
         aPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717529916; x=1718134716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4t2g0PVVuuW+v+1R4uuv5ecvQtI5NuL9WT54hihDiE=;
        b=hIk9O0Mghp1f5jPBtr2ZCSOCOfhds7NcO/n4HB4riE60cjagjOz/T3mURwmpLR9Z9Y
         0CpnfCckqv7nj3AXsZ5iXIplInGs6TuCm7ZXl/4kQMD91wVwqiMje+9oJSHWeToqXPTg
         t4iRJof4HGKRJchvoMCcRL5kKgJILldb2OfICuAmO0a50AxR8f1XkUdxcGvfzBIUZzzA
         FS4iKywBeBtmg6Sdng50UjOumjxEbNb/978flsn42OipVtQxgfiNBHHMY0IQ+6rnLUIs
         K7EMtudtMJETbeOlsMGRMXcyH0vUMiBY28AGiubtZOOhQ4DKXcnQHxqXJnpNyi2QNfaU
         9Lxw==
X-Forwarded-Encrypted: i=1; AJvYcCXKIqcSedfG9V+44Xtu+07qULKblWDJgsXEldJVDefjS1OE1FN/LwLkcz3KLTEp4fEZemodvo/apWT4wT9y84wFxjkJi5JNF67LaUjgj9ho5tyteFDKQSSWxwqgQJ5mNmsFRoh4
X-Gm-Message-State: AOJu0Yy6r4wc/jXG+SZbl+shfXdLAXdFLN1kCjvTcccfL49uAZlRz5J8
	Jhdbfp5KILAjux+fYwCeslTlnRqZ/+paFMdrKKl3axLpjmaiWpWj
X-Google-Smtp-Source: AGHT+IEZkAaMD+sJQk/rpTCEjZ9+/enh6XV1jxIl/bz9yZxLYzVOYt3YtG79oKakWeHmm7OoGGr6GA==
X-Received: by 2002:a5d:5846:0:b0:35e:6166:2e1e with SMTP id ffacd0b85a97d-35e8ef90cc6mr333885f8f.50.1717529916248;
        Tue, 04 Jun 2024 12:38:36 -0700 (PDT)
Received: from [192.168.0.5] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0f2asm12536869f8f.3.2024.06.04.12.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 12:38:35 -0700 (PDT)
Message-ID: <cff64803-3eaf-432b-9217-67c8fa8cdc77@gmail.com>
Date: Tue, 4 Jun 2024 22:39:09 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: wwan: iosm: Fix tainted pointer delete is case
 of region creation fail
To: Aleksandr Mishin <amishin@t-argos.ru>,
 M Chetan Kumar <m.chetan.kumar@intel.com>
Cc: Loic Poulain <loic.poulain@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240604082500.20769-1-amishin@t-argos.ru>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20240604082500.20769-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.2024 11:25, Aleksandr Mishin wrote:
> In case of region creation fail in ipc_devlink_create_region(), previously
> created regions delete process starts from tainted pointer which actually
> holds error code value.
> Fix this bug by decreasing region index before delete.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 4dcd183fbd67 ("net: wwan: iosm: devlink registration")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>

Nice catch!

Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

