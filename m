Return-Path: <netdev+bounces-18858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F317758E5C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4C928161D
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 07:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA33AD57;
	Wed, 19 Jul 2023 07:08:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A0D3D8B
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754CAC433C8;
	Wed, 19 Jul 2023 07:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689750511;
	bh=vIgxjK1nHjyKdJKx7z3ZJwiHL/Y2wz1xQKW4KNcqGFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tWf4xPGaf+BJQulEhvX5yAcfYPvpcX3HTkBIO4fTnH77cWUXLyCFnSjtvTCHPluLx
	 fmrRXeVrjueyMjNq9oov+mQJSQwYXNa7TgU3Gg4GCm6DvqCIUHtAyE3pDqVNjjOfNK
	 QUL4T05lH3g4t7UHkYEDLzEvXJ7pFeqgrbQa2qzul15xRJU5WeV85siwCCJWDDvdq1
	 DcmvPL3Sm9y9Tnm0Km+9qXkc6SckFbxVN26LUL2u4QcvMWH30CriGmtiHxA62p02bj
	 BOLjc/DliDwhyq0jlQ/2yyrH5w1wK1Ph3e8QEj4G5MrmsLvbOBKZj0UujrYsVSVSYX
	 sjnRFdl57nnNg==
Date: Wed, 19 Jul 2023 10:08:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
	sharmaajay@microsoft.com, cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com, vkuznets@redhat.com,
	tglx@linutronix.de, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, schakrabarti@microsoft.com
Subject: Re: [PATCH V4 net-next] net: mana: Configure hwc timeout from
 hardware
Message-ID: <20230719070826.GF8808@unreal>
References: <1689703232-24858-1-git-send-email-schakrabarti@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689703232-24858-1-git-send-email-schakrabarti@linux.microsoft.com>

On Tue, Jul 18, 2023 at 11:00:32AM -0700, Souradeep Chakrabarti wrote:
> At present hwc timeout value is a fixed value. This patch sets the hwc
> timeout from the hardware. It now uses a new hardware capability
> GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG to query and set the value
> in hwc_timeout.
> 
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
> V3 -> V4:
> * Changing branch to net-next.
> * Changed the commit message to 75 chars per line.
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 30 ++++++++++++++++++-
>  .../net/ethernet/microsoft/mana/hw_channel.c  | 25 +++++++++++++++-
>  include/net/mana/gdma.h                       | 20 ++++++++++++-
>  include/net/mana/hw_channel.h                 |  5 ++++
>  4 files changed, 77 insertions(+), 3 deletions(-)

<...>

>  	gc->hwc.driver_data = NULL;
>  	gc->hwc.gdma_context = NULL;
> @@ -818,6 +839,7 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
>  		dest_vrq = hwc->pf_dest_vrq_id;
>  		dest_vrcq = hwc->pf_dest_vrcq_id;
>  	}
> +	dev_err(hwc->dev, "HWC: timeout %u ms\n", hwc->hwc_timeout);

Why do you print this message every time and with error level?
Probably you should delete it.

Thanks

