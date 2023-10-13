Return-Path: <netdev+bounces-40675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07867C84D3
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 13:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF5CB2097C
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA1C13FEC;
	Fri, 13 Oct 2023 11:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2j2l7cy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6207613AF9
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 11:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743E8C433C7;
	Fri, 13 Oct 2023 11:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697197605;
	bh=qAcwf2vzDOZ3Xfk7UEfPcHigvrsVR7t/kzoL7cG72No=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u2j2l7cyh1NTpprTnK2JshkjFCPYwGrWVy34oKfjZWfckcMePZNCqBcJ8s8IEtU0g
	 FlqvxUn8hjdCUIl+qzjNbP2OHQ9moyam0a8TOV94rRvv3SpJz+WmHpXPdgmNbtGWqU
	 k7xin/vq1BOOjQGUStL781ytRt7oNedBm4btgbxkdN3ezpYO3HQRe/6bujNnXDhXVp
	 kkZ42zaM2crRWNM4vTX9l1DwEkRHGRtvp9cxbUDpGDlxY44ISotaoiVION7ZruDO2l
	 it6bCrO/jXhCpTVu/Mh/NIeYxuOxFOxgJ7yXarSOb5JhA1zQnx4ndmCb6Q4lvQabOk
	 Ds0cpMN2sV21w==
Date: Fri, 13 Oct 2023 13:46:41 +0200
From: Simon Horman <horms@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: netdev@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>
Subject: Re: [PATCH v3] net: dsa: bcm_sf2: Fix possible memory leak in
 bcm_sf2_mdio_register()
Message-ID: <20231013114641.GG29570@kernel.org>
References: <20231011032419.2423290-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011032419.2423290-1-ruanjinjie@huawei.com>

On Wed, Oct 11, 2023 at 11:24:19AM +0800, Jinjie Ruan wrote:
> In bcm_sf2_mdio_register(), the class_find_device() will call get_device()
> to increment reference count for priv->master_mii_bus->dev if
> of_mdio_find_bus() succeeds. If mdiobus_alloc() or mdiobus_register()
> fails, it will call get_device() twice without decrement reference count
> for the device. And it is the same if bcm_sf2_mdio_register() succeeds but
> fails in bcm_sf2_sw_probe(), or if bcm_sf2_sw_probe() succeeds. If the
> reference count has not decremented to zero, the dev related resource will
> not be freed.
> 
> So remove the get_device() in bcm_sf2_mdio_register(), and call
> put_device() if mdiobus_alloc() or mdiobus_register() fails and in
> bcm_sf2_mdio_unregister() to solve the issue.
> 
> And as Simon suggested, unwind from errors for bcm_sf2_mdio_register() and
> just return 0 if it succeeds to make it cleaner.
> 
> Fixes: 461cd1b03e32 ("net: dsa: bcm_sf2: Register our slave MDIO bus")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Simon Horman <horms@kernel.org>

Thanks, this addresses my concerns around v2.

Reviewed-by: Simon Horman <horms@kernel.org>

