Return-Path: <netdev+bounces-198105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE357ADB413
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A3B1716C0
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 14:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AC41F91E3;
	Mon, 16 Jun 2025 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4TXKn/F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D016C1F461D
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084788; cv=none; b=psk4YUFMViB1aG0hTNVl7rtKB2rC7FYPGkI1Ved2d9WD5CAhcXAbm7mQUVu/h2rgkXMh8YavbGHEs7Yc4Lj8b+g7teiXiBbice8Gkd/iFIQbL5R9VQNgusKhANp2aJM/pYBPj9UuDrSTqacazBjNpQKkIoED4SDVCcnG3f6O8v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084788; c=relaxed/simple;
	bh=aoWztmiuIJVUgdt3J+k6fHZeV8z8Tzk0Uzi/KJMUAf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAjID4KW6mXwPq4/ZNzkTvXFggWH039HwBxUBYHRJB8v9oSpY6mY1q028bkXZcJcVdjSYvtPnE5gwf/7sAlPewqkml3tRV7BUqd3V4Ipj8414srQKrP/NgXK41LWjZvkKeTpyXbBZIS/PUC04WWw79Ptjw7GFnRmLVW2BGPszy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4TXKn/F; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so3661936f8f.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750084785; x=1750689585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoWztmiuIJVUgdt3J+k6fHZeV8z8Tzk0Uzi/KJMUAf0=;
        b=U4TXKn/FXMUY2roJrNBDX3earcSROdEkjrKzvCZHuaylXrgbKpYkqJYILA15p0kjm0
         Fs0qugTgsf0ma2Z+qQ/nTcxEZ5vwk3qHUKrn6geJIpaH4pm8WXLQB8M8tj/JV1ychXn8
         qUrxqvWrMAS/XpkOVU3gJU8j3VPJHavIBDavikp+QOCujFNo87uMnfg8hGEd697h2iyU
         NJWpICjKoNQ+NvNpPxD+GXDZqFiwxG6KyPLffzuzPThoZllmoR0pHkwkw2lPHM4AGVJW
         Y92eg4Jcu39bDb44HM+Y4e9+0akHXrd3aWWRvGtN23gbz2jCcSCjFtfxRqEIzeCfJIR8
         SeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750084785; x=1750689585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aoWztmiuIJVUgdt3J+k6fHZeV8z8Tzk0Uzi/KJMUAf0=;
        b=eGO8rfe7Vjh9df/D+A4UG31DEn4lQwVL6lTuORkvvLVr1Fwf5vZE5h5PkiQpYbKBfX
         O7RquiSschlDHH+ThhzfoxqfwnYSdk49k1OkMESSNsbZ23xHvYPtfMh1XhaQgyCLNBrP
         8pbQVqlYTSRs6eViaftZev/1veGrPsbgU33qCM8Wme9YKN3pUweAiEzg7pSs/7rybO/W
         +ZSdlktFuafH1D37Z59cPLRpH/rfdnbsUV/7kGoPxMF2LsJxc5Y/wnpe8Mg7hGdA6NwF
         RGSZleqYcR3rIa3wIbcB7kCeKE9PeSADHWQXyGH+vVeq9rZwY9svt2Yi8g30NLu9UwIR
         nlgw==
X-Forwarded-Encrypted: i=1; AJvYcCVVCKMuG8T/1xjjXBe9vcBfXZzj+olwfvK5id8R2v2/oG5YmXcsg9nXJOXtSPqTf5HHK/r2dnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO2J3HKsVXaMkL8FiPRhVNTP8/MpiB7Hp0vD6m5TnJGkg33qQw
	EGiaTbnIeJPNxBe1ZANfN9ch6OVYUzGiIU3hu1kN4mKLB6zPrdDN4VeecOBAlbEK2AjnqK1Mzas
	aNf4XoyVWIVunS+MQpnRvVMtH5+1H/zo=
