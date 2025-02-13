Return-Path: <netdev+bounces-165995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A183A33E19
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DDD8188D307
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7501211A0D;
	Thu, 13 Feb 2025 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVUlp8HE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C568A20D514
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446221; cv=none; b=GQ57bBWQT/XvSWJ312i8JbdjKu1ZjviW44qFCAf5NjTUMMzFz4Lyc9AeW7NPFBi6bmDL7N8uvTGkVSFo3lun1S0XL/0+zw6g2E+YsIcnX6w1U93p20mR9HhG2zw6Yx3r8mFeD3tJeidz+fe4itIIXmSYpUlbHtPtE232Uztkl+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446221; c=relaxed/simple;
	bh=7Z56Y83f+ojrrsd3GpgSgBFA2lIExVUESQWAv2+ulCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJl7ch2SsAEmipQ+Ck7qS07ltetZAPaYDEdhVQoVDxYL6OcCD1xWlRIAHPQo1B+NKyu4w0ZscR9acFjNrQIaE/ugzdFZwe0oeYmsZRY1XFoZyNgQxrWR7KwrV7UtmYKSDnBuidwGazgDSQ5XM2wJOWdU/Uvn69SZ6EXmVKqsW4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aVUlp8HE; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5450cf3ef63so761190e87.1
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 03:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739446218; x=1740051018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Z56Y83f+ojrrsd3GpgSgBFA2lIExVUESQWAv2+ulCQ=;
        b=aVUlp8HE3Mj7Yw7D+M2Ilr4HILAWlFgq0W3QEgCdurBYNiGOc/07AzttlQiYIeIO8d
         Ic71Tdj3Oz5HCo1v1Qj8syKHM6RoXfC5tRYaNXfBYJLnvUcPgf7xHn5dVV0KqqThBvVJ
         bVIPVR9ck/VY2Tgy6z1LtDBh395vM/i2OcF6e8ZGpLHX0wFvaKo1f/MkKnXPXEtzcROO
         Sskoh9CVyZCvJBCaCR5MfbL0dvOLw2ulPxWcRWTR6WwhQeLa7gIrl8zpan2jdmjrTLF6
         WdTqKjXNYFttme7LiFvF5AaFz52Ym0JulLwEJkFA55FnkGgaoxr1fxJEKXojdudKcm+s
         4urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739446218; x=1740051018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Z56Y83f+ojrrsd3GpgSgBFA2lIExVUESQWAv2+ulCQ=;
        b=AfMCg2JicAJfO5T7ql9xHiAu9q4TO67XjA1ibsWKP5/sVlhu9gmAMRf4EN4zhPxIEj
         qaS0dI3P6VxF/gNFImRaL37mcdCK7LCQui4ykT7QWUx8dhT6wuffxcppdE3VSK27Mojd
         cSnM3eMUeXP9WLsZI7ixvp4LWpXkgx3lqQD/pINKBXQDHhkGo6g6JDto8QDUGB5MszUM
         5iYj6uEDN8qyuEhYMEROkLU8WfWtStOLRicuTloEC6+nQ+VtRXPDllTxzbf3GRmhxwAg
         VT4Pjg3aVXJn7L6u4TKGeyLYBu2vI4stQSD0Spp0ZMIf+RpFq7tmf6/xtNMf4Rnjyi/m
         C4ow==
X-Forwarded-Encrypted: i=1; AJvYcCWyTyrGbQ/KSLp5LtqCgYckzf8Cmq9nQRj9rmp8X6wJFWPmvmMn1iwJCUFTeA8awLrnVzy016g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMofRd9GmciRVk/G2nIn+gKXmW4pVRyBdJumeNyBMOxDZtk8eb
	ZtdVM4ME2LVsN1VANBFJuHkFKwAUuMb/wZl4vpfeSeVlKb/jxNUMT2mnmn2Beo40d005VL3cr1I
	WBCQwKH19QGx2FMdsT8KGvdCcXP0RPySLy5Gb1A==
X-Gm-Gg: ASbGnctVIiKWXusRF6jbZ5wPUnkGBkNaW4Y90HWNzoRFaAvZ0mWh63uXTCTCS9iklcJ
	KPxwKJODBCcZELZV93YAd2D3Z0PVmHg5l2eW/XjEbgFZ8t2Jmm8KIxl8OLsqltvU/dvzOcJ0c
X-Google-Smtp-Source: AGHT+IGtr+B7QUg7ovhczdnIrY54CJufjoazE+Gk4x6uF30Uby+ckGzBKyKIc+SyfPUrY3/AAaJl/Zu1tehVGQNXynI=
X-Received: by 2002:a05:6512:3447:b0:545:b40:6566 with SMTP id
 2adb3069b0e04-5451ddeb857mr591146e87.53.1739446217812; Thu, 13 Feb 2025
 03:30:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203144422.269948-1-ninad@linux.ibm.com> <20250203144422.269948-3-ninad@linux.ibm.com>
In-Reply-To: <20250203144422.269948-3-ninad@linux.ibm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 13 Feb 2025 12:30:06 +0100
X-Gm-Features: AWEUYZklvT3HDVtZsVqTrXdrtQL7QNdhFrM_NmeZwuKBhmtHfAH-J4BH0prCplk
Message-ID: <CACRpkdZW9aNbrQk-zz4G0_W-HXrxgpWi_QzuLvActcWkh+U4Tw@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] dt-bindings: gpio: ast2400-gpio: Add hogs parsing
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: brgl@bgdev.pl, minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, devicetree@vger.kernel.org, 
	eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 3:44=E2=80=AFPM Ninad Palsule <ninad@linux.ibm.com> =
wrote:

> Allow parsing GPIO controller children nodes with GPIO hogs.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

