Return-Path: <netdev+bounces-113775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D4193FE25
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135681C2265D
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 19:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D009F18787A;
	Mon, 29 Jul 2024 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X8lo3SYY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E55187858;
	Mon, 29 Jul 2024 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722280614; cv=none; b=ApfV8nVz7CFmvEPM0sW8ayeaUssNk8Tctq0fLFuGkjpNRhwYnpQF11JW8WT0wD9QKEPmojyvjdb/jaLyxgqQu5EyMVmLgvuWSDA/BlpkZkcVXxbNbViaWp/csoKNXAQiqUmaM21eamulM3C8Xw/dspKhOKR6pi9ybBZGvsLL8MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722280614; c=relaxed/simple;
	bh=9WfXrIZy44aHGHWrDoHRUQ7UNxV2aK8lea1dAKUdivc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfnBRhnksOXUtzz2lw7Yz6AVtLDNxBa+zF7WrGmFqH9ik8gscIrFnpLEH0LMyYyskErVN9x4SOnalhaOTCRIs9AnmAkDOUlcb7zBBhsHCDsv05UbTzYKBP+CkG9ptn1pWhseAN7wddp17I55FwrfsUE7qgLu8d3Uc82kXK4IdhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X8lo3SYY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EXiZPCkGG/WY8978lhHpm1gh1lZhSm6kt6nPRKAeWA4=; b=X8lo3SYYHf+5H6okvB6WRG6yDF
	eH0U1L7ulr3YiTXtcQsjdsPxhRALaR7Us8iYJdilKkWrucg9/2Bwjy0n7fzMw02zYn/1tJ+JVKlYy
	NgYx4AGrE8naVtvq3pmoO0kzO8GFiS7p1vebm/NEPgGyGR8wXprVPcixU/g2OJTane8Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYVrT-003Uy5-Ol; Mon, 29 Jul 2024 21:16:47 +0200
Date: Mon, 29 Jul 2024 21:16:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
	parav@nvidia.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] vdpa/mlx5: Add the support of set mac address
Message-ID: <aa0ffd28-bfb8-4b25-8730-a522861bca98@lunn.ch>
References: <20240729052146.621924-1-lulu@redhat.com>
 <20240729052146.621924-4-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729052146.621924-4-lulu@redhat.com>

> +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev,
> +			      const struct vdpa_dev_set_config *add_config)
> +{
> +	struct virtio_net_config *config;
> +	struct mlx5_core_dev *pfmdev;
> +	struct mlx5_vdpa_dev *mvdev;
> +	struct mlx5_vdpa_net *ndev;
> +	struct mlx5_core_dev *mdev;
> +	int err = -EINVAL;

I would say this should also be EOPNOTSUPP.

> +
> +	mvdev = to_mvdev(dev);
> +	ndev = to_mlx5_vdpa_ndev(mvdev);
> +	mdev = mvdev->mdev;
> +	config = &ndev->config;
> +
> +	down_write(&ndev->reslock);
> +	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> +		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
> +		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
> +		if (!err)
> +			ether_addr_copy(config->mac, add_config->net.mac);
> +	}
> +
> +	up_write(&ndev->reslock);
> +	return err;


    Andrew

---
pw-bot: cr

