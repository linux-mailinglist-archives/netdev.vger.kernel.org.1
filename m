Return-Path: <netdev+bounces-235768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B5CC351E7
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 11:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C9284E5962
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 10:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079313043D1;
	Wed,  5 Nov 2025 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="RGH3D93t"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FC73043C6;
	Wed,  5 Nov 2025 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338961; cv=none; b=GYlbz1i/7y5v2x1M5/peRtRX9l5cxp/9mnQHNribBv4ovj5t0vYXvXpPo5XOUceFahi9QoEaz8wcLV2yqmQxaqR76bBWCNDALKi6yTwEPU5rH/GUDU/LFm+i/b7bJJxKfOW82muV/qbV0SrD2E/YBGvv9KtDAeJLmaC0B+YTErA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338961; c=relaxed/simple;
	bh=nl6nAkWjHQ1vFAep+33KKvxJfu81vmzmEKJOq8pE2e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNqeS4etiP4AKXBVjlaR9Tu7L22KSJfbDGjuH2DdFka9lEv+atxlWeilDVexDN/W9X/0papqmqj6SAtgxWw9qWyb3MB1q2z0ndgoG6dwgeUvnzVKdqe6Y/8EOtBusop6THkKl6dZ0Sb8ngDlxm3wUQKIVYPSbrtpGMPBvlk4K90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=RGH3D93t; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from [129.217.186.196] ([129.217.186.196])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.1.10/8.18.1.10) with ESMTPSA id 5A5AZnXN002213
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 5 Nov 2025 11:35:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1762338950;
	bh=nl6nAkWjHQ1vFAep+33KKvxJfu81vmzmEKJOq8pE2e8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RGH3D93tStoUQgk3tB3XAnwkhxeqIlM1CngmB2hpfIVV/HzT5spzwnfgRSV//xjnm
	 UzSuPnADTGGNTJDpEDwuL0SBtMunOf5oivN0de7TCsa20Q+VcsS6wPj0EhDbs6c4rf
	 sosYHshrl5ypgf2ceQ96ynAX1jm4LsBqxr0en/r0=
Message-ID: <66d22955-bb20-44cf-8ad3-743ae272fec7@tu-dortmund.de>
Date: Wed, 5 Nov 2025 11:35:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v1 1/1] usbnet: Add support for Byte Queue Limits
 (BQL)
To: Eric Dumazet <edumazet@google.com>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251104161327.41004-1-simon.schippers@tu-dortmund.de>
 <20251104161327.41004-2-simon.schippers@tu-dortmund.de>
 <CANn89iL6MjvOc8qEQpeQJPLX0Y3X0HmqNcmgHL4RzfcijPim5w@mail.gmail.com>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <CANn89iL6MjvOc8qEQpeQJPLX0Y3X0HmqNcmgHL4RzfcijPim5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/4/25 18:00, Eric Dumazet wrote:
> On Tue, Nov 4, 2025 at 8:14 AM Simon Schippers
> <simon.schippers@tu-dortmund.de> wrote:
>>
>> The usbnet driver currently relies on fixed transmit queue lengths, which
>> can lead to bufferbloat and large latency spikes under load -
>> particularly with cellular modems.
>> This patch adds support for Byte Queue Limits (BQL) to dynamically manage
>> the transmit queue size and reduce latency without sacrificing
>> throughput.
>>
>> Testing was performed on various devices using the usbnet driver for
>> packet transmission:
>>
>> - DELOCK 66045: USB3 to 2.5 GbE adapter (ax88179_178a)
>> - DELOCK 61969: USB2 to 1 GbE adapter (asix)
>> - Quectel RM520: 5G modem (qmi_wwan)
>> - USB2 Android tethering (cdc_ncm)
>>
>> No performance degradation was observed for iperf3 TCP or UDP traffic,
>> while latency for a prioritized ping application was significantly
>> reduced. For example, using the USB3 to 2.5 GbE adapter, which was fully
>> utilized by iperf3 UDP traffic, the prioritized ping was improved from
>> 1.6 ms to 0.6 ms. With the same setup but with a 100 Mbit/s Ethernet
>> connection, the prioritized ping was improved from 35 ms to 5 ms.
>>
>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>> ---
>>  drivers/net/usb/usbnet.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
>> index 62a85dbad31a..1994f03a78ad 100644
>> --- a/drivers/net/usb/usbnet.c
>> +++ b/drivers/net/usb/usbnet.c
>> @@ -831,6 +831,7 @@ int usbnet_stop(struct net_device *net)
>>
>>         clear_bit(EVENT_DEV_OPEN, &dev->flags);
>>         netif_stop_queue (net);
>> +       netdev_reset_queue(net);
>>
>>         netif_info(dev, ifdown, dev->net,
>>                    "stop stats: rx/tx %lu/%lu, errs %lu/%lu\n",
>> @@ -939,6 +940,7 @@ int usbnet_open(struct net_device *net)
>>         }
>>
>>         set_bit(EVENT_DEV_OPEN, &dev->flags);
>> +       netdev_reset_queue(net);
>>         netif_start_queue (net);
>>         netif_info(dev, ifup, dev->net,
>>                    "open: enable queueing (rx %d, tx %d) mtu %d %s framing\n",
>> @@ -1500,6 +1502,7 @@ netdev_tx_t usbnet_start_xmit(struct sk_buff *skb, struct net_device *net)
>>         case 0:
>>                 netif_trans_update(net);
>>                 __usbnet_queue_skb(&dev->txq, skb, tx_start);
>> +               netdev_sent_queue(net, skb->len);
>>                 if (dev->txq.qlen >= TX_QLEN (dev))
>>                         netif_stop_queue (net);
>>         }
>> @@ -1563,6 +1566,7 @@ static inline void usb_free_skb(struct sk_buff *skb)
>>  static void usbnet_bh(struct timer_list *t)
>>  {
>>         struct usbnet           *dev = timer_container_of(dev, t, delay);
>> +       unsigned int bytes_compl = 0, pkts_compl = 0;
>>         struct sk_buff          *skb;
>>         struct skb_data         *entry;
>>
>> @@ -1574,6 +1578,8 @@ static void usbnet_bh(struct timer_list *t)
>>                                 usb_free_skb(skb);
>>                         continue;
>>                 case tx_done:
>> +                       bytes_compl += skb->len;
>> +                       pkts_compl++;
>>                         kfree(entry->urb->sg);
>>                         fallthrough;
>>                 case rx_cleanup:
>> @@ -1584,6 +1590,8 @@ static void usbnet_bh(struct timer_list *t)
>>                 }
>>         }
>>
>> +       netdev_completed_queue(dev->net, pkts_compl, bytes_compl);
>> +
>>         /* restart RX again after disabling due to high error rate */
>>         clear_bit(EVENT_RX_KILL, &dev->flags);
>>
> 
> I think this is racy. usbnet_bh() can run from two different contexts,
> at the same time (from two cpus)
> 
> 1) From process context :
> usbnet_bh_work()
> 
> 2) From a timer. (dev->delay)
> 
> 
> To use BQL, you will need to add mutual exclusion.

Yeah, I missed that.

I guess synchronizing with the lock of the sk_buff_head dev->done makes
sense? The same locking is also done right before in skb_dequeue.

