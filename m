Return-Path: <netdev+bounces-162035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F3FA25693
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 11:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84839188315A
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 10:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85A278F49;
	Mon,  3 Feb 2025 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rE100XoE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A867218651;
	Mon,  3 Feb 2025 10:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738576962; cv=none; b=RnJw18TBgA7S+CpmhnX360KiTizoMtNv334ZNobjGf7sO5TDEeechYM35RqcG4LlFK730kUJmzzXwB3JCsZuSpetG/NO0J8p49cak7wxqWtMussk7rjszpLye2t7Yz0RiyJbYsZoJ7RGRukYQBbvAW6AMdz3Lbu2tGPfpKRAyVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738576962; c=relaxed/simple;
	bh=j64qVmWci3xBNkGE0mS2OOj0BR2pEsdKu6w5rANbRP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u50LuZgY8MsxniNRY42DhxaKEeQwC5YHuM8ka0HBu5OVM9ilt5/y8Przb+9TbSl/ijnK2FnbbyMdp+N76qS/YCU+HTHi0KFzLB7oIWN46Loo5cdXzDT5hS0wI1Mpm6G1kpfw1liaudfoBjsxyrAGDJROpBP09FMIW2zx5bBtPGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rE100XoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A8BC4CED2;
	Mon,  3 Feb 2025 10:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738576961;
	bh=j64qVmWci3xBNkGE0mS2OOj0BR2pEsdKu6w5rANbRP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rE100XoEQCDq/GAsA/kFJsCV1lURPiPFtj6MKbrKUU5SNDELwgYo3zmqtzFhOmi9Y
	 xNgN4y0dRzaxjWTc5bvZD1fZYk0nhWkam/HxMmGz6MTsC7r8uJZZUz37pr79OXvAFX
	 84gFWn4bWVo7iQ2nXiX9FfL9zEYY4Qd6PFTlEWA+ueXhrz7687HjBmAYJM4l+fxoeT
	 ZVucXR5qfZT0yZmYjCApK3pwM43twtCrKiH/Kqmo6YAV6qSCQhmNtOFgUwImewlCqK
	 oQN3um9/oF1nhPTSFbbA5DwmuWMzSmZhJV8pHn5MisZNDP9Lv1WyM+GT+ceZ+ksT1N
	 iNf4litnb2bcA==
Date: Mon, 3 Feb 2025 10:02:36 +0000
From: Simon Horman <horms@kernel.org>
To: Jacob Moroni <mail@jakemoroni.com>
Cc: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: atlantic: fix warning during hot unplug
Message-ID: <20250203100236.GB234677@kernel.org>
References: <20250202220921.13384-2-mail@jakemoroni.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250202220921.13384-2-mail@jakemoroni.com>

On Sun, Feb 02, 2025 at 05:09:21PM -0500, Jacob Moroni wrote:
> Firmware deinitialization performs MMIO accesses which are not
> necessary if the device has already been removed. In some cases,
> these accesses happen via readx_poll_timeout_atomic which ends up
> timing out, resulting in a warning at hw_atl2_utils_fw.c:112:
> 
> [  104.595913] Call Trace:
> [  104.595915]  <TASK>
> [  104.595918]  ? show_regs+0x6c/0x80
> [  104.595923]  ? __warn+0x8d/0x150
> [  104.595925]  ? aq_a2_fw_deinit+0xcf/0xe0 [atlantic]
> [  104.595934]  ? report_bug+0x182/0x1b0
> [  104.595938]  ? handle_bug+0x6e/0xb0
> [  104.595940]  ? exc_invalid_op+0x18/0x80
> [  104.595942]  ? asm_exc_invalid_op+0x1b/0x20
> [  104.595944]  ? aq_a2_fw_deinit+0xcf/0xe0 [atlantic]
> [  104.595952]  ? aq_a2_fw_deinit+0xcf/0xe0 [atlantic]
> [  104.595959]  aq_nic_deinit.part.0+0xbd/0xf0 [atlantic]
> [  104.595964]  aq_nic_deinit+0x17/0x30 [atlantic]
> [  104.595970]  aq_ndev_close+0x2b/0x40 [atlantic]
> [  104.595975]  __dev_close_many+0xad/0x160
> [  104.595978]  dev_close_many+0x99/0x170
> [  104.595979]  unregister_netdevice_many_notify+0x18b/0xb20
> [  104.595981]  ? __call_rcu_common+0xcd/0x700
> [  104.595984]  unregister_netdevice_queue+0xc6/0x110
> [  104.595986]  unregister_netdev+0x1c/0x30
> [  104.595988]  aq_pci_remove+0xb1/0xc0 [atlantic]
> 
> Fix this by skipping firmware deinitialization altogether if the
> PCI device is no longer present.
> 
> Tested with an AQC113 attached via Thunderbolt by performing
> repeated unplug cycles while traffic was running via iperf.
> 

Hi Jacob,

As a fix for net a Fixes tag should go here
(immediately before your signed-off-by line, no blank line in between).

I'm wondering if this one is appropriate: the problem seems
to go all the way back to here.

Fixes: 97bde5c4f909 ("net: ethernet: aquantia: Support for NIC-specific code")

> Signed-off-by: Jacob Moroni <mail@jakemoroni.com>
> ---
>  drivers/net/ethernet/aquantia/atlantic/aq_nic.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> index fe0e3e2a8117..e2ae95a01947 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> @@ -1428,7 +1428,7 @@ void aq_nic_deinit(struct aq_nic_s *self, bool link_down)
>  	unsigned int i = 0U;
>  
>  	if (!self)
> -		goto err_exit;
> +		return;
>  
>  	for (i = 0U; i < self->aq_vecs; i++) {
>  		aq_vec = self->aq_vec[i];

This hunk, and the removal of the err_exit label, seem to be more
clean-up than addressing the bug described in the patch description.
I don't think they belong in this patch. But could be candidates for
a follow-up patch targeted at net-next.

> @@ -1441,13 +1441,14 @@ void aq_nic_deinit(struct aq_nic_s *self, bool link_down)
>  	aq_ptp_ring_free(self);
>  	aq_ptp_free(self);
>  
> -	if (likely(self->aq_fw_ops->deinit) && link_down) {
> -		mutex_lock(&self->fwreq_mutex);
> -		self->aq_fw_ops->deinit(self->aq_hw);
> -		mutex_unlock(&self->fwreq_mutex);
> +	/* May be invoked during hot unplug. */
> +	if (pci_device_is_present(self->pdev)) {
> +		if (likely(self->aq_fw_ops->deinit) && link_down) {

Maybe not important, but I would have written this as a single if
condition rather than two.

Also, not really appropriate to change in this patch as it's not part
of the bug, but I'm not sure that likely() is appropriate here:
is this a fast path?

> +			mutex_lock(&self->fwreq_mutex);
> +			self->aq_fw_ops->deinit(self->aq_hw);
> +			mutex_unlock(&self->fwreq_mutex);
> +		}
>  	}
> -
> -err_exit:;
>  }
>  
>  void aq_nic_free_vectors(struct aq_nic_s *self)

-- 
pw-bot: changes-requested

