Return-Path: <netdev+bounces-122315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567E6960B3A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876CE1C228FF
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9841A0715;
	Tue, 27 Aug 2024 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ci3oK9Fx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5788719CCED
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763825; cv=none; b=ln/sMLtn37+di4JcGp5MZjRphXSvhj189nZ+f9q8WDIpkssOZIyhub4UTgnk4ExC/5eUMG/QTfk1gHl/ezy/zzBEE8v144g4Bc4tcAH9/iaRqzoBAJNgi/UNLV96CkprZKaJF2g0RAZb293IXtgrPj9XQaK8zTD7TUhz0gxHgjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763825; c=relaxed/simple;
	bh=g131o0KuyKHodChgpl8+qeSQWwQdDBkQEeVD2/iEY1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyY8A3yhvEGfcYm1mpTga2+5rGYkmKWiKhP3esBByFVvfU/Ds9i9M3RRbn7ELNWk66OVlAnFLC+vzsKuD8VJpbB3+01VpiUTim8FqEbrotIFDz0bafrF9UY3FC0EirCyCzMQzjYc5HQLgcR1UoUWzwXv1FQRL7AVvUwHKqfkODk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ci3oK9Fx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724763823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JQ7KSXos2g5YKHcot8IcrKmcUaOEE56R2i6CzUYd7pg=;
	b=Ci3oK9FxcijfE6nAx9TuuP/nE4bq0fnbCP6MEOxrmfFTbcXZX7Ogekkdv6kIYgVH5hrvG7
	dofyxffTystoKpfvyGp+5t7SobH0hCu8D5TMCecsNBIrIr8dIiY6s8nPGqAm/KnfTj70hX
	utrIQAqsu7XZr15ZcYkEUaqt419VIVM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-6W5y5k-oPrK_3acwPKlaUA-1; Tue, 27 Aug 2024 09:03:42 -0400
X-MC-Unique: 6W5y5k-oPrK_3acwPKlaUA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428ea5b1479so46325405e9.0
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 06:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724763821; x=1725368621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQ7KSXos2g5YKHcot8IcrKmcUaOEE56R2i6CzUYd7pg=;
        b=FzxNAgsSToV08b6HDxXLUPHZkhlXrbkksrs8pbRM5M0N0NFhYl4t6w/pP6LJBwL5c9
         Esd6GTLEbvzCnMErNTt19Nk8Fu/cRzVUnSe8wCT58okAuM8CFC+z4fzEhG3Cu/SdvGXI
         aMrr59heZuSnumm9YX2k0J1Q6a4Z5LJGt3tdVDPTw9Vbr72c6DfCFfhLPwnKIOcqe4xC
         EDWY5BeQEUusABgk8W48zz4Rjk1Ago/BywmW3HlShDymfJV6pKSsrIlPhzUODYLsH+m7
         E5S/vu5Ww0PelQ893txfRZZDTgAQMyYMO0985u/yBS6mIH1uBk67JsQ+JfB9clebp8kD
         zBVA==
X-Forwarded-Encrypted: i=1; AJvYcCXfJ7gDetkEHNBg0nKY/253CfiX6iE2eZHj3CCwVWFv/Xe9rgI4O05Z+X5I5Yjtu8bfrqKvlV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTuIsrTw66E6IKLrHy2vv1/YjnsNRcmOZQhauRVu5mL5DjR+P8
	726JMAcmVaLDKubaDtF/fmLT1dN3HgUnhkPfG/i/jFv98dWdATFC7pls+XqOrFp0FIbp5HU93kc
	G7xo+SpsslVS4vqrRMVcMlPkkr28cy+S8JBHKDOZ+CS1cxlWseCB8EQ==
X-Received: by 2002:adf:ed08:0:b0:368:4edc:611e with SMTP id ffacd0b85a97d-373118580dcmr8316825f8f.14.1724763820829;
        Tue, 27 Aug 2024 06:03:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd1xsweSnbINCAxizbM13yu0pRe3D0c3l234fJFAE105Vpm2FkO3D8LTHh2scsUxQgobBHWw==
X-Received: by 2002:adf:ed08:0:b0:368:4edc:611e with SMTP id ffacd0b85a97d-373118580dcmr8316789f8f.14.1724763820223;
        Tue, 27 Aug 2024 06:03:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b67:7410::f71? ([2a0d:3344:1b67:7410::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730826a3f7sm13027467f8f.112.2024.08.27.06.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 06:03:39 -0700 (PDT)
Message-ID: <43ca814d-2003-4d1b-8cca-4d3fec3d1aee@redhat.com>
Date: Tue, 27 Aug 2024 15:03:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] net: pse-pd: tps23881: Reset GPIO support
To: Kyle Swenson <kyle.swenson@est.tech>,
 "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
 "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>
Cc: "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20240822220100.3030184-1-kyle.swenson@est.tech>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240822220100.3030184-1-kyle.swenson@est.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/24 00:01, Kyle Swenson wrote:
> On some boards, the TPS2388x's reset line (active low) is pulled low to
> keep the chip in reset until the SoC pulls the device out of reset.
> This series updates the device-tree binding for the tps23881 and then
> adds support for the reset gpio handling in the tps23881 driver.
> 
> Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
> 
> v1 -> v2:
>    - Changed the reset pulse duration to be between 5us and 10us, per the
>      TPS23880 datasheet
>    - Changed the delay after reset to be 50ms instead of 1-10ms in order
>      to meet the minimum recommended time before SRAM programming.
> 
> v1: https://lore.kernel.org/netdev/20240819190151.93253-1-kyle.swenson@est.tech/
> 
> Kyle Swenson (2):
>    dt-bindings: pse: tps23881: add reset-gpios
>    net: pse-pd: tps23881: Support reset-gpios
> 
>   .../bindings/net/pse-pd/ti,tps23881.yaml      |  3 +++
>   drivers/net/pse-pd/tps23881.c                 | 21 +++++++++++++++++++
>   2 files changed, 24 insertions(+)

This has been applied by Jakub, but the bot failed to send the notification.

Thanks,

Paolo


