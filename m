Return-Path: <netdev+bounces-220098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D8AB44753
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D17267B5A6D
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A129D2820BF;
	Thu,  4 Sep 2025 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIok8wPH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151F127F18F
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757017849; cv=none; b=V9t9naNk90x76UxWRBYtEZ7B8CUseL7GBdNSm85vIwUlMkZhyMVf2f+0UkPNRz+na5KMflJTWd4Q1F74BjQ24RBz0yqxopJ6jyOAGFGW4Ycl6V2gsdtXPBhDvLuni/AbvybceJ5d/vx2AIjyIIVPlI7g1149iSdhKKNlBcqtZXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757017849; c=relaxed/simple;
	bh=zUsaPLYjf8SLwOttRNsr/L4u2Ljo0WcNY+axt8D24e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNPJHA7KcDU/pG7F1zxHz8GquTH5ZGVuoNeYxfeDItOCtfRjo74xEtPjYME0phPyNra1vxzPE1xdrGVGrlSOshERU3YhRj/kRor3Qx8DWyEgVX+Qgmj00Kzgevnn3X2jsQ4fSmcyPj9hg9uWAMOn+9PNnyMM51TArcgKVx0vuIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIok8wPH; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-724b9ba77d5so18025777b3.3
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 13:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757017847; x=1757622647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOHgCUl1XmDnVvwIC+Um9bZKXnrjGToMg4c/3lGdzvU=;
        b=MIok8wPHf7BauFJM0cw0bg10dMus1KkSq/m26ews/sBpbT9IMWefTsJ+OTRdneDsaA
         /DWpS/t1uf1m9e+KDTqVrrMlEEooQmzEFY3iR4fbc6AqYwmRmOCRWUZVd1aomj2Sn+ln
         Aopvv5Sx43ekYuMoBk8AoKT046ULnNwPRUzaNxKswPgp547kDGHPEYdkeqqMZdGwXAPa
         L8FFxDclpOKr6yNi/HPE0TZ7i9oEIhCtQFYCsty8p7dbLtL1FEccd9Lp2VCihs3sP80q
         osxSI99kWb55WmGsziRyqeGJyrg9cF6v2GIQzkPpzzfi240Riuta2eEEkk0ZRUx+BrXS
         SzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757017847; x=1757622647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOHgCUl1XmDnVvwIC+Um9bZKXnrjGToMg4c/3lGdzvU=;
        b=XlG7FWMEGTwwB71yAnkiS1qgPYIzNbe7SojKTE3HxerM1ea8blubivfjykRXxxVNuj
         wI5SraJDZQ8vj7RKEHXX6rOO6ssscVAIBb1L1XiKEZ28i/jNzRfc/big5Gymh7GZpJbX
         vBO04KnYj0geAjW+wYeAfV0wv5Wh+HBQ0c11W3LCcnRHgFZs+gZSaDqrKJ4lMigLqKSZ
         rP15SI6gBORKvoyK+n+WNDfIrP9/mbOs9jpL4iPdcxT86vHtAoGn2jjpoIk2HYHNJFed
         HUGWihxt8eYBd646e3oimhzxymqbCuCMYAwITTqSVvqPGp2XhwotBDt2JIah55IUzJbr
         z93A==
X-Forwarded-Encrypted: i=1; AJvYcCVLGbP6b1TRbxTkLgo5o7rxHZgalimI7cxKpOHFejZZ/2LLNiCh1V7/YNrQ2HXPshoLRiMdzbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Il1bdVp/ETVhJCg+5PQbo2ZNSSYVsMZ+wZaHQEAXfuq92LQE
	GURrJFY/OccmLiq84hZKFBymtbkAzpb4csZOwEARDKvebDHE7h3lWYP6C4bf7mo63FRriipkKF/
	NBPKYb+/K9W5EH/M4O6v9mYkT9ymIogs=
