Return-Path: <netdev+bounces-206870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A49B04A81
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C65627B3C3D
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B42E278E75;
	Mon, 14 Jul 2025 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4i27Pt6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8225288C9C
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531566; cv=none; b=ff9c1Pl6NftG+OlK7zYWgEyO+wXhG7kxGx0A4cg1WLqIPJP6ywz0a0bRBBulHyl+RByXlIiZjVmV2lRrYAB7wfoFZ+tUvgfb31mA1QRP+WHisdm9rmLGnPfliMwO4w4SceDO2Jyb0S4s8frZiW2GRbrQTXBbuZh9L4oRR5681/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531566; c=relaxed/simple;
	bh=0vCmzadEWXoElFAc4Pjn+I40OQmJKNgMtG6iMe6iBtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7rLHvMlDUVKhr0akFeN+yRb/t3qft9TwfS3TWGpjsf7ybff2zj5RYkQ65ySoMVk56lpQbzOC7/63EeYu68o0f8Ve7Os7cmSCc4aRDrYDGNy8jgmAw+97/LTllp3SZWljmCna88PNHuPw9wh6mv77/WeTstHXaLkObywwheEpX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4i27Pt6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-455fddfa2c3so25533985e9.2
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752531563; x=1753136363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y36p8ETA+RGPd11WkmhV9BnNZVxUJM7V6bzyiXHPjm8=;
        b=m4i27Pt6BdaL8UB5QZVp5k12eYPg1UHtQJUMvDTzU2i1L8pyuilxX34P+yh1HY2lEY
         veUyl6WitQHOxfER05B68L7mQVWlL5ADkfZWDpLRr1YkIW8oosvcah10I5QLkp8SrWRP
         h0e/6GLpgM2A/oW2GUzdoBz4O+Ur0IzYqUHHDvUUZXcblQ7pu3Fyxg3iRL2KBeDl3BzL
         4sAlvFph4cu8wTjJutW3U7GoRhyY+0k7TBCfOJBCTB9oDdjniGBelQwv2Ar/cTNJjybV
         xAGMU7QfyobxsnxoYwKqOJ0t6xClJTpW7r0ysUUCWte5s5Wb3WC3ldsv41SHtk7neoW+
         vD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752531563; x=1753136363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y36p8ETA+RGPd11WkmhV9BnNZVxUJM7V6bzyiXHPjm8=;
        b=rnEn0s825B+6SreEfJs/vY9yzNj+ko7/LaoHn7yTSzJ25MXjKAUsLgN0P1zcItazIM
         I1Zmj99KxelryRZqp8/aa6/mhvlFqlOAiyBkJxY2wvkaP4t9INKEnAopnETYfhvX65NS
         BYzxaharxkHLymiRSzZ0JXtITragSva6ko3L9lRNtF3Axnq/1Kto1Y/jwD8xVglO1czA
         pr6XQzWFjbpkIZU84ZlPmFkB4Iz+B2CKRDPLiMF2uyVBnsWhQumtyXSnKM0+qpXZm9d5
         p5/Z6izVM/IFD8K4bzRMTBpz7MmfHQXd9WYKquidn1WusbFRdw8LvAmcheLbbgVDbYZd
         BJiQ==
X-Gm-Message-State: AOJu0Yw5+MtexsGPJD6C8r8x5ltWgkcixRcbLsUzZAn+jMuf2Hng9JIj
	9DId43uE30/g/4eBm7qf9V63xq6Yhhkd6l8H5IlaqXj2c8iarKDj693a
X-Gm-Gg: ASbGncs+XQGZaRPeMgO9BW3FUO5tddOBvvQmwnJEcrxAkdOMElhJjkqwQ0/dDVnaJB1
	yZjK+jPIvvC1OEE2vb900Hic8fSDtJ+K/feA2xd0kUvjxnnvDr8jnId7aD/4zChMgo/e+/paPN6
	Fjq1difPs3U13ASc0cQqpA/660Fhn8zYG/qmRNNabNBSa2N0sRiDf2exKedN19SarQ8gpiPWx9P
	XXz3sTLc6kKXXWOVj3TE/Hy98T3QGS1xJJQW+Nyt2/rVBSWjHkXi2DFnYbs+mcQRUICHY2kn21u
	8oLxSJXsja7WRxT4OknsDSEl70OUdwXl2B3te2ENsHcileRwlBXh9HptYQX4znwByxdzuBIPIwz
	GJXGGcasn8Mp9brduwvP0sXdjqXEQkZukybxQrsn4zoMJYg/SEzlEfuJDT4ooR26qV/zOetk7hq
	9kmzef5V7WXg==
X-Google-Smtp-Source: AGHT+IGnLum7RIDMZmZuwfEEPe1YBE4EuFvZFEAJHXCsTeNceifpETYz0KklFcyLIeqt1hDjJ2pljg==
X-Received: by 2002:a05:600c:310a:b0:43d:4686:5cfb with SMTP id 5b1f17b1804b1-4562751c28bmr2315635e9.27.1752531562671;
        Mon, 14 Jul 2025 15:19:22 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1924sm13693368f8f.16.2025.07.14.15.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 15:19:22 -0700 (PDT)
Message-ID: <d0d2439c-3461-4be4-9014-70c93ab9a1d2@gmail.com>
Date: Mon, 14 Jul 2025 23:19:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/11] selftests: drv-net: rss_api: test setting
 indirection table via Netlink
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 shuah@kernel.org, kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 sdf@fomichev.me, gal@nvidia.com
References: <20250711015303.3688717-1-kuba@kernel.org>
 <20250711015303.3688717-5-kuba@kernel.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250711015303.3688717-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2025 02:52, Jakub Kicinski wrote:
> Test setting indirection table via Netlink.
> 
>   # ./tools/testing/selftests/drivers/net/hw/rss_api.py
>   TAP version 13
>   1..6
>   ok 1 rss_api.test_rxfh_nl_set_fail
>   ok 2 rss_api.test_rxfh_nl_set_indir
>   ok 3 rss_api.test_rxfh_nl_set_indir_ctx
>   ok 4 rss_api.test_rxfh_indir_ntf
>   ok 5 rss_api.test_rxfh_indir_ctx_ntf
>   ok 6 rss_api.test_rxfh_fields
>   # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

...

> +def test_rxfh_nl_set_indir_ctx(cfg):
> +    """
> +    Test setting indirection table via Netlink.

"... for custom context via Netlink"?

Apart from that LGTM.
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

