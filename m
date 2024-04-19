Return-Path: <netdev+bounces-89693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 725878AB370
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 18:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9525B1C2237C
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 16:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FA013248F;
	Fri, 19 Apr 2024 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GDuXsERA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6FD132478
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544595; cv=none; b=VXxtbc4tUamLxwjeTrRhmit5Mf5/w8Dg9kVcY3Jw+4UcSeGMQSx9QeVaoE2AbHxbWJ13SkVI9WE0F6k2XN+urfKEYDFxv9BmIlRhUs+kxy5shaK540KVo7kY1h2P6ydh1dqi94pFZArPint1RTQiR8xnvPPgjjQBfEUJkQK3xaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544595; c=relaxed/simple;
	bh=VJqWL28kx8On3nuV8espYdeI3/7H9SWapLP1/qFwGlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqUwmUcd5HDVxW0LWWbZzkVVUm232PRSStxnT8fv5iqbLy3Dy4wmtyYXeA/i6pSaCbPVUTVG8ks9uW0xJt8eHSYvH/RzaHM3q9YblEB55VtG7A+PCFg3wjvQx0iZzEzapjwxJzhnx4i6eoX2pno/4bEJ7F8isyrRwHpMHiwqvpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GDuXsERA; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed32341906so2279494b3a.1
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 09:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713544593; x=1714149393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nKU8IrsvXVH6vCCN8x56ibxhIaYffY3bOXpskGLRQtY=;
        b=GDuXsERAePt2z0oGOlg0fqeAolGLJeHb5FCycRiXtQ/tvLo0aEKmb6cCV+0SNclA0i
         dW28Ns4zL5veXerqREMwzgTiLxDUVUDeEkF7q5raV+ZygoQYduwk4m44P6Ri/7nW2Yb3
         +QNAPHFPmh3PppBs/nxq9yf9MkNsIFNekq4XZY+cl7ZCO+FgHDzCGcgcOLDdb2UdRGMA
         OzSUGFXi9Oq5CluV6l8KhlRWwC7CPHnWNy/SJ0jIvV9dp2kany4PHuT7PzJgKsAD+l9H
         kQO50c+WIFnxY+TZHNaUA22uZquaG+LcAbCCt3nWrjPQptRrOdiXxbJDnfCV7yhlw+PN
         A09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713544593; x=1714149393;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKU8IrsvXVH6vCCN8x56ibxhIaYffY3bOXpskGLRQtY=;
        b=LU3FpnZZ03cFNDcWhLD9sBecpQ5BPQWWzAsAObfql5EeyYEHNMCXDayg0DEz5p6Pn0
         rEn7K9F/x0iwVS3N5kBOpPzimM3rYQTLAFR2QKVnOxlbuIWXh7PvbSxRuvOQj79wKxLe
         ieBZ2ojRMHKvGuX/AVT3P3j7kjAp6psDJYUH+cJTmM6UJOn2i5xbXw6PxuL+OJ2E9QMd
         Skp/oPC8aLL0AFNJ2PCYcFGMe6eexhtTOe2kNv04XPjoBmi0DsJQmkgh8LZMKp1NFJJm
         kcFn92z7GU/t++bOiW9GzuTcct0Z78ywZyX2sZEIEEbxqfGcEjK5fGssVGdzpsFnqMOT
         tOSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRK0U5Z5LV2xHUhV6POFuqpPaKjcG+TsUH9dxVMxawWl0ejNGtoKpVyHoaCsq6TUtLjc8rf4F7T4SEsl+mWIycTE7JP9x8
X-Gm-Message-State: AOJu0YxedpracAcMTmtcGL+tORupusjScMEX5BPT5YXweD1+kbzT7C9u
	ux/Yxx8HmwEY2TcqxfAjEHQCt9dRkALxLpUfCtciJwiE1XqrsrSiLOsu8KnfuuY=
X-Google-Smtp-Source: AGHT+IHcfbk2RThWHuPEMLnqz0LDobacqviydOp7ymiCFW0Jc7NhokVPbQQDyv1afQA8obc3s0RZ8Q==
X-Received: by 2002:a05:6a20:2585:b0:1aa:5983:45e5 with SMTP id k5-20020a056a20258500b001aa598345e5mr3540637pzd.37.1713544593081;
        Fri, 19 Apr 2024 09:36:33 -0700 (PDT)
Received: from [172.20.9.36] ([209.37.221.130])
        by smtp.gmail.com with ESMTPSA id v22-20020aa78516000000b006f03a06314esm3427918pfn.195.2024.04.19.09.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 09:36:32 -0700 (PDT)
Message-ID: <78eb30a6-ef27-4ad1-93c1-2ebba77088cd@linaro.org>
Date: Fri, 19 Apr 2024 18:36:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] dt-binding: can: mcp251xfd: add gpio-controller
 property
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Thomas Kopp <thomas.kopp@microchip.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux@ew.tq-group.com, alexander.stein@ew.tq-group.com
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
 <20240417-mcp251xfd-gpio-feature-v1-4-bc0c61fd0c80@ew.tq-group.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240417-mcp251xfd-gpio-feature-v1-4-bc0c61fd0c80@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2024 15:43, Gregor Herburger wrote:
> The mcp251xfd has two pins that can be used as gpio. Add gpio-controller
> property to binding description.
> 

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

Also, please test the patch.

Best regards,
Krzysztof


