Return-Path: <netdev+bounces-187280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB81AA6095
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 17:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7FC3AF528
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 15:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0701E1EB9E8;
	Thu,  1 May 2025 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhV8uj6m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8551D6DBF;
	Thu,  1 May 2025 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746112582; cv=none; b=nf8CHse9LUhH1BLVEIMqI+UAyJ/mye/nlhn+5X6NG6lcB9Dm+r/1NWMbQB7X32XNvGXMHRkxSjuHo8tJxFjAwAkJ4+To01MxPlFckguMDUMcnCejlHR8VBExcCYZ8LeZpgoNk6QCrQlCHWZTviGrjU5hcWeBjoSL7oHWZ6G961o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746112582; c=relaxed/simple;
	bh=DeYBnZVHnZYEBZhQbxUl90si40aAkCAJWkQr9vzu+tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u01x0AdKCtsU86iNDNC+cSwvEJOESCaL4rM4KN7boR95Z74XVtcRtPGtblkqluExAgmJ2YGKKbF5dmMfnuupUSgrmFMne4FVyu/SVVQfQcDrJopvpkmZXQUewul82UaSV4fMYUbUgfh4WJBD6q/N3hDiqx3+Nv0CFLK4TeNl5o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhV8uj6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA65C4CEED;
	Thu,  1 May 2025 15:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746112582;
	bh=DeYBnZVHnZYEBZhQbxUl90si40aAkCAJWkQr9vzu+tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LhV8uj6mRlmldjAzOQWpKP4k92NlF/xe+O2L/AzByiLRYby8Q0FpKTAWSctizCsa4
	 H4t9XBEPXfl0LWGUG4DWoHJtYzjSVE5+05tPTDYQbZp782KnSMZ55MVucclwfbG6Z4
	 h0U49b79IAwW/RcZlXaqrVQbxQYZUqaj9KCvwHeE/M7mtP6KEdp2a/QPm5bTuVRQ34
	 XPFQ6B2A5PrjoFjPB/3QPKt7Qy/TwhFoWYAVW5xrAj0A/jHKNqhpl3Io5OcvR0Lrjb
	 M7sHAjyHBcnHRrsKl9R5XhTwGdYU0VL3i51ode36mwAfFHChrBY1Kmz3b0Xh3SNhU8
	 xXG5KHUwZwcGw==
Date: Thu, 1 May 2025 16:16:16 +0100
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
	emil.s.tantilov@intel.com, Josh Hay <joshua.a.hay@intel.com>,
	Luigi Rizzo <lrizzo@google.com>
Subject: Re: [iwl-net PATCH v2] idpf: fix a race in txq wakeup
Message-ID: <20250501151616.GA3339421@horms.kernel.org>
References: <20250428195532.1590892-1-brianvv@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428195532.1590892-1-brianvv@google.com>

On Mon, Apr 28, 2025 at 07:55:32PM +0000, Brian Vazquez wrote:
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
> Note that idpf_rx_buf_hw_update doesn't need to check for resources
> since that will be covered in idpf_tx_splitq_frame.

Should the above read idpf_tx_buf_hw_update() rather than
idpf_rx_buf_hw_update()?

If so, I see that this is true when idpf_tx_buf_hw_update() is called from
idpf_tx_singleq_frame(). But is a check required in the case where
idpf_rx_buf_hw_update() is called by idpf_tx_singleq_map()?

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
> Signed-off-by: Josh Hay <joshua.a.hay@intel.com>
> Signed-off-by: Brian Vazquez <brianvv@google.com>
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>

...

