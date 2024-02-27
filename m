Return-Path: <netdev+bounces-75273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F2A868E57
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69EDF1C21099
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 11:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958F41386B9;
	Tue, 27 Feb 2024 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="IeI5TQnL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3DA139584
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031975; cv=none; b=D3c172XavyWhyMIwWi/CRu9qhav59AdffpqrveFE5PARyqDUKAwt59OI4d6FA/666+9LwNkGOoS2OmiSVwcMJBrLY74u23yVrk1rubqMGk0Tui4tEW3NzTAhZXam9PA3dIyiXpd7yCE9mQDvoneJdLw1t5RV9Vman/dHsQwSJg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031975; c=relaxed/simple;
	bh=u51JWFv036cRvnw1w1tlLkdqI5TcE9uWP1FirBgf2O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IpW9IrRWvJF2watlEQtA0jUAJ/mNUv56uN6fql+AxTERWFRvbmgoghztImVS/geMM18YBh7QZ/to+4zl0jGuz16W6d6hCWMD1i5puMIukwdIZfGwp++xH0DGbmZf1r9vHBhLssKxsmFl/d4AxTS9XndLEPMwfi65FsNqMpKmbgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=IeI5TQnL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33d6f1f17e5so2876513f8f.3
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 03:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1709031972; x=1709636772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k56rjAKqNveTGHTwnkJ1TNT2rCS4EB5y8gW8gJgaKf0=;
        b=IeI5TQnLsW6SGbdpC6u1jQutZzqIqIcQJ20lKCbEA5Prg7BYhlSSjMOTnkRjK2z+CL
         I86jxbfzjZggTTLL5q7ol+6/o1UXYYaFU/hOy35IPvLQe8shHdV2d6LQBOUP7JH+tH7J
         BDngCd3PL6hyxq2hWlD1n9oO4hXLF+HKGBg3WhU/lmnlf1Ov/fv2m/gK7UwJ2tKSd/tO
         HNEBkkZOBFbRkEwarXqiWUPLGEJ49zzRTNOU+vKtfp6++A++XCH6aN/Gn2Vfi8H2tvaA
         SA43jBkoR4fcmTfwvvmgbhnsbv8cH4MnWmf32saQ3p1h+qwTl133EXCB2AWu6tjfD+qX
         gNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709031972; x=1709636772;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k56rjAKqNveTGHTwnkJ1TNT2rCS4EB5y8gW8gJgaKf0=;
        b=HdEwqIIe1i16tNrLodxnshMH0Lc03zW+BW/o5A9uO2gljsELT2EvwwteA5IBIh1GAK
         sjHorZInzwbZlFX6DLA+UrlgtJlcnudRDOrMNAi0WKf0MdMZfKKo2j4haJ2cr19vyOrN
         dkhR6INkZvKhMHu/ah4fOYqBqQV0y+XfqxPRGp4FU37LeDzOTSa7MZqGXfR3c2mMoisT
         tFdz5Nj1gT1dCmikMLoKpnKDzrwh9JszofXcFekL6vD+YzXKL79x+SB8Wz2MrWdYQaMZ
         GiQg12/38DutWM/Hzy7WQ9K0+zFpZpUcXlXcaGZDEUWE8b67cMQoC8ycOL80iWOTe+Gx
         sYwg==
X-Gm-Message-State: AOJu0YzJm7yjPNPnHqxkYyh3k5SemiFvkh50PITIHIu3uxYaa1cp4X6O
	XygMUFd8ZoQzjz+LACcSuqEP++Q7vQU7CuJZshAWge0Q1MxMVarpGYE7sUBoOSYB0i5YgTeUVbD
	R
X-Google-Smtp-Source: AGHT+IHvj1QusljoktMT8CfmGWHVqkm2KgXAbv0+2uFxRpldU7OY7v0b/sd7enfAmyqvYdiH655HEQ==
X-Received: by 2002:a5d:400c:0:b0:33b:26de:ea with SMTP id n12-20020a5d400c000000b0033b26de00eamr6724623wrp.37.1709031972043;
        Tue, 27 Feb 2024 03:06:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:535b:621:9ce6:7091? ([2a01:e0a:b41:c160:535b:621:9ce6:7091])
        by smtp.gmail.com with ESMTPSA id bo28-20020a056000069c00b0033b406bc689sm11493630wrb.75.2024.02.27.03.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 03:06:11 -0800 (PST)
Message-ID: <a1d7a94a-a0aa-4e54-aa8e-0fcc18e4c201@6wind.com>
Date: Tue, 27 Feb 2024 12:06:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v2 10/15] tools: ynl: stop using mnl_cb_run2()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 donald.hunter@gmail.com, jiri@resnulli.us, sdf@google.com
References: <20240226212021.1247379-1-kuba@kernel.org>
 <20240226212021.1247379-11-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240226212021.1247379-11-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 26/02/2024 à 22:20, Jakub Kicinski a écrit :
> There's only one set of callbacks in YNL, for netlink control
> messages, and most of them are trivial. So implement the message
> walking directly without depending on mnl_cb_run2().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

