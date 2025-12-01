Return-Path: <netdev+bounces-242917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EFBC964E6
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 10:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A8ED4E0439
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 09:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D252EBB8B;
	Mon,  1 Dec 2025 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="V+ej+Dn7"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A864A2C030E
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764579707; cv=none; b=h9hZ4fTKCQjNFHWdDWc4QyrlYulRTWqjaZ4ORRGFLQb7A/oVjb3yxROvOTK47xWerxMCm0lqUkizH711ZHWN37HUwT4MKIItDHb3UqmYqcgauzxxmf9d8L0uDq5SZ4KgBTxb7I/QuhKgo/qWr2thCnCI4MStZx7U3FhZD0duZj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764579707; c=relaxed/simple;
	bh=H+iJGWdBNt2Bhj49PeJmHMqb/ySZVm/J5km51i3J7zU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doAums55cxYdweVU8f+bAfrt28g/rLlmEGBBjIrW5NOzR/m22BKHiVitIPtpNCkNGO6R052IZiETmVg+hhtJgyxWBCoREQM5AH/yj37td0bBvBfma+xSdUUZsjbx/qyNP2Mz97hHKHGrL8JLmWTDD0D59Q/Rb9obvq0bIWhxd2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=V+ej+Dn7; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9B8E220612;
	Mon,  1 Dec 2025 10:01:43 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Kwz3g4ZyC8f; Mon,  1 Dec 2025 10:01:42 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C332020518;
	Mon,  1 Dec 2025 10:01:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C332020518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1764579702;
	bh=xU/9uyJgMBz4E2lc0h8DAmnMIQlhFbBYDZmoeL04dhU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=V+ej+Dn7y4eKYQJw4+5RxKLBoPeaea1q+EjKL2J4Zjml7JtMtme7qh2vz6SMn17ej
	 vOPgxI0Lr6RcXDqkHmz1ERTvEFspduagRKnrO2DtIB2o9AROx6o5hc5fkRrjOYrq1e
	 cCkT61sGD+Oa2TJyFQCnRrJG6PykqnS2FWMpgelqtlpZAnI24DHand2qevl972PaHi
	 LSq3Ec52J0rEl1I7IlBLI4WPp4wV8b2+kyFB2Iv3IqLN03zKX4nGuiNGW0/Wfaou5D
	 W53uicQz9jviceIR1fgsgzAPeIT1tZpniUnWsqzAkQuHU772xY445hDxKHGpr87BwC
	 H0/huOOZ+AqOg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 1 Dec
 2025 10:01:42 +0100
Received: (nullmailer pid 1123638 invoked by uid 1000);
	Mon, 01 Dec 2025 09:01:41 -0000
Date: Mon, 1 Dec 2025 10:01:41 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
CC: <netdev@vger.kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Taehee Yoo
	<ap420073@gmail.com>, Jianbo Liu <jianbol@nvidia.com>, Sabrina Dubroca
	<sd@queasysnail.net>, Herbert Xu <herbert@gondor.apana.org.au>, Leon
 Romanovsky <leonro@nvidia.com>
Subject: Re: [RFC PATCH ipsec 0/2] Fix bonding IPSec races
Message-ID: <aS1ZdbElmUB7VyPU@secunet.com>
References: <20251121151644.1797728-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251121151644.1797728-1-cratiu@nvidia.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

On Fri, Nov 21, 2025 at 05:16:42PM +0200, Cosmin Ratiu wrote:
> These patches are an alternate proposed fix to the bonding IPSec races
> which could result in unencrypted IPSec packets on the wire.
> I'm sending them as RFC based on the discussion with Sabrina on the
> primary approach [1].
> 
> [1] https://lore.kernel.org/netdev/20251113104310.1243150-1-cratiu@nvidia.com/T/#u
> 
> Cosmin Ratiu (2):
>   xfrm: Add explicit offload_handle to some xfrm callbacks
>   bonding: Maintain offloaded xfrm on all devices
> 
>  Documentation/networking/xfrm_device.rst      |  13 +-
>  drivers/net/bonding/bond_main.c               | 284 ++++++++++--------
>  .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  20 +-
>  .../inline_crypto/ch_ipsec/chcr_ipsec.c       |  25 +-
>  .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |  47 +--
>  drivers/net/ethernet/intel/ixgbevf/ipsec.c    |  18 +-
>  .../marvell/octeontx2/nic/cn10k_ipsec.c       |  13 +-
>  .../mellanox/mlx5/core/en_accel/ipsec.c       |  26 +-
>  .../net/ethernet/netronome/nfp/crypto/ipsec.c |  10 +-
>  drivers/net/netdevsim/ipsec.c                 |   8 +-
>  include/linux/netdevice.h                     |   7 +-
>  include/net/bonding.h                         |  22 +-
>  net/xfrm/xfrm_device.c                        |   3 +-
>  net/xfrm/xfrm_state.c                         |   7 +-
>  14 files changed, 295 insertions(+), 208 deletions(-)

There are only minor changes to the IPsec subsystem,
compared to drivers and bonding. Also this is a rather
big change for a fix. So if this patchset should go to
the ipsec tree, we would need some ACKs from the drivers
an bonding maintainers.


