Return-Path: <netdev+bounces-203290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05440AF12D5
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 12:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35784A1741
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 10:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E23A264A9E;
	Wed,  2 Jul 2025 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Lxqm/R71"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA4826057C
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751453856; cv=none; b=JhYiovAVqPEgMi3yMXLuESZeA90ze5AMAndi8ufbae5tTfSSdAnvX2KmLHU2A8HYwfTX5Swd/2AdfE6x4PkI2NAv+dfK9WVVeLUfLnXgafXYmXIAupoQqyZgb1kauNsDu8aDznN/5g8LevtrP1aIKuOSQnNko0muKajdCmaj5GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751453856; c=relaxed/simple;
	bh=IWxUbh4BDZ7bPd8L/dwwB+q8iBVYy1u5irOTFUt+L8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCzXILn2KkgOC+ckZJ+K2Lo+u3IvJPozkw6oFQu1fijG6Cpi7WX628avrkIjuJZJnwucWmvLo950LtWLS2z5esluNJf8zljVVFLT6a+Qh374cOjMSigPf1pbyEu6sEyyG/6BcM30ZelEUZc22/b4hc1CgoOLyGrkTX1faLpalR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Lxqm/R71; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so6010855f8f.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 03:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1751453853; x=1752058653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G1Fm2q1qB6Y+ckuWV69fHpAi4zNbor+5BGrf65Mmqog=;
        b=Lxqm/R71/qlMDJ0eVPjPMCiMWcyRwVJq+DsfxJBR3A/Zyq9stlGs2NCPVV66goGmZ+
         mGxDjmYDSO8FXJI3ByzarZvm5+3H+pO/eDuaThx9UWH5zGErhl4ZvBTwf4fbm21RtSZJ
         pkGIizRtBhsrvw0SuS9fE3oGn2a1m83Nyl6Bqrtgf+s7dPg+NaexUVjV0tyQkTVY45PT
         szz0fZOxvhNwSVTGvog8IY7uyRe3gZIWjpFthWx+XFeEa/EKlra6sLMbSgIVpxDiXxB5
         eVgyYe+Hs0Rrl+mF2uZfiS4PFTSFYPqTlNRwYQ/nmPDkAvlw3XnyrSzjHcOutUyEVbpC
         CKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751453853; x=1752058653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1Fm2q1qB6Y+ckuWV69fHpAi4zNbor+5BGrf65Mmqog=;
        b=NGrJsAoN946UOnE4zBGf/MxrKvr9DGzJT8GZmHwdXb9TSWv27TC9jWcDpdwq9rScaB
         kWED3oSMEHfO1nKxwPEemDSrVjoSJVbOZmRCk1s2UIqncvoqoGvGHXM/EDfSWzb59Kd9
         bGJCoeQ5hmvSwcDOcpU3+BdEoizLXqSDPzcXhQdwOkvQey/eWBQcXZVGUrKTk5zcri1l
         HDFjNJDETiPOlVAhFzDEbwgHkqFcikayYKPnkBZmnQy80dO/GeacE723KumQXNCJIo01
         QhMWnSJJCGpTtorHRT3zbiJadWyG/Nl2UJ5CtXhDIDBv+qrE9qXjcA2WLUlod4fRdk8f
         u6ZA==
X-Gm-Message-State: AOJu0YyUrt6y7IMjvdzCS1Xv6cnNLUfm0FAl1KLrgWZ2jz1WugbVEOzj
	TSlvKRVej3doGE6rcCEzcwLBgaXHiXKDDOAe580v5K7AZzKSHIgxQ+7WCx/IT0lmeeM=
X-Gm-Gg: ASbGncsqIla91XfEmPBIGGmtLTCGgDyfb0LXVbf9qKYRU8iul95RITxO8tQ9MXCWE89
	d0b1RovwsD2AKiC+ukTXuIXWdoZsQycSEyXl9/iM9DnKkJBAySxta0jjdstV7EMmLycAJ2VOb2y
	aJPsfLRJeivRl6VE5HzCuvr3/wlgQJ3cAg1yZK5KnT/YdqVqnoX0b9QvjOI+Itjsn4/Xfhr+qXH
	VIAxOX3MdoAmOF1CRBV79Ywp2CFOXGJilJKfCCLz7LSTYyMlHI2n58Eg9cmt68ZEP2ttLpfBbgi
	JepDaBOT+QCooE6Fkwq8iT0BLycncEsNS/ESJVt58Fa1eqQs1VRfGJRGl5qK/UFGk2xRXg==
X-Google-Smtp-Source: AGHT+IEDVTtMFy2hu992Zcq7801L2H6bIzfHs2qeo81vyzxGHZtPy+ypN/+AhlS2RlBfT5PUx2bs3Q==
X-Received: by 2002:a05:6000:21c4:b0:3a5:8abe:a264 with SMTP id ffacd0b85a97d-3b2001ac737mr1267473f8f.37.1751453852634;
        Wed, 02 Jul 2025 03:57:32 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538f2fec5fsm173817385e9.40.2025.07.02.03.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:57:32 -0700 (PDT)
Date: Wed, 2 Jul 2025 12:57:22 +0200
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
Subject: Re: [PATCH net-next v12 09/14] dpll: zl3073x: Register DPLL devices
 and pins
Message-ID: <ne36b7ky5cg2g3juejcah7bnvsajihncmpzag3vpjnb3gabz2m@xtxhpfhvfmwl>
References: <20250629191049.64398-1-ivecera@redhat.com>
 <20250629191049.64398-10-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629191049.64398-10-ivecera@redhat.com>

Sun, Jun 29, 2025 at 09:10:44PM +0200, ivecera@redhat.com wrote:

[...]

>+/**
>+ * zl3073x_dpll_device_register - register DPLL device
>+ * @zldpll: pointer to zl3073x_dpll structure
>+ *
>+ * Registers given DPLL device into DPLL sub-system.
>+ *
>+ * Return: 0 on success, <0 on error
>+ */
>+static int
>+zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
>+{
>+	struct zl3073x_dev *zldev = zldpll->dev;
>+	u8 dpll_mode_refsel;
>+	int rc;
>+
>+	/* Read DPLL mode and forcibly selected reference */
>+	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(zldpll->id),
>+			     &dpll_mode_refsel);
>+	if (rc)
>+		return rc;
>+
>+	/* Extract mode and selected input reference */
>+	zldpll->refsel_mode = FIELD_GET(ZL_DPLL_MODE_REFSEL_MODE,
>+					dpll_mode_refsel);

Who sets this?


>+	zldpll->forced_ref = FIELD_GET(ZL_DPLL_MODE_REFSEL_REF,
>+				       dpll_mode_refsel);
>+
>+	zldpll->dpll_dev = dpll_device_get(zldev->clock_id, zldpll->id,
>+					   THIS_MODULE);
>+	if (IS_ERR(zldpll->dpll_dev)) {
>+		rc = PTR_ERR(zldpll->dpll_dev);
>+		zldpll->dpll_dev = NULL;
>+
>+		return rc;
>+	}
>+
>+	rc = dpll_device_register(zldpll->dpll_dev,
>+				  zl3073x_prop_dpll_type_get(zldev, zldpll->id),
>+				  &zl3073x_dpll_device_ops, zldpll);
>+	if (rc) {
>+		dpll_device_put(zldpll->dpll_dev);
>+		zldpll->dpll_dev = NULL;
>+	}
>+
>+	return rc;
>+}

[...]

