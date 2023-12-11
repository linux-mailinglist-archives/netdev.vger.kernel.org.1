Return-Path: <netdev+bounces-55768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D8680C38B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 09:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2DA1F20F33
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 08:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532F620DF7;
	Mon, 11 Dec 2023 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcDKzfe9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379D8125DC
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 08:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44DBC433C7;
	Mon, 11 Dec 2023 08:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702284417;
	bh=zjlRUhnaZnjsZZughQI/BxjLVo+4gBWoqW3Nl+z5Khw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcDKzfe9rsmIXuu2kqeOHU7yRm2NbwkVuULN0FrjITTjlxqmzO422rRbPkyU8nL4L
	 UD+X9olvrhTq7AGWbcm4s9wEwH/am42xmw/Wwhro9OC85ij8IXXU0D7Bf/cDVeBWFN
	 STOVjZIn/TIkJ9MLNOBNFRHaGE6ovx32H5ebWrpYvstzSSonepFSKAwzII3+VSZviS
	 9SJf/NMBMoajszoJdo7OsdrMw0krOIB/J94WbDMJuryfWNoqMA6JCHouatti3sNbDG
	 zXWSvluvyvp/HH7gLjm0K2jsmu5lJPaNQkWX+IoMKXirMi8vqnvf+IKjPV9YL0pG0o
	 yO+uop5kGmZMA==
Date: Mon, 11 Dec 2023 10:46:52 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
	vimleshk@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
	pabeni@redhat.com, horms@kernel.org, kuba@kernel.org,
	davem@davemloft.net, wizhao@redhat.com, kheib@redhat.com,
	konguyen@redhat.com, Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v3 2/4] octeon_ep: PF-VF mailbox version support
Message-ID: <20231211084652.GC4870@unreal>
References: <20231211063355.2630028-1-srasheed@marvell.com>
 <20231211063355.2630028-3-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211063355.2630028-3-srasheed@marvell.com>

On Sun, Dec 10, 2023 at 10:33:53PM -0800, Shinas Rasheed wrote:
> Add PF-VF mailbox initial version support
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---

<...>

> @@ -28,10 +28,18 @@ static void octep_pfvf_validate_version(struct octep_device *oct,  u32 vf_id,
>  {
>  	u32 vf_version = (u32)cmd.s_version.version;
>  
> -	if (vf_version <= OCTEP_PFVF_MBOX_VERSION_V1)
> -		rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
> +	dev_dbg(&oct->pdev->dev, "VF id:%d VF version:%d PF version:%d\n",
> +		vf_id, vf_version, OCTEP_PFVF_MBOX_VERSION_CURRENT);
> +	if (vf_version < OCTEP_PFVF_MBOX_VERSION_CURRENT)
> +		rsp->s_version.version = vf_version;
>  	else
> -		rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
> +		rsp->s_version.version = OCTEP_PFVF_MBOX_VERSION_CURRENT;
> +
> +	oct->vf_info[vf_id].mbox_version = rsp->s_version.version;
> +	dev_dbg(&oct->pdev->dev, "VF id:%d negotiated VF version:%d\n",
> +		vf_id, oct->vf_info[vf_id].mbox_version);
> +
> +	rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
>  }

<...>

> +#define OCTEP_PFVF_MBOX_VERSION_CURRENT	OCTEP_PFVF_MBOX_VERSION_V1

This architecture design is unlikely to work in the real world unless
you control both PF and VF environment. Mostly PF is running some old
legacy distribution while VFs run more modern OS and this check will
prevent to run new driver in VF.

Thanks

