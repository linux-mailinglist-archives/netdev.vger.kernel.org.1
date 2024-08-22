Return-Path: <netdev+bounces-120843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F4995B038
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 10:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86881C237F0
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 08:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1085A17B401;
	Thu, 22 Aug 2024 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Hdlez5cI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8211C171088
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315149; cv=none; b=f7JOFfgJuIXIpJKNLhmdLqxwfhffwH8r5goAmuGU/Lt9fAnKJnHmeWcJt/Q3KMsYUsEEynnTmZ9sx5Ly07eV57ubtoiV7WT3IKpTEOdOeeYlsgFOwcrb/8smaAXzQxxvOdBeYQN2lmThedCQxUFtDJLR7iUip4uXIvpAg74LiLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315149; c=relaxed/simple;
	bh=loryYtIRejTvQXqCiQ+6T2F0TRbLEqx6TT8pqfhBHWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6Esxyu6cus/1RpoGkFXoeazwdPRxFWZKolZfkQuljitFKvKEbyno4T8gOwSqnzCeperoGRMFfHPl8pmEKAdR+c4gzcl7Gkbus7Cc9cRAilCXwN53sQvWCWDX4sZ/AeXx6aRrv+MS/ZcCVTwh+zn9lmmAR4ytzNAPMCY3MVCM18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Hdlez5cI; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7c1324be8easo1183289a12.1
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 01:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724315148; x=1724919948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXfLX67xydWXFofQKkNhVZ5m+kGg8DeUVnRTn9LVrTg=;
        b=Hdlez5cIdN3gHIZH6V5LDaYZCHXRqcvWfXVvVxHkXtaP9C4lEh1skxWCNitf7gB9+b
         Z9V9PWDvcNYcueuQoKDwwO8JrPcwic2PkTNmyIqWwJRXW261vYbkMQcybpaTgSW4BCys
         jab1VpTwWEOjcfb3v5GYpL8mt4Jl32vlDLLidkNRASJvWf2Q+30yqY2nKOvjKd1mBKMU
         SkZbzjevn4HyffqTWJdJ6pz9/blRGTxMexef1c7vyxYk3j1e7PUdYuVZg2REuCw90/4z
         VRC8WbmdwLKbD78YHaS2qqQDaF5lz1ldhnk/bpTVF5pT74jC1D1FA6+tSV2GncxDOKBp
         349A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724315148; x=1724919948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uXfLX67xydWXFofQKkNhVZ5m+kGg8DeUVnRTn9LVrTg=;
        b=QKnhsxjjMwMzBNNdry/sjMHpp524vTm35roHmSPtdhpEtW8eOo9KU+lR+jbVm6U27q
         5KMzWAhQh7Ip/bmtUGL53XFKrQagdf84TmzSoF93zfiJOyS41aSCAM9xehnfjznCV6Fg
         cjnFYWlMQwPY/OrKamuncZTRNakIiml22gtiRGI1GKGobaVrCK+N50xAdDb+GEenKyzs
         yKCK2ZGIp93Jcn/Y8F4xM1qPta5wOPB6IsGfCxtFaw4bHAkd017ufhM0AKYHz+50XryP
         VxUKkN9hp3vJI4H1IvjvWkCOa63tq58CrFYRNsa7/+VtxDQB7e8PNn79LeJhsTvSmIWc
         EVhg==
X-Forwarded-Encrypted: i=1; AJvYcCWVTJZYoDCZQPuMloOSplGWvBs4/zZ+QlkJSUmDVcSd5RrhNcyI/JBOjo0zVN8tmFg98f8/DdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUxPpjAzmoDqhLBn4bWtbs32pWPUtIvU19E10IK/x9+mvfcR2f
	GKVyV/SuCFrwogpH0nC4+1hni4mshWbEc4gFFJEP2BC2yAOENNA900Hq34k+w58=
X-Google-Smtp-Source: AGHT+IGavGubutSE27H+Qqx47oXi5pTvlaJldryUCjPUVdX6faZcAT7o8WBJLpBwcHa/BpiQ3qPC8Q==
X-Received: by 2002:a17:903:1cd:b0:1fd:6ca4:f987 with SMTP id d9443c01a7336-2037f9d95f0mr30636175ad.15.1724315147604;
        Thu, 22 Aug 2024 01:25:47 -0700 (PDT)
Received: from [10.68.122.106] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385fc69ddsm7575335ad.293.2024.08.22.01.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 01:25:47 -0700 (PDT)
Message-ID: <3bf84d23-a561-47ae-84a4-e99488fc762b@bytedance.com>
Date: Thu, 22 Aug 2024 16:25:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] net: Don't allow to attach xdp if bond
 slave device's upper already has a program
To: Jiri Pirko <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, bigeasy@linutronix.de, lorenzo@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20240814090811.35343-1-zhoufeng.zf@bytedance.com>
 <fd30815f-cf2b-42a0-9911-4f71e4e4dd14@redhat.com>
 <Zr32ZZ8e4RhYN1xd@nanopsycho.orion>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <Zr32ZZ8e4RhYN1xd@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/8/15 20:36, Jiri Pirko 写道:
> Thu, Aug 15, 2024 at 01:18:33PM CEST, pabeni@redhat.com wrote:
>> On 8/14/24 11:08, Feng zhou wrote:
>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>
>>> Cannot attach when an upper device already has a program, This
>>> restriction is only for bond's slave devices, and should not be
>>> accidentally injured for devices like eth0 and vxlan0.
>>>
>>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>>> ---
>>>    net/core/dev.c | 10 ++++++----
>>>    1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>> index 6ea1d20676fb..e1f87662376a 100644
>>> --- a/net/core/dev.c
>>> +++ b/net/core/dev.c
>>> @@ -9501,10 +9501,12 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
>>>    	}
>>>    	/* don't allow if an upper device already has a program */
>>> -	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>>> -		if (dev_xdp_prog_count(upper) > 0) {
>>> -			NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
>>> -			return -EEXIST;
>>> +	if (netif_is_bond_slave(dev)) {
>>
>> I think we want to consider even team port devices.
> 
> netif_is_lag_port()
> 
> 

Will do, thanks.

>>
>> Thanks,
>>
>> Paolo
>>


