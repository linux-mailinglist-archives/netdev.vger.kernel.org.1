Return-Path: <netdev+bounces-161410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D06DA212E5
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 21:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07C516591B
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 20:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9531DE4DA;
	Tue, 28 Jan 2025 20:12:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lynxeye.de (ns.lynxeye.de [87.118.118.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F88B15D5C4;
	Tue, 28 Jan 2025 20:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.118.118.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738095175; cv=none; b=jj1zXHMM6lyhr9NtfPltyx8/K7r+PCfn5NeocN0o+0qHSVQfgNH7lx2KEegx/MObik5uRPtou+FRFSgKspHBu7QeUQB/vx3E2Ilfs56lF11XJXOeU7ckU96JuDiAnOPpNjb1qQTDPvxjirCMi92cq3D5UM3Kk+hOKhQ5OlvLSE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738095175; c=relaxed/simple;
	bh=rEer5Vac7kMVgv5bwbnGzchPKoqx1kUftnZtMdARFIA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=db0W+sR7wRENmOcadHDmMhuU9Vr2KG9Me9+GIrhOt3vOn86p94zb5xNX2zsFm/r6ukFGLagY4MAzFEz1rV4XgK0D9vIcaW5qo0vCaUeeAKdgk3VSAtKbd3DGVcH60b2ZY2g5NjbTkq/cVXRHFUmZWQLVvc64dfsD94+H9HJcHh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lynxeye.de; spf=none smtp.mailfrom=lynxeye.de; arc=none smtp.client-ip=87.118.118.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lynxeye.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lynxeye.de
Received: by lynxeye.de (Postfix, from userid 501)
	id 6F899E74071; Tue, 28 Jan 2025 21:04:58 +0100 (CET)
X-Spam-Level: 
Received: from [192.168.178.25] (a89-182-99-197.net-htp.de [89.182.99.197])
	by lynxeye.de (Postfix) with ESMTPSA id 0A738E74067;
	Tue, 28 Jan 2025 21:04:57 +0100 (CET)
Message-ID: <c8db4ad722b7dd169ea71990238dbc82da91f3a4.camel@lynxeye.de>
Subject: Re: [PATCH net-next v3 1/4] net: stmmac: Switch to zero-copy in
 non-XDP RX path
From: Lucas Stach <dev@lynxeye.de>
To: Thierry Reding <thierry.reding@gmail.com>, Furong Xu <0x1207@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Brad Griffis <bgriffis@nvidia.com>, Jon
 Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Joe Damato
 <jdamato@fastly.com>, Andrew Lunn	 <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, 	xfr@outlook.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Date: Tue, 28 Jan 2025 21:04:56 +0100
In-Reply-To: <qkjv53fn32qdi5jh2d6bqdfnnl5x4x74cmir6fjtstfw2ijds6@eoxctjkqij7u>
References: <cover.1736910454.git.0x1207@gmail.com>
	 <bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
	 <d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
	 <20250124003501.5fff00bc@orangepi5-plus>
	 <e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
	 <ccbecd2a-7889-4389-977e-10da6a00391c@lunn.ch>
	 <20250124104256.00007d23@gmail.com>
	 <qkjv53fn32qdi5jh2d6bqdfnnl5x4x74cmir6fjtstfw2ijds6@eoxctjkqij7u>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Am Freitag, dem 24.01.2025 um 14:15 +0100 schrieb Thierry Reding:
>=20
[...]
> > The dma-coherent property in device tree node is SoC specific, so only =
the
> > vendors know if their stmmac ethernet controller is dma coherent and
> > whether their device tree are missing the critical dma-coherent propert=
y.
>=20
> What I fail to understand is how dma-coherent can make a difference in
> this case. If it's not present, then the driver is supposed to maintain
> caches explicitly. But it seems like explicit cache maintenance actually
> causes things to break. So do we need to assume that DMA coherent
> devices in generally won't work if the driver manages caches explicitly?
>=20
> I always figured dma-coherent was more of an optimization, but this
> seems to indicate it isn't.

There is a real=C2=A0failure scenario when the device is actually dma-
coherent, but the DT claims it isn't: If a location from e.g. a receive
buffer is already allocated in the cache, the write from the device
will update the cache line and not go out to memory. If you then do the
usual non-coherent cache maintenance, i.e. invalidate the RX buffer
area after the device indicated the reception of the buffer, you will
destroy the updated data in the cache and read stale data from memory.

Regards,
Lucas

