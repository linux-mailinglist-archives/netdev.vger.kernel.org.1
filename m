Return-Path: <netdev+bounces-154712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBAD9FF8B4
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 12:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C02F97A184F
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 11:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BAE14E2E6;
	Thu,  2 Jan 2025 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="WRUgySdq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109801B041B
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735817016; cv=none; b=Hl8WRPoVVcxNhkQm2+85+/1uBTfh71fk/27q1q7mY9Ph+ia+ZWccGZykVfoUmOKSoDKWSo4uLjFMz0So6pKV9WdV+7t94z3Fz4l2hfchwwkK6B+9dG/XwvMubpfiwyqyHOsYXYaJqesfPBLwsUJbnZDNn3TLM+95qZH5whDU+I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735817016; c=relaxed/simple;
	bh=nN515SH96sgeIfLBKS7MW9Yvn9Usno/wlWHNhiCZG+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1VWaRLC+SRyIE/UurssXDsiS7lcQTC7LcIdhQ6Xs0nqNVzNEobkfXuWD01/mFpmF7DF2n0vUXWQHCIk1eZcW8NWfdf/d6NbohoK092y/YwQlFsL8v5dxz496I5Tg7rfN9TtMwik+RL1Wp1Aw0BmSBZJWRSnhonpOyPgoqmHdJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=WRUgySdq; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so12349429a91.3
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 03:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1735817012; x=1736421812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sFhwoHExJXCqpxC3vnz8KQUoJqZj6NhHppA9s3d7OM=;
        b=WRUgySdq3JRyzeYmhvbYq4Wa/z44bpJaiG2RlWjv2qPKI7o+6bAnyJTkpSP+JfD9U+
         lvHzt0Jfu4LE9OeW8AIAIvJZ3GektEYTjeprgw3kOhcOujIbBk8y4ZuVbR1F6F4JftYU
         xRgzFRnUjOL70jPT0wjxTTndAi4TI8t6tL3I07Fz7QFRRJzZ51VVUxYqxOiFrGz91a20
         ZmSNLxnaheTYfsjX0jrLDRNLhcVGj/K3TvjPDpujKriKTxXgwOhHQMBKjb0sUFFKfQhb
         fFqxYpZBsksnm1tbwt0N5v3FG1lxnvoAfm+wBRR+FVfpBm+DBxYiNZqDd085Ieni8JGG
         Om7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735817012; x=1736421812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8sFhwoHExJXCqpxC3vnz8KQUoJqZj6NhHppA9s3d7OM=;
        b=JwxOpZwC7KFEx6sdeC8rHkdAhcmL1z90yhSD5THIK0v3mds1nnFWw85kANxfiozAzo
         bGj4I6FQ7EOswlmbmE3EFzD3jqnkTCU9iw34gWWaL36xn1Edapy95Hb+kO4vmTEL5R6r
         mC2Q6GuaM4M//pQC7qBNeTRBsHlNJIn1+OVfj0B1waAHy3sDvYxEsTqe0F17anluh62m
         1j/BLLxdf4s3digq2bamSFSnmbNIGZMIeZqp++bEt9OMS23YpOj6WY/xhPDw7PeW8AK3
         8/qhRUjWq8XTFNp95+ggpQA6ev7cGOzC+c0ngshIly8IZreTHHxzxv4Xbnwx+rGC19lh
         fVLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzr8ZaESZP5Yw3bpgWQcTthd+wOGowXhUb+shUqnoloTy+i2WjACldS50/hwNNCRmuTM0b2ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYNtzIH2w22z2xfHm6wbvBqu1Sx5f2gLMdWAkZwBrICGBFRlb
	Unt3+c99PkZnL3miX75DB2qjgopRbYhBX/T3GoHL80Bcuofk96Q522BJGtofPpg=
X-Gm-Gg: ASbGncuN+4m3FRCah+5wpQTEvPxZfT2+WyRid2yscdU+L3B4QCHPSL5vY2SpDe7fEZF
	7iP1IpYgxd1XtIDrvcsX2pjouW7QSANt00GvO9ZqHUiakzzGVfwWA2Gs4f1Mppj06FsL5q2v/dy
	U5LB3H3ZgNz7YcPpLgMlHGedYjzq3IH8jG/l+T43Dx8+uM1/eIDXUlhxByWkGHguVzFo8JMyPBp
	4+veDsWeuRe0uNG9XLhdXgruB62eXEz2GLUUc6t9IoxVcMYzH/ZUiY1Gd3wjzcP69mBPp/zeHdS
	Hy7M4O6ztnMAV93xtqmelVU1H7asmM8yQK/gZDi1
X-Google-Smtp-Source: AGHT+IFA8XuBDDWIfpgiTyTXdpOEKFSzWH//Fz/k1Nauung0TXVCmFIm7z1F+mhtXYmWqJkLUeHQ/Q==
X-Received: by 2002:a17:90b:2dc8:b0:2ee:c797:e276 with SMTP id 98e67ed59e1d1-2f452d3000cmr79788586a91.0.1735817012601;
        Thu, 02 Jan 2025 03:23:32 -0800 (PST)
