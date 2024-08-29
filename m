Return-Path: <netdev+bounces-123014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2DA963705
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 02:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A538E285F14
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23472B657;
	Thu, 29 Aug 2024 00:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1u68bvS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B78610B
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 00:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724892472; cv=none; b=Etpog+X2Th8ArbcJPSkKJlwLKeb2snL69spWq4HOH+7oxL3OJZY+veC2VNelXcHwDBwnpbHvaBDWOyTVChhHk2gyXLUoDtAxdCPleBYvacVTNumGlQS1HkroLktqo1hYZs8voxTpylXvjVBaIdwWKs3FF0q7ZKcBsCbN3CL8ZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724892472; c=relaxed/simple;
	bh=6ip9DQJJnUUI+GmLqjIMKoCn7URsTRnTso2ryrenek4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvlTrMGeYa2v82qRkMPufaxjLi0HsrXVVBo5O3p0pro9HjfRlJS+iStJoFmA+Emcil5hi7PRSgnhTPAiQLA9p8WqfSoamtHwwcZ8ECRsPrF76QYMf0/xlcwDUZho7jBIz+0ZyoqICvBLKXhPIDxiTcwtFln/o+pvUBB942zW+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1u68bvS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-201fbd0d7c2so912425ad.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 17:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724892469; x=1725497269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YU5ptuSqGkH46XIF4/25MgAZcAGuO5Y5bxsZWMdl+7o=;
        b=P1u68bvSfG4YdatZArwE8wH0SIPJnmy9G+DzlaXtP85mtJ2IVktam7eLPi7a3Y85a+
         Wl4DF//rWVlKRU1fulLfMatqq18aGoVCqTv3jr0opFYPTEvilwCtbdsGLrkeKXH8T3y7
         H67l5BZIklQjUjEsGiHaDrcnToXGbLo93oQ0mtUVtrusOst+MtI+mHx4bHJBc0I/0zeU
         aRAHZD75kL9Ln2TIuVxvYpjtkvPwKASExataEYRT6lzEEdOxmWueBQaX3jjRinPcingc
         uTGsFebQCY9rpfVlhSlE9pR4ITb1yxZxWj06KTwXF1gBt1GVZQYX8I8hwGPxr604kAJU
         qXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724892469; x=1725497269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YU5ptuSqGkH46XIF4/25MgAZcAGuO5Y5bxsZWMdl+7o=;
        b=KkspyM4X3cqm/KoK1nsAdbjf2Nm9gRCd+Xaq5pqVzu/s5Tw7hhYEr5zwngWkahDMRr
         6X0a8RYNbNMaCTtA6dGchDvnPVvKb+Y2nNPjeK4aXaaM2lB+xJWMu7rmUvLjc+G5booj
         FI1uJGvvnYmO3e3+ArRCiwNrvP6ugc+P/Tk6pR26XyzIRIfbu06WmcybSuuzgdzWJxHR
         TQFNcOUcoyWiVyztjkPBi7bue8Wo93RZeN+62KFvfU+L/FKxS5o7r4O6oGADKvBEGda9
         ab0+FJaghI+a+ftewK2V11OemMNL7sgbVcSOoUsoiufRqZcd9RjhFs23727+azFqXeVk
         AC6A==
X-Forwarded-Encrypted: i=1; AJvYcCUh7f1XRIGuKARE1NNIw9o2OzTqJtmJnoR0DC5Va6nlbVSieh/9BhKeErxccNlRBzWJUMhJSco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wK8qH+8zAUndP4dgKE9YoQxF0VwSoKqPstIA3v0z/VhWX8M8
	DAw4C5I6xExc/2bGSDXu/Wx17r2MRDzdKXknk/EPUumWDtMpmvQ0dJKxoQ==
