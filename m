Return-Path: <netdev+bounces-20587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F957602AD
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703EF2815FC
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 22:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3E6125CC;
	Mon, 24 Jul 2023 22:50:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294BA107B2
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 22:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE67C433C8;
	Mon, 24 Jul 2023 22:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690239014;
	bh=6ZJqXfhIIPmgaDylEA2+I5u+ebCDmDx0tMohgbBRdJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qz3rFA4zVCcZWyTePhfmdbn+L7Ljzdv0CfL6F83Dw32RBsPH2lZne9JzAe3E7Idxd
	 H3Xp5JJ/MTgwdaWxMlfcqvEEmrulYx7KJ26V6L0Skd2hSVntUBvUzDO3PIwB/wDbeN
	 tsbGX3ozlLyPIuNm4EdpIah83iIxMjVkiTOekvuBEGa3FqN7+kasQaDAR+yCFmMbnz
	 ICLFAFd75Qt+utu7dNK0OlCahcnYjMS2GRHz6PuRvFrHQYf0uXgeuHLCV+ZZe1EPD2
	 rKlYgnTK0E5+XVcdW/j/yFeF/mP8m6PWdy5B9pjp5P1ap8m+R0pyZkAorezo9JEBHZ
	 cr3uc0Q1Nleyg==
Date: Mon, 24 Jul 2023 15:50:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
 manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
 skalluru@marvell.com, drc@linux.vnet.ibm.com, abdhalee@in.ibm.com
Subject: Re: [Patch v3] bnx2x: Fix error recovering in switch configuration
Message-ID: <20230724155013.442d566c@kernel.org>
In-Reply-To: <20230719220200.2485377-1-thinhtr@linux.vnet.ibm.com>
References: <20220916195114.2474829-1-thinhtr@linux.vnet.ibm.com>
	<20230719220200.2485377-1-thinhtr@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jul 2023 22:02:01 +0000 Thinh Tran wrote:
> -		/* Disable HW interrupts, NAPI */
> -		bnx2x_netif_stop(bp, 1);
> -		/* Delete all NAPI objects */
> -		bnx2x_del_all_napi(bp);
> -		if (CNIC_LOADED(bp))
> -			bnx2x_del_all_napi_cnic(bp);
> -		/* Release IRQs */
> -		bnx2x_free_irq(bp);
> +		if (!bp->nic_stopped) {
> +			/* Disable HW interrupts, NAPI */
> +			bnx2x_netif_stop(bp, 1);
> +			/* Delete all NAPI objects */
> +			bnx2x_del_all_napi(bp);
> +			if (CNIC_LOADED(bp))
> +				bnx2x_del_all_napi_cnic(bp);
> +			/* Release IRQs */
> +			bnx2x_free_irq(bp);
> +			bp->nic_stopped = true;
> +		}

You're sprinkling this if around the same piece of code in multiple
places. Please factor it out into a function, and add return early 
from it if needed. If possible please keep the code symmetric (i.e.
also factor out the inverse of this code for starting the NIC).
-- 
pw-bot: cr

