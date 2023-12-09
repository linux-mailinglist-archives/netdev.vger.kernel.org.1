Return-Path: <netdev+bounces-55506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F8280B118
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 01:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33351F21283
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 00:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9091464E;
	Sat,  9 Dec 2023 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nB9fF8tL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C331716;
	Fri,  8 Dec 2023 16:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702083259; x=1733619259;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8pxbXmVjtgxQ6jJTKi3HMK6M41nw+oEV1H8AuJRdMJw=;
  b=nB9fF8tLQHakrm4N6VoggAbm7atLIFWZwON8EVdE+g/w00FERsfSsF7G
   zWxtpf1kTaNeJzCqmU5tc4+lKBxI67cUXDYXN1I3bPvvpcUuBIWCAMPwJ
   3SLfWQJSlfrbzMfFVlhrxFbdPni64uJ+sQ/tKSJFiInPukI2Qq5+BxdXW
   PGEZSqa6ttkeH7vUKc5qF6VTXqwVHNQdKJivMnvHgXRbjMnCS9pflZroh
   SZIBprcEdBQUSMurFrqAo3QcW6Lofb3LUsNQbOZPpCG8g7oAyMFD0SLC3
   zdu0KY1UUzUWFS1gq8tvwtvYu5gm+4QjQ9VnGvAdI1LfUNBv3eAwvCCOP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="425613704"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="425613704"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 16:54:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="863063915"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="863063915"
Received: from jcquinta-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.47.201])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 16:54:17 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Rodrigo Cataldo via B4 Relay
 <devnull+rodrigo.cadore.l-acoustics.com@kernel.org>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Aravindhan Gunasekaran
 <aravindhan.gunasekaran@intel.com>, Mallikarjuna Chilakala
 <mallikarjuna.chilakala@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>,
 Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>
Subject: Re: [PATCH iwl-net] igc: Fix hicredit calculation
In-Reply-To: <20231208-igc-fix-hicredit-calc-v1-1-7e505fbe249d@l-acoustics.com>
References: <20231208-igc-fix-hicredit-calc-v1-1-7e505fbe249d@l-acoustics.com>
Date: Fri, 08 Dec 2023 16:54:17 -0800
Message-ID: <871qbwry9y.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rodrigo Cataldo via B4 Relay
<devnull+rodrigo.cadore.l-acoustics.com@kernel.org> writes:

> From: Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>
>
> According to the Intel Software Manual for I225, Section 7.5.2.7,
> hicredit should be multiplied by the constant link-rate value, 0x7736.
>
> Currently, the old constant link-rate value, 0x7735, from the boards
> supported on igb are being used, most likely due to a copy'n'paste, as
> the rest of the logic is the same for both drivers.
>
> Update hicredit accordingly.
>
> Fixes: 1ab011b0bf07 ("igc: Add support for CBS offloading")
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> Signed-off-by: Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>
> ---

Very good catch.

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Just for curiosity, my test machines are busy right now, what kind of
difference are you seeing?

> This is a simple fix for the credit calculation on igc devices
> (i225/i226) to match the Intel software manual.
>
> This is my first contribution to the Linux Kernel. Apologies for any
> mistakes and let me know if I improve anything.
> ---
>  drivers/net/ethernet/intel/igc/igc_tsn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index a9c08321aca9..22cefb1eeedf 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -227,7 +227,7 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
>  			wr32(IGC_TQAVCC(i), tqavcc);
>  
>  			wr32(IGC_TQAVHC(i),
> -			     0x80000000 + ring->hicredit * 0x7735);
> +			     0x80000000 + ring->hicredit * 0x7736);
>  		} else {
>  			/* Disable any CBS for the queue */
>  			txqctl &= ~(IGC_TXQCTL_QAV_SEL_MASK);
>
> ---
> base-commit: 2078a341f5f609d55667c2dc6337f90d8f322b8f
> change-id: 20231206-igc-fix-hicredit-calc-028bf73c50a8
>
> Best regards,
> -- 
> Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>
>

Cheers,
-- 
Vinicius

