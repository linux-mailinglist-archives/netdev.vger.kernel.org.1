Return-Path: <netdev+bounces-232960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EC3C0A5F8
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 11:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18631188C9A7
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 10:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E617017C21B;
	Sun, 26 Oct 2025 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PshB2GUP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1916FC3
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761473841; cv=none; b=Z1wcQ8JuHCbKpkNZfvm7VgCt5gYxdjJ8dWsTN+dSZXhiaAzJPeUky3cqWe8IPD5QB+Mu7uuJhJQ7oBRTQiyoFvi7sChOsumlarqlxBpUoXFL+cR8+DM3J8ykUB5Qd9Noc+m/SRcE1xxS/OpLGkogk+zWgr6lbdRPX2ucCQBXhwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761473841; c=relaxed/simple;
	bh=gMD3G4ZxXqskaNyrzUNjhADfrHw5dMqOo55bKaKUfBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VWUpQQanr9xVFRab8NAMUja0dGixxEgQQTV6ks9hVQ5uOrHXNrOAf/eLcTZaFodIc8EanZhfGJNWzAh+xRIy3d4LFf7MX8f89tmYOTcBYW68/cbN08ErOK2IuTgkxg/nZV/3yd6dhoeE7XZJJ286LtLcxygwctm5/Ba3s5dIs4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PshB2GUP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4271234b49cso572874f8f.3
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 03:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761473839; x=1762078639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xw8qvM/k9x3QM3FUGccHK4P+EbI4lHRF8d2YmWsJ6mI=;
        b=PshB2GUP6a6uhp0vAUP5OmwjNHX8Yib2Rs4HfUy/CpVoPpa4/0IHbe98Ct0HM29JHM
         WDJG5z/l0CWp8MQzbgFeTK1modSvnmQ0UUkuI0MSm6Ibw+mxzeIcFeP1aESZ+BVF6k/L
         Yi1SedHgGo8OrBYIl5VZyKhaU7yjSxo6k71b9/CqWbT1ew3flMeD1ewRK5SbH/P4ottO
         WPn7icZPA22x1zB2WJ4xzk03giFUXKBa9UZ7sSpg6h5ncWGpZyIwlf3GInDVU17MJiwe
         ebMEdY09mhf+eBe5lG725kOVIJYWBqk87mmISR9hJacrfclBkKgBUtMBdXx6B/BvNDtd
         XR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761473839; x=1762078639;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xw8qvM/k9x3QM3FUGccHK4P+EbI4lHRF8d2YmWsJ6mI=;
        b=GSrT5Tbyee5crjRXvIx/1pzrequDnwDjSvMkdx1/Avv2H353S9iB9R7VvEeAzyjSR4
         s+4rK8qJZx5swEUwSehl60bsnJL2RiB0GR/AayT+iRYB+M+5fxphLkDJWZ2vJNCq1ap6
         3PpME/ivs+/VtP/RtIcsR27afK9Bkd0KiqQsCMVpJ2VLtX4JuA2IfBe0YHJfEyXsQHSt
         F7EFAqRnS7y0yNDVr7kHQkJuHaRIPZkwdbuZB6EiPxwW4raRl8XU4moxhEaHwcNJbAay
         Uk3wm7vDexXI19zKgTMz09YgusqHG8kRgy0DmpR3HHU+x6mwm/m722iVlBgv785GW69p
         J4MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv19uQJn02/dFo1vR5RUJzQsKJPrahMoBG9PHK0cyU8GpAV2oBtNQIr6PAwKRRLHEJVevF3Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOdHbCP7KWTr91zfHoQCL5JjR98RxFJZdonWTxd84BxyvDdj2a
	xaWeInhoa2InuvFlezpQtgvbSfhI3szgFI2vimGl+oy01R5sq7In7nXFkaJbEnLupCM=
X-Gm-Gg: ASbGncsroOxkNQcIChzRYC5aEzO4pL204K2SJwKLfjPMqL93s4kl5UwZLVFX78SimhC
	uwYLJSHOqD7HMwCPXaL23azgyK0zPZcyW21NbcH9Fm3hpJa9Ny1YcX8a0SAx74Z0njIP0ifdmz0
	mxxfbmGjqa75J4srA4NrO88ZSZZQ/JpAFh2+juCle5Qu+fxa9gdJ/H3cs5ubU7+ZtrLYXNg0fdE
	hLFSsakQ/dAAFEf51AbQqmBuX0B5Krxf8AmNlrj52cLW/Bs5SCCTKMYqBg7AASSulvmQWM9sjHg
	9oUL97eCk+gocFpSgI3d+JvF73GWvTvAuMOgdIKR1eIIFTw6D4y76yv794a//kR2BR5EYMioNbW
	1B/jvf5iFq6GkP7bNR3qUZLYIuWQixZllVKxNNOk54eWblofvkosPuk8vv/pUCzXX097XF4cT6+
	4V1vekRVLaNVhQcbWpsEQf
X-Google-Smtp-Source: AGHT+IFFbfGbMDbsWBBs3RsW/GIAAV6RF9Uol3ZED7FMAKqg7lkgjIlJ6dqknn/N2BG9SMwePdI99Q==
X-Received: by 2002:a05:600c:1d25:b0:471:152a:e574 with SMTP id 5b1f17b1804b1-474942c4fa0mr110129115e9.2.1761473838648;
        Sun, 26 Oct 2025 03:17:18 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd47853csm74937545e9.13.2025.10.26.03.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 03:17:18 -0700 (PDT)
Message-ID: <908748d8-a436-4ed8-abdf-bd228292141a@linaro.org>
Date: Sun, 26 Oct 2025 11:17:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dt-bindings: net: sparx5: Narrow properly LAN969x
 register space windows
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251026101614.20271-2-krzysztof.kozlowski@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20251026101614.20271-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/10/2025 11:16, Krzysztof Kozlowski wrote:
> Commit 267bca002c50 ("dt-bindings: net: sparx5: correct LAN969x register
> space windows") said that LAN969x has exactly two address spaces ("ref"
> property) but implemented it as 2 or more.  Narrow the constraint to


Typo. I will send v2.

Best regards,
Krzysztof

