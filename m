Return-Path: <netdev+bounces-248826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A65E2D0F2FE
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 15:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A700303ACE5
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 14:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847AB34AAFC;
	Sun, 11 Jan 2026 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZFz5/xt1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B566134A3BC
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142768; cv=none; b=oX6rd7k6VToa4WFoXwaGV7tp88SYjSzD+bas8uujvP2QQ2/9sSUxO7IqNvooFK78hMoizB91HAnFycJeuTc6RWz0hEI30O2Zc/E//r2U2d/JbFPUMDw5dn0eWamHK8jCQqLldRwOykRRDLDMSbTPph9MYVKwFitRhGHB3bdUY80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142768; c=relaxed/simple;
	bh=E3fIUBLPFnEXAfwoSTB7dOLky4Cj+/epBMllkCL2GpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4ipeaNDt54g6LxAMFHhXYXvDEhHUwWUKbm6XAQk9K8d9bIOYtMw4BmW6ppotHXkUczSFncl6qa+jHh0IyUsl0TxmhRDbPFEGSoXTPl+98TgpOqLA2OnfIGYWVXRWGb6hnh8Q5FybhEo3MPC3NIDvJj7eyUlDChQYekxzu12l/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZFz5/xt1; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6505d3adc3aso8880140a12.1
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 06:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142765; x=1768747565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSh5A9C/ikcooPDg3GNmd0+fIcS/l8zoJ1QKaA55bnM=;
        b=ZFz5/xt1R3RPg0IfhqILS6DeIcAi+Q7dknvvl7zujx9QVOvzKxPv6PbFWkA+xsWdwy
         q4RvbDBtR/HjlASIiVjVE8AqQ+cFMmSpSmHz/9zLrH9twpLhuoDOp2ifbX2+2rz35r8W
         EZggkt2Z25Ce3wkYydKW1eTb6s6zNkVGI4+qfKwk56y0v5hgCqKDZMbRcQU8iiV6WcXD
         bNlH8BXPaurlSjuMuJ8jWyp7GKnMkFz+dHJmqtCjFfpct6Tch/J1+bYJfTm+imAjQNT4
         bYlIO26xS8CbA20ia+8l9ila1DeJP0BiFxQQHuZUchuSBxxfuj1eBGaY4zansROWmVws
         ybLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142765; x=1768747565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSh5A9C/ikcooPDg3GNmd0+fIcS/l8zoJ1QKaA55bnM=;
        b=ajLXNM27mWPJrwcr6oWa1CHoCZoyCSnDhKvwIvRd3GwrooPLvgCAAmvujDfjhoU99M
         ISVhnYrUYhMLFvA8kLIN5FO35lJ7XjQJ8wxrcg3aXVCfUEb8P62IDA0BzzSkHgxzrLWL
         8ksB4nc76tbB5WiT3ragOnTH+rB4MshZbuG8r7RJN3K30p2sJ4AMLicjAbmQvv/0Q5kR
         JoJNTGSh3cRV7ZN3GGvd+scxryyPdaDEKyYm0WVMnJ+2Pjb/ceg3WPfecfWBthC2Ydmb
         u6ctTUtUF4sylgwoO4/orzMt+XEsxgYX7+1jGIGAC+pUkYAoK9IEsBAv+OiJ588DwtTo
         fRMw==
X-Forwarded-Encrypted: i=1; AJvYcCUTAlgfAImrlfcoGk2wyfE9nQNhHAm9XD4JUa6Wuv1q3tMH9o+fwug7zzUWKrvHNmKbtdb1r3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYGJsf85fOBFTEGYDK0S8utywePZwIRXHFg8Mxc0Iqz6D03EWQ
	SdlYcjrnc5yhADLKjzqz5j1mjSioLFi2zwrf2u6t1+Tham8PMoOXfP5ZAE0Ir9DDbrg=
X-Gm-Gg: AY/fxX6Dl6003f8dZ4+ujuSfQY+IEM2N78OkqwqWsBvxQe5DMY7LVkM0MyCtLtzdB/O
	zSy7aUxKXCIkVVPMUS0HmaEgOBy0f1xcTD5TCz06vLJPKPUy/6wH/oI8T9nH4aGRKGgE6sPjrpD
	90jNBWvTs3uGkFU4RzRbQRvLJNE0TqJxa+MDYHZwvij9+ty8JMGx2wWMY6Hktvrv4mwVZTzQhID
	6pRI7irIm78Y4z7/dv83uIgfsw1c0EON8Ku37NqjFsYPtcMio7zq+1wy9bS5PTIq2C2mv4desi+
	b06X7yn/uSS7VfSvVaC6QznIr65HNk+Fo87kt+O4nhaKXJdSgrERYZntzNaVczq+b1XrRNUX5oz
	l9kS3fXjws3z9xVcsyvf/53H62KWYb3XVwTRDM0f/vloamXE3TzreYlxPtP2V3bxB8nP3ATFX5o
	q4kds2sAiLbjpphiFRCzz5pBY=
X-Google-Smtp-Source: AGHT+IHdSgN1j5CfCwzzuZuuUE6k4oOsy7A6FyHYN7fpU3s7QMByt1Yrcz5j8phSUL1uwYAKt/FfvA==
X-Received: by 2002:a17:907:3c8a:b0:b87:1b2b:32fc with SMTP id a640c23a62f3a-b871b2b3d67mr52172166b.0.1768142765029;
        Sun, 11 Jan 2026 06:46:05 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870b0dba4esm216046666b.17.2026.01.11.06.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:46:04 -0800 (PST)
Message-ID: <dd70bce6-77c5-4d73-96ae-6a0bd8ab7b22@tuxon.dev>
Date: Sun, 11 Jan 2026 16:46:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/15] dt-bindings: pinctrl: pinctrl-microchip-sgpio:
 add LAN969x
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
Cc: luka.perkov@sartura.hr, Conor Dooley <conor.dooley@microchip.com>
References: <20251229184004.571837-1-robert.marko@sartura.hr>
 <20251229184004.571837-12-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-12-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document LAN969x compatibles for SGPIO.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

