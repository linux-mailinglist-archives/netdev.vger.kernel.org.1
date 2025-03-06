Return-Path: <netdev+bounces-172350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EDCA544E2
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC491676CE
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5752B207A32;
	Thu,  6 Mar 2025 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aa8VlRE4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D79207A0C
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249824; cv=none; b=Uw7A5hhux1icPxNfs6WqGUMUjXukz4Ld1aDKFXTSjXDuinDp0IpSgp0wW96Y71Bqak+jjJ66nd2DWFWJtJJPi8MaxEKte1szs7spuRpJDcMTsgqd7SlcGqyxF8eZ+w6tHkqXGSS1/t8E+UjhIdBfBuIpYkotTRnGTSgiGqcyCtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249824; c=relaxed/simple;
	bh=VvoSJeZ7MPAkJtonTuw/6n3jfxm0a91F1JYboOommUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQkOOz0jpeNO1knzj1k+0zy3H5nWzC4JyZ4qB3ndtJ4Tfux6R6a882/scw/N2RicX8SQG4FWwoNKAo0U7aw00hkMrGlUyRt1llx9z9OEwb7/mUDd9/NnYncV58zBr79rfJocze2uFyHlMH9+0FWBEr0FB6KhSA5hLQxnA+kBtSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aa8VlRE4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741249821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsCMTPwBZxgkhOa7brSI6tFSY0lECBrdeb8WRKOM7b4=;
	b=Aa8VlRE4/Ec7bBHclS3swpYv66wHcvu2hEW6J0yIKXZUWZMhapybM3425Y99rIPI43VSfw
	4xGftqC3CRFCGkKwZOT7skQ7t4voUa3roLx85bdSKTfC+s8k1rupRVBDGk1TJioqCgIf2k
	1gOQRYM09Shptu+PIx6Or6S9JBvw71E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-gSOykprgOr-E9OEPJc_A4w-1; Thu, 06 Mar 2025 03:30:15 -0500
X-MC-Unique: gSOykprgOr-E9OEPJc_A4w-1
X-Mimecast-MFC-AGG-ID: gSOykprgOr-E9OEPJc_A4w_1741249814
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43bc97e6360so1489835e9.3
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 00:30:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741249814; x=1741854614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zsCMTPwBZxgkhOa7brSI6tFSY0lECBrdeb8WRKOM7b4=;
        b=hiq+TI60gH/j3JgpKZnsqZQZBpf1nK97iScfrkSYphh71BbjODMGgTYLNCEBTCCPNm
         /h3muNbmDzAdOOv6iiAIFxBVuP11weh0nxfwvzBbmrpEcRJ4rIEMVzpq0U20yGHO/e+g
         zKySS0JaRq2PS3JyzLVfM4S+J4x1YpLUWkbV0ZT1Ixwu33mL4yJym+LDjC+ifVu/WKXR
         QW5Vn/nPp9PDi6YjDfZbrAxUbLFImzo+fuXKu70oTuen/1qdMHXc4M5mtV3CjTetf2wD
         /a/tLFBi0GVp8TtHNmJ5Z3LcwpeX2H6vZI+Ta9JtG2rfYHjt5or+3rMfUtErWWqt23kk
         SHsw==
X-Gm-Message-State: AOJu0Yyz2SmuBaLADrDhPxqIWK0Ry8OFoEVSFhg5IQ0z5BbsXt08Kdg9
	ekPhB0bnehPwSoIjJreiJHZmVlMzPjhyuVavk7e4PExFJeT4mYVNMJB00w7RJ8NYrC4muxX20Yx
	9IJgduolrIsAQCMsaQi+U7v9JPRuzTZcdwXpGFH8Q+wDhBO2X2LYC0A==
