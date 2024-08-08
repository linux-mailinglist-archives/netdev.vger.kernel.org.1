Return-Path: <netdev+bounces-116804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4754094BC44
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E917C1F21959
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DE518C320;
	Thu,  8 Aug 2024 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJ7YPhOR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598AF1891AC
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116382; cv=none; b=mOLgQ2+QEJckF2lhH4Q2ro3ok+iere5pbz3BdfSR5NL8EMwGWzJOGNVhYoZPBpIGJNcxt8hAW5CIUOda/XkHJVPtgtvsgdMYeVgg8o3L2UC+I/ggYTYmX6xUEDuNtSLAMpMQwJvxmOsn+BKU0bb10jumAT0kRpoQe3W86Ho6rIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116382; c=relaxed/simple;
	bh=4MPStt/Aou7/jjN06Dzsl7qUotnMswEnllTqALn4+uw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=X2Y41P9TD8RdWVXIU/GyjwsD2oWrgvMpXGmKaqIzHL0YXE+RytSBx3tPq6AfetVAMnjKkBXXWsQ4TPRgKqJQBhAIQZPkT82imdFD7bi24dsy1YcWHXDNNGgYudpgSpV6vH69+BVsc3ZUwhailhGPmLAt9y03oa06F0of8fab7nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJ7YPhOR; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f032cb782dso8695141fa.3
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 04:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723116378; x=1723721178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6RLspPD4tRrDsi2nTLdeFo1tIoohSLWQKDZalACeHw=;
        b=SJ7YPhORWBvzRU7OwVQHFtuTFhhZNGdudtieOB5rWpm8eHjmJp6XpB8Hfoix7tq36q
         6KOqC/xlxz8B1C3i+YsgXhR7jWEbQi5Ifvq2yhmVtRAw3rv1DFL+lYVGqAgsqrngNoF6
         2Lh3NPKgV+3IJvGPnkes1ZqeV4OaP+Va8blH0PeuSnpuC2j85iUXLuIhC9exL0U1LIOl
         zckIlQhy1SFt2fCPIYcmfGLJw6iNdCKkgeYpWvSpdlLPBkrAnPvg4tu65vbjMgWl93UZ
         mdETUqEQIebpgCy6Kr65Rmjk9EViWmTkdYugZb7KGi0CJuv8KFPqCP9DyahqAAVYIN+e
         jhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723116378; x=1723721178;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6RLspPD4tRrDsi2nTLdeFo1tIoohSLWQKDZalACeHw=;
        b=sB2Ccbe3i0pmdYi508wGbmOnRVrAUxa1iXaUY9zacr0tDzIQKmZfk2TBz/pS7lyzkl
         GiUxqL1OPNnmSiOCrcGpTcf+EDKPlP9TpY22ZEr4i2PHuozLKZbUAd1LBvVeyb4Nh9fE
         Lzk5A5jUPolA+wJvy7eXBRGyh1umSdkG6A8dylCfWZy4KCU9z7ZW9uhXNbkJhNjtYlxZ
         WqyBJB6l+hU4uHhIfbyMeEmsaYQjzpS5m5Ub6T6Z9/ZMfvdENYSWJFM2MEcAG5Y1xHBn
         PXAMtulmZzzml6PZUwVuUiVfKT5a+h0kQTJBZEuU73EwboWcYj/6mTec91Nu6V6eqF4T
         YXfg==
X-Gm-Message-State: AOJu0YzEYMODSu5WhxHed/W3CB/CZs0rZLjzuTGJeD8OWsUNBLrjeDRM
	ORQUWx6OiS3iirKPkU+hG3bkMCG/Cty1OcsWavrXiLBTg534YFNy
X-Google-Smtp-Source: AGHT+IHxAjGJrI38J6KmXphRKWwxzo7LRQo5XQuUNLhgge4hLTs0Q9aIhtQdXfRmcIE8esHKKV5Qjg==
X-Received: by 2002:a2e:4609:0:b0:2ef:2006:bfb1 with SMTP id 38308e7fff4ca-2f19de2d1b9mr11880451fa.15.1723116377854;
        Thu, 08 Aug 2024 04:26:17 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27228ea8sm1565960f8f.93.2024.08.08.04.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 04:26:17 -0700 (PDT)
Subject: Re: [PATCH net-next v3 06/12] ethtool: rss: don't report key if
 device doesn't support it
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 michael.chan@broadcom.com, shuah@kernel.org, przemyslaw.kitszel@intel.com,
 ahmed.zaki@intel.com, andrew@lunn.ch, willemb@google.com,
 pavan.chebbi@broadcom.com, petrm@nvidia.com, gal@nvidia.com,
 jdamato@fastly.com, donald.hunter@gmail.com
References: <20240806193317.1491822-1-kuba@kernel.org>
 <20240806193317.1491822-7-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <79a5e054-4110-3730-377c-b7797e16292d@gmail.com>
Date: Thu, 8 Aug 2024 12:26:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240806193317.1491822-7-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 06/08/2024 20:33, Jakub Kicinski wrote:
> marvell/otx2 and mvpp2 do not support setting different
> keys for different RSS contexts. Contexts have separate
> indirection tables but key is shared with all other contexts.
> This is likely fine, indirection table is the most important
> piece.
> 
> Don't report the key-related parameters from such drivers.
> This prevents driver-errors, e.g. otx2 always writes
> the main key, even when user asks to change per-context key.
> The second reason is that without this change tracking
> the keys by the core gets complicated. Even if the driver
> correctly reject setting key with rss_context != 0,
> change of the main key would have to be reflected in
> the XArray for all additional contexts.
> 
> Since the additional contexts don't have their own keys
> not including the attributes (in Netlink speak) seems
> intuitive. ethtool CLI seems to deal with it just fine.
> 
> Having to set the flag in majority of the drivers is
> a bit tedious but not reporting the key is a safer
> default.
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

