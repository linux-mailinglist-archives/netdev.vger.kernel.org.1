Return-Path: <netdev+bounces-248827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 908CCD0F340
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 15:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BFE63016A94
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1577634A3C1;
	Sun, 11 Jan 2026 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Qam1s0sk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2CD346AF9
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142805; cv=none; b=f+TIIi/5UkUd0fmdV+y7CGz95IuzZqvkXwwh+RldqZZHQ3q6MFy6Dx96s4EE3hXI57n7dWHym8HaiFPfWpiDxvyMht36xkbpq5zj17IcfGSxZz06qbkJznCnA8wIVIMlu2vEfhgjLcmTjlLSlEYlRD2L6bDOov9o6zNV9CfiUQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142805; c=relaxed/simple;
	bh=L2SAqNmu61MHKLD0agICr57xkRB0iGTI91g9rMmmRgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBC7CXV2rFPHcVAHGFpXcCd0HccnwtxDC+S6RElbLApCYnxNoDAYEwjYdj2zPeHPkozBwAHz2O8QEAi0+G5mMVAq8Yb1a+IWjKMVn3CiiTgfZvhT8SkM+bNSMo1oqGIO/nTE9VXhu9MifRf/f/RBcGa7A0BUunU5W6GAz/hKGf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Qam1s0sk; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-64d02c01865so9507812a12.1
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 06:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142800; x=1768747600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=998LIQD26tTlqKe1Nt9hPTV8z5SAR5Xb1tsWRfDj7yM=;
        b=Qam1s0skrMJn1KfWZxSe96IKP81h22WhBDibkbxgWIUwpBSQNSN536T77TtojW3nxq
         kLFoyDPha3E1j8A98VyQxWws3pi3XVHEjYrLvuh2AjL/vNPcDkas+WMRnHVItePkIK5p
         yjOS8EtefDgl07rBXwJ/tP65Y/Vw1sE6EhWNK6+VRchLP7n6emPQxYYi/5H9xtlL6/P/
         ns7a6XFDQO9GAFW8hheFyqWsQk6Nsce0VyXmYi3J35Jk+Y3cTtzFIsWLZLPcx+gnyCUs
         9g1Vv5mta+IVdq3zoLjpJHhxhqt9cTIhUzchJVlA7JHMdhTyomaoN/CV+gPsigwenQok
         wOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142800; x=1768747600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=998LIQD26tTlqKe1Nt9hPTV8z5SAR5Xb1tsWRfDj7yM=;
        b=qFdTmxhiFUfxlr6bWP5TwMpW+vB5Y+eCGAMaucgWsIK/vInlhuPJUBNkujVQG+iM1X
         IdYtfZX1KP9OdGDaAcltWvvA6HMYO3y1RzHwFIlcgr4ztKDtmU7MjccoVZ1Q5X4u6VQA
         KWqoIcYnopCnS2Aro+7N9T/Ufy7XSyIsIj4n6s9tXaIlbzlopKyKoUOV7zdK6mhhulKW
         TuglfjIklapUlj2AdTEltWR29ExuAtThYG1I8I/m6zA/cdMJBbJmRUlliJSgMtyYCqJo
         WoZGm/mGtUSU9OEsqNo/Alu/dX0NnDwwfFAKTZ3k5S0/9GDCT4/OruvfqlDl9KFq+8NM
         ptXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHISXVNVPSXcnJpuMIdGWEFe3z10dXNXXNRf2t62kxcifgdZKWNSyRsESPnzVo0meiNrIOoIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnKVPpb6UACKQLZla5sfOf2BoqJeG8ol8MqARmBJUPMl6VCu/1
	aZpGDtoV6LCBUuVDUAgC43/SGNiqHhDxuL7yJTF1tXwggPPIzYZb1c9YckCs0/XmiNE=
X-Gm-Gg: AY/fxX5HzSON5n3Ipkh0FNkCLbSmXsBils+pwcov/59waQUyWQk1MWrfhnjam6zaZWE
	QMfy2GR8M0jBJhvGVCRy7QfWzxejKVdQO0syIXYRa4YYgkiytS0xxGvHhRYw3/z3YW7Dp5I+2S6
	oh9XaK0byJPftlV8TxcgTWKWrswABTGBKqrF6FpOlq48RH3VI0xye7wbnuRcEFMCWT/+eCnJJJ7
	MaJChOM2wVYUQPkMPVS+hKHmM0wSfHByVDcmokP7PiqqwXLFAzCzwfQcKGImUc9Cc94nA6wQGA1
	FrRk8zO+CCbZZO7QBhLFJ5emYxbQjwjdk1ronN+AdVqqBHOcD1ixf9PNrUgMt+T5R9LfJfh0IVq
	N4wiGhIWXjf4s25NocF8j1VHW/IN56prC+vPLtlFTUg0w75qr69P1Yb7SPM7WHME09/YYmFoQSf
	6qKY7xavJtbzIYfofTSqGrg10=
X-Google-Smtp-Source: AGHT+IEEnxtsLJjgQBqtCtTKdKKJ7nKe93tErDCONdjzSpalyD4Cf1jf8cogFFk+Jwao/l06OHgHEQ==
X-Received: by 2002:a05:6402:26cc:b0:64d:498b:aeff with SMTP id 4fb4d7f45d1cf-65097e8e49bmr13880469a12.34.1768142800347;
        Sun, 11 Jan 2026 06:46:40 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d4acsm15318996a12.30.2026.01.11.06.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:46:39 -0800 (PST)
Message-ID: <0ca4477e-cfd8-439f-946f-9d0205b62c6a@tuxon.dev>
Date: Sun, 11 Jan 2026 16:46:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/15] dt-bindings: arm: AT91: document EV23X71A board
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, vkoul@kernel.org, andi.shyti@kernel.org,
 lee@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linusw@kernel.org, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 olivia@selenic.com, radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.org,
 lars.povlsen@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr
References: <20251229184004.571837-1-robert.marko@sartura.hr>
 <20251229184004.571837-15-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-15-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Microchip EV23X71A board is an LAN9696 based evaluation board.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

