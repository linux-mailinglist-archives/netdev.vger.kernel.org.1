Return-Path: <netdev+bounces-102797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A243904C6E
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 09:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAAE81F22162
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 07:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCC46F077;
	Wed, 12 Jun 2024 07:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="o7Zd1oeZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4094213B59F
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 07:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176268; cv=none; b=FE8UTayvE+lG0ZGBxfy6bvF9IhnRktdzOdiuBoQzqWJ2Ggh2tYPHmsCUrRCVajVywLqk9Zjqw1OjqAQPXspAciK8fNjx4nT0Bvul53ooJaGhwPJDkhBFdORw2zwHgTP74qwxLiQv6T36Mhqt1wgCSXGZd9apj37jML2cQm65Ejk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176268; c=relaxed/simple;
	bh=i6o0FZBPMx+nOIu/mzHBniZ5GdF+FcAxR4uXfrLlAu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fl2619W/bVm1nq9ebP11MpwXxe/xl0j7Ie2xxusWm8yP8xMHI4x1lg2oQnSvgGzOLK096hJJTHKKJ4xpJqQbbXn8sU4qoLVO2VbeRkbWpdKrHMFt3tmmhXzMgwy/EJ/+S16866OFu1hTM1EzHKHvWBXaZP28Fmv6iVm0T0nbwAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=o7Zd1oeZ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebdfe261f9so50085031fa.1
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 00:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718176264; x=1718781064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6o0FZBPMx+nOIu/mzHBniZ5GdF+FcAxR4uXfrLlAu8=;
        b=o7Zd1oeZPpPLURaHzb321yRhJty2DLlnC4qlpDAKYRFrE37XjKXxDcFOiFIb9S/k59
         zOiDJoKQKHDthECblWTjcuySU2K8pVGTszGKSP28d8Wqu8RslcoPlcygzf1gMvZwyl3I
         pvNZo+1wN7nmbggtNN8Z6x2LMRnZSBpP+Z+J+iGRVSpfGK9gO4MbtRortXxuZgYt/y25
         pNZA62NRWFLhqawVq7KXbsVGQsn49MwnAqnVQsnthUWtbAjJMYPwSAy5XiqKVPxQxpr8
         LGRrV3JLU8vv3DDdZY6lCL2a6PAUrgpA0YzkKe44ijQH5GLO9atBJnYnPCFtsPgtHWjb
         1ISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718176264; x=1718781064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6o0FZBPMx+nOIu/mzHBniZ5GdF+FcAxR4uXfrLlAu8=;
        b=UAebPpt3LzvQue7sZEgNgj/p8NHH4foF56BF9C8aN9Hhs5XA/abjVnmjjsbxlR6NIX
         yAG0mL0Zsuf7GF3u18Djb/yW//ZahMvY2PRiDHf0TeOYRaioOUasm5qEiuGattKxyQtz
         RGMNRA3LUn1cToUka9rh8m9AxILkf2os9CY+VxKo+NGRlK60hEakXVkXG/ysNVRYwR0k
         H/mKhl4VyJbpa3N+jwtNxY7QoFGnFBo+meaoZ4AQOm0kpYWy8yTqZHYCAvtmcfXlLcpI
         c2tGjTYBFDXCwxxfTVR72TYWKevuWSrqmtkTcYYfgFLul3X5DvR2dT45Bs/ZmOxAf4Ew
         r5qg==
X-Forwarded-Encrypted: i=1; AJvYcCWFIhJwB3E3xcrnjWX3zjAGYFHykb8lhOZ7qArk50ZFNMiI6ql+Gl24UU6HJsV8kl/ryVcNqkNUT5gfxW5BuRzj+uFY5Ut1
X-Gm-Message-State: AOJu0YyMA4pgcIX9Ctx99mTnDHGSfycOlIU1ZO5podcXfe156vOU6FKL
	VYJfj9hfzPimHGU4WltBNGypvAjK7u7CYebs738/ricST0Z/nRa9jTGdHXdLSnWBB948COPZ4cI
	lsF3Fx2cMm9EuOmDbWZ6/lsreqVM1am18g/EKYQ==
X-Google-Smtp-Source: AGHT+IGbd4X2fJf6zNeYZx/X1mM77+GhoF1Zhv+mm3RhXCxcJXVvZIgRJjoUptYt08IGG4KjkAvHHP/xFOcuJD7oR1M=
X-Received: by 2002:ac2:4c4a:0:b0:52c:826f:f3f1 with SMTP id
 2adb3069b0e04-52c9a3bfbb7mr898457e87.2.1718176264237; Wed, 12 Jun 2024
 00:11:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org> <20240611225428.GA1005695@bhelgaas>
In-Reply-To: <20240611225428.GA1005695@bhelgaas>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Jun 2024 09:10:53 +0200
Message-ID: <CAMRc=MfE0o=ohK6fpJN6=J7hmywifneBaNdSxOgeGH9iZ1uvTQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] power: sequencing: implement the subsystem and
 add first users
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Elliot Berman <quic_eberman@quicinc.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, ath12k@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 12:54=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Tue, May 28, 2024 at 09:03:08PM +0200, Bartosz Golaszewski wrote:
> > Note: I am resending this series in its entirety once more for
> > discussions and reviews. If there won't be any major objections, I'll
> > then start sending individual bits and pieces to appropriate trees.
> >
> > Merging strategy: The DT binding and DTS changes are a no-brainer, they
> > can go through the wireless, regulator and arm-msm trees separately. Th=
e
> > bluetooth and PCI changes have a build-time dependency on the power
> > sequencing code. The bluetooth changes also have a run-time dependency =
on
> > the PCI pwrctl part. In order to get it into next I plan to pick up the
> > power sequencing code into my own tree and maintain it. I can then
> > provide an immutable tag for the BT and PCI trees to pull. I wouldn't
> > stress about the BT runtime dependency as it will be fixed once all
> > changes are in next.
>
> The PCI changes are very self-contained and any conflicts will be
> trivial, so rather than messing with an immutable tag, how about if I
> just ack them and you can include them in your tree directly?

Sure, if you're convinced that eventual conflicts in PCI core won't be
an issue then it's even better.

Bart

