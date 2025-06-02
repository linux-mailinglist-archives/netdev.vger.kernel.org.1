Return-Path: <netdev+bounces-194575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B402ACABCA
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 11:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D54189E3D4
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 09:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE011E7C06;
	Mon,  2 Jun 2025 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBdRyF0/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6C51E8328;
	Mon,  2 Jun 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857470; cv=none; b=HCcYW0cqsIM++MCR9/Q/Iygzp8yayqWDAZhDp8DETtfo31UgowR88yJh7dBXO4gWBx/Wq1qFRLA/h1MVMAvBfA+OLOmQ/XTPeh1GUXW+fRXi+No+CegJ7gd9/GxHk2MeePrEN3mt7CGwaN0l5WiVzerK52+q97TvWQ0VcBXvbhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857470; c=relaxed/simple;
	bh=xmBH5czQjFIsa8LnBYBUvZXNgl6kBQfslFYSZkWrujk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxvQWpCpjmWrrc0gSg12cCpOK74uwhNFEPhGu3oPC6vInNHhKEsdy0zL0T9uHiD/G+YxqlV4HDX/74CBMQ/qDRVceoNTkvbFVrOedniwxNWnl4QvTjpfFzeBOIvZbTV64qwpQeFIO71AOvDuYZbADGhXlHVP2VZHjsQf+fR9aH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBdRyF0/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad8942cc6faso26845566b.2;
        Mon, 02 Jun 2025 02:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748857467; x=1749462267; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zesnd6bTvxrkLopsZikvZ1T4cmCNKzjJVQCn6KpRc2c=;
        b=cBdRyF0/sbVwJNeHvqKU/93jkQSfwDFtsC+1/LVZkLI5ouuxCWQH6z7j1imslAqrf1
         XydB5YivOIrnj5xp9g9JE3Bh16Q2uzCwb37jw0y4S3SNzrinDep//6g4g8LraIA3yajc
         u4LuT87wiR666H1cOx9vfCexVZmXc61YEfFi8XpVgtzoZivSBiV+0gvcTjMid64iqNgF
         3/a/fPVhHPmrntAA+VNQnJUnWRHndAqwEJ2MLohAOK6oit7ygNXhg8eakdmgWCfZmlq3
         oGhgYcr9gV67Ow37C30Oi6C6eCpEQ6RVAOY3h1Mkq3KAeTn1R8Pp1m+c2bDmPIFC8/+x
         YvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748857467; x=1749462267;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zesnd6bTvxrkLopsZikvZ1T4cmCNKzjJVQCn6KpRc2c=;
        b=qTF68x4B/FmF6Ze1+sds0HdFiklfYxazFN9wqYY9r/2vKMXG9wkd2a0L7dMsJMpi1Y
         8P6aVaMuvOnChxkYx32URuJBxfAKj9oMSF1rNJ2E+fFueeSxJQTjekooXREKfJknIGc0
         Am5o3zt5p20N6lwZb3e+4PU3ik+B/3nQ47OkyCnyZFkyuvbk7wcfMs14rziVIhaFt3Oh
         MRl+5dcAaogp458w9CeFe3qPFaZH33DS96gkqORPsuDS0/8VnGuTjsHThapknRS89nra
         NIU0ZZ/LavvoNUkp9o/C4/+rPckKlVYwsNT2cBafLq45QXXyMZYG62hMs604VrBz5hb3
         u5KA==
X-Forwarded-Encrypted: i=1; AJvYcCU/sGHG4VwGRFGgh3z14IHOxjoBeovxTGL5R71iydyp7UIWe1U+PiVqHompypOcgqF5xssdVOba7qvoiA4=@vger.kernel.org, AJvYcCUDcYo/gHKWpMq7JR4QDgFGcIT2XfV1CV15/TNsVKZB+Ln38eEDqceHwQaKVDeuDdEdLSb1yjSX@vger.kernel.org
X-Gm-Message-State: AOJu0YyNAjyaQ/kQZV73O4z+/rmEYaiYWk2Td5y1dpq9fqw9l+DiryWh
	Mm5CKI3PV7LQbF1NjNhOyAJcFv47gEYVSporo/LwYarw9LrOGjfozeQG
X-Gm-Gg: ASbGncttpXQRDXlcMt2flFg8q4ZOOVBiBCpoiphXTpDTSanSYfi1S+WOGRde12fqJU2
	V+P3seSeYGbrUPE3+Pl4DvHroZZDPtiAWJhtet3Vv5wZfJYUgmVdWAONVmRGnKIOFbif2nq6kPI
	FAiKWBTcoRKjm5qagUFLaVfJ3QdaSsnTbZPTqsry7p3GDD5gn9GNn6MGpY7lOhmpIf/OIG3WZg9
	xfralzrugWbdwAZ/OT8FRJbcg9phhQJyBHIHQg6kWJu6AwgAK2unpToOHtnhigd0Uhjd8TNRJJM
	23YKFW5ZYCq/cgUX9aZJHQE6Nw9eGlAHZTMwQdM=
X-Google-Smtp-Source: AGHT+IHGRZsUNGriRExzHNpTJp8RVpjM1nvJvcFd+PssWLf6CWxW9UFF26PaXp9QsSSzF4oBcAIWWA==
X-Received: by 2002:a17:907:2ce2:b0:ad8:882e:39a with SMTP id a640c23a62f3a-adb36a69057mr362497966b.8.1748857466884;
        Mon, 02 Jun 2025 02:44:26 -0700 (PDT)
Received: from skbuf ([86.127.125.65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad394e5sm769413166b.137.2025.06.02.02.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 02:44:26 -0700 (PDT)
Date: Mon, 2 Jun 2025 12:44:23 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Cc: jonas.gorski@gmail.com, florian.fainelli@broadcom.com, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vivien.didelot@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Subject: Re: [RFC PATCH 08/10] net: dsa: b53: fix unicast/multicast flooding
 on BCM5325
Message-ID: <20250602094423.z56vjqlyxp7sbdhw@skbuf>
References: <20250531101308.155757-1-noltari@gmail.com>
 <20250531101308.155757-9-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250531101308.155757-9-noltari@gmail.com>

On Sat, May 31, 2025 at 12:13:06PM +0200, Álvaro Fernández Rojas wrote:
> BCM5325 doesn't implement UC_FLOOD_MASK, MC_FLOOD_MASK and IPMC_FLOOD_MASK
> registers.
> This has to be handled differently with other pages and registers.
> 
> Fixes: a8b659e7ff75 ("net: dsa: act as passthrough for bridge port flags")
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  drivers/net/dsa/b53/b53_common.c | 85 +++++++++++++++++++++++++-------
>  drivers/net/dsa/b53/b53_regs.h   | 38 ++++++++++++++
>  2 files changed, 105 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index 387e1e7ec749..d5216ea2c984 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -560,12 +560,36 @@ static void b53_port_set_ucast_flood(struct b53_device *dev, int port,
>  {
>  	u16 uc;
>  
> -	b53_read16(dev, B53_CTRL_PAGE, B53_UC_FLOOD_MASK, &uc);
> -	if (unicast)
> -		uc |= BIT(port);
> -	else
> -		uc &= ~BIT(port);
> -	b53_write16(dev, B53_CTRL_PAGE, B53_UC_FLOOD_MASK, uc);
> +	if (is5325(dev)) {

Maybe instead of a big "if (is5325(dev)) else", you could have this instead?

	if (is5325(dev))
		return b5325_port_set_ucast_flood();

	... // go on with regular procedure

Here and in other places.