X-Gm-Gg: ASbGncvHSwGS3YxZjIva6AjpIgZ5V7iS8nwppuDts/JglNyxlDQ1OkgU+t5PV9bpwLN
	qgB+Q3Jxww6DCX1OgBVNbwTPevcNvE6e+dB0UzZrH5XrknnT78736Bwr9Bx1vanSkOy8E5RBrHr
	TjSRw128ZUHi3KzP89GhDKsj8PSSiwD18GPiOzvtHVl8rHUPJ+tCWGyaBopIR1QJAHnHRP9BS/N
	H7i919LRql5bjIba487hdTj8puvf+/XOHAEtfWotzJsFZm+VrRwtxRgj76yVTlyvEHV8iTCUT/R
	ru2LFHi3AY8l262cVlU6O01v62yDzG1+b6cC9dMpdhjH1Q==
X-Received: by 2002:a05:600c:5117:b0:439:a6db:1824 with SMTP id 5b1f17b1804b1-43bd29d6c7fmr59684435e9.16.1741249813969;
        Thu, 06 Mar 2025 00:30:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeiiS7g9xPdRasKEgZd17TDJ4YiUIINUR88fvo+ijeTmx55HfEiBGbbv43iFagWinu4311xw==
X-Received: by 2002:a05:600c:5117:b0:439:a6db:1824 with SMTP id 5b1f17b1804b1-43bd29d6c7fmr59683995e9.16.1741249813597;
        Thu, 06 Mar 2025 00:30:13 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8da097sm12217325e9.17.2025.03.06.00.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 00:30:13 -0800 (PST)
Message-ID: <738bd67c-8688-4902-805f-4e35e6aaed4a@redhat.com>
Date: Thu, 6 Mar 2025 09:30:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 02/13] net: phy: Use an internal, searchable
 storage for the linkmodes
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>,
 Romain Gantois <romain.gantois@bootlin.com>
References: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
 <20250303090321.805785-3-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250303090321.805785-3-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/25 10:03 AM, Maxime Chevallier wrote:
[...]
> +static int speed_duplex_to_capa(int speed, unsigned int duplex)
> +{
> +	if (duplex == DUPLEX_UNKNOWN ||
> +	    (speed > SPEED_1000 && duplex != DUPLEX_FULL))
> +		return -EINVAL;
> +
> +	switch (speed) {
> +	case SPEED_10: return duplex == DUPLEX_FULL ?
> +			      LINK_CAPA_10FD : LINK_CAPA_10HD;
> +	case SPEED_100: return duplex == DUPLEX_FULL ?
> +			       LINK_CAPA_100FD : LINK_CAPA_100HD;
> +	case SPEED_1000: return duplex == DUPLEX_FULL ?
> +				LINK_CAPA_1000FD : LINK_CAPA_1000HD;
> +	case SPEED_2500: return LINK_CAPA_2500FD;
> +	case SPEED_5000: return LINK_CAPA_5000FD;
> +	case SPEED_10000: return LINK_CAPA_10000FD;
> +	case SPEED_20000: return LINK_CAPA_20000FD;
> +	case SPEED_25000: return LINK_CAPA_25000FD;
> +	case SPEED_40000: return LINK_CAPA_40000FD;
> +	case SPEED_50000: return LINK_CAPA_50000FD;
> +	case SPEED_56000: return LINK_CAPA_56000FD;
> +	case SPEED_100000: return LINK_CAPA_100000FD;
> +	case SPEED_200000: return LINK_CAPA_200000FD;
> +	case SPEED_400000: return LINK_CAPA_400000FD;
> +	case SPEED_800000: return LINK_CAPA_800000FD;
> +	}
> +

What about adding some code here to help future patch updating LINK_CAPA
definition as needed?

Something alike:

	pr_err_once("Unknown speed %d, please update LINK_CAPS\n", speed);


> +	return -EINVAL;
> +}
> +
> +/**
> + * phy_caps_init() - Initializes the link_caps array from the link_mode_params.
> + */
> +void phy_caps_init(void)
> +{
> +	const struct link_mode_info *linkmode;
> +	int i, capa;
> +
> +	/* Fill the caps array from net/ethtool/common.c */
> +	for (i = 0; i < __ETHTOOL_LINK_MODE_MASK_NBITS; i++) {
> +		linkmode = &link_mode_params[i];
> +		capa = speed_duplex_to_capa(linkmode->speed, linkmode->duplex);
> +
> +		if (capa < 0)
> +			continue;

Or even error-out here.

/P


