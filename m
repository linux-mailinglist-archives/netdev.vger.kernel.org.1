Return-Path: <netdev+bounces-124310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C061968ED9
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 22:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1624B21B16
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F041AB6ED;
	Mon,  2 Sep 2024 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThvOHWdN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AFF1A4E71;
	Mon,  2 Sep 2024 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725308832; cv=none; b=YS7eUk6mN0+zmy4VjJrwi9tHs08gDXV4OXmgPLcOaJfwIerKpwoagVQNjylXQ0c31TGB/P87fplag8e2TFv19M8vRAgV8EfS63bgCdTc/aOcZxmilXbhSGcxqnB8lUm9+4PPjZfoQtawWyaX40mAJuoi4zoYFyVdNK90J1lNLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725308832; c=relaxed/simple;
	bh=sbASA7/1FBn9KOAbGmPoUmzWkGeBV9KBUp9kKbirgm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PW7/Hje3YbYbH6UXc0OltEvzHsne5glQVlij2a5051PuVh8wl/GCzCUxntGRrz5498euD1Rc8tglcLyuNT176lMG9/sEESMWiwnu/GUntSy0P1kdH31B2pRUXJddO+zf0e0a7B/cGh7mAZ6pI5qX2cJgV/7CDwH3ldsxtd3xoNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThvOHWdN; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6c91f9fb0acso38886687b3.2;
        Mon, 02 Sep 2024 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725308830; x=1725913630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Nhr8HkfR0QyBLpZ3kQVj2wTpnEp2kTEBagtzh8X6A8=;
        b=ThvOHWdNv8FV9bUr/KdVF3s2m1vu+2SyQZ09cwa3J1HIeJ9y7G1aSq+16Q9Z69tQsx
         j9AyJRLzgAGIioKpRVyZwkJ9HrQkkFixbIhK8SdQAXGcol+0ewN5/zFXpe/2s1+xflrP
         EmrAoQbf3Wd+FjU4K+brFGg4CL+rFU9neV+0X65H8k+5t/sNLYpqLQcRAZSNDalEXq2S
         /4e+pwTSKZ1kVBSUMLFWDgr0najTzWQoO+2Ao3NIVR1/JxgD6szqrjggrj9HIkDKzFfS
         AqZQYXO9RnLgEo10s+vXHFweeu63hSgI6yY1ZzPPZ6Otn3sOrwJQKrxIFSxNkw5pB/+R
         EQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725308830; x=1725913630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Nhr8HkfR0QyBLpZ3kQVj2wTpnEp2kTEBagtzh8X6A8=;
        b=h9XxYfc94JT4sUa81etd3s1Trpjv89HR4itYMxccwOjgFw9ktEn9MiTg1NZoeoSQe+
         Jk9aQLk4fabdG7KheUy3JZ5d/FkTqh/+3/9+IpEv8vHThudzbbMe2AQsawp90AUkNUp/
         PYHcxGz13XNJcurdR3uqvPLbQfBgQwJT1/7R6LK8PARWAOR1ngnUxNLvKYi9AJj3WOgf
         hQGK8Gd/9RRQXQrz2HLwZpIxddKp62doC2w5IvXWcebnZGU35/bGYElKEGHgmm9wvGtq
         dP5OG0NRfPsO/vQFBB/l5un8WEERtolqnk9yA/PFQxJncvWC9VG3rAEqL3YIJpIcAkA/
         5Bow==
X-Forwarded-Encrypted: i=1; AJvYcCWou3uW62zUp/+pwwuBq2OV/sIa/Dp9XmMnWZRUITcpXlvb5sEDlLTZwQlSCk318daO8NVNkf0KXO0D+I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5Bd9RwA7DzrX5UsOZhPN1V5kWbD+a4RNdpbySW79Vo2tlLgH
	PKBKG6k3wJ43EyFNvmdIVXEaj9mW9xqWhxsXNFMlCDw6/z3MsD7IpL9KgsQ0jEym9ZahHufOqJT
	gTgJz0Mm5izMNpaH/+L0gvaTEh8hxgHBg
X-Google-Smtp-Source: AGHT+IEZQ5qUyfI55kLTZv3NvcIaMHGMClHmdfI4Ui3qizjSl71HuBAas8vYGUUoa9BF167ktTnf1Ay66lSb2AfnkAw=
X-Received: by 2002:a05:690c:4488:b0:6be:92c7:a27e with SMTP id
 00721157ae682-6d40f928720mr89282167b3.28.1725308830175; Mon, 02 Sep 2024
 13:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902181530.6852-1-rosenp@gmail.com> <20240902181530.6852-3-rosenp@gmail.com>
 <7812014c-a77f-441c-bcab-36846a3037cf@lunn.ch>
In-Reply-To: <7812014c-a77f-441c-bcab-36846a3037cf@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 2 Sep 2024 13:26:59 -0700
Message-ID: <CAKxU2N8TsYHvM7a_Dhu34xHbvrWev9eL8VOa1JZcu_naW3fwjg@mail.gmail.com>
Subject: Re: [PATCH 2/6] net: ibm: emac: manage emac_irq with devm
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net, 
	chunkeey@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 1:06=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Sep 02, 2024 at 11:15:11AM -0700, Rosen Penev wrote:
> > It's the last to go in remove. Safe to let devm handle it.
> >
> > Also move request_irq to probe for clarity. It's removed in _remove not
> > close.
> >
> > Use dev_err instead of printk. Handles names automatically.
> >
> > +     /* Setup error IRQ handler */
> > +     err =3D devm_request_irq(&ofdev->dev, dev->emac_irq, emac_irq, 0,=
 "EMAC", dev);
> > +     if (err) {
> > +             dev_err(&ofdev->dev, "failed to request IRQ %d", dev->ema=
c_irq);
> > +             goto err_gone;
> > +     }
>
> Is this an internal interrupt, or a GPIO? It could be it is done in
> open because there is a danger the GPIO controller has not probed
> yet. So here you might get an EPROBE_DEFFER, where as the much older
> kernel this was written for might not of done, if just gave an error
> had gave up. So dev_err_probe() might be better.
Good call on that. In my experience, I get these EPROBE_DEFER errors
on OpenWrt's ath79 target (QCA MIPS) but not on PowerPC when trying to
use GPIOs. Nevertheless it seems to be good practice to use
dev_err_probe anyway. Will fix in v2.
>
>         Andrew

