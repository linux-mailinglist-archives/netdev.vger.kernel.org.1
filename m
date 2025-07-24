Return-Path: <netdev+bounces-209771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A7DB10B9F
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0359B1CE8357
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667D72D375B;
	Thu, 24 Jul 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/oJr96K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424F92DA74D
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364093; cv=none; b=kXAflj/DVj5WHhpxLER1jldXEFN29nqBbaQDDfc8RPgoJZHiyrAv6ktBxDWs5s5YbJrD1133hcuf7D4JJVWA/jHCAzGQdFYZkdkfmrcgRbzBB2+sv5N857lq6qsBT9LWJNEKVN1dy8/NVKUmqYDkAX7xQ+K9itbQKPkXtjOXp6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364093; c=relaxed/simple;
	bh=MR+tq1+SqcEC099yOTi4MJrIyC+5GeZO2XX/YkrVHDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ts4YnYPMtKl7MqjAye99u5tn3wiIpSM7T1wgQL0THCibAS0+gY6bd+FEzq6zbfYwNyVv4jtveTuqRjXzSqkEb2OIJPa3njOrOKlRaCDJlJffHylteNL2aKDikIrcMsTXH4cARFjEF2gGSc4hfXLrlrVaFYWvMVRoJWzZXqXbE98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/oJr96K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E03C4CEED;
	Thu, 24 Jul 2025 13:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753364092;
	bh=MR+tq1+SqcEC099yOTi4MJrIyC+5GeZO2XX/YkrVHDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/oJr96KUKFSd2w+6cqnnq/eC3mfIN5aAhyNwMU6/zYg5oMbW23MfjrytQxCclpAO
	 AK6xblx85oCRFdBS7I+eyPK3e9oKbHh+52qMEzgTc3jmk1guNcN3q2XpvgtPmApZ9P
	 pBKU4ijhxwlNRfeV15nvs90tXFh1FwAdmPtG7rY+Eq06+gahueZ2c1CD5wlliuXNL/
	 1CEoEjAnuU0u3AKzzvnJ4UbG609J/fA4dSWdJIA5+7x6EkI2+IGtObmgyXpER8IRGg
	 t3INDWYZhS0msyrmieWaSVZ4bB3pzKNOvSG63Ul3P/WUIrhKP6r+/zRiSGrxpAJemz
	 RtsUQ+v7PXsRA==
Date: Thu, 24 Jul 2025 14:34:46 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5.0 15/19] net/mlx5e: Add PSP steering in local
 NIC RX
Message-ID: <20250724133446.GM1150792@horms.kernel.org>
References: <20250723203454.519540-1-daniel.zahka@gmail.com>
 <20250723203454.519540-36-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723203454.519540-36-daniel.zahka@gmail.com>

On Wed, Jul 23, 2025 at 01:34:46PM -0700, Daniel Zahka wrote:
> From: Raed Salem <raeds@nvidia.com>
> 
> Introduce decrypt FT, the RX error FT, and the default rules.
> 
> The PSP (PSP) RX decrypt flow table is pointed by the TTC
> (Traffic Type Classifier) UDP steering rules.
> The decrypt flow table has two flow groups. The first flow group
> keeps the decrypt steering rule programmed always when PSP packet is
> recognized using the dedicated udp destination port number 1000, if
> packet is decrypted then a PSP marker is set in metadata_regB[30].
> The second flow group has a default rule to forward all non-offloaded
> PSP packet to the TTC UDP default RSS TIR.
> 
> The RX error flow table is the destination of the decrypt steering rules in
> the PSP RX decrypt flow table. It has two fixed rule one with single copy
> action that copies psp_syndrome to metadata_regB[23:29]. The PSP marker
> and syndrome is used to filter out non-psp packet and to return the PSP
> crypto offload status in Rx flow. The marker is used to identify such
> packet in driver so the driver could set SKB PSP metadata. The destination
> of RX error flow table is the TTC UDP default RSS TIR. The second rule will
> drop packets that failed to be decrypted (like in case illegal SPI or
> expired SPI is used).
> 
> Signed-off-by: Raed Salem <raeds@nvidia.com>
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

...

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c

> +static int accel_psp_fs_rx_ft_get(struct mlx5e_psp_fs *fs, enum accel_fs_psp_type type)
> +{
> +	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(fs->fs, false);

Below it is assumed that fs may be NULL.
But above it is dereference unconditionally.
This does not seem consistent.

> +	struct mlx5e_accel_fs_psp_prot *fs_prot;
> +	struct mlx5_flow_destination dest = {};
> +	struct mlx5e_accel_fs_psp *accel_psp;
> +	int err = 0;
> +
> +	if (!fs || !fs->rx_fs)
> +		return -EINVAL;
> +
> +	accel_psp = fs->rx_fs;
> +	fs_prot = &accel_psp->fs_prot[type];
> +	mutex_lock(&fs_prot->prot_mutex);
> +	if (fs_prot->refcnt++)
> +		goto out;
> +
> +	/* create FT */
> +	err = accel_psp_fs_rx_create(fs, type);
> +	if (err) {
> +		fs_prot->refcnt--;
> +		goto out;
> +	}
> +
> +	/* connect */
> +	dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
> +	dest.ft = fs_prot->ft;
> +	mlx5_ttc_fwd_dest(ttc, fs_psp2tt(type), &dest);
> +
> +out:
> +	mutex_unlock(&fs_prot->prot_mutex);
> +	return err;
> +}

...

