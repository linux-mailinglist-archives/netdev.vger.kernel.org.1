Return-Path: <netdev+bounces-117903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB0894FBFA
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 04:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F26F1C21939
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 02:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B854217588;
	Tue, 13 Aug 2024 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJ3+panW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15518AEA;
	Tue, 13 Aug 2024 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723517443; cv=none; b=H8cJQ4FzzEp09Tfs+Z0Q3yV6tn56aRQsc9hNptYftAbxmvkxr2u5f3jaB468jyOhpvMWPFY2ILprHRit6DO+26moe2+Sy0doAjwoCelf1oY/GG9vrDwXnUYI9POLz2OgHM7gGoE+9A4IUh5yrQzrcXVAogCwLQrPelxQsgqGihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723517443; c=relaxed/simple;
	bh=CF9HW3eNFhOVDA/sxRBdxiNTt85AJDi7Zr7sdnYlRo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIYDJmtomNfwi6sW1g2w9m47O6jNXjy34w88oGHnoL6741XWkuRgpM3NFboQsB9h64jyt7BytM7PJR9oAEMN6XGfbqrl8R46tJhbjRIlXHnBHvzKeAyDRHoiFzlK7mjlmK3XPuFe8pLxjNEa4W/m/dL7rIvHKYPk9LiOT+ivgmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJ3+panW; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-691c85525ebso47369127b3.0;
        Mon, 12 Aug 2024 19:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723517440; x=1724122240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5X/LLJbCQIJdAHCZobbfZ15M33n1HKUhsdxOtakpmKU=;
        b=TJ3+panWonqSSnbGJ/5VSGdAcGT0hxM4XB4rX0Sz96kTgHX9zkrbyvVed+aNePNzND
         /Gim2f5m17rIQxkTx+iK7fyX/IRJM7PBEyxiGq9AAM2fIGAcscw7gXiwlguqn9DErYCc
         cJZlAi9QdtKm5RCJgt48uK/HXnTKq38BIfHCpFg2I+IwxP4H6UpswvVZtH6fh4EyQAKn
         5HpYLmPo1246WyEYf+utFAwzfgzizrpEu4opZ4l2TfNBguZG1wiButMgG39FSmmYT2ut
         lRhk6qIs3YMpR80yE/maknjOIe2plD5v7KBQuEWSkIHEbRtnWwH4U4WARRQ1qml166zH
         qNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723517440; x=1724122240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5X/LLJbCQIJdAHCZobbfZ15M33n1HKUhsdxOtakpmKU=;
        b=Bi55IwczXhgiZPHp4Fc/ewt6HA0NOl5whd3Yiz0ksiPzI96AHbLgkEn+xrL69+otv6
         baf5WedgvCJ8RvrbBTORXEmiJEmHAvkrDQa/V8o1+U9aep98pU6vEL0TD/5I6xicVLWQ
         IPPsmUwqN+SxaOITydIhf6IbZHHQ1Lx2mloYGsjkeb4Z/c/xCdHs8EpoVpmglV07Lvi1
         +fuwTmNF04Z4wsBzOG1m+YiH9uXR7zsI6zwYQAFL+tAG+5c6Ulv/+evnWt7BbRLZE9xD
         OY62X/A6Yi5jOur5SBXkJllP/nwxYe4gf/oN4XMvZvbARvQRoJLJxCUBvjYkFFvWNNo/
         mf5A==
X-Forwarded-Encrypted: i=1; AJvYcCVFUyb8zgtXb1+0YoeQK3qxWk3ZzAqim8vfei5W6pV7qdXgt1BhpmjrTbAbb1VTPZOQt8UfViJWDR30xbTLXrxN9lqh6wCC421Is4PN
X-Gm-Message-State: AOJu0YyReeT3jOUmpcelMQhnZaexkjDOAIcnG1tsGXzaFM7AHjlbQS6F
	z1dkmvg+BZGx7mIYKhEpZnhK8mXvlZB0o5vW4M6AI9Yh7dxgFUJIbsZ/joce/W2RCsBrybhI2tZ
	cGApGoJQGcn7WofGRPrVf5XCdDYQ=
X-Google-Smtp-Source: AGHT+IEtD8/3jwjUQ+AEI2oWq1b72HdraqJL7SYGlFXfY5Ubeh//o2e4Ryc3x/THyllge9fIvvnW9ZqvGRbDPAY7n8s=
X-Received: by 2002:a05:690c:f92:b0:665:30bf:7752 with SMTP id
 00721157ae682-6a97151cb4dmr28162177b3.2.1723517440450; Mon, 12 Aug 2024
 19:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812190700.14270-1-rosenp@gmail.com> <20240812190700.14270-3-rosenp@gmail.com>
 <ae818694-e697-41cc-a731-73cd50dd7d99@lunn.ch> <CAKxU2N9p4DrbREqHuagmVS=evjK48SWE5NM3RbD5zF6D-H93kA@mail.gmail.com>
 <38c43119-4158-4be8-8919-f6890a5f4722@lunn.ch>
In-Reply-To: <38c43119-4158-4be8-8919-f6890a5f4722@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 12 Aug 2024 19:50:29 -0700
Message-ID: <CAKxU2N8-bPnkouJ_95U9NkRh7AP94MuMJTMeThWQhnuL1n0SMg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net: ag71xx: use devm for of_mdiobus_register
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 7:41=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Aug 12, 2024 at 02:35:45PM -0700, Rosen Penev wrote:
> > On Mon, Aug 12, 2024 at 2:28=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > On Mon, Aug 12, 2024 at 12:06:52PM -0700, Rosen Penev wrote:
> > > > Allows removing ag71xx_mdio_remove.
> > > >
> > > > Removed local mii_bus variable and assign struct members directly.
> > > > Easier to reason about.
> > >
> > > This mixes up two different things, making the patch harder to
> > > review. Ideally you want lots of little patches, each doing one thing=
,
> > > and being obviously correct.
> > >
> > > Is ag->mii_bus actually used anywhere, outside of ag71xx_mdio_probe()=
?
> > > Often swapping to devm_ means the driver does not need to keep hold o=
f
> > > the resources. So i actually think you can remove ag->mii_bus. This
> > > might of been more obvious if you had first swapped to
> > > devm_of_mdiobus_register() without the other changes mixed in.
> > not sure I follow. mdiobus_unregister would need to be called in
> > remove without devm. That would need a private mii_bus of some kind.
> > So with devm this is unneeded?
>
> If you use devm_of_mdiobus_register(), the device core will call
> devm_mdiobus_unregister() on remove. Your patch removed
> mdiobus_unregister() in remove....
>
> Is there any user of ag->mii_bus left after converting to
> devm_of_mdiobus_register()?
There is not. I've applied the change removing mii_bus from ag locally.

From testing, nothing has blown up. Although there's still a problem
with switched ports (except for lan1) dying after a while. I think
that bug's in qca8k though.

calling restart results in no surprises, unlike with some of my other
questionable patches.
>
>         Andrew

