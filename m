Return-Path: <netdev+bounces-163705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBFFA2B65C
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066701653BD
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1D22417DF;
	Thu,  6 Feb 2025 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmbyY8WY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81432417C0
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738883213; cv=none; b=rWG/GsM8gN4L2LcBgqfBy7HfDlcDg8l2+dKkggXNTUCmBXHwAr6PDtYHEaMn4uRmpRBbOiub3PzEYXhIkFNuxs69XgTy/0qwgX6nCPNXMlHYFOZWfFogql7E5CpaKmY5DzaWXz+uocLGirpVZka+4l3uhSYyBxwdzk2UgAmDsCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738883213; c=relaxed/simple;
	bh=AsJ+HRC4uf28HpYJ43W9A5a6ARlAHXZ0jwY4e+tKBLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWpf71gOB3ZOyWpIcJRrH+CJCyKVudl8b31s56fx2vdCCo/FCdMHgbL35IyqwavERh04iHd5RyhPMbzDmaP9xc3QBuNGYxWyKUtxNf4440UjCdMXyFdRKrPmVCb5lym7lVZty+BkQyzSoQiPKElJ6NS/P56AOenEaD1Aea13ZKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmbyY8WY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB11C4CEDD;
	Thu,  6 Feb 2025 23:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738883213;
	bh=AsJ+HRC4uf28HpYJ43W9A5a6ARlAHXZ0jwY4e+tKBLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mmbyY8WYG7u1w71DEo8UHmHW0zQRhur1coRopCs+rL76mDfN+zEvmVZh8uUTQUkqj
	 HSr2z/Fwn9pdry18G7sET2Xfqf7oxmLdFt4MsP8UVZ97sfnBw9P99pdjiPu8DamNJ0
	 lIe3/e4aVohVEs3ejR0xMh4Dw5Rp7QY0Sjs4QoQKXiM82G5pUpNfPRHLuIFIo1MZ3B
	 7ty3s+IOihAo9CHWvY5gMTiRwvfolJz/bFYMfCK3UVX7398lmWir07PYCjTmlUpnx2
	 g33ai91woqqKG9FmIsoo//kePfvB2J8oPfOHl5KwIgNNAeMQhDT/UmIKSeGviLcTS3
	 DV8qs5E47sQIA==
Date: Thu, 6 Feb 2025 15:06:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next v2 1/4] net: refactor netdev_rx_queue_restart()
 to use local qops
Message-ID: <20250206150652.7724cf63@kernel.org>
In-Reply-To: <CAHS8izNpnB+-Ev1DHZ_nuVTc4gDGQq67BdQ0Gn37MLHX5fBieA@mail.gmail.com>
References: <20250206225638.1387810-1-kuba@kernel.org>
	<20250206225638.1387810-2-kuba@kernel.org>
	<CAHS8izNpnB+-Ev1DHZ_nuVTc4gDGQq67BdQ0Gn37MLHX5fBieA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Feb 2025 15:05:56 -0800 Mina Almasry wrote:
> On Thu, Feb 6, 2025 at 2:56=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > Shorten the lines by storing dev->queue_mgmt_ops in a temp variable.
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org> =20
>=20
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Ah, forgot to carry your tags forward, didn't I.. Sorry.

