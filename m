Return-Path: <netdev+bounces-216077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7500FB31E53
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 17:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EABD1D419DD
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ECB3054E8;
	Fri, 22 Aug 2025 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KjzXfUhE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A04221FF3C
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875849; cv=none; b=oiAu+AXmRKZUuPaIe3TEZ5SnPv+WqHxf0D62CGTuSVbLwjO5D7tL6YOTGayE1WqoKmB/rhqgMClC/CNITnEWPZuLm21VqPY8pbeoD+azLkSLbrfaYIWbZwho6xQ/+mTW4vpJYLEUKT6ZGyeZlIKq5Jmqey9MMW0FC4nI72V4k1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875849; c=relaxed/simple;
	bh=qs9a/XOifb3gwYxzXNZ4bFs+sHBqoJ0U3hM8MkBb7is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkblLYcHfPoJH1Nw+vmk6HKg3HHXTzqswAclopenbUJT56l1udi9BP/asf3mYoPY2Me6TRrT97/+hSfMq0hhbCZ9IyB4k/uOxiz+VWthIEB7fNsvZXZJIvsouYJpD+AH4gEtrNAC14HJfkUKMaoyQC2shSCUje2A5orEkIs4bCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KjzXfUhE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b4d892175so10017805e9.2
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 08:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755875845; x=1756480645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ls62rn3dMHOmB2VTWdVw4sYol0IkmBDufKybVQiodmA=;
        b=KjzXfUhEwkzRqI4MztHDFwC5yCjTC3ygY5DcSW1hN18UpGjjk0cs8NwgfCybd4OKb3
         8IvlLKKv9NUARrbJtVzSOSZMhKc1Hr8dwqM5+bg0qGpvbC4iILFQHM35w+VhceUTT49M
         kcZQ26rveiPskfbC22UjgNLrqwTAPBM00HxJz9ujfy4F5x6PNUCL1/crkKTDjlUPxlcA
         CQkDsifuhzWcAKMIbJ4uj3jfRbQEKxXD/xtyEQcgQdZQSrQ/CINaU+EXkJiEn+b6nqEp
         hS45+/kQ+B6i6SAbGRpU0Z12IuLGKP2IXCZCRjZ8+7hGAa5VQKC8/TMuYGKyFIzNI7n5
         9J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755875845; x=1756480645;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ls62rn3dMHOmB2VTWdVw4sYol0IkmBDufKybVQiodmA=;
        b=oV/vnuRRbNW6Pnf4TpPPtKppp/XZILbhrulUZz2Q553o6+zaWMhxsnpGgX5pC+jq/K
         h3MznKX5HnUUzPw2zhUvIXC48/GcNtC9KMzJmFWiSAHZLuv/gm26TKQYIc3Iel6ZcUbr
         N350DLrfjbKzQc2R7WWvmmgu0sJAhsPawciE1EuqNGPhirSDk572YCgLn7H0A0x6ZnKO
         NxXKwiEIS8lKPHu8zlMXjTUsCOWzyyvZoAdJiK3plp7y5NrSfMEriwpe22jx06m5mxXe
         dga7XhgW+4SCeqfhm/ayJFQ3kDBmWUqK+xhpgYPuRnO3IWN8QP3iikm4jSKMLho3CHM+
         pBWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTnvLgX9M0azbrzeLgsYqZtUTM+lJCfhZ1BMh4y1rro5SvsgHbljYjok3lE9HAt2qe5DOgRmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxksskZvBDaMcc/4GQgb9NBM0NQSbSCfZiSPQuLmnpLrkK8UPuo
	9S2urCRIRxv2Y9mGbIYgNDs75gp0bhbU6+PEPe/1mOJV9x9kbXekCOl9wj8U8rHMAuc=
X-Gm-Gg: ASbGncsqa6kS2/plNyXkWfXSW5BO4q9EglVfZbBjxFbWL60Deyn82spzE8R7XF5Qm12
	1TTEx1RwWqG6ESITHQNl0w6bgmwUhz8uryEnc5GeJcxzQeMwR639UaTLNKRs8X0yMJedqpGTy9F
	2ags0FPqaur/BJepDVitnB5+p99zdQrHdfwMnxUxvQe82WQehMOh9/UWTRVxLs0DIC2RGnnuD86
	m1XlNti2odZA/qdCZWD9dnlS+Pk4Swunl+p8cqzm43mCj3XfMQ5LjbO5UgCTk0TJT33Oysglkf3
	+j0dQSWacd+HWCsUKJE5+aClfSLJym7Iq3pIeKh0Ody9R+kej+hoshq75watQR+wI7A3SsKKDSM
	JotIwPb3y/Yl12xMakR40xrSU3U3Aqg==
X-Google-Smtp-Source: AGHT+IGNN9Z5/+uibhBqThaCgEQTDyJjDZ11Ocq8PmmFMqWdJekg1NPHuZJvr7YSISbg9lI0H3tDRg==
X-Received: by 2002:a05:600c:4fcd:b0:456:133f:a02d with SMTP id 5b1f17b1804b1-45b517cfe71mr35761285e9.17.1755875844711;
        Fri, 22 Aug 2025 08:17:24 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e877e3fsm38312615e9.2.2025.08.22.08.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 08:17:24 -0700 (PDT)
Message-ID: <93f182c7-572d-4cc6-92a3-3be48fbc3848@tuxon.dev>
Date: Fri, 22 Aug 2025 18:17:21 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] net: cadence: macb: Add support for Raspberry Pi
 RP1 ethernet controller
To: Stanimir Varbanov <svarbanov@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrea della Porta <andrea.porta@suse.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Andrew Lunn <andrew@lunn.ch>
References: <20250822093440.53941-1-svarbanov@suse.de>
 <20250822093440.53941-4-svarbanov@suse.de>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250822093440.53941-4-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22.08.2025 12:34, Stanimir Varbanov wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> The RP1 chip has the Cadence GEM block, but wants the tx_clock
> to always run at 125MHz, in the same way as sama7g5.
> Add the relevant configuration.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

