Return-Path: <netdev+bounces-113155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E9993CEF4
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 09:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780DD1F213B3
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 07:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1AC176AC3;
	Fri, 26 Jul 2024 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oP/tMKiP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A33176255
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721979726; cv=none; b=qOKs9UdmNLrgcpsJHjFtxIXTAEGY2YgvE2CMCFWtRJ+pruI9eTuzWqmnV11pl0ks21xYUr1o9PP0eS9GlPPRwqboLvUH/0Pe4EnG4uKKzGBblUemNw3nRO6bCvHrpCDyLhdwmEmgEoMOCCTF6vRgYT0P9bWHR0BtpOjdQFOLf8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721979726; c=relaxed/simple;
	bh=nHMnC/oHV63qHSPSA2oxdTfUb5muYGwzRVbmDjEX76g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cReDmmRfedD8+RLWFkTTaJzPOHqqnq404cE61MUtwtyQrqBvH3GivVTFMGngW1aC74w64482BrEIdYM7cMMcjK/XrbfmaWbTU1d1CdT9qSrZ41DtZRossb21C3P9eqajn5jGa63TTF5ADQIGCP5hwF3UaP3KdwSJvalPUBOIczY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oP/tMKiP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso11380a12.0
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 00:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721979723; x=1722584523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHMnC/oHV63qHSPSA2oxdTfUb5muYGwzRVbmDjEX76g=;
        b=oP/tMKiP+ms29U7KfcEQ67OVEJUq+o7PNNaXTxMI/u7b40qwpTrm71DbsXQAjObxsl
         p6eoIs/I5048R5wuQPTEHeHbRWUrwA/OxCD+FfTrxZ9PjH0eSHatKDqaFxWPxteBu+b6
         SEmJMidlTO/toSz5Jkq5znsBmcb8mFufpmSzIch2ouIaz/6hYSiy7tmtB4ihKHq2q0N3
         /y+Nf+jAO/VQ7B7pI2gAVPgu3dlEFqqJOGsXkhnB64K3jxnqIJqBzx/Iui2z55Mnah6y
         /u2lzUa1XbVGo4iEYG1Y76drWBAIojksWmTu1qr3TnrbwX5JJYAuGebPcp/o33tlAqYq
         xopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721979723; x=1722584523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHMnC/oHV63qHSPSA2oxdTfUb5muYGwzRVbmDjEX76g=;
        b=tJz852d7rsvwsvBEF1SGHZUYpYF7ABBx6AcufYCTgAcLvHpJAQtRXA/w/ASEFUXhzv
         A5smPDk4vth42fxbuhgmFYWh8+UP6krXRGx8pLEgHVqcDXYhj6QFkxIvwsxYtXovav4G
         Dl1E3kwLkq5RNrAcV/xmlFB4WXc9yfaS0ybtfJqSmv0akciDWhBtmTraiw/exaxImrmp
         sOAblTetp4JcWYqTpli0srTEb3ez9uOzwLFqMqxr4Fsf3Oujf+gGaTZYghtZV79qA/9l
         q2bNXqP5UrS6oYhAHXTKCcbHnR+GUgbcsh2dxEFTFMF9V1neQSAo8l44g67h8MwW6w68
         iq5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUswXCxG+9mUJHl0wsAPn6Yopc0Bo4PUGcQdh5A4A2+XwImksp2WbTiXE0Dq/FO6YGaEU2K4IYQcHs3UJr1kROJIMszqpGd
X-Gm-Message-State: AOJu0YzqfDssuizFnarsysQrAchs5eD6qrC7xPm6BExOzI3QGiGoklc2
	0NBZl425z02a6Ju/IZNtlQOqeBvMBgrRsN0IrakFNgOj0t4LezNCtQQ6QZAYo7x2UwWDl3KsfIb
	t/WPwf4leO9QG0rNESktbJxn2SXsuuo3Am3F0
X-Google-Smtp-Source: AGHT+IGoQPZ0QMYNcCXbjqU30bTUmaZKQuSy39n0+FyRHD/OPmhVjFhf738bAp11QMIAWJNjtK8t0GWRD2CzbyWLWN0=
X-Received: by 2002:a05:6402:35c3:b0:5a0:d4ce:59a6 with SMTP id
 4fb4d7f45d1cf-5aed72f8708mr123178a12.2.1721979720698; Fri, 26 Jul 2024
 00:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726-dev-andyc-net-fixes-v1-1-15a98b79afb4@sifive.com>
In-Reply-To: <20240726-dev-andyc-net-fixes-v1-1-15a98b79afb4@sifive.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Jul 2024 09:41:47 +0200
Message-ID: <CANn89iKNACSRA05bUM7xVc2vXAjh0jk6P7+b3TFM99mMW9CmFw@mail.gmail.com>
Subject: Re: [PATCH] net: axienet: start napi before enabling Rx/Tx
To: Andy Chiu <andy.chiu@sifive.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, 
	Robert Hancock <robert.hancock@calian.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 9:06=E2=80=AFAM Andy Chiu <andy.chiu@sifive.com> wr=
ote:
>
> softirq may get lost if an Rx interrupt comes before we call
> napi_enable. Move napi_enable in front of axienet_setoptions(), which
> turns on the device, to address the issue.
>
> Link: https://lists.gnu.org/archive/html/qemu-devel/2024-07/msg06160.html
> Fixes: cc37610caaf8 ("net: axienet: implement NAPI and GRO receive")
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>

SGTM, although the axienet_setoptions name is a bit confusing...

Reviewed-by: Eric Dumazet <edumazet@google.com>

