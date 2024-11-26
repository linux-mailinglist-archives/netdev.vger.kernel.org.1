Return-Path: <netdev+bounces-147392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDBE9D95DC
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 11:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F321B22446
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5121C8FBA;
	Tue, 26 Nov 2024 10:53:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7430679DC
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618425; cv=none; b=P44U84xbOhPapd/1+7t5tCpYJIII3Q8uFoujYCj/oY15RoHqsz684/zGhst+MBJus+ISNbty2XKcwVR5rKMA51qzZGaOKbiWj2QPv0qjW2L/WEKbXbHtTA5SmaP2X0uxvCGsVFlZzP6xhven/BX747HSWHGdeCqojOR0nifo9h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618425; c=relaxed/simple;
	bh=RtAK+BErpbEzYBuxXqyZ9JpwyoO0HlM0iV4hpQE/GYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdghaUVqXS4rr3oXvi9hKaC4t9DLJKISJzW+nqC178Wbds5jr/splmfmSjCnkQPt2SaUe0HzL9Sf3YkpRpehQsMgelF5eUn5PxPRdtuusc6fRkew3bUaE66v3weekQcEw9SYOeZxp65XaBt8cf+4XNgSZgAEovfJx5W+0jepnwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8562861E6477C;
	Tue, 26 Nov 2024 11:53:22 +0100 (CET)
Message-ID: <b1d2b8a5-1dae-4247-8fb7-1b73ee0a89ee@molgen.mpg.de>
Date: Tue, 26 Nov 2024 11:53:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: fix incorrect PHY settings
 for 100 GB/s
To: Przemyslaw Korba <przemyslaw.korba@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
 Milena Olech <milena.olech@intel.com>, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com
References: <20241126102311.344972-1-przemyslaw.korba@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241126102311.344972-1-przemyslaw.korba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Przemyslaw,



Thank you for your patch.

Am 26.11.24 um 11:23 schrieb Przemyslaw Korba:
> ptp4l application reports too high offset when ran on E823 device
> with a 100GB/s link. Those values cannot go under 100ns, like in a
> PTP working case when using 100 GB/s cable.
> This is due to incorrect frequency settings on the PHY clocks for
> 100 GB/s speed. Changes are introduced to align with the internal
> hardware documentation, and correctly initialize frequency in PHY

It’d be great if you added the documentation name.

> clocks with the frequency values that are in our HW spec.
> To reproduce the issue run ptp4l as a Time Receiver on E823 device,
> and observe the offset, which will never approach values seen
> in the PTP working case.

(I’d add a blank line between paragraphs.)

Also, I always like to see pastes from the commands you ran to reproduce 
this. It’s always good for comparison.

> Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")

Any idea, where the wrong values came from? Will your test be added to 
the test procedure?

> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp_consts.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
> index 6620642077bb..bdb1020147d1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
> @@ -761,9 +761,9 @@ const struct ice_vernier_info_e82x e822_vernier[NUM_ICE_PTP_LNK_SPD] = {
>   		/* rx_desk_rsgb_par */
>   		644531250, /* 644.53125 MHz Reed Solomon gearbox */
>   		/* tx_desk_rsgb_pcs */
> -		644531250, /* 644.53125 MHz Reed Solomon gearbox */
> +		390625000, /* 390.625 MHz Reed Solomon gearbox */
>   		/* rx_desk_rsgb_pcs */
> -		644531250, /* 644.53125 MHz Reed Solomon gearbox */
> +		390625000, /* 390.625 MHz Reed Solomon gearbox */
>   		/* tx_fixed_delay */
>   		1620,
>   		/* pmd_adj_divisor */

Kind regards,

Paul

