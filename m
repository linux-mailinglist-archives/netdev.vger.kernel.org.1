Return-Path: <netdev+bounces-177411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4F3A701D4
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85EF19A6C3A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E2725A2CB;
	Tue, 25 Mar 2025 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsLELxgM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E6625A2C0
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907639; cv=none; b=fS2N23t2jv0MHJRjz7qigSORRtK6P7doAHB2I10b2T/ipo9FF3FlF5de7SpWfsXs+hjIYUdyEUQi61a+bCaucipbyvnm4fVg7ZUCCIZ47ut5iHHwrRR4a6pJ4HiP/a0sDp2rof47g18HBJladHejKjMBMFCsCo5yBpgOY4Pj0Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907639; c=relaxed/simple;
	bh=osUZqh8OiPa1kToH8jOhy7QTKetaqfKzeenIuuruPXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0gztoGTNf1YvuAILeolfJFyJ82inYjIKhBhQ2hw619IoS82ud+sTYpvD7nc43dUi6jh2XdnuUJBONwoDsC5pW4L0KNTozEuWdt1iiaTnrK4QcZnjFLS2p44lz+2RFZhRQQ8GKfgSkxbkdod00EF/JAv2uXI57262tXp8efOuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsLELxgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19381C4CEED;
	Tue, 25 Mar 2025 13:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742907639;
	bh=osUZqh8OiPa1kToH8jOhy7QTKetaqfKzeenIuuruPXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JsLELxgMNTPbBGIbTs3b1a2OZzpaV2wnbtYXraFnIA83gn5Wwv5CSNah42jdTZAab
	 LEqz8K7tPPkARWw+lq2LIwVOb55JCINOO9MEEPl471QOAImnp4fUCR0s6mO/YVvL8D
	 vix2nDL/brEioXwBOl+potgJvh4H6tlMsOqQ9bZeB3g/RBMKCeAy9GstN7WRT0fK5c
	 042QFcIFykymB5VvZVrjKwz/YiTTH80eGEGe76Y/KcCvLqPA3aCK6RTS4RO3zZuwYa
	 v08J9zIfy1H/EAWnSsOP5sc0Y8hmVjsCo9mZxPGoEZNSZAOxA/qNRc/kJHq6gBogQj
	 aMAJdIquPnx1w==
Date: Tue, 25 Mar 2025 06:00:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Milena Olech
 <milena.olech@intel.com>, przemyslaw.kitszel@intel.com,
 karol.kolacinski@intel.com, richardcochran@gmail.com, Josh Hay
 <joshua.a.hay@intel.com>, Samuel Salin <Samuel.salin@intel.com>
Subject: Re: [PATCH net-next 08/10] idpf: add Tx timestamp flows
Message-ID: <20250325060030.279c99bf@kernel.org>
In-Reply-To: <20250318161327.2532891-9-anthony.l.nguyen@intel.com>
References: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
	<20250318161327.2532891-9-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 09:13:23 -0700 Tony Nguyen wrote:
> +/**
> + * struct idpf_tx_tstamp_stats - Tx timestamp statistics
> + * @tx_hwtstamp_lock: Lock to protect Tx tstamp stats
> + * @tx_hwtstamp_discarded: Number of Tx skbs discarded due to cached PHC time
> + *			   being too old to correctly extend timestamp
> + * @tx_hwtstamp_flushed: Number of Tx skbs flushed due to interface closed
> + */
> +struct idpf_tx_tstamp_stats {
> +	struct mutex tx_hwtstamp_lock;
> +	u32 tx_hwtstamp_discarded;
> +	u32 tx_hwtstamp_flushed;
> +};

>   * idpf_get_rxnfc - command to get RX flow classification rules
> @@ -479,6 +480,9 @@ static const struct idpf_stats idpf_gstrings_port_stats[] = {
>  	IDPF_PORT_STAT("tx-unicast_pkts", port_stats.vport_stats.tx_unicast),
>  	IDPF_PORT_STAT("tx-multicast_pkts", port_stats.vport_stats.tx_multicast),
>  	IDPF_PORT_STAT("tx-broadcast_pkts", port_stats.vport_stats.tx_broadcast),
> +	IDPF_PORT_STAT("tx-hwtstamp_skipped", port_stats.tx_hwtstamp_skipped),
> +	IDPF_PORT_STAT("tx-hwtstamp_flushed", tstamp_stats.tx_hwtstamp_flushed),
> +	IDPF_PORT_STAT("tx-hwtstamp_discarded", tstamp_stats.tx_hwtstamp_discarded),

I don't see you implementing .get_ts_stats ? If there is a reason
please explain in the commit msg. We require that standard stats
are reported if you want to report custom, more granular ones.

> +static int idpf_get_ts_info(struct net_device *netdev,
> +			    struct kernel_ethtool_ts_info *info)
> +{
> +	struct idpf_netdev_priv *np = netdev_priv(netdev);
> +	struct idpf_vport *vport;
> +	int err = 0;
> +
> +	if (!mutex_trylock(&np->adapter->vport_ctrl_lock))

Why trylock? This also needs a solid and well documented justification
to pass.
-- 
pw-bot: cr

