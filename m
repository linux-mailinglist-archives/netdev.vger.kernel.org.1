Return-Path: <netdev+bounces-175889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33310A67DC2
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 21:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1E319C6CC3
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C04F1F3BBF;
	Tue, 18 Mar 2025 20:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/gDKbwG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EA51DDC30;
	Tue, 18 Mar 2025 20:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328525; cv=none; b=NH1OMDY1FA2DERSsper4fpOWjBcNEaA2tSKAI0wOpHKpDH2E1rbVeAJx7jpveTvVizd3i7K8jmD419qr8nz9cSZ7zwXV0Mfxp9jtVleG0sMuNsPQPYD3VNNsA9hW/OYaWox0jXeDtnPLrVaykekj/Umi81fb1CWMC5A3LxiP1TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328525; c=relaxed/simple;
	bh=dmKl5xfiG2GUMqlc8M0UtpkszSZqlx2pHbQuVOldTGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aqji5yE03keWKXoJgnDKCJPREvoM4wy8PPwElXmK98bdSQZWI89jYXStAXlTvM23kAAT3nAL2MuW6f3476HA7bJza5zEV0rAZNIswSUjn8nVtjr6Zy+yFana3Ji9xBBvgtFitKooHKCus/bTy8pFDzuM83FdCGeeSVLb1HtU3cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/gDKbwG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf680d351so185885e9.0;
        Tue, 18 Mar 2025 13:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742328521; x=1742933321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jAh0V16NCsAzLgy0Za/fPBaB/+/Y2QI7QJxj+d2mfpw=;
        b=W/gDKbwGJ7oJalx2Mzfaqnw4vITfz+EQHQ2PYADIsVrXWAUvE13jziLShLfuvyNzOM
         uPXb1YjONJS+VGHJf1FOIOKePESWtM3oFbKeoKo0BDMsaNfI41+vnAaSwZ4s/MpcGnoM
         OHq9+3vOOAOdrkUSS04ZBWsOZO3Isw3btIbSYiXJxeYMMXlb8JFeWwApU26mxCXvf+j7
         3YIggmI/vr8h6BYoZ4hRSC6eNbcm2p5KNr8e0SFRQCIgNhwTZsNTx93W5mnAO8cqLKpF
         X4fuawMoOZD39NUS+jqD4ZF9JiJNCiPn7mk7Qo4RxUaYK5haLOlNM/VImnkuw0BJwgut
         Ognw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742328521; x=1742933321;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAh0V16NCsAzLgy0Za/fPBaB/+/Y2QI7QJxj+d2mfpw=;
        b=OmyIi88heXf9eD1xLNKC6wpYbHJdyOvoH9vY7F/YtvE9mzdkQoTTuQ02MyfJzSTEPf
         J7ZmfPM0wv3LaSV0WGBZ9tdHgXSahUhD681PH46MKaQl+WXs4jLebi+NlIql7hj117k6
         zfksBAVPpTwgOmk6gcr1m1X1+6ZoO9OYWC2fMiLalGYn+1xdu5kHTDHTp3EPfqGuhMUQ
         +XrwHV9SY5hxt3mGtrMTp8mrKW/a29MdTdTM/POzrqCqwmEqFbCrI0iyd+lermwYDDZb
         Mt+Bp/3y112k/xvUoE9SL2jLYFX3SZUehD1913db4yV6s/Oku6bYWjgbFeji2TG0dlV5
         SMWg==
X-Forwarded-Encrypted: i=1; AJvYcCWpn4cN6+MoHDtpji2ZwMfP3VNk7XFKkvLKc60CLIqNo9x3apDrpdc+4exO4RRWSBE3DcthmR64m30TVtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJk35SV1m08WxfIdyzQBRqn8uZpeCPjt8iGo5J2i7aQvX7GGm9
	+/3iCwFtncGvkc/OyAB5APqCkyKjFqXjJfaMCwEgxEHyfkPMDSQ9
X-Gm-Gg: ASbGnct93QZR9UbUxrnM4l31/96PrYJYw1a14VtR9SmDCvXBzReXaN/UcnZPfsP7PqG
	Iyhx22viSPmgxRMClee/Cxa5Jdip2LPbj4zvEoDVec2iqr6aAMjjN5O4UmlYk1Pjg6t3t9iYiNQ
	OjwFz76DT+BO/lx1+QavRvrQw3C6wOJhnhsW0ZEu3WTMKhvwamwhTQUweHcEKBOK5PmsN7pUrEq
	k/TNhOXABNYTPDM9dcmgsgqhBNiE+8Vhfjeqn6pvJ3dELq724TYF9MP+OJGZVczvCDQ1Pu4wNyd
	RjuoRyw14AynuwOBenB8LP7OytJ4D7GbBkIwhiWslGMWom0w0bKzzzbGhg86xbAHIsKDKaN8TBp
	8xNbq0t0VU1JZOa96I5Z/UGrWQDNGWMfWBILUUOexn0bOmp/pfx/0SIf8wZHKJTrL5tckmorwMS
	7HMxOZUMP1JzUWxtAevLF2rSsaTYOM6u/+wEgc
X-Google-Smtp-Source: AGHT+IE4Rmx7fyRVeP431hktxNcpBnLplXp6T172jhYp9C/MXpAYPrQFbgaa4fZGCi3D9PbdFApZWw==
X-Received: by 2002:a5d:64e7:0:b0:390:f0ff:2c10 with SMTP id ffacd0b85a97d-3996bb774d9mr4277819f8f.19.1742328520885;
        Tue, 18 Mar 2025 13:08:40 -0700 (PDT)
Received: from ?IPV6:2a02:3100:affc:8100:fd3c:7c71:106a:a90e? (dynamic-2a02-3100-affc-8100-fd3c-7c71-106a-a90e.310.pool.telefonica.de. [2a02:3100:affc:8100:fd3c:7c71:106a:a90e])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-395cb318a3dsm19162926f8f.74.2025.03.18.13.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 13:08:40 -0700 (PDT)
Message-ID: <62a4084e-db7a-4cbf-a5fd-5be354eaf0ef@gmail.com>
Date: Tue, 18 Mar 2025 21:08:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] r8169: disable RTL8126 ZRX-DC timeout
To: ChunHao Lin <hau@realtek.com>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250318083721.4127-1-hau@realtek.com>
 <20250318083721.4127-3-hau@realtek.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250318083721.4127-3-hau@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.03.2025 09:37, ChunHao Lin wrote:
> Disable it due to it dose not meet ZRX-DC specification. If it is enabled,
> device will exit L1 substate every 100ms. Disable it for saving more power
> in L1 substate.
> 
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 27 +++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

