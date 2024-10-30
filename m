Return-Path: <netdev+bounces-140331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2779B5FEC
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 11:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABB7BB21A4E
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 10:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D3A1E2313;
	Wed, 30 Oct 2024 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGXWyE7e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43DB1E22F4
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283650; cv=none; b=DmLXkrvuQEmNyNQ3Jq+hazxA4/3Z3oX2iRmNicBFLWPp+wPVnt9cCRJKe/0i6baGN3IHS1c7zU55w8xgvyGnmJup2+dBFJ2Pgb4tCIa02HZizkzb4WlIrhMm1xlihXCqPwxaxisgdVhhpdyVjF0Mn6d4GkKkVfatNFxpVqbqlLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283650; c=relaxed/simple;
	bh=rWrliluYOC1q38lpqheDkUZ2pQHfdwkJwSGi6+DsTyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqVg7ETOnix9aZ8WYdfTakudwYcVEF2JXhAOUlWJ3TNdwSiQPnSC49aF2WlStwxHeBAn4ssCw7t311RUhLy+Qr7jnyWR3ZCMs7wl1lUjjGouVUVWWOSCYL3LZe6dNkh9iO0ydCZtgdkrdKEr2AErDXyLwtghMriKl9Mc/daxNhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGXWyE7e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730283646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OcLiLkMiXm/YlYX/9LXkvHvt6awYdtKfm+QQsHQ3YoE=;
	b=KGXWyE7eP6noTaHu4cLF1lBT/Z6Qld12MkUNDD82qn5ImRK/mFqhIAeqtevAO99As9odNv
	RojEHAx544rol5CmaqbnK7huMKwcEbYpaOZfiYpBAJGgtxRkcrbPYF3a88thVTjzJTok2H
	ax6WyfMMYjvKyf6OXXoFPiT2ddeIGEY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-RCBIvOr9PcujWkYbDAA_8g-1; Wed,
 30 Oct 2024 06:20:41 -0400
X-MC-Unique: RCBIvOr9PcujWkYbDAA_8g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE7A419560B5;
	Wed, 30 Oct 2024 10:20:39 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.194.141])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89B9119560AA;
	Wed, 30 Oct 2024 10:20:39 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5F2BDA80980; Wed, 30 Oct 2024 11:20:37 +0100 (CET)
Date: Wed, 30 Oct 2024 11:20:37 +0100
From: Corinna Vinschen <vinschen@redhat.com>
To: Chris H <christopher.s.hall@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
	vinicius.gomes@intel.com, netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com
Subject: Re: [PATCH iwl-net v2 4/4] igc: Add lock preventing multiple
 simultaneous PTM transactions
Message-ID: <ZyIIdTT-_pKC018c@calimero.vinschen.de>
Mail-Followup-To: Chris H <christopher.s.hall@intel.com>,
	intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
	vinicius.gomes@intel.com, netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com
References: <20241023023040.111429-1-christopher.s.hall@intel.com>
 <20241023023040.111429-5-christopher.s.hall@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023023040.111429-5-christopher.s.hall@intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Chris,

Same question as in the v1 thread:

On Oct 23 02:30, Chris H wrote:
> From: Christopher S M Hall <christopher.s.hall@intel.com>
> 
> Add a mutex around the PTM transaction to prevent multiple transactors
> 
> Multiple processes try to initiate a PTM transaction, one or all may
> fail. This can be reproduced by running two instances of the
> following:
> 
> $ sudo phc2sys -O 0 -i tsn0 -m
> 
> PHC2SYS exits with:
> 
> "ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
>  fails
> 
> Note: Normally two instance of PHC2SYS will not run, but one process
>  should not break another.
> 
> Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
> Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>

I saw a former version of the patch which additionally added a mutex
lock/unlock in igc_ptp_reset() just before calling igc_ptm_trigger().
Is it safe to skip that?  igc_ptp_reset() is called from igc_reset()
which in turn is called from quite a few places.


Thanks,
Corinna





> ---
>  drivers/net/ethernet/intel/igc/igc.h     |  1 +
>  drivers/net/ethernet/intel/igc/igc_ptp.c | 12 ++++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index eac0f966e0e4..323db1e2be38 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -319,6 +319,7 @@ struct igc_adapter {
>  	struct timespec64 prev_ptp_time; /* Pre-reset PTP clock */
>  	ktime_t ptp_reset_start; /* Reset time in clock mono */
>  	struct system_time_snapshot snapshot;
> +	struct mutex ptm_lock; /* Only allow one PTM transaction at a time */
>  
>  	char fw_version[32];
>  
> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
> index fb885fcaa97c..4e1379b7d2ee 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
> @@ -1068,9 +1068,16 @@ static int igc_ptp_getcrosststamp(struct ptp_clock_info *ptp,
>  {
>  	struct igc_adapter *adapter = container_of(ptp, struct igc_adapter,
>  						   ptp_caps);
> +	int ret;
>  
> -	return get_device_system_crosststamp(igc_phc_get_syncdevicetime,
> -					     adapter, &adapter->snapshot, cts);
> +	/* This blocks until any in progress PTM transactions complete */
> +	mutex_lock(&adapter->ptm_lock);
> +
> +	ret = get_device_system_crosststamp(igc_phc_get_syncdevicetime,
> +					    adapter, &adapter->snapshot, cts);
> +	mutex_unlock(&adapter->ptm_lock);
> +
> +	return ret;
>  }
>  
>  static int igc_ptp_getcyclesx64(struct ptp_clock_info *ptp,
> @@ -1169,6 +1176,7 @@ void igc_ptp_init(struct igc_adapter *adapter)
>  	spin_lock_init(&adapter->ptp_tx_lock);
>  	spin_lock_init(&adapter->free_timer_lock);
>  	spin_lock_init(&adapter->tmreg_lock);
> +	mutex_init(&adapter->ptm_lock);
>  
>  	adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
>  	adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
> -- 
> 2.34.1


