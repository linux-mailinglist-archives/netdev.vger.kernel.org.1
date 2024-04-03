Return-Path: <netdev+bounces-84647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A11D897B10
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 23:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6B3B261F3
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 21:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281E815686D;
	Wed,  3 Apr 2024 21:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBB/bxqO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2F713665F
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712181114; cv=none; b=aJ9jwN3aNtPYlaNX0+W+OzDAr9Yby0Y5htHIqpEpfVIDUiQoPE9sl4mYngg1uzU7H/xk6Wuz4rE3888V5exdEa3kVhM5XrCdPy0zZEPJRDe7bgEm+9elh+OrwaKy3ZHNUR+aTU+WO71IoNV10nJ6/LdkjFfjWnrGb6wRpklX5B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712181114; c=relaxed/simple;
	bh=fyKapA1HMBhCyOGllltwnMDO3u765aeZYa51XzwbM+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7n88aCK5IC5eILydoqIKpim1ZINpy0jujp/U01t98gWCujzbLInTIEDhZFm24Vj2gKQEGRuJX87Tmht3zg+vqATn+uJZ+cy7V42qhmw7Rdj3avjHi9/msU0CEklFQ9xSYESomSQda+NFDsaFUsQcdeFuVBWKXJAIjRh9T9phe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBB/bxqO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33ddd1624beso158954f8f.1
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 14:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712181111; x=1712785911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjdddVKqTXG7wWiBCkK0CCy68yeZUeF6rbdGqgdnAeY=;
        b=TBB/bxqOfhwevTuO4rM0cXoR3Mqn55CSfqCiI4bhleDornwr0Z1xECEdRvDT39gpBI
         p+IPBdtfhJcegUDF6dSjfn6MNUPecmQtENDL2iKJrUxNn4Vm6ctqel+7UqXI0XVszwr9
         vyHFinPNfAxc+cTdstG8zb8/gsla7ZgauzwTHPtS2dQ2wsMmlsUKyVL2hTKZa2ZUx+YW
         QJyLctay3Zo46ln8tqFMj+6VI87N1C8zrfZ5dQ+iHp9X1SgvisIjgWTWYY5MSZRgpEmu
         4MaiyVp/ovPkJloVLYs41ZaUeZ0UC0+79Q+2alKlUWOFOzh9dOGwcHigg5jq/nip73U5
         oJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712181111; x=1712785911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjdddVKqTXG7wWiBCkK0CCy68yeZUeF6rbdGqgdnAeY=;
        b=J54AeGWIVL0bUJ1dmiYt7akEEEl844owwCXfuSsugAYiaw7aXXAvSEBjPwBZrCVxXW
         cl95jaBjBw2ABStv0ZBgUi/I/QQzwqceEfsrpyQmNCkSopIQG2Klewcw6BDhJ7Hzz82Z
         zMtEj5V0il71Nf72ZWiTQnQHMMza5Jtp86jhW+wAgkbTc7hqjiOra363YYzzQzr+l0bw
         X5FUT7Snl+ra6DL4U/hxAdoPPx5jBiVDmX9UstH6gUlZm29sGBpUOEXba8ifc8OOft86
         Lld9BX522k2l602TXXL/8OCuMdLmjAS0VMiQYd93/4UEvb/0fZ9iU/dDwtii2YcPX5R/
         lTYQ==
X-Gm-Message-State: AOJu0YwEydlizReaanx2CWXJDNmqgvpnC7YFGwQ6/SZJtEl7KdkTJ9Br
	NluMNNA+No6lmKloet2rVul6kVuf18mYRfvWIvKTnchVgYoVztyNT01WkCyULF51ynVrtU9eKjw
	lE+8tBLip8Ibt9nTqjVq+l2FR7mw=
X-Google-Smtp-Source: AGHT+IFxZSvr0U/dtrXGoV84s7/iZN8cl6+cI0oaf10rwTHtVA3u88LD4cw11iJ/SR4QbnB/SX7eCfNQ8w3HmLysu6k=
X-Received: by 2002:a5d:5447:0:b0:343:7f4b:6da5 with SMTP id
 w7-20020a5d5447000000b003437f4b6da5mr3027609wrv.17.1712181110624; Wed, 03 Apr
 2024 14:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217491384.1598374.15535514527169847181.stgit@ahduyck-xeon-server.home.arpa>
 <7b4e73da-6dd7-4240-9e87-157832986dc0@lunn.ch> <CAKgT0UeBva+gCVHbqS2DL-0dUMSmq883cE6C1JqnehgCUUDBTQ@mail.gmail.com>
 <19c2a4be-428f-4fc6-b344-704f314aee95@lunn.ch>
In-Reply-To: <19c2a4be-428f-4fc6-b344-704f314aee95@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 3 Apr 2024 14:51:14 -0700
Message-ID: <CAKgT0UeZ1zzJNOcTbiJYzG0_HeDW2jFKkSSSogR-gU+-mRZhYQ@mail.gmail.com>
Subject: Re: [net-next PATCH 02/15] eth: fbnic: add scaffolding for Meta's NIC driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 2:17=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Apr 03, 2024 at 01:47:18PM -0700, Alexander Duyck wrote:
> > On Wed, Apr 3, 2024 at 1:33=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > > > + * fbnic_init_module - Driver Registration Routine
> > > > + *
> > > > + * The first routine called when the driver is loaded.  All it doe=
s is
> > > > + * register with the PCI subsystem.
> > > > + **/
> > > > +static int __init fbnic_init_module(void)
> > > > +{
> > > > +     int err;
> > > > +
> > > > +     pr_info(DRV_SUMMARY " (%s)", fbnic_driver.name);
> > >
> > > Please don't spam the kernel log like this. Drivers should only repor=
t
> > > when something goes wrong.
> > >
> > >      Andrew
> >
> > Really?
>
> I think if you look around, GregKH has said this.
>
> lsmod | wc
>     167     585    6814
>
> Do i really want my kernel log spammed with 167 'Hello world'
> messages?

I would say it depends. Are you trying to boot off of all 167 devices?
The issue I run into is that I have to support boot scenarios where
the driver has to load as early as possible in order to mount a boot
image copied over the network. In many cases if something fails we
won't have access to something like lsmod since this is being used in
fairly small monolithic kernel images used for provisioning systems.

> > I have always used something like this to determine that the
> > driver isn't there when a user complains that the driver didn't load
> > on a given device. It isn't as though it would be super spammy as this
> > is something that is normally only run once when the module is loaded
> > during early boot, and there isn't a good way to say the module isn't
> > loaded if the driver itself isn't there.
>
> lsmod
>
>         Andrew

That assumes you have access to the system and aren't looking at logs
after the fact. In addition that assumes the module isn't built into
the kernel as well. Having the one line in the log provides a single
point of truth that is easily searchable without having to resort to
one of several different ways of trying to figure out if it is there:
[root@localhost ~]# dmesg | grep "Meta(R) Host Network Interface Driver"
[   11.890979] Meta(R) Host Network Interface Driver (fbnic)

Otherwise we are having to go searching in sysfs if it is there, or
lsmod, or whatever is your preferred way and that only works if we
have login access to the system and it isn't just doing something like
writing the log to a file and rebooting.

Thanks,

- Alex

