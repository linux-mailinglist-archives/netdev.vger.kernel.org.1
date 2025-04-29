Return-Path: <netdev+bounces-186619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4789A9FE72
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 02:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0388E7A5812
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 00:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EF113BC0E;
	Tue, 29 Apr 2025 00:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3YlmCLC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196681CA84
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 00:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745886923; cv=none; b=XnHLvB7VUnZxaKlFfgKPZ9ieyp8wS1WVowklcO/4RLjNTCWgBkSQ4NqUag5vg133wB9PAYQ+1VZihOFOw/ikQ5+3JeO0VC40H1fO2yZWbCmTV6tEs02acEqrZ+IK5Y7BhrGXJyTq6iVqu8NPVWy8wxTn2kQMqQQS2Hja9iKOaC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745886923; c=relaxed/simple;
	bh=DgN8dT2Rl63x7PgoDs1a6wZxXK/X5Kos6YhzHgZF9zs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjAYL9RZKOR3Nh99x0G/itsDWD49bS1SBPlo9RNuTMWV4YpdvbL7M/glF2Q581DntDYIlaPJczl9MBhAerApvag9hKxP7djL8BfeJLl8PtCgTm7l38+18ibDjrHawejzDOHQLMiQUC7vTR+I2ftuDRAYpFNhAoNrUznBPaMFJQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3YlmCLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A68C4CEE4;
	Tue, 29 Apr 2025 00:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745886922;
	bh=DgN8dT2Rl63x7PgoDs1a6wZxXK/X5Kos6YhzHgZF9zs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y3YlmCLCAJwXc6/aYLrrNYzrZyVfHHMCJ73txB1RDXpKh8AZqaULhZ4hibFjSBPpP
	 BAhJHSjDpKub8NSB659yTo2cvDAbXrayl9f/lu0HWrrwrInnpYhcT4kxlxFcSNmbia
	 SKzif/eJDoO9qsLZTBQC6gGLeHBbgQwNQk1QXGKkSrDwdw80vVpHpcHXEI6FEEmPeT
	 xydYWVfASMp8PEShzGDTZyFv7Qyh+nJAyPIRRdz6w2K7V+xDBVMJomrO54awfI3ExU
	 lZ7WlFf0kmyidKmTmvyllGFXvTT8RN+zg9LYeUm6NE3A5EDdHAI1VqAGd+OY4uUwPg
	 0+o7NVUe7HQPw==
Date: Mon, 28 Apr 2025 17:35:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Milena Olech
 <milena.olech@intel.com>, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com, richardcochran@gmail.com, Josh Hay
 <joshua.a.hay@intel.com>, Samuel Salin <Samuel.salin@intel.com>
Subject: Re: [PATCH net-next v2 10/11] idpf: add Tx timestamp flows
Message-ID: <20250428173521.1af2cc52@kernel.org>
In-Reply-To: <20250425215227.3170837-11-anthony.l.nguyen@intel.com>
References: <20250425215227.3170837-1-anthony.l.nguyen@intel.com>
	<20250425215227.3170837-11-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 14:52:24 -0700 Tony Nguyen wrote:
> +int idpf_ptp_get_tx_tstamp(struct idpf_vport *vport)
> +{
> +	struct virtchnl2_ptp_get_vport_tx_tstamp_latches *send_tx_tstamp_msg;
> +	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
> +	struct idpf_vc_xn_params xn_params = {
> +		.vc_op = VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP,
> +		.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
> +		.async = true,
> +		.async_handler = idpf_ptp_get_tx_tstamp_async_handler,
> +	};
> +	struct idpf_ptp_tx_tstamp *ptp_tx_tstamp;
> +	int reply_sz, size, msg_size;
> +	struct list_head *head;
> +	bool state_upd;
> +	u16 id = 0;
> +
> +	tx_tstamp_caps = vport->tx_tstamp_caps;
> +	head = &tx_tstamp_caps->latches_in_use;
> +
> +	size = struct_size(send_tx_tstamp_msg, tstamp_latches,
> +			   tx_tstamp_caps->num_entries);
> +	send_tx_tstamp_msg = kzalloc(size, GFP_KERNEL);
> +	if (!send_tx_tstamp_msg)
> +		return -ENOMEM;
> +
> +	spin_lock(&tx_tstamp_caps->latches_lock);

Looks like this function is called from a work but it takes 
the latches_lock in non-BH mode? Elsewhere the lock is taken
in BH mode. Not sure what the context for the async handler is.

