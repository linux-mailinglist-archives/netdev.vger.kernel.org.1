Return-Path: <netdev+bounces-144106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8E19C5BA4
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 16:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6BC1B282FD
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4FA1FCF63;
	Tue, 12 Nov 2024 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="rstItsb9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06951FCF41
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419429; cv=none; b=jccTBCdhYxPzBFdLPRTrf8csdadJVHzP3L6NN5aozV1goX/pwvW2sqgAAkhQDwERBELWND8mW9VCxIkvbdovRYzOWLt5zj6+Cfzjf4o8tZbbvVH4/fPOkv/hr0SeiJSsYKEh5KZUzWyhJ7UGLW/lxFFwQ+Z4rT2AOrxc6DFWfDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419429; c=relaxed/simple;
	bh=mzq613P0rQJ2+4JHU/B89oV7zMp4IkunBZ8sL1R7feI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9TB4AdVB6bSOzug8Qa0WMXThqcSRfyyRgAbNLBwhVckiaAqkQHNm049rpLbk7sGalae4IWaRhkTIE4rYuzn8Kg97bLku6OIKHlKThr7A8/911fSEweFoQUXyhUldMBn7y7co/rZLBkcC7/0MUTaAn3zSnirOKRIlSLRj3hfZ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=rstItsb9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f58c68c5so9732091e87.3
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 05:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1731419426; x=1732024226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=faWcBO3IObJ6Ff1ndGVWG5mNTwtfJB+/3MIGY1Y/Ibw=;
        b=rstItsb9/vxg5pCALe+xEjzh/fa/g14ATXWB15ukZLLxfxzqrTSk2xos/MtDpPKP6f
         ynmN+nu5asUSZ3ADEnNqFgbzKDDjkpPz9I1nstI297a1I9WAr1J5cnookOdsWgEZWZsz
         koaqbkG3n/7zhpLi77ObH7Q1VmHnnVZrBN24He79R8SCvQmyfiYwka0EDA/Kdj46bW4A
         RcV8Px/AHNmIG9lTtN5mNrDjKCvkZlLGtz+4q2eVK0FnpRvhwxogjp5x9YfeQtFHYtiz
         /EsE/2ySYFMcAbTd5vCcBPi9j3woL0Ghxtpb9buIgRl3BWnGBofGlZqTmfNN6KyoEJsP
         IMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731419426; x=1732024226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faWcBO3IObJ6Ff1ndGVWG5mNTwtfJB+/3MIGY1Y/Ibw=;
        b=Miqa5ItZOEi+BNjGJNL9f/x1UErlTovmzCtomhPbDQtXEjsa1OKlO7exd9OJ+KWGIx
         Rd2sUHknE+lbc2vedUD+TCPs9w6wCBfi4qs4E/yRbLP/DSU2TAVSPno8yu0TdInS/4Mr
         zqEE2rPdfQbU+xj2L982h3g3F4gj6+gxZ8mf4NFObDtC+9qEmY3P8MA0cAkxvnWu+Pn5
         nxrGix7VflkjD2UnZXKkBXnDcaBBoQqal+BE5DafIe9Lh17tO644mP6ncqvdF+QTR9Sp
         k3/qtXrqwer54u3RyEIXCcXCGy7NQfNsZ+AZxHktMGiG1S0caMuJx1OIsPUCCaXL7IYj
         qpMw==
X-Gm-Message-State: AOJu0YxBqBkbvhQc5CHROcPkpJbAljdbtg9qzREOQ9fkBkrTkxz1lsGN
	QTIn2MqOHQcymsS+e2OFGcZfT/vO37ik3cA3p4rbzKcrd+BCH9j7pBsxwfQT5bm9wgAsYFLhfLw
	x
X-Google-Smtp-Source: AGHT+IH8giJ+0I4u5AIEdyM111/2T0kTvvnxMXkxC6ARvNEqpPlklpz/VToCv4/0i97trTh84+rTUA==
X-Received: by 2002:a05:6512:3f09:b0:533:71f:3a3d with SMTP id 2adb3069b0e04-53d862c7321mr13439101e87.24.1731419425787;
        Tue, 12 Nov 2024 05:50:25 -0800 (PST)
Received: from [192.168.1.128] ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a9d9dsm1844419e87.205.2024.11.12.05.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 05:50:24 -0800 (PST)
Message-ID: <6821f3d4-3157-451d-86f2-bb1d1a990c17@blackwall.org>
Date: Tue, 12 Nov 2024 15:50:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net 1/2] bonding: add ns target multicast address to
 slave device
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20241106051442.75177-1-liuhangbin@gmail.com>
 <20241106051442.75177-2-liuhangbin@gmail.com> <ZytEBmPmqHwfCIzo@penguin>
 <ZzHW9llUizisMk3u@fedora>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZzHW9llUizisMk3u@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 12:05, Hangbin Liu wrote:
> On Wed, Nov 06, 2024 at 12:25:10PM +0200, Nikolay Aleksandrov wrote:
>>> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
>>> index 95d59a18c022..60368cef2704 100644
>>> --- a/drivers/net/bonding/bond_options.c
>>> +++ b/drivers/net/bonding/bond_options.c
>>> @@ -15,6 +15,7 @@
>>>  #include <linux/sched/signal.h>
>>>  
>>>  #include <net/bonding.h>
>>> +#include <net/ndisc.h>
>>>  
>>>  static int bond_option_active_slave_set(struct bonding *bond,
>>>  					const struct bond_opt_value *newval);
>>> @@ -1234,6 +1235,64 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
>>>  }
>>>  
>>>  #if IS_ENABLED(CONFIG_IPV6)
>>> +static bool slave_can_set_ns_maddr(struct bonding *bond, struct slave *slave)
>>
>> const bond/slave
>>
>>> +{
>>> +	return BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
>>> +	       !bond_is_active_slave(slave) &&
>>> +	       slave->dev->flags & IFF_MULTICAST;
>>> +}
> 
> Hi, FYI, in new patch I only set bond to const as slave will be called
> by bond_is_active_slave().
> 
> Thanks
> Hangbin

Yeah, I figured. :) Thanks for letting me know!


