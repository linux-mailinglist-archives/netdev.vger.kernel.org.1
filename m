Return-Path: <netdev+bounces-185144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4996AA98B36
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C5E3A4B4A
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02291624D2;
	Wed, 23 Apr 2025 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5c9+nTy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB774040
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745415231; cv=none; b=ajgi3IRkIpJe1lD1NbZpTf+QCFuAncg2FTX3+qITJZDns9sCdHfB7frlpHBM4+mAJFzjquEmjrBlybYtn4BLnxBWl271QzSo7cMmLLqdRA5ou1RY8pV5m13wKBU6s3u8bY/MWk6nWCTeolbZcG2e28UuHxB9MBrxxmhFCQB/xwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745415231; c=relaxed/simple;
	bh=LAggvedjfM3/QkWgHFlxHtpbw+YmZ4PQd5zXikFl3c8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rzh1OizEc5xwFRUUcm5YHkYlwKRrnv+tSPDXLiJLtomotsrBQ/LSUlzXpyScDrfFyExpZTYXioTM74Equ9bxZTtmrKyMKc3RCrP61P6tXIXAKL4Vmr1OYPm4QdXNadWU0cakuAfUbUUHxcbwwLkAhj+ECIrKQ/plzKBmph1Plao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5c9+nTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4CCC4CEE2;
	Wed, 23 Apr 2025 13:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745415231;
	bh=LAggvedjfM3/QkWgHFlxHtpbw+YmZ4PQd5zXikFl3c8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p5c9+nTy3DxHN57sYIMI8MDDAZ7nOGXfIZfb/CV6LRDjm8pB1taVu9G2l8/yhvNr4
	 NLDvQAOkanbBhPlzbRQ+Y18MkDOdXT9DauD0nYwczZpTfeUKxTkTPZqAQ6VCtOO1LT
	 +azi5ImTWG0P8DYif0/tOt3EW0vXqdDAD+6AyOrr7mn7ULAA6nzU9Fq6NEDxv1HbBq
	 sTB+BEfqLm4zab0skb+1Yh6T5veebCcPgQyUOZIrxurWOOqhZA8d5f1T21zScgDmcB
	 pEijtONFMuGnKCafusL2Aj7NlADVqCK99vQSYNx2G1gIIolFJlzwzvpBDoahoAO1Pj
	 ikwlZXAziWwyA==
Date: Wed, 23 Apr 2025 06:33:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Wojciech Drewek <wojciech.drewek@intel.com>, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org, marcin.szycik@intel.com
Subject: Re: [PATCH v2 net-next 2/3] pfcp: Convert pfcp_net_exit() to
 ->exit_rtnl().
Message-ID: <20250423063350.49025e5e@kernel.org>
In-Reply-To: <aAimsamTlQOq3/aD@mev-dev.igk.intel.com>
References: <20250418003259.48017-1-kuniyu@amazon.com>
	<20250418003259.48017-3-kuniyu@amazon.com>
	<20250422194757.67ba67d6@kernel.org>
	<aAimsamTlQOq3/aD@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Apr 2025 10:37:05 +0200 Michal Swiatkowski wrote:
> On Tue, Apr 22, 2025 at 07:47:57PM -0700, Jakub Kicinski wrote:
> > On Thu, 17 Apr 2025 17:32:33 -0700 Kuniyuki Iwashima wrote: =20
> > >  drivers/net/pfcp.c | 23 +++++++---------------- =20
> >=20
> > Wojciech, Micha=C5=82, does anyone use this driver?
> > It seems that it hooks dev_get_tstats64 as ndo_get_stats64=20
> > but it never allocates tstats, so any ifconfig / ip link
> > run after the device is create immediately crashes the kernel.
> > I don't see any tstats in this driver history or UDP tunnel
> > code so I'm moderately confused as how this worked / when
> > it broke.
> >=20
> > If I'm not missing anything and indeed this driver was always
> > broken we should just delete it ? =20
>=20
> Uh, I remember that we used it to add tc filter. Maybe we can fix it?

If it really was broken for over a year and nobody noticed -
my preference would be to delete it. I don't think you need
an actual tunnel dev to add TC filters?

