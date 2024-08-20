Return-Path: <netdev+bounces-120278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B496958C65
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AB91F2709F
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07721B86FC;
	Tue, 20 Aug 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBNsRfyu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430221C8FA8;
	Tue, 20 Aug 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171840; cv=none; b=F1L10IX33WdA3oTvalsHCXlDmy/1XCumQFaa3KCzbM/Qhm5Yv7mllCKf+SJT0eZpAmz29VGmLNwksk2yTRFcE7xZWYBxR2ud/v6nBGl9prrEsGevn3iT4uHfdYSzao0+y6OZvQ5mzkKYLvHwp+td34/YGQ5BN6cV96J3WM9owkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171840; c=relaxed/simple;
	bh=2nNREbCH/pr/tBWAR+BdTqAb2OYm44LtEYysj/desDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrNhhdw1kTtX7g6q7uNRNrC1WNcyLWo9cbL/xJiwXbu0paItPK5i/9OIZZtaQ8yDJWR8vjYr+yDMPtL2I956x6ylPJu5AtY54osEqFw/rTEu48VEQdLBWiPUoT9v3OYxCk7IGbkP5a3m3dQATrZk0Dm6Z0Hmdm1F9ticBTbCQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBNsRfyu; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7141b04e7a3so365931b3a.3;
        Tue, 20 Aug 2024 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724171838; x=1724776638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x7MxfxKYVnrK4uUnI7qzlvdovHkOxnx27tmvLvGkMRo=;
        b=DBNsRfyuJSUTfTz5P8puRYAPtKxOz7+KBvjP1GPzhHL2BMrAPIWHaxDqhX5oXkrjoK
         PdRRLa2pBCNZl3kngmEYIxfz/abgSqn3hoL1lh1y3AUh5HMZftnLcuBdoVgWsihpo8kg
         SRnRpnNVFx0lquXlKQDaw+7QODnsABmuRaeH52bhUmtx7ePpg1wo5dpSxfjj+NP/f+JH
         kZ/oJgKblWiXM8cZBMdXW3iRn0ZV6+ENUv/3nV8Jm1rRuj6Ua9TlF3QNNmwn0PkcSwdn
         Jp9wu9B0gO+FhxKeRQHbyvmu3VsQYW82dWAlW0/GwW5YptA7yDlm1hysQ1Bq+/LXaqpG
         Osmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171838; x=1724776638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7MxfxKYVnrK4uUnI7qzlvdovHkOxnx27tmvLvGkMRo=;
        b=dRpJXL/Mfhi4JMUQ2m46mCJmpJMEzI4PA33P2VfJN051VBUu8q/FHHdmK8z9CJcH4p
         HBc01ieYHYMD3h9sQNVwgiFdckS2QD61WS+HIL+TuFkgfAdS6MHNq2mUnB7lXSLIAOBi
         C//Nm+D1EWtV3wqqUYeIHTfsfX6E3ML1XPEDd0LQ48aX0q9Ro8Dk+UN4xlYGQ1whZVrT
         SI/0MQAaYhZ8+jHnNEg8Yj6digYVdZ9ClPyp8+l5X20GVSg38jpmLglYXi2dGc+lof1v
         sMHhi3bZoJAQcPAz81342IS6vYqSQldHKoQjx0Baa/kzUK3MJ80/eCCmhcsega07nEHp
         J0kQ==
X-Forwarded-Encrypted: i=1; AJvYcCViF7BcbaG9J8uvBK5bRDRBP9aQ8Jr9/dFLELXPyY3QZlN88HQmWlEITDsGPMC0wyNq47TZ8Gs9@vger.kernel.org, AJvYcCXWOApHAmnzP+G3tgDSjaW5XwY16mdCjtdy+hbmwoTpLiiRcimvbfdhp6lBBH+VhTIWbdxLCGNP63msMQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz14ggPmCoElpAW9yPsz/jxLiqpFe+RqigY1+ztcymTme/ouMQu
	umjQ+NgMjjCjPmOnmEBA1ppEgJYQTCJhgPP+XZcFkApcMI+UrdLIEJrg1A==
X-Google-Smtp-Source: AGHT+IFIxjkN75lOVYCa31isQLLkZBkY9ASiIt+lmjmtlP3VE06hgx3koq+xDVjjvaL2JgqfDsgKLw==
X-Received: by 2002:aa7:88ca:0:b0:714:10d2:baae with SMTP id d2e1a72fcca58-71410d2bb63mr1617288b3a.14.1724171838234;
        Tue, 20 Aug 2024 09:37:18 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9f8b:d2d2:8416:b9d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71410dabb3csm1111604b3a.213.2024.08.20.09.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:37:17 -0700 (PDT)
Date: Tue, 20 Aug 2024 09:37:15 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] nfc: st95hf: switch to using sleeping variants
 of gpiod API
Message-ID: <ZsTGO46wSsIuMQdf@google.com>
References: <ZsPtCPwnXAyHG2Jq@google.com>
 <20240820082614.0e9e9192@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820082614.0e9e9192@kernel.org>

On Tue, Aug 20, 2024 at 08:26:14AM -0700, Jakub Kicinski wrote:
> On Mon, 19 Aug 2024 18:10:32 -0700 Dmitry Torokhov wrote:
> > The driver does not not use gpiod API calls in an atomic context. Switch
> > to gpiod_set_value_cansleep() calls to allow using the driver with GPIO
> > controllers that might need process context to operate.
> 
> Could you explain why? Are you using this device? Is it part of some
> larger effort to remove an API?

Because it is better to use sleeping variants of gpiod API unless the
call is in atomic context, so it is basic code hygiene. We do not want
other drivers to copy the behavior.

I was going through my WIP patches and decided to sent it out. Originally
it was part of overall transition of the driver to gpiod API, but Andy
Shevchenko beat me to it, so movement to gpiod_set_value_cansleep()
is all that is left.

Thanks.

-- 
Dmitry

