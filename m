Return-Path: <netdev+bounces-163246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E26E6A29B21
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 21:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5523A8965
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B379E20CCF4;
	Wed,  5 Feb 2025 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="TFJY8Pnh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67651FFC61
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738787175; cv=none; b=AuGDo+x9qHdZ3pIC0ZLCnrJuroFOS+O3iw3a3X1/pA5YvkvaNI0XK7xMKTxbz+OKOXLagvQiMMp+MEbcRa2BPtrudPARp3IlIfuuimrKDwZo0eVcAX4RDckLEYCyHVwRU/+JmtIE1W2ZFZlh+jtgQfBfpFHPLWIrpyaDb3diXQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738787175; c=relaxed/simple;
	bh=hWcjkVvv6KY7K+i5MOmOpjaDm9yKh5mFFQCnW/jf3uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+bjb14+PIzKs9/JZ2A7wFNB4s46r00BVeeTKzqs+FVp9EDmyvdRFcp/gkEc6EB1lUaP5f1xcR+uIQ5B4xFw0P2zubDnFKkI+e6SeEQg/p524w3R5P0jY3TlnH4RxCVAri7eD2vQ1aZe3UZNq2PFhsubkvA+svZ4xIT5C3Kij0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=TFJY8Pnh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso42351066b.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 12:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1738787172; x=1739391972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hWcjkVvv6KY7K+i5MOmOpjaDm9yKh5mFFQCnW/jf3uI=;
        b=TFJY8PnhtYQY/EbyFjVANJJjS9ShjElv9GBzaKut/LDmIOePLfb2L+elGjot2Nxwyt
         grfA2+4KJcbHLossN3dUgdIdE6ODsVo99t3TWUStjAKGl+kXLjPlnZtEvMUSnWmF4hAJ
         xFm+lfRb3ZAw9OwMtVEOHE7vJa1BcmlnmqWsS9fPM2Vn1kPdfy8F6XbvnYtO8Qt+4/3L
         My9SV359eVsMwcNPd8ESPEolaPpyTf9+HzsNZ/zXOGUMLGw4nGHGquwtSMUmf4+NlrbW
         7NQlwDePw9ldumYLLAvzj3c3H5fyuV0u2YQX5zMV1jBlDHLA0rErOD+BLpvCfo7wF15n
         7EHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738787172; x=1739391972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWcjkVvv6KY7K+i5MOmOpjaDm9yKh5mFFQCnW/jf3uI=;
        b=ViEZkEcfjXpdJ5IXJ75bZkzPhya+D8XtKrAGzYOd2LFbP05N/acD3HBAyv/iawq1Id
         /oqEVRsOsmgsCELIjZN+Ka3FUzGHnUVSyU1dYJDnZQykXREv8IDsrqEeJEvaGSjo3AuK
         SAjOEeG02W5ET6J9tO8Azzf2pK7DnKvzLLM6mIJOekHgb5g6l3rO7IoipZSw48nL8225
         nIAW+TwOHUe4CoabiZjfkQzwlNBnHo+DEv0SXkQ8y/YTpL1aXGBfzsENtK2nBTolUBaP
         dV6JMIWjQNRwU3uNgkAS1VHpo6+6/Tya0GEyi2g8O+7C+ZbUn0TNmdQLq/qCzxqh1FvG
         gaAA==
X-Forwarded-Encrypted: i=1; AJvYcCUZfno/cXsBvbUdHqf/5m/kTbyHktr8U0D5Hhm/WHU9iCl6BR/Z/PaiC3ftpuWzNzfGCzrIxoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVvczvPeE9yAVE6lffljMkYOk5qI+arhsY/exGkSKc0AqZSdJi
	wTsomOmOD1SL5V8lY4eNQtkCLxpbE/0+HQ249gfFGti1OR8gHtbiXwzrB3Fr/D4=
X-Gm-Gg: ASbGncuDPtqVA4fAmJqDs5C6agEiXkuiWVPVKpnGjdM/hjpjtxD2f9EdkF6gouvkm5O
	PoXnsbB8IWBohgJNtrKNpnRFbPXNIGCl3zWAFxzvMXDcNdoFK5rYPjJPQMiB3aBybI4m7LUEbJz
	ZN8SW1gbqVav4Xp5nyj6r02TnlxvZdXbgB+1quqmJ+jm+8NsP623nnjCVNfjRyD9FPShOp4MdHN
	IYp1G6OrS66wbsTCKCdAAsVR9Mejmv/4cqFwk7yrUV8mO1vDvr1nGfe4Y6/3ukOOT7rLBeoyr2G
	TZsoLPobMYQzh8Y/j4G6QrMsed+49tMzz3p6EbCtxA==
X-Google-Smtp-Source: AGHT+IFaywZdRalBVpVVP5TmbF1T5HAAaPMMuKHq8rwyEDyE+qrnaJZq8qLnDjIR22e45iPw8kWcCg==
X-Received: by 2002:a17:907:d8b:b0:aa6:b63a:4521 with SMTP id a640c23a62f3a-ab75e23a4ebmr414280166b.15.1738787171974;
        Wed, 05 Feb 2025 12:26:11 -0800 (PST)
Received: from ?IPV6:2a02:810a:b83:a100::2e88? ([2a02:810a:b83:a100::2e88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab70e4e3b5esm818932366b.138.2025.02.05.12.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 12:26:11 -0800 (PST)
Message-ID: <93856925-b451-408c-8dee-bfd8dc2d56b3@cogentembedded.com>
Date: Wed, 5 Feb 2025 21:26:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: renesas: rswitch: cleanup max_speed setting
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>
References: <20250203170941.2491964-1-nikita.yoush@cogentembedded.com>
 <18a72981-9896-4725-8f5b-5783224de300@lunn.ch>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <18a72981-9896-4725-8f5b-5783224de300@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> If the interface mode is 5GBASER why set the speed to SPEED_2500?
> Also, USXGMII allows up to 10G. So this all looks a bit odd.

2500 is hardware limit (or at least the datasheet states so).

Nikita

