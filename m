Return-Path: <netdev+bounces-145228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 181AD9CDC4B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 11:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17852848B8
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 10:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B1F18D649;
	Fri, 15 Nov 2024 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIPHLGzL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6018D626
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665736; cv=none; b=JY/DQ6FF/XlpO3WtAl2rvQ+3A91CB9FjVaXR6duxHjZCBE6PCICwBxmC+T9cy40NYh8NApeNMWxxNi39f9fzWKPOf/e4U0AXbMyiYj5bORzJqjbjSn0R1PNpUvlVHfQxcJtuBi7zrMWsuFevnZY8I/QCsH7e6IU0BpKiab7MK/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665736; c=relaxed/simple;
	bh=qWFEGKKhiPUHHrJSnP5ZKUCahKe/BmX7/jamRiZlxCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzbOrYm1UL+Wz7O0qipTjDwMRSI/oeB+8wH/LmlD0h6LzGeCx7SAakiiDd+AKWUhS2fAssewPLh183/5Qdma0fQ3TfEogpM8TU2vpFfa7lN4NCqbvPG05X4W+ENFhEPC3+1tblhFaPUnVb/QrbEcGxumzOVHEHj2yyi2valCb4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KIPHLGzL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731665733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nm+TFFx/PBF2d0vt3Kc4TRup6U0JUm8/XpjtD5qqlsg=;
	b=KIPHLGzLs++VYd+1rL1k0zJSUawqTZw/nznMuhyaE0v3HzgJ2p+0VekWyWzHSmWVTZU8Cr
	hMjVgnEvIEDuywkwMr8Exa12S49pbQTl2SWKu0km1TXkzWT/gMdqEpTdDe9JtqQ8gLrsaC
	AnnbUau9otV1P3gxlxCPODdmdjW5rVw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-WuWxTKzUNpuwCdcCzc76rg-1; Fri, 15 Nov 2024 05:15:31 -0500
X-MC-Unique: WuWxTKzUNpuwCdcCzc76rg-1
X-Mimecast-MFC-AGG-ID: WuWxTKzUNpuwCdcCzc76rg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315dd8fe7fso14979595e9.3
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 02:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731665730; x=1732270530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nm+TFFx/PBF2d0vt3Kc4TRup6U0JUm8/XpjtD5qqlsg=;
        b=uIgHXUAi2GcGk5iGnbpEWsolIoqJ2Twwrgh2RLdzzKCBwvxpp2OWwymtYvJ5jc6v85
         y18zrxia8RlyyfGHosif2ivQnGWHzLvP762b52Xg1QffjR8hUQHMVmfIhbSWC3tCloNH
         aI3WK9zu/eGwLevco4iMhXYCt8gTogwYJ5+iHKP55isdX/mSPIOHtCQZFTSiWhuEXAiE
         5dIVDXJuFXMGf3/KBizy1rUPpG58r+rgAJOkSw8uaRaSd97a42E31MYCfx3otqDyHj+V
         2OBtBk85akiF2lQw5Kys7SO0XSka95tzPJSpLNzKLMdhrdsSEc08GaLx37s9FfomR4Dc
         S6qw==
X-Gm-Message-State: AOJu0YwCICQuLYAUpwixSadiO8s5oDk01DfmXiNTxmb/TItprOliGS1e
	TJXzTJe5S81OB0XhFRcHVylonXStRQHMVXsIkmFwAyCo11c+oH1j5RsBIw1xvbc52D8H3y08uxS
	XUuXVFlskA+qjkbUJJes5NtmS807Odz4DsffdJ7aJyUVjWhiTMOpnjA==
X-Received: by 2002:a05:600c:c8e:b0:431:54f3:11ab with SMTP id 5b1f17b1804b1-432df793c07mr17267765e9.33.1731665730133;
        Fri, 15 Nov 2024 02:15:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzirhbkRJCDLFEr3GTD3L93dBFCyN9udF6PPhtZRzJKRDASOqjGLfsFYqYRW/hsHP/E8k+8A==
X-Received: by 2002:a05:600c:c8e:b0:431:54f3:11ab with SMTP id 5b1f17b1804b1-432df793c07mr17267515e9.33.1731665729771;
        Fri, 15 Nov 2024 02:15:29 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae311fbsm3902704f8f.95.2024.11.15.02.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 02:15:29 -0800 (PST)
Message-ID: <6e5e26b7-9682-49e4-bc2e-7683967a8c78@redhat.com>
Date: Fri, 15 Nov 2024 11:15:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 3/8] devlink: Extend devlink rate API with
 traffic classes bandwidth management
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Jiri Pirko <jiri@resnulli.us>, Carolina Jubran <cjubran@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>
References: <20241114220937.719507-1-tariqt@nvidia.com>
 <20241114220937.719507-4-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241114220937.719507-4-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/24 23:09, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Introduce support for specifying bandwidth proportions between traffic
> classes (TC) in the devlink-rate API. This new option allows users to
> allocate bandwidth across multiple traffic classes in a single command.
> 
> This feature provides a more granular control over traffic management,
> especially for scenarios requiring Enhanced Transmission Selection.
> 
> Users can now define a specific bandwidth share for each traffic class,
> such as allocating 20% for TC0 (TCP/UDP) and 80% for TC5 (RoCE).
> 
> Example:
> DEV=pci/0000:08:00.0
> 
> $ devlink port function rate add $DEV/vfs_group tx_share 10Gbit \
>   tx_max 50Gbit tc-bw 0:20 1:0 2:0 3:0 4:0 5:80 6:0 7:0
> 
> $ devlink port function rate set $DEV/vfs_group \
>   tc-bw 0:20 1:0 2:0 3:0 4:0 5:10 6:60 7:0
> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

I haven't dug into it, but this patch is apparently causing netdevsim
self-tests failures:

https://netdev-3.bots.linux.dev/vmksft-netdevsim/results/860662/4-devlink-sh/stdout

Could you please have a look?

Thanks!

Paolo


