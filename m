Return-Path: <netdev+bounces-147869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813849DE9C3
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 16:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA67BB233A8
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 15:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F8C1990C1;
	Fri, 29 Nov 2024 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cm3v5zcV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F44149C4A
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732894672; cv=none; b=Rs4nlVSoMzXE01D6fuwT7YIZOhTbdcByzSSf1qe2ugikPkSCnl7YTQORB2I3eHzfr2WzDaDHxCRSop9RHjA/ZPGkIyIQyq2VFyh9TCiSgfTTDzB7/y0OAfYR9K5xDNcFnCkNhLi0gS2Ymrvv64/EA1l5TqUyvOgIavBRlEsUjT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732894672; c=relaxed/simple;
	bh=aCCFWpiZxL+4fyT8l2tKnr/Kr00+ydVdNeUDcaZv9hM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VjjunBRBAOVp/orUbBcZoKCp1kxkXo7W4QZCgGqTwUjJwvecVU0CP2KQJzhRjYT7NnyPeL/l2aSrVUYMLs5fWeCBpCGgW6O56YtVyzSOOpem+HD7HwFYBuiXlHRPyp2Z+7Nar5aHsX0jSXAxPOsMe6m/l7upwNUlU8fqpSCc3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cm3v5zcV; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d403b1d050so13827556d6.1
        for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 07:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732894669; x=1733499469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4lSa2k5avuy1/0rqwlB+ZozQszT7LmIlkao2GIr0D8=;
        b=Cm3v5zcVj96xQ0Tfn6h40tXx4UAC3yINKRRW3onmKpdyNC1X56pjPhuEWK5SrvOrxh
         2RxLg01wAnKgk/LuNQ0fKsUUsNeZym1vvJHb+9HDKrj7BYSR9HR6DF8vEH3bLMcT/x65
         7LrqQCeyP4OzcK4tVuk4j6Psiffz8ZOmMAmupjylhVHTLCP+DoJNgcwZuSvjRXXPf64v
         xBZ2E0i16lJ1bBVe6IawW0lxyXxt3Sk+jDLBMZ0+7q/lfTIplZWk3CaEFilpd1ZAi1gD
         zjzUsmM/vMfMJDXf6THhBTI+NwpjLZIqg8tfwQymBUqhngb+eVSyj6v+YTbl1Zv4Nw7u
         JI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732894669; x=1733499469;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C4lSa2k5avuy1/0rqwlB+ZozQszT7LmIlkao2GIr0D8=;
        b=ks/quqrakLpYOC0iGgQ9SX9JTpuv8sFR8XTvqAt9hJN+7+pL3LqprMtlEpPswhGPxf
         UR34dgYDvEQrulBsQ+rbIt6wVWNqAWqidi2rgMStrV/0AtiivgestQNSb6QRxW+avBhj
         dlrV6x4+hYnotDZ6CNX02Nrf3j9rjdTNrbzNwR3LblKVumrIhVhqmsAJOFjM4eWtFg8d
         6P8TLXRUShZhP7RGBMBfUCyDZplOqtZ235iql3GGiF1NqhHkO84vWbz7SBO35c54iKw5
         sfZAaTPD41vgVzTh+a08Pl1a5d+mLBaEWM9grQxsQBsga9G2hWHz5Y8iRGzWPjM8YPle
         Q00g==
X-Gm-Message-State: AOJu0Yxup9SfR3RxiovbBjIxn4lzUzVGf9RD3uHM/A3vw3oYxCDN0laP
	xuXtkgUsnd9Wgwh6JiZMPsbNGqSIHgd/SYcXpzYtG+7BExIH9IyFFKRsVA==
X-Gm-Gg: ASbGnct+OLo7od70wk/Rk28ecLo226PiIgK781c8nlPBw5TrxJ0WbnfrUMLvUq79vhb
	7el30+oa5PnvljprmD/I1eFa3Fr0gKXuW3VqvlzyLgwlbi0jfxtRJXv4wRpntwl4O5yj9GhjTg7
	6f8OJAOnYiS1rcyBmDCuajytOYEqiM6OSzZfqF2rDscm593u5PY8aJ674sDaNdgy3KsrSt+QGfA
	GOVDfZpPqhaL1DMpWJseFk9JAuOgxvkzHWicQzSTxMs0kQr8azzt3LBEhLzJMD19ipfZZhXnE1s
	Y3ZMq65Btg5fBWHqTdmVGw==
