Return-Path: <netdev+bounces-108843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3774925FA5
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA91C1F20EFC
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAECB16DEAC;
	Wed,  3 Jul 2024 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gESSkFzJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC9F13B5B2
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720008377; cv=none; b=WWQn1Zsmz08ieMzK5FbVn5vv+iG+OOYBwsg4ikXJGuRDIKKsx/hV7RMYuDJqehmVYyjcbCVqCerOFl/C7is44GDslRVp9PqqdvIMculs2M20tP+eg4vCjbaEGH3FjSVJDuSYUTT9y3DsOWpjcjx0PYDOysLJvPPiDq+bdBtIecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720008377; c=relaxed/simple;
	bh=JVuls2IpRp3ihuNg63JnqrVt0M2mR/bsdIIULNvhMhQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=V8cVNnS0UQ+89rdXU5UoILb1x41i4lN3A95vqmppMKLbNdcmxLc88LjMcICYG9SANU6VHlk1snnfNZgsukByNRpraOSd2Q+9L3ZSjkC+xXVW94vZnXbJQBM10+E42OZdNkI3pipHz/APOoPXlyqjCMLmCH0Cz3xGFcAyOskEuUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gESSkFzJ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36733f09305so2880166f8f.3
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 05:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720008374; x=1720613174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iropvlS1ULsfZa8EM+3IzzM21M1qOq5sJTwOfD7Pomo=;
        b=gESSkFzJrauxuKGL1PaDjBRvR8y44cS8uVPdJKVIZ+unEPTOTrreACB+t4XFEvkZqw
         NQWFix4JgIgmH9XQOEzb1TSUlX/S7E4DIenAtdmcTzL/XD361treuYNvWcNgz1Op4FLe
         OhbJ2/VDej/yu2KKMBQ3GNHsPuu6Lt7l+MHmQeIOp9sQ2azxCTckAKL4j/+kcFzapWeb
         pgJU4tgspv7Zwfhh2EF+d5q0XBR+VoaADFqoItF96i3yTa8mzD78azGi9Qx5tticJ1BS
         OAIBLch1TLkonFIa73Okl3rcQ26OerCPgxZ0qp7cyVqIyEUxMkSrlH6vo7leJ9aYwNfU
         aaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720008374; x=1720613174;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iropvlS1ULsfZa8EM+3IzzM21M1qOq5sJTwOfD7Pomo=;
        b=Gz6xhoV+mXs8WJ1QQM5MforhthHcXDarZqNkUtXceDHJfpQ1YU9ij3yZ0e6N7bSsiP
         YYyO5m2fv+oAHN6Qhw3o6/+lu5QZlPa6zfNnQ5puXyHwnqJYPeE/R3w3GK3bmmbpgASE
         6INlAtlV/hYeYhmANC8RuB8YU0WzQmSN/t20x4TZHnotlRof4lPFyR6CW5JUQN46/2Sy
         eqUO8c+qSUTfg3IC+g8/y6msABaYV4fPuB9opvpw9DEBDEHWRcmH/XPEpV/t6kNaf7b5
         s0TAlr/JflXvUaHc4M6AwNxDpaZiF8kXDO8K5Y3ltwqz97R4TW08il4kkhFE5dGmo01O
         T80Q==
X-Gm-Message-State: AOJu0YwV/RjIF0BSRSMUGdnl9yaMDEtJABCXKF92/ayN46qva+KLcxlK
	cTQjQJHxOo/K0bZoZuo3wXmLxI6+PKv7GLdIula2AxHU4tXCx5N4
X-Google-Smtp-Source: AGHT+IFHwPO0cam5VV93CXEUtPwmq1K7kaS+vEuVS5KwcNiq9Aor9IGE79Tu/VqYkSaHYtpP/ipC1w==
X-Received: by 2002:a5d:630f:0:b0:362:41a4:974d with SMTP id ffacd0b85a97d-3677571b76bmr9055297f8f.46.1720008374290;
        Wed, 03 Jul 2024 05:06:14 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fc4c9sm15708364f8f.86.2024.07.03.05.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 05:06:13 -0700 (PDT)
Subject: Re: [PATCH net-next 04/11] eth: bnxt: move from .set_rxfh to
 .create_rxfh_context and friends
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 michael.chan@broadcom.com, Pavan Chebbi <pavan.chebbi@broadcom.com>
References: <20240702234757.4188344-1-kuba@kernel.org>
 <20240702234757.4188344-6-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <575edb3a-3c52-0bcf-4c19-b627dc99d2e5@gmail.com>
Date: Wed, 3 Jul 2024 13:06:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240702234757.4188344-6-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 03/07/2024 00:47, Jakub Kicinski wrote:
> Use the new ethtool ops for RSS context management. The conversion
> is pretty straightforward cut / paste of the right chunks of the
> combined handler. Main change is that we let the core pick the IDs
> (bitmap will be removed separately for ease of review), so we need
> to tell the core when we lose a context.
> Since the new API passes rxfh as const, change bnxt_modify_rss()
> to also take const.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
...
> @@ -5271,6 +5296,7 @@ void bnxt_ethtool_free(struct bnxt *bp)
>  const struct ethtool_ops bnxt_ethtool_ops = {
>  	.cap_link_lanes_supported	= 1,
>  	.cap_rss_ctx_supported		= 1,
> +	.rxfh_max_context_id		= BNXT_MAX_ETH_RSS_CTX,

According to Pavan [1], this limit only existed for the sake of the
 SW side (presumably the rss_ctx_bmap), so probably it can be removed
 in patch #5.
The higher FW limit Pavan mentions appears to be on number rather
 than index; at least I can't see anything in the driver feeding the
 user-facing context ID to the device.  But I don't know whether FW
 has any opportunity to say ENOMEM, or whether the driver needs to
 validate against the hardware limit itself.  Hopefully Pavan (CCed)
 can elaborate.

-ed

[1] https://lore.kernel.org/netdev/CALs4sv2dyy3uy+Xznm41M3uOkv1TSoGMwVBL5Cwzv=_E=+L_4A@mail.gmail.com/

