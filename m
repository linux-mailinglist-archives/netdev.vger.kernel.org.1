Return-Path: <netdev+bounces-105822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F6091312A
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 02:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61561F22957
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 00:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1752C63E;
	Sat, 22 Jun 2024 00:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OutJDPYg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67DD384
	for <netdev@vger.kernel.org>; Sat, 22 Jun 2024 00:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719016245; cv=none; b=P4Jwod/pkEQiVuTCu6sfJi/OQJLAn0eiROWQ3H6EgEjszdNhhJJlChBk/3OGMsNGGQA1qiFxXZE0YwIV7zbmdY4qCj0KGJjB+VtRBSnF/auyyXYtDHBehs4knbykQX3nbQNsV2QFiBC9B4IB+RIQT25hzmgUQBmzrVAvdvFWqN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719016245; c=relaxed/simple;
	bh=/B+VLGY0A1cOtZOx4QFmTvK+OCKKBcKyyY8JvEauPyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bxnx65iyIr2y1Gdxqf/W4xmse9k0A22Fqun1YkOaqJiqJBJjv3R2lC8QEzwSgdBhFNrXf5ckQqPthg5wbfxn58pZ3f2VtIIzsKiTABjt7QgjLxl3PnfxyI7tZJXZ4jbhcW327Y12sjOxef7pxHI8FYngq0fQDZNk4LhnjjqvoQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OutJDPYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A110C2BBFC;
	Sat, 22 Jun 2024 00:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719016244;
	bh=/B+VLGY0A1cOtZOx4QFmTvK+OCKKBcKyyY8JvEauPyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OutJDPYgj4EXyivATOqcdzTUyfEEUF0ZoRQmrPDXeD5zuQGbJycETZBTbEb/2Dtd/
	 JH9CI3o4rkQw5AqF9hw4I6hMhG7D4Kacnkw7ZsgmcylgyrwyTu44zrXvvuPeEZNoxy
	 CGjHPKhJteKzO6Bk2oikA/DP20LLJGp4RKAM3yWY04BuJgN+zxw+ogDkEGO+l7Cjl8
	 Sfo7fi6/9HwCVbcq745z5CqAKMB6nALsRw1Uz73N3nobicqbRfgimZrqVeu+TXIiux
	 ZIk5vmg+TjiMFG4s9b1UW/4BDp4otK7ITfFoFkjMWXVh1hOXbh5a6PA7fwb3mcEcBt
	 iONlRUF6sZ8sg==
Date: Fri, 21 Jun 2024 17:30:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Singhai, Anjali" <anjali.singhai@intel.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Boris Pismenny <borisp@nvidia.com>, "gal@nvidia.com"
 <gal@nvidia.com>, "cratiu@nvidia.com" <cratiu@nvidia.com>,
 "rrameshbabu@nvidia.com" <rrameshbabu@nvidia.com>,
 "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
 "tariqt@nvidia.com" <tariqt@nvidia.com>, "Samudrala, Sridhar"
 <sridhar.samudrala@intel.com>, "Acharya, Arun Kumar"
 <arun.kumar.acharya@intel.com>
Subject: Re: [RFC net-next 00/15] add basic PSP encryption for TCP
 connections
Message-ID: <20240621173043.4afac43f@kernel.org>
In-Reply-To: <CO1PR11MB49939F947A63E4A5F8C5246A93C82@CO1PR11MB4993.namprd11.prod.outlook.com>
References: <CO1PR11MB49939CBC31BC13472404094793CE2@CO1PR11MB4993.namprd11.prod.outlook.com>
	<66729953651ba_2751bc294fa@willemb.c.googlers.com.notmuch>
	<CO1PR11MB49939F947A63E4A5F8C5246A93C82@CO1PR11MB4993.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Jun 2024 21:32:14 +0000 Singhai, Anjali wrote:
> > > 1. Why do we need =C2=A0ndo_op set_config() at device level which is =
setting only one version, instead the description above the psp_dev struct =
which had a mask for enabled versions at a=C2=A0 device level is better and=
 device lets the stack know at psp_dev create time what all versions it is =
capable of.  Later on, version is negotiated with the peer and set per sess=
ion.
> > > Even the Mellanox driver does not implement this set_config ndo_op.=20
> > =C2=A0> =20
> Can you or Kuba comment on this?

For now the only action the driver can perform is to disable PSP Rx
handling:

https://github.com/kuba-moo/linux/blob/psp/drivers/net/ethernet/mellanox/ml=
x5/core/en_accel/psp.c#L18

> > > 2. Where is the association_index/handle returned to the stack to be =
used with the packet on TX by the driver and device? ( if an SADB is in use=
 on Tx side in the device), what we understand from Mellanox driver is, its=
 not doing an SADB in TX in HW, but passing the key directly into the Tx de=
scriptor? Is that right, but other devices may not support this and will ha=
ve an SADB on TX and this allowed as per PSP protocol. Of course on RX ther=
e is no SADB for any device.
> > > In our device we have 2 options,=20
> > >             1. Using SADB on TX and just passing SA_Index in the desc=
riptor (trade off between performance and memory.=20
> > >             As  passing key in descriptor makes for a much larger TX =
descriptor which will have perf penalty.)
> > >            2. Passing key in the descriptor.
> > >             For us we need both these options, so please allow for en=
hancements.
> > > =20
> Can you or Kuba comment on this? This is critical, also in the fast path,=
 skb needs to carry the SA_index/handle (like the tls case) instead of the =
key or both so that either method can be used by the device driver/device.

The ID should go into the driver state of the association, specify how
much space you need by setting this:
https://github.com/kuba-moo/linux/blob/psp/include/net/psp/types.h#L110C6-L=
110C19
Then you can access it via psp_assoc_drv_data()

AFAICT Willem answered all the other points.

