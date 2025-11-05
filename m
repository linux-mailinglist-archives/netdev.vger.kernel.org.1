Return-Path: <netdev+bounces-235750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DB9C34B93
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 10:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A278C189A5FE
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 09:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCD12F90EA;
	Wed,  5 Nov 2025 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJDgtKPB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17EA24291B;
	Wed,  5 Nov 2025 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334051; cv=none; b=mOoIMV9hpI1OfgK7UuM0dD8hucO7MbsYjWXhW02BypBM5uQ9eKfP6lnvqC1K5fNL4qbHmHb5MmTxlE9b+TMxECU0DzSFEmeJ+YZo0NUZhJHK9x9RA9EZAV8wISdFXe4bdyHUohMjabk0h9hwpx1+KdCGsauoHkloUBovyg4nIsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334051; c=relaxed/simple;
	bh=+IcD7Spbw17oRsINmLuhMDru7Z//3dFzIofki5+RBpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXczean+eZOcZmvb62QnVDaJ4cwaaNmf2cVz1MH9E5PE5AvtTRN1rhMAFo7CljB/JW9zlSi/i3QfGwsjPV2Ale9TO3As5R4LqIeYC7eTMZnnv/iyny0YkQ1PC8AJTZED8XP5SIDQk0hJzQW5t6RCtRIwrnP+W4qEeQ3d6yocLSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJDgtKPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE89C4CEF8;
	Wed,  5 Nov 2025 09:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762334051;
	bh=+IcD7Spbw17oRsINmLuhMDru7Z//3dFzIofki5+RBpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJDgtKPBz3icUlyYvEpGUKaHscHOx35GSJXlsT+55IVdo9ELb2ZDPNnixY0NmfcVh
	 +7bXBHagm+C6RGJqEz+O1IboyJMwyNvlMsaqn/iHGi5kujCnMARSJ5XWORcaTmLB4M
	 WkEo/RHl4i3qLdBh7kzm3tQ6KXieTLocU2LScGXIP4yWmolTMCxrf4H3K4lKzIs71Z
	 Y4vgiCZx3uRcqAnTOHrnlO/7es8Hp4O/ZbYCB3a8aWzXG1/oUGWI1DAuBN+lmsV0o1
	 ECpXBWGRNAYsME5YRrTuDgQKk2orBlVGxXaH0DPeUR/3TRYgqz9Rdkzh5A2m3cm3/B
	 n7IzY4JB7n8OA==
Date: Wed, 5 Nov 2025 09:14:05 +0000
From: Simon Horman <horms@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Markus.Elfring@web.de,
	pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Luo Yang <luoyang82@h-partners.com>,
	Meny Yossefi <meny.yossefi@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>
Subject: Re: [PATCH net-next v04 3/5] hinic3: Add NIC configuration ops
Message-ID: <aQsVXfFlZzIeSf-V@horms.kernel.org>
References: <cover.1761711549.git.zhuyikai1@h-partners.com>
 <79009912df8bed8ce44f6fcaf8cdbb943d6efd82.1761711549.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79009912df8bed8ce44f6fcaf8cdbb943d6efd82.1761711549.git.zhuyikai1@h-partners.com>

On Wed, Oct 29, 2025 at 02:16:27PM +0800, Fan Gong wrote:

...

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
> index 09dae2ef610c..0efb5a843964 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
> @@ -9,6 +9,36 @@
>  #include "hinic3_hwif.h"
>  #include "hinic3_mbox.h"
>  
> +static int hinic3_get_interrupt_cfg(struct hinic3_hwdev *hwdev,
> +				    struct hinic3_interrupt_info *info)
> +{
> +	struct comm_cmd_cfg_msix_ctrl_reg msix_cfg = {};
> +	struct mgmt_msg_params msg_params = {};
> +	int err;
> +
> +	msix_cfg.func_id = hinic3_global_func_id(hwdev);
> +	msix_cfg.msix_index = info->msix_index;
> +	msix_cfg.opcode = MGMT_MSG_CMD_OP_GET;
> +
> +	mgmt_msg_params_init_default(&msg_params, &msix_cfg, sizeof(msix_cfg));
> +
> +	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
> +				       COMM_CMD_CFG_MSIX_CTRL_REG, &msg_params);
> +	if (err || msix_cfg.head.status) {
> +		dev_err(hwdev->dev, "Failed to get interrupt config, err: %d, status: 0x%x\n",
> +			err, msix_cfg.head.status);
> +		return -EFAULT;
> +	}
> +
> +	info->lli_credit_limit = msix_cfg.lli_credit_cnt;
> +	info->lli_timer_cfg = msix_cfg.lli_timer_cnt;
> +	info->pending_limit = msix_cfg.pending_cnt;
> +	info->coalesc_timer_cfg = msix_cfg.coalesce_timer_cnt;
> +	info->resend_timer_cfg = msix_cfg.resend_timer_cnt;
> +
> +	return 0;
> +}
> +
>  int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev,
>  				    const struct hinic3_interrupt_info *info)
>  {
> @@ -40,6 +70,30 @@ int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev,
>  	return 0;
>  }
>  
> +int hinic3_set_interrupt_cfg(struct hinic3_hwdev *hwdev,
> +			     struct hinic3_interrupt_info info)
> +{
> +	struct hinic3_interrupt_info temp_info;
> +	int err;
> +
> +	temp_info.msix_index = info.msix_index;
> +
> +	err = hinic3_get_interrupt_cfg(hwdev, &temp_info);
> +	if (err)
> +		return -EINVAL;

Maybe I am missing something. It seems to me thaat this error value will
propagate up to be the return value of the probe value. And it seems to me
that would be a bit more intuitive, and possibly lead to a better user
experience, if the return value of hinic3_get_interrupt_cfg() was
propagated here. And, in turn, if hinic3_get_interrupt_cfg() propagated the
return value of hinic3_send_mbox_to_mgmt(). These values differ from
-EINVAL.

> +
> +	info.lli_credit_limit = temp_info.lli_credit_limit;
> +	info.lli_timer_cfg = temp_info.lli_timer_cfg;
> +
> +	if (!info.interrupt_coalesc_set) {
> +		info.pending_limit = temp_info.pending_limit;
> +		info.coalesc_timer_cfg = temp_info.coalesc_timer_cfg;
> +		info.resend_timer_cfg = temp_info.resend_timer_cfg;
> +	}
> +
> +	return hinic3_set_interrupt_cfg_direct(hwdev, &info);
> +}

...

