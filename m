Return-Path: <netdev+bounces-129785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1904F9860D2
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 16:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C421F27AC6
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CCC17BEB9;
	Wed, 25 Sep 2024 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDkOMjoJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421F71798C
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271258; cv=none; b=EJuLqy0xuaLAORo5ah2GiDhIxlQFgccKS3pgqPr2M+M33yUCQhUCz2W1d/D5tzTt8P8bEfyy7lVIQh2yby4cp11yEpsDWhJsUMa7KzO9G0f2AVezs/UKCbhzXXGGwvzI/+0eo4SXotmjNB7nWkv809aIo7umb2mQqquvmdF4K0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271258; c=relaxed/simple;
	bh=sB8/KUANxSoxjpj2Iq9zbZAehZ6anaOiP0bkJ+kLzAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMVZVotw4ft6TRmA4ZSjDawGnaIT5Oh6WqS7f6IMS/Z06/h61Y0Tz4WapH4wjQl1hhn7nHUjslHGz/e3FpFxyQbLNbL/KiicG78w7VnziOriwchNiYHiNRpndOhlZY2v9EI9gA2D8XjtYiQMnc3SGKMAEHsQtMiFeM07rzC9TvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDkOMjoJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d302b6b30so81845066b.0
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 06:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727271255; x=1727876055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1G9GlB0spcSQ2Hzbn1Dic1BfcSKakLMd9Fn04CdJsDE=;
        b=KDkOMjoJwMBQSLhFGAglnyD5Cmh5YE2oDu8k1lbIEoxUi24Uy3W++SYW6Cbfs9ZNCM
         JNk1aSLum3pKmnVojya+4ELEn3zrRVmb5G8FMV7IirVWVGX17MEqVNDdZeUb9ZeCoaI4
         8KdrFqQQ9+TV0QX+f8p1k7213aaIzWs2yKd4lx6gpvY4IIpYJjDP9K3OA1iZgLfECNp3
         8IoNDo/WaatPDDSJ4Y7/Wpxrdmin5HnKrH2ktmSm21maW8S6kieWmk/k2jRMdlk6TQ8/
         /wkMnpEvZa1VAXwifqfDqw4H7PfQd+sybm39eqRzg0abgE7lJjjp4M7RuCepAIFNipJA
         UlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727271255; x=1727876055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1G9GlB0spcSQ2Hzbn1Dic1BfcSKakLMd9Fn04CdJsDE=;
        b=I1bGydiyc8WUEGPbTPydUyrOYQ4zpD4/zfAHIfD+Pr1j0wf/SQ9KhPwh5RlC18TYVi
         lDDomrJqBanr/4VBlQnlzFuvdGa9wQs6Lp2hLIj7oMpvoEpKb5JQKofZMO+MckuCTe/S
         cwH48mpSvgJjFItAl8JNgMRCGK5BoJTYhgXUgXPAzxNs7/KqMr0rQ9mrtB2WsAsWkm/w
         F0YA2xgOGgcQW01RfVkePFvFI0dvVVMTLEiGdrCpjbsAGr6seUsMZsvCJ7BagDu6FbZ7
         cGUJqURQCPg60fMtj65BmVyviwHjMDVvNjA/tnZnf2yWfi2pgi3Alhdak87lpEdSTGUP
         zDGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlJg8mbBgcmbAAoHWzNsOdPNStEPaVthLXpkFg9Lx/fHgjRlnZcsKKEkT3+NEatx3NNukXK4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YydP/yvv1k4Z0OfYPoXD8TdU16KZb7vRtMt2RpHnDIt351q8yus
	vApKVD+MVqNTes+sWie6PRjMl89DVmqZXdBFbFO3M1+1dc+YudpW
X-Google-Smtp-Source: AGHT+IFlt8RigiKecsjAQw3jCdDTeX+psJX6Ye/0uvJWpmUJn4dFKXnuhwDgbyCk2uZZJ0TnWaWFhQ==
X-Received: by 2002:a17:906:d554:b0:a8a:93ce:d252 with SMTP id a640c23a62f3a-a93a039f506mr116078366b.6.1727271255186;
        Wed, 25 Sep 2024 06:34:15 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f34291sm214235466b.14.2024.09.25.06.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 06:34:14 -0700 (PDT)
Date: Wed, 25 Sep 2024 16:34:12 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 08/10] net: dsa: sja1105: use phylink_pcs
 internally
Message-ID: <20240925133412.76bnadwfw55sw37a@skbuf>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <E1ssjd9-005NsL-K7@rmk-PC.armlinux.org.uk>
 <E1ssjd9-005NsL-K7@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ssjd9-005NsL-K7@rmk-PC.armlinux.org.uk>
 <E1ssjd9-005NsL-K7@rmk-PC.armlinux.org.uk>

On Mon, Sep 23, 2024 at 03:01:35PM +0100, Russell King (Oracle) wrote:
> Use xpcs_create_pcs_mdiodev() to create the XPCS instance, storing
> and using the phylink_pcs pointer internally, rather than dw_xpcs.
> Use xpcs_destroy_pcs() to destroy the XPCS instance when we've
> finished with it.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