X-Gm-Gg: ASbGncuiH9qDWoMLqUuliXfp6igEgif2sKWhTrHu82TYdWQKRKoZu4bdhNfm3S3wp6W
	ki3oj2wPjjN3WghH+EcVZXvKDd2ADWYliXF0JlD+YBlLhO1yGnpzB3eOyT8vBjfAL75YzWOu6pa
	4yzPi31qw9goq/nVWJlGV640/DVbvAeGU39ulHWjxnbINxS7joZhqI3Uj6+OovVZ5T63Vm9zpmE
	yUGYSE+MWSz5AI=
X-Google-Smtp-Source: AGHT+IGrxzFl9Ef7jrFY1jTfRxQR3oTuCxeLHVcutu8D5RCtTyCFz9gKHWLXlz3WRSZcbcUSRpi4xKn2MxZ0HYu3TYk=
X-Received: by 2002:a05:6000:3103:b0:3a5:2ef8:3505 with SMTP id
 ffacd0b85a97d-3a572e7d50bmr7127457f8f.37.1750084781845; Mon, 16 Jun 2025
 07:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
 <20250612094234.GA436744@unreal> <daa8bb61-5b6c-49ab-8961-dc17ef2829bf@lunn.ch>
 <20250612173145.GB436744@unreal> <52be06d0-ad45-4e8c-9893-628ba8cebccb@lunn.ch>
 <20250613160024.GC436744@unreal> <aEyprg21XsgmJoOR@shell.armlinux.org.uk> <20250616103327.GC750234@unreal>
In-Reply-To: <20250616103327.GC750234@unreal>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 16 Jun 2025 07:39:05 -0700
X-Gm-Features: AX0GCFujaOaWrgo2AU7LIucNdVrzn93X0B9_jeejYsLSy-AvGRUHpAe9u1jCfgk
Message-ID: <CAKgT0UfLCmZ9r6xqxH6NbOyVWJOMmVAJLEZwyCX41Hk99Tb=FQ@mail.gmail.com>
Subject: Re: [net-next PATCH 0/6] Add support for 25G, 50G, and 100G to fbnic
To: Leon Romanovsky <leon@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	hkallweit1@gmail.com, davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org, 
	Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 3:33=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Fri, Jun 13, 2025 at 11:43:58PM +0100, Russell King (Oracle) wrote:
> > On Fri, Jun 13, 2025 at 07:00:24PM +0300, Leon Romanovsky wrote:
> > > Excellent, like you said, no one needs this code except fbnic, which =
is
> > > exactly as was agreed - no core in/out API changes special for fbnic.
> >
> > Rather than getting all religious about this, I'd prefer to ask a
> > different question.
> >
> > Is it useful to add 50GBASER, LAUI and 100GBASEP PHY interface modes,
> > and would anyone else use them? That's the real question here, and
> > *not* whomever is submitting the patches or who is the first user.
>
> Right now, the answer is no. There are no available devices in the
> market which implement it.
>
> Thanks

That's not really true. From what I can tell the XPCS driver is lying
about what it supports and is advertising an XLGMII interface as being
capable of doing 25, 50, and 100G speeds. Just take a look at the
xpcs_xlgmii feature set
(https://elixir.bootlin.com/linux/v6.15.1/source/drivers/net/pcs/pcs-xpcs.c=
#L40).
Somehow it is saying that XLGMII supports all those speeds, but only
the 40G ones really apply. The rest are a combination of most of the
modes I am calling out here.

One of the things on my list to fix is the XPCS driver as I am pretty
sure the DW IP we are using is the same IP. It is just that nobody
ever went through and enabled the correct interface modes as that
hardware is somewhat hacky in that the PMA configuration essentially
determines what the actual setup is and I suspect we may be the only
part that is allowing dynamic reconfiguration of the external pins to
allow it to switch between 10, 25, 40, 50, and 100G speeds and FEC
configurations.

