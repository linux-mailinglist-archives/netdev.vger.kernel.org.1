Return-Path: <netdev+bounces-120557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DB0959C46
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752711C2167A
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB1318C35C;
	Wed, 21 Aug 2024 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="q41EhNWt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426A7185E6E
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244368; cv=none; b=uEdv0pVAisZNXgp698xxO7+gSpYXAMk+2L/eceohBE1YKl1+nwkNifvIC6ZWsHCRUOLu2IX6Ll6lPuwYWd7vA2IQsBzlwHIndlJ7BbKJtoCTYV0aK6KUQ1Ndke+fc2xFm6hW31uZCOSX6P1ht2cWvm81s5HZewib8jsJnYpw8+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244368; c=relaxed/simple;
	bh=hiR1Haq30NxfLMtsVDbu0nnLT6exfBNX71lnvpiNLFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8F5M+2IMoDVzmvfdlg7u8aWacvOaHQAgqvkAzw6iHlG19zayfMdX92GKRKJj8BeajNE5xcjeVg3qCsJ0H7+VL1Gy8jlTbC2au2CLDCtkP5eruWDkKGQg0DMQXYeKgQiyX326CpB3gY5yu+2sXleWFktoiCw7qicAl2a3kImDHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=q41EhNWt; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f3cd4ebf84so54099061fa.3
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 05:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724244364; x=1724849164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiR1Haq30NxfLMtsVDbu0nnLT6exfBNX71lnvpiNLFY=;
        b=q41EhNWtgX8WLc6zeVbeAUGL/bhDtQNP57p8MR9CIvV6qidK8MSNXaTR9jKmPbhexl
         SxpalRgAYEJcNlNbkbw2L+gVhMu0QEc84TH88T89GrasXdxvHcrleezy3a4SpgZCuhzX
         FwRUGTE4FTyoUxvPcuR7Rh4/3HEU/yz3yemSs9OJMqlcmYLZ6NtgZ4nN9eqUvTue1Tpp
         hb01vAAluNrP5QwRFlmeuyq1c90bKNZ0KqC6sLAzCxvYsA9Ual9oZouklMMV+nvLhn8d
         J8sNZisZUhMlmxZuHclBzeXBmZJ9ug6zsW5wEnQkiCLeCylQo2sYyG2JhyekCCQwiuH0
         /c3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244364; x=1724849164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiR1Haq30NxfLMtsVDbu0nnLT6exfBNX71lnvpiNLFY=;
        b=CUewhTFx37Sh32ChUSvUq83RgpES9DLlJ0LMtWf3UPJWdFo1jHBidkld0lXOQ7e8nb
         +1QoE2CF02I3fBNIUNw8Uy8pFFNwuEUegqZevzZWH1b5Jhg8jrjSGGfARVUmoQRYJITh
         crJ5hYeM8ZOFFK0nQM7ziDgSWMdhb95i+/JEILdqyLpdfdxcrgWE01uX6ltbDFFb7ho/
         RFC5hzFa7znTZ3lV9RsQ2yDiada04H/cPM8sc+YkCw5lcfGvN/RmCEYRp1hgySiH9eSv
         G6inFRbGXf+SPPe4+z6+4IRgR7vqUxOnnba0RAlGm7WxWip+VZwkOr4fYUZWl5ILm/hO
         5lIg==
X-Forwarded-Encrypted: i=1; AJvYcCWJSy9CvD0xiEfy96MLdOQIOQaY2GiLezPNmtg7ly+CxEgA9ZwfmZo1ADeW2l2SajB1/AKLmbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyta92QyDFBkOMM56i281Xp+lQa0zR+q7rJuMlU99PR6OmixMQ/
	N2FXvCekYgevIFiJZW2OF6tD/5+76cXzkuNWFYNXI4m1npyEfytIndkxDobo3aKlO4D0xAOnndR
	8SBNG2TVPshJvBfhuX10T1HO4YP+4xaFr5YR8Dw==
X-Google-Smtp-Source: AGHT+IEoyoaFzaTuBjS7UWRKkhT5wQ2XOqzoc1U9KRDb2oPtaGqMo9RjMJ/MuacPyZChbEXTgMD4LzxduCDtp+Rqrpc=
X-Received: by 2002:a05:651c:1507:b0:2ef:1d8d:21fd with SMTP id
 38308e7fff4ca-2f3f87e0c7amr14835921fa.2.1724244363623; Wed, 21 Aug 2024
 05:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821122530.20529-1-brgl@bgdev.pl> <bd793119-3a0f-40c8-8c78-201e2fcf9664@lunn.ch>
In-Reply-To: <bd793119-3a0f-40c8-8c78-201e2fcf9664@lunn.ch>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 21 Aug 2024 14:45:52 +0200
Message-ID: <CAMRc=MeaVe=JcT9KF4YaP-2jsPH=ApRjfhomwuJ+L9GLhh-Dng@mail.gmail.com>
Subject: Re: [PATCH net-next] net: mdio-gpio: remove support for platform data
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 2:42=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Aug 21, 2024 at 02:25:29PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > There are no more board files defining platform data for this driver so
> > remove the header and drop the support.
>
> There are a number of out of tree x86 boards which use this, flying in
> various aircraft, so have a long life, and do get kernel updates.
>
> I'm happy to support this code, and as a PHYLIB Maintainer, it adds
> little overhead to my maintenance works. If you really insist, i can
> try to get code added to drivers/platform/x86/ which use this.
>

We typically don't care about out-of-tree board files upstream. Having
users for this struct in mainline would of course be great and a
perfect reason to keep it.

Bart

