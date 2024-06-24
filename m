Return-Path: <netdev+bounces-106134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBF5914EB4
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651261F2191F
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68610142E9C;
	Mon, 24 Jun 2024 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km7hfaiS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C41422D4
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235897; cv=none; b=jPd+wLHIBzqgi6c7jXTUWksbk6K4lMpzV/jiwPcjq5pqMobGNH3wkt3D4x5ggq1an9+S1f4Xl3+WSV4g7UFUv2i4OAtE1nz+1N1VDN1I3dslO0tVB0lwhmpZf01+p+SCYNasV/8O7XHjjwsuQm1ocjYY5KS6YoGsfugWsGPhIUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235897; c=relaxed/simple;
	bh=Sxq6WZpgYLxbSFP2CMwaXYml6A/6Cx5PVY6qmWPGnaQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HC6VW/LP66ru6h8HqiBPqCH9SiCHrGL9WitNyOUB0p54UhcrMzVUgdt/VGoIHwyMXevKORQcioZ5VCJGRNHxuqyK69xTTLua9eVxpxs6lYL1rlh8QqV2LjG1Bzmbqdq/PkBtMNAyM3Q81fSEy5ZbM7/zuDx30HN1RaDjVzLbeM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=km7hfaiS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-421d32fda86so47722355e9.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 06:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719235894; x=1719840694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+L2pf9SPWDmXWf9+5/GFfIZujr5iq8xhCkgdQNCJtBI=;
        b=km7hfaiSCGVROr7oHwBBkQaQ/g9Nf1HMQjJBb1SKWg/E8mchMvSmFV6NSpbGTiHRAt
         VLPBSFee71TtQHZe5GDUVgHg/Q1dzjCnCHm8X1XwAoZehI9WuuVvupOMsEtqN4ILgQss
         vwMYYAjowrEV0UwsYRWQSetlM9hD/UpBYm8RneNzfyb43etTtYv7aUzlw6CoSkXkPUKP
         qME704hyJAky0hqAIapeoV/zLgYI4049/F4+wbALk5fcCON5gOj5V6XbBObimOwqHoLS
         ldK5L9daJpIp0+nhXgOIpF5ZfAEUT6vwJhmfac7P5Y42yhoLJJ4RPBlwVGVTyN/+DpFY
         GLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719235894; x=1719840694;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+L2pf9SPWDmXWf9+5/GFfIZujr5iq8xhCkgdQNCJtBI=;
        b=WCoA+Fe/fLRhGdQg5rM5F4daD1/H+R/4FCmXbALSUqZG9giBu7Mxo4JJplxfV6F2EL
         TDVYiuce9GDvEmKKJH58UhSfO6k608T3RksWAzpyK4cDxIC7ZSUaRCzPSyXKt8zsKMhF
         3Q978VFlR8cCFM1unQILqeUyaU3QOPRHiyMa/WEVqHe9ACR4LAk3OGOUAcjFBJn2GVGz
         ctBMnL2a0y+bF5Y92B8d+DneZc2oOAuPSJ6WLRDuqia/by6GFv4CnhbH4AzykABXk/KH
         DFGJyc1YOtqgOoagjERJkcQXavXvwbiSU1e+8wmSp82+f0oWOLS2DuTvCbJSYyjDoeDJ
         kaoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoGVLedTYOc0zSTYc0JUircCflCAg52piM8CWz4TcIVOqsAsW7clGha8Vs6fNOZGgYxT6NRLyc8yjzDHvEvx1bbxHRE24r
X-Gm-Message-State: AOJu0YxkLe1vSrFYZT/AT0VxVSWwVzzZZdOJ4RqIh54Y9+EzBBgs3jrj
	vsTBE0NPLpczC4DG16GSI9LVZnCzfTA12wLf4dZzNp8i+E4rUi5d
X-Google-Smtp-Source: AGHT+IEcfPBdIlcHlp9NJjsBQ1CPB5QTlYYShrXPk6FgvsPAIrMSNQ4OrhEdcBFeJTR5cc2yIz5U7g==
X-Received: by 2002:a05:600c:1c02:b0:424:8e13:52a6 with SMTP id 5b1f17b1804b1-4248e13536cmr32887585e9.1.1719235893722;
        Mon, 24 Jun 2024 06:31:33 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42481910dcesm140487265e9.35.2024.06.24.06.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 06:31:33 -0700 (PDT)