X-Google-Smtp-Source: AGHT+IHekeEK7b1XZLO6Tq6Psxgik5Oe6Z0aFTiDrNLP6NZ8DNZOmzvF1b4zfysABXWL7BzA4c+tvg==
X-Received: by 2002:a0c:eb85:0:b0:6d8:821d:7370 with SMTP id 6a1803df08f44-6d8821db4aemr53306806d6.49.1732894669415;
        Fri, 29 Nov 2024 07:37:49 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8752309edsm17038056d6.131.2024.11.29.07.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:37:48 -0800 (PST)
Date: Fri, 29 Nov 2024 10:37:48 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Milena Olech <milena.olech@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Milena Olech <milena.olech@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Message-ID: <6749dfcc21228_23772a29463@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241126035849.6441-8-milena.olech@intel.com>
References: <20241126035849.6441-1-milena.olech@intel.com>
 <20241126035849.6441-8-milena.olech@intel.com>
Subject: Re: [PATCH v2 iwl-next 07/10] idpf: add Tx timestamp capabilities
 negotiation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Milena Olech wrote:
> Tx timestamp capabilities are negotiated for the uplink Vport.
> Driver receives information about the number of available Tx timestamp
> latches, the size of Tx timestamp value and the set of indexes used
> for Tx timestamping.
> 
> Add function to get the Tx timestamp capabilities and parse the uplink
> vport flag.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Co-developed-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> ---
> v1 -> v2: change the idpf_for_each_vport macro
> 
>  drivers/net/ethernet/intel/idpf/idpf.h        |   6 +
>  drivers/net/ethernet/intel/idpf/idpf_ptp.c    |  69 ++++++++++
>  drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  96 ++++++++++++-
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  11 ++
>  .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   | 128 +++++++++++++++++-
>  drivers/net/ethernet/intel/idpf/virtchnl2.h   |  10 +-
>  6 files changed, 317 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
> index 1607e9641b23..14b82e93dab5 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -292,6 +292,7 @@ struct idpf_port_stats {
>   * @port_stats: per port csum, header split, and other offload stats
>   * @link_up: True if link is up
>   * @sw_marker_wq: workqueue for marker packets
> + * @tx_tstamp_caps: The capabilities negotiated for Tx timestamping
>   */
>  struct idpf_vport {
>  	u16 num_txq;
> @@ -336,6 +337,8 @@ struct idpf_vport {
>  	bool link_up;
>  
>  	wait_queue_head_t sw_marker_wq;
> +
> +	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
>  };
>  
>  /**
> @@ -480,6 +483,9 @@ struct idpf_vport_config {
>  
>  struct idpf_vc_xn_manager;
>  
> +#define idpf_for_each_vport(adapter, i) \
> +	for ((i) = 0; (i) < (adapter)->num_alloc_vports; (i)++)
> +

I did not mean to make the code less readable. My suggestion was

    #define idpf_for_each_vport(adapter, vport) \
        for (int i = 0; vport = &(adapter)->vports[i], i < (adapter)->num_alloc_vports; i++)

I see that this now requires defining a variable i outside of the
loop. I suppose because of a possible namespace collision otherwise?

That can be addressed with the same stringification as the original
code. But then may as well revert to that. The following is no
more readable

    #define idpf_for_each_vport(adapter, vport) \
        for (int __idx_##vport = 0; \
             vport = &((adapter)->vports[__idx_##vport]), __idx_##vport < (adapter)->num_alloc_vports; \
             __idx_##vport++)

Please choose whichever path you prefer, including the original.

Not for this series, but a wrapper might also be helpful for
idpf_vport_for_each_rxq. To isolate the singleq vs splitq in one
location. I see that come up a come up times in this series too.

