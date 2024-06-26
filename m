Return-Path: <netdev+bounces-106763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7A791792F
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39B50B21FCB
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 06:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2F1155A25;
	Wed, 26 Jun 2024 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="K6rtYLmz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953BA1FBB
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 06:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719384610; cv=none; b=UCdmuG8k71D5cZ1ppZCsQ+R6EcN6vIrzKB+TuYkPsSE+Kvh5cExlhjMN3cXVGHk3z1DsdkTC6Y8LDuE+TZVyt2Rq23jItTBAuQhKdRC3kIo2BTxAyGnsHO256Jy24NdD8gT7A4r/EGT3MiZ8coEpXy1y+jO4hkKlM+U/37rVjMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719384610; c=relaxed/simple;
	bh=eQUdNs2rIrX7qqGigt2hfzC7FSnA47UlmMvb1I6gqFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqMGqQd4vSuWE2y6Kxr7hdBZo81PzpYsL22pK1ioIKpjpU92mfi+OFHQxyVw7BCmnIClW7YGPEc7sgjbRfuCHuwwq7PHh1zyv/I4l9ZEQzX44Jro39VGoNGlHlBBFvyF7tsw6xcCdy4LraliW3lNaRQdL9dmrr9vMQhP+MID7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=K6rtYLmz; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cdf2c7454so7037773e87.1
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 23:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1719384607; x=1719989407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aYfugkFKdXF5OXKJphEPoOGEPgE4e7C0WTCNJr7v2Lk=;
        b=K6rtYLmzK+9Ozrwrm4vIUoKNbgYgbd2UKropN7X0rzATrvoHQW7xEk2nlFQrHnPoaL
         9ZuGAYLPRZ24Ac6Uqg7++C13koQZMD/XHTz30xcH1s26EFpstE+97xmxY/aLcoOe3A8m
         EB4/E95YPiIJuEqJHqrns6vlm3Gc1NnqcLNh+k8tMJPjnfCCsP3prF7TzkPtua0MtAer
         LpIYHalFHZgzUmTirE1CT7jzuK6kpHHpBGWW7yk9Y5YkhURVTPJSMqs/hgZP86FMU18d
         E7YF7Sb96O+f8ZZy+RuJ0+iuun6AhaUMpRDfJRH32W6x0XNMEMZNkD4zvtNBpRnXUyt+
         iB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719384607; x=1719989407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYfugkFKdXF5OXKJphEPoOGEPgE4e7C0WTCNJr7v2Lk=;
        b=SUNNi8CA7PEnYxjoJ8E1Qekvcve5uE/+6WXhBjjHw3U93/onkbds3Q7n+mnBuRo7o7
         sWM8Y/DCGaUqE0blkaik8ZTE+RhUe0tCytYmx3QxMOa4VAYcujfSqg6MN1+H/AIuVla4
         o6rA2kbNqKDVRnQEt1kvCXTzlK/9fVEI2atQVU7dhjEFYMwFF2CzEsGIJgWnVAcdZClc
         Nq+jKgoGWiU5sPXOzxiyYK0p7e3ynqiZjmQfbKIh88JD6KfUeXXrk1fjgCKd0Mt5hNg+
         sDQ8ykQxkZAq8EfKA8f0O8n68Rhh/ZOyAfXWuOLEkhTQd3RQBa9KvhPgR9gXolX/7jeA
         vyrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT174nD2lSC1P0f/RkBdLDqhUraZnQH/iDbDILL4BCN5bX3TcI28uEPdNyQOrdK8ZcYYVss7NuF0KFITLa0+Avos1tVS/l
X-Gm-Message-State: AOJu0YxJHCiqhE1HFw6/E714PPZ7ZpCt63bnnPRRbmWzygzPRSAs5NM8
	rRY7cQhpMR2yAw7l9Qrap/WmQ3JRQcEF+mACD62+gIqof376CQeGEk7Oy/cPBIU=
X-Google-Smtp-Source: AGHT+IHSj+NeSiBiocSmOkSNZcFlifenhzRJ6+JsxsR636NiAxa4i0Hy3RAl1l1Fy4kOUeCNgGccfQ==
X-Received: by 2002:a05:6512:32a5:b0:52c:dfaa:def6 with SMTP id 2adb3069b0e04-52ce18356f4mr7555945e87.33.1719384606722;
        Tue, 25 Jun 2024 23:50:06 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a727900d2f1sm119638366b.180.2024.06.25.23.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 23:50:06 -0700 (PDT)
Message-ID: <c84b6dab-b86b-49ad-b78f-b4dcae1d4e76@blackwall.org>
Date: Wed, 26 Jun 2024 09:50:05 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2 0/3] Multiple Spanning Tree (MST) Support
To: Hangbin Liu <liuhangbin@gmail.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, netdev@vger.kernel.org
References: <20240624130035.3689606-1-tobias@waldekranz.com>
 <Znu5eEoN3lRJxX5v@Laptop-X1>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Znu5eEoN3lRJxX5v@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/06/2024 09:47, Hangbin Liu wrote:
> On Mon, Jun 24, 2024 at 03:00:32PM +0200, Tobias Waldekranz wrote:
>> This series adds support for:
>>
>> - Enabling MST on a bridge:
>>
>>       ip link set dev <BR> type bridge mst_enable 1
>>
>> - (Re)associating VLANs with an MSTI:
>>
>>       bridge vlan global set dev <BR> vid <X> msti <Y>
>>
>> - Setting the port state in a given MSTI:
>>
>>       bridge mst set dev <PORT> msti <Y> state <Z>
>>
>> - Listing the current port MST states:
>>
>>       bridge mst show
> 
> Tested-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> With following steps:
> + /home/iproute2/ip/ip link add br0 type bridge
> + /home/iproute2/ip/ip link set br0 type bridge mst_enabled 1
> + /home/iproute2/ip/ip link add type veth
> + /home/iproute2/ip/ip link set veth0 master br0
> + /home/iproute2/bridge/bridge vlan add dev br0 vid 1-3 self
> + /home/iproute2/bridge/bridge vlan global set dev br0 vid 2 msti 3
> + /home/iproute2/bridge/bridge vlan add dev veth0 vid 1-3
> + /home/iproute2/bridge/bridge mst set dev veth0 msti 3 state 1
> + /home/iproute2/bridge/bridge mst show
> port              msti
> veth0             0
>                     state disabled
>                   3
>                     state listening
> 
> 
> There is one issue I got (should be kernel issue):
> 
> + /home/iproute2/ip/ip link set br0 type bridge mst_enabled 0
> Error: MST mode can't be changed while VLANs exist.
> 
>   If I want disable mst, I got failed as there is VLAN info, which is expected
> 
> + /home/iproute2/ip/ip link set veth0 nomaster
> + /home/iproute2/ip/ip link set veth0 master br0
> + /home/iproute2/ip/ip link set br0 type bridge mst_enabled 0
> Error: MST mode can't be changed while VLANs exist.
> 
>   But I got failed again after remove and re-add veth0, is this expected?
>   I thought the VLAN info should be cleared after removing.
> 

Probably default vlan 1 got added to the port when it was enslaved.

> + /home/iproute2/ip/ip link set veth0 nomaster
> + /home/iproute2/ip/ip link set br0 type bridge mst_enabled 0
> 
>   It works after I remove veth0.
> 


