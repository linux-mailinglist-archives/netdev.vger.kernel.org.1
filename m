Return-Path: <netdev+bounces-52687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A517FFACD
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 20:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EFA2818A4
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 19:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409E15FF01;
	Thu, 30 Nov 2023 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpuaA+LH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894D0D48
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 11:09:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54b8a4d64b5so1378382a12.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 11:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701371388; x=1701976188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M18k0Gk1/fj/6yEF63zM2Yr67RGDEcrjdLvSk4xIBW0=;
        b=LpuaA+LHWpmDCxzjlh498Lgpm0jzpheXEexO3T7YTqxmNpBd3553njU6naDWh19w2c
         tfhE6P+GieQs1OnG9w7G+PxamCa7DcXfOdsbEloGOH33lW2UNW5iLJORLuQwIG5sZqrV
         h9tz3SZ88BfMIB69tp7rSZ9U4x+BHi8tAl8zARoIwill8dfe0+R2ioFwNNVW/6IFwXpY
         88+X6AUeCUs9jwYlFUKp4/DHwPROUK+ldMiuZDV9OGgC1czm3jPtJRuuN4wnm99ItEUb
         9mxBtrH8+mhmeg/b6hAAJCls1n3ivkZN76Cb2w46mkKdS0UAIkOrVs64a7YBnDHVUu5m
         nVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371388; x=1701976188;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M18k0Gk1/fj/6yEF63zM2Yr67RGDEcrjdLvSk4xIBW0=;
        b=ZtXk/CprU+fN5Gtq77O1hq45mACvMBEXyuZd72E6xGlB6L1Xn3skfEx1RDiMUkxPvQ
         MSTsS2weaBX18Xy9whj+VV19rgqycDaw3XkPCayVacKVMVK7LKPll906/HOJ+mLwb3r3
         vqD7prWViAnVdqwtlf/Q092doJz/J3WjhfMmxGj9THQkaaigTCrniGyLA0790XgcP6r4
         Z2l7G96PTpGu4IcAA8Bl/VvBD7JAjng7BY16sJ2XHklEztF2pU8zLwbLofZgSgbl6U5s
         P/pPQMSIaYDrRsbk7C7JSIwCUZwnyV3qs6hmiIqvCjDy0pCjjzqrD7G8J5LeYjIPfyvY
         DP2w==
X-Gm-Message-State: AOJu0YxcPWJqqakTfeAkVoECm7+vr4z5aVtCnrjhyYLCKrFwWHxC84ZX
	ZWX5CLr3kAlbE0MYuNBayX+3U8HcdOs=
X-Google-Smtp-Source: AGHT+IFpQE7bevW5fLpISeqeXU55Wtc+X12qFdY8w0CiN2HWygSGtw/2EuUIADJ4fiX/VhIp5KMVgg==
X-Received: by 2002:a50:c349:0:b0:54a:f3df:5814 with SMTP id q9-20020a50c349000000b0054af3df5814mr11872edb.25.1701371086501;
        Thu, 30 Nov 2023 11:04:46 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c384f00b0040b35195e54sm2899860wmr.5.2023.11.30.11.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 11:04:45 -0800 (PST)
Subject: Re: [PATCH net-next 1/2] sfc: Implement ndo_hwtstamp_(get|set)
To: Alex Austin <alex.austin@amd.com>, netdev@vger.kernel.org,
 linux-net-drivers@amd.com
Cc: habetsm.xilinx@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 lorenzo@kernel.org, memxor@gmail.com, alardam@gmail.com, bhelgaas@google.com
References: <20231130135826.19018-1-alex.austin@amd.com>
 <20231130135826.19018-2-alex.austin@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <6bc0037b-c3c2-5282-730e-2b5a40122a29@gmail.com>
Date: Thu, 30 Nov 2023 19:04:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231130135826.19018-2-alex.austin@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 30/11/2023 13:58, Alex Austin wrote:
> Update efx->ptp_data to use kernel_hwtstamp_config and implement
> ndo_hwtstamp_(get|set). Remove SIOCGHWTSTAMP and SIOCSHWTSTAMP from
> efx_ioctl.
> 
> Signed-off-by: Alex Austin <alex.austin@amd.com>
> Acked-by: Martin Habets <habetsm.xilinx@gmail.com>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

