Return-Path: <netdev+bounces-77665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D864487285D
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 21:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E635F1C225FF
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 20:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBED9433C0;
	Tue,  5 Mar 2024 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiywkD+X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7731B59F
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 20:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669551; cv=none; b=UIeZyvfpvK1bbgJ1S2+VcEUmML+sUaU6lZrbrbKbg0YWaTIl9nBIDqWemFb30J+a5jYDkdgmn/+HH80TUjsjxqafaetK1Tm8+uog0XXY8KzdLyZtUFJMFtPyl7BSFWACafPYCrkwyDAjqpOtHsd8bF+6chvbjJBc2NXDmUaUDxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669551; c=relaxed/simple;
	bh=bTA51K3tCdp9dOsHR5ffjO9H50L0IPjI9y0jmjX3WeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/kAR9dv4+qJPTVLjA7uuBJ8eM72jU7BW2Ye5s7a0K5JqJhzpY0Zh1iw7BhzPpUTDBCfWwkGeAqbZLUj1bgYl9t/vo2wvnfmEtzVfbLEfoV/staY5rUo3s1RxWCb5ruVFMNIBAna/fXrb8heHYbOdsSxSyv+EWU9kTIPikhLsSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiywkD+X; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412eddd165eso6450245e9.1
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 12:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709669548; x=1710274348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pqmSMd1Buc460rne0TvIS7etk/SPhkSEFPqxixTd6X0=;
        b=LiywkD+XxQFgVKYGGJOJ5lSy4AmXqiEiH1RphzhwfOVI2Xy43u4xKO1jvkXLI99NJh
         NyP0vYP42fYfoKXcGq41vJh045bE6lITdhRq7ijDrzByF9tb5ohFMMTrS3Lq7fwHD/L3
         xFd3sKIqR2VFP9diD6LgMeQT+zWe6NT5ZPitE42BJ9ZqFUm5LBocVeF3aI38wnDwv5/Q
         Yt0Jd/xtbtXW1UAD7oFs9tC789hB0HVX7ndFPLmBcXWdbW5RvUtkY7vtf7PZZHeJmTCx
         pwlTPi9YwlxQBoCyqWXcZKu+VNIZJQuG+kEohREmE5dBXpExp1LbhfNYpEgKw2nzPHYt
         iGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709669548; x=1710274348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqmSMd1Buc460rne0TvIS7etk/SPhkSEFPqxixTd6X0=;
        b=hS9UG7aR08fD3O89BjLkBb2KBAWXtIqRby02Ta3uBZgJQBrJuPA6gSCw8+zC5bAsr8
         Hr3FopoOqZ2H0UQotZRNbJR+N1MVNTdGFiLWYevZgcIF02TehSUSznmQiq9sokQE+vRx
         BiZhX4wLlKQiRozCMFea2THnRqvQsf90j1hBh84+1/Uy8BASyUHtlqXJqqmXay7ml3Af
         v0ziFdIFc7PoEusyfrLKpVvBWAQ3whTVNZBqStvJTtg3kwqH5RUPQBybJu492ZkrbvdA
         nU4zyUDRMQKLO7Ikhx31xMonrpPOd2VjvNZsQHZHl53SaOxvSz9pfyMpJaj7hLS7HZfq
         1fHg==
X-Forwarded-Encrypted: i=1; AJvYcCXcezkKPUTGwb04F1YeNOLTIsrDIP5Qi5qeI7Knl20NyBb/+tFJXeyQGPPkEDn7xhcXqEbZsbGCw9/uM72r5kUZq4JvjVZQ
X-Gm-Message-State: AOJu0YxHtH1FfWCT99O/keynSmuyCT4HMKJZ1eXzBMS5gjSIsdiupgkj
	uexyn0BsH2QiArLCpJ6fXpmItKb5AHvXX3so8WxZ3D7GOwBCzcuN
X-Google-Smtp-Source: AGHT+IGWAjdmfvp/NawmAF+Ebx1zGmbyloJ3UAJEWQbvgE8JAeYPrNVBMJS26fnjembhBbGuClEsNA==
X-Received: by 2002:a05:600c:4e06:b0:412:ea91:ec97 with SMTP id b6-20020a05600c4e0600b00412ea91ec97mr3098165wmq.2.1709669547837;
        Tue, 05 Mar 2024 12:12:27 -0800 (PST)
