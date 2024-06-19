Return-Path: <netdev+bounces-105008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D5990F6EF
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF4A1F2271F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89961158D7A;
	Wed, 19 Jun 2024 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nInh2kjm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6BF8475
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718825358; cv=none; b=FvJcn59ddXEEVGDf4PMxRVN3SpMU+p6WUwAypefYrvjQ8XqBuMiEbb1FIQgwTyqLiNYw8Z3LS1RstoMNj4dCrSjnCZ88qR6Mo0KS0vmWjxXkbogT6NgxLjx2E2VTXDD9OBMy8KWQpWgyd3U6SNnPcAbB6h2NjHjV68V4mDxYP64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718825358; c=relaxed/simple;
	bh=1SXc52g+zhJGJZ9WknweUhXNqTt2ao1lVhNUkIST54M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VP716pN249gzP2PRC4Oot3cSQgCzWVq7BJkhu6HmvcSglqhclE9judJWyI7Mue5Pwjsg47NaqDUhVRueegID6mSXqGmVJTVgUIZSlgfvmJPJso9RWWc5zi/yu0JNHR5GFv2pfxDIi3fJLqmtPH1RG5PW4N3uvImOHpbt8BtaiKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nInh2kjm; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52bc121fb1eso160254e87.1
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 12:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718825355; x=1719430155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sizxqf/p+Ad13rP5NaIetozu8E9y9ijMGImLu6tat1A=;
        b=nInh2kjmRTpQcmXG/2/AHC8Lw3rX9hLk09yUGGxYXQtUu33hawYcjWNZVaNN2jSLIm
         k+1A1LbI4d4MNJXxfO6SZW31L/jDaqbeGOcqaD3gZIKQqTUWbVHrQHoj5VUty4ExFrmr
         0U7Uv4yIcVSZSq6DCDslTNncg6R/wOlafSVip0tsBX+EX3sa67j7qsRfUZmLNQoIk3WM
         RTdS5JlMulpQC5uZeBy/3mOwbW7jR6pGON4ruVruYB9G8xKyOZQGSzRtM3MzCMjaSbyH
         UZmXO+A3immYXXBguan/0s5l2o0aaDrTHt8yIwJGLhuvk9WJc/X7wUGZv02adtIcLZcp
         xsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718825355; x=1719430155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sizxqf/p+Ad13rP5NaIetozu8E9y9ijMGImLu6tat1A=;
        b=QeCTYgW6iC0Cq1WPTgDNPCchaPK0sco7KR10LMGLYsTEKDPBKU0w942i+OkLjDzW2G
         W8q/5DFreQK433e7y1gxBiuS5zOME0AFxLF7n3tM8zW/ANqJnhZ5DUsLXsWUaLjPbX19
         qypt3lpgJTLOWdLXtEiaoWRpr/1KH0LTrm1nd6HG3SW+mHUngR3JQpyFP/2NKzRDzlVk
         Dmw+GE1uYdlZRwi4ftpYxxK/hpOSgkM5rjzshKL4wH5ZvVZulTT5TAT02QzcvYHHdXCw
         MPXO5vajZpu+kgMhn1EFMMLHVJxAgyyRyCu/Tl+pamNZyrplDWNf7EIPthJyQHeDIvNO
         aj2A==
X-Forwarded-Encrypted: i=1; AJvYcCW8Om7EPp5pepCtAdTBDzWIS5C/8N+YzlrtHI6dWEswsaImxjdBpTA8Ns4lJnlkBIHGRlQgBXWz0wEnLRsbInGXNyzN4qhR
X-Gm-Message-State: AOJu0YzNCNOA4sslCR3tXC7IoRSckyf6b6j6Q7waWMUOf90qKBXuNMPE
	e4eD0Nb3yxCia6NjRp+f/sHxPfxSJdQEptBEXJCH5/JHswSuBskMPHw81kow/syU9y2s5fn3G3n
	3aBZyNzHlP+9uKcN1tXWpjL4FUJQ+lIEzbppvqA==
X-Google-Smtp-Source: AGHT+IH/SFsikh0a7Jr/pP4kVDIchxhejysWu07Ul9ypfLKXOG9XTdZtFR6KlZwkn8zT1K3TP7nGNZxnhwc9pC67zws=
X-Received: by 2002:ac2:4c06:0:b0:529:b5ea:fda5 with SMTP id
 2adb3069b0e04-52ccaa5459fmr1881427e87.53.1718825355350; Wed, 19 Jun 2024
 12:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619184550.34524-1-brgl@bgdev.pl> <20240619184550.34524-2-brgl@bgdev.pl>
 <bedd74cb-ee1e-4f8d-86ee-021e5964f6e5@lunn.ch>
In-Reply-To: <bedd74cb-ee1e-4f8d-86ee-021e5964f6e5@lunn.ch>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Jun 2024 21:29:03 +0200
Message-ID: <CAMRc=MeCcrvid=+KG-6Pe5_-u21PBJDdNCChVrib8zT+FUfPJw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/8] net: phy: add support for overclocked SGMII
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vinod Koul <vkoul@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 9:09=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Jun 19, 2024 at 08:45:42PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The Aquantia AQR115C PHY supports the Overlocked SGMII mode. In order t=
o
> > support it in the driver, extend the PHY core with the new mode bits an=
d
> > pieces.
>
> Here we go again....
>

Admittedly I don't post to net very often and I assume there's a story
to this comment? Care to elaborate?

Bart

> Is this 2500BaseX but without inband signalling, since SGMII inband
> signalling makes no sense at 2.5G?
>
>         Andrew

