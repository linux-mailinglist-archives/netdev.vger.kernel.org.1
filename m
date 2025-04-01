Return-Path: <netdev+bounces-178489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B284A772D0
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 04:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4013AB8A8
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 02:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190771A070E;
	Tue,  1 Apr 2025 02:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lessconfused.com header.i=@lessconfused.com header.b="eYyVXqjc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB9213C67C
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 02:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743475460; cv=none; b=YaW2R5YhXTBUJuten+eSTPW0j6/315leSqRlA6yXeuj+R3ieA5mlyOkuYT09MCcqqJnfZ/aeevx/7Wu47QK63khGx2E7oYwRfXn6COD3Nk65w8lyo5JMmy2hldGGKKPLsKrFhqzG/5EORlGj6DlXvnux0MyXfo4eTrRc4lwCagU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743475460; c=relaxed/simple;
	bh=HkxGjWUqTJOgqG7g3+8MzEadXEObhK4uaNG+f+mMpaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIoTy1ZnjpWweamQqvRJ/gzs/KyLmcD9CXqju0SiNa2CN7MkDj5hLIx5MtbxH20nQXoKWNuhgh8AHUcjMDT6M/VPK1SqZKf6Zsh792DsMn+8S6hN0i0lRCtwcGodhZBva6CwZKgNaVPfvfemJyRKZ+iVOC8/b3UuasBskqvs7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lessconfused.com; spf=pass smtp.mailfrom=lessconfused.com; dkim=pass (1024-bit key) header.d=lessconfused.com header.i=@lessconfused.com header.b=eYyVXqjc; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lessconfused.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lessconfused.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-303a66af07eso6966061a91.2
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 19:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lessconfused.com; s=lessconfused; t=1743475458; x=1744080258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkxGjWUqTJOgqG7g3+8MzEadXEObhK4uaNG+f+mMpaA=;
        b=eYyVXqjc96cYAL7J5II6yGzorQAT7ybIEzwi28gXkn6HiURBAmrIv3U6wXYUhgKesU
         gtTRYfrbtzJRp3pJlejjL88m0se4Z5/BJH+G7jJ4760gZ2Lf9rjx6JJeLBIxsfp0hDVu
         wO9dAaNxhUjcjPYNh3wWxKVWDmTb3PZuZuV1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743475458; x=1744080258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkxGjWUqTJOgqG7g3+8MzEadXEObhK4uaNG+f+mMpaA=;
        b=v/vPhcetABHFolP4FwYOXAWhR2etWjIurf7p5NBkZ18iibY16zJkI2AsT+O2GFxiWJ
         zbR3YcibwgMnhRjQnFNsEtInB2kW6sDLMLN6JREAvFNW8MdBlBkvburpWedyfXMmSMTw
         G+qX8kXezT0EV9T92rbYY04Q3XWNJzl1N0BNsQWRKSzRGpeUsWysYtVj5qetMFTlQqKy
         gUi8DlHmQgze5oaIeClA2UqymkYCHkU0Cp1/MHxDXr6bYKg/ga7+SQhZEvFtLh3Ko+2x
         ff8hv3yMyK2Fu/gQ0ixIyVjFdU15DEfcUAMc1p19d44cXJ02q0jwLRfYDpfLPoM4WPyw
         m9uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd7cthOIDXR2cvyH+ULXcBkM1mC/BMz87t53tEcjHEAizSAaBnsEWVoF8Rk/WAv6O+JUuJvEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq2MZcNP6GJH6A3q8aqrw4aT1PI2zhPhXusU6gcFRgxEvQUoJi
	6IrcpAKocPgjfgarDZAGIaqgZQuHapKoMtG+RHWKrjxKWsbImWJPmWqlXf5KRFEarH7BWe3bxlv
	JhvoR1rT0eQw4eek1HpXgaS6+OX/ytvc55rZ8sw==
X-Gm-Gg: ASbGncsSQfEg2v8BYLI6tBCnCTzTG07iSG76PwZIS+onQsQxQEVuPbqdTYKsuiRUfSn
	SXzbOK5mrgQvEhAnqfxcrx0MyPZCGXtfCP0l6qFy2zmWjXZU7ZZvlSMJ5V1A6KcfL14pC9N8RoC
	ROldDM+5Ux/jt5e3xifhAxhqo=
X-Google-Smtp-Source: AGHT+IEpFvhBi+lUM5E7CGqIh8SlOtzaJBvCk79aI8LiSy+0QDNR3/3AA4vdH3Sbx11mdSvsVtvYulswYGsuHxWrLD0=
X-Received: by 2002:a17:90b:1f91:b0:305:2d68:8d39 with SMTP id
 98e67ed59e1d1-30531f9475fmr21374158a91.12.1743475457642; Mon, 31 Mar 2025
 19:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331074420.3443748-1-christianshewitt@gmail.com>
 <17cfc9e2-5920-42e9-b934-036351c5d8d2@lunn.ch> <Z-qeXK2BlCAR1M0F@shell.armlinux.org.uk>
 <CACdvmAijY=ovZBgwBFDBne5dJPHrReLTV6+1rJZRxxGm42fcMA@mail.gmail.com>
 <Z-r7c1bAHJK48xhD@shell.armlinux.org.uk> <CACdvmAhvh-+-yiATTqnzJCLthtr8uNpJqUrXQGs5MFJSHafkSQ@mail.gmail.com>
 <Z-ssXdmRLYqKbyn6@shell.armlinux.org.uk>
In-Reply-To: <Z-ssXdmRLYqKbyn6@shell.armlinux.org.uk>
From: Da Xue <da@lessconfused.com>
Date: Mon, 31 Mar 2025 22:44:05 -0400
X-Gm-Features: AQ5f1JqL8hh66tVHnQp1H53_t8VYOq9ejOXVjyop1xdABti6QeP9kvlxkmw2sn8
Message-ID: <CACdvmAgP8iftcUumv9RrHBLLHFtQtPeRVgDVp7YkWuPsW6Ybmg@mail.gmail.com>
Subject: Re: [PATCH v2] net: mdio: mux-meson-gxl: set 28th bit in eth_reg2
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Kevin Hilman <khilman@baylibre.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Da Xue <da@libre.computer>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Jerome Brunet <jbrunet@baylibre.com>, Jakub Kicinski <kuba@kernel.org>, 
	linux-amlogic@lists.infradead.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, 
	Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 7:59=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Mar 31, 2025 at 05:21:08PM -0400, Da Xue wrote:
> > I found this on the zircon kernel:
> >
> > #define REG2_ETH_REG2_REVERSED (1 << 28)
> >
> > pregs->Write32(REG2_ETH_REG2_REVERSED | REG2_INTERNAL_PHY_ID, PER_ETH_R=
EG2);
> >
> > I can respin and call it that.
>
> Which interface mode is being used, and what is the MAC connected to?
>
> "Reversed" seems to imply that _this_ end is acting as a PHY rather
> than the MAC in the link, so I think a bit more information (the above)
> is needed to ensure that this is the correct solution.

The SoC can be connected to an external PHY or use the internal PHY.
In this gxl_enable_internal_mdio case, we are using the internal PHY.

Sorry about leaving this out in the last email and causing another RT.
I'm not very familiar with ethernet underpinnings so I don't want to
use the wrong terms.


>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

