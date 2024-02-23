Return-Path: <netdev+bounces-74481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE4C86176A
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 17:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB44B1C2559B
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE8585627;
	Fri, 23 Feb 2024 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="AUX+KcMH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7D8594B
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704894; cv=none; b=eaMloMwP89OZfChifjr2Cfrtwgzowr7dR61L2oxl3mGAdOIp+e+cvPy9ha+9XOAcRCC8KuzaKmaKa/T/C6LuNvKJcNvgC3yHhSKaFBAPpXJsWGTwVQTYz9fQ1VtC1qCGSfY+IK32zZRGgEWIehdfgE3Up45CJjnEuVSwMR1+DXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704894; c=relaxed/simple;
	bh=xKgiQPQRUhHjEKNRFUKLtTd9hZw9hTY5uvg1yPtxmmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKZCbv6VQKULuRiRvGesTmmttSrW82q89uDX44JkvRIqhybQd2ioXmn/dPRfq4mLZNX5vJEp6vB3ZBmRsb24ofTcFxIGyGD3Md+8eQeIU/YyCeba0koPQZ6Sn34uBWrSDOLvu4pn8uGaWPudwt8csgGIzT4XlvXOHRiDcSRAGxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=AUX+KcMH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41294021cd8so3854825e9.2
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 08:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708704876; x=1709309676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YJl70iNdbcqFviWVktEHXYWAha39r0dE/qr7MjNB18s=;
        b=AUX+KcMHF6nSVty5Yd5e5UEsLNeRw5A4FsVIk3G3iRQWqEx/wejXp6e7819C9FyVeu
         NtxZbx9PI6mUlew8xXWnHCZIzWHoUoXPxxt4P+zp66d+m40HlM0dftBgoandwES56DCe
         fEaXR4f6bJwG1wpuurMs/xIVNiROXNsVX59Ae+HSqkyxqQkuq87iT11t1YMSNVErmhZF
         WtQZ1XGoDTwCa08AKLml3MEX2njjSlRH0kJQuSuTfUGrI2KRzpvmEg3tXms6FhcO1jGi
         eJ6hn9vQfeuTHPRCuGLQiQoMUMBDdF0PW+Pe4snXyH6EDjeK2DkdDfpw1TJAXsnfqOfP
         E3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708704876; x=1709309676;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJl70iNdbcqFviWVktEHXYWAha39r0dE/qr7MjNB18s=;
        b=kryqGV9TrBsF9iy0ip7AViH7uWbQvCc/izFByjcYPSLmzqhcB0Tj01Z4/HcliTa+Z6
         OZ3TuDd7lN4Z6dtY6Iv32KiRafsl16ktDYe4JX0m496SeY22FCTJIieQrcHqWQKYY59L
         mLYPrwrpiyZ7eqd6rZVCMM6Lu1XvmaFfxW41NOU4EjvLGboRTIUg0xLI4Sj64RWNNFzC
         DNfOjvrdxyluqdl8PBVM7ZWcUFV1qtRwF7nvYe6oFykbMnwqpBgjm1nMAp2klnHQOs+I
         7OkjtDpTUGdFe4gyDdNJ7qVPcYyvCH0gDbZihyCGuBLAqUxp4qN8dm4hEGEQ9Cx4fREc
         pTMQ==
X-Gm-Message-State: AOJu0Yx7aFvxH+SK7YKxn6zH7HTOf80qKAhthRbXexAhgN+0Yffj1gP7
	DE8gdWA+1Ul27oyJnINqwvCqSmKYdOf3BoJiAKc2Q8th1xUSRgyJD8Qtbi+PYe4=
X-Google-Smtp-Source: AGHT+IHNMMXYQmGXtljIWl/ekJh+9jwN18r7feVh5+71rMd1299XfPWy42q3e3QwfEc7AQGntYyVTw==
X-Received: by 2002:a05:600c:35d1:b0:412:16d8:d565 with SMTP id r17-20020a05600c35d100b0041216d8d565mr210428wmq.15.1708704876019;
        Fri, 23 Feb 2024 08:14:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:25c8:f7d3:953d:aca4? ([2a01:e0a:b41:c160:25c8:f7d3:953d:aca4])
        by smtp.gmail.com with ESMTPSA id fl13-20020a05600c0b8d00b00411a595d56bsm3057707wmb.14.2024.02.23.08.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 08:14:35 -0800 (PST)
Message-ID: <d9ee9846-dc7b-4e3c-a7ee-b23b6374726e@6wind.com>
Date: Fri, 23 Feb 2024 17:14:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 14/15] tools: ynl: remove the libmnl dependency
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, sdf@google.com, donald.hunter@gmail.com
References: <20240222235614.180876-1-kuba@kernel.org>
 <20240222235614.180876-15-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240222235614.180876-15-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/02/2024 à 00:56, Jakub Kicinski a écrit :
> We don't use libmnl any more.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

