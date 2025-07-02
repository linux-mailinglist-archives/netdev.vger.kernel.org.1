Return-Path: <netdev+bounces-203287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B46AAF1226
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 12:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C15E87AA111
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 10:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78992571B9;
	Wed,  2 Jul 2025 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PZIKXDfH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E7F255F26
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751452913; cv=none; b=j5+xDmXlmEXm43+R+FddLOoidQmHDkp2pEr9hcOGPjKtcKtG7a3kDPbFUbpeFhcgSxQ1/7YoPAA7THpl5dG8s7CbDsvpn1qDlq7FxtMFiwnXkxCz+i+CCxXSu/XGp/ENadXjcM/uh70iJ2z5Tax7IvcPXuh2IuwyTT3cveSxrSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751452913; c=relaxed/simple;
	bh=opI8kZ94jXxc3W+bhK8KIvd92l7nPa8l691dPsRb30U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iihmRsqKYE+8ZZsyDdVFNlq/7k1WvPOSvDKrENZTfe0ceo6J3qC4ntus/M1UIrfpzWaU204ao/66IkyY/ylWcIHWSTh5P+YnODlS07Fbse2eXOnv0T4hIL1Z6MXDtqD5VIH2dA5k0v2iEVzn1keR+tOpr+E6ou95Wg8c9ax0UY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PZIKXDfH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4530921461aso44080445e9.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 03:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1751452910; x=1752057710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vKybssvnFprModTIZAiiqhMc9ohtbZTXrEhnTtnvSDI=;
        b=PZIKXDfHzzrMWMb8wWmm9ujwZ6GGJl5NC9cuOftFYEVlr1vNngMTVjw3ej7F+Fk8dx
         TjCGtHInRC2muFv9YuywxxvhjzO5GLv0h/yc7mA3gOUO93vT7ZtyKvIoBPF2jYQaX4JN
         9n78uqtXP2gQAVaYlX8v9GOjbHH3AzUdyj14Ad+O1YKEbPRX9cX4kb9TGCCuIeQ0OL/5
         XY/lOhBhTNf8kPWTL5HdXMu/YWyazpAcnqTQGZkvBT1E0WqJOIN/xOI95VpOgiWM8DFm
         KguCe0C02dOXPoxsweSjAqvybOeiFUeHtqp8yfnV6TLSQYERoUWSpiq5TVq3pOs+dtM/
         qZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751452910; x=1752057710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKybssvnFprModTIZAiiqhMc9ohtbZTXrEhnTtnvSDI=;
        b=TYWKldze0BYoAqpqyIAgk9oGAridsf7lur5v0Y6Wggrl9EJuk4A6Ig7a3IdIOF22TB
         KDBvcsXlWPgere7YCX6DgDl1Rml0R9zXjtDU09ijYFEC1CHceV83Flk4QtwZsLFbm1vN
         atZJQZ5bexiFJNWz8H2YBvhVsSTEOcOfs1f1BxcKCoXb0IlmfcHmrCh7MH2UkGmezfjE
         l/CbT5wwHS7qnI410jP5pdrAAJ9qCbQZjbb/C4MVPUNLAqmH+z8Pj7qH4GcZyo7P2cBR
         Rjf/GpqRAhR0Q8UCRiHhj5/QtlI7ez2fJmMi5FZb2VjVx79LTYG+y0z9cgpmj3umhatG
         ounQ==
X-Gm-Message-State: AOJu0YzZF1XrzyVu+ATy0cZqIayplQlGCArY2wKshN31BAqDnWn87KW5
	1BtEdlaDsZPioIowENpB4dyZ3NaK1Y81N99hQzs8gYHNqb6+sGYN3te0O+shcx4Pooc=
X-Gm-Gg: ASbGncs4hKcOjv/VB7SNFn550HY1vAMP55LXdso0qNRSIgX0WJUieFeZvGwJ5Aq/dh9
	qnFGK+A2hU0GATSI3fg44PYGMsdsqCTUE1JwMnRgUfZw61tejgdWTSRbLDJ8L797uzQbjROdEMl
	c/zVZxC7R7c4EDjIm/N2mNkb24KZwiVFtoieJSd+GTlXqo+B4+o5iP7V/U2Ol9ESpQOyqhh3ncE
	0W8QmdttsV7LxCa1G2805mvp3zGYaOrEX3bNbpjCziixeSDFhjh8VE4LgCULBcHesWeaXNd8KYH
	uuUqPaGOQqFcWZofiyynBVYH644xEV0nplzlTrRXZaaecZb8WBEAZYwKQCpn1pq23wj0sA==
X-Google-Smtp-Source: AGHT+IHp+NonL/psql4ZWWlHXVavL55jVvlBbLDx9BjCEnFRZEGhViNaWfW5qLGhu87010kP2/wTbw==
X-Received: by 2002:a05:600c:538e:b0:453:697:6f08 with SMTP id 5b1f17b1804b1-454a3728b85mr23020135e9.26.1751452910342;
        Wed, 02 Jul 2025 03:41:50 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453a85b3d44sm33167695e9.0.2025.07.02.03.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:41:49 -0700 (PDT)
Date: Wed, 2 Jul 2025 12:41:40 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shannon Nelson <shannon.nelson@amd.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>, 
	Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v12 08/14] dpll: zl3073x: Read DPLL types and
 pin properties from system firmware
Message-ID: <vpzjeh5kc6s4cpah5wagdy6sm3rzt6vlfyfcdbenppwnzftzow@u4xu7mhzg77u>
References: <20250629191049.64398-1-ivecera@redhat.com>
 <20250629191049.64398-9-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629191049.64398-9-ivecera@redhat.com>

Sun, Jun 29, 2025 at 09:10:43PM +0200, ivecera@redhat.com wrote:

[...]


>+/**
>+ * zl3073x_prop_dpll_type_get - get DPLL channel type
>+ * @zldev: pointer to zl3073x device
>+ * @index: DPLL channel index
>+ *
>+ * Return: DPLL type for given DPLL channel
>+ */
>+enum dpll_type
>+zl3073x_prop_dpll_type_get(struct zl3073x_dev *zldev, u8 index)
>+{
>+	const char *types[ZL3073X_MAX_CHANNELS];
>+	int count;
>+
>+	/* Read dpll types property from firmware */
>+	count = device_property_read_string_array(zldev->dev, "dpll-types",
>+						  types, ARRAY_SIZE(types));
>+
>+	/* Return default if property or entry for given channel is missing */
>+	if (index >= count)
>+		return DPLL_TYPE_PPS;

Not sure how this embedded stuff works, but isn't better to just bail
out in case this is not present/unknown_value? Why assuming PPS is
correct?


>+
>+	if (!strcmp(types[index], "pps"))
>+		return DPLL_TYPE_PPS;
>+	else if (!strcmp(types[index], "eec"))
>+		return DPLL_TYPE_EEC;
>+
>+	dev_info(zldev->dev, "Unknown DPLL type '%s', using default\n",
>+		 types[index]);
>+
>+	return DPLL_TYPE_PPS; /* Default */
>+}

[...]

