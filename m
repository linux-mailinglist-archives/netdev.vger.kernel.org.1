Return-Path: <netdev+bounces-233670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC91FC1732E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B2F3AAF80
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 22:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2B93019C8;
	Tue, 28 Oct 2025 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaUE9yPk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8314C2E0926
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761690770; cv=none; b=MxH5O198a5V3Ua+p17u6xdB5lKxlRp3yv2pxoT4o1I+dL0uSqWnri+Ag1j3oKvYBhnv71ByEqMCn1DkxJd0D4Os3/KfUs7rRKaMVomDn3rBjVNV6QAS+LbbtTAmy/qCL8YaQ6QP5ntH+dorcizb39FeW5NuAgzo90aqe4Mh0fjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761690770; c=relaxed/simple;
	bh=0vXX3n3Rz31dv6N5IEsxFdgPcgYtJTn/+3tsPomFM08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UyiCYwJNI2EgyEbQn3LfPG/egssz4Zs6wsOcMpmBGnO7pwy6amzSrPKsYnI5laflqdS4sE5my9pf/I1Dr3rwqVtW4K6SaVQIpQq0W7wgx/wZr2ozfh4cZwc8l0OtnSYWFXwI8ts6kZz9hGR1lXTDattgFb1dha2UUmSXNeZrr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaUE9yPk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42701b29a7eso188968f8f.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 15:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761690767; x=1762295567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRvx3Ot0WJkFxKt4jg5l9lhpNEvpdL9WnUMypf2gXfI=;
        b=QaUE9yPkSicTGfoDe2ES508j9H5qTJLC3gqrk3bRvBu03JdGls+KFYL7syJnIiuZxB
         1XygEL3O7YUl/mdjGnUqbPkZA0LsXVDuCgGRniVE40Waiwe1MQCZdM7niApTD0ncOoGe
         o1V9bwSpbbhlIt4e/zdEWfraFA3zeJ63S8/KBqDBxHj7XL0ANZENt8NW5DZZauzsSBql
         4c4T4zlkGvEjPOgi9x+BXCocgig2X4GfF/uN+mvbqSNNTP5LWxEsC1Vo0BWBJWdx9dPq
         LCJFTR7xGR5hWEHrxBtG0XkZ0ASJ387UVXc+F9RRd1XIZwt1H/87lWnYhSlBTMAEmTGH
         vBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761690767; x=1762295567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRvx3Ot0WJkFxKt4jg5l9lhpNEvpdL9WnUMypf2gXfI=;
        b=AhAGL5oSffro8qUyfKnTvD6T7alyJ4K8QRngZMS5SUBxZ4A4CJGu+CKpr1Npx6XBd8
         rBAf8eWutrJuk7WTSeOjByP9DNqyzzVNSefzkYH+nN52/NTGbAgPwsi+AqOH+iWBTAg3
         /n1hfMVc3OSzcUqiK8fnHE8vll4pugW17D9L+M2tLnBx5Rg0F2vLxitek1tXQgZvyBxO
         +RIwN9RRe7dQdIy73t9oMSnnHfYJ0+M3An/KcLkWDoj62BItmOOoCCIHL5UvGaMMu67P
         UJ/K9K/2Q0B3F0+jPp0SnAOOECzP0ck9YzgBaKsifAMTcda/TjwiPWXWPN8WYSoQFXEF
         qOMg==
X-Gm-Message-State: AOJu0YxpoRMB1PrSD5jrhTbvpQE8RcgPTTIJO7wvRBySSa6o0esiZySk
	anxXhLd7FEe891+OivIuQmhSzVK9oal6loRyzM4QPXjZqBjUXX4QQ1mEo+SINPHAb9IqlxtF1Pj
	+o5xfaaDBJwJuA6GSOTXQTKvHmchktSo=
