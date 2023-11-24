Return-Path: <netdev+bounces-50930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 518897F78AF
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 17:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074DF2810C0
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F7B33CE1;
	Fri, 24 Nov 2023 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huFi1LIG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D51119AB;
	Fri, 24 Nov 2023 08:11:49 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a03a900956dso398610166b.1;
        Fri, 24 Nov 2023 08:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700842308; x=1701447108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I35NveYhkoZ28DMqDop9zJmkqxtTHkbKlKYsYxwRQuE=;
        b=huFi1LIGb+FA19Pp5QUqdux4rLG4jOmab9aAEmc2lFcqUWvO0jo7QIjgj0ptLgbM5E
         +AMxlu0YqhxoJuuv4Ma1j/xglUIRfR2aVnbw+pKvjwrNjTR8u5IfIBz9IUlHH8q0dFgG
         2khzNu4MwiAitKWPIVkyrVG1TRqno4Sd7kEj7YfWNp3CxeCz3zNFqSSEtEjjpKPp+x8N
         5Fd+Tk+xs5oTvlFcCdb5fSjOKEzM31Y1enALCfy84tocIcO8NRqF7Ccoths/+Dc+VuFC
         9nBxzwxu/hKabMRZKycsdB4mzl50EkegasLM7PdA8+m/id3h5FiMjeXzwWW8+omX42eM
         CgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700842308; x=1701447108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I35NveYhkoZ28DMqDop9zJmkqxtTHkbKlKYsYxwRQuE=;
        b=O9vVlHjaA2n00va5feBvhGRCsjFLguDiUwvoCIrBMN9KwLwcZ7oNKx/y1VFV62+sHg
         IyxcznYE8zjo9Xx66VAkVHm/H3q7bFSEgEkfG6wisrHWzzrtNeHHUEL0uuKv7I9sn5Qi
         8iiLmwHuSMHC0+4k8Xlkhfj0YlG+UnlmFPGJagxbUWDdVuMzOaRJX8H9nkvn9vm0LTPB
         3nBehCb9+wu5MXRGsDML8xfeGBFjVWSOCAg6Etl5yTxuKvhm6BP6V1ECl1PaclaBF/37
         40UDiYZ5Qpy0if6DPKPl0Cemf/PQ2NJxw5K3FaM1MELeejYteNHfz0KYX6U9lhTqvraq
         Wh2A==
X-Gm-Message-State: AOJu0Yxdnkjoa3srSy3MIC9O5qWOCn1csxgwFWoVCZDDoSoAqiFbnx+w
	5mcAqVgDs9b3cLarXv/HOmM=
X-Google-Smtp-Source: AGHT+IGtJ3UGtPKqhJP4J6tZy5FGZu9hyca3DpcSgvFJPVdTvOhpNj9dj0Jf+zI1m+YQ7QJao754aw==
X-Received: by 2002:a17:906:7494:b0:a01:d701:2f1d with SMTP id e20-20020a170906749400b00a01d7012f1dmr3109574ejl.14.1700842307727;
        Fri, 24 Nov 2023 08:11:47 -0800 (PST)
Received: from skbuf ([188.26.185.12])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906119400b009fbdacf9363sm2211170eja.21.2023.11.24.08.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 08:11:47 -0800 (PST)
Date: Fri, 24 Nov 2023 18:11:45 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	marex@denx.de, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/2] net: dsa: microchip: add property to
 select internal RMII reference clock
Message-ID: <20231124161145.q4zww6m5hi3ccqzk@skbuf>
References: <cover.1700841353.git.ante.knezic@helmholz.de>
 <4e62cff653c7845bb848de5af44abe7e5578f624.1700841353.git.ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e62cff653c7845bb848de5af44abe7e5578f624.1700841353.git.ante.knezic@helmholz.de>

On Fri, Nov 24, 2023 at 05:01:48PM +0100, Ante Knezic wrote:
> +static int ksz88x3_config_rmii_clk(struct ksz_device *dev, int cpu_port)
> +{
> +	struct device_node *ports, *port, *cpu_node;
> +	bool rmii_clk_internal;
> +
> +	if (!ksz_is_ksz88x3(dev))
> +		return 0;
> +
> +	cpu_node = NULL;
> +
> +	ports = of_get_child_by_name(dev->dev->of_node, "ports");
> +	if (!ports)
> +		ports = of_get_child_by_name(dev->dev->of_node,
> +					     "ethernet-ports");
> +	if (!ports)
> +		return -ENODEV;
> +
> +	for_each_available_child_of_node(ports, port) {
> +		u32 index;
> +
> +		if (of_property_read_u32(port, "reg", &index) < 0)
> +			return -ENODEV;
> +
> +		if (index == cpu_port) {
> +			cpu_node = port;
> +			break;
> +		}
> +	}
> +
> +	if (!cpu_node)
> +		return -ENODEV;

Too much code. Assuming you have struct dsa_port *cpu_dp, you can access
cpu_dp->dn instead of re-parsing the device tree.

> +
> +	rmii_clk_internal = of_property_read_bool(cpu_node,
> +						  "microchip,rmii-clk-internal");
> +
> +	ksz_cfg(dev, KSZ88X3_REG_FVID_AND_HOST_MODE,
> +		KSZ88X3_PORT3_RMII_CLK_INTERNAL, rmii_clk_internal);
> +
> +	return 0;
> +}

Please wait for 24 hours before reposting, maybe you get more feedback.

