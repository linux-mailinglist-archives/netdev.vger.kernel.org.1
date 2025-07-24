Return-Path: <netdev+bounces-209820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C25B2B10FEA
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 18:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08F8188E2A8
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 16:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D5A1EDA1A;
	Thu, 24 Jul 2025 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEu6t0tp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA42C17A318
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753375871; cv=none; b=N6vR8dSO2/TdT9tUEVedMMQd578+h+3DTbzfY20gX8OqLpVPqxRJ+RXQj4WlwYcO0IMwVPk7ck40Znmw0ip5n998qCjIgsAOiD3/roWf/HI3RrgMFolpiYnQKAURHRKFCrCb/B8vmousTEqR7tIgCC3ydbnjkPF7xYsvFqmwyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753375871; c=relaxed/simple;
	bh=MxpJX1RoKg1r1aPTRlDUn/r3pesu11m36Wczlf6A+YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=av1koLXmlT2qqAMZL49AIhp4GPerOf8UTs5VZ9aDsjA1FsUrz5abzzKEISaPVLKmozB9sMeQ4XB4N6IDf1elU/hZH5wDY4okpg/vQw6GD2WcxcoENsjIaqlWSEyCrRBbdB9q6XDIlLxDWdJX2DlYCl3BpucHXKitP0qqjlpa18Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEu6t0tp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8B8C4CEED;
	Thu, 24 Jul 2025 16:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753375870;
	bh=MxpJX1RoKg1r1aPTRlDUn/r3pesu11m36Wczlf6A+YQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EEu6t0tpsUnRKdGxKE62aYOIfm3F6kCINdBNfBK8ydC76CZzOzl9rJLz2h04JvopW
	 07rpsIGsJIVtx7LMBslmqGEQSo+3laATp/AUaTeyFF3IVgi0slRTdhc1TnPXROuMSQ
	 tMPoV0U6VUmg72qmecmV9VLPBaSQXGJmDTVhOfibXqj3v3o90EOXWdrwIZ7TxbL9gh
	 GQniNV438jb43ld9EcrB92nolAvPd8iF7778oZEf5VShWosMnAqWaC0SUCOpv3jp02
	 55Z2/VhN+XODDLPQNSdvKMMFQh3sKiX97UvMKbYXtedum20cwr/nlXQIwuI+MuVPZd
	 1JUhSuxEJxWaw==
Date: Thu, 24 Jul 2025 09:51:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 netdev@vger.kernel.org, alexanderduyck@fb.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, vadim.fedorenko@linux.dev, jdamato@fastly.com,
 sdf@fomichev.me, aleksander.lobakin@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Subject: Re: [PATCH net-next 5/9] eth: fbnic: Add XDP pass, drop, abort
 support
Message-ID: <20250724095108.186fe3a1@kernel.org>
In-Reply-To: <3b1f10aa-49a2-465b-8b11-bf5e92a6bf8f@gmail.com>
References: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
	<20250723145926.4120434-6-mohsin.bashr@gmail.com>
	<aIEdS6fnblUEuYf5@boxer>
	<3b1f10aa-49a2-465b-8b11-bf5e92a6bf8f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 08:47:20 -0700 Mohsin Bashir wrote:
> >> +	if (xdp_buff_has_frags(&pkt->buff) && !xdp_prog->aux->xdp_has_frags)
> >> +		return ERR_PTR(-FBNIC_XDP_LEN_ERR);  
> > 
> > when can this happen and couldn't you catch this within ndo_bpf? i suppose
> > it's related to hds setup.
> 
> It is important to avoid passing a packet with frags to a single-buff 
> XDP program. The implication being that a single-buff XDP program would 
> fail to access packet linearly. For example, we can send a jumbo UDP 
> packet to the SUT with a single-buffer XDP program attached and in the 
> XDP program, attempt to access payload linearly.
> 
> I believe handling this case within ndo_bpf may not be possible.

Herm, we are handling it in ndo_bpf..
This check is just a safety in case somehow we get a packet larger 
than MTU, and therefore crossing the "safe" HDS threshold.

