Return-Path: <netdev+bounces-196919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02A5AD6DFE
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2624C3A3B44
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3C3224B07;
	Thu, 12 Jun 2025 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="jfXzAsN7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F0231A23
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724723; cv=none; b=TWxQ9fLT3BAwEmbJzvfF0KKteCBbFGBCUlKNHHjmuHhHLjOdNlyltQ4q1Vrwh1Hcgawsu+NUDzlSUpldCfNqr5TxDcH6kvG1pUGAUYV2FCbSzUiICcYEDJXJ2Br1p6Cgb3ynl63QT3LceD3AASicAyE2i3jZtzxZhPDxr5Rqk3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724723; c=relaxed/simple;
	bh=Dxl77DbUFGK7O2Y+toGQAH36dP1XAvme2IiKzEhonNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9w+BYJtvprM3B+CGjD0qR0uknqQrn6+v6gn3dx4EbrrAsicEf3EELxpIKlAu6rImrj9k179ZO7SLVR7EoYkoFmiKy16GNESr8DZL9y8b4MOCe935OlkubQI8hAM6Jq39+Tv+4C/Cs3PtdL7YIrMXLIgbYlwzrKJ4IGsbNnTye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=jfXzAsN7; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-552206ac67aso702332e87.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 03:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749724720; x=1750329520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GvTpPQ9lrVJYF3xLC4PEE8D1vqkgVuuEEGD9w4gNmVw=;
        b=jfXzAsN73gJU4R/hqGf5oGp9CGmC+4K6Dd9m+kPUtMW0nuGg+IUAVevYDpZGlZoslS
         G+E0zVSYfnHVDvZCd7AjkYBq9gd0iMsWkmC7gDf3gt1m0IYr980nQmzb/RCdfVTbtdgr
         NIiGARDU4nINS7BoOyJBblyzNCq3yT1XQQ2H3IBBsgOXZVQPg/R6cGDd1OXId7MTTpLR
         2Ux8xrOoE1A7yUnbQPKTB747Vj/sFmN+gaXdj+3z7Urba+lojKot42XXvdGRDv2aR2jv
         5neBBVExgc10w/Ay5gGq4yHQKQuQ9P7QVR4rd9HpQsZ4BW7E3LHJaVAfRtlK7gQ0R34j
         qu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724720; x=1750329520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvTpPQ9lrVJYF3xLC4PEE8D1vqkgVuuEEGD9w4gNmVw=;
        b=vRwggyu5YqgjuOqTDO85fK9Z3zIF9vfwzO37a6xiZQZAEx+2H1lcVUnDy2GEafAw21
         pX/1jsIMymc7u2bByT08NQNey/Y6H9/aT9OAiBaHMTVzz/XVw5KjZ9JXGXiFTauG2B42
         yml0Xnw4vRhubcalTOog9bBrgIhhuUAhN6ydRJsARoHAp4QjYDN5Jm6Br8zv1ogxGza5
         M+KG9ceWUTnmtt1Y1S07vz/k1Yh7xyEoKAe7RVKc/0EQGOz4LGsDCB+cl85MTkTe+szp
         gkaLka/Dpj6FINdtm/KNZZq++jE/Vrt2c0PZarEK7KnVUvzljUvpA9lEroYG3QCuzHRM
         qvsw==
X-Forwarded-Encrypted: i=1; AJvYcCUt3ULkQHB+UwUiGQV08BeicveYVOzH4y4RcfDerA41rvgKXbimbilAJXv+Z1FO2Lh+7laDbng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP5vIZda6SyotEEtxki8XuRpvCBuQNJDVJ5tUopn0R3SzSV8D0
	oXwwwcfPyZgT27K661cCIlF1zSsSz1jcZ0IGGlMJY5t86PwBs3yQyQtMYVcvQDzKqPM=
X-Gm-Gg: ASbGncvddtNS1SxWA6w4ZZnXWhC2bx1mAwuab2uPwavdqtWD+0AII7J73I2aCYK5ZRy
	S0QEA2Le0qmS574SWnLotl4f9ipc2EjHxxfOPaw1MkQa9leq87Q2LsjF5KjDrkdS1rFNcoHKNK4
	SqO/3TalB646Bqvj4ytoiIpUmXVVx2cVfcKvzHaHybCOH+xDZYvz9XDn0SlNewa42C1GlNh+WLF
	dpteAotf0Yuxn1rCNAwuNnIRgRM/NGKWkwO9Nin/hoRhcIDrto2xLPqogNE2xBGGFdqu0a29K7t
	pyTv+bozkiXe9Safz6T7IlEx5W/oCz5YvY9iYU4cU1dr+bjHOMtwTjZhjc7ZGVWH+/jXg6MoOpt
	Ly62i280raH+2GuQ5XLGpL1J1KnmwI+M=
X-Google-Smtp-Source: AGHT+IFes2kLZDGZq979B/RGOBu95QnEAstptKdXBQPpJhdagQxdRARFx1bnJlxzM+/Imeis4MYrlA==
X-Received: by 2002:a05:6512:4028:b0:553:51a2:4405 with SMTP id 2adb3069b0e04-553a55fdb36mr792090e87.45.1749724720212;
        Thu, 12 Jun 2025 03:38:40 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b3316fbe1sm1572271fa.73.2025.06.12.03.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:38:39 -0700 (PDT)
Message-ID: <1ffa6fa1-b178-4452-b443-266b46495408@blackwall.org>
Date: Thu, 12 Jun 2025 13:38:38 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 13/14] selftests: forwarding: adf_mcd_start():
 Allow configuring custom interfaces
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <cover.1749499963.git.petrm@nvidia.com>
 <29c1dfbb4882222661fa1546f125d55d72aa74ab.1749499963.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <29c1dfbb4882222661fa1546f125d55d72aa74ab.1749499963.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 23:50, Petr Machata wrote:
> Tests may wish to add other interfaces to listen on. Notably locally
> generated traffic uses dummy interfaces. The multicast daemon needs to know
> about these so that it allows forming rules that involve these interfaces,
> and so that net.ipv4.conf.X.mc_forwarding is set for the interfaces.
> 
> To that end, allow passing in a list of interfaces to configure in addition
> to all the physical ones.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
> CC: Shuah Khan <shuah@kernel.org>
> CC: linux-kselftest@vger.kernel.org
> 
>   tools/testing/selftests/net/forwarding/lib.sh | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