X-Google-Smtp-Source: AGHT+IHEMrXGr0UVgoPs3byDA2OFcqld2a4LNV+jGX7Dypa9Uk9dJCmX5ssW3qrBEOPUyybYMUE+Dg==
X-Received: by 2002:a17:903:2449:b0:1fd:9105:7dd3 with SMTP id d9443c01a7336-2050c4b6f9amr13245445ad.64.1724892469271;
        Wed, 28 Aug 2024 17:47:49 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:1c59:4088:26ff:3c78? ([2620:10d:c090:500::5:6cee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b332dsm748285ad.37.2024.08.28.17.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 17:47:48 -0700 (PDT)
Message-ID: <59eeb85a-f5a8-49d5-bee7-78d2684a6065@gmail.com>
Date: Wed, 28 Aug 2024 17:47:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] eth: fbnic: Add support to fetch group
 stats
To: Alexander H Duyck <alexander.duyck@gmail.com>,
 "Nelson, Shannon" <shannon.nelson@amd.com>, netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 kernel-team@meta.com, sanmanpradhan@meta.com, sdf@fomichev.me,
 jdamato@fastly.com
References: <20240827205904.1944066-1-mohsin.bashr@gmail.com>
 <20240827205904.1944066-3-mohsin.bashr@gmail.com>
 <36253a7b-3326-4786-8275-e653573e8aed@amd.com>
 <b2d98851b62e1cf18bad0996736cd0b6de265f06.camel@gmail.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <b2d98851b62e1cf18bad0996736cd0b6de265f06.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/28/24 9:41 AM, Alexander H Duyck wrote:
> On Tue, 2024-08-27 at 17:30 -0700, Nelson, Shannon wrote:
>> On 8/27/2024 1:59 PM, Mohsin Bashir wrote:
>>> Add support for group stats for mac. The fbnic_set_counter helps prevent
>>> overriding the default values for counters which are not collected by the device.
>>>
>>> The 'reset' flag in 'get_eth_mac_stats' allows choosing between
>>> resetting the counter to recent most value or fecthing the aggregate
>>> values of counters. This is important to cater for cases such as
>>> device reset.
>>>
>>> The 'fbnic_stat_rd64' read 64b stats counters in a consistent fashion using
>>> high-low-high approach. This allows to isolate cases where counter is
>>> wrapped between the reads.
>>>
>>> Command: ethtool -S eth0 --groups eth-mac
>>> Example Output:
>>> eth-mac-FramesTransmittedOK: 421644
>>> eth-mac-FramesReceivedOK: 3849708
>>> eth-mac-FrameCheckSequenceErrors: 0
>>> eth-mac-AlignmentErrors: 0
>>> eth-mac-OctetsTransmittedOK: 64799060
>>> eth-mac-FramesLostDueToIntMACXmitError: 0
>>> eth-mac-OctetsReceivedOK: 5134513531
>>> eth-mac-FramesLostDueToIntMACRcvError: 0
>>> eth-mac-MulticastFramesXmittedOK: 568
>>> eth-mac-BroadcastFramesXmittedOK: 454
>>> eth-mac-MulticastFramesReceivedOK: 276106
>>> eth-mac-BroadcastFramesReceivedOK: 26119
>>> eth-mac-FrameTooLongErrors: 0
>>>
>>> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
>>> ---
>>> v2: Rebase to the latest
>>>
>>> v1: https://lore.kernel.org/netdev/20240807002445.3833895-1-mohsin.bashr@gmail.com
>>> ---
>>>    drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
>>>    drivers/net/ethernet/meta/fbnic/fbnic.h       |  4 ++
>>>    drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 37 ++++++++++++++
>>>    .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 49 ++++++++++++++++++
>>>    .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 27 ++++++++++
>>>    .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  | 40 +++++++++++++++
>>>    drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 50 +++++++++++++++++++
>>>    drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  3 ++
>>>    8 files changed, 211 insertions(+)
>>>    create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
>>>    create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
>>>
>>> diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
>>> index 37cfc34a5118..ed4533a73c57 100644
>>> --- a/drivers/net/ethernet/meta/fbnic/Makefile
>>> +++ b/drivers/net/ethernet/meta/fbnic/Makefile
>>> @@ -10,6 +10,7 @@ obj-$(CONFIG_FBNIC) += fbnic.o
>>>    fbnic-y := fbnic_devlink.o \
>>>              fbnic_ethtool.o \
>>>              fbnic_fw.o \
>>> +          fbnic_hw_stats.o \
>>>              fbnic_irq.o \
>>>              fbnic_mac.o \
>>>              fbnic_netdev.o \
>>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
>>> index 28d970f81bfc..0f9e8d79461c 100644
>>> --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
>>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
>>> @@ -11,6 +11,7 @@
>>>
>>>    #include "fbnic_csr.h"
>>>    #include "fbnic_fw.h"
>>> +#include "fbnic_hw_stats.h"
>>>    #include "fbnic_mac.h"
>>>    #include "fbnic_rpc.h"
>>>
>>> @@ -47,6 +48,9 @@ struct fbnic_dev {
>>>
>>>           /* Number of TCQs/RCQs available on hardware */
>>>           u16 max_num_queues;
>>> +
>>> +       /* Local copy of hardware statistics */
>>> +       struct fbnic_hw_stats hw_stats;
>>>    };
>>>
>>>    /* Reserve entry 0 in the MSI-X "others" array until we have filled all
>>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
>>> index a64360de0552..21db509acbc1 100644
>>> --- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
>>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
>>> @@ -660,6 +660,43 @@ enum {
>>>    #define FBNIC_SIG_PCS_INTR_MASK                0x11816         /* 0x46058 */
>>>    #define FBNIC_CSR_END_SIG              0x1184e /* CSR section delimiter */
>>>
>>> +#define FBNIC_CSR_START_MAC_STAT       0x11a00
>>> +#define FBNIC_MAC_STAT_RX_BYTE_COUNT_L 0x11a08         /* 0x46820 */
>>> +#define FBNIC_MAC_STAT_RX_BYTE_COUNT_H 0x11a09         /* 0x46824 */
>>> +#define FBNIC_MAC_STAT_RX_ALIGN_ERROR_L \
>>> +                                       0x11a0a         /* 0x46828 */
>>> +#define FBNIC_MAC_STAT_RX_ALIGN_ERROR_H \
>>> +                                       0x11a0b         /* 0x4682c */
>>> +#define FBNIC_MAC_STAT_RX_TOOLONG_L    0x11a0e         /* 0x46838 */
>>> +#define FBNIC_MAC_STAT_RX_TOOLONG_H    0x11a0f         /* 0x4683c */
>>> +#define FBNIC_MAC_STAT_RX_RECEIVED_OK_L        \
>>> +                                       0x11a12         /* 0x46848 */
>>> +#define FBNIC_MAC_STAT_RX_RECEIVED_OK_H        \
>>> +                                       0x11a13         /* 0x4684c */
>>> +#define FBNIC_MAC_STAT_RX_PACKET_BAD_FCS_L \
>>> +                                       0x11a14         /* 0x46850 */
>>> +#define FBNIC_MAC_STAT_RX_PACKET_BAD_FCS_H \
>>> +                                       0x11a15         /* 0x46854 */
>>> +#define FBNIC_MAC_STAT_RX_IFINERRORS_L 0x11a18         /* 0x46860 */
>>> +#define FBNIC_MAC_STAT_RX_IFINERRORS_H 0x11a19         /* 0x46864 */
>>> +#define FBNIC_MAC_STAT_RX_MULTICAST_L  0x11a1c         /* 0x46870 */
>>> +#define FBNIC_MAC_STAT_RX_MULTICAST_H  0x11a1d         /* 0x46874 */
>>> +#define FBNIC_MAC_STAT_RX_BROADCAST_L  0x11a1e         /* 0x46878 */
>>> +#define FBNIC_MAC_STAT_RX_BROADCAST_H  0x11a1f         /* 0x4687c */
>>> +#define FBNIC_MAC_STAT_TX_BYTE_COUNT_L 0x11a3e         /* 0x468f8 */
>>> +#define FBNIC_MAC_STAT_TX_BYTE_COUNT_H 0x11a3f         /* 0x468fc */
>>> +#define FBNIC_MAC_STAT_TX_TRANSMITTED_OK_L \
>>> +                                       0x11a42         /* 0x46908 */
>>> +#define FBNIC_MAC_STAT_TX_TRANSMITTED_OK_H \
>>> +                                       0x11a43         /* 0x4690c */
>>> +#define FBNIC_MAC_STAT_TX_IFOUTERRORS_L \
>>> +                                       0x11a46         /* 0x46918 */
>>> +#define FBNIC_MAC_STAT_TX_IFOUTERRORS_H \
>>> +                                       0x11a47         /* 0x4691c */
>>> +#define FBNIC_MAC_STAT_TX_MULTICAST_L  0x11a4a         /* 0x46928 */
>>> +#define FBNIC_MAC_STAT_TX_MULTICAST_H  0x11a4b         /* 0x4692c */
>>> +#define FBNIC_MAC_STAT_TX_BROADCAST_L  0x11a4c         /* 0x46930 */
>>> +#define FBNIC_MAC_STAT_TX_BROADCAST_H  0x11a4d         /* 0x46934 */
>> These might be more readable if you add another tab between the name and
>> the value, then you wouldn't need to do line wraps.
> We were trying to keep the format consistent from the top of these
> defines to the bottom. If I recall the comment on the byte offset would
> end up going past 80 characters if we shifted that over.
>
>>>    /* PUL User Registers */
>>>    #define FBNIC_CSR_START_PUL_USER       0x31000 /* CSR section delimiter */
>>>    #define FBNIC_PUL_OB_TLP_HDR_AW_CFG    0x3103d         /* 0xc40f4 */
>>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>>> index 7064dfc9f5b0..5d980e178941 100644
>>> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>>> @@ -16,8 +16,57 @@ fbnic_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
>>>                                       sizeof(drvinfo->fw_version));
>>>    }
>>>
>>> +static void fbnic_set_counter(u64 *stat, struct fbnic_stat_counter *counter)
>>> +{
>>> +       if (counter->reported)
>>> +               *stat = counter->value;
>>> +}
>>> +
>>> +static void
>>> +fbnic_get_eth_mac_stats(struct net_device *netdev,
>>> +                       struct ethtool_eth_mac_stats *eth_mac_stats)
>>> +{
>>> +       struct fbnic_net *fbn = netdev_priv(netdev);
>>> +       struct fbnic_mac_stats *mac_stats;
>>> +       struct fbnic_dev *fbd = fbn->fbd;
>>> +       const struct fbnic_mac *mac;
>>> +
>>> +       mac_stats = &fbd->hw_stats.mac;
>>> +       mac = fbd->mac;
>>> +
>>> +       mac->get_eth_mac_stats(fbd, false, &mac_stats->eth_mac);
>>> +
>>> +       fbnic_set_counter(&eth_mac_stats->FramesTransmittedOK,
>>> +                         &mac_stats->eth_mac.FramesTransmittedOK);
>>> +       fbnic_set_counter(&eth_mac_stats->FramesReceivedOK,
>>> +                         &mac_stats->eth_mac.FramesReceivedOK);
>>> +       fbnic_set_counter(&eth_mac_stats->FrameCheckSequenceErrors,
>>> +                         &mac_stats->eth_mac.FrameCheckSequenceErrors);
>>> +       fbnic_set_counter(&eth_mac_stats->AlignmentErrors,
>>> +                         &mac_stats->eth_mac.AlignmentErrors);
>>> +       fbnic_set_counter(&eth_mac_stats->OctetsTransmittedOK,
>>> +                         &mac_stats->eth_mac.OctetsTransmittedOK);
>>> +       fbnic_set_counter(&eth_mac_stats->FramesLostDueToIntMACXmitError,
>>> +                         &mac_stats->eth_mac.FramesLostDueToIntMACXmitError);
>>> +       fbnic_set_counter(&eth_mac_stats->OctetsReceivedOK,
>>> +                         &mac_stats->eth_mac.OctetsReceivedOK);
>>> +       fbnic_set_counter(&eth_mac_stats->FramesLostDueToIntMACRcvError,
>>> +                         &mac_stats->eth_mac.FramesLostDueToIntMACRcvError);
>>> +       fbnic_set_counter(&eth_mac_stats->MulticastFramesXmittedOK,
>>> +                         &mac_stats->eth_mac.MulticastFramesXmittedOK);
>>> +       fbnic_set_counter(&eth_mac_stats->BroadcastFramesXmittedOK,
>>> +                         &mac_stats->eth_mac.BroadcastFramesXmittedOK);
>>> +       fbnic_set_counter(&eth_mac_stats->MulticastFramesReceivedOK,
>>> +                         &mac_stats->eth_mac.MulticastFramesReceivedOK);
>>> +       fbnic_set_counter(&eth_mac_stats->BroadcastFramesReceivedOK,
>>> +                         &mac_stats->eth_mac.BroadcastFramesReceivedOK);
>>> +       fbnic_set_counter(&eth_mac_stats->FrameTooLongErrors,
>>> +                         &mac_stats->eth_mac.FrameTooLongErrors);
>>> +}
>>> +
>>>    static const struct ethtool_ops fbnic_ethtool_ops = {
>>>           .get_drvinfo            = fbnic_get_drvinfo,
>>> +       .get_eth_mac_stats      = fbnic_get_eth_mac_stats,
>>>    };
>>>
>>>    void fbnic_set_ethtool_ops(struct net_device *dev)
>>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
>>> new file mode 100644
>>> index 000000000000..a0acc7606aa1
>>> --- /dev/null
>>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
>>> @@ -0,0 +1,27 @@
>>> +#include "fbnic.h"
>>> +
>>> +u64 fbnic_stat_rd64(struct fbnic_dev *fbd, u32 reg, u32 offset)
>>> +{
>>> +       u32 prev_upper, upper, lower, diff;
>>> +
>>> +       prev_upper = rd32(fbd, reg + offset);
>>> +       lower = rd32(fbd, reg);
>>> +       upper = rd32(fbd, reg + offset);
>>> +
>>> +       diff = upper - prev_upper;
>>> +       if (!diff)
>>> +               return ((u64)upper << 32) | lower;
>> Is there any particular reason you didn't use u64_stats_fetch_begin()
>> and u64_stats_fetch_retry() around these to protect the reads?
>>
>> sln
> The thing is there isn't another thread to race against. The checking
> here is against hardware so it cannot cooperate with the
> stats_fetch_begin/retry.
>
> That said we do have a function that is collecting the 32b register
> stats that we probably do need to add this wrapper for as it has to run
> in the service task to update the stats.
At the moment, the service task is not updating the stats hence, this 
patch should work fine. I'll make sure to include the required support 
in the respective patch when we will start updating stats in the service 
task.