Received: from [10.54.24.59] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f447882af6sm28929842a91.36.2025.01.02.03.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 03:23:32 -0800 (PST)
Message-ID: <b9c88c0f-7909-43a3-8229-2b0ce7c68c10@shopee.com>
Date: Thu, 2 Jan 2025 19:23:27 +0800
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
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <CANn89iLZQOegmzpK5rX0p++utV=XaxY8S-+H+zdeHzT3iYjXWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/1/2 18:34, Eric Dumazet wrote:
> On Thu, Jan 2, 2025 at 9:43 AM Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>
>>
>>
>> On 2025/1/2 16:13, Eric Dumazet wrote:
>>> On Thu, Jan 2, 2025 at 4:53 AM Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>>>
>>>> Hi masters,
>>>>
>>>>         We use the Intel Corporation 82599ES NIC in our production environment. And it has 63 rx queues, every rx queue interrupt is processed by a single cpu.
>>>>         The RSS configuration can be seen as follow:
>>>>
>>>>         RX flow hash indirection table for eno5 with 63 RX ring(s):
>>>>         0:      0     1     2     3     4     5     6     7
>>>>         8:      8     9    10    11    12    13    14    15
>>>>         16:      0     1     2     3     4     5     6     7
>>>>         24:      8     9    10    11    12    13    14    15
>>>>         32:      0     1     2     3     4     5     6     7
>>>>         40:      8     9    10    11    12    13    14    15
>>>>         48:      0     1     2     3     4     5     6     7
>>>>         56:      8     9    10    11    12    13    14    15
>>>>         64:      0     1     2     3     4     5     6     7
>>>>         72:      8     9    10    11    12    13    14    15
>>>>         80:      0     1     2     3     4     5     6     7
>>>>         88:      8     9    10    11    12    13    14    15
>>>>         96:      0     1     2     3     4     5     6     7
>>>>         104:      8     9    10    11    12    13    14    15
>>>>         112:      0     1     2     3     4     5     6     7
>>>>         120:      8     9    10    11    12    13    14    15
>>>>
>>>>         The maximum number of RSS queues is 16. So I have some questions about this. Will other cpus except 0~15 receive the rx interrupts?
>>>>
>>>>         In our production environment, cpu 16~62 also receive the rx interrupts. Was our RSS misconfigured?
>>>
>>> It really depends on which cpus are assigned to each IRQ.
>>>
>>
>> Hi Eric,
>>
>> Each irq was assigned to a single cpu, for exapmle:
>>
>> irq     cpu
>>
>> 117      0
>> 118      1
>>
>> ......
>>
>> 179      62
>>
>> All cpus trigger interrupts not only cpus 0~15.
>> It seems that the result is inconsistent with the RSS hash value.
>>
>>
> 
> I misread your report, I thought you had 16 receive queues.
> 
> Why don't you change "ethtool -L eno5 rx 16", instead of trying to
> configure RSS manually ?

Hi Eric,

We want to make full use of cpu resources to receive packets. So
we enable 63 rx queues. But we found the rate of interrupt growth
on cpu 0~15 is faster than other cpus(almost twice). I don't know 
whether it is related to RSS configuration. We didn't make any changes
on the RSS configration after the server is up.



FYI, on another server, we use Mellanox Technologies MT27800 NIC.
The rate of interrupt growth on cpu 0~63 seems have little gap.

It's RSS configration can be seen as follow:

RX flow hash indirection table for ens2f0np0 with 63 RX ring(s):
    0:      0     1     2     3     4     5     6     7
    8:      8     9    10    11    12    13    14    15
   16:     16    17    18    19    20    21    22    23
   24:     24    25    26    27    28    29    30    31
   32:     32    33    34    35    36    37    38    39
   40:     40    41    42    43    44    45    46    47
   48:     48    49    50    51    52    53    54    55
   56:     56    57    58    59    60    61    62     0
   64:      1     2     3     4     5     6     7     8
   72:      9    10    11    12    13    14    15    16
   80:     17    18    19    20    21    22    23    24
   88:     25    26    27    28    29    30    31    32
   96:     33    34    35    36    37    38    39    40
  104:     41    42    43    44    45    46    47    48
  112:     49    50    51    52    53    54    55    56
  120:     57    58    59    60    61    62     0     1
  128:      2     3     4     5     6     7     8     9
  136:     10    11    12    13    14    15    16    17
  144:     18    19    20    21    22    23    24    25
  152:     26    27    28    29    30    31    32    33
  160:     34    35    36    37    38    39    40    41
  168:     42    43    44    45    46    47    48    49
  176:     50    51    52    53    54    55    56    57
  184:     58    59    60    61    62     0     1     2
  192:      3     4     5     6     7     8     9    10
  200:     11    12    13    14    15    16    17    18
  208:     19    20    21    22    23    24    25    26
  216:     27    28    29    30    31    32    33    34
  224:     35    36    37    38    39    40    41    42
  232:     43    44    45    46    47    48    49    50
  240:     51    52    53    54    55    56    57    58
  248:     59    60    61    62     0     1     2     3


I am confused that why ixgbe NIC can dispatch the packets
to the rx queues that not specified in RSS configuration.

Thanks!



