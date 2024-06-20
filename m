Return-Path: <netdev+bounces-105084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3DC90FA1E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 02:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F06B22967
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D98D19B;
	Thu, 20 Jun 2024 00:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBB6H6CF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259A118E;
	Thu, 20 Jun 2024 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718841866; cv=none; b=r8/krifU+bpQlVNwngdT+k/9f9KGFWkppqOFiBLMQ4YC5tRfG1N6mpazAh6PA7v8FV4IARUOYyt9UTQjBoUbVIPBoKdjkT3lHn5EqKRa/flRl2JPV1Np+Plsn1kPGHz6lHRy0JRmbnaC3fEplPrt5vwBRqIzchOuYlNP5IKuamk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718841866; c=relaxed/simple;
	bh=mxFHVROngzpz4sS7Nrv7AjUmlg3I6MX6RkT2+wKLo54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdhZ2iJl/sRM0G+GZpET5i+uC+ww8pkludDG+dpH5YZGlggEqa9YtA+nmF7enxnrWpGCYmGQr+LARIlEqFNhIc07ltX1bzTH20e9olxP4piMKf4U9DsBGX8/bSEB9cxTOQU5wrOYwT4jzXJRWPgZxINrGQ1aXjKlBrPHmYqArI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBB6H6CF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0BAC2BBFC;
	Thu, 20 Jun 2024 00:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718841865;
	bh=mxFHVROngzpz4sS7Nrv7AjUmlg3I6MX6RkT2+wKLo54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MBB6H6CFkAqR1TrctTYULx9hYOCvpvXTEJyBTFTNm4miiEGzCwiTu5lIu3um2V+pg
	 9G1HdhzLdrXdKcuiVVfih8mDHUYzkyoKOsi7kCiMK2/R/5ehWlp4XYEDmj6KHiKHL+
	 9NynA+KbLMgVATiJ568+Sr8ZwuM3Y4megYY+Yn3LRktXajl1qL47SmpvHZHVo7Xicd
	 HF/3cdHO1OObqRPC6P2KSxUj9m/RpSaDuPQqJKCGsG3GIYoGNWxH4LnhFrKfIy0pl1
	 GRbYFhkczoFbqAVnSluwXfX60tlsnng91u/T4RYwrhD8WAHcd5TPZ7TAXrAgvMa4wR
	 WEx4Ecey4O4Mg==
Date: Wed, 19 Jun 2024 17:04:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jon Kohler <jon@nutanix.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Christian Benvenuti
 <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Larysa
 Zaremba <larysa.zaremba@intel.com>
Subject: Re: [PATCH] enic: add ethtool get_channel support
Message-ID: <20240619170424.5592d6f6@kernel.org>
In-Reply-To: <2CB61A20-4055-49AF-A941-AF5376687244@nutanix.com>
References: <20240618160146.3900470-1-jon@nutanix.com>
	<51a446e5-e5c5-433d-96fd-e0e23d560b08@intel.com>
	<2CB61A20-4055-49AF-A941-AF5376687244@nutanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Jun 2024 16:39:40 +0000 Jon Kohler wrote:
> Looking through how other drivers do this, I didn=E2=80=99t get a sense t=
hat
> any other drivers were stacking rx_count + combined_count together.
>=20
> Also, enic and the underlying Cisco VIC hardware appears to be=20
> fairly specific that the queues they provision at the hardware level are
> either RX or TX and not a unified ring or something to that effect.
>=20
> I took that to mean that we would never call anything =E2=80=98combined=
=E2=80=99 in
> the context of this driver.

channel is a bit of an old term, think about interrupts more than
queues. ethtool man page has the most informative description.

Looking at this driver, specifically enic_dev_init() I'd venture
something along the lines of:

	switch (vnic_dev_get_intr_mode(enic->vdev)) {=20
	default:
		channels->combined =3D 1;
		break;               =20
	case VNIC_DEV_INTR_MODE_MSIX:=20
		channels->rx_count =3D enic->rq_count;
		channels->tx_count =3D enic->wq_count;
		break;
        }

Please not that you don't have to zero out unused fields, they come
zero-initilized.
--=20
pw-bot: cr