Subject: Re: [PATCH v6 net-next 8/9] net: ethtool: use the tracking array for
 get_rxfh on custom RSS contexts
To: Simon Horman <horms@kernel.org>, edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com, sudheer.mogilappagari@intel.com,
 jdamato@fastly.com, mw@semihalf.com, linux@armlinux.org.uk,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, saeedm@nvidia.com, leon@kernel.org,
 jacob.e.keller@intel.com, andrew@lunn.ch, ahmed.zaki@intel.com
References: <cover.1718862049.git.ecree.xilinx@gmail.com>
 <2f024e0b6d32880ff443c4e880af16ec2b5e456a.1718862050.git.ecree.xilinx@gmail.com>
 <20240620194214.GT959333@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <283253f4-929b-f1b0-e0d4-9d89a341e57e@gmail.com>
Date: Mon, 24 Jun 2024 14:31:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240620194214.GT959333@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 20/06/2024 20:42, Simon Horman wrote:
> On Thu, Jun 20, 2024 at 06:47:11AM +0100, edward.cree@amd.com wrote:
>> From: Edward Cree <ecree.xilinx@gmail.com>
>>
>> On 'ethtool -x' with rss_context != 0, instead of calling the driver to
>>  read the RSS settings for the context, just get the settings from the
>>  rss_ctx xarray, and return them to the user with no driver involvement.
>>
>> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
>> ---
>>  net/ethtool/ioctl.c | 25 ++++++++++++++++++++-----
>>  1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
>> index 9d2d677770db..ac562ee3662e 100644
>> --- a/net/ethtool/ioctl.c
>> +++ b/net/ethtool/ioctl.c
>> @@ -1199,6 +1199,7 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
>>  	const struct ethtool_ops *ops = dev->ethtool_ops;
>>  	struct ethtool_rxfh_param rxfh_dev = {};
>>  	u32 user_indir_size, user_key_size;
>> +	struct ethtool_rxfh_context *ctx;
>>  	struct ethtool_rxfh rxfh;
>>  	u32 indir_bytes;
>>  	u8 *rss_config;
>> @@ -1246,11 +1247,25 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
>>  	if (user_key_size)
>>  		rxfh_dev.key = rss_config + indir_bytes;
>>  
>> -	rxfh_dev.rss_context = rxfh.rss_context;
>> -
>> -	ret = dev->ethtool_ops->get_rxfh(dev, &rxfh_dev);
>> -	if (ret)
>> -		goto out;
>> +	if (rxfh.rss_context) {
>> +		ctx = xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context);
>> +		if (!ctx) {
>> +			ret = -ENOENT;
>> +			goto out;
>> +		}
>> +		if (rxfh_dev.indir)
>> +			memcpy(rxfh_dev.indir, ethtool_rxfh_context_indir(ctx),
>> +			       indir_bytes);
>> +		if (rxfh_dev.key)
>> +			memcpy(rxfh_dev.key, ethtool_rxfh_context_key(ctx),
>> +			       user_key_size);
>> +		rxfh_dev.hfunc = ctx->hfunc;
>> +		rxfh_dev.input_xfrm = ctx->input_xfrm;
> 
> Hi Edward,
> 
> The last line of this function is:
> 
> 	return ret;
> 
> With this patch applied, Smatch complains that ret may be used there
> when unintialised.
> 
> I think that occurs when the code reaches the line where this
> commentary has been placed in this email.

You (and Smatch) are quite right.  Fixed for v7.
-ed

> 
>> +	} else {
>> +		ret = dev->ethtool_ops->get_rxfh(dev, &rxfh_dev);
>> +		if (ret)
>> +			goto out;
>> +	}
>>  
>>  	if (copy_to_user(useraddr + offsetof(struct ethtool_rxfh, hfunc),
>>  			 &rxfh_dev.hfunc, sizeof(rxfh.hfunc))) {
>>


