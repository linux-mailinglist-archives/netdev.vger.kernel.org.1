Return-Path: <netdev+bounces-133018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D3D994495
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946FF1C24BEF
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A4F184551;
	Tue,  8 Oct 2024 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nmlh7FCL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7241865EF
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380659; cv=none; b=sV/1sHWwQxPHXlq1u4b0+QBox/9OV2W2o0e+cT5WzS25PS9SLbUallpJdORGcLI57OstS1tYgYX8cYVpcbrh1CfF9UYnx+wWF4hX1NsEC2lb5kpVUw9v8y6R9p+9y8rUR40ItsatvuLY7vqM1X/9pZGTKlkxPoD7W/21R9A6zSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380659; c=relaxed/simple;
	bh=SDDLtyGwN3boJU9vuDQmf/lWBtfwjCJZjBYvHpbuZ8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4Q05nvfJB7beZCyvMyBrkpAwEJK1Y0y3Lo3xH4X/rHi/3ktTaciG5Rtpn1EaXS8znKoD6h11YF4WPJU/93F6Wm5RECyT92ujYocsOBbeAAuxpc5+GJidsuUpKY4v+jwXzAOaLda4m8RQ+APsv7WFsFweCmYd7TCxoPFF1znVT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nmlh7FCL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728380657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BX5Wg/uFyRBw2TJnom7CLx4mNcqX+J1yoWEepUCTp/c=;
	b=Nmlh7FCLE5zq+yLDzuMdTpX8Y010FRd4UTip/FwepyuyKrN8RwDcQPPotUfw84Z6oPtwWg
	y/8jKeWtVBKbxpdIhIO3eNok66lBSbCOXjI12EXKQLWM7ztRXEmVsi4Tawk39l54Kd0UYe
	cpgsd5AU2KOi9I85awmLZWP9jER+I/E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-6WG2F2RHNvG0DspAFqmeMQ-1; Tue, 08 Oct 2024 05:44:15 -0400
X-MC-Unique: 6WG2F2RHNvG0DspAFqmeMQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37ccd39115bso3520536f8f.0
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 02:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728380655; x=1728985455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BX5Wg/uFyRBw2TJnom7CLx4mNcqX+J1yoWEepUCTp/c=;
        b=lmSBZfdgDtTGmRqmnvOvjcbNdiSDPhBRwFXUVKSTrQPHdB9fCh1qi6lCijiQWSlgsA
         jW0iZgS8iUQFKPIB/vt8e6iEqPx9LbZ1brt9+bQH9SyGIpzPV4S7LnhW8VaNQL4N3ZKq
         vl2ZAksEfF+kZyDjsHgGdzaj2xu4d9jk7veh7cjdjFaDKt21bc1ByRdMPJ3fuTK1lDQH
         hAU63UE0QTJqnIy5UW9qLk9UU9hgJ4N15u4Y2N9VmR5AWzrnjCDPb8OcZmQLGvTEhAsJ
         BM+lCSu7yE3zo2SqJqePgwlyDp0gPk6IqegpMSOSce67I01FqeMiWLBL2SsSdt5Kgye/
         T1LA==
X-Forwarded-Encrypted: i=1; AJvYcCU9bYRcKzNZITPPEOyDXoi+EKGc+i/73AjHV3Amn8EUbtkvvKK6Eou34GwogB6fMxA+VMrdw1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuclqReoFLtzikKA/uHRyaIJIly4WamKoeUl4PWQOebTkvwf/H
	OLgfDqV/4EtYWzEcc7e7RYDTQ2FcsSWhaiCPDKTzT/H0U00kLH9In+FlaoneFnfKWOAU2b3/08f
	kVAIMH/1wQkYnbnP5Hy1Fm0bc5bWgg/QdaRSEA4waLD/4lYztVVcl0A==
X-Received: by 2002:a5d:526d:0:b0:374:c1de:5525 with SMTP id ffacd0b85a97d-37d0e6bb844mr8595646f8f.6.1728380654556;
        Tue, 08 Oct 2024 02:44:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE0ymeMn3DM2N0eULYBv2CdhcxLdElwe23PHauaKbNKnWEklD4+BLjiRWhCHYTYJucujP0uw==
X-Received: by 2002:a5d:526d:0:b0:374:c1de:5525 with SMTP id ffacd0b85a97d-37d0e6bb844mr8595617f8f.6.1728380654086;
        Tue, 08 Oct 2024 02:44:14 -0700 (PDT)
Received: from [192.168.88.248] (146-241-82-174.dyn.eolo.it. [146.241.82.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1697024fsm7658040f8f.95.2024.10.08.02.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 02:44:13 -0700 (PDT)
Message-ID: <460778bb-aa3c-4b5b-9bbc-a65833b9035c@redhat.com>
Date: Tue, 8 Oct 2024 11:44:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/1] Documentation: networking: add Twisted
 Pair Ethernet diagnostics at OSI Layer 1
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Lukasz Majewski <lukma@denx.de>,
 Jonathan Corbet <corbet@lwn.net>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Divya.Koppera@microchip.com
References: <20241004121824.1716303-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241004121824.1716303-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/4/24 14:18, Oleksij Rempel wrote:
> This patch introduces a diagnostic guide for troubleshooting Twisted
> Pair  Ethernet variants at OSI Layer 1. It provides detailed steps for
> detecting  and resolving common link issues, such as incorrect wiring,
> cable damage,  and power delivery problems. The guide also includes
> interface verification  steps and PHY-specific diagnostics.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Very nice documentation! Just a minor not blocking note below.

[...]
> +- **Next Steps**:
> +
> +  - Record the output provided by `ethtool`, particularly noting the
> +    **master-slave status**, **speed**, **duplex**, and other relevant fields.
> +    This information will be useful for further analysis or troubleshooting.
> +    Once the **ethtool** output has been collected and stored, move on to the
> +    next diagnostic step.

Likely we will have to reword the this specific ethtool output at same 
point, and we will need to update this guide accordingly.

Cheers,

Paolo


