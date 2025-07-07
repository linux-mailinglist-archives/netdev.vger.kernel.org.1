Return-Path: <netdev+bounces-204501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFADFAFAEAC
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74CB1AA01E1
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 08:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F4028AAEE;
	Mon,  7 Jul 2025 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PO6ViXcm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BEB27702E
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751877126; cv=none; b=M4+93YLeuWYFO50dCVuHXDTlIrf+hX6TF36/Gdb4z++OSeUueZ8pxltOH1dMuWSZ1Tawqom4CWMqR/bZLSU8iAwJmL42ejzkX0Dw9SJlJdZES2LW2knVOBqxQVrtKCBMKqXeHr/BVkdvpmDJEv72u01UjhcVH9HXHYTSZibOVyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751877126; c=relaxed/simple;
	bh=EokrUka+8q9BFBcMOPMx0zXPzrf3e9HtqUOEMOxQYtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alIST9ymfkxGyJhKhazLyFrDAi93Wwr7iGEWXrODJ/Fw4cbbaRRoBaQfPipcdnYrVBxLhXqAIYk+/dHqRpfvEvUOaMHKN8UomcDAOmw1JopsJnUN+vn06j/Evsf9OYpZAzHrTK3EnThwOx9QuFbHW0o9ahpWJrlizFKVhPcGaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PO6ViXcm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso21343845e9.2
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 01:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1751877123; x=1752481923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jk0DSP+snP0yxTTILdaG1XmNWZzWY5PtYg8JXeBa+lA=;
        b=PO6ViXcmYP6ZlnXVKyLR/Oh6oKcVwhg9FBYCZvZZUr+FtiLlsUSY/Dz5S2Jls4Fzu4
         uvUsi2yT2DnVXrpFjlWbSGT3LHGL6TvV1AWqpNZiphD6QQapD0V5xwyE8BdotU4rW+Al
         d8fqljugqv1xT66OULBbTFDdyDwMtbgngaZIY45bGo8fhMQQXd9g9Wkl1BZc7AcZvBVB
         FUgwmzA6otoIaBwFwj7lSFuHR4zwFG96aPL+VzG51ifR9E99LXpIHxEV/4r1ConSQCP1
         Em/SOcXVh6mZPxgbUDm6MYZERJqp0W5FEb5vDuEAgQRVlAf9qryCq5mA3BAg1Xq4XyXu
         EhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751877123; x=1752481923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jk0DSP+snP0yxTTILdaG1XmNWZzWY5PtYg8JXeBa+lA=;
        b=gjeAgNANyuSErmREo1P6LCJoBrlmyp6ZDBD9WpCwwz/A+2B9M1QfjvE/BZnCYQApnG
         BSseJC9GQ+ZpVDsuMbH5MFmHQt1l2lZ35SdOLylWr6DrxpGAckJqp02KY4ibLn8ylsOI
         BBTGF08NOFERaTIRvYR8NcSq+sm/ovyxSpSMo53d2+b1KG65ZIz59vHFvoHY2zMaVAjA
         7i1wg2w/sD5sWamaEomMt5ClUlWiVQFaOl0ZRWpPhCNr801kQ8Hl11y2u/a48OKuGWaG
         NgEwFzi0qe8r84zSh65FKjX6sbvjvGbcAhKKOvvV1QrV/ItnbuJOH+EMWHdtsUI9CzRl
         4HmQ==
X-Gm-Message-State: AOJu0YwP9l9+i/0FTkM6KWGh9yF4FLkLxrb5p2hIY5xZzo17sZ2XeE9E
	luC8awWDjGfY2cCAinaOILlMMijneTacdJPR9yROQMwXQ8N8iZeeHIhsq9O7vD48WYGNlzWTDGK
	IWiWV3mY=
X-Gm-Gg: ASbGncvg1Pkc6J+j4kaoWu+x5/Y+OSI541PFU/TcGwWNI+J3ZqDykPgpwJ0/BgVjt6o
	Nt9ls1b9n/k5EbUkdxuMB8cK77tM/Uo1JAn5ggix1WGsLaq/t9DOYAJWWcvSulFaCRO+RhR/oOL
	1nuiGkBLtlpYtLE8JrxRd6W4KyWXRe7WAK5gdFwlpn1gPZUUwmT2kJQD49tWzCkEx/oMwYg2Vu3
	Aef8iLzeS/aVlhhoePaZ2j3LxZUyMRupZ91Q4+bmucoaAMyyxC4mu2t6LqimR2u8Zd3xtIKPGE0
	lt8JZTOs/Oj8BBAHsb59AyatqfX+9KmqfFgb32xEYPVoAAiZM7rStcDnL2p90GY=
X-Google-Smtp-Source: AGHT+IHColHEC/SleUA2FaGBvscXm99Qomr8ucT1fEnsASZPSUvkTO+j3OPSIwgqWNk5VgdiiF29Ag==
X-Received: by 2002:a05:600c:3b1a:b0:43c:fffc:7886 with SMTP id 5b1f17b1804b1-454bf4092c3mr47838765e9.8.1751877123334;
        Mon, 07 Jul 2025 01:32:03 -0700 (PDT)
Received: from jiri-mlt ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454abea60d5sm94590505e9.1.2025.07.07.01.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 01:32:02 -0700 (PDT)
Date: Mon, 7 Jul 2025 10:32:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shannon Nelson <shannon.nelson@amd.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>, 
	Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v13 12/12] dpll: zl3073x: Add support to get/set
 frequency on pins
Message-ID: <idzmiaubwlnkzds2jbminyr46vuqo37nz5twj7f2yytn4aqoff@r34cm3qpd5mj>
References: <20250704182202.1641943-1-ivecera@redhat.com>
 <20250704182202.1641943-13-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704182202.1641943-13-ivecera@redhat.com>

Fri, Jul 04, 2025 at 08:22:02PM +0200, ivecera@redhat.com wrote:

[...]

>+static int
>+zl3073x_dpll_input_pin_frequency_set(const struct dpll_pin *dpll_pin,
>+				     void *pin_priv,
>+				     const struct dpll_device *dpll,
>+				     void *dpll_priv, u64 frequency,
>+				     struct netlink_ext_ack *extack)

Unrelated to this patch, but ny idea why we don't implement
"FREQUENCY_CAN_CHANGE" capability. I think we are missing it.


