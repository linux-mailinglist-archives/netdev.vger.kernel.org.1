Return-Path: <netdev+bounces-24679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A690771056
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 17:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F73282268
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 15:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A64EC2C4;
	Sat,  5 Aug 2023 15:23:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424F1A92A
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 15:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431E2C433C8;
	Sat,  5 Aug 2023 15:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691248999;
	bh=LpVn5xN6a1WvaDPq4mSJg3/3qrkYfD7C01pkO+QsnkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GbM74WrspqL6oRv0H5qUnpbO+Ty/dZbMDuq1T9zgm780JoCJxQrcLvovIUAQNzq81
	 fLFSJAK4t2JtZBPnkeQ/U+vB9uYFFSloQF261doQ/tca7L2TKklOhaAbqe/BR7cnJJ
	 RLbyJLLImGSYbxQKGjrY4arp7jphiUVZ/u3b+bYmp344rKYuCuCSB5Wzm3OHogt8RE
	 giKfpeiv4mXB691XfBLKUeIGZBFCToE4suKpRJT5izptBotEY8/F+I29StxrY1SrgV
	 tJLzdlxQmSdbkuJki4twiwjXwDdN+AQrJgJunkIqEpQkchfpHJqs/s1vdgh+A8Fm0C
	 HfuOEXucBi4vw==
Date: Sat, 5 Aug 2023 17:23:15 +0200
From: Simon Horman <horms@kernel.org>
To: Manish Chopra <manishc@marvell.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, aelior@marvell.com,
	palok@marvell.com, njavali@marvell.com, skashyap@marvell.com,
	jmeneghi@redhat.com, David Miller <davem@davemloft.net>,
	Yuval Mintz <Yuval.Mintz@qlogic.com>,
	Sudarsana Kalluru <Sudarsana.Kalluru@qlogic.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net] qede: fix firmware halt over suspend and resume
Message-ID: <ZM5pYxWOhEeupUfy@vergenet.net>
References: <20230804115111.84988-1-manishc@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804115111.84988-1-manishc@marvell.com>

+ Yuval Mintz, Sudarsana Kalluru, Paolo Abeni and Eric Dumazet

  As per the output of
  ./scripts/get_maintainer.pl --git-min-percent 25 this.patch
  which is the preferred method to determine the CC list for
  Networking patches. LKML can, in general, be excluded.

On Fri, Aug 04, 2023 at 05:21:11PM +0530, Manish Chopra wrote:
> While performing certain power-off sequences, PCI drivers are
> called to suspend and resume their underlying devices through
> PCI PM (power management) interface. However this NIC hardware
> does not support PCI PM suspend/resume operations so system wide
> suspend/resume leads to bad MFW (management firmware) state which
> causes various follow-up errors in driver when communicating with
> the device/firmware afterwards.
> 
> To fix this driver implements PCI PM suspend handler to indicate
> unsupported operation to the PCI subsystem explicitly, thus avoiding
> system to go into suspended/standby mode.
> 
> Fixes: 2950219d87b0 ("qede: Add basic network device support")
> Cc: David Miller <davem@davemloft.net>
> Signed-off-by: Manish Chopra <manishc@marvell.com>
> Signed-off-by: Alok Prasad <palok@marvell.com>
> ---
>  drivers/net/ethernet/qlogic/qede/qede_main.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
> index d57e52a97f85..35ef187e4825 100644
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
> +
> +	dev_info(dev, "Device does not support suspend operation\n");
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(qede_pm_ops, qede_suspend, NULL);

The comment above the definition of SIMPLE_DEV_PM_OPS says
that it is deprecated and that DEFINE_SIMPLE_DEV_PM_OPS
should be used instead.

> +
>  static const struct pci_error_handlers qede_err_handler = {
>  	.error_detected = qede_io_error_detected,
>  };
> @@ -191,6 +203,7 @@ static struct pci_driver qede_pci_driver = {
>  	.sriov_configure = qede_sriov_configure,
>  #endif
>  	.err_handler = &qede_err_handler,
> +	.driver.pm = &qede_pm_ops,
>  };
>  
>  static struct qed_eth_cb_ops qede_ll_ops = {

-- 
pw-bot: changes-requested


