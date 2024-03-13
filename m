Return-Path: <netdev+bounces-79652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC07587A6AD
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 12:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2611C21D45
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 11:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8BF3E47B;
	Wed, 13 Mar 2024 11:05:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0143D386
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327949; cv=none; b=cbezw7+efnE49U/MdLoMRRbTVY3jtPLqwYpwCxgylvfmInHGzcGnF3hWXBtXqhqNvzPCO2A9rDNYFWFwvqOLqMvMHANVHixp3fcAhUjjm3Pv+L5uRzeBJP/LCDvJYLja4rwELPQHNIyTDLFrbxxwKFUTZ478yJ5FZO5H1mcSbTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327949; c=relaxed/simple;
	bh=TlQJijplGAKIb2a0aR4nOHHsKVE7w0rTFEO2tGw+Ljc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IS3JViYjkEaCh2tCYJ8+aa8ps6vWgJVr3bwyUxc5T+hSGcJ4qfRjEXMsoSwnVKlAezbSuP6izyAUYe0VDi+KrA77q0PKEfga1fhVW7uqYqBrvIwq3/Sb7GQpEAK7o3+vn0NAyBNHnSfWdy+5nEPnRQJ6FaQz2m17HIY/68Oqfag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4668B61E5FE04;
	Wed, 13 Mar 2024 12:05:29 +0100 (CET)
Message-ID: <d64cd3d6-a13a-48da-8658-7cfc12d98066@molgen.mpg.de>
Date: Wed, 13 Mar 2024 12:05:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] i40e: fix
 i40e_count_filters() to count only active/new filters
Content-Language: en-US
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
References: <20240313094400.6485-1-aleksandr.loktionov@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240313094400.6485-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Aleksandr,


Am 13.03.24 um 10:44 schrieb Aleksandr Loktionov:
> The bug usually affects untrusted VFs, because they are limited to 18MACs,
> it affects them badly, not letting to create MAC all filters.
> Not stable to reproduce, it happens when VF user creates MAC filters
> when other MACVLAN operations are happened in parallel.
> But consequence is that VF can't receive desired traffic.
> 
> Fix counter to be bumped only for new or active filters.
> 
> Fixes: 621650cabee5 ("i40e: Refactoring VF MAC filters counting to make more reliable")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
> v1 -> v2: add explanation about the bug

Thank you very much. (I personally wouldn’t break lines just because a 
sentence ends.)

> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 89a3401..6010a49 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -1257,8 +1257,11 @@ int i40e_count_filters(struct i40e_vsi *vsi)
>   	int bkt;
>   	int cnt = 0;
>   
> -	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist)
> -		++cnt;
> +	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist) {
> +		if (f->state == I40E_FILTER_NEW ||
> +		    f->state == I40E_FILTER_ACTIVE)
> +			++cnt;
> +	}
>   
>   	return cnt;
>   }

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

