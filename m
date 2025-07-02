Return-Path: <netdev+bounces-203379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C9FAF5ABD
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A74A176C8D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2EB2BE7B4;
	Wed,  2 Jul 2025 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0g8/CW6n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8FE2BDC1E
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465586; cv=none; b=g1IvJwefyb+fFwhlyO4IBElBV5PUXBs4B+uXR9toq1DFTO9BcY9w+I9UYe9kgIdVsD9jS9TKNsHDYv2ZbEiBiLXwuRkN6bxtrECwd5QOxl9KD2h8IqnmbMLnrXxsXKdyMRHtV5PcmMepLEdJvU2L45wMVnZQ+YSJeHs2GCam/EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465586; c=relaxed/simple;
	bh=xIX6GxkYy+RMVioZ/VaEmi8TDF7cbtgtQXVNUQIlmus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnB1fYiydxuhSuSQEVhuzZE1SZBBQCs/tZFjIXSWL7srxnGJzftXvkLA9A9tA/y2Lxp5TdVxOIoFpDsiMrzQlcuI4c655V8YQzKdvlUgBNfqKL7UeQx5ZkVyDnGCOLLSWlUpKSS7bQQUuVqCjK/poaEYOn8W4qRULTEcOfFIyis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0g8/CW6n; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-453634d8609so49339025e9.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 07:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1751465583; x=1752070383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KCX8EDCd8/i/wYRS9YBmGDW0iWUiXiEN/46xP+vv74E=;
        b=0g8/CW6n4xengA9/rppoYsTHQxislg1Z2I5aP0twp4c8xYsmszHOV/Mpf+zRNJV7cw
         Q5NpzqCvER6Hwbt+TGuNv95T0LPr2gZtIN775W3NCc4Oy6BZN9tReQxeGchZZ9TGl+G7
         IVVsH5CErKsV0gwC8iSYFI3qUaoH1oMvVIpTvGJEoeWHBZ3T78rvkfO5BE3a15uv3eeV
         2iuN0R7Ef47Z8WLCkj3PX8X5G0UauUE6c5zWyFEKKKMcVZ+psObLob816QgkeW7zIfGI
         aKVKBjrsSwhrF7xrGDig/xh5ruQCa4dSyRgtOik80DqnLuVSVAwACKdYmABsd1dVdZ6x
         ZQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751465583; x=1752070383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCX8EDCd8/i/wYRS9YBmGDW0iWUiXiEN/46xP+vv74E=;
        b=bIpFqKo+TBD1eFNojMxXXQo1aVnqyWE+YNBPW+0r/diLIITJOGCSmUESYS+IlTOUmB
         Gr9eRePMPYma2kj43kjG+DNikAkhUWB05dGD5cmlC//5VClaQ+St7zZAPyObqgT6Pu96
         eoaMXuoqlvLanAexaOU0Kg2Teb62vPAzReUxKSPgRKK4V0vCCCgYk5JfwWo8Ss8zlXlW
         CSJ6kC4FLunlMkaUN+tlpjlUBciCGmazCj5i8LZq6iF/RYCQC7XoTfy7fVc7vFommVQm
         SbspDbpy1vu27pBeIMcCVs7gfdrz4N93cAovV3kp4jKWzVPkbRKDY95tVtuJ5RPWxzvC
         uYrg==
X-Gm-Message-State: AOJu0YzUcW7Tg0+dKdGhORGPLABb6SpLQS9uRhKWA2mNCrp1zoOLV0Tx
	k+JpzcP2YrXjU1E6+lkWv/R3lujTYNJ/6EbAOfIykMzQ8Nvs+vOtT7flfjwGGLE5oy0=
X-Gm-Gg: ASbGncvpLtiNDxV9qkw9C81JfLF5Pv7y5B1o0fZYuwI7X2+N4PYviTmqFLnkqWntDTR
	mB/J0tvbZJ9T2nnFVgixIdkvjnJWvt7RfCgo4vgxtDpLXcN/iFAnVeL7AAv4ymf03apwBkuWdMs
	kyOkH3R/V4mLSwgzdrqmzo/d1JtgGtwGXI4Zmt/CvvYJH+BggxKBgn/15LJWVnWSfohKPqKGMrq
	bruBEzXAOE4qBmB5iM639V2omZzymXIFAFojGv+udxGvXlLPti+zH0DrDOJIiRshbi0vbeiYAmi
	rgRVaqGyQ03gPgHv5rVpGgx/t4dx7pOexgTYd11Id0Oh9GbMxS0RiLe2s/514w/52N2gDA==
