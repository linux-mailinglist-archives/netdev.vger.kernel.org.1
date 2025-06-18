Return-Path: <netdev+bounces-199118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02478ADF031
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23383A2D2A
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AB22ED845;
	Wed, 18 Jun 2025 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vi9OcuaT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CF72ED84A
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258247; cv=none; b=Ylao8Efaratmq9Qg/CM3T8yCEusrmPHzdIBFThns5zToV6SHAwQ9aU8I0SRWFebTSa4R8s7YOxjAABALwjIgdW32nxh+55DxlwKucGwFkv5jH5895gp+pUCH1UF4IXsX6+ymOKG5Ge3e2CRENhHFps4nSsiXfu/KqGgPTfaGbd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258247; c=relaxed/simple;
	bh=FTZI+35CUH3Vwm5T5v8vUzC8w3+Hik4FJbp6cgbjx6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eAs++mAwqV4NQKq2Sp3snhGFWW8TQJPT17i7fVcjZXRdIoiGFXxzm+O4c0IcLhY29OLN6kOlokAj87y4iEJRjomoseMBJiJvCdDQ9YMNaHBhLCbmbP0i7ccb04VoZ/PKXuvXSmcsqKma/ReHAmy6Y36YOK4zNEozz5nLOMT1Uxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vi9OcuaT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso4761997f8f.2
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 07:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750258244; x=1750863044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gdvjqZttkX4vPnSqKRltijVeXS5VJSqdhhH0wrC+31Y=;
        b=Vi9OcuaT9w/2ivTE6u3m0cJobxsaCivUX4okGq1NBwxOH/Wg9u8dWUqu7E1Wfm7TqM
         YS0MxzPzX7kTA0g6dpSJTQfZezfPXmiGed20LZ/Qe+iP+sPMAXr8hmIliMecr2PyFnqk
         H6VoaRMAuE9qlOwiq704M5lKSjHog9TGtCeHt9Xv233ehFcHQnGH3pc562HRYcJcHiNd
         RYVnOaKuUHmTTN8C/Q0O2MPhb1QRUzSqxkPT4Os5bMUsaj/UraOqvJwy/f9e/uoKMvbV
         Vf4AoFiyrm3fzmMW62Sw58Qku9eiTvDpCCU0cYZ7YkwnGXPGZ16guyQuGZjjGYIb6NyL
         C6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750258244; x=1750863044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gdvjqZttkX4vPnSqKRltijVeXS5VJSqdhhH0wrC+31Y=;
        b=a1w7xrFFi07g9Hpqz/L6jNXxFGiZ/6r5RkY1H0rLWAkJ0DuIN3EAPc4x/EwcicJX8A
         AJy1JA30DhjpGciZWlT6LhCJoH3JBukEpnOWwfy9XWoM/VEHhKZMw4w3TxXKE8yYsID1
         3vwpDD30/vxzTrqWBufIniyfE2pUmDv+TjS7dzYL184MzmSFVOKoRmUDCCGu3+t1yIbi
         6PNtxAzSu6hweAgOufu1EK0bCIoDdIgX3rMZC1h1aZSzxqzKmhS/xj46/lfG2ZgeUdZ2
         lyDFYictL4HUqI0vQZzi+vE0lL9g+sOaZ5S1Q5cAZ4vNhrK0ssje+u0ZMcoxQkYAb8gf
         HRfQ==
X-Gm-Message-State: AOJu0YwqBRauDjKdVH+eGHfQgu9VSd8MT6M+IgHL5PGJcOba7am4UCO4
	DdbqC0o9IhtGTqd7ZIC2NCFErjjleYQdn5T+2ry4bmvFK1Ju5YSITHQ4
X-Gm-Gg: ASbGncuQQpOsRi3+BjuvI/pSL46u+Iw4W5wTJqN+AqZimBINrithexRhnr1Fi4Ot1x+
	QEEqK0pbVgtnUVRcBDuQqOpX+NnZDMhRls9HJHA7mNL3qM5WXB/kxXOw1BjxPK0Zg3F+80NQxo5
	Eyk3k1Ah5oWEP9OAtSR1nKJ/DonJ+aO0q6f0HsmXr9rM/JhfTcC3UZi7RCsWvHnrwPRcNY6cPwQ
	PmCMDK34t2/8OsLQRCHNH0YeEP7WLEhMWNYaD0W1ahuhI+riJBYV0odQRMEIxIa5Genqh4EeXAb
	KQW0Ra5TagTA/4BmoZ47xRqzKPw1w8gtoe/JQdQxqcbQArXfcX4pdohMebnxgljsxMj2cQWe44p
	j7mZjzj3F+6x4a7vNF9Bo1Ffciap1po5mbF/htJJgQgSn3ogUwA==
X-Google-Smtp-Source: AGHT+IHQ31DcldcD5muJE+n7Ema6BCmfiTg0B5cm1rwSF5/biWEvvhSDKFcoC+bP83uBgrIitDxHTA==
X-Received: by 2002:a05:6000:708:b0:3a5:5278:e635 with SMTP id ffacd0b85a97d-3a572367577mr13426078f8f.3.1750258244123;
        Wed, 18 Jun 2025 07:50:44 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2522b1sm206131265e9.25.2025.06.18.07.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 07:50:43 -0700 (PDT)
Message-ID: <4b85ec94-7da5-493c-b54c-0cc5579f24dd@gmail.com>
Date: Wed, 18 Jun 2025 15:50:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] eth: sfc: migrate to new RXFH callbacks
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
References: <20250617013954.427411-1-kuba@kernel.org>
 <20250617013954.427411-4-kuba@kernel.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250617013954.427411-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/06/2025 02:39, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> This driver's RXFH config is read only / fixed so the conversion
> is purely factoring out the handling into a helper. One thing of
> note that this is one of the two drivers which pays attention to
> rss_context.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

Although,
> +int efx_ethtool_get_rxfh_fields(struct net_device *net_dev,
> +				struct ethtool_rxfh_fields *info)
> +{
> +	struct efx_nic *efx = efx_netdev_priv(net_dev);
> +	struct efx_rss_context_priv *ctx;
> +	__u64 data;
> +	s32 rc = 0;

this could just be an int; it's only an s32 in efx_ethtool_get_rxnfc()
for the sake of the ETHTOOL_GRXCLSRLALL path which uses it for more
than just 0/negative error.  Up to you whether to change and respin.

