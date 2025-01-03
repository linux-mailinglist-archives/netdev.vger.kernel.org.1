Return-Path: <netdev+bounces-154871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FAAA002C8
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 03:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF123A395B
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48520192B62;
	Fri,  3 Jan 2025 02:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="BiLM9rMO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8779F194141
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 02:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735871820; cv=none; b=Xov0Cyj/FWWybtkH5uhR+DWLce4fVE8KSfQQMvS3RI+FZ9WievTNqYRfS7o/vj0GoaQx0MPv2Z75gQ/6GOFKugMoF3zWBOSQS9K46C0A5/Br9ZgNVIG3BG0cW6qObG95fr5KHyem9AxIzDbE8hHmAS6UeSUy16nNqt3L2qhQv0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735871820; c=relaxed/simple;
	bh=ewbCAEa1HCYTZ/da2eh8J5IoXaFWtdrPanhkagUdKfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOo/NFiAoJwbC8/Uu4pAyrHhB/ppNqQeh/7XJ2usSH7uuLCM5ASLNhOK0iH8M87tyr3WCvupB56pWRR9YNAYdD7a+JktI4I/UQWKbnbM2rLSJH2n0dSKG8HvshWV0PeBVcz80tl9ija80IMTgj5VEYu0cfoDM3wOtCAqMFKFkIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=BiLM9rMO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2166651f752so189818465ad.3
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 18:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1735871818; x=1736476618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pShsrZzLuZZugsMDraq2n40cWRm+2AwH1RmFN69x8Oo=;
        b=BiLM9rMOWIYanHNhUAJCFxhzheE6b6LW9RN3rrrZAzzbU9Z+BojM766FYAzA8NSLKX
         6qsfJaU/i0Irw0UPEfg06PMJVAXRWeQOSZ6ZseiknAJARBhzXLu20upIQi5zayI6juxt
         wiedh49lKxPVQzmeyEVCRA97JOA56QGVhcHfrUGrVoMXqqu6Oh9jMrA9biILl6uZ3lPR
         4Z6/WTMafEU4sfQPzJTed3xSBCnHF7x7b4IebgmXSRPQP3HTcuNEUFgvH8PXTRS33cKT
         iHP3rGdpk13d6XyBycxkpNjyppE18ADFJdPaIGc7d8aXGU8jT6zNIimim1iq1OETAF/H
         ZGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735871818; x=1736476618;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pShsrZzLuZZugsMDraq2n40cWRm+2AwH1RmFN69x8Oo=;
        b=DrxqTRQpjNjrFI8PieQNs0gXTCY7ECYWzpniHdx4ciwLVQJMQzipwC+Qc61ZUXc+NP
         XVba6UpoSDpuWaRmsocDVwpeJ7hcmADjyEmu9mYn+Af8DiqQ+FBPoBdRAjlgZweDM20l
         iC10W5e84eSF9vn1W0pC0/tVUn1yFDP0uqKtlsTxXX4mzNqd47LMHt84oc5VJjeIE4Or
         h1SVTXTlaOVigqSHxgjyqGZEU/6nkuLRJjIpjE7WScfr8kpHUaCAPEAp2Vo3lt6lhLWO
         uqWj0SKhf/KRGNaH27f7NxMlDH02ZHsqNh4sRDluDcPjJgJWVpne00MNWaTMrChvU1BB
         52xA==
X-Forwarded-Encrypted: i=1; AJvYcCVG7ZGkIS6sQyTZKWO+4WHSczIlCwLELDupc2uShojqNBKkWWsuf3Nd4+pCQ5DsC41zwdOKI3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVl/3xtYL/X3+k0jG0RvuvR7hpVyrz1t5J62K2YeohQ/U3SfOl
	c6dy4xkvHfTev8B5eP6YX3Zb9Gt5/M5EqFRmTS7FL6kpG9sFnBPY/R8uWyZ0ajI=
X-Gm-Gg: ASbGnctMshOObZH4yJFwKIOWE0M5ZLMAsU+RL2rNdyH4+/yAbxdpRaQ/aQrbDHGqqdz
	Pj0gYL2YBvMMeBjhJ1OEkj13GvbJvOcsNLH+RAnOxQhQwHdCFWbmucFUX2EDEkShv3XP1SMAHBB
	y2azWCwsN4c96L1zVQstlCJSPoecJzcy1WMvp5MUDjmb1rXlriWfZkqIbue6ygU5K4GE/wDW90t
	3myQgbVga4/k7o29PKowYGUUXOloXu+BHTKZ1sdOKu1pUefUjs2rf0g8Udkpz8+EsKeXw==