X-Google-Smtp-Source: AGHT+IEk1Iz9F6Hzi17G8siVxy1kneMMVA9o7oJxCvLiimTGG5VAQ9oHTXa5JjHBEPPb8pmO2Hxa8w==
X-Received: by 2002:a05:600c:638e:b0:453:b44:eb71 with SMTP id 5b1f17b1804b1-454a370c313mr35319005e9.19.1751465582882;
        Wed, 02 Jul 2025 07:13:02 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b6d50sm233164175e9.30.2025.07.02.07.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 07:13:02 -0700 (PDT)
Date: Wed, 2 Jul 2025 16:12:54 +0200
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
Message-ID: <3sgsj5vxtkzfpfpn5igave2qppy27mq7erpcmhqtfswaayaynv@zcsldf44o7b3>
References: <20250629191049.64398-1-ivecera@redhat.com>
 <20250629191049.64398-10-ivecera@redhat.com>
 <ne36b7ky5cg2g3juejcah7bnvsajihncmpzag3vpjnb3gabz2m@xtxhpfhvfmwl>
 <1848e2f6-a0bb-48e6-9bfc-5ea6cbea2e5c@redhat.com>
 <k2osi2mzfmudh7q3av5raxj33smbdjgnrmaqjx2evjaaloddb3@vublvfldqlnm>
 <e55caefa-2ea9-4d31-be76-48cdfd481b5c@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e55caefa-2ea9-4d31-be76-48cdfd481b5c@redhat.com>

Wed, Jul 02, 2025 at 02:16:53PM +0200, ivecera@redhat.com wrote:
>
>
>On 02. 07. 25 2:02 odp., Jiri Pirko wrote:
>> Wed, Jul 02, 2025 at 01:49:22PM +0200, ivecera@redhat.com wrote:
>> > 
>> > 
>> > On 02. 07. 25 12:57 odp., Jiri Pirko wrote:
>> > > Sun, Jun 29, 2025 at 09:10:44PM +0200, ivecera@redhat.com wrote:
>> > > 
>> > > [...]
>> > > 
>> > > > +/**
>> > > > + * zl3073x_dpll_device_register - register DPLL device
>> > > > + * @zldpll: pointer to zl3073x_dpll structure
>> > > > + *
>> > > > + * Registers given DPLL device into DPLL sub-system.
>> > > > + *
>> > > > + * Return: 0 on success, <0 on error
>> > > > + */
>> > > > +static int
>> > > > +zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
>> > > > +{
>> > > > +	struct zl3073x_dev *zldev = zldpll->dev;
>> > > > +	u8 dpll_mode_refsel;
>> > > > +	int rc;
>> > > > +
>> > > > +	/* Read DPLL mode and forcibly selected reference */
>> > > > +	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(zldpll->id),
>> > > > +			     &dpll_mode_refsel);
>> > > > +	if (rc)
>> > > > +		return rc;
>> > > > +
>> > > > +	/* Extract mode and selected input reference */
>> > > > +	zldpll->refsel_mode = FIELD_GET(ZL_DPLL_MODE_REFSEL_MODE,
>> > > > +					dpll_mode_refsel);
>> > > 
>> > > Who sets this?
>> > 
>> > WDYM? refsel_mode register? If so this register is populated from
>> > configuration stored in flash inside the chip. And the configuration
>> > is prepared by vendor/OEM.
>> 
>> Okay. Any plan to implement on-fly change of this?
>
>Do you mean switching between automatic and manual mode?
>If so? Yes, later, need to extend DPLL API to allow this.

That is why I ask. Looking forward to it.

>
>Ivan
>
>> > 
>> > > > +	zldpll->forced_ref = FIELD_GET(ZL_DPLL_MODE_REFSEL_REF,
>> > > > +				       dpll_mode_refsel);
>> > > > +
>> > > > +	zldpll->dpll_dev = dpll_device_get(zldev->clock_id, zldpll->id,
>> > > > +					   THIS_MODULE);
>> > > > +	if (IS_ERR(zldpll->dpll_dev)) {
>> > > > +		rc = PTR_ERR(zldpll->dpll_dev);
>> > > > +		zldpll->dpll_dev = NULL;
>> > > > +
>> > > > +		return rc;
>> > > > +	}
>> > > > +
>> > > > +	rc = dpll_device_register(zldpll->dpll_dev,
>> > > > +				  zl3073x_prop_dpll_type_get(zldev, zldpll->id),
>> > > > +				  &zl3073x_dpll_device_ops, zldpll);
>> > > > +	if (rc) {
>> > > > +		dpll_device_put(zldpll->dpll_dev);
>> > > > +		zldpll->dpll_dev = NULL;
>> > > > +	}
>> > > > +
>> > > > +	return rc;
>> > > > +}
>> > > 
>> > > [...]
>> > > 
>> > 
>> 
>

