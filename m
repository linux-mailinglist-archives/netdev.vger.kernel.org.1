Return-Path: <netdev+bounces-113268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D629D93D6B7
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 18:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131EE1C23D53
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 16:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A09D17C7B0;
	Fri, 26 Jul 2024 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMOBOmrm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A3E17A580;
	Fri, 26 Jul 2024 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722010198; cv=none; b=FujfP3ejeOhCSWUVEstwvMEZAKt9aI2uHdfQyf29i+b/yznF5k8bg4bbNiOmvuphMp8rF0XziVc0wV9Ctm1PJ/JfRho+Dlt9AkhXurh1zEvznYervvYocuZ0eCUIgYfoWmHhQYps0Nk0NVliG5eyvwRajniBGIQGQ9w3k0GFsKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722010198; c=relaxed/simple;
	bh=AWvw3eax2CYJAfNzSApso/eG5j5f7iJdJCcd66tWino=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5Q+kSv8Wmm0rPnAgACipsRO0nvvl3kldB3gGOKbXzOvQ5qIYhjMaiNYUD7NzhsAKasw9Y6PU8sYsMA785KwvhJRIO84kPOUJB5JAlwpaKASKvQZBFjLMc5OxwJKfGAEIMZIlWRC3N/5GRp1BCJgwil6RVn5EfJbi9lWMciBYQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMOBOmrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F6BC32782;
	Fri, 26 Jul 2024 16:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722010198;
	bh=AWvw3eax2CYJAfNzSApso/eG5j5f7iJdJCcd66tWino=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gMOBOmrmvE9PBAcK9qnC2qsWdm1FDQ0prQUdITFLNu/ot0o9cpabw+1b/Jz7Vrjzv
	 te/QS5k6U6w8uSLzmU5mvxTbh+nCZ0vLEtgueNHkNkKYMVhr5LSWqe2jHo9kWITeS8
	 vt+pw5qhcCFeMvNKV60L7D7V/DAxkv4JnWeWkLswuHdUsbSMYznmCzNK2pV0tXdYAR
	 xFo8EK3iUVm5p67uA5yszAMPIelCWJFoNMm42Dm93RSdfkPEEnoFj5zClwjVeyvsKm
	 Q8t5KfqQdinnpW2rOy19i81d2ls1GhzjTA6qt7MHyhCi4aN1PaWXqc6ov6NO1RGIaO
	 Jk0MP4MZPT82w==
Date: Fri, 26 Jul 2024 17:09:54 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net 1/3] idpf: fix memory leaks and crashes while
 performing a soft reset
Message-ID: <20240726160954.GO97837@kernel.org>
References: <20240724134024.2182959-1-aleksander.lobakin@intel.com>
 <20240724134024.2182959-2-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724134024.2182959-2-aleksander.lobakin@intel.com>

On Wed, Jul 24, 2024 at 03:40:22PM +0200, Alexander Lobakin wrote:
> The second tagged commit introduced a UAF, as it removed restoring
> q_vector->vport pointers after reinitializating the structures.
> This is due to that all queue allocation functions are performed here
> with the new temporary vport structure and those functions rewrite
> the backpointers to the vport. Then, this new struct is freed and
> the pointers start leading to nowhere.
> 
> But generally speaking, the current logic is very fragile. It claims
> to be more reliable when the system is low on memory, but in fact, it
> consumes two times more memory as at the moment of running this
> function, there are two vports allocated with their queues and vectors.
> Moreover, it claims to prevent the driver from running into "bad state",
> but in fact, any error during the rebuild leaves the old vport in the
> partially allocated state.
> Finally, if the interface is down when the function is called, it always
> allocates a new queue set, but when the user decides to enable the
> interface later on, vport_open() allocates them once again, IOW there's
> a clear memory leak here.
> 
> Just don't allocate a new queue set when performing a reset, that solves
> crashes and memory leaks. Readd the old queue number and reopen the
> interface on rollback - that solves limbo states when the device is left
> disabled and/or without HW queues enabled.
> 
> Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
> Fixes: e4891e4687c8 ("idpf: split &idpf_queue into 4 strictly-typed queue structures")
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_lib.c | 30 +++++++++++-----------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c

...

> @@ -1932,17 +1926,23 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
>  
>  	err = idpf_set_real_num_queues(vport);
>  	if (err)
> -		goto err_reset;
> +		goto err_open;
>  
>  	if (current_state == __IDPF_VPORT_UP)
> -		err = idpf_vport_open(vport, false);
> +		err = idpf_vport_open(vport);
>  
>  	kfree(new_vport);
>  
>  	return err;
>  
>  err_reset:
> -	idpf_vport_queues_rel(new_vport);
> +	idpf_send_add_queues_msg(vport, vport->num_txq, vport->num_complq,
> +				 vport->num_rxq, vport->num_bufq);
> +
> +err_open:
> +	if (current_state == __IDPF_VPORT_UP)
> +		idpf_vport_open(vport);

Hi Alexander,

Can the system end up in an odd state if this call to idpf_vport_open(), or
the one above, fails. Likewise if the above call to
idpf_send_add_queues_msg() fails.

> +
>  free_vport:
>  	kfree(new_vport);
>  

...

