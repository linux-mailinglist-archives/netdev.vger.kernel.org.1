Return-Path: <netdev+bounces-203385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 904FCAF5B61
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D7C1C42939
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B482307AEB;
	Wed,  2 Jul 2025 14:41:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A4A28A731;
	Wed,  2 Jul 2025 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467286; cv=none; b=lyDj2AB2QQ7nVfnIjDsM3Hg7caC0bq68i1W8e0V+Cc/hSpv0Vnwx0efS2A9CFhFX3QQR/60bOUn6XELm4mjAGPV8eJf96Lsr82avr5k3ydaNMNF8/sxEe76z/TBBHtPrvqiG526yP6gijvAGDOhvr3Sg2hba4dZZcagKy3Ovp3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467286; c=relaxed/simple;
	bh=jzvkyESIt3QgR/cZefa4IBA7Sg1MyuZzZ05SLDXDmMU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QLD2c7FAk5xuaFoJC7P6RXPuin5BKdTVytWTiD05J0i89wrW+FkMUz4BgTYuFLphhAXOwC0srEPGecJEt/rDAUrRO8tAL1y7SZ/YLzXmNW7fuOiD75wkpZVny+/iljxagrjJwwKD9NEgAB1im2Y2F1d6bLDBgIfViUfHIHoa4/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4535fbe0299so26957685e9.3;
        Wed, 02 Jul 2025 07:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751467282; x=1752072082;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndTHFVVhixBgD3rkZfrRCvShiIGpBMTqyDWYOFCUEw8=;
        b=eBhH1AXQW3Lb99UZIxHx/KHjAu/QkY+diypiaErHL4LPUNR19NZB8WFNu1eLhBxOtg
         5G0qVn16aM7ed7u94SakIar/3TLIIFni8Z9NAOhIz8AWCvZl9ZXRQqUdGthIFY9PqtX0
         RQCh7tAkXzucju+TY76CrQz56DDtEVcwUT03wDS2ukmeMVAJdNJc/JK1vhrggNvsFdB8
         Yy9eyCkE76XrL5YTsuQcSBJAYnlOTkfvnPYFI7GPQ5gFRFq74Plkgk8dpnGjd0iauQhp
         uxKvHSbuQr3i/XeYZXLboTPB3gMd1QY6kU5pCgnUSak2GDsF4SH7nivWNJYafMfUYDM0
         Xqwg==
X-Forwarded-Encrypted: i=1; AJvYcCU5lVfGeiMJDJLLJP94cNQdlfY+JZaBTsdYctEpL/q7BowunoTKrMcYcJel1WZ9BlHmHGpNcfBKb++mrxA=@vger.kernel.org, AJvYcCW6q/7j/QThuOP8tD4vhJdpaGI2ImMvRUWq8b4rMqOyYrXyswfLd4PaWtw0VrZbLT7CfUPbooX+@vger.kernel.org
X-Gm-Message-State: AOJu0YxrcLoncb1MldAtG/6aga5N3keSFCIlhof0D2mFWwIPROdhc1iW
	dn300K/qUqHKUjukcVwVoRt4rbV+fCn1xewyC7RdQ8g2pK4maWY52eqp
X-Gm-Gg: ASbGncvt5odKPO2vvbZpHeXCfob4ApGecaJIJfYRU/z5b8eQJ2TFEDXWo1nAPPOWXBh
	gkjR2UqD5W5v8EjfMNfio0oX7o8COHbFxmx1FHU52qCyemQmFuog8pjGp2nhrX0IePjH4m/a8Zk
	FjHdMPrvmgO0kdTm12bTgtKGaYZCj83f1Rb/GEQetkMItwfOGe8AGfDg+yVxhcwJR3U3YXQyZO9
	CI6z2fwpkzSaKYcHVwL72BdHk7bQ+ExjnCo7j4qtomcnSIuXfoqgXc7bXE/VVZlBcydeNI3+z2B
	MZRL9HkzaJvf/W7rTY6A+of2DyjezXLKaWmONLFTomwJlayYws6FIet+RzGsFEP0C5rdVDTxUds
	VO/NejHzF0/pwXb240AIpxXX7XICvK34=