Received: from [172.27.52.41] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b00412ea92f1b4sm3694096wmb.19.2024.03.05.12.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 12:12:27 -0800 (PST)
Message-ID: <228ecfb6-d5cb-403b-aecf-7c1181aa45ce@gmail.com>
Date: Tue, 5 Mar 2024 22:12:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V4 15/15] Documentation: networking: Add description
 for multi-pf netdev
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Saeed Mahameed <saeed@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, sridhar.samudrala@intel.com,
 Jay Vosburgh <jay.vosburgh@canonical.com>, Jiri Pirko <jiri@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240302072246.67920-1-saeed@kernel.org>
 <20240302072246.67920-16-saeed@kernel.org>
 <7f749366-193f-480e-8302-fea7566ec57c@intel.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <7f749366-193f-480e-8302-fea7566ec57c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04/03/2024 14:03, Przemek Kitszel wrote:
> On 3/2/24 08:22, Saeed Mahameed wrote:
>> From: Tariq Toukan <tariqt@nvidia.com>
>>
>> Add documentation for the multi-pf netdev feature.
>> Describe the mlx5 implementation and design decisions.
>>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>> ---
>>   Documentation/networking/index.rst           |   1 +
>>   Documentation/networking/multi-pf-netdev.rst | 177 +++++++++++++++++++
>>   2 files changed, 178 insertions(+)
>>   create mode 100644 Documentation/networking/multi-pf-netdev.rst
>>
>> diff --git a/Documentation/networking/index.rst 
>> b/Documentation/networking/index.rst
>> index 69f3d6dcd9fd..473d72c36d61 100644
>> --- a/Documentation/networking/index.rst
>> +++ b/Documentation/networking/index.rst
>> @@ -74,6 +74,7 @@ Contents:
>>      mpls-sysctl
>>      mptcp-sysctl
>>      multiqueue
>> +   multi-pf-netdev
>>      napi
>>      net_cachelines/index
>>      netconsole
>> diff --git a/Documentation/networking/multi-pf-netdev.rst 
>> b/Documentation/networking/multi-pf-netdev.rst
>> new file mode 100644
>> index 000000000000..f6f782374b71
>> --- /dev/null
>> +++ b/Documentation/networking/multi-pf-netdev.rst
>> @@ -0,0 +1,177 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +.. include:: <isonum.txt>
>> +
>> +===============
>> +Multi-PF Netdev
>> +===============
>> +
>> +Contents
>> +========
>> +
>> +- `Background`_
>> +- `Overview`_
>> +- `mlx5 implementation`_
>> +- `Channels distribution`_
>> +- `Observability`_
>> +- `Steering`_
>> +- `Mutually exclusive features`_
> 
> this document describes mlx5 details mostly, and I would expect to find
> them in a mlx5.rst file instead of vendor-agnostic doc
> 

It was originally under 
Documentation/networking/device_drivers/ethernet/mellanox/mlx5/
We moved it here with the needed changes per request.

See:
https://lore.kernel.org/all/20240209222738.4cf9f25b@kernel.org/

