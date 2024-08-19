Return-Path: <netdev+bounces-119856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86008957405
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 20:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F2D1F213FE
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 18:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE3A187555;
	Mon, 19 Aug 2024 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwkBK94l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35192136663;
	Mon, 19 Aug 2024 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724093716; cv=none; b=OS3BmLKfYBS4k699aV4qq3NHwWMriCzwH/5UvYQWb013UvYgDHwrrtxmi1C/h+wtfGRJLYecgpZS3lVANk0Zh8kAmp5KhhTheOK3aiLqR4h2nwIOIYXxFanUp9soO3AaazDAuUEb3dfE7aSVhFmHazIUvXv0AJ5sA9sB960nWIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724093716; c=relaxed/simple;
	bh=tDvdXinVnDI9BvvfcT0IFNgj77H0Y8GFQ17csRxcFpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7xz2mdOr63jBHvmoAT8HpRG9j1Fp/JMHby9qcDr5Gh7NfiPVAbGLfIMUoS92FFaD5pknghv9CgpywiYv21fP2LWn1+yfiFUIO/ymp0ttOX0SRVuaDFKbd5j2FfogaU5ebZm/+QJgVTcHMvikyq7t/wjdlfpdbxJS2agmhqJRLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwkBK94l; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1d5f6c56fso319987385a.0;
        Mon, 19 Aug 2024 11:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724093714; x=1724698514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Og/TmCjNlWt2OFidxbN/4s+thu87b3BvJlit93QJzmo=;
        b=IwkBK94ly2K1vfCxrJ9HhTQitOQeiBYLNT3p3mT0EcSgxKPQ+ftI+0PcRl4S0YB/+h
         6BnLDiDaIc/EM1v2qH9fQhVEGOSc2h0UTo2yDAkaKDP4Pwrl7pDeah7nc4KQEaTXlecq
         0AnOFqF6tU8UUSJI9qzs244iQDJ8O3Gzv1BIibOldGvS1ZFVZTkwIOUyKqiNyKU419Yn
         IBGamjaiUOmiOnY6kN0afVRmAC8B+uvK6MqU/tv2KQokx0hPGCTdoAuwyxvAGov02ULs
         XI9DmzLrULCgttYVKp6kaXRC4wxyPj8lR0i+ZwK1k5CcgzpGajV0L/hhpW3KwkQd2rsq
         yIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724093714; x=1724698514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Og/TmCjNlWt2OFidxbN/4s+thu87b3BvJlit93QJzmo=;
        b=CExjK0jXRgUg+QmK7eLApaBkZjuAMRJBlpqfk+I7n8+V/C2PEkLz3t8f11IaQIf/YH
         aWSH4UiNmFGdwT4+R+BJze1Qo67sB/rH6J/GMvQHgqMe4bv2crsQ1DISMkz/zC9WV8Ey
         v16gMobRZ3YE8Rmp94as/QlpGqwmOyw9Az9coS4v2pTRXOO4Qaj4EqPHyzJV63A1/lvc
         14/sGSJxsKmimnjf7kfEk5FL3nLNTutAcRnYIHsD9LCZU/pxts4xwpud3y5gKCA0l9Hv
         WiWw0acuwFCcc7NZQMQWG8OVtBv8K1IEJ5VWgISBRNYEX4UBm1cRx2QpeZfQ469wNu2L
         1Hgg==
X-Forwarded-Encrypted: i=1; AJvYcCW1FH78rpftrKEIvsP5tu18Jj6rqZfct/3riJrEY2YzD0TGQNBMLJpQZTonUfMMjstlZy/6l0WklS+MBP6u3uszuPhcsfbvReslgF1li/sEjs8J4WNdE4TeOX0VjzdZ5NkCaNSG
X-Gm-Message-State: AOJu0Yz6tm7S6QMkWdwAhvW51b8vhqsK+o18sbO2wsnZ3xzKsB15dyfR
	gFC9GOnLYxkbx32nMyjNDsnUU4e0WN0XVs3w8ypDDoh5InaPsTdvtrN/6X8M5K0=
X-Google-Smtp-Source: AGHT+IE7vm64p5ml9Xq5ZxnkB27+3YMqZb7I/waSe/Trr9qbBNL+uIH7tDbYIsVX/FRg6ItXLrJqzg==
X-Received: by 2002:a05:620a:1903:b0:79f:1098:a949 with SMTP id af79cd13be357-7a506906861mr1521686985a.4.1724093713761;
        Mon, 19 Aug 2024 11:55:13 -0700 (PDT)
Received: from localhost (24-50-101-229.resi.cgocable.ca. [24.50.101.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff106232sm458067385a.108.2024.08.19.11.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 11:55:13 -0700 (PDT)
Date: Mon, 19 Aug 2024 14:55:12 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: David Thompson <davthompson@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andriy.shevchenko@linux.intel.com,
	u.kleine-koenig@pengutronix.de, asmaa@nvidia.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] mlxbf_gige: disable port during stop()
Message-ID: <ZsOVEMvzAXfaRiEY@f4>
References: <20240816204808.30359-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816204808.30359-1-davthompson@nvidia.com>

On 2024-08-16 16:48 -0400, David Thompson wrote:
> The mlxbf_gige_open() routine initializes and enables the
> Gigabit Ethernet port from a hardware point of view. The
> mlxbf_gige_stop() routine must disable the port hardware
> to fully quiesce it.
> 
> Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
> Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
> index 385a56ac7348..12942a50e1bb 100644
> --- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
> +++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
> @@ -205,8 +205,14 @@ static int mlxbf_gige_open(struct net_device *netdev)
>  static int mlxbf_gige_stop(struct net_device *netdev)
>  {
>  	struct mlxbf_gige *priv = netdev_priv(netdev);
> +	u64 control;
> +
> +	control = readq(priv->base + MLXBF_GIGE_CONTROL);
> +	control &= ~MLXBF_GIGE_CONTROL_PORT_EN;
> +	writeq(control, priv->base + MLXBF_GIGE_CONTROL);
>  
>  	writeq(0, priv->base + MLXBF_GIGE_INT_EN);
> +	mb();

checkpatch says:
WARNING: memory barrier without comment
#37: FILE: drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c:215:
+       mb();

Is this memory barrier paired with another one?

