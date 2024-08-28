Return-Path: <netdev+bounces-122873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633D6962EEC
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 19:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95EB01C20D51
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36891A705E;
	Wed, 28 Aug 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ou1xz2kA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FC815ECD7
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867425; cv=none; b=SVkT11rMd9ybzM2k+Sjs8PiNLe2VdShVmSjuzEjtZ0pMn/BaNqUkqNDdgqBVjer8cybyRILGqAnqGzot3gkXt/+opk4nuTsnUl6o+dzTORDcZi4P1G9VsGUwtQZipP1EvaN9ZR2dXwi15j4BMcl8PKk8KQzaf0ZtT4fbS4CfhFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867425; c=relaxed/simple;
	bh=rjt6956a8Mu11Cjc0xErxj8KWpPud0/EHilTQSrm+FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7nQDt7oyhS7VzO0Bn0Lih4E0OT/0Cj7RON8dGrXmG0QFxezrLdTpfjwXyRrWa2tip1b9LTSzGFqbvj5iZpg8QYGM7O2rX/J7MimGOehBwkzwK4LMGHW3/FKf9gK5bf4MPBd7JvXNeKvzpY6oUfxDc8blf6GaqjwM7aNQtnm94I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ou1xz2kA; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d5f5d8cc01so696185a91.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 10:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724867424; x=1725472224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rjt6956a8Mu11Cjc0xErxj8KWpPud0/EHilTQSrm+FI=;
        b=Ou1xz2kAYZhPNweoJ7GyrCisRF7jKgsaWmSIPK9iNwDzPbiIb0MUiD6vKeIdwtJWdT
         r4MU81RzZ810ozJd5RARsWE+gEdbQ/zvjJQlyWxWFg2zL1hYDl3gkJVaMWqHwgm/rarS
         UfED4PNvtGoDhWxtvFuyCPlgZsIZhk2vgcgRJz1CPTkZjZOFUOhZfz7OG6nkP3GdOvgd
         0dfcwnv0DllblufcaL8eTiO7GAW8SyHZ49dwqxMdNfUTOkic+ZMekSV7GbRLhcQj552U
         qMRjEzJqIsHjVVJEQf2rUvI+X7XgMD0Tsx0QaxXR+k9GVPb5o94F2lRX/ErATYogOwuI
         3YfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724867424; x=1725472224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjt6956a8Mu11Cjc0xErxj8KWpPud0/EHilTQSrm+FI=;
        b=QZAARlhE2nywCzP34XKAG9zNKoW2KK3ieet5wot5hgIZ3/b8rsWOcOpWghagqdMGR5
         2HvdlLhGevI8OGXzZuIqlmJVwbzgsFigzjdSQdCaE113SyY1wSXZBj5SwdP6scjUWUrZ
         510jH0buHOuh6xwNV136YIgybfjbbgttpHCpwC6zUMzWkgxKd6maZ/Jk5ve+rU6XO0ue
         AVdv6OCynUv9/RXBPZc+POsVHQY2hvgBmUkYSRYmY4Hm8ZNf3W5cVEV/8nj8Cm+D9nRs
         YuIsHriTXPgl+yLESLYsN3Saa4pWJoypts6o7N8Pp3pD2bzA8udGUUgysmCwbDqy1fLO
         wyAA==
X-Forwarded-Encrypted: i=1; AJvYcCX1Ld15jgCxxOeXiPJXZr0gRMF7Ou59UevZB71RT3kgT6FcZLhhbzyWBMp3LQSp4UxM0+A7vj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBYq+wBnyM/9viZ6rfSb7bY+z92ucgKbhHF4uvKSU4qr3+EM+4
	PzQLu87t+oigt+4sNCqwrj/QhNFS2y9Cf1wgNOo0HyWLPwXu8CKF
X-Google-Smtp-Source: AGHT+IF5Z1kq42nAj+kg1N8Oy3DXTIQaGkmS7ryZdeGSL9YiyLFuqn8SqR9vze/QWXyVJ9JZ1E4ChQ==
X-Received: by 2002:a17:90b:1c02:b0:2c8:2cd1:881b with SMTP id 98e67ed59e1d1-2d843d92219mr4074710a91.20.1724867423593;
        Wed, 28 Aug 2024 10:50:23 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:1c59:4088:26ff:3c78? ([2620:10d:c090:500::5:6cee])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445fbf0dsm2224179a91.19.2024.08.28.10.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 10:50:23 -0700 (PDT)
Message-ID: <f1a467cd-40f6-42d5-aef3-6b7a288ba728@gmail.com>
Date: Wed, 28 Aug 2024 10:50:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] eth: fbnic: Add support to fetch group
 stats
To: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 kernel-team@meta.com, sanmanpradhan@meta.com, sdf@fomichev.me,
 jdamato@fastly.com
References: <20240827205904.1944066-1-mohsin.bashr@gmail.com>
 <20240827205904.1944066-3-mohsin.bashr@gmail.com>
 <20240828143736.GH1368797@kernel.org>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20240828143736.GH1368797@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/28/24 7:37 AM, Simon Horman wrote:
> On Tue, Aug 27, 2024 at 01:59:04PM -0700, Mohsin Bashir wrote:
>> Add support for group stats for mac. The fbnic_set_counter helps prevent
>> overriding the default values for counters which are not collected by the device.
>>
>> The 'reset' flag in 'get_eth_mac_stats' allows choosing between
>> resetting the counter to recent most value or fecthing the aggregate
> nit: fetching
Thank you for pointing.
>
>> values of counters. This is important to cater for cases such as
>> device reset.
>>
>> The 'fbnic_stat_rd64' read 64b stats counters in a consistent fashion using
>> high-low-high approach. This allows to isolate cases where counter is
>> wrapped between the reads.
>>
>> Command: ethtool -S eth0 --groups eth-mac
>> Example Output:
>> eth-mac-FramesTransmittedOK: 421644
>> eth-mac-FramesReceivedOK: 3849708
>> eth-mac-FrameCheckSequenceErrors: 0
>> eth-mac-AlignmentErrors: 0
>> eth-mac-OctetsTransmittedOK: 64799060
>> eth-mac-FramesLostDueToIntMACXmitError: 0
>> eth-mac-OctetsReceivedOK: 5134513531
>> eth-mac-FramesLostDueToIntMACRcvError: 0
>> eth-mac-MulticastFramesXmittedOK: 568
>> eth-mac-BroadcastFramesXmittedOK: 454
>> eth-mac-MulticastFramesReceivedOK: 276106
>> eth-mac-BroadcastFramesReceivedOK: 26119
>> eth-mac-FrameTooLongErrors: 0
>>
>> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ...

