Return-Path: <netdev+bounces-131341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269B798E2A2
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 20:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F41284BFF
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5B9212F0B;
	Wed,  2 Oct 2024 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAEcZths"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF0D8F5B;
	Wed,  2 Oct 2024 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894136; cv=none; b=anfeQFvbh2fBEwYI1XuV+9binZvnSOPIqVv9ei+LTlpLboOP+iBooD7fBu63tTyobQcuY/NvG4zV6S7TVzP1y1LCqfH7Z5RIWOyIsfF6Rl7ndNHI6ecRCXaybBh3exF5ig6EIcdRF7msYYrJvgOpBIc2vSpZGDnOEsdacfHRFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894136; c=relaxed/simple;
	bh=bwLKcTf0q0+cuHXLLWcsnRiUjbBp0Ybor6BgLH8u8DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIEM1Cq5CJv05zseyPSBQF4vZLNxxoerTl8aCx2vcmQMQK8tF/KHeGp0e0gG9FwQTZ7swsl7ct1cPvZenYUug6JX6t4BOMysJUAHsq2d09YiQerVkJIs5N6vhG1yGn0+Cyo7roKbW8gTmy9tXg+ew6Lbn6xpq1Gw7nO3CkO5hIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAEcZths; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37ce8458ae3so93214f8f.1;
        Wed, 02 Oct 2024 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727894133; x=1728498933; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mED0YUDg6ybFD4UVoBw4zqqhlZ7Qyev/U4YEla4InU0=;
        b=fAEcZthsug1IP/iTxrm3okZ+GRz3cuxkhjjvL/7U0s+Z2cBCVgx0u4vwYJlFndA9Sq
         M8DWZfv/W+IcEq07yCsBKC06zQ3oNcl5EMGTM4r5LzRNtRpQbXz0nw+SqSKK7R2DF0zg
         0dLod285c2+G1oU0ngLAOy+h8tIQe9dUdgQfijf4O7l1vzNj2zWyESPj5SW25v44VBV6
         x038gtMdzaTduZ/Lg1p1av3CQUErt7x1GF3mJTvtvLsNTDwHy3mjczt2dMt4ZA6KGd7x
         uvY6nEgYyLNU0oM3fsXco8kF/P/n2MWAfw4IYGZjVan7YMBZD6dpeLgF8vinDwcIImps
         WVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727894133; x=1728498933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mED0YUDg6ybFD4UVoBw4zqqhlZ7Qyev/U4YEla4InU0=;
        b=NQNnp+r2ih4+pHL4qQHlU3lz8wm9y1OLR3RAac9z1CNQt/rL6Keemaa3XsgfBCmaOz
         YwYHaoi3xYa2FW9Zxwe+kRivK93qpTriqrNGvbyHvWZlnBHUFX43JzUqV1cR5rM2OlCr
         cRR8CQucXhrI+3NTSbGaI41cfM7JkP+9LurM4riUX27fV8kQTTksCxnddZpMSDU56OOc
         B3642ReLphrCdejtvYR3I/HisLNDd7rTohNZumqiWhcV4Gdl+UqzUH96jn4drayJPdSA
         25ywKiQgDDwS+YjiHkd512GsyepoqSixMwvFVquFbNAqhL+SwcKX8UEuXN4SAOcv7/fg
         3Azw==
X-Forwarded-Encrypted: i=1; AJvYcCXneeDcj/UtBU3RYViXwcZEnfyttU05PJC2oa7r84Op5EyI9D9aTOyH+NAWknpwgAXwtbzlGq9CXk0UW6I=@vger.kernel.org, AJvYcCXwnIWQdh+RGRLAdDZqjlafv+G3QWuzdqP75BTqWx6UdamsmY3CcSu7N7KD31DgcP9D2IMiXhNN@vger.kernel.org
X-Gm-Message-State: AOJu0YzOAyw9CDqfXAZ+f3PynITqyH77J8iFTyt09rybsLawym5oBHnx
	bJ24sve1jsPAN0BbolLFLjEDn44h8cBTdLCcfmZ/iJJVMG1J/38F
X-Google-Smtp-Source: AGHT+IHIuA+cnJos2nrvsIxzTDux8f98ipwTTinJw7yI+Z3bzwU2f3+6jkM/OeMsVH0sd28t02VIhQ==
X-Received: by 2002:a5d:4f10:0:b0:374:c8b7:63ec with SMTP id ffacd0b85a97d-37cfb8cf2a7mr3444408f8f.21.1727894133008;
        Wed, 02 Oct 2024 11:35:33 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d2e8sm14714913f8f.18.2024.10.02.11.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 11:35:32 -0700 (PDT)
Date: Wed, 2 Oct 2024 21:35:30 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Minda Chen <minda.chen@starfivetech.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v2] net: stmmac: dwmac4: Add ip payload error
 statistics
Message-ID: <tb2o2dhxcg7lykl743no3zkkjnqwuce56ls5ihrwreowigivwv@2mol7uc2qvto>
References: <20240930110205.44278-1-minda.chen@starfivetech.com>
 <20241002065801.595db51a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241002065801.595db51a@kernel.org>

Hi Jakub

On Wed, Oct 02, 2024 at 06:58:01AM GMT, Jakub Kicinski wrote:
> On Mon, 30 Sep 2024 19:02:05 +0800 Minda Chen wrote:
> > Add dwmac4 ip payload error statistics, and rename discripter bit macro
> 
> descriptor
>         ^
> 
> > because latest version descriptor IPCE bit claims ip checksum error or
> > l4 segment length error.
> 

> What is an L4 segment length error on Rx?
> Seems to me that reusing ip_payload_err here will be confusing

From the current "ip_payload_err" field semantics, Minda is correct to
use it for the Rx IP-payload error statistics. Here is the definition
of the IPCE flag (part of the RDES4 descriptor field) cited from the
Synopsys DW QoS Eth v5 HW-manual:

Bit  Name  Description
 7   IPCE  IP Payload Error
           When this bit is set, it indicates either of the following:
           ■ The 16-bit IP payload checksum (that is, the TCP, UDP, or ICMP checksum) calculated by the
             MAC does not match the corresponding checksum field in the received segment.
           ■ The TCP, UDP, or ICMP segment length does not match the payload length value in the IP Header
             field.
           ■ The TCP, UDP, or ICMP segment length is less than minimum allowed segment length for TCP,
             UDP, or ICMP.

It almost word-by-word matches to what is defined for the
ERDES4_IP_PAYLOAD_ERR flag (part of the Extended RDES4 descriptor
field) in DW GMAC v3.x HW-manual for which the
stmmac_stats::ip_payload_err field has been added in the first place.
Note the name of the flag in the descriptor matches to what is declared in
the stmmac_stats structure.

So based on that I don't see any problem with the patch except some
minor patch-log issues I mentioned in another message.

-Serge(y)

> -- 
> pw-bot: cr
> 

