Return-Path: <netdev+bounces-203311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2FEAF1441
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB258441ABE
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E186026CE12;
	Wed,  2 Jul 2025 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XyU9H6Zw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1043C26AABE
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456500; cv=none; b=rO1u2MVceFh7bzk/2Sm9PVOSTvtwg9/zuzw/WBHM5iUjXDysbQSGdiFe0Cz/7fc03MxSgYNgXHfPs/RTactgFoYeg4EexsM2+ZeMeM+/I/+cPsCz15X06OMxnlYKRGPOt6vUO0B+BsZlVzaesq6xJDVaZH+W9siwNZbBl8IU0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456500; c=relaxed/simple;
	bh=pLB/CoHkptOL4qWVMaQUjQV5ZTKskQstiuecHdpzjpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTTPGP8z08X0o0R0iW3s40KA7k8WcGav38pGsOIdfP0FawQyIJBSRt4WFbz1GKa3PZWkQ8MllP0/yQFWZG26NhlB3FNYQivVCl+3fEwhanBlJZE1gYCb65+Il5Em6HSopAlsUdibFTI2eQVSMmNcz31aWObkB3yU/K6/PeyS6/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XyU9H6Zw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso45236095e9.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 04:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1751456497; x=1752061297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GzZXJPE+pCDN2n4VgGUurGvnQ9PWiAa/jKqR630GwDM=;
        b=XyU9H6Zw1aG5keWErGbyoFWjRVrTo1hqfUrKHZIfidYmKS87DC/6k0IQg6Ams0l/3t
         6q1+jj51LVxjYD70W5IIlKhH42dzVrdRKagRPDVd7ijGd2ibCwXjlvsl0E4zQxwBumHO
         /ywWF+HffUZrTNOwY93qpX5yZUllgCNU/EwNpxWcmLU9jzXJrpl/vXht0V+O5+8nX3J9
         pP67r8wFXKu9U6d1T32qJZEQl+ag2NyahJpnwiPKmUVCWzD3byVoiX6AuzlOOI6ydxIZ
         X/5Cd8V2c3tZDUldojEldYkQHLzdHuRGPWEP0FzuWC9dzwblexrH/GyDjcTUJhNmTx2H
         EOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751456497; x=1752061297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzZXJPE+pCDN2n4VgGUurGvnQ9PWiAa/jKqR630GwDM=;
        b=bTgk+itGEWUQ2GqDc1NBjKCdgtrl4x1L+tIv76/PYNiyIwHDfbH62zt9ZMOfQ6pscN
         XYaWzJ7UkQKglZgeTR9z0CXqc9HLWHFoFmc2nMyWz2XR6Hr1O92Klqq/4RwSHCAd+H6a
         C+At4lizJBFxTDx8EMDsXcxDd22Cj1ERE6rc4LX8mRBffuC16JgdWZ95cA0Op/UQ6yN8
         zihVsdPnkmSK3iKJZnY1voHmeBN1rmQj/dxWOQYgrYN5b0wkTa8NC4ONgtYyS9m/9yTz
         ukVKvO5vOT7rqyQTdW9BfdQXL+nAGVgVpN7H4WcGnAA8cBVkfBIyK+3F5KJaH1SpvwoR
         YJnQ==
X-Gm-Message-State: AOJu0Yx8WtmRoe8GJydeBX4xAeVDmfvK4DavpZHf0x5Z1fFYKL56QEh6
	PMtj1A/Bh9GNn87QHiMk6vTlVqCRRcN4asrpIsIWNB/3CQEGQCj0gwaxX4JCdwj28lY=
X-Gm-Gg: ASbGncsxf4QLQDW4FA029Pp9YwIZHnz57u8wFyCyAtXOgmW9UGu4MEfbVV9hA9wzNw6
	0iYkyJ6X95O/l49JRb2MTds/bQSg/l/8DCiZrqXfnLUu6UcxT3tPGuUnrgN83VHRuaZ3Np6hEBT
	nRhnr1/lBf1vhSmUIA2ulIdqu8Op8adz3QhTFeTP/NLMo8DyQ1ZHIyH04s18mKiKFKC5mJxHSll
	AbnGb64Os7arO9CHDyD+WhWf1W2TFYQ+kxJ2iw5iJMGduqpzpXM2zt6A8cyTxw6tkQ4XI20SIqJ
	Ki4Q1dlNNwtJ3NQxpzrd6jqYpwlJPK6eAG9O7QGbHn6x+gghD9qRLlBvN+/4kC8VhQFKjS13He2
	Gku5H
X-Google-Smtp-Source: AGHT+IEPNXHtekgkaTeh2otpe/2mD8BVkUglqfnjvgS0sOGRxpc82/oHrtuGTxrVpXcyjzzBFMM9rg==
X-Received: by 2002:a05:6000:2406:b0:3a5:7944:c9b with SMTP id ffacd0b85a97d-3b1fe2dde08mr2085098f8f.16.1751456497314;
        Wed, 02 Jul 2025 04:41:37 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e59aaasm15549022f8f.83.2025.07.02.04.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:41:36 -0700 (PDT)
Date: Wed, 2 Jul 2025 13:41:26 +0200
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
Subject: Re: [PATCH net-next v12 04/14] dpll: zl3073x: Add support for
 devlink device info
Message-ID: <vhv3wdiaphtilm7w3v5iro4aojo5go5vlacwfmsycimxnljhsl@itc567adbkey>
References: <20250629191049.64398-1-ivecera@redhat.com>
 <20250629191049.64398-5-ivecera@redhat.com>
 <x23jvoo4eycl5whishhsy2qpb5qajsqcx36amltwkqwu5xuj7s@ghg47je4hbjt>
 <351c8eb7-26b2-4435-a6cf-6dac36e55ad9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <351c8eb7-26b2-4435-a6cf-6dac36e55ad9@redhat.com>

Wed, Jul 02, 2025 at 01:38:03PM +0200, ivecera@redhat.com wrote:
>On 02. 07. 25 12:25 odp., Jiri Pirko wrote:
>> Sun, Jun 29, 2025 at 09:10:39PM +0200, ivecera@redhat.com wrote:
>> 
>> [...]
>> 
>> > +	snprintf(buf, sizeof(buf), "%lu.%lu.%lu.%lu",
>> > +		 FIELD_GET(GENMASK(31, 24), cfg_ver),
>> > +		 FIELD_GET(GENMASK(23, 16), cfg_ver),
>> > +		 FIELD_GET(GENMASK(15, 8), cfg_ver),
>> > +		 FIELD_GET(GENMASK(7, 0), cfg_ver));
>> > +
>> > +	return devlink_info_version_running_put(req, "cfg.custom_ver", buf);
>> 
>> Nit:
>> 
>> It's redundant to put "ver" string into version name. Also, isn't it
>> rather "custom_config" or "custom_cfg"?
>
>As per datasheet, this is configuration custom version.

This is UAPI, we define it and we should make sure it make sense.
Datasheet is sort of irrelevant.

