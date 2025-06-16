Return-Path: <netdev+bounces-198261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABBDADBB79
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE04175ED0
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B471E98F3;
	Mon, 16 Jun 2025 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiMzspfw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB0F1B0F1E
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750106910; cv=none; b=Rr7Wil5em/kdp//392JkbMXAb7UN73zxTEZ9ywTCxKg43fbE2TZxECPVlDyqBoIU/UcE5d2pjJngHDNRyf3OrRR4KwMjnizG+OOThc4w/pQARTwXOHQx7RmXHrkakfzua/f48TitbgELmevtI+yzkCBsVDlRsv8vTPFKG/tgCxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750106910; c=relaxed/simple;
	bh=94pqwOQZJ6v7QfMDQpp7gmTCVHye4zUd2I05AKWuSNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4BgKhEq09TN5Egk9UEPs7gBN/QOp/eAhwOsN56UmjYBkRWTPN9zf2JJQ6F9gJ2cnbHfXN6HHmZZTBnFOLdU3fzldV6HPykD3aEegVPr9d57bR1Vbn53yIeXzbnrxXSOJiEn7WTeAjTcF33f1MvL8QQmXbL5f2hwXMX3dPYcKTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiMzspfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46D1C4CEEA;
	Mon, 16 Jun 2025 20:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750106910;
	bh=94pqwOQZJ6v7QfMDQpp7gmTCVHye4zUd2I05AKWuSNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EiMzspfw0yGYEOOznOfdIzHeb9es9FcHSbJttoVtp4CEz//gZcH5MJP4kAUnU3QoK
	 e1Uf+IfX6bbqjNJSKAJGvp+KITB11/XC/mZnqfHnTE9GE/0tn1+EIDIUt4jpAoUkMs
	 FnoZ5rnBDNWzFx4heUfd19zGDKLAel02U4vGFlLFAvbiX2qPJhWvUH+q4yPXAfPujZ
	 dsXJS43jFn/Sxj2lzffga7AJKJxIos8mno964wF/0kvluwOlzQJWqLgaLnw1XM3HT5
	 5sMp5dSiGX7jighowvj3sBghSd0dfDrN3LsjMGAMfqfvj3/mORSveG9rqGUUAZiXXe
	 AqhxEfr/hEHdg==
Date: Mon, 16 Jun 2025 13:48:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Simon Horman <horms@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net 3/3] bnxt_en: Update MRU and RSS table of RSS
 contexts on queue reset
Message-ID: <20250616134828.703eafe5@kernel.org>
In-Reply-To: <CACKFLimACdMBNZ2v-zpJ5=H1JdyWfLjN_0SqXkPe9waacq=GiQ@mail.gmail.com>
References: <20250613231841.377988-1-michael.chan@broadcom.com>
	<20250613231841.377988-4-michael.chan@broadcom.com>
	<20250616133855.GA6187@horms.kernel.org>
	<CACKFLimACdMBNZ2v-zpJ5=H1JdyWfLjN_0SqXkPe9waacq=GiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Jun 2025 10:40:27 -0700 Michael Chan wrote:
> On Mon, Jun 16, 2025 at 6:39=E2=80=AFAM Simon Horman <horms@kernel.org> w=
rote:
> > On Fri, Jun 13, 2025 at 04:18:41PM -0700, Michael Chan wrote: =20
> > > From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > >
> > > The commit under the Fixes tag below which updates the VNICs' RSS
> > > and MRU during .ndo_queue_start(), needs to be extended to cover any
> > > non-default RSS contexts which have their own VNICs.  Without this
> > > step, packets that are destined to a non-default RSS context may be
> > > dropped after .ndo_queue_start(). =20
> >
> > This patch seems to be doing two things:
> > 1. Addressing the bug described above
> > 2. Implementing the optimisation below
> >
> > As such I think it would be best split into two patches.
> > And I'd lean towards targeting the optimisation at net-next
> > since "this scheme is just an improvement". =20
>=20
> The original fix (without the improvement) was rejected by Jakub and
> that's why we are improving it here.
>=20
> Jakub, what do you think?

I think the phrasing of the commit message could be better, but the fix
is correct as is. We were shutting down just the main vNIC, now we shut
down all the vNICs to which the queue belongs.

It's not an "optimization" in the sense of an improvement to status quo,
IIUC Pavan means that shutting down the vNIC is still not 100% correct
for single queue reset, but best we can do with current FW. If we were
to split this into 2 changes, I don't think those changes would form a
logical progression: reset vNIC 0 (current) -> reset all (net) -> reset
the correct set of vNICs (net-next).. ?

I'd chalk this up to people writing sassy / opinion-tainted commit
messages after reviewers disagree with their initial implementation.=20
I tend not to fight it :)

