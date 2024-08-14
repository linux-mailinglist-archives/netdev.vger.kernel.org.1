Return-Path: <netdev+bounces-118437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AE0951994
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0961C216F0
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE6E1A76B6;
	Wed, 14 Aug 2024 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2Z7IHw8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36929139CFC
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633460; cv=none; b=JEWEy4ZjRzEUy2lZ2skz2lTyyLcCwNf1KSTsR0Ev0IkkJsAm38ScKsnN2IQVSS3hLByYIF0F4p0TuWr1U4J0hkzyTf6a5h1zXFH6gRMAtPF5d9/7Qkh7sfdp/Y6h7xbxYMuOFEBE8HN4iSdzADZjboiIrzHBXdyVzVCoP8FkEnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633460; c=relaxed/simple;
	bh=v9st0O5N/V9za5sr/9HrlMObvcdY4oGdvn0cSd/+J5Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Lukxmtc2OtKyYZrXwISRXQh72g/Cqkmf/rnNM8LVKy5+IRQ+Fqdyp8FptgTyhC7UsLbtmmCReFhz0PqVFSXmUJML7OLNkl+ThqUIPbhXWf7gaIixqlDfyCoV/7vEC0d6KhdcXUfuLLoeAOmuni7oFTYauB7o5mxrZd00+4y1s/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2Z7IHw8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso49708635e9.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 04:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723633457; x=1724238257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8CpXDqSij4nMC6woFE3cNeSkGpZmu9XT9izw6nNk84=;
        b=m2Z7IHw8WUmQF4P+sCNGGRaw2Qas1FQBCFkGM8VF35z7+LZdYsq0QoJscWJOuaHPIE
         kVYjzVt3pqNZIGCrrRm+giOaFTwYSxw/Ql+r52flYb+wuaVDrLB1U/6gz/s/39JSADnQ
         mlM4RZ4y2zgGbv5YM5uRBLxuEy4IOCkJSnTD8bz+MD5KI5fqsBpuR4yzmcTcE5Cowou+
         aQjMCM6WXxcQ98VMolugk+NlxLqcr79LX8xFi1YmczZvdCGSodulPBjA+iBhXxpz1UH6
         C8YIiyNudVKrm10cdfeJtvvIT3KJhVprssmn+1t+0rZ4eOcV7ZwnOp8J5OdCdXx6w/x2
         tN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723633457; x=1724238257;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j8CpXDqSij4nMC6woFE3cNeSkGpZmu9XT9izw6nNk84=;
        b=bKI+CGalMCgT8PIAyobHwUqStWs5aeZvvj2U30rdjKq5TpOlJ5gVllqUfk6p3SJKEh
         QLu6i751q9b31Ukx1cJP58oPsoPmuMrDociutuXs5p3u06N7CO2bkp9X5urBx2bDPn6q
         DuveCuwHVYnmqkyTMylNIPadjE10Zf2H2ocfCfwkMStv4tbdNGeX4VyzlaCwsvtJ5TdM
         /CIZcTQJSmP3X0JcY0OY4cm3BXuJUGeLl2F6vEMC0P67yHfkQLrsXb65dzfG86L6ypx5
         l5q2PxzDnVBSLojPOKNXy5oyvTLVgfoOpoeXkI4fLxVTddN7Wh4nBytnZKrCywNsT9su
         aFng==
X-Gm-Message-State: AOJu0YylFy+SA1368UbVKOXenWVISkkg+8Nbf27mcjtUtpo/f4ALk5IM
	Wcrs7GK9pyd3eWcAKB0jFEK8BJWhYkbc8N8Lz6Q6YOhZ9voPwlKF
X-Google-Smtp-Source: AGHT+IFtBWWQ8PQLabcD7RcMkdugeWZ6kY0fxS73DN03z3UqeZw0QN2XY4iu+kvlNhlPaXpZDIt+jg==
X-Received: by 2002:a05:600c:3103:b0:426:5ee3:728b with SMTP id 5b1f17b1804b1-429dd236442mr19024505e9.13.1723633457216;
        Wed, 14 Aug 2024 04:04:17 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51ec46sm12586812f8f.81.2024.08.14.04.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 04:04:16 -0700 (PDT)
Subject: Re: [PATCH -next] sfc: Add missing pci_disable_device() for
 efx_pm_resume()
To: Yi Yang <yiyang13@huawei.com>, habetsm.xilinx@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vladimir.oltean@nxp.com, alex.austin@amd.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com
References: <20240814092946.1371750-1-yiyang13@huawei.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <3e52b10f-ad28-7927-fa60-f00755b32756@gmail.com>
Date: Wed, 14 Aug 2024 12:04:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240814092946.1371750-1-yiyang13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 14/08/2024 10:29, Yi Yang wrote:
> Add missing pci_disable_device() in error path of efx_pm_resume().
> 
> Fixes: 6e173d3b4af9 ("sfc: Copy shared files needed for Siena (part 1)")
> Signed-off-by: Yi Yang <yiyang13@huawei.com>

Hi Yi, a couple of questions.
1) Could you explain in more detail in the commit message why this
 is needed?  It's far from clear to me, though that could just be
 due to my limited knowledge about PM.
2) Is there any reason to only do this for Siena?  AFAICT the ef10/
 ef100 driver has the same code (drivers/net/ethernet/sfc/efx.c),
 so would this change also be needed there?  Same goes for Falcon
 (drivers/net/ethernet/sfc/falcon/efx.c:ef4_pm_resume).

-ed

