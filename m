Return-Path: <netdev+bounces-238010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7346AC52A10
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C54934C251
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066642797AE;
	Wed, 12 Nov 2025 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NBAPIM7N"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051472797AC
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956737; cv=none; b=u1YF8sp8ptrIVkGRXAppQcPt6duUbja8lFEQbDAHh/TDlx7i92aZKWCXDYSoMEKNB8AUXR/OwyrA19DtIVjq5ZlwxuDj4SvuGoG2XgHZmnNm+n6ewBI2QfmXWbGCanmvwUnSPdNytiOgg0+zcrH2PkanEgkQLumFHswHx4O4rH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956737; c=relaxed/simple;
	bh=F5X9qOXsyM1mUEK+0vABJYOFK47Bb8X+n/aMsCtriIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8TYXx9XrBu4tXummNIVAtkWw2wFHm00LbAxFJAolgb9tqFBl9S3+TTardmntc+2G/E93cIOawKPVaMoWO/SDCNrAPimv+EIMME3hOi3BHaXZayj2/zsOJLoPCK804rtBDNOm60Mrvy5bTDlbAHG5cO+r16sbWaq1OlqYeC47i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NBAPIM7N; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <886723c3-ff9e-43cf-a1da-021f1ff088ab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762956732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tHlJLaEX8wPWCv+MNAdT//lMOMThqQ+egSg5dpPwhM=;
	b=NBAPIM7NTnL6Oke3uHuDtlpxqnMu3Xz3yGytuxOV7DgudvQDwuTGz6mOaoPfoK0PQTvnh/
	suji2xrIIIlzJHOqVIZkz8QDsnDs7XISZj2IAr97irI8JQ5Xr3fc1brGHTpBAhQa3qqSz/
	dmcuHLs5Ee1M4dhKetJ/zRuxKpUcN38=
Date: Wed, 12 Nov 2025 14:12:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/6] dpll: zl3073x: Store raw register values
 instead of parsed state
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20251111181243.4570-1-ivecera@redhat.com>
 <20251111181243.4570-2-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251111181243.4570-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/11/2025 18:12, Ivan Vecera wrote:
> The zl3073x_ref, zl3073x_out and zl3073x_synth structures
> previously stored state that was parsed from register reads. This
> included values like boolean 'enabled' flags, synthesizer selections,
> and pre-calculated frequencies.
> 
> This commit refactors the state management to store the raw register
> values directly in these structures. The various inline helper functions
> are updated to parse these raw values on-demand using FIELD_GET.
> 
> Reviewed-by: Petr Oros <poros@redhat.com>
> Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/core.c | 81 ++++++++++++-------------------------
>   drivers/dpll/zl3073x/core.h | 61 ++++++++++++++++------------
>   2 files changed, 60 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
> index e42e527813cf8..50c1fe59bc7f0 100644
> --- a/drivers/dpll/zl3073x/core.c
> +++ b/drivers/dpll/zl3073x/core.c
> @@ -598,25 +598,22 @@ int zl3073x_write_hwreg_seq(struct zl3073x_dev *zldev,
>    * @zldev: pointer to zl3073x_dev structure
>    * @index: input reference index to fetch state for
>    *
> - * Function fetches information for the given input reference that are
> - * invariant and stores them for later use.
> + * Function fetches state for the given input reference and stores it for
> + * later user.
>    *
>    * Return: 0 on success, <0 on error
>    */
>   static int
>   zl3073x_ref_state_fetch(struct zl3073x_dev *zldev, u8 index)
>   {
> -	struct zl3073x_ref *input = &zldev->ref[index];
> -	u8 ref_config;
> +	struct zl3073x_ref *ref = &zldev->ref[index];
>   	int rc;
>   
>   	/* If the input is differential then the configuration for N-pin
>   	 * reference is ignored and P-pin config is used for both.
>   	 */
> -	if (zl3073x_is_n_pin(index) &&
> -	    zl3073x_ref_is_diff(zldev, index - 1)) {
> -		input->enabled = zl3073x_ref_is_enabled(zldev, index - 1);
> -		input->diff = true;
> +	if (zl3073x_is_n_pin(index) && zl3073x_ref_is_diff(zldev, index - 1)) {
> +		memcpy(ref, &zldev->ref[index - 1], sizeof(*ref));

Oh, it's not obvious from the code that it's actually safe, unless
reviewer remembers that N-pins have only even indexes.
Have you thought of adding an abstraction for differential pair pins?

>   
>   		return 0;
>   	}