>> +
>> +Background
>> +==========
>> +
>> +The advanced Multi-PF NIC technology enables several CPUs within a 
>> multi-socket server to
> 
> please remove the `advanced` word
> 
>> +connect directly to the network, each through its own dedicated PCIe 
>> interface. Through either a
>> +connection harness that splits the PCIe lanes between two cards or by 
>> bifurcating a PCIe slot for a
>> +single card. This results in eliminating the network traffic 
>> traversing over the internal bus
>> +between the sockets, significantly reducing overhead and latency, in 
>> addition to reducing CPU
>> +utilization and increasing network throughput.
>> +
>> +Overview
>> +========
>> +
>> +The feature adds support for combining multiple PFs of the same port 
>> in a Multi-PF environment under
>> +one netdev instance. It is implemented in the netdev layer. 
>> Lower-layer instances like pci func,
>> +sysfs entry, devlink) are kept separate.
>> +Passing traffic through different devices belonging to different NUMA 
>> sockets saves cross-numa
> 
> please consider spelling out NUMA as always capitalized
> 
>> +traffic and allows apps running on the same netdev from different 
>> numas to still feel a sense of
>> +proximity to the device and achieve improved performance.
>> +
>> +mlx5 implementation
>> +===================
>> +
>> +Multi-PF or Socket-direct in mlx5 is achieved by grouping PFs 
>> together which belong to the same
>> +NIC and has the socket-direct property enabled, once all PFS are 
>> probed, we create a single netdev
> 
> s/PFS/PFs/
> 
>> +to represent all of them, symmetrically, we destroy the netdev 
>> whenever any of the PFs is removed.
>> +
>> +The netdev network channels are distributed between all devices, a 
>> proper configuration would utilize
>> +the correct close numa node when working on a certain app/cpu.
> 
> CPU
> 
>> +
>> +We pick one PF to be a primary (leader), and it fills a special role. 
>> The other devices
>> +(secondaries) are disconnected from the network at the chip level 
>> (set to silent mode). In silent
>> +mode, no south <-> north traffic flowing directly through a secondary 
>> PF. It needs the assistance of
>> +the leader PF (east <-> west traffic) to function. All RX/TX traffic 
>> is steered through the primary
> 
> Rx, Tx (whole document)
> 
>> +to/from the secondaries.
>> +
>> +Currently, we limit the support to PFs only, and up to two PFs 
>> (sockets).
>> +
>> +Channels distribution
>> +=====================
>> +
>> +We distribute the channels between the different PFs to achieve local 
>> NUMA node performance
>> +on multiple NUMA nodes.
>> +
>> +Each combined channel works against one specific PF, creating all its 
>> datapath queues against it. We
>> +distribute channels to PFs in a round-robin policy.
>> +
>> +::
>> +
>> +        Example for 2 PFs and 5 channels:
>> +        +--------+--------+
>> +        | ch idx | PF idx |
>> +        +--------+--------+
>> +        |    0   |    0   |
>> +        |    1   |    1   |
>> +        |    2   |    0   |
>> +        |    3   |    1   |
>> +        |    4   |    0   |
>> +        +--------+--------+
>> +
>> +
>> +We prefer this round-robin distribution policy over another suggested 
>> intuitive distribution, in
>> +which we first distribute one half of the channels to PF0 and then 
>> the second half to PF1.
> 
> Please rephrase to describe current state (which makes sense over what
> was suggested), instead of addressing feedback (that could be kept in
> cover letter if you really want).
> 
> And again, the wording "we" clearly indicates that this section, as
> future ones, is mlx specific.
> 
>> +
>> +The reason we prefer round-robin is, it is less influenced by changes 
>> in the number of channels. The
>> +mapping between a channel index and a PF is fixed, no matter how many 
>> channels the user configures.
>> +As the channel stats are persistent across channel's closure, 
>> changing the mapping every single time
>> +would turn the accumulative stats less representing of the channel's 
>> history.
>> +
>> +This is achieved by using the correct core device instance (mdev) in 
>> each channel, instead of them
>> +all using the same instance under "priv->mdev".
>> +
>> +Observability
>> +=============
>> +The relation between PF, irq, napi, and queue can be observed via 
>> netlink spec:
>> +
>> +$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml 
>> --dump queue-get --json='{"ifindex": 13}'
>> +[{'id': 0, 'ifindex': 13, 'napi-id': 539, 'type': 'rx'},
>> + {'id': 1, 'ifindex': 13, 'napi-id': 540, 'type': 'rx'},
>> + {'id': 2, 'ifindex': 13, 'napi-id': 541, 'type': 'rx'},
>> + {'id': 3, 'ifindex': 13, 'napi-id': 542, 'type': 'rx'},
>> + {'id': 4, 'ifindex': 13, 'napi-id': 543, 'type': 'rx'},
>> + {'id': 0, 'ifindex': 13, 'napi-id': 539, 'type': 'tx'},
>> + {'id': 1, 'ifindex': 13, 'napi-id': 540, 'type': 'tx'},
>> + {'id': 2, 'ifindex': 13, 'napi-id': 541, 'type': 'tx'},
>> + {'id': 3, 'ifindex': 13, 'napi-id': 542, 'type': 'tx'},
>> + {'id': 4, 'ifindex': 13, 'napi-id': 543, 'type': 'tx'}]
>> +
>> +$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml 
>> --dump napi-get --json='{"ifindex": 13}'
>> +[{'id': 543, 'ifindex': 13, 'irq': 42},
>> + {'id': 542, 'ifindex': 13, 'irq': 41},
>> + {'id': 541, 'ifindex': 13, 'irq': 40},
>> + {'id': 540, 'ifindex': 13, 'irq': 39},
>> + {'id': 539, 'ifindex': 13, 'irq': 36}]
>> +
>> +Here you can clearly observe our channels distribution policy:
>> +
>> +$ ls /proc/irq/{36,39,40,41,42}/mlx5* -d -1
>> +/proc/irq/36/mlx5_comp1@pci:0000:08:00.0
>> +/proc/irq/39/mlx5_comp1@pci:0000:09:00.0
>> +/proc/irq/40/mlx5_comp2@pci:0000:08:00.0
>> +/proc/irq/41/mlx5_comp2@pci:0000:09:00.0
>> +/proc/irq/42/mlx5_comp3@pci:0000:08:00.0
>> +
>> +Steering
>> +========
>> +Secondary PFs are set to "silent" mode, meaning they are disconnected 
>> from the network.
>> +
>> +In RX, the steering tables belong to the primary PF only, and it is 
>> its role to distribute incoming
>> +traffic to other PFs, via cross-vhca steering capabilities. Nothing 
>> special about the RSS table
>> +content, except that it needs a capable device to point to the 
>> receive queues of a different PF.
> 
> I guess you cannot enable the multi-pf for incapable device, so there is
> anything noteworthy in last sentence?
> 