X-Gm-Gg: ASbGncu/6PTAM6iuy76v5psrl3LeT0K31X4T+CryzWq/MEn/U3k4DYB9z+ycxRTbfIt
	cJZVp+HFdScX6v7END4bH/q3o4YPeKH4ltAb32w/halBd2SG93zzJVHng8QZR0bLK+QhDYsRsaM
	8deltqNXPcVXUW2FuBsG5L58WaxtVi0x3CboFWbtUO1014ZIyqI5DScMFrkH4ouRSTlIwRnsXNC
	SaJOgeh9A9eGMUwH2jil/zGWt0ysF+BYWkIWNxMtZgF/iMhziqV7GEwMkznjyddcfJKghx38tVa
	RZ8dZT4cD46WjNV2
X-Google-Smtp-Source: AGHT+IEGKogGosca/TPXOn+3IVuQLyHBXf+wxtH6uKn5dVO5gedb1SDbgpRIRPkz8pAc9Pj6mU4DYCNF7YWxfqst1xc=
X-Received: by 2002:a05:690c:9c07:b0:71f:ab32:1e1 with SMTP id
 00721157ae682-7227635d16bmr274728687b3.10.1757017846930; Thu, 04 Sep 2025
 13:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901202001.27024-1-rosenp@gmail.com> <20250901202001.27024-3-rosenp@gmail.com>
 <20250903165509.6617e812@kernel.org> <CAKxU2N_RaPLj07ZqxtefPUJCnRbThZjKhpqfpey9QB2g3kNfsw@mail.gmail.com>
 <20250904090056.q2w7ufpnkx33leab@DEN-DL-M70577>
In-Reply-To: <20250904090056.q2w7ufpnkx33leab@DEN-DL-M70577>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 4 Sep 2025 13:30:35 -0700
X-Gm-Features: Ac12FXwfG3ca_lyyd2sRuneNSXRG583tGl1z1LY-lMfKUp-qkQvhdCrGd5buLdY
Message-ID: <CAKxU2N83hKCYbxoFkGUSNMW1k-skCpksQ_eDzPACYEFXP5Fb2A@mail.gmail.com>
Subject: Re: [PATCHv2 net-next 2/2] net: lan966x: convert fwnode to of
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	"maintainer:MICROCHIP LAN966X ETHERNET DRIVER" <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 2:01=E2=80=AFAM Daniel Machon
<daniel.machon@microchip.com> wrote:
>
> > On Wed, Sep 3, 2025 at 4:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Mon,  1 Sep 2025 13:20:01 -0700 Rosen Penev wrote:
> > > > This is a purely OF driver. There's no need for fwnode to handle an=
y of
> > > > this, with the exception being phylik_create. Use of_fwnode_handle =
for
> > > > that.
> > >
> > > Not sure this is worth cleaning up, but I'm not an OF API expert.
> > > It's pretty odd that you're sneaking in an extra error check in
> > > such a cleanup patch without even mentioning it.
> > git grep shows most drivers handling the error.
> >
> > git grep of_get_phy_mode drivers/ | grep -v =3D | wc -l
> > 7
> > git grep \ =3D\ of_get_phy_mode drivers/ | wc -l
> > 48
> >
> > I don't see why it should be different here.
> >
> > Actually without handling the error, phy_mode gets used unassigned in
> > lan966x_probe_port
> >
> > The fwnode API is different as it conflates int and phy_connection_t
> > as the same thing.
> > > --
> > > pw-bot: cr
>
> About the added error check - I agree with Jakub that this deserves to be
> mentioned, and should be a patch on its own.
Sounds like a fix for net instead of net-next. Not sure how that would
work as both patches would conflict.
>
> I did some testing on lan966x, and before the added error check, it was
> actually possible to omit phy-mode from the DT, and still have a valid po=
rt
> configuration - but then again, the bindings documents phy-mode as a requ=
ired
> property.. maybe this should be enforced in the code.
Absolutely.
>
> As for the fwnode -> of changes, those looks good to me.
>
> /Daniel
>

