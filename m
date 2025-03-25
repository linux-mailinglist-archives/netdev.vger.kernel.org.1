Return-Path: <netdev+bounces-177424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E15A70227
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DAB57A3CAF
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DE1258CCD;
	Tue, 25 Mar 2025 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnFvzxnf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E819E7F8;
	Tue, 25 Mar 2025 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909065; cv=none; b=FxlCQ7GArnjR8sDs/YoE25fuG0L/kRsIPAyvCxBpV1bKWDuqa6bbVAqKqvr0vj+rAC58VMcMQpUZvEbbHSeq7t0W13xtz2KKuYiNtQVhlXLeROqE6dxSdejWpS+1On0mvjauOLFF8wisk+O38E3avVsXTGo9Q6oLw1Z2UrsM4X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909065; c=relaxed/simple;
	bh=wozwOKQiaMagwbpwK6NFNx/fOsvnFGH61CvbZNCe3Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzlZHlOU2Aw4k8qmUvRsvgCy1qUnUyv4FO803R/Horw6xtcDJJQ7a8RAm+dH4v4i8H34JZodpUMnZLdCrlLLVpYVIEW9mvj2amjGhJvAMlog5n5aUjRfUinQtZ8Z1yMnL3wJ2dp2i03rIDSD0WffRLbiyanCFnLPZte0rBLMY08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnFvzxnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FCEC4CEE4;
	Tue, 25 Mar 2025 13:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742909064;
	bh=wozwOKQiaMagwbpwK6NFNx/fOsvnFGH61CvbZNCe3Gg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RnFvzxnfSxNj3kF9oZmvyMhC+P8+Gb2kSHobDmo6DHmG/FPs8kGz3DrKMfesNMEn+
	 JiX6c5Cmhlqf+1fNHrDLMcngAqk7qkN+VfLZ75dbGbt44A0/uQkibzR/C9ZFkV7m39
	 Utbzgkf1fldCv1DftWRqK70jqDUDMYBVLyfmQbspaD5wJEKUN2WaTGrJUTACpsjtxI
	 NNs2rIAhGz6X2FuC9Q9MRmo7VIwV2EYXwPAfEMZAcLweB/NDSX8L5vwka451h8FV4e
	 6oy5XZp8k2RsrVkAifyLRHfNXLaJYpvrkuG7yyU7D8QVv7/xst2SVEaLCCdsfXdNrD
	 kBNf3rQg2iTzA==
Date: Tue, 25 Mar 2025 06:24:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>, Cosmin
 Ratiu <cratiu@nvidia.com>, linux-kernel@vger.kernel.org, Liang Li
 <liali@redhat.com>
Subject: Re: [PATCH net] bonding: use permanent address for MAC swapping if
 device address is same
Message-ID: <20250325062416.4d60681b@kernel.org>
In-Reply-To: <20250319080947.2001-1-liuhangbin@gmail.com>
References: <20250319080947.2001-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Mar 2025 08:09:47 +0000 Hangbin Liu wrote:
> Similar with a951bc1e6ba5 ("bonding: correct the MAC address for "follow"
> fail_over_mac policy"). The fail_over_mac follow mode requires the former=
ly
> active slave to swap MAC addresses with the newly active slave during
> failover. However, the slave's MAC address can be same under certain
> conditions:
>=20
> 1) ip link set eth0 master bond0
>    bond0 adopts eth0's MAC address (MAC0).
>=20
> 1) ip link set eth1 master bond0

nit: 2)

>    eth1 is added as a backup with its own MAC (MAC1).
>=20
> 3) ip link set eth0 nomaster
>    eth0 is released and restores its MAC (MAC0).
>    eth1 becomes the active slave, and bond0 assigns MAC0 to eth1.

I don't know much about bonding, but this seems like a problem already
to me. Assuming both eth0 and eth1 are on the same segment we now have
two interfaces with the same MAC on the network. Shouldn't we override
the address of eth0 to a random one when it leaves?

> 4) ip link set eth0 master bond0
>    eth0 is re-added to bond0, but both eth0 and eth1 now have MAC0,
>    breaking the follow policy.
>=20
> To resolve this issue, we need to swap the new active slave=E2=80=99s per=
manent
> MAC address with the old one. The new active slave then uses the old
> dev_addr, ensuring that it matches the bond address. After the fix:
>=20
> 5) ip link set bond0 type bond active_slave eth0
>    dev_addr is the same, swap old active eth1's MAC (MAC0) with eth0.
>    Swap new active eth0's permanent MAC (MAC0) to eth1.
>    MAC addresses remain unchanged.
>=20
> 6) ip link set bond0 type bond active_slave eth1
>    dev_addr is the same, swap the old active eth0's MAC (MAC0) with eth1.
>    Swap new active eth1's permanent MAC (MAC1) to eth0.
>    The MAC addresses are now correctly differentiated.
>=20
> Fixes: 3915c1e8634a ("bonding: Add "follow" option to fail_over_mac")
> Reported-by: Liang Li <liali@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 9 +++++++--
>  include/net/bonding.h           | 8 ++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index e45bba240cbc..9cc2348d4ee9 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1107,8 +1107,13 @@ static void bond_do_fail_over_mac(struct bonding *=
bond,
>  			old_active =3D bond_get_old_active(bond, new_active);
> =20
>  		if (old_active) {
> -			bond_hw_addr_copy(tmp_mac, new_active->dev->dev_addr,
> -					  new_active->dev->addr_len);
> +			if (bond_hw_addr_equal(old_active->dev->dev_addr, new_active->dev->de=
v_addr,
> +					       new_active->dev->addr_len))
> +				bond_hw_addr_copy(tmp_mac, new_active->perm_hwaddr,
> +						  new_active->dev->addr_len);
> +			else
> +				bond_hw_addr_copy(tmp_mac, new_active->dev->dev_addr,
> +						  new_active->dev->addr_len);
>  			bond_hw_addr_copy(ss.__data,
>  					  old_active->dev->dev_addr,
>  					  old_active->dev->addr_len);
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 8bb5f016969f..de965c24dde0 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -463,6 +463,14 @@ static inline void bond_hw_addr_copy(u8 *dst, const =
u8 *src, unsigned int len)
>  	memcpy(dst, src, len);
>  }
> =20
> +static inline bool bond_hw_addr_equal(const u8 *dst, const u8 *src, unsi=
gned int len)
> +{
> +	if (len =3D=3D ETH_ALEN)
> +		return ether_addr_equal(dst, src);
> +	else
> +		return (memcmp(dst, src, len) =3D=3D 0);

looks like this is on ctrl path, just always use memcmp directly ?
not sure if this helper actually.. helps.

> +}
> +
>  #define BOND_PRI_RESELECT_ALWAYS	0
>  #define BOND_PRI_RESELECT_BETTER	1
>  #define BOND_PRI_RESELECT_FAILURE	2
--=20
pw-bot: cr

