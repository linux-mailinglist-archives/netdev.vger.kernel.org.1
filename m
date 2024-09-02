Return-Path: <netdev+bounces-124309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA0A968ECF
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 22:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE790B21816
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF5D1A3ABA;
	Mon,  2 Sep 2024 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcYo818K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776181A3AA5;
	Mon,  2 Sep 2024 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725308453; cv=none; b=PwgS0gy3S/vj3A1u9OlSyOvar5y7cbvbUZ+TPV/dAaM0kD25brZW/nTNFFhHWPeSy+c7MgCE+yrUDtQptqj3FjnaRhiTPGrzkfUkv/2p9y3wlD31IOUepEdh8fZplGt2CoqaBWkyYL0KzFgdAJw16K0Grj4eBqR+tii8ZIK0l04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725308453; c=relaxed/simple;
	bh=DDS797LPSLXF5DUZhvSIXvhnmOVCbd+FC0JxJqgvan4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpmxzc0U5uPRSLX+hz85I/6DGgfkHzcOAKZVHrL5IjZMe80Y0509s9g0NOULWFEyguvgmtpDIw9/a6P9acSH5/M7Tgd199mVSTkD2QCo3Tzp76p5Jeny9OxROk/UZvxTTZ9ptiRFYTpVUTHqdoRJ03Y0lDUOxEYxO5v70KZd7mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcYo818K; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6b6b9867faaso37889717b3.2;
        Mon, 02 Sep 2024 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725308451; x=1725913251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6ZoJimyI0+j3EAlQIah3fNwK8Zs3ud4jfbViwry4E4=;
        b=TcYo818KR5xi4m4u+QRlq/S/ZLlbhcYfebhyLKjISv+b8fm/oFLK/EOx+6Nxdob9Bs
         mFaZUvySowBveFX8NocqbHakHLQ8We4T5RXrNA0TBuR2IvtCMs8jX90B+UtKKKEO3/2p
         Ficdnpvpq4wHnfWh62aAR3vZ+H1w5AqhtUzn6jSBH/ON/+iTPI4MX9QbY+7VHlTeULcM
         pfoWg04J4wfoD1WfZQUe2VkV6YPAQ++AxP1rCLRL3u4cirR+Z2ox+1yaTwMPj/vJ2Vx2
         UZJX2+5KSo9zD3n6L0FWOX5mX/B/apFvlD8xRZo/2v0Q9HX5n/cdOPS8GO7hD1vSAeh/
         Zn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725308451; x=1725913251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6ZoJimyI0+j3EAlQIah3fNwK8Zs3ud4jfbViwry4E4=;
        b=enMvMFKfYYEIhWXcPrqiUhkN5PKO5nqCDbztMrXsAlFmPN+lQP4q4gHcvQBXasBbrm
         MDQZnvMyBwVw/Ir1Mp/1areQLCUWgc3xWyyHiRnfuLyMqo3J2xJ5I7r6uBFMm7TdJtby
         XA5OH5wILAalPP9ZAW+ApRyj7iDPwD6eMi7Xcfp6b/bk45ME8hGc3K02bbSSBqUml5sH
         ODmXhe5f97axODUctt7Wx87yOwsjsQMmXqZcw+oiuk0/kQa5t3huEGQN9AbVt1nMMUch
         chDlQiBhoF5WtREw5+Dcd4lcALaitx3dyF9Stv1g7hVZM1625mBievcJR9RPZLNpe69P
         cVOw==
X-Forwarded-Encrypted: i=1; AJvYcCUvd5Pjtzw25meQKQsVTUGyNeoXP2SFIYOHr88c+s/KjsQC+xL/sSndErOS+VIqTTosKROskfe39SieP/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxnzvamTp4XJN5afIX+GJmTgBVPhWgUczwn1qxetoftgz2qa1M
	VBBhl7rwZaYGk0KRiFTqxeSNckce1+Ok5ZtTGlLJ7qK1DWMB8OCB1xZC/jZiWNkdrQlpYY1SVjt
	PavQVzgkq2FUkw4QIQXSnYY6Gqcs=
X-Google-Smtp-Source: AGHT+IGFIcrYrJVdstJYct4Tsj+HXJHCf1NPVbRfDXsdPB3uYZOllkLDC/g97W17XEYxjg4ZWz87oKS4dDT7B7VpHsc=
X-Received: by 2002:a05:690c:6583:b0:62a:530:472f with SMTP id
 00721157ae682-6d40f534326mr130482947b3.32.1725308451409; Mon, 02 Sep 2024
 13:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902181530.6852-1-rosenp@gmail.com> <b149c9cd-a76b-4fb8-b3ff-430afa8fdd77@lunn.ch>
In-Reply-To: <b149c9cd-a76b-4fb8-b3ff-430afa8fdd77@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 2 Sep 2024 13:20:40 -0700
Message-ID: <CAKxU2N8D3JCjGkgbxwKOGyb7Nd3QDeAfEMQfCGr_EODzPrV9Jg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] net: ibm: emac: some cleanups and devm
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net, 
	chunkeey@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 1:00=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Sep 02, 2024 at 11:15:09AM -0700, Rosen Penev wrote:
> > It's a very old driver with a lot of potential for cleaning up code to
> > modern standards. This was a simple one dealing with mostly the probe
> > function and adding some devm to it.
> >
> > All patches were tested on a Cisco Meraki MX60W. Boot and
> > Shutdown/Reboot showed no warnings.
>
> This is a 12 year old PowerPC system. Cool you found one. Looks like
> OpenWRT still supports it.
I recently bought one in an attempt to get qca8k working on it.
Unfortunately the bootloader disables all ports except WAN and the
driver has a hack that disables MDIO 0-3, which qca8k seems to need. I
tried removing it but then mdiobus_alloc fails with error code -5.

qca8k only manages to bring up port 5 (WAN).
>
>         Andrwq

