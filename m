Return-Path: <netdev+bounces-206594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1FBB03A15
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 10:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CDE93AC8AE
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 08:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BFC233134;
	Mon, 14 Jul 2025 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="U70d6aGN"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BBEDDC5;
	Mon, 14 Jul 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752483272; cv=none; b=Yrs+jPESOlbg7u+vJ442DwOGgGB+oLqNyLOkXsLc9XOXdLf4fKlMGk7qC8xOPVoZRFpmHrH3jz2CuVcb1cF9ts+3fK8dPiN85zi4Wav7cfsD0/BSJ29k83B2w5wIJxoQaTpD/GMpyuGb2Dzl7lbBHsHww3rcRkooxLCOhOzuWBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752483272; c=relaxed/simple;
	bh=XLCkRSISVDeIpgxU8vs7vyiheo6la4vi1egMoe27PeQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DQBAbwfXBbCJa6DsZfPieJQpSvKCWvp6Jm8QjQ8TwYjUnnmaoAFdbttk+azkQCseJbHjQhPq5B21nAXphrIC9+fx2yz94JpeIWTBQGUFPSNkjRU0iwixrJFrlHz+xZh0KoWwDf8yitunYbGWOqN3fVbDSBRSFfNGuMDCdAa6hog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=U70d6aGN; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752483268;
	bh=XLCkRSISVDeIpgxU8vs7vyiheo6la4vi1egMoe27PeQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U70d6aGN4WTy/rLquqHvkgc6xTa234lVRTLYf/nCwD4a4AUcuHal2/G5f4NrWGWfg
	 2pBRtsBDG7420PWzmXl5lDfhoTuxDqTZW8L9ffFqVMtMAL3wtBtyeI0jpPbT+Gfwet
	 s1do5/Aa/sUZDCGG8aiLqcPejnkf90BcZ49oEmI+BUf1bk8sQbQSkVfmC6LsT2UWgV
	 Zxi4i/CGeHd6BA4/VS8/Poz+XeZWEepgiN7iZLuQ/2rf7W9lpnk23Ac86xF8CxKwg9
	 3C+aQmm8N3Ei9kq+ZFPb4HbjurF/SafY/LHkTcQG9jp9horP9FwM8dbRIxKLu1i5N8
	 rn6uJnDCI5BOw==
Received: from [192.168.72.164] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E69416B4BE;
	Mon, 14 Jul 2025 16:54:27 +0800 (AWST)
Message-ID: <a01f2ed55c69fc22dac9c8e5c2e84b557346aa4d.camel@codeconstruct.com.au>
Subject: Re: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: aspeedyh <yh_chung@aspeedtech.com>, matt@codeconstruct.com.au, 
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,  bmc-sw@aspeedtech.com
Cc: Khang D Nguyen <khangng@amperemail.onmicrosoft.com>
Date: Mon, 14 Jul 2025 16:54:27 +0800
In-Reply-To: <20250714062544.2612693-1-yh_chung@aspeedtech.com>
References: <20250714062544.2612693-1-yh_chung@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi YH,

[+CC Khang]

I have some overall questions before we get into a full review of the
series, inline below.

> Add an implementation for DMTF DSP0238 MCTP PCIe VDM transport spec.
>=20
> Introduce struct mctp_pcie_vdm_dev to represent each PCIe VDM
> interface and its send/receive operations.=C2=A0 Register a
> net_device with the MCTP core so packets traverse the standard
> networking socket API.
>=20
> Because there is no generic PCIe VDM bus framework in-tree, this
> driver provides a transport interface for lower layers to
> implement vendor-specific read/write callbacks.

Do we really need an abstraction for MCTP VDM drivers? How many are you
expecting? Can you point us to a client of the VDM abstraction?

There is some value in keeping consistency for the MCTP lladdr formats
across PCIe transports, but I'm not convinced we need a whole
abstraction layer for this.

> TX path uses a dedicated kernel thread and ptr_ring: skbs queued by the
> MCTP stack are enqueued on the ring and processed in-thread context.

Is this somehow more suitable than the existing netdev queues?

> +struct mctp_pcie_vdm_route_info {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 eid;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 dirty;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 bdf_addr;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct hlist_node hnode;
> +};

Why are you keeping your own routing table in the transport driver? We
already have the route and neighbour tables in the MCTP core code.

Your assumption that you can intercept MCTP control messages to keep a
separate routing table will not work.

> +static void mctp_pcie_vdm_net_setup(struct net_device *ndev)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ndev->type =3D ARPHRD_MCTP;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ndev->mtu =3D MCTP_PCIE_VDM_MI=
N_MTU;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ndev->min_mtu =3D MCTP_PCIE_VD=
M_MIN_MTU;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ndev->max_mtu =3D MCTP_PCIE_VD=
M_MAX_MTU;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ndev->tx_queue_len =3D MCTP_PC=
IE_VDM_NET_DEV_TX_QUEUE_LEN;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ndev->addr_len =3D 2; //PCIe b=
df is 2 bytes

One of the critical things to get right is the lladdr format for PCIe
VDM devices, as it will be visible to userspace. While the PCIe b/d/fn
data is indeed two bytes, the MCTP addressing format for VDM data is not
entirely representable in two bytes: we also have the routing type to
encode. DSP0238 requires us to use Route to Root Complex and Broadcast
from Root Complex for certain messages, so we need some way to represent
that in your proposed lladdr format.

For this reason, you may want to encode this as [type, bdfn] data.

Also, in flit mode, we also have the segment byte to encode.

Cheers,


Jeremy

