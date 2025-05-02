Return-Path: <netdev+bounces-187403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C46AAA6E55
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 11:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E474C26B2
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 09:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2425022E3FD;
	Fri,  2 May 2025 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/qS5AeO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD631D554;
	Fri,  2 May 2025 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746178789; cv=none; b=ob+jM2cL5CgCPArWJR3hSUwdVvYlWCMGzFu1H+E2lpVk29+34IMV2hlcILuxwh7FvxTGOU38Pu5sLDS0lcZVtD70nmBrS7iPKgrnJopD+WaD1vlSAptB929Ybuk++D7D2vtJIMTruWEHeSCM2QacVJ/tLP96kZjxE5pCF3JiS4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746178789; c=relaxed/simple;
	bh=OTcU+TyYte9xshVPz57Q6Apwcs2oIlxw0u2RikVAXJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZlzYRLEpomjrWSEC/Pv7xSTJllPiFCnD0q5/QIK5YOdJ67HNfKL6Lnlw1CG3flnG0cZO89kGIsGQbHMsZc/B3pU/RpAZgjgIS0qi/AvzzbFUl97Wvz6arWHjRcSsUz5NAqQ0M1HZY8aXLRPQ74ICCgGCx29EvdybPrn1QKswqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/qS5AeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27526C4CEE4;
	Fri,  2 May 2025 09:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746178788;
	bh=OTcU+TyYte9xshVPz57Q6Apwcs2oIlxw0u2RikVAXJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F/qS5AeO3aUkgzYbtK422mwKQ8LGFgid2UYoNMG4Ql9L9yVYEedacS7T5dVHaFHSj
	 R1IRASQL0gusPIM5WdsMxwG47IsOj5gNacezG/2G0pdDDvyIrf+gmqpQM8BxUnia7x
	 xUlRARHT8okKYTivPae0gR394TpXZT9ucnvgSBpDO8ocV2c2JGOKjth4BHlab7EQ3o
	 84P5LZ5Zoayx0KmXUeXTaJop5UERRT5HUNkhsdnKEB13JsJ9utMyUJUhXQRTUPyVVe
	 Fkqy5iM6n+fdeF9jQY/1uASQ8W0dPsT0nfMjTdSXB54PzBbiYNJU3jjx9Txn2hWxpx
	 wCZUbdLa/DiLw==
Date: Fri, 2 May 2025 10:39:41 +0100
From: Simon Horman <horms@kernel.org>
To: Brian Vazquez <brianvv@google.com>
Cc: Brian Vazquez <brianvv.kernel@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	David Decotigny <decot@google.com>,
	Anjali Singhai <anjali.singhai@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	emil.s.tantilov@intel.com, Jacob Keller <jacob.e.keller@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>, Luigi Rizzo <lrizzo@google.com>
Subject: Re: [iwl-net PATCH v3] idpf: fix a race in txq wakeup
Message-ID: <20250502093941.GG3339421@horms.kernel.org>
References: <20250501170617.1121247-1-brianvv@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501170617.1121247-1-brianvv@google.com>

On Thu, May 01, 2025 at 05:06:17PM +0000, Brian Vazquez wrote:
> Add a helper function to correctly handle the lockless
> synchronization when the sender needs to block. The paradigm is
> 
>         if (no_resources()) {
>                 stop_queue();
>                 barrier();
>                 if (!no_resources())
>                         restart_queue();
>         }
> 
> netif_subqueue_maybe_stop already handles the paradigm correctly, but
> the code split the check for resources in three parts, the first one
> (descriptors) followed the protocol, but the other two (completions and
> tx_buf) were only doing the first part and so race prone.
> 
> Luckily netif_subqueue_maybe_stop macro already allows you to use a
> function to evaluate the start/stop conditions so the fix only requires
> the right helper function to evaluate all the conditions at once.
> 
> The patch removes idpf_tx_maybe_stop_common since it's no longer needed
> and instead adjusts separately the conditions for singleq and splitq.
> 
> Note that idpf_tx_buf_hw_update doesn't need to check for resources
> since that will be covered in idpf_tx_splitq_frame.
> 
> To reproduce:
> 
> Reduce the threshold for pending completions to increase the chances of
> hitting this pause by changing your kernel:
> 
> drivers/net/ethernet/intel/idpf/idpf_txrx.h
> 
> -#define IDPF_TX_COMPLQ_OVERFLOW_THRESH(txcq)   ((txcq)->desc_count >> 1)
> +#define IDPF_TX_COMPLQ_OVERFLOW_THRESH(txcq)   ((txcq)->desc_count >> 4)
> 
> Use pktgen to force the host to push small pkts very aggressively:
> 
> ./pktgen_sample02_multiqueue.sh -i eth1 -s 100 -6 -d $IP -m $MAC \
>   -p 10000-10000 -t 16 -n 0 -v -x -c 64
> 
> Fixes: 6818c4d5b3c2 ("idpf: add splitq start_xmit")
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Josh Hay <joshua.a.hay@intel.com>
> Signed-off-by: Brian Vazquez <brianvv@google.com>
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> ---
> v3:
> - Fix typo in commit message
> v2:
> - Fix typos
> - Fix RCT in singleq function
> - No inline in c files
> - Submit to iwl-net and add Fixes tag

Thanks Brian,

This version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


