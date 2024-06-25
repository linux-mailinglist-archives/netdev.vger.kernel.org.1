Return-Path: <netdev+bounces-106555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB6C916CE6
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5BD71F27AD5
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB2717082E;
	Tue, 25 Jun 2024 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QQ2kr0y2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDE016DEA4
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328737; cv=none; b=SiaygtJ0CQpBkeK8cvTnA4Pp6NBKWCpjHULX6tuDDQi1EzOJETdjJsUVBNlffIBYOLh3L8zG4K91K0CeL4rGZ07UpgSVdui4oi6dlalRvSs9XmXA8mplkTwBjnv42QVQ5lGHYPkA33vAhntu8WLMQsQxBWFpPzh5HlMZrjnaK6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328737; c=relaxed/simple;
	bh=mZj8HmgKq4m3YHtNZd94nsGMAQh/YBBmlu+PxcHslvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fD9zkcJeOYkAuWstB1BgmlWZ00bcZcLgPE1UDpWL872EM7u1XXB30t9iq/gQEqC/AsO1qLdyKoR9a2e7XwAAy6Adg2ai0YNitSjcxEAN+QkE8qqJ0Z1GBDMa3OIjnueMJbamRdcBgndaAKTw+QU828lVN/RRMuTF4P6zSkfbR3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QQ2kr0y2; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so61781201fa.3
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 08:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719328734; x=1719933534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sx2HYLsaSgIFg2Oa96eeaBmlhRTVUGHBB/hKxCjYNQo=;
        b=QQ2kr0y2cbrgNAeQ2Bj/fNDMO7tt1JPbzbHFf++6QslpTNXii1Gqk0u34mA1/MywBw
         h9Jq3RO4zf0d1T0u6iXii0FTX5CzQaHIzsz1caANAgYdy3t0O+tT25dTd8FDpWODO9ZQ
         OCa5Y2GVEDkUqomfxASVuejXoW/ogjRJ6Qe8tglsqndXlEl9pegnUsWAQZ9y1DwDCMqp
         8d3mVu1tqM4gRitf3PeksMylAq7OaEAp4jEm3g2SkIkMrU0fXxR+LUmgODqRLWpimeWG
         UXnyPkeYRl5cLS0tScGtKDJHki58965yM0+8BryRTi/qn5y0ciaJWTbykfqgjADVU6Wo
         VzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719328734; x=1719933534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sx2HYLsaSgIFg2Oa96eeaBmlhRTVUGHBB/hKxCjYNQo=;
        b=NUGlqLiG0XqvFORKnmLvMNa3KNj+IGatnYglc1dJ8SbLz7htOcj76/WpTH5tb2uKPH
         4tQw4Y7T1oXWXSZiVxSHgPaK3vvsObvrXumJBxUGwtWQ1RvgN6lDi06UubuYaHI35SMU
         GDoy7uBKL90H/h7l3u0X9JadwvmRYHubjx+yp+uAMBRLbh9tYXlh3mAvVNi+7gPr1W4l
         jyAGlGH/zUW25ksVq63cXGGfj2IWgJcNspCJ85iwK0ebrGNNlqMMPy6RorxiXN2+SCBx
         Vr8yQqmkQ0BtOkijReY9AbwzwDhAbdZhSxXuPVUUbFisCxtrV42QGYxDR+76q7Jh8+/h
         x6jw==
X-Forwarded-Encrypted: i=1; AJvYcCUvSqDASb0Flymn+QIEV9Ato21ZZqmiN4FXC3o3YpzNA0xTD0pJgrIhzbdMfGDFqAUJ4qnWOtHT1mIYJ9fYSsWozhzfHC27
X-Gm-Message-State: AOJu0YyNb/bsbJFDl4jnLmdrrRwrfczpa8xZjMpiaBm1gtVzSXeXiLU5
	RVrr8u6ZRCJNyGbG+CMf93hm1j3ln6COZXNM9hAah4CUehgnKPc/CqsCcWJvvAxMKf15WQHVbZW
	JvKuAWRjP0FlO0ff9S9+wygbt+FnasH3NF8bpZg==
X-Google-Smtp-Source: AGHT+IGlP6Tm/b40/iLFEbi5fEIe/lDxGDCO4P+RlrzHbY56PKFGIr90owQjEXNXIRqgsr7Lwxg736Z4cGfOwruVrLo=
X-Received: by 2002:a2e:998b:0:b0:2ec:59d8:a7e9 with SMTP id
 38308e7fff4ca-2ec5b3e35b1mr45408841fa.52.1719328734531; Tue, 25 Jun 2024
 08:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625151430.34024-1-brgl@bgdev.pl>
In-Reply-To: <20240625151430.34024-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 25 Jun 2024 17:18:43 +0200
Message-ID: <CAMRc=Mcm94=Fd6LiRpBLD3bWco6KhZ4+T0YPwAmrtNUosM6VEA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] arm64: dts: qcom: sa8775p-ride: support both board variants
To: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 5:14=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Split the current .dts into two: the existing one keeps the name and
> supports revision 2 of the board while patch 2 adds a .dts for revision 3=
.
>
> Changes since v1:
> - add a new compatible for Rev3
>
> Bartosz Golaszewski (3):
>   dt-bindings: arm: qcom: add sa8775p-ride Rev 3
>   arm64: dts: qcom: move common parts for sa8775p-ride variants into a
>     .dtsi
>   arm64: dts: qcom: sa8775p-ride-r3: add new board file
>
>  .../devicetree/bindings/arm/qcom.yaml         |   1 +
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts  |  47 +
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts     | 836 +-----------------
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi    | 814 +++++++++++++++++
>  5 files changed, 885 insertions(+), 814 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
>
> --
> 2.43.0
>

Eeek -ETOOEARLY, please disregard this one, it requires one more
change. Sorry for the noise.

Bartosz

