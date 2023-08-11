Return-Path: <netdev+bounces-26597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D552B7784A8
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 02:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E78F281EA9
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 00:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353A37E9;
	Fri, 11 Aug 2023 00:47:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7138371
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8340C433C7;
	Fri, 11 Aug 2023 00:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691714839;
	bh=IaxhkhHPZQw6m7eWITh2gsrzur8oY47l3tCN2cv5VUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z15d1G7YV7/9qjOr4fju08cebRbQIW5i8BmkTNd4sJnXdNJphUGOsEM1tgVCqDBbB
	 f/8F/kmNYcr/fDXZeNJN8KDXgUwtn4PsbjEMiHY9JDApND5zq1PnWjF//kWoXfRMlm
	 sFqHVVi4rko2HUebYbjh8wmScub5yQGGCf6iGFK4Zrv5p0Wzu2uexOFpL5lq1iyhUA
	 WjjFRLGOutZdGs2R7YDkKRD0BBce1stIyKB2ZqeeV5kM/wr+PsD/ef9/Tb2Xk6HwUM
	 OQ6RRqoNiLxN15+WPYCVuYPKDju/1tkTXGrrxtL6APJl5Anb/P7Fd/SvUe1JqzXHGf
	 Ed0cR9TOH9KDg==
Date: Thu, 10 Aug 2023 17:47:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Manish Chopra <manishc@marvell.com>
Cc: <netdev@vger.kernel.org>, <aelior@marvell.com>, <palok@marvell.com>,
 <njavali@marvell.com>, <skashyap@marvell.com>, <jmeneghi@redhat.com>,
 <yuval.mintz@qlogic.com>, <skalluru@marvell.com>, <pabeni@redhat.com>,
 <edumazet@google.com>, <horms@kernel.org>, David Miller
 <davem@davemloft.net>
Subject: Re: [PATCH v2 net] qede: fix firmware halt over suspend and resume
Message-ID: <20230810174718.38190258@kernel.org>
In-Reply-To: <20230809134339.698074-1-manishc@marvell.com>
References: <20230809134339.698074-1-manishc@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Aug 2023 19:13:39 +0530 Manish Chopra wrote:
> While performing certain power-off sequences, PCI drivers are
> called to suspend and resume their underlying devices through
> PCI PM (power management) interface. However this NIC hardware
> does not support PCI PM suspend/resume operations so system wide
> suspend/resume leads to bad MFW (management firmware) state which
> causes various follow-up errors in driver when communicating with
> the device/firmware afterwards.

Does the FW end up recovering? That could still be preferable
to rejecting suspend altogether. Reject is a big hammer,
I'm a bit worried it will cause a regression in stable.

> To fix this driver implements PCI PM suspend handler to indicate
> unsupported operation to the PCI subsystem explicitly, thus avoiding
> system to go into suspended/standby mode.
> 
> Fixes: 2950219d87b0 ("qede: Add basic network device support")
> Cc: David Miller <davem@davemloft.net>
> Signed-off-by: Manish Chopra <manishc@marvell.com>
> Signed-off-by: Alok Prasad <palok@marvell.com>
> ---
> V1->V2:
> * Replace SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS
> ---
>  drivers/net/ethernet/qlogic/qede/qede_main.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
> index d57e52a97f85..18ae7af1764c 100644
> --- a/drivers/net/ethernet/qlogic/qede/qede_main.c
> +++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
> @@ -177,6 +177,18 @@ static int qede_sriov_configure(struct pci_dev *pdev, int num_vfs_param)
>  }
>  #endif
>  
> +static int __maybe_unused qede_suspend(struct device *dev)
> +{
> +	if (!dev)
> +		return -ENODEV;

Can dev really be NULL here? That wouldn't make sense, what's the
driver supposed to do in such case?
-- 
pw-bot: cr

