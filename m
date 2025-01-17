Return-Path: <netdev+bounces-159396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19517A156D2
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CEF3A22D2
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2417A1A3056;
	Fri, 17 Jan 2025 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZaKdJeq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36D5146D59
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138920; cv=none; b=gXoLpJSkS2aITOgUfn6RdhFB3DAbZ+Of39LRkL5Pm8c2XE2yNhwOxGnTsEC4PGZn7AtcmcfrGanvtIzhK+XCmRowUPgPRnCNFspmrt6Fj3bJLfIQgtlXz/7FL59+EGS7R3nb+vLUt72Q4gClK+bKSw5hsK2iuv4ztwXkSiFWJio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138920; c=relaxed/simple;
	bh=/2Oy4hUeLlZ7ifwsyw0+umPl2SqFLRlXMxlzwqsE//A=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=tGF/YO2skp8y73TdXQxIMQ9w7jp6jj+5970NatUGCV0s2ltnhb8BJTrHpAEyhk1sJUzoXrr5Z05yoItW4ZeOFY5Rd6RWU2dHqsQHE0U5gpo4l3NOIw/kDPm1IlxJfZRT1LIZFC+Z9PHjGN0ywFFWvMrgho0nnSRwSdlLwU2cvZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZaKdJeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C863C4CEDD;
	Fri, 17 Jan 2025 18:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737138919;
	bh=/2Oy4hUeLlZ7ifwsyw0+umPl2SqFLRlXMxlzwqsE//A=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=bZaKdJeq/XVRIIPeBMIx74x0Slq8OpUAcO5U4xNIaezkgPscn2snjnLDGfX0Rzvxf
	 /EeyBHpAZORDoXYYuQ4ySqGfhYK8OPo43i8Q1Al/7KQz6Ej/uAoBTws3xOikqWiRGn
	 aMjBEMUf+BwMmUXXm8dBBLQfSBVTBPlyfX8CdV166SSvMyocT/nuqoEy4A7V9GLZGr
	 U48RhxbwkvhtCfaITvw5cS4dH1THji4nAxnm2zYu8HJzwBw6r5gwVmD3jGn0Oz8GbP
	 m1LlyKkbKTSZHyQAwCuipByrN+Nmk8w4lw2DrN65zMBO/6RlTgPx2vATNwVZPD+/MW
	 3T/ksIxRYo5Bw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250117090311.23257dcc@hermes.local>
References: <20250117102612.132644-1-atenart@kernel.org> <20250117102612.132644-2-atenart@kernel.org> <20250117090311.23257dcc@hermes.local>
Subject: Re: [PATCH net-next 1/4] net-sysfs: remove rtnl_trylock from device attributes
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, gregkh@linuxfoundation.org, netdev@vger.kernel.org
To: Stephen Hemminger <stephen@networkplumber.org>
Date: Fri, 17 Jan 2025 19:35:16 +0100
Message-ID: <173713891639.5144.4856802697008623996@kwain>

Quoting Stephen Hemminger (2025-01-17 18:03:11)
> On Fri, 17 Jan 2025 11:26:08 +0100
> Antoine Tenart <atenart@kernel.org> wrote:
>=20
> > diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> > index 1f4d4b5570ab..7c3a0f79a669 100644
> > --- a/net/core/rtnetlink.c
> > +++ b/net/core/rtnetlink.c
> > @@ -80,6 +80,12 @@ void rtnl_lock(void)
> >  }
> >  EXPORT_SYMBOL(rtnl_lock);
> > =20
> > +int rtnl_lock_interruptible(void)
> > +{
> > +     return mutex_lock_interruptible(&rtnl_mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(rtnl_lock_interruptible);
>=20
> Is export symbol needed at all? The sysfs stuff isn't in a module.

You're right, this could be removed and only added if/when there is a
use case. The only reason would be for consistence with other similar
helpers but some are not exported already so I guess that's OK.

Thanks,
Antoine

