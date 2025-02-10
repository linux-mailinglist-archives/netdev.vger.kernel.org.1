Return-Path: <netdev+bounces-164771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 156B1A2F036
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B9B188730C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389181F8BBD;
	Mon, 10 Feb 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NArGeRE/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E921BEF91
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199023; cv=none; b=l7AftpgU0qF8SjMgbdXn0HZVkCzdZ8Hme7QL8q7PaXdp/lrvCqOSJughsA/f0I1RDTCOjWEYC9cFpTSL4LmjeVuRV+V387hYB5Kn+3DlPdz72c73nAqHLLHlMACkNG9W3bGlqujgRYJM5xjgXbq0B7Uj+A/sdk7TxT++L/q2NMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199023; c=relaxed/simple;
	bh=wp6wmbrqjZAChKTl8y/4Kq51nbOadwczA0IQFgBBSQ4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HfBohN62b6TgRnYLu5LevyuTm1GaGqePSOa6XrilS19YFEck5CE/KcpFb/bHfzI3DW+/cM2pj2nbUyjGfPdrYv0Fo+jhSc3oh81iD/BWf+SIUj5uGOMfqPEyOjNc21yf+tNtuekmfyPnGPCmcbW3hzrHxaKZtsF3PkGdegjlqWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NArGeRE/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361815b96cso29852405e9.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 06:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739199020; x=1739803820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcphbmqkIIdPEWHNIfdnN6TAUXLGgnTab4JgK3F09KA=;
        b=NArGeRE/TeKhyDDJ/lo5UQ8f6dHUTRqts1CJigcQXnZ8EFt/SZ9Aik5ZESJaVMYdBW
         OCJ/g71bh1TCmwn30o7uke1SaYL1x24S2kTsMzqt0MVn1cxcpPT5dM+TK921+sdt9em/
         GcnaR5hZfFAgqbRv4N7qIXvsAPYtB6ZLs+pIyaMZU3mMXwDTKq2KYP9bY5zCEg5yA/5X
         VTp4DcoOMyY1egruO+t/dmBsOTpWUrsi1T2QKngt2VQ9CXTHN6wv9CaAI69/FQNXiPqh
         Eg9iG8VFfIs5VheCz6Fu6FnRlxyX0IBNpl5wIzrgp4+ErmEyCLoxG8dabiayeJOTwnbO
         pmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739199020; x=1739803820;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcphbmqkIIdPEWHNIfdnN6TAUXLGgnTab4JgK3F09KA=;
        b=ikMc77xh/Gm4c4t2cmq3bQotvZ/KnCLo1eSYbia8EnsnflaE6hMCK2GgRU/FtOhBmF
         UJaurDNx0GrLrXl4QeRjMb2LZSFgJhr8HCxBhd9EPZQ/n84qF6nComaYmstwo7vDYcA3
         h2igADHEWhnCkD0zRRP+jbDLLd9O3NXPNzpMWMlJnFq4IClYtp0pFZRvSfPTQ72CY0rO
         82COmLwezP+OmYanOZPHb4c2RgWWOgBmMc0U1Nmpa8O4DlvHpgopPtwV2fHgiQOFQSh7
         z5u2Zkjg6jCzc88Cb+cUuum8a+Lwuw4bf+LqyyISPRXV/HutlebPgRV/IPi+2CpcQfZl
         /j3A==
X-Forwarded-Encrypted: i=1; AJvYcCWraUTUSQErizs+vHlHQgPUCXkcmUEk1/YjhpTQFDYKf+uNjF+qCwbRce3evJky/6h3njeA0B8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwmdQtRlklmWY5LX6x1IthCZAbW3ctvwYj69F4vgsUDUks4X7e
	2jmKK3bbnVDvM3A7xO/BVcLfoQ68Byih+7V/4cWqfDkPbCKP8rNE
X-Gm-Gg: ASbGncv9gDkHhuqFJxpp5OcYFLDKKWrMzdfIrizo4AlWLWhVlDIXTLcPOfWxq6ZMAUY
	VY4FIb2YZ12cd0vGC9npYuBz9hC12OKNMGERYyAYt/KUP2zAzxnTH+FptEVKA/6grEY/zoqe4Hj
	eCzwuy8V+stsWePImajAcKtvzXSohwzGs/Hc9FJqxW1OxOj6jCM3BHUqaPVQKP1z4qqc+RoyMJk
	W2yIYxRuren5RyChDuLPcBn6GVDy1+ZEv7IQmQzFzO8ffs9YZEfLnoTcqU5JYZk39/EblZLH/UN
	PjLFb/3nrUIGOcB+grXXG9qeM4g6gS/It1Oi+T9IgP5VW5uIM8xSJu7syT7ucpRJxot8alnuWle
	z8VY=
X-Google-Smtp-Source: AGHT+IGbEF6Pvt0mIo6bYTqLTOnsdh0UP8aNgoO+J861Qaqwo+HVnKMoL3rH82oFknZA/uMNkWWhVw==
X-Received: by 2002:a05:600c:3b86:b0:439:4696:c071 with SMTP id 5b1f17b1804b1-4394696c404mr25810425e9.19.1739199019508;
        Mon, 10 Feb 2025 06:50:19 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd07fa80csm8296986f8f.13.2025.02.10.06.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 06:50:19 -0800 (PST)
Subject: Re: [PATCH v2 net-next 4/4] sfc: document devlink flash support
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, habetsm.xilinx@gmail.com, netdev@vger.kernel.org,
 edward.cree@amd.com, Jacob Keller <jacob.e.keller@intel.com>
References: <cover.1739186252.git.ecree.xilinx@gmail.com>
 <3476b0ef04a0944f03e0b771ec8ed1a9c70db4dc.1739186253.git.ecree.xilinx@gmail.com>
 <p527x74v7gycii3qfgcqn46j2dixpa62tguri6k2dzymohkeyw@rqqmgs5tbobj>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <116cc011-4e4a-12c9-0cba-3097c6e85e0d@gmail.com>
Date: Mon, 10 Feb 2025 14:50:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <p527x74v7gycii3qfgcqn46j2dixpa62tguri6k2dzymohkeyw@rqqmgs5tbobj>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 10/02/2025 13:51, Jiri Pirko wrote:
> Mon, Feb 10, 2025 at 12:25:45PM +0100, edward.cree@amd.com wrote:
>> Info versions
>> =============
>> @@ -18,6 +18,10 @@ The ``sfc`` driver reports the following versions
>>    * - Name
>>      - Type
>>      - Description
>> +   * - ``fw.bundle_id``
> 
> Why "id"? It is the bundle version, isn't it. In that case just "bundle"
> would be fine I guess...

bundle_id comes from DEVLINK_INFO_VERSION_GENERIC_FW_BUNDLE_ID in
 include/net/devlink.h, which git blame tells me was added by Jacob
 Keller in 2020 as a generalisation of a similar name in nfp.[1]
Its use in sfc was added[2] by Alejandro Lucero in 2023 but seems to
 have been left out of the documentation at that time.
The present patch series is merely documenting the name that already
 exists, not adding it.  Changing it might break existing scripts, and
 in any case would affect more drivers than just sfc (it is used by
 i40e, ice, and nfp).

CCing Jacob in case he has anything to add on why that name was chosen.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c90977a3c227
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=14743ddd2495