X-Google-Smtp-Source: AGHT+IElcPb5SdyKwOYf2hMzQ7oB5RMpBcE/E/qNMOnvQzCZhDGbGZG/16W8RKFUUlBN64vu4WnKdA==
X-Received: by 2002:a05:6a00:392a:b0:728:e906:e446 with SMTP id d2e1a72fcca58-72abdeb7855mr76549430b3a.24.1735871817695;
        Thu, 02 Jan 2025 18:36:57 -0800 (PST)
Received: from [10.54.24.59] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c1b1sm25991849b3a.185.2025.01.02.18.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 18:36:57 -0800 (PST)
Message-ID: <03b02880-4aae-4a4a-9533-7a756cc84001@shopee.com>
Date: Fri, 3 Jan 2025 10:36:50 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BQuestion=5D_ixgbe=EF=BC=9AMechanism_of_RSS?=
To: Eric Dumazet <edumazet@google.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
References: <da83df12-d7e2-41fe-a303-290640e2a4a4@shopee.com>
 <CANn89iKVVS=ODm9jKnwG0d_FNUJ7zdYxeDYDyyOb74y3ELJLdA@mail.gmail.com>
 <c2c94aa3-c557-4a74-82fc-d88821522a8f@shopee.com>
 <CANn89iLZQOegmzpK5rX0p++utV=XaxY8S-+H+zdeHzT3iYjXWw@mail.gmail.com>
 <b9c88c0f-7909-43a3-8229-2b0ce7c68c10@shopee.com>
 <CANn89iLbC3qkeptG9xv1nZyWHUTdtXBf4w3LGaisRGc7xj4pMw@mail.gmail.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <CANn89iLbC3qkeptG9xv1nZyWHUTdtXBf4w3LGaisRGc7xj4pMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/1/2 19:46, Eric Dumazet wrote:
