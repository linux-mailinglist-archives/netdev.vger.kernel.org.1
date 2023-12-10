Return-Path: <netdev+bounces-55605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4A980BA6A
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 12:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775DA280CB2
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 11:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0A28820;
	Sun, 10 Dec 2023 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzqVkRhx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E501FAA
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 11:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF7DC433C8;
	Sun, 10 Dec 2023 11:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702208258;
	bh=fQuCk+8Fl3NLJUs5k6QdH8GKGyoRU1ec77I08QQKBsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KzqVkRhxhGAAfxO3ObXGj++ChnacncyHIBrvDGjGA5UgtU2NNfDsGOngKdIpkH5mA
	 +Oey4RgzeQEmi6WCMgDlBef2l3gJvgCtyKfn1A4Ddh+lg7saa644NaRXGHyh0gW7YR
	 k0RzZ1vxx7mLF/SEAv70k+zPM8TSQaCMEUPbEG8AFRptPwa2u18NKo1S8AfTI3wTRA
	 OZr4Zx02TMzOvxHohXB7cqB25HzWMCP41UsctOHdDA5ElqhkMOCqN/IEWrXpYw/VY6
	 KpBiWjv5P9aPqhLARX+pVbnGz1dPHwFWP+WykkGJYl0uerPl0ihj26prHUUXohFYyW
	 mUTmGz4xFlKyA==
Date: Sun, 10 Dec 2023 11:37:32 +0000
From: Simon Horman <horms@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
	vimleshk@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
	pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
	wizhao@redhat.com, kheib@redhat.com, konguyen@redhat.com,
	Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 1/4] octeon_ep: add PF-VF mailbox
 communication
Message-ID: <20231210113732.GF5817@kernel.org>
References: <20231209081450.2613561-1-srasheed@marvell.com>
 <20231209081450.2613561-2-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209081450.2613561-2-srasheed@marvell.com>

On Sat, Dec 09, 2023 at 12:14:47AM -0800, Shinas Rasheed wrote:
> Implement mailbox communication between PF and VFs.
> PF-VF mailbox is used for all control commands from VF to PF and
> asynchronous notification messages from PF to VF.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c

...

> @@ -1315,6 +1335,7 @@ static void octep_device_cleanup(struct octep_device *oct)
>  		oct->mbox[i] = NULL;
>  	}
>  
> +	octep_delete_pfvf_mbox(oct);
>  	octep_ctrl_net_uninit(oct);
>  	cancel_delayed_work_sync(&oct->hb_task);
>  
> @@ -1411,6 +1432,13 @@ static int octep_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		goto err_octep_config;
>  	}
>  
> +	err = octep_setup_pfvf_mbox(octep_dev);
> +	if (err) {
> +		dev_err(&pdev->dev, " pfvf mailbox setup failed\n");
> +		octep_ctrl_net_uninit(octep_dev);
> +		return err;

Hi Shinas,

This seems inconsistent with other error handling in this function, I
suspect it is leaking resources. And even if it does not, it's likely to
lead to such problems as this function is updated in future.  Please
consider consistently handling error unwinding using goto labels in this
function.

I think that means either making sure that octep_delete_pfvf_mbox() can
handle the case whereby octep_setup_pfvf_mbox() fails. Or including) the
steps taken by octep_device_cleanup() in the unwind ladder provided by goto
labels (which could be a separate patch, and I suspect to be the best
approach). But I could well be wrong.

> +	}
> +
>  	octep_ctrl_net_get_info(octep_dev, OCTEP_CTRL_NET_INVALID_VFID,
>  				&octep_dev->conf->fw_info);
>  	dev_info(&octep_dev->pdev->dev, "Heartbeat interval %u msecs Heartbeat miss count %u\n",

...

