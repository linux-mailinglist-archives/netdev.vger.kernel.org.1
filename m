Return-Path: <netdev+bounces-97574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4711E8CC2B8
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 16:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEAD31F2132A
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 14:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823452594;
	Wed, 22 May 2024 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2jnUB6bT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D048513D63D
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386488; cv=none; b=BAijb0yhQOsBdDH6XRBpAiFPe53XJzs50OahBbbHrKeN4imVP/4q4cWpjKUf9SwV0Qtp8MzpmviT9I2007zkBTyBZsR2DK0njeGc/5qHxeujtyQCt2MjGflUKquJP00NwO0DPTCaX4zX5iNziXFvasmzOA9Ha8JU3NIO5JpZ9V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386488; c=relaxed/simple;
	bh=Aly5UMYHr+2V4DiE0Vcfx/Kv7FPJLJG0vJT9Kjyoy7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoBDepNK97vcplT1gH+EZ95f00vPc3Qqt93AA/P9ASHvIk8ZYZ+vUoZZBVF9ymx3/295M+F3aGFj4hQB/DkixcE1tD+EuXUQuoHvilBVb3DsgrNoVusOTXeWosoiw2giXiFRrVvj4EiIHcUvrt9/233053/aLNtfpQmOGn1wovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2jnUB6bT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42012c85e61so67115e9.0
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 07:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716386485; x=1716991285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aly5UMYHr+2V4DiE0Vcfx/Kv7FPJLJG0vJT9Kjyoy7U=;
        b=2jnUB6bT3wcToCG0iaYyB3WCIIkdgT0XFeSUyen1XX//S1JqVxFZlLylKQHs4vtbwF
         toz5hgw+/5fa0GrlQqeI/OptdvZnjPf3HNf/4e5juZBigsRPG+cwe8XuxoW94O+7tetQ
         5nh4PK6o+2fBSK+drO0HT/B99aFE+cLkRi7MSusPSr0rNQRX0QQRSamFFgc2c8gXlOkr
         9TNI4Odl26pcl6AKoaVV7n0pE6Jvg8WUpFrI+ZBCPd+B+JvwAT1VBHmac0VbO9zWrI0S
         pb9b0vOdXeorvvIz7UZJqZpWYoHM1PnpZpnH3iqpYt3nwQNV+ea4O9sZwV7ie6RY+jVd
         Oijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716386485; x=1716991285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aly5UMYHr+2V4DiE0Vcfx/Kv7FPJLJG0vJT9Kjyoy7U=;
        b=coh6ixC8Vgsj6u+7vC9w5duNhxhS8mTBlWY0zRUljWDkNHot2h+X///6eGBe5U6nZV
         asbnntnkLkHlxBhCDn1qNXhWdK0qa2LtmpCkRgKSjPFdOvdYJ/kBgBIipVrPb0K2QrYT
         7HP2OBZZKxKS+CjH5ZrnAWgOPn2k5bO1q1jXHcPf3aGp4/fNCg1u+oQKaf9j34SbN51r
         zDfKtzmPIoX3Vd38wkiFW5jBXAOl+D5EgW7wJ0zTSXn1HELCdb8U0SUYs7oP5xLpfaR8
         /HC2CMfH8KR3+09vWZT940kFnc5tGSZ6lO+BW5F2fVm8/OnQoiHNQVIQjbllWlGbGpEq
         ueIA==
X-Forwarded-Encrypted: i=1; AJvYcCX79xPMslyiMh0etZKmZd5TkcKmyh3J6pHOQhTwg9ERqwX+RGoSWyYfhRt3JPQzv/oF5DHCeRmiKvbe96Zop2Ej2HkML4OP
X-Gm-Message-State: AOJu0Ywrs3rKlj53r53l9oToB8MevLcqIA1/ccboz4j/3N+WDYCcOWcj
	C3oRrgGLWFFP9BKSzArH3wVkOWx7LCL1JvjqXREokFUHZSoS5ExXWT/yw4aFAD3+TJ3DSL+lkYe
	ivY2VBlmxaUilh6rPehipCp9VwZfjLtae1S6W
X-Google-Smtp-Source: AGHT+IEUvvMTj+pXR6vzK7Wf63T1ANyrBX9wvEQ+EqKfs4WzlstSwvs3QbF1bLtqZlE6izNtx28y6/hzkP3OOa7tP0g=
X-Received: by 2002:a05:600c:a51:b0:418:97c6:188d with SMTP id
 5b1f17b1804b1-420fd1eee70mr1646675e9.7.1716386484773; Wed, 22 May 2024
 07:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b18ea747-252a-44ad-b746-033be1784114@gmail.com>
 <75df2de0-9e32-475d-886c-0e65d7cfba1e@gmail.com> <20240522065550.32d37359@kernel.org>
In-Reply-To: <20240522065550.32d37359@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 May 2024 16:01:09 +0200
Message-ID: <CANn89i+VvWJ+TGDpYWxU-LJZHtHo05bx6CHofM+8QdG4nmpqEA@mail.gmail.com>
Subject: Re: r8169: Crash with TX segmentation offload on RTL8125
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Ken Milmore <ken.milmore@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Realtek linux nic maintainers <nic_swsd@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 3:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 17 May 2024 15:21:00 -0700 Florian Fainelli wrote:
> > > The patch below fixes the problem, by simply reading nr_frags a bit l=
ater, after the checksum stage.
> >
> > Yeah, that's an excellent catch and one that is bitten us before, too:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D20d1f2d1b024f6be199a3bedf1578a1d21592bc5
> >
> > unclear what we would do in skb_shinfo() to help driver writers, rather
> > than rely upon code inspection to find such bugs.
>
> I wonder if we should add a "error injection" hook under DEBUG_NET
> to force re-allocation of skbs in any helper which may cause it?

Makes sense !