X-Google-Smtp-Source: AGHT+IE4gSuJ00dWwEp2sb6cVNAm7Lck2daAPc6pSZT35r8KYYS0E7F2STc6A+aYwtJYUTMQvE0lKQ==
X-Received: by 2002:a05:600c:354b:b0:450:cd50:3c64 with SMTP id 5b1f17b1804b1-454a373b988mr39469445e9.31.1751467282006;
        Wed, 02 Jul 2025 07:41:22 -0700 (PDT)
Received: from [192.168.88.252] (78-80-97-102.customers.tmcz.cz. [78.80.97.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e59736sm16180929f8f.74.2025.07.02.07.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 07:41:21 -0700 (PDT)
Message-ID: <00067667-0329-4d8c-9c9a-a6660806b137@ovn.org>
Date: Wed, 2 Jul 2025 16:41:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next] net: openvswitch: allow providing
 upcall pid for the 'execute' command
To: Flavio Leitner <fbl@sysclose.org>
References: <20250627220219.1504221-1-i.maximets@ovn.org>
 <20250702105316.43017482@uranium>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250702105316.43017482@uranium>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 3:53 PM, Flavio Leitner wrote:
> On Sat, 28 Jun 2025 00:01:33 +0200
> Ilya Maximets <i.maximets@ovn.org> wrote:
> 
>> When a packet enters OVS datapath and there is no flow to handle it,
>> packet goes to userspace through a MISS upcall.  With per-CPU upcall
>> dispatch mechanism, we're using the current CPU id to select the
>> Netlink PID on which to send this packet.  This allows us to send
>> packets from the same traffic flow through the same handler.
>>
>> The handler will process the packet, install required flow into the
>> kernel and re-inject the original packet via OVS_PACKET_CMD_EXECUTE.
>>
>> While handling OVS_PACKET_CMD_EXECUTE, however, we may hit a
>> recirculation action that will pass the (likely modified) packet
>> through the flow lookup again.  And if the flow is not found, the
>> packet will be sent to userspace again through another MISS upcall.
>>
>> However, the handler thread in userspace is likely running on a
>> different CPU core, and the OVS_PACKET_CMD_EXECUTE request is handled
>> in the syscall context of that thread.  So, when the time comes to
>> send the packet through another upcall, the per-CPU dispatch will
>> choose a different Netlink PID, and this packet will end up processed
>> by a different handler thread on a different CPU.
> 
> 
> The per-CPU dispatch mode is supposed to rely on the CPU context, 
> which according with what you said above, it is working okay on 
> the first MISS. However, when we hit a recirculation action and 
> there is another MISS, another thread from another CPU context 
> is selected, why?

Because the second miss is happening while processing OVS_PACKET_CMD_EXECUTE,
which is happening in a syscall context of a userspace handler thread, which
is running on a different CPU.

> 
> Thanks,
> Flavio
> 
>>
>> The process continues as long as there are new recirculations, each
>> time the packet goes to a different handler thread before it is sent
>> out of the OVS datapath to the destination port.  In real setups the
>> number of recirculations can go up to 4 or 5, sometimes more.
>>
>> There is always a chance to re-order packets while processing upcalls,
>> because userspace will first install the flow and then re-inject the
>> original packet.  So, there is a race window when the flow is already
>> installed and the second packet can match it and be forwarded to the
>> destination before the first packet is re-injected.  But the fact that
>> packets are going through multiple upcalls handled by different
>> userspace threads makes the reordering noticeably more likely, because
>> we not only have a race between the kernel and a userspace handler
>> (which is hard to avoid), but also between multiple userspace
>> handlers.
>>
>> For example, let's assume that 10 packets got enqueued through a MISS
>> upcall for handler-1, it will start processing them, will install the
>> flow into the kernel and start re-injecting packets back, from where
>> they will go through another MISS to handler-2.  Handler-2 will
>> install the flow into the kernel and start re-injecting the packets,
>> while handler-1 continues to re-inject the last of the 10 packets,
>> they will hit the flow installed by handler-2 and be forwarded
>> without going to the handler-2, while handler-2 still re-injects the
>> first of these 10 packets.  Given multiple recirculations and misses,
>> these 10 packets may end up completely mixed up on the output from
>> the datapath.
>>
>> Let's allow userspace to specify on which Netlink PID the packets
>> should be upcalled while processing OVS_PACKET_CMD_EXECUTE.
>> This makes it possible to ensure that all the packets are processed
>> by the same handler thread in the userspace even with them being
>> upcalled multiple times in the process.  Packets will remain in order
>> since they will be enqueued to the same socket and re-injected in the
>> same order.  This doesn't eliminate re-ordering as stated above, since
>> we still have a race between kernel and the userspace thread, but it
>> allows to eliminate races between multiple userspace threads.
>>
>> Userspace knows the PID of the socket on which the original upcall is
>> received, so there is no need to send it up from the kernel.
>>
>> Solution requires storing the value somewhere for the duration of the
>> packet processing.  There are two potential places for this: our skb
>> extension or the per-CPU storage.  It's not clear which is better,
>> so just following currently used scheme of storing this kind of things
>> along the skb.
>>
>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
>> ---
>>  include/uapi/linux/openvswitch.h |  6 ++++++
>>  net/openvswitch/actions.c        |  6 ++++--
>>  net/openvswitch/datapath.c       | 10 +++++++++-
>>  net/openvswitch/datapath.h       |  3 +++
>>  net/openvswitch/vport.c          |  1 +
>>  5 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/uapi/linux/openvswitch.h
>> b/include/uapi/linux/openvswitch.h index 3a701bd1f31b..3092c2c6f1d2
>> 100644 --- a/include/uapi/linux/openvswitch.h
>> +++ b/include/uapi/linux/openvswitch.h
>> @@ -186,6 +186,11 @@ enum ovs_packet_cmd {
>>   * %OVS_PACKET_ATTR_USERSPACE action specify the Maximum received
>> fragment
>>   * size.
>>   * @OVS_PACKET_ATTR_HASH: Packet hash info (e.g. hash, sw_hash and
>> l4_hash in skb).
>> + * @OVS_PACKET_ATTR_UPCALL_PID: Netlink PID to use for upcalls while
>> + * processing %OVS_PACKET_CMD_EXECUTE.  Takes precedence over all
>> other ways
>> + * to determine the Netlink PID including %OVS_USERSPACE_ATTR_PID,
>> + * %OVS_DP_ATTR_UPCALL_PID, %OVS_DP_ATTR_PER_CPU_PIDS and the
>> + * %OVS_VPORT_ATTR_UPCALL_PID.
>>   *
>>   * These attributes follow the &struct ovs_header within the Generic
>> Netlink
>>   * payload for %OVS_PACKET_* commands.
>> @@ -205,6 +210,7 @@ enum ovs_packet_attr {
>>  	OVS_PACKET_ATTR_MRU,	    /* Maximum received IP
>> fragment size. */ OVS_PACKET_ATTR_LEN,	    /* Packet size
>> before truncation. */ OVS_PACKET_ATTR_HASH,	    /* Packet
>> hash. */
>> +	OVS_PACKET_ATTR_UPCALL_PID, /* u32 Netlink PID. */
>>  	__OVS_PACKET_ATTR_MAX
>>  };
>>  
>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>> index 3add108340bf..2832e0794197 100644
>> --- a/net/openvswitch/actions.c
>> +++ b/net/openvswitch/actions.c
>> @@ -941,8 +941,10 @@ static int output_userspace(struct datapath *dp,
>> struct sk_buff *skb, break;
>>  
>>  		case OVS_USERSPACE_ATTR_PID:
>> -			if (dp->user_features &
>> -			    OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
>> +			if (OVS_CB(skb)->upcall_pid)
>> +				upcall.portid =
>> OVS_CB(skb)->upcall_pid;
>> +			else if (dp->user_features &
>> +				 OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
>>  				upcall.portid =
>>  				  ovs_dp_get_upcall_portid(dp,
>>  							   smp_processor_id());
>> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
>> index b990dc83504f..ec08ce72f439 100644
>> --- a/net/openvswitch/datapath.c
>> +++ b/net/openvswitch/datapath.c
>> @@ -267,7 +267,9 @@ void ovs_dp_process_packet(struct sk_buff *skb,
>> struct sw_flow_key *key) memset(&upcall, 0, sizeof(upcall));
>>  		upcall.cmd = OVS_PACKET_CMD_MISS;
>>  
>> -		if (dp->user_features &
>> OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
>> +		if (OVS_CB(skb)->upcall_pid)
>> +			upcall.portid = OVS_CB(skb)->upcall_pid;
>> +		else if (dp->user_features &
>> OVS_DP_F_DISPATCH_UPCALL_PER_CPU) upcall.portid =
>>  			    ovs_dp_get_upcall_portid(dp,
>> smp_processor_id()); else
>> @@ -616,6 +618,7 @@ static int ovs_packet_cmd_execute(struct sk_buff
>> *skb, struct genl_info *info) struct sw_flow_actions *sf_acts;
>>  	struct datapath *dp;
>>  	struct vport *input_vport;
>> +	u32 upcall_pid = 0;
>>  	u16 mru = 0;
>>  	u64 hash;
>>  	int len;
>> @@ -651,6 +654,10 @@ static int ovs_packet_cmd_execute(struct sk_buff
>> *skb, struct genl_info *info) !!(hash & OVS_PACKET_HASH_L4_BIT));
>>  	}
>>  
>> +	if (a[OVS_PACKET_ATTR_UPCALL_PID])
>> +		upcall_pid =
>> nla_get_u32(a[OVS_PACKET_ATTR_UPCALL_PID]);
>> +	OVS_CB(packet)->upcall_pid = upcall_pid;
>> +
>>  	/* Build an sw_flow for sending this packet. */
>>  	flow = ovs_flow_alloc();
>>  	err = PTR_ERR(flow);
>> @@ -719,6 +726,7 @@ static const struct nla_policy
>> packet_policy[OVS_PACKET_ATTR_MAX + 1] = { [OVS_PACKET_ATTR_PROBE] =
>> { .type = NLA_FLAG }, [OVS_PACKET_ATTR_MRU] = { .type = NLA_U16 },
>>  	[OVS_PACKET_ATTR_HASH] = { .type = NLA_U64 },
>> +	[OVS_PACKET_ATTR_UPCALL_PID] = { .type = NLA_U32 },
>>  };
>>  
>>  static const struct genl_small_ops dp_packet_genl_ops[] = {
>> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
>> index cfeb817a1889..db0c3e69d66c 100644
>> --- a/net/openvswitch/datapath.h
>> +++ b/net/openvswitch/datapath.h
>> @@ -121,6 +121,8 @@ struct datapath {
>>   * @cutlen: The number of bytes from the packet end to be removed.
>>   * @probability: The sampling probability that was applied to this
>> skb; 0 means
>>   * no sampling has occurred; U32_MAX means 100% probability.
>> + * @upcall_pid: Netlink socket PID to use for sending this packet to
>> userspace;
>> + * 0 means "not set" and default per-CPU or per-vport dispatch
>> should be used. */
>>  struct ovs_skb_cb {
>>  	struct vport		*input_vport;
>> @@ -128,6 +130,7 @@ struct ovs_skb_cb {
>>  	u16			acts_origlen;
>>  	u32			cutlen;
>>  	u32			probability;
>> +	u32			upcall_pid;
>>  };
>>  #define OVS_CB(skb) ((struct ovs_skb_cb *)(skb)->cb)
>>  
>> diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
>> index 8732f6e51ae5..6bbbc16ab778 100644
>> --- a/net/openvswitch/vport.c
>> +++ b/net/openvswitch/vport.c
>> @@ -501,6 +501,7 @@ int ovs_vport_receive(struct vport *vport, struct
>> sk_buff *skb, OVS_CB(skb)->mru = 0;
>>  	OVS_CB(skb)->cutlen = 0;
>>  	OVS_CB(skb)->probability = 0;
>> +	OVS_CB(skb)->upcall_pid = 0;
>>  	if (unlikely(dev_net(skb->dev) !=
>> ovs_dp_get_net(vport->dp))) { u32 mark;
>>  
> 


