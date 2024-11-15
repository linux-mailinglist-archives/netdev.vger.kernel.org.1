Return-Path: <netdev+bounces-145367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805729CF469
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 744ADB28877
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 18:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DC41D8E07;
	Fri, 15 Nov 2024 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hI47qxyP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B218FC89
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731696499; cv=none; b=JwYoAQnS5m1kdD50WZzZzcQrRDFpBOOKuWQDNCyKePkSANAuyse36LUJAvicKY+IK5ECMcM8WNP/P5+h/lEZUblkXzQ6fv2BOCj9NprySdcAI9DOjbmQ8nQsqQ2r1q3KqTOuJTSwGlgWlscXH0TVlP5ChaQpvLJ1pVzDldgymhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731696499; c=relaxed/simple;
	bh=KtMVxTTOMI0KU4wbIFDAADxkrsXz/EzCNgQuQP9tN9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgysMO89AVKaLMELsLD/fig1BClcTnCqTMFEwlSs0UVwrTHvfHBDRfvpZVRsmIHjC3M2Iaz0FJJgLz1RXYHyD5Xw+QRbt8oMHOoIgRU5bnnAYOKgU5QYZ1xZN7ycEgEH8mxPrsdJXPGiHMkaeaZeZ6iOLzzPx2p8VI2ikAQxTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hI47qxyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3962DC4AF0B
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 18:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731696498;
	bh=KtMVxTTOMI0KU4wbIFDAADxkrsXz/EzCNgQuQP9tN9w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hI47qxyPOCTYej+zgfbXNd8qUfSgBy9uSxAjFPMrmWbCeZSoULle4oJCXKhfw9gnS
	 lvuT6kXamKRcNdInix5yv74YmeNjwG2YNOnPa/sSDcu6QBBbqHEII3MLl3Wp0tqZEa
	 JXGLh/J4fqKcw4QwbOZDe7pAnYlvBNsOrRy1Os4qF56GfwEoj8vnrP1Sk8Wx23wR0b
	 KiFiBQ53MVPrT2zo4KRoAUYUWxGm/GVNG8c1NMmTNyQvqhS+ipTF1a32jpWZilDVf2
	 QEIn76RRbZEbK9P6hZIusa+tOO0CT1R6wK+BP0pbpH/3ZdXRftDKCDgxOfO6/+QSRN
	 Q84WNmPe4S1XA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cf7b79c6a6so3126975a12.0
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 10:48:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX0G78aEHt/Si6eZwnZNoMRcLuePD/AC8d+RfhYncuNRIvVP8RNzSisVSN/B76VYjz8+ACzKhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwysUQhjxS5vi1fKKI0dKdsHOwHIMk6b4YINTeXMBfPhv1FDEiu
	SsWOaoJOwdzJY+ApZpURSSKDr+ELvdu4Ij04yaxHftriDSAr6rzNyek5XWPxZ9oPTqTCeOsQYA1
	8nxobZDmwoAtnbWwuM24cjpxqPNY=
X-Google-Smtp-Source: AGHT+IGuYUD5/FMtZKhUiG0CMehc0zX1bb110lvnVpPNYCetY7IHL2qPJR1PfOavhEJt3hPwfWl83EdtZB90GphgVbc=
X-Received: by 2002:a17:907:3f03:b0:a9a:a3a:6c48 with SMTP id
 a640c23a62f3a-aa20763b6ffmr788963066b.2.1731696497126; Fri, 15 Nov 2024
 10:48:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114000105.703740-1-jbrandeb@kernel.org> <7c63c3db-072c-4f44-a487-f7e7de9f39e4@intel.com>
In-Reply-To: <7c63c3db-072c-4f44-a487-f7e7de9f39e4@intel.com>
From: Jesse Brandeburg <jbrandeb@kernel.org>
Date: Fri, 15 Nov 2024 10:48:05 -0800
X-Gmail-Original-Message-ID: <CAEuXFEyryE_Cr+=DEzPPZFeOXLn5QpwL57nyxkQ=Eo6eTE3eyQ@mail.gmail.com>
Message-ID: <CAEuXFEyryE_Cr+=DEzPPZFeOXLn5QpwL57nyxkQ=Eo6eTE3eyQ@mail.gmail.com>
Subject: Re: [PATCH net v1] ice: do not reserve resources for RDMA when disabled
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: jbrandeburg@cloudflare.com, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, Dave Ertman <david.m.ertman@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Czapnik, Lukasz" <lukasz.czapnik@intel.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 12:51=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 11/14/24 01:00, jbrandeb@kernel.org wrote:
> > From: Jesse Brandeburg <jbrandeb@kernel.org>
> >
> > If the CONFIG_INFINIBAND_IRDMA symbol is not enabled as a module or a
> > built-in, then don't let the driver reserve resources for RDMA.
> >
> > Do this by avoiding enabling the capability when scanning hardware
> > capabilities.
> >
> > Fixes: d25a0fc41c1f ("ice: Initialize RDMA support")
> > CC: Dave Ertman <david.m.ertman@intel.com>
> > Signed-off-by: Jesse Brandeburg <jbrandeb@kernel.org>
> > ---
>
> Hi Jesse, it's good to hear back from you :)


Hi Przemek! You too.

> we are already working on resolving the issue of miss-allocating
> too many resources (would be good to know what beyond MSI-x'es
> you care about) for RDMA in the default (likely non-RDMA heavy) case.
> Here is a series from Michal that lets user to manage it a bit:
> https://lore.kernel.org/netdev/20241114122009.97416-3-michal.swiatkowski@=
linux.intel.com/T/

I agree, but that whole series is far too big to backport to stable, right?

> and we want to post another one later that changes defaults from the
> current "grab a lot when there are many CPUs" policy to more resonable

I'm looking forward to those series, and in fact had been looking to
backport one of the patches from michal's series, but found that for
us at least with RDMA disabled this limit seemed far simpler, and also
I doubt it will conflict with the more complicated work of managing
features when all are enabled.

Please see my other reply to dave (and yes I'm replying from two
different accounts, as I'm figuring out the best way to work here at
my new job.)

