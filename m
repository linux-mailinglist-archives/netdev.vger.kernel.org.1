Return-Path: <netdev+bounces-92902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7168B9417
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 07:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B5A1C20D7F
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 05:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7F21CAB0;
	Thu,  2 May 2024 05:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="OB8Xs4Cw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CF1182DB
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 05:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714626243; cv=none; b=QUpCSLIEC9+eHwsSuOZm4cTa5oKRJTNQ3XQ112FuZkBm5wYrT79JFsBEd7jdGMIMeTKionC5IlMVX/LC8dwz5jslY4ROr57j4RvGnxTWn0X/5h6hUwsS8AFd/Q5W9v8IDdbRUmMI4bK2W08M96NaN396BYeOWeZoKTauzE/DzZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714626243; c=relaxed/simple;
	bh=2a65XCBBO5xFO4WB9xyZN5QunMn5xhTlNhifx5FcK6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WazIBqpyYIj0le2GH/ZRMJZjVAwdveuADPJHHIEmsFSleHT1LrWkvDTEQ5GQmf/wMnMYP6TIFtTlGVZsZG0eej8/ll4d2XEjwtBBqWK7xAK+1Dgao/GeQtA+t/9Ul3WaPlnh9AWr+SyrI87A4TXHqYAkVRPtzHuvijI4ZOWGyms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=OB8Xs4Cw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ecff9df447so7220344b3a.1
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 22:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714626242; x=1715231042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SNkuZfAEvXW3ZRRe5v+FkgwHvjFOWNg8gq366HCjhfU=;
        b=OB8Xs4CwXlgf72ZdtUKKGH5A2H4k7tbmccgGqVHGvr6Fv2G8wXqv5C2AI/b8RNZmBq
         9Rm8/a9Us8eDwdAEFGoBLZQqXGSZ+5MkD0b1dmU5CthON5Gq3HO0SrQxKeNPAgmNR8Ld
         eyjVYWFPKnJj2eEuE0892mZsgQpJi0sOwoXRLUdLxNyKeZ+9BRVUztiNY1vjVSGL4CKZ
         QTbYPz5WV2erdtLULFySJIMX5dJ+D2/oTQH16B0jIDf+/9osbgEvpzpMtq3/lzEhVLjz
         uNRc7qJKd8ctWrtVLJowHwnk/j+q5O+h3CMyqLmK459XBu3w0Z8XVZuIapGAONUO+o97
         MAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714626242; x=1715231042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNkuZfAEvXW3ZRRe5v+FkgwHvjFOWNg8gq366HCjhfU=;
        b=pTGJcF5fq7a/UM2x71Om0sVclvdTUdFEWN3APH/MRJdRjQkZEUU6ZMELTLszi1W4nz
         s5/AOgoHPzjXJ1M7l2ekOAN3WV3Eid44MCWSej0FIwXBqgpKaD9YBdVkZGa4dEO8rSPB
         b/6ORrhkoI2yonv7Qs+GRuAR/uB4PwC02a/uAQHhP5OpbgsYnUb10xQLTAAUYqg0VWWW
         OS75lbNM/Lr3vF1tqv86Ou0eG686GhMHZ4Q2+U89shrmPd0uBFXP5PiYrpb1+CT7sgNl
         Dx34e5YwJwaa4h61lNxDx2tK5qSZ9d1cTPSJjLRpi6PySWDyvFDDl3hgdi4EqrZHln8y
         hBcQ==
X-Gm-Message-State: AOJu0YwwUTiDkolRQ2GsC3AmEGHos7kIVVuyJfAfZ3ai3yOo2LbTT8Uy
	U4ZC4DTfKqt1xsC1pV1A2wdSdRq2kcXtzMzDztqGp5Bls1SaFJLJqdAOzrear24=
X-Google-Smtp-Source: AGHT+IEACvZzvobkhTimV0IHshAupVVf9d3FL2TJ16Ws3OzVienkZ78xtZIN1czANw+tkfEdZLXImQ==
X-Received: by 2002:a05:6a20:7348:b0:1a9:5b3f:f139 with SMTP id v8-20020a056a20734800b001a95b3ff139mr6494617pzc.25.1714626241946;
        Wed, 01 May 2024 22:04:01 -0700 (PDT)
Received: from [192.168.1.4] (174-21-160-85.tukw.qwest.net. [174.21.160.85])
        by smtp.gmail.com with ESMTPSA id a20-20020aa780d4000000b006e64ddfa71asm293530pfn.170.2024.05.01.22.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 22:04:01 -0700 (PDT)
Message-ID: <e3ea5234-c196-4cb7-a0c6-4859c9c2931f@davidwei.uk>
Date: Wed, 1 May 2024 22:04:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: selftest: add test for netdev
 netlink queue-get API
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240424023624.2320033-1-dw@davidwei.uk>
 <20240424023624.2320033-3-dw@davidwei.uk>
 <20240425185124.7d9456e1@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240425185124.7d9456e1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-25 6:51 pm, Jakub Kicinski wrote:
> On Tue, 23 Apr 2024 19:36:24 -0700 David Wei wrote:
>> +    try:
>> +        expected = curr_queues - 1
>> +        cmd(f"ethtool -L {cfg.dev['ifname']} {rx_type} {expected}", timeout=10)
>> +        queues = nl_get_queues(cfg, nl)
>> +        if not queues:
>> +            raise KsftSkipEx('queue-get not supported by device')
>> +        ksft_eq(queues, expected)
>> +
>> +        expected = curr_queues
>> +        cmd(f"ethtool -L {cfg.dev['ifname']} {rx_type} {expected}", timeout=10)
>> +        queues = nl_get_queues(cfg, nl)
>> +        ksft_eq(queues, expected)
>> +    except Exception as ex:
>> +        raise KsftSkipEx(ex)
> 
> 
> Why convert all exceptions to skip? Don't we want the test to go red
> if something is off?

I wanted to separate ethtool -L failures from test failures, but looking
at this code I'm swalling all exceptions here, sorry.

> 
>> +def main() -> None:
>> +    with NetDrvEnv(__file__, queue_count=3) as cfg:
>> +        ksft_run([get_queues, addremove_queues], args=(cfg, NetdevFamily()))
> 
> gotta call ksft_exit() at the end explicitly. It's a bit annoying, 
> I know :S

Ah, I didn't know. Will address in next version.

