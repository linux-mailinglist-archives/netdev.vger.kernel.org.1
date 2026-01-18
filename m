Return-Path: <netdev+bounces-250776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAACD3922C
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 03:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD01C300A872
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 02:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E501DE3B5;
	Sun, 18 Jan 2026 02:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rqt/4Cba"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D231D798E
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 02:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768703125; cv=none; b=pvAvwJBMgWpFjWHrd8I2n5OZcgz3YUJw1O62uuu/yHqcOltQfrFXb0LH/Y4HKUDvG/P97xkT+bbk/Uas3tArrrmsU+qeNEddHD9r89teF24TjrNf6wKLTdrnuOSw17jfcTMZDlW1GRrjZpaQNw62W/Ly5Labm4qIvdPnXgfw5aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768703125; c=relaxed/simple;
	bh=2BD3JAeeroFtMFLqnpeyffIMVZ/JAGp4c5SerlDlAFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zssu0IIbIzqW12DiSV2wf8HP4cy5o0KyX/UW0oZuJtJ39YC6ZOUzxfdUNFR+1/ovxNGsFlg/g23pMqBBb1F23JBzrLt28nuyo3af+tl/qzOkCVRXc3q/kVO74nV/3wOuBV5PiFHGWyBIIaCvNQopfv53m9qQ4Cs77N9ZkVqbQD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rqt/4Cba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1256EC4CEF7;
	Sun, 18 Jan 2026 02:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768703124;
	bh=2BD3JAeeroFtMFLqnpeyffIMVZ/JAGp4c5SerlDlAFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rqt/4Cbas1PSoC4ZtbmgG9Ea9MZFVBfqBINN+fVPdcIpKdgHPjGZ78dsVq4T/Lg0S
	 vLbpOBtNEVNJZNVVj6w2yywqhtI5zMvWSzsIa8BJqzhzBUTNIKJX46hpqLhjldGBYB
	 tN+6kkMHK3BmBm9qR4oEjKPD33GlQ+JauHClSXBu8RZCBmYpWVTOzJEvky+WiFa3T5
	 7LS4tFJiNNW/xyyqKjjgWEzdHF6q23n+dA9HYOBYNlsAzel1/hk3Y1/UEz3LMxfc7X
	 FRRa5KtlxNyhLYA71pTmuTdaoPYF4g33zR9lxTOWo6WQvCX5uz+sKLqNX0BZTqkXn8
	 kRhwBaR3qivuQ==
Date: Sat, 17 Jan 2026 18:25:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Madhu Chittim
 <madhu.chittim@intel.com>, joshua.a.hay@intel.com, Milena Olech
 <milena.olech@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Samuel Salin <Samuel.salin@intel.com>
Subject: Re: [PATCH net-next 01/10] idpf: introduce local idpf structure to
 store virtchnl queue chunks
Message-ID: <20260117182523.6b6c91e7@kernel.org>
In-Reply-To: <20260115234749.2365504-2-anthony.l.nguyen@intel.com>
References: <20260115234749.2365504-1-anthony.l.nguyen@intel.com>
	<20260115234749.2365504-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 15:47:38 -0800 Tony Nguyen wrote:
> +/**
> + * idpf_queue_id_reg_chunk - individual queue ID and register chunk

missing the word struct

> + * @qtail_reg_start: queue tail register offset
> + * @qtail_reg_spacing: queue tail register spacing
> + * @type: queue type of the queues in the chunk
> + * @start_queue_id: starting queue ID in the chunk
> + * @num_queues: number of queues in the chunk
> + */
> +struct idpf_queue_id_reg_chunk {
> +	u64 qtail_reg_start;
> +	u32 qtail_reg_spacing;
> +	u32 type;
> +	u32 start_queue_id;
> +	u32 num_queues;
> +};
> +
> +/**
> + * idpf_queue_id_reg_info - struct to store the queue ID and register chunk

ditto

> + *			    info received over the mailbox
> + * @num_chunks: number of chunks
> + * @queue_chunks: array of chunks
> + */
> +struct idpf_queue_id_reg_info {
> +	u16 num_chunks;
> +	struct idpf_queue_id_reg_chunk *queue_chunks;
> +};

> +static int
> +idpf_vport_init_queue_reg_chunks(struct idpf_vport_config *vport_config,
> +				 struct virtchnl2_queue_reg_chunks *schunks)
> +{
> +	struct idpf_queue_id_reg_info *q_info = &vport_config->qid_reg_info;
> +	u16 num_chunks = le16_to_cpu(schunks->num_chunks);
> +
> +	kfree(q_info->queue_chunks);
> +
> +	q_info->num_chunks = num_chunks;

AI review complains that this is set before the alloc, so if alloc
fails the struct is in inconsistent state. I didn't check if this is
defensive programming or the callers handle this error correctly.
But seems easy to fix, so maybe let's?

> +	q_info->queue_chunks = kcalloc(num_chunks, sizeof(*q_info->queue_chunks),
> +				       GFP_KERNEL);
> +	if (!q_info->queue_chunks)
> +		return -ENOMEM;
> +
> +	for (u16 i = 0; i < num_chunks; i++) {
> +		struct idpf_queue_id_reg_chunk *dchunk = &q_info->queue_chunks[i];
> +		struct virtchnl2_queue_reg_chunk *schunk = &schunks->chunks[i];
> +
> +		dchunk->qtail_reg_start = le64_to_cpu(schunk->qtail_reg_start);
> +		dchunk->qtail_reg_spacing = le32_to_cpu(schunk->qtail_reg_spacing);
> +		dchunk->type = le32_to_cpu(schunk->type);
> +		dchunk->start_queue_id = le32_to_cpu(schunk->start_queue_id);
> +		dchunk->num_queues = le32_to_cpu(schunk->num_queues);
> +	}
> +
-- 
pw-bot: cr