I was asked in earlier patchsets to elaborate on this.

It tells "how" an RSS table looks like on a capable device.
Maybe I should re-phrase to emphasize the point.

It is not straightforward that we still maintain a single RSS table like 
non-multi-PF netdevs. Preserving this (over other complex alternatives) 
is what noteworthy here.

>> +
>> +In TX, the primary PF creates a new TX flow table, which is aliased 
>> by the secondaries, so they can
>> +go out to the network through it.
>> +
>> +In addition, we set default XPS configuration that, based on the cpu, 
>> selects an SQ belonging to the
>> +PF on the same node as the cpu.
>> +
>> +XPS default config example:
>> +
>> +NUMA node(s):          2
>> +NUMA node0 CPU(s):     0-11
>> +NUMA node1 CPU(s):     12-23
>> +
>> +PF0 on node0, PF1 on node1.
>> +
>> +- /sys/class/net/eth2/queues/tx-0/xps_cpus:000001
>> +- /sys/class/net/eth2/queues/tx-1/xps_cpus:001000
>> +- /sys/class/net/eth2/queues/tx-2/xps_cpus:000002
>> +- /sys/class/net/eth2/queues/tx-3/xps_cpus:002000
>> +- /sys/class/net/eth2/queues/tx-4/xps_cpus:000004
>> +- /sys/class/net/eth2/queues/tx-5/xps_cpus:004000
>> +- /sys/class/net/eth2/queues/tx-6/xps_cpus:000008
>> +- /sys/class/net/eth2/queues/tx-7/xps_cpus:008000
>> +- /sys/class/net/eth2/queues/tx-8/xps_cpus:000010
>> +- /sys/class/net/eth2/queues/tx-9/xps_cpus:010000
>> +- /sys/class/net/eth2/queues/tx-10/xps_cpus:000020
>> +- /sys/class/net/eth2/queues/tx-11/xps_cpus:020000
>> +- /sys/class/net/eth2/queues/tx-12/xps_cpus:000040
>> +- /sys/class/net/eth2/queues/tx-13/xps_cpus:040000
>> +- /sys/class/net/eth2/queues/tx-14/xps_cpus:000080
>> +- /sys/class/net/eth2/queues/tx-15/xps_cpus:080000
>> +- /sys/class/net/eth2/queues/tx-16/xps_cpus:000100
>> +- /sys/class/net/eth2/queues/tx-17/xps_cpus:100000
>> +- /sys/class/net/eth2/queues/tx-18/xps_cpus:000200
>> +- /sys/class/net/eth2/queues/tx-19/xps_cpus:200000
>> +- /sys/class/net/eth2/queues/tx-20/xps_cpus:000400
>> +- /sys/class/net/eth2/queues/tx-21/xps_cpus:400000
>> +- /sys/class/net/eth2/queues/tx-22/xps_cpus:000800
>> +- /sys/class/net/eth2/queues/tx-23/xps_cpus:800000
>> +
>> +Mutually exclusive features
>> +===========================
>> +
>> +The nature of Multi-PF, where different channels work with different 
>> PFs, conflicts with
>> +stateful features where the state is maintained in one of the PFs.
>> +For example, in the TLS device-offload feature, special context 
>> objects are created per connection
>> +and maintained in the PF.  Transitioning between different RQs/SQs 
>> would break the feature. Hence,
>> +we disable this combination for now.
> 
>  From the reading I will know what the feature is at the user level.
> 
> After splitting most of the doc out into mlx5 file, and fixing the minor
> typos, feel free to add my:
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 

Thanks.

