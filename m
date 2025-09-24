Return-Path: <netdev+bounces-225954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761DBB99DC8
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 14:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8A416C4BD
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 12:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3522E7658;
	Wed, 24 Sep 2025 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKFN8r8p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF859155A30
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 12:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717275; cv=none; b=oM3eXHZzdx30KEegUHdvpMo9YQXBs/HMmp3if/RnoCYVeh6Xy/u8OL0/tajBbLPa4WDxh+XtCj8FL6y7oepV3q3LKdPO/AjdjICkh/MXVyY3027xd9yy6jrH7plQHbHQFJnGFAtPPuhrMOWQndDMOTS21IUoq5dSq1C4G7xQ2kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717275; c=relaxed/simple;
	bh=w/Y7hFj+095plLmyj6F//RB0JJaVllnXem2h/GAL5DM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fT31hWZqgmi+mw0XTyHpAImdPqTSAZebYLnCYAl35eQCyKmxUjVlKOLpKtZPcdQu3m2nT+bcXBOLGQ91wJQS4sb2YVrlroM3e12IWdoInn/VViK8n6evlrDrh9Z5eKOwM1A0bQAP45kK7VRBEn6GDkOsvav/nj7bSptHHbqEmBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKFN8r8p; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77f5d497692so1882215b3a.1
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 05:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758717273; x=1759322073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTDFZgAdQghFMqYnaQQne0DSQg8eYDQbEUoZypuZEl0=;
        b=nKFN8r8px+pzegy2l8GzbujA3yONawgNDtwnTyjN3MVG+becplTcAFlrefsHstjep3
         Uub109iAJRU1KOEBZRFhm0MlO5B/XDZ5204pKV5O1S25FAmW1hjAuKLsZY5D9yBOgue1
         wzQzZpyoAs3gMYfKOBD0twEMueSvXUHwcdvVcfy/Venut+jIUoEBvOw0k88ejbw3FyaL
         OXjj5SaAg5Axb1gReX4SUBHgktHAlvjF6sQQatvc5qdtB7sraWLw5SR+ezqLf+E6B1oy
         GPhrXvwiHxtcwplCpwNX4Nupiar2cWlj1pbTEcCXNi6Pe4jSUNFvZfNpRgbj680D9TDu
         /CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758717273; x=1759322073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTDFZgAdQghFMqYnaQQne0DSQg8eYDQbEUoZypuZEl0=;
        b=oN3LRuMhPPRknnEbCwFGZdyfcCoPZuMhm/Et3kC15pS83fK5Yvv6M9EaUqqyH7NDqC
         njQa0VgzEdybqVUTTthPuoCX5ZHEbcTZdsPnNiqEFhYEwcFiE1IXmTTnCxm17XdWw7Ds
         2Ip3LitHkDTO4FImbjP9Ot5TkxJ4uRx5iq1hBKda/ykBm0FcYHvGKg0v3EEDoXwifGkB
         SrVb4CTlFuSHfUS+P5G8u88iOvPSSi8cg7n8ZLzg3Cb9KXuNAxIxiCvM/J7edY/M9UK4
         zsujpD1OiV+hXSnIzsBkxwC85q6ass0J9C3KHRsl7EE9X7WfxWc+LyA7L08Iv4mV8usZ
         LdzQ==
X-Gm-Message-State: AOJu0YycNGlCSqMJR4o/NOpmwzUTEz2o+FB5a81YYGb7BE4iPHe/qV6c
	x/JoOQvaSu5tjrW1iSxxMIJbVXG5AlR6AqRqPT77/b28jGi+x7wdcoYvpwPL5b1sLhiqrLonK50
	+BE/kgbeBAJTOQvUhD+Dpmq75aqPqum0=
X-Gm-Gg: ASbGncsvxCONq1fQGtzA41cOWRgIlQh3LF3RJTa+YsGCHW/shTWyoO8pg8/Ug6QKYg2
	fb5XFmkgRB3l33BOkesvE2Q7SeAMoNd10WawIuY1T0qfrSflE033qBFMCpmizV1IKnt6UT+N8MY
	JcBHT9sZbWVv9yXGwFTEHASx/klNoPG/3UQ1CPSjXMQ04IgKMs4e1XlxxFqrfFe7qadAiNYi4uj
	OU4VPHbvLinok8Ubj1M9WGbkJhbzLhfHbMQ6k+x
X-Google-Smtp-Source: AGHT+IHdx5C/tIG+bo3u5C0cXUba70Ijx6a94OsvdZgP19XusiUpG+AOBXv8usuNF4dJmHieFVzFc321rHyvoQrN75Y=
X-Received: by 2002:a17:90b:58c5:b0:32b:dfdb:b276 with SMTP id
 98e67ed59e1d1-332a98fc381mr6768390a91.34.1758717273147; Wed, 24 Sep 2025
 05:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922131148.1917856-1-mmyangfl@gmail.com> <20250922131148.1917856-6-mmyangfl@gmail.com>
 <20250923174737.4759aaf4@kernel.org>
In-Reply-To: <20250923174737.4759aaf4@kernel.org>
From: Yangfl <mmyangfl@gmail.com>
Date: Wed, 24 Sep 2025 20:33:57 +0800
X-Gm-Features: AS18NWBjGVWilxW3m5lF33pWes0iHg7AU_L8xzuQ8IGPKI3mtuMEre2fBRoTZXw
Message-ID: <CAAXyoMNBHgG-DFv16ua-T__iBXg=chFQ6TNoXdZvk4VP2aYESA@mail.gmail.com>
Subject: Re: [PATCH net-next v11 5/5] net: dsa: yt921x: Add support for
 Motorcomm YT921x
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 8:47=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
...
>
> > +static void yt921x_mdio_remove(struct mdio_device *mdiodev)
> > +{
>
> > +             cancel_delayed_work_sync(&pp->mib_read);
> > +     }
> > +
> > +     dsa_unregister_switch(&priv->ds);
>
> The work canceling looks racy, the port can come up in between
> cancel_work and dsa_unregister ? disable_delayed_work.. will likely
> do the job.

Are you sure about this? There are many others who use
cancel_delayed_work_sync in their teardown methods (for example
ar9331_sw_remove). If that is true, they should be fixed too.