> On Thu, Jan 2, 2025 at 12:23 PM Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>
>>
>>
>> On 2025/1/2 18:34, Eric Dumazet wrote:
>>> On Thu, Jan 2, 2025 at 9:43 AM Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2025/1/2 16:13, Eric Dumazet wrote:
>>>>> On Thu, Jan 2, 2025 at 4:53 AM Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>>>>>
>>>>>> Hi masters,
>>>>>>
>>>>>>         We use the Intel Corporation 82599ES NIC in our production environment. And it has 63 rx queues, every rx queue interrupt is processed by a single cpu.
>>>>>>         The RSS configuration can be seen as follow:
>>>>>>
>>>>>>         RX flow hash indirection table for eno5 with 63 RX ring(s):
>>>>>>         0:      0     1     2     3     4     5     6     7
>>>>>>         8:      8     9    10    11    12    13    14    15
>>>>>>         16:      0     1     2     3     4     5     6     7
>>>>>>         24:      8     9    10    11    12    13    14    15
>>>>>>         32:      0     1     2     3     4     5     6     7
>>>>>>         40:      8     9    10    11    12    13    14    15
>>>>>>         48:      0     1     2     3     4     5     6     7
>>>>>>         56:      8     9    10    11    12    13    14    15
>>>>>>         64:      0     1     2     3     4     5     6     7
>>>>>>         72:      8     9    10    11    12    13    14    15
>>>>>>         80:      0     1     2     3     4     5     6     7
>>>>>>         88:      8     9    10    11    12    13    14    15
>>>>>>         96:      0     1     2     3     4     5     6     7
>>>>>>         104:      8     9    10    11    12    13    14    15
>>>>>>         112:      0     1     2     3     4     5     6     7
>>>>>>         120:      8     9    10    11    12    13    14    15
>>>>>>
>>>>>>         The maximum number of RSS queues is 16. So I have some questions about this. Will other cpus except 0~15 receive the rx interrupts?
>>>>>>
>>>>>>         In our production environment, cpu 16~62 also receive the rx interrupts. Was our RSS misconfigured?
>>>>>
>>>>> It really depends on which cpus are assigned to each IRQ.
>>>>>
>>>>
>>>> Hi Eric,
>>>>
>>>> Each irq was assigned to a single cpu, for exapmle:
>>>>
>>>> irq     cpu
>>>>
>>>> 117      0
>>>> 118      1
>>>>
>>>> ......
>>>>
>>>> 179      62
>>>>
>>>> All cpus trigger interrupts not only cpus 0~15.
>>>> It seems that the result is inconsistent with the RSS hash value.
>>>>
>>>>
>>>
>>> I misread your report, I thought you had 16 receive queues.
>>>
>>> Why don't you change "ethtool -L eno5 rx 16", instead of trying to
>>> configure RSS manually ?
>>
>> Hi Eric,
>>
>> We want to make full use of cpu resources to receive packets. So
>> we enable 63 rx queues. But we found the rate of interrupt growth
>> on cpu 0~15 is faster than other cpus(almost twice). I don't know
>> whether it is related to RSS configuration. We didn't make any changes
>> on the RSS configration after the server is up.
>>
>>
>>
>> FYI, on another server, we use Mellanox Technologies MT27800 NIC.
>> The rate of interrupt growth on cpu 0~63 seems have little gap.
>>
>> It's RSS configration can be seen as follow:
>>
>> RX flow hash indirection table for ens2f0np0 with 63 RX ring(s):
>>     0:      0     1     2     3     4     5     6     7
>>     8:      8     9    10    11    12    13    14    15
>>    16:     16    17    18    19    20    21    22    23
>>    24:     24    25    26    27    28    29    30    31
>>    32:     32    33    34    35    36    37    38    39
>>    40:     40    41    42    43    44    45    46    47
>>    48:     48    49    50    51    52    53    54    55
>>    56:     56    57    58    59    60    61    62     0
>>    64:      1     2     3     4     5     6     7     8
>>    72:      9    10    11    12    13    14    15    16
>>    80:     17    18    19    20    21    22    23    24
>>    88:     25    26    27    28    29    30    31    32
>>    96:     33    34    35    36    37    38    39    40
>>   104:     41    42    43    44    45    46    47    48
>>   112:     49    50    51    52    53    54    55    56
>>   120:     57    58    59    60    61    62     0     1
>>   128:      2     3     4     5     6     7     8     9
>>   136:     10    11    12    13    14    15    16    17
>>   144:     18    19    20    21    22    23    24    25
>>   152:     26    27    28    29    30    31    32    33
>>   160:     34    35    36    37    38    39    40    41
>>   168:     42    43    44    45    46    47    48    49
>>   176:     50    51    52    53    54    55    56    57
>>   184:     58    59    60    61    62     0     1     2
>>   192:      3     4     5     6     7     8     9    10
>>   200:     11    12    13    14    15    16    17    18
>>   208:     19    20    21    22    23    24    25    26
>>   216:     27    28    29    30    31    32    33    34
>>   224:     35    36    37    38    39    40    41    42
>>   232:     43    44    45    46    47    48    49    50
>>   240:     51    52    53    54    55    56    57    58
>>   248:     59    60    61    62     0     1     2     3
>>
>>
>> I am confused that why ixgbe NIC can dispatch the packets
>> to the rx queues that not specified in RSS configuration.
> 
> Perhaps make sure to change RX flow hash indirection table on the
> Intel NIC then...
> 
> Maybe you changed the default configuration.
> 
> ethtool -X eno5 equal 64


The maximum number of RSS queues supported by Intel Corporation 82599ES NIC
is 16. When I specify the number which is larger than 16, it shows the below message.

"Cannot set RX flow hash configuration: Invalid argument."

> Or
> ethtool -X eno5 default

This command can run sucessfully and as I saied above, it only has 16 queues.

RX flow hash indirection table for eno5 with 63 RX ring(s):
    0:      0     1     2     3     4     5     6     7
    8:      8     9    10    11    12    13    14    15
   16:      0     1     2     3     4     5     6     7
   24:      8     9    10    11    12    13    14    15
   32:      0     1     2     3     4     5     6     7
   40:      8     9    10    11    12    13    14    15
   48:      0     1     2     3     4     5     6     7
   56:      8     9    10    11    12    13    14    15
   64:      0     1     2     3     4     5     6     7
   72:      8     9    10    11    12    13    14    15
   80:      0     1     2     3     4     5     6     7
   88:      8     9    10    11    12    13    14    15
   96:      0     1     2     3     4     5     6     7
  104:      8     9    10    11    12    13    14    15
  112:      0     1     2     3     4     5     6     7
  120:      8     9    10    11    12    13    14    15

Thanks!

