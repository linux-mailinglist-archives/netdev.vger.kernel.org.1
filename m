Return-Path: <netdev+bounces-18277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01307563DD
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 15:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086F82811B3
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 13:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB574AD5D;
	Mon, 17 Jul 2023 13:10:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E6AAD50
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 13:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BC6C433C8;
	Mon, 17 Jul 2023 13:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689599409;
	bh=bbIvg+6N9/Fwez4K2lqCRQuVEWn56jz9r7IzmBSXJlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tdcq1f4qS70rQgHAJgZ9j2AXUnOXfWAmrrhl1QgMkw9GV+R5Y5bZA/OnuLjVkC5ez
	 hjVsRurVXkMYLSZvDiKY7xZ7YIjbO4BJhygezynysBArrhXNdddA/Q9RaRHqG6xRtO
	 m1mX1gxp+7UBkfByV8BqUR2e228d0GfCgRkcgTiCzOO3Qubp3PR1ioTpOFNajpVMFt
	 XFKdmGOgPwWa/KBsIyLZMjzPWxU4/hN/cd780SJXvJ3vEAWEl85phKbytAr7FmkfiK
	 0D9HdiuFl2I2e7Cn9UzmfUlRPBpO0JKaoSDboYpUqFhMUaqJx/s87zFJZlzlMvwfwv
	 TjUkYnJaO6EWQ==
Date: Mon, 17 Jul 2023 16:10:06 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ganesh G R <ganeshgr@linux.ibm.com>, Moshe Shemesh <moshe@nvidia.com>
Cc: saeedm@nvidia.com, netdev@vger.kernel.org, oohall@gmail.com,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>
Subject: Re: EEH recovery failing on mlx5 card
Message-ID: <20230717131006.GA346905@unreal>
References: <c13fa245-64ed-f87c-fd1e-e618fe017359@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c13fa245-64ed-f87c-fd1e-e618fe017359@linux.ibm.com>

+ Moshe

On Mon, Jul 17, 2023 at 12:48:37PM +0530, Ganesh G R wrote:
> Hi,
> 
> mlx5 cards are failing to recover from PCI errors, Upon investigation we found that the
> driver is trying to do MMIO in the middle of EEH error handling.
> The following fix in mlx5_pci_err_detected() is fixing the issue, Do you think its the right fix?
> 
> @@ -1847,6 +1847,7 @@ static pci_ers_result_t mlx5_pci_err_detected(struct pci_dev *pdev,
>         mlx5_unload_one(dev, true);
>         mlx5_drain_health_wq(dev);
>         mlx5_pci_disable_device(dev);
> +       cancel_delayed_work_sync(&clock->timer.overflow_work);
>         res = state == pci_channel_io_perm_failure ?
>                 PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_NEED_RESET;
> 
> Regards
> Ganesh

