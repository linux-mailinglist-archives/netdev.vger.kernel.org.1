Return-Path: <netdev+bounces-101798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 744FA900206
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24EB31F21C76
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B8918C357;
	Fri,  7 Jun 2024 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Va1yAiWm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22E0188CCB;
	Fri,  7 Jun 2024 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759318; cv=none; b=ePZx6Ga+YGq9lODrtrxMaNqaBsCSkw/JEyTSFym9GwCIJS8LX/N+JzFK6o3RKYXs0SuYe7Uh1ztK/e8faLK0bSN+x24SqDZhveorki0UHSPF9CcIJG7M0vHqOfKeuj1pqnsqrDebufcTrg3k/+hhzfR2TPk8LdhwT0IzNtfGU8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759318; c=relaxed/simple;
	bh=Yl3DkmnPTUWMGgWDO4cJIljddrB4AEvlWOgDYnv5Dtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeZEj+tedhJE0RArNtysS10ztT0gWb1E1gZwaJexKBS8vvk+Szhflo7zYW14kB9uWGk637m0JpPVBRff3qV/CH25JxJn3k4BLdMYWu2fpL29lqg+Y+wl19neDpjEEtk9OayapAbLMU/5HM4Oo4t4CENssKrAlCWj0VNS1W9g/+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Va1yAiWm; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6c828238dcso191946766b.0;
        Fri, 07 Jun 2024 04:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717759315; x=1718364115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CRh9AsKOSlOyg9I3i83gQxMMzeGBKIcTnvDHJnPFk4U=;
        b=Va1yAiWmOhzZ2bClUgHFo7Pnw+uwaUsGiqMj7RLtnMp9/Fz0hr6OG+r6x5QMikjQus
         +DHAltyTCiWFmcopYc7Okq/dRZzIy+JXhNHsgQTHhqNqvVd0yQgZrHTB+goU1GvUJKQC
         uBT8H06MFEQ7GFj07VrugC9mDIhF7CCvi0A1BSt12f8NmXSKTO4MJyp2Vwx/Q/B33VOz
         GfsO10IWbJs8b+df9CAKgahRPRfw4pSqKZkSNwWPbyVthw8lpxpvYoXuNp1Ak+md/FuT
         4Ogv7TXM6UxdCx2Zp5XNT9f4XZKSL7DG1qYAWCpYxKdvmpKee8iH/Gy/d28HP3CCWpdc
         pdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717759315; x=1718364115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRh9AsKOSlOyg9I3i83gQxMMzeGBKIcTnvDHJnPFk4U=;
        b=CXDZhVLAuD4Ljr+sFngC+EoWVejL0Dk0wxY9pdgcojsVRnyzxhApmHKJiXLXbnPSVU
         fg+DiieQgh4pI6cFTdgReMKJPtggLRwtPOSrVhUZdHALOtw+07VnE5zLn9XodUdjQqif
         UJ2qBOoRU6I1es7VQh9M25XRTT/GxU4vdTIeYUpov6Ta6/rlHZtlykKucJpErtsKodTO
         0dS5wotkYlmp+u+znsclff64AdvyheJxm+EMpqA+8grNvvmogh5jXa3xuDUiylacFNjZ
         Qs93qDv8w130ntNXTdT+qoQLK/FCJvW2VLoEXbHRtduLnXAEBM6rYjGCb+XfvX1yzppN
         7tqg==
X-Forwarded-Encrypted: i=1; AJvYcCV6ISQEPpNFj6gxHIZ6QRZ86+vyQQT/I13DVvsDnknuU9M7EcykIZbxB5yYMXVKlvr1RWFnrF4GdLG1jItQSmIJXPFJzzJ8B1F/0qjeFecCcUpgQTwJMBOf7xZiVwJo4nFc1ot2tFy+kAzL9d47CB1kHGxzj6rHQjYwN1GebEavAg==
X-Gm-Message-State: AOJu0YyaCPq589HJEEBQU9SHImQlJtcEoXese1E7Uh6+Rq2DPHQvOwrp
	k2v9jKxyReACpL8pqJ5sq2wiVBfspQZupZ5E8dYGEALNf/kq8dbM
X-Google-Smtp-Source: AGHT+IELT5I2k2vwcuce/Gi+SvfjvAT1/ztYNxlZSeix24vWenMlR5O3hYpNx11OvftVJt+nPfB/VA==
X-Received: by 2002:a17:907:1ca1:b0:a68:a333:d2a6 with SMTP id a640c23a62f3a-a6cdbd0e29bmr193342866b.65.1717759314909;
        Fri, 07 Jun 2024 04:21:54 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805c9eacsm230753966b.58.2024.06.07.04.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:21:54 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:21:51 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 06/13] net: dsa: lantiq_gswip: Use
 dsa_is_cpu_port() in gswip_port_change_mtu()
Message-ID: <20240607112151.ghzbigprodboq7tp@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-7-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606085234.565551-7-ms@dev.tdt.de>

On Thu, Jun 06, 2024 at 10:52:27AM +0200, Martin Schiller wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Make the check for the CPU port in gswip_port_change_mtu() consistent
> with other areas of the driver by using dsa_is_cpu_port().
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