X-Gm-Gg: ASbGncuc1MntzJngGwrm2t1qQExSgJUryfkQ491qKG/RBbsEa9Q7/1X9qExnTizLWc8
	TnHPFUQAWG0CTuGBtAekU+8ztQUMVzjMqQAw965Dixfa3mNfQXfNa/wfB4toxV6HsCscJI4kMH/
	7EX4jgMnuSpCSPlfG7n7ERlNmQftZ/gR5wMP1ltLRhh/bmNZCX23Ih2JriJiQSbGhIw3c8P/HHS
	K1vkuDBs9rWTN7x4rBXmEbLiPdwJQZ31jvgFF7RcoQn0naJyg5ycbYfzRox9Ghmk7Av1QA9m5SZ
	zj8pNXuIMl7x9v7hbQ==
X-Google-Smtp-Source: AGHT+IEUY0tOtqUU9ASgI8Aq3Y/MWWJHS6hPVGWOjVxjxQkh0ztJ602plTkTw/nGfCPbQfNZYtsxrCAf1e7HoZbl0aM=
X-Received: by 2002:a05:6000:18a5:b0:429:8c43:4b93 with SMTP id
 ffacd0b85a97d-429ae8dea01mr906065f8f.4.1761690766668; Tue, 28 Oct 2025
 15:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
 <176133848870.2245037.4413688703874426341.stgit@ahduyck-xeon-server.home.arpa>
 <6ca8f12d-9413-400d-bfc4-9a6c4a2d8896@lunn.ch>
In-Reply-To: <6ca8f12d-9413-400d-bfc4-9a6c4a2d8896@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 28 Oct 2025 15:32:10 -0700
X-Gm-Features: AWmQ_blPtcB5UjNOelyqBxw7ATc96-JPJ3bAkgZZURaAy0tpXoNN3dh23LzwWNA
Message-ID: <CAKgT0UdqH0swVcQFypY8tbDpL58ZDNLpkmQMPNzQep1=eb1hQQ@mail.gmail.com>
Subject: Re: [net-next PATCH 8/8] fbnic: Add phydev representing PMD to
 phylink setup
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com, 
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 2:02=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +/**
> > + * fbnic_phylink_connect - Connect phylink structure to IRQ, PHY, and =
enable it
> > + * @fbn: FBNIC Netdev private data struct phylink device attached to
> > + *
> > + * This function connects the phylink structure to the PHY and IRQ and=
 then
> > + * enables it to resuem operations. With this function completed the P=
HY will
>
> resume
>
> > + * be able to obtain link and notify the netdev of its current state.
> > + **/
> > +int fbnic_phylink_connect(struct fbnic_net *fbn)
> > +{
> > +     struct fbnic_dev *fbd =3D fbn->fbd;
> > +     struct phy_device *phydev;
> > +     int err;
> > +
> > +     phydev =3D phy_find_first(fbd->mii_bus);
>
> phy_find_first() is generally used when you have no idea what address
> the PHY is using. It can cause future surprises when additional
> devices appear on the bus.
>
> In this case, you know what address the device is on the bus, so
> mdiobus_get_phy() would be better.

I'll make the switch then.

> > +     if (!phydev) {
> > +             dev_err(fbd->dev, "No PHY found\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     /* We don't need to poll, the MAC will notify us of events */
> > +     phydev->irq =3D PHY_MAC_INTERRUPT;
> > +
> > +     phy_attached_info(phydev);
> > +
> > +     err =3D phylink_connect_phy(fbn->phylink, phydev);
> > +     if (err) {
> > +             dev_err(fbd->dev, "Error connecting phy, err: %d\n", err)=
;
> > +             return err;
> > +     }
> > +
> > +     err =3D fbnic_mac_request_irq(fbd);
> > +     if (err) {
> > +             phylink_disconnect_phy(fbn->phylink);
> > +             dev_err(fbd->dev, "Error requesting MAC IRQ, err: %d", er=
r);
> > +             return err;
> > +     }
> > +
> > +     phylink_resume(fbn->phylink);
>
> When was is suspended?

We don't use the start/stop calls. Instead we use the resume/suspend
calls in order to deal with the fact that we normally aren't fully
resetting the link. The first call automatically gets converted to a
phylink_start because the bit isn't set for the MAC_WOL, however all
subsequent setups it becomes a resume so that we aren't tearing the
link down fully in order to avoid blocking the BMC which is sharing
the link similar to how a WOL connection would.

