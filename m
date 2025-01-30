Return-Path: <netdev+bounces-161635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD5BA22CE7
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 13:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122B13A20F2
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 12:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441CD1C07E7;
	Thu, 30 Jan 2025 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YfqErh34"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5D11B425D
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738239987; cv=none; b=gbQNTK4mBJZH07cWiCkAv9blf4o5schdIMUpUcnyUVTwG8z0FDYLL9lmLL2qChxx8wK6+JSTJXooP5s4CrMyhEAPvVQnNLsvrwel+ebu4vJ7MfwiN4JpifaYFJPfhnR7rFREwfvAh7MY/xoafympri6fOVitGToTClVE9jAQgOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738239987; c=relaxed/simple;
	bh=hmxVBsWwS3/CubSu1zrMdICiMvkIVQhrbAsot8NgaXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i08a932aRn+f3OKvPny63dWKWFOSN1J0ve8pU4P0rPRVTeFpEsVVnjcvKyPMMxNYRFElYHaxa+zxvQBFlqqfJwlt0/MSFe3pzNWm8kLPBb3emRpBnEmTfjUUi+8Z6I08XD3MjmONW+D99SDLrKcaV3Mpi5eICLOpyARcNZsrjZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YfqErh34; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4aa25d98-4df2-4950-89a4-e749d60116be@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738239982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5IAIyIdNeCzO/im6VHwrT3okPReIA2s9UlJ8+PChQs=;
	b=YfqErh342rYkOdjnfdxXmYkcoNas4nHEgGBmcIerhXtzStgW3bqg5r1o9QQrnG2tVNIBFf
	nVIhARM2bZxl0w+vzvULaXwaPcJzO6Bp+QdvtFtTEfuSI5fpmc66DA88442O9gQd3FUb46
	PUrGvDeTRH9twwi0AeX1QqOGjmdoGMw=
Date: Thu, 30 Jan 2025 12:26:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ethtool-next v2 05/14] qsfp: Refactor sff8636_show_dom()
 by moving code into separate functions
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: mkubecek@suse.cz, matt@traverse.com.au, daniel.zahka@gmail.com,
 amcohen@nvidia.com, nbu-mlxsw@exchange.nvidia.com
References: <20250129131547.964711-1-danieller@nvidia.com>
 <20250129131547.964711-6-danieller@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250129131547.964711-6-danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/01/2025 05:15, Danielle Ratson wrote:
