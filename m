Return-Path: <netdev+bounces-54288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A8F8067DC
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 07:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355CA1C21185
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 06:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AC012E4F;
	Wed,  6 Dec 2023 06:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fUSpwS4e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4264ED64
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 22:59:26 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b8b6acc3e7so2430230b6e.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 22:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701845965; x=1702450765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfqEHLbUHYLDNr52xzISlLf7TCD393bK+BO/LsCYG3E=;
        b=fUSpwS4eOnOAGq42BJJsGCIFQ/B9Irk8wkv2pvh7rJyakFee1e4KO8DdtpUFyjdN+r
         sdVnELKBo3QYdv7oJNjDF+4agJYjC6tatCCmFX6PtdIO4rNeVxwMLE5Kw3QAV8rz0nJY
         beM8rT1Vpqtn4aQtoa1uEPj0RtXgzU8LBT4FI2djrk7E40kGkpuU1A9K4LtS6P4NazX2
         HTC4oHMjiQfOdXlXuL1GU+bOWZHjNz1ZNMVUsPWoa7ZKeeznBEHD8bamwsBaZT4eam/O
         9CWxePrrvOcflLCX95Fna7WJP6HCkGFxQiIeAjgzk5J19coUht5SLUeubOGVKSMS1l28
         XPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701845965; x=1702450765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sfqEHLbUHYLDNr52xzISlLf7TCD393bK+BO/LsCYG3E=;
        b=Yv/nxB7+h5yPxXonjb8NGrtZ+KloCkbEP7JOVb+xPQqEiuj14J1Mnsp0+yGEeRxphn
         DUTgdDbTDhim2KwVhPqzPuH0qu3HbKF0Wp1BigUAwiOVbxy504SoZ1UTK0zh4N6SKIGb
         4U+WqPx0G/ytsdb5xg0qP9qLxpyRS93yJIhK8FBWuZBNtbcVEDy+nzRihuEQZcqnM2lJ
         t+LuZvu/HAmLWXCxlZPsUkOy/SMv3AqmGSRkCVHalBaitlW82q1WsqNJoebg8Kx0Huxb
         y2EU29gwIwMpN/ZB2WPJ2ye8qpu9PjqJ4HfuLIhUzJmbDWp3nz8zkRs1qRf+7t/ORBHD
         v5tw==
X-Gm-Message-State: AOJu0YxQ4SgaaYosIB2HQFxRrBTx2e1ciLSr/3bG8xrkzgUiTTRUOCVQ
	7nPnGYauSOojl7mtwfvUtos93v60vNDtrx2KPFs=
X-Google-Smtp-Source: AGHT+IEe1DCMs1vCS65e5ggb9jvVWH07VbtqqRGVbP9+tHVKJFmcpLj5v7Cl/x3LWwioPRdxmFGjsw==
X-Received: by 2002:a05:6808:1494:b0:3b8:b4c6:ce0d with SMTP id e20-20020a056808149400b003b8b4c6ce0dmr729443oiw.81.1701845965611;
        Tue, 05 Dec 2023 22:59:25 -0800 (PST)
Received: from [10.84.153.17] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id e15-20020aa78c4f000000b006ce5f2996d4sm3967316pfd.143.2023.12.05.22.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 22:59:25 -0800 (PST)
Message-ID: <b7053425-65eb-46a0-abd9-59ade5e78211@bytedance.com>
Date: Wed, 6 Dec 2023 14:59:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH bpf-next] netkit: Add some ethtool ops to provide
 information to user
To: Daniel Borkmann <daniel@iogearbox.net>,
 Nikolay Aleksandrov <razor@blackwall.org>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com, tangchen.1@bytedance.com
References: <20231130075844.52932-1-zhoufeng.zf@bytedance.com>
 <51dd35c9-ff5b-5b11-04d1-9a5ae9466780@blackwall.org>
 <16b4d42d-2d62-460e-912f-6e3b86f3004d@bytedance.com>
 <94e335d4-ec90-ba78-b2b4-8419b25bfa88@iogearbox.net>
 <57587b74-f865-4b56-8d65-a5cbc6826079@bytedance.com>
 <2a829a9c-69a6-695d-d3df-59190b161787@iogearbox.net>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <2a829a9c-69a6-695d-d3df-59190b161787@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2023/12/4 23:22, Daniel Borkmann 写道:
> Thanks, so the netkit_get_link_ksettings is optional. 

Yes, netkit_get_link_ksettings really not necessary, I just added it in 
line with veth.

I don't quite
> follow what you
> mean with regards to your business logic in veth to obtain peer ifindex. 
> What does
> the script do exactly with the peer ifindex (aka /why/ is it needed), 
> could you
> elaborate some more - it's still somewhat too vague? 🙂 E.g. why it does 
> not suffice
> to look at the device type or other kind of attributes?


The scripting logic of the business colleagues should just be simple 
logging records, using ethtool. Then they saw that netkit has this 
missing, so raised this requirement, so I sent this patch, wanting to 
hear your opinions. If you don't think it's necessary, let the business 
colleagues modify it.

Thanks.


