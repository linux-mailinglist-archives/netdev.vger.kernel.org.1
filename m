Return-Path: <netdev+bounces-213566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDF6B25AC3
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 07:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0615A82AD
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 05:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06582221DB0;
	Thu, 14 Aug 2025 05:20:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACF221FF4D
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 05:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755148810; cv=none; b=ESgfP37KrQUZ5g00SI4+SINX3q46Hj2pnnXrDlMrZxMMJDL6hV/gTdM7D/0TQ1O30OcawgEYa+2k8HCYMMTk+Ke70g34jk4e4R/C5eLvBj0EjD0GN6TWvDcKj8aOzGxFqLLTmQgOYoOvP601x4c7yrdt7XG76Q+WBOvDFfWwxKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755148810; c=relaxed/simple;
	bh=ajRdkpHODuqzpFDItxnZt/p3R3kGuJcvbuoxXnjQof8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6JPo4n1DAt9176AM/GFlzmHrRm9xGk5QtXiEOdMp9uKR02T/4tCNS7m0fEqDMBzmo3u7jSvJ8dv+QXrC6pjC9/nhqhEz/BEQ8jKnoAheP6QTAnWbTcalamE13hX0/dgwZgaPfW9KJxwZ25yBkJmu47UL5EJ5un0MWZsEty8rLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7f5.dynamic.kabel-deutschland.de [95.90.247.245])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 06B2561E64844;
	Thu, 14 Aug 2025 07:19:47 +0200 (CEST)
Message-ID: <ad9058eb-f1f9-4c38-b04f-9761121a48df@molgen.mpg.de>
Date: Thu, 14 Aug 2025 07:19:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: cleanup remaining SKBs in
 PTP flows
To: Anton Nadezhdin <anton.nadezhdin@intel.com>,
 Milena Olech <milena.olech@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, richardcochran@gmail.com,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20250813173304.46027-1-anton.nadezhdin@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250813173304.46027-1-anton.nadezhdin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Anton, dear Milena,


Thank you for the patch.

Am 13.08.25 um 19:33 schrieb Anton Nadezhdin:
> From: Milena Olech <milena.olech@intel.com>
> 
> When the driver requests Tx timestamp value, one of the first steps is
> to clone SKB using skb_get. It increases the reference counter for that
> SKB to prevent unexpected freeing by another component.
> However, there may be a case where the index is requested, SKB is
> assigned and never consumed by PTP flows - for example due to reset during
> running PTP apps.
> 
> Add a check in release timestamping function to verify if the SKB
> assigned to Tx timestamp latch was freed, and release remaining SKBs.
> 
> Fixes: 4901e83a94ef ("idpf: add Tx timestamp capabilities negotiation")
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_ptp.c          | 3 +++
>   drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> index ee21f2ff0cad..63a41e688733 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> @@ -855,6 +855,9 @@ static void idpf_ptp_release_vport_tstamp(struct idpf_vport *vport)
>   	head = &vport->tx_tstamp_caps->latches_in_use;
>   	list_for_each_entry_safe(ptp_tx_tstamp, tmp, head, list_member) {
>   		list_del(&ptp_tx_tstamp->list_member);
> +		if (ptp_tx_tstamp->skb)
> +			consume_skb(ptp_tx_tstamp->skb);
> +
>   		kfree(ptp_tx_tstamp);
>   	}
>   
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> index 4f1fb0cefe51..688a6f4e0acc 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> @@ -517,6 +517,7 @@ idpf_ptp_get_tstamp_value(struct idpf_vport *vport,
>   	shhwtstamps.hwtstamp = ns_to_ktime(tstamp);
>   	skb_tstamp_tx(ptp_tx_tstamp->skb, &shhwtstamps);
>   	consume_skb(ptp_tx_tstamp->skb);
> +	ptp_tx_tstamp->skb = NULL;

This hunk is not clear to me from the commit message, and the whole diff.

>   
>   	list_add(&ptp_tx_tstamp->list_member,
>   		 &tx_tstamp_caps->latches_free);

Kind regards,

Paul

