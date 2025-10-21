Return-Path: <netdev+bounces-231244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C0DBF66EB
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F7B0355815
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DE62F3612;
	Tue, 21 Oct 2025 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQxK/5Hx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8C11E5B71
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049548; cv=none; b=McZgOIYYFGMjDFVs0K52r4BpRXV+RnNbQ0Igr4E9JrV6ZTh4+7ZYEQo2B3DqVbm4ceq/9wemR8CCqnp5gPa0xZRz59Rv+HcYwUQXkux5gu2PPo9WusGUib3lWuMv8rCvmHA/jgw3Crl+xXXgOF1Xg98zJ7MUjTmNwBbWuYFzHjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049548; c=relaxed/simple;
	bh=ktWOZ8sx65f0/bJwZvgY/DZ5tkUetuyN7nRy1XtAE/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVRb5DesTnru5sWJprz+0rarAysMsTpzL/FLIi+huAkMBIlfYFjiJLFj5cxVWlDx4kFNFq19pseopfs/67vYsVm8rWR6wGOcBxrKJyRTWncPbaxYDdzrU1v4aDUhWpv1xkkHYadVs4A7Q60BaPuvcJRFsGiHG7QWBzhWcKeYGQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQxK/5Hx; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-940e06b4184so166388139f.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 05:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761049546; x=1761654346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktWOZ8sx65f0/bJwZvgY/DZ5tkUetuyN7nRy1XtAE/g=;
        b=FQxK/5HxZ/yY6nHDZ5wzGjhOiq65vgv3PVwf6BJ2UYo5mcmBTPMF3h+cr3KyqAZ6f0
         hI9DNCC6LYV5WOsNSekhYUuXV2mHYM9fO1zJ7yu82Le+sCHUHSPtoEGwtwdkF60O9Sth
         n2227CZQi8YnVKDjAAyvI8oZtTzD26UIwSLNBKICCO2/f1VNRrxTR3fz/RP4aRfa/zdV
         zRduRFO4qy+lbeNIRd666QvxYUIufYeyBIMaIs9MJYXbD069nmU48lVFFZ2yLPPqJQTF
         dEqG8SmvhrvjAey6onNMV6N387oGaHhvakh93oDWR7Mn9FXbIUwDw5fEhGWdz1gxV6S2
         RP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049546; x=1761654346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktWOZ8sx65f0/bJwZvgY/DZ5tkUetuyN7nRy1XtAE/g=;
        b=cyJWsIs18vK6IRTBPhSo3/D/AnqlHbaZFrYdmpHoqGogl97XAfCeqlm4v7BfsI96X+
         ypSxm2ZLe8RMRUNVHY04kmSxymQW7XkvSo31VoAsbknIP0p1VF+1zWRMqnR6ut1NZXLb
         KOjOb0YcqVaPxpNSga+Yzz9umHOlq1GOosRl1vm2ifEHtqAE9oXlPOnEyuyC0Tk4kZ2z
         HWGT3DPva7gdCF4Sdqst4ZBFzFPMG8+pxaKKGtByquDpy78o4q4clxiwh1sIJYUzOkz6
         rRI6dl3rP6BWnlBhwqAFmGsKkRwxATw2zu9jqxXmDoLraBl4R8Ag02rx+zFAoB4LQtda
         zf+w==
X-Forwarded-Encrypted: i=1; AJvYcCXcGmDuZdFLk9HcarWkGrQt5NmTxYuFqUZDP138g1diw7GVJJ9aK7x4AG8R0EOp9AuHKPsZ7To=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoJMvjvqW8/O8jQEcV+8qJmYEkqy1CBSPqwhEVA0e6ZLx4xX8B
	HY3yrD4Y2r6wQ3/HYXeVeNBI3434SNgWiVgJAHvhc/36Bhbe5Len7pmbiEQP4Z2cuXhd4T1G/DG
	dDVcVl0SaXX8of0KvzonIePaX5+bmYSA=
X-Gm-Gg: ASbGncvK0uIvT2IgMQwyI6otRFjtEOmcPJA0xWBuvpVATLg/3bwTcvwU5k2m0Kjympr
	07DcaIFK/EHBpnJsYZgD8vDN9R5j/oXYG9UJ1EEB9I6EqteyMX498Rh8ozzwXWkgMBojx267yEP
	dnV+TFaA0g5GGJDcjFJ2ZwJSTwJjTWcuRoZdpy67d/j53I4ofQo/7OfrWSQfQNjoRUxGoXeZWlU
	OinjPBcOwLL2WMt/Hz86XPKhASeldpdV/+kI+gSVg5vBSSqV8giiftHrC4K6dU7JuaDMgE=
X-Google-Smtp-Source: AGHT+IEPjbfrKNwYdqhrdEIinLi4QHAD2LgZDidtG7WC2qmQgFHIghWWQJSKStO7jWPBz4mHplHpo+iB8yDDyXogzpE=
X-Received: by 2002:a05:6e02:1d9d:b0:430:a65c:a833 with SMTP id
 e9e14a558f8ab-430c52ccf5fmr254378145ab.31.1761049545965; Tue, 21 Oct 2025
 05:25:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu> <CAL+tcoA5qDAcnZpmULsnD=X6aVP-ztRxPv5z1OSP-nvtNEk+-w@mail.gmail.com>
 <643fbe8f-ba76-49b4-9fb7-403535fd5638@nop.hu> <CAL+tcoDqgQbs20xV34RFWDoE5YPXS-ne3FBns2n9t4eggx8LAQ@mail.gmail.com>
 <d8808206-0951-4512-91cb-58839ba9b8c4@nop.hu> <7e58078f-8355-4259-b929-c37abbc1f206@suse.de>
In-Reply-To: <7e58078f-8355-4259-b929-c37abbc1f206@suse.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Oct 2025 20:25:09 +0800
X-Gm-Features: AS18NWCK7bntQZTu0FjGx1VkqHaElYhEKFMOKaTvnzFXM91Cgx5Y_qGTKEr-zew
Message-ID: <CAL+tcoDLr_soUTsZzFE+f-M0R83tvqx7tGjU+a5nBFSdtyP7Lw@mail.gmail.com>
Subject: Re: null pointer dereference in interrupt after receiving an ip
 packet on veth from xsk from user space
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: mc36 <csmate@nop.hu>, alekcejk@googlemail.com, 
	Jonathan Lemon <jonathan.lemon@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 1118437@bugs.debian.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 6:52=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
>
>
> On 10/20/25 11:31 PM, mc36 wrote:
> > hi,
> >
> > On 10/20/25 11:04, Jason Xing wrote:
> >>
> >> I followed your steps you attached in your code:
> >> ////// gcc xskInt.c -lxdp
> >> ////// sudo ip link add veth1 type veth
> >> ////// sudo ip link set veth0 up
> >> ////// sudo ip link set veth1 up
> >
> > ip link set dev veth1 address 3a:10:5c:53:b3:5c
> >
> >> ////// sudo ./a.out
> >>
> > that will do the trick on a recent kerlek....
> >
> > its the destination mac in the c code....
> >
> > ps: chaining in the original reporter from the fedora land.....
> >
> >
> > have a nice day,
> >
> > cs
> >
> >
>
> hi, FWIW I have reproduced this and I bisected it, issue was introduced
> at 30f241fcf52aaaef7ac16e66530faa11be78a865 - working on a patch.

Exactly. I simply reverted it and its dependencies and didn't see any
crash then. It was newly introduced, hopefully it will not bring much
trouble. As I replied before, I will take a look tomorrow morning.

Thanks,
Jason

