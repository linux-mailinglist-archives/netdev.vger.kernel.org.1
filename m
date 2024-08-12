Return-Path: <netdev+bounces-117873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD5894FA56
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 01:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC58282A12
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 23:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B6F15C12B;
	Mon, 12 Aug 2024 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdLeW696"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE647E0E8;
	Mon, 12 Aug 2024 23:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723505721; cv=none; b=fvB76osMMlec7/cUnVEqJ8W94Ru7x9ZzuLZFSfGV4g5dcoBJ1zBSU7RlIg8gRkPRe4pTDxDVPw4tNgDaOYXD2y82a4dx2RlINWEGqd/UL+PSIK/XU9P0wCZry2JmEywIOq31LrfNqQ5N0422HW5ZZ9Fjr0wERzDuuhqf32mV+lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723505721; c=relaxed/simple;
	bh=w2P4mB9qfIgkYgWcB1VPu+41w5OKZahvx5C47+aTTfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tw0poDibcTlm6v06N4IG97S2jKdNZIxRrFtFrMiCXkLUZ1GIdL3mKyhoD0KHOQrK9mhFsxiqR7InjuCops/q1UqwjDoUpSSl2gLk8ytx8ORZKpBDztELmo3R0AghCM2jCBhSpjY0rw9OBeuCS2oTQ6WcC4yGoNcY2i5lvrCkZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdLeW696; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-66599ca3470so47036287b3.2;
        Mon, 12 Aug 2024 16:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723505719; x=1724110519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXbxLiY0DFig1x36d2vGcHyedVdpa1QHU4qAQbXaCYU=;
        b=cdLeW696WuzN3+b/ziSzJ6cvZ61QzvB5vSsjW01g5SJ4eySpnFjP5OjlyvkvROrx9t
         x6z/spu8ef4InYyY//3Y6L0AllJaEtgNCBgGsixR45xHqQqV7dJryz8hoQL6EfdLC6kJ
         GPIXmcgvHYt0P3/1cw2aAVhXRSiTlJhbQzQjpogu2mRC56O2/jLxiEx3A8li0OEEl+Fc
         zMQ3U+KeYear6EL3VUYD7lvSD4m1w1nUdKOLNvoJ+WCoKkPS3wBHDy5CJjAd0BawEjnK
         ViSxrrLK1tAaP5AK9t3DDkoWqM6u3SazUQLsp+nmfCZdqiiV51I+kk6PqsnF6XkL5CD3
         TZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723505719; x=1724110519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXbxLiY0DFig1x36d2vGcHyedVdpa1QHU4qAQbXaCYU=;
        b=D3vmv+Q1QktJ3SwQz29/6QcT8Rj+eYY/LHPuvbqTklQMgBl6/CozAebnzhza1LvvW7
         FZo6/EriXT9c3kw1sR8Y93BdjDIvNo2hAFMSXx0RXcKwu/Ri8ROmHWVtdnFJiNnAoLRK
         mJtxkDfhIMuChbZRK+f0nUe74ispcUxVq3R1baQ7uOXxKrQY8/6ivhBMwV+d+14aoFKN
         YA5mZMsfUNnzJPT0yn0H0WQbF9/9EuK8YhaC+Aa4OzDdGz+OZREzahf4okbLhrrsuig+
         /HsKoQ5rCBgYKxgAPc6zgRI36sItW9y8lsHPThKNsGbmHaJ+XMeqrYjpHOvIJGzuescl
         AMog==
X-Forwarded-Encrypted: i=1; AJvYcCWfzbbAwejLQH+D6XkSVK/nCJDFYDY1QkIi0LLhzHU1nQVEKnJGApAL69J2rmFBryDZ9Vlsjamz7inqD4/B1GzhFHwvKF2e16R5mEV6
X-Gm-Message-State: AOJu0YwX3BG2mEbd77s6GzY0tiH8fabPmB4aqCtLuVgh5h4GxhCRNbSC
	i3Af88ny8l0Gk9UW3j5AIWyP3X7/jEy1HhLU6Dg+6OW1e8kYAsJTOspThHTePobY02pCI16Tj0Y
	eJOAox4XEle+2v70E6/vb7JRcCPUDLxgCJG4=
X-Google-Smtp-Source: AGHT+IHgC1shSW4zl4x4Ao2zQr9xrmAQr0OhC/u4E9RM8FbZSXpXhk6hGMET5EVYAA+JuydiDT5iVuCrpbA+9fjDTFA=
X-Received: by 2002:a05:690c:4249:b0:61a:d846:9858 with SMTP id
 00721157ae682-6a97285f92cmr20936607b3.20.1723505719072; Mon, 12 Aug 2024
 16:35:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812190700.14270-1-rosenp@gmail.com> <20240812190700.14270-3-rosenp@gmail.com>
 <ae818694-e697-41cc-a731-73cd50dd7d99@lunn.ch> <CAKxU2N9p4DrbREqHuagmVS=evjK48SWE5NM3RbD5zF6D-H93kA@mail.gmail.com>
In-Reply-To: <CAKxU2N9p4DrbREqHuagmVS=evjK48SWE5NM3RbD5zF6D-H93kA@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 12 Aug 2024 16:35:08 -0700
Message-ID: <CAKxU2N-2M_tPK5mJjhgfn8vW5qH6ts5o3sxzrugK3BdVee_XWA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net: ag71xx: use devm for of_mdiobus_register
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 2:35=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> On Mon, Aug 12, 2024 at 2:28=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrot=
e:
> >
> > On Mon, Aug 12, 2024 at 12:06:52PM -0700, Rosen Penev wrote:
> > > Allows removing ag71xx_mdio_remove.
> > >
> > > Removed local mii_bus variable and assign struct members directly.
> > > Easier to reason about.
> >
> > This mixes up two different things, making the patch harder to
> > review. Ideally you want lots of little patches, each doing one thing,
> > and being obviously correct.
> >
> > Is ag->mii_bus actually used anywhere, outside of ag71xx_mdio_probe()?
> > Often swapping to devm_ means the driver does not need to keep hold of
> > the resources. So i actually think you can remove ag->mii_bus. This
> > might of been more obvious if you had first swapped to
> > devm_of_mdiobus_register() without the other changes mixed in.
> not sure I follow. mdiobus_unregister would need to be called in
> remove without devm. That would need a private mii_bus of some kind.
> So with devm this is unneeded?
Just checked drivers/net/dsa/lantiq_gswip.c

This seems correct. Will make the change for v2.
> >
> >     Andrew
> >
> > ---
> > pw-bot: cr

