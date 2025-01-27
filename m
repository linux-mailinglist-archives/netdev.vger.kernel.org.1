Return-Path: <netdev+bounces-161187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35842A1DCE8
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 20:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4576C18850DD
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 19:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6EA192D86;
	Mon, 27 Jan 2025 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oaLXmlT8"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2731D18D626
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738007055; cv=none; b=Pk2ZbuTWOtFoYDY/1KU5BDTZkWRjK01GO91CqfzBXHl0FOOU4p9xe3O6bIsEQaN+NDdgcwjDdtj8mY6KpMMCn4G/ilQPZoKS/nCmFa5w+21NbhsJ8wXM1nvwSCgPsfbMgPXbir7Vjd+wg/EAYcvFvKCVsC1FCgVVhr1MbICCZ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738007055; c=relaxed/simple;
	bh=vS1Z8WrktbS6FtJbnSaf3L/jWgeMmDZAI4veKoJwT7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sff/d+XnDJrC0EB0Yuvj85BrZ0A3WDf+1HY5FROu1BULnlpS9G44tbi3XWoFeNyuQFZMTHcMmu5zlwdkRpe9tgtu8MFmKKa3IKOOZ185y76rmVvIuI81d8sPkeJ6jBffYAE7KwzZ+rgREqm3VvFDYwwzP/GrbQjuwrv0Qqp521Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oaLXmlT8; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dd574fdf-8e65-4c03-9dd7-105de4cece74@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738007049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gge5VU1+GkLyAwM9wc5sJHKfTv3SgI79lDY+5NnjGIU=;
	b=oaLXmlT8jPTm/59xdzXSVxoAeIoF1/AOWWGELf9KBfBHuMqlWhLppsXyrCW50S78I8Koy7
	SluDVdkN3OWCOxSS98Suh98XU89EgtjfSI2jrl8sUXoLZutn70eDL6YVjNUtVXr8jj+bO5
	I+H7OpsPlmRyUWoAitugz5MRBllu+CE=
Date: Mon, 27 Jan 2025 11:44:03 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ethtool-next 05/14] qsfp: Refactor sff8636_show_dom() by
 moving code into separate functions
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: mkubecek@suse.cz, matt@traverse.com.au, daniel.zahka@gmail.com,
 amcohen@nvidia.com, nbu-mlxsw@exchange.nvidia.com
References: <20250126115635.801935-1-danieller@nvidia.com>
 <20250126115635.801935-6-danieller@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250126115635.801935-6-danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/01/2025 03:56, Danielle Ratson wrote:
> The sff8636_show_dom() function is quite lengthy, and with the planned
> addition of JSON support, it will become even longer and more complex.
> 
> To improve readability and maintainability, refactor the function by
> moving portions of the code into separate functions, following the
> approach used in the cmis.c module.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>   qsfp.c | 144 +++++++++++++++++++++++++++++++++++----------------------
>   1 file changed, 89 insertions(+), 55 deletions(-)
> 
> diff --git a/qsfp.c b/qsfp.c
> index 674242c..13d8fb7 100644
> --- a/qsfp.c
> +++ b/qsfp.c
> @@ -649,13 +649,94 @@ out:
>   	}
>   }
>   
> -static void sff8636_show_dom(const struct sff8636_memory_map *map)
> +static void sff8636_show_dom_chan_lvl_tx_bias(const struct sff_diags *sd)
> +{
> +	char power_string[MAX_DESC_SIZE];
> +	int i;
> +
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
>   {
> -	struct sff_diags sd = {0};
> -	char *rx_power_string = NULL;
>   	char power_string[MAX_DESC_SIZE];
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
>   	int i;
>   
> +	for (i = 0; module_aw_chan_flags[i].fmt_str; ++i) {
> +		int j = 1;
> +
> +		if (module_aw_chan_flags[i].type != MODULE_TYPE_SFF8636)
> +			continue;
> +
> +		do {
> +			value = map->lower_memory[module_aw_chan_flags[i].offset] &
> +				module_aw_chan_flags[i].adver_value;
> +			printf("\t%-41s (Chan %d) : %s\n",
> +			       module_aw_chan_flags[i].fmt_str, j,
> +			       ONOFF(value));
> +			j++;
> +			i++;
> +		}
> +		while (module_aw_chan_flags[i].fmt_str &&
> +		       strcmp(module_aw_chan_flags[i].fmt_str,
> +			      module_aw_chan_flags[i-1].fmt_str) == 0);

Why do we need this complex logic of comparing strings and moving
iterators forth and back? We do have SFF8636_MAX_CHANNEL_NUM in other
functions, and we know that module_aw_chan_flags has items for all
channels, we can simplify the loop here by providing channel number
as ((i % SFF8636_MAX_CHANNEL_NUM) + 1). That will make the code much
easier to read.

This comment actually applies to the previous patch, as current one
simply moves it to a dedicated function. But I think patch 4 and
patch 5 can be merged in one.


> +		i--;
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
> @@ -687,60 +768,13 @@ static void sff8636_show_dom(const struct sff8636_memory_map *map)
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
> -			int j = 1;
> -
> -			if (module_aw_chan_flags[i].type != MODULE_TYPE_SFF8636)
> -				continue;
> -
> -			do {
> -				value = map->lower_memory[module_aw_chan_flags[i].offset] &
> -					module_aw_chan_flags[i].adver_value;
> -				printf("\t%-41s (Chan %d) : %s\n",
> -				       module_aw_chan_flags[i].fmt_str, j,
> -				       value ? "On" : "Off");
> -				j++;
> -				i++;
> -			}
> -			while (module_aw_chan_flags[i].fmt_str &&
> -			       strcmp(module_aw_chan_flags[i].fmt_str,
> -				      module_aw_chan_flags[i-1].fmt_str) == 0);
> -			i--;
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


