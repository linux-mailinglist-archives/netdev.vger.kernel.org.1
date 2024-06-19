Return-Path: <netdev+bounces-104712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A0C90E168
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 03:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D1828451B
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 01:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3137A18E20;
	Wed, 19 Jun 2024 01:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYnNPb8m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D16DDDC0
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718761802; cv=none; b=DRaC0YYrELH76TvUtPuaMONDJU9aETwdjSXLwPSVCVTrdKKzT/005C4Ot4q8q2xkw8d6gjSyBR0RikEEFp1ZOa6E6OZzwuOf3TJb79/TUa1us/VVn7/yAhEwyJBlvrulDS5bj7lBd7zuvv6/gBZzLGz9fI5rSdQ5RcJ76756oVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718761802; c=relaxed/simple;
	bh=I5QCYiKa4u+XioOSBz1G6Mwn9pjOyt80EOpYWDTtEr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLMN4Fid6y0U0hL3D0SjHMAVbIRBy+CqcdghH2D3sWIYkl5wexMLUN+l+Sg6Jq7q+htQPwREcc6FAq9EMzozh0vPBDrRouf71A3l2PAAk2zk8/Z6qBXW0PgSsxXwSBSik73k//wHlg6RqZPdjOJq7IKf/A++qziSfKZPYlERO6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYnNPb8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2005BC3277B;
	Wed, 19 Jun 2024 01:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718761801;
	bh=I5QCYiKa4u+XioOSBz1G6Mwn9pjOyt80EOpYWDTtEr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IYnNPb8muoUnff0KCPfrw4rH5aoq41kYSrUHLZ65qa7ZyP1caBUvX7L6Ue5AaxKpC
	 YENY+53pdCvpL2DsFHwk6+gZr5qy+Mnn8KF7BX0JdHawz60Fu3WctR4z899RkKAs2U
	 6HxURDwboAUFhwpSu+ihqouE62YdCbLQ+Ij+YVQFZ1XGTN2wp/I7hsicp/EIBZpdwD
	 exxb7B2au06CD20BI6lwVhsC0Mu3iWAevcN/8cCLVHyFxdZUdphweKmR0Xt5aF5p2y
	 t/Hvu0Po3NcSIo6y+M41s7Mq0DEIdHFwDLLUGOJ93nSync5qE6uOx/vxNkgpo1lGm8
	 ei8LGP90JXrpQ==
Date: Tue, 18 Jun 2024 18:50:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
 jiri@resnulli.us, pabeni@redhat.com, linux@armlinux.org.uk,
 hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v11 4/7] net: tn40xx: add basic Tx handling
Message-ID: <20240618185000.1ecc561f@kernel.org>
In-Reply-To: <20240618051608.95208-5-fujita.tomonori@gmail.com>
References: <20240618051608.95208-1-fujita.tomonori@gmail.com>
	<20240618051608.95208-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 14:16:05 +0900 FUJITA Tomonori wrote:
> + * As our benchmarks shows, it adds 1.5 Gbit/sec to NIS's throughput.

nit: NIC's

> +static int tn40_start_xmit(struct sk_buff *skb, struct net_device *ndev)

return type should be netdev_tx_t ?

> +	netif_trans_update(ndev);

I don't think you need to call this, core sets the trans time
all by itself

> +static void tn40_link_changed(struct tn40_priv *priv)
> +{
> +	u32 link = tn40_read_reg(priv,
> +				 TN40_REG_MAC_LNK_STAT) & TN40_MAC_LINK_STAT;
> +
> +	netdev_dbg(priv->ndev, "link changed %u\n", link);

shouldn't this call netif_carrier_on / off?

> +		mdelay(100);

there are 3 more mdelays in the driver, all seem like candidates for
being msleep

