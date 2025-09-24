Return-Path: <netdev+bounces-225756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AC6B97FCC
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 03:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E59C67AA768
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 01:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD90F1DA60F;
	Wed, 24 Sep 2025 01:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgUSeSfy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4C617C21B;
	Wed, 24 Sep 2025 01:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676601; cv=none; b=i2h52M6e+ZLQL2PD+r9b+jYcmNaEsgHHYaxTSjZJuMsESXn2z4qMUXK0VVEu00tFSzoxk7peTHxVc0h6dRvSSTcXXJw7ggJCqpPGn0mJ2g52/tm8rHUtmEvKfwoA3EjNyEPdOxnbMkftR9bz7XhWNfHOQ+UORrcGvMbpoDSsQzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676601; c=relaxed/simple;
	bh=8ePn7JLIUJhkEG1cge46lu2Tibuofo60ASXiwv4beHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXeMvYd1q33W6Z/N5+Qski7QfAeevyvbtlHidN40gR6uPu670eQK7VqZ1SeiCSWjb+NgPKj7l/pnaklZOdaUq5bnKEPJNkstxAmldt3vb1MYZ8MIpaMTYkR0b4Dgg1HcTtBpTmDZH1RiN4OAdjLYr1kv4N3J5eM39SeITXeCrNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgUSeSfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FFAC4CEF5;
	Wed, 24 Sep 2025 01:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758676601;
	bh=8ePn7JLIUJhkEG1cge46lu2Tibuofo60ASXiwv4beHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pgUSeSfy4qTNW1wzGNQ7A1uIyj4oHbxQMPINBfaiGF7/SAWYKc0yBGSInBGo8JYYW
	 orpOLNMItg3EenItCqQOiYmFzkk68nvMvY6a9bMP+qwIOGdjRlmX8QGPbikVHCHyb0
	 yBhmhgmIFNqxCC6VXHRS7AbgtAgr3A71i6z0cTaoa1wRLjuHHhwcrySVyen6ZFf2gM
	 jb6kRLTYmr5uUJ0XVrM4NLRS8Lx/bkelQma+ZtDqspkvtQB360ic8yE9DztK94obfL
	 LMUPu4nEyltMFjId7HOmYQ5yENY8IUbAlWDDnZ8+aPigzyMzlYDUdiWHhBQ7F4vNFT
	 66anFEe6NvLqw==
Date: Tue, 23 Sep 2025 18:16:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
 gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
 Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
 alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
 gustavoars@kernel.org, rdunlap@infradead.org, vadim.fedorenko@linux.dev,
 joerg@jo-so.de, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v13 5/5] net: rnpgbe: Add register_netdev
Message-ID: <20250923181639.6755cca4@kernel.org>
In-Reply-To: <20250922014111.225155-6-dong100@mucse.com>
References: <20250922014111.225155-1-dong100@mucse.com>
	<20250922014111.225155-6-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 09:41:11 +0800 Dong Yibo wrote:
> +static const struct mucse_hw_operations rnpgbe_hw_ops = {
> +	.reset_hw = rnpgbe_reset,
> +	.get_perm_mac = rnpgbe_get_permanent_mac,
> +	.mbx_send_notify = rnpgbe_mbx_send_notify,

Please don't add abstraction layers, you only have one set of ops right
now call them directly. The abstractions layers make the code harder to
follow.

> +static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
> +				     struct net_device *netdev)
> +{
> +	dev_kfree_skb_any(skb);
> +	netdev->stats.tx_dropped++;

Please add your own stats, the stats in struct net_device
are deprecated and should not be used by new drivers.

>  	err = rnpgbe_init_hw(hw, board_type);
>  	if (err) {
>  		dev_err(&pdev->dev, "Init hw err %d\n", err);
>  		goto err_free_net;
>  	}
> +	/* Step 1: Send power-up notification to firmware (no response expected)
> +	 * This informs firmware to initialize hardware power state, but
> +	 * firmware only acknowledges receipt without returning data. Must be
> +	 * done before synchronization as firmware may be in low-power idle
> +	 * state initially.
> +	 */
> +	err = hw->ops->mbx_send_notify(hw, true, mucse_fw_powerup);
> +	if (err) {

Don't you have to power it down on errors later in this function?
-- 
pw-bot: cr