> The sff8636_show_dom() function is quite lengthy, and with the planned
> addition of JSON support, it will become even longer and more complex.
> 
> To improve readability and maintainability, refactor the function by
> moving portions of the code into separate functions, following the
> approach used in the cmis.c module.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>   qsfp.c | 126 ++++++++++++++++++++++++++++++++++++---------------------
>   1 file changed, 80 insertions(+), 46 deletions(-)
> 
> diff --git a/qsfp.c b/qsfp.c
> index d272dbf..994ad5f 100644
> --- a/qsfp.c
> +++ b/qsfp.c
> @@ -649,13 +649,85 @@ out:
>   	}
>   }
>   
> -static void sff8636_show_dom(const struct sff8636_memory_map *map)
> +static void sff8636_show_dom_chan_lvl_tx_bias(const struct sff_diags *sd)
>   {
> -	struct sff_diags sd = {0};
> -	char *rx_power_string = NULL;
>   	char power_string[MAX_DESC_SIZE];
>   	int i;
>   
> +	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
> +		snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
> +			 "Laser tx bias current", i+1);
> +		PRINT_BIAS(power_string, sd->scd[i].bias_cur);
> +	}
> +}
> +
> +static void sff8636_show_dom_chan_lvl_tx_power(const struct sff_diags *sd)
> +{
> +	char power_string[MAX_DESC_SIZE];
> +	int i;
> +
> +	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
> +		snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
> +			 "Transmit avg optical power", i+1);
> +		PRINT_xX_PWR(power_string, sd->scd[i].tx_power);
> +	}
> +}
> +
> +static void sff8636_show_dom_chan_lvl_rx_power(const struct sff_diags *sd)
> +{
> +	char power_string[MAX_DESC_SIZE];
> +	char *rx_power_string = NULL;
> +	int i;
> +
> +	if (!sd->rx_power_type)
> +		rx_power_string = "Receiver signal OMA";
> +	else
> +		rx_power_string = "Rcvr signal avg optical power";
> +
> +	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
> +		snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
> +			 rx_power_string, i+1);
> +		PRINT_xX_PWR(power_string, sd->scd[i].rx_power);
> +	}
> +}
> +
> +static void
> +sff8636_show_dom_chan_lvl_flags(const struct sff8636_memory_map *map)
> +{
> +	bool value;
> +	int i;
> +
> +	for (i = 0; module_aw_chan_flags[i].fmt_str; ++i) {
> +		if (module_aw_chan_flags[i].type != MODULE_TYPE_SFF8636)
> +			continue;
> +
> +		value = map->lower_memory[module_aw_chan_flags[i].offset] &
> +			module_aw_chan_flags[i].adver_value;
> +		printf("\t%-41s (Chan %d) : %s\n",
> +		       module_aw_chan_flags[i].fmt_str,
> +		       (i % SFF8636_MAX_CHANNEL_NUM) + 1,

Looks like this way will only work when MODULE_TYPE_SFF8636 properties
starts at (offset % SFF8636_MAX_CHANNEL_NUM) == 0. Maybe we have to save
the offset of the first SFF8636 item in module_aw_chan_flags[] ?

> +		       value ? "On" : "Off");
> +	}
> +}
> +
> +static void
> +sff8636_show_dom_mod_lvl_flags(const struct sff8636_memory_map *map)
> +{
> +	int i;
> +
> +	for (i = 0; module_aw_mod_flags[i].str; ++i) {
> +		if (module_aw_mod_flags[i].type == MODULE_TYPE_SFF8636)
> +			printf("\t%-41s : %s\n",
> +			       module_aw_mod_flags[i].str,
> +			       ONOFF(map->lower_memory[module_aw_mod_flags[i].offset]
> +				     & module_aw_mod_flags[i].value));
> +	}
> +}
> +
> +static void sff8636_show_dom(const struct sff8636_memory_map *map)
> +{
> +	struct sff_diags sd = {0};
> +
>   	/*
>   	 * There is no clear identifier to signify the existence of
>   	 * optical diagnostics similar to SFF-8472. So checking existence
> @@ -687,51 +759,13 @@ static void sff8636_show_dom(const struct sff8636_memory_map *map)
>   	printf("\t%-41s : %s\n", "Alarm/warning flags implemented",
>   		(sd.supports_alarms ? "Yes" : "No"));
>   
> -	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
> -		snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
> -					"Laser tx bias current", i+1);
> -		PRINT_BIAS(power_string, sd.scd[i].bias_cur);
> -	}
> -
> -	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
> -		snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
> -					"Transmit avg optical power", i+1);
> -		PRINT_xX_PWR(power_string, sd.scd[i].tx_power);
> -	}
> -
> -	if (!sd.rx_power_type)
> -		rx_power_string = "Receiver signal OMA";
> -	else
> -		rx_power_string = "Rcvr signal avg optical power";
> -
> -	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
> -		snprintf(power_string, MAX_DESC_SIZE, "%s(Channel %d)",
> -					rx_power_string, i+1);
> -		PRINT_xX_PWR(power_string, sd.scd[i].rx_power);
> -	}
> +	sff8636_show_dom_chan_lvl_tx_bias(&sd);
> +	sff8636_show_dom_chan_lvl_tx_power(&sd);
> +	sff8636_show_dom_chan_lvl_rx_power(&sd);
>   
>   	if (sd.supports_alarms) {
> -		bool value;
> -
> -		for (i = 0; module_aw_chan_flags[i].fmt_str; ++i) {
> -			if (module_aw_chan_flags[i].type != MODULE_TYPE_SFF8636)
> -				continue;
> -
> -			value = map->lower_memory[module_aw_chan_flags[i].offset] &
> -				module_aw_chan_flags[i].adver_value;
> -			printf("\t%-41s (Chan %d) : %s\n",
> -			       module_aw_chan_flags[i].fmt_str,
> -			       (i % SFF8636_MAX_CHANNEL_NUM) + 1,
> -			       value ? "On" : "Off");
> -		}
> -		for (i = 0; module_aw_mod_flags[i].str; ++i) {
> -			if (module_aw_mod_flags[i].type == MODULE_TYPE_SFF8636)
> -				printf("\t%-41s : %s\n",
> -				       module_aw_mod_flags[i].str,
> -				       (map->lower_memory[module_aw_mod_flags[i].offset]
> -				       & module_aw_mod_flags[i].value) ?
> -				       "On" : "Off");
> -		}
> +		sff8636_show_dom_chan_lvl_flags(map);
> +		sff8636_show_dom_mod_lvl_flags(map);
>   
>   		sff_show_thresholds(sd);
>   	}


