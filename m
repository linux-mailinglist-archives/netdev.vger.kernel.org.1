Return-Path: <netdev+bounces-235809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD441C35D87
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 14:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8F23A5F07
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 13:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2A4320393;
	Wed,  5 Nov 2025 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="iLxTtYvi"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91BF31DDBF;
	Wed,  5 Nov 2025 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349355; cv=none; b=FIkFNV8h1XCPnEZc7pjh6CE+SMq5DOIizMWeNy5hcyw8MgfwX3fgbhC7a/HaTzYqQd0CM8sCeBYh5QlUi3iJx/5HeTYfIKO27bC7phcz5ttyE2F+BZDhjMWkQhEIjj3iHTj0CNEuXQce9bp9Gz4pWEmqIAvs/6Fw7T8oIjo4gjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349355; c=relaxed/simple;
	bh=SfJ/gkw4Za8gyVk5g9wXE4LGNptpUuo7yd3jtBKzOt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8IQ+pZl416fLo3xn4GQsBnb+0fWPPS71YgUCKjs/8iDmOqt/9hXqU2rbhLYxabCge0L5NFRIjhjBHE4PLEuaFE2IhS/kQJ5HD31bt7DTTTFFCaJ+q+/q+aJQvJt0PoHTUsIuLAFR1P7Nn8fquXMsmGY7DLKMHX6X2arwIiJPW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=iLxTtYvi; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from [129.217.186.196] ([129.217.186.196])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.1.10/8.18.1.10) with ESMTPSA id 5A5DT5jV025521
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 5 Nov 2025 14:29:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1762349346;
	bh=SfJ/gkw4Za8gyVk5g9wXE4LGNptpUuo7yd3jtBKzOt0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iLxTtYviNdbBh3SORdHRFxc5QUBDRB4EF1kv7ata8qRsIJ+r4DrRE8XLTZJ0c5YyE
	 fV5ru0xLkT9BXPtY/J2rMo0Nm6rfmQf7V59trjE17pKxXDfjI0GQ8z/Xw7+h/xSFg9
	 moREl7J0AaZfuDvCSvxQKCd4kWXR0Qb38FORR+es=
Message-ID: <9ebd72d0-5ae9-4844-b0be-5629c52e6df8@tu-dortmund.de>
Date: Wed, 5 Nov 2025 14:29:05 +0100
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
 <66d22955-bb20-44cf-8ad3-743ae272fec7@tu-dortmund.de>
 <CANn89i+oGnt=Gpo1hZh+8uaEoK3mKLQY-gszzHWC+A2enXa7Tw@mail.gmail.com>
 <be77736d-6fde-4f48-b774-f7067a826656@tu-dortmund.de>
 <CANn89iJVW-_qLbUehhJNJO70PRuw1SZVQX0towgZ4K-JvsPKkw@mail.gmail.com>
 <c01c12a8-c19c-4b9f-94d1-2a106e65a074@tu-dortmund.de>
 <CANn89iJpXwmvg0MOvLo8+hVAhaMTL_1_62Afk_6dG1ZEL3tORQ@mail.gmail.com>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <CANn89iJpXwmvg0MOvLo8+hVAhaMTL_1_62Afk_6dG1ZEL3tORQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/5/25 14:05, Eric Dumazet wrote:
> On Wed, Nov 5, 2025 at 4:58 AM Simon Schippers
> <simon.schippers@tu-dortmund.de> wrote:
>>
>> On 11/5/25 13:34, Eric Dumazet wrote:
>>> On Wed, Nov 5, 2025 at 4:20 AM Simon Schippers
>>> <simon.schippers@tu-dortmund.de> wrote:
>>>>
>>>> On 11/5/25 12:28, Eric Dumazet wrote:
>>>>> On Wed, Nov 5, 2025 at 2:35 AM Simon Schippers
>>>>> <simon.schippers@tu-dortmund.de> wrote:
>>>>>>
>>>>>> On 11/4/25 18:00, Eric Dumazet wrote:
>>>>>>> On Tue, Nov 4, 2025 at 8:14 AM Simon Schippers
>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
>>>>>>>>
>>>>>>>> The usbnet driver currently relies on fixed transmit queue lengths, which
>>>>>>>> can lead to bufferbloat and large latency spikes under load -
>>>>>>>> particularly with cellular modems.
>>>>>>>> This patch adds support for Byte Queue Limits (BQL) to dynamically manage
>>>>>>>> the transmit queue size and reduce latency without sacrificing
>>>>>>>> throughput.
>>>>>>>>
>>>>>>>> Testing was performed on various devices using the usbnet driver for
>>>>>>>> packet transmission:
>>>>>>>>
>>>>>>>> - DELOCK 66045: USB3 to 2.5 GbE adapter (ax88179_178a)
>>>>>>>> - DELOCK 61969: USB2 to 1 GbE adapter (asix)
>>>>>>>> - Quectel RM520: 5G modem (qmi_wwan)
>>>>>>>> - USB2 Android tethering (cdc_ncm)
>>>>>>>>
>>>>>>>> No performance degradation was observed for iperf3 TCP or UDP traffic,
>>>>>>>> while latency for a prioritized ping application was significantly
>>>>>>>> reduced. For example, using the USB3 to 2.5 GbE adapter, which was fully
>>>>>>>> utilized by iperf3 UDP traffic, the prioritized ping was improved from
>>>>>>>> 1.6 ms to 0.6 ms. With the same setup but with a 100 Mbit/s Ethernet
>>>>>>>> connection, the prioritized ping was improved from 35 ms to 5 ms.
>>>>>>>>
>>>>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>>>>>> ---
>>>>>>>>  drivers/net/usb/usbnet.c | 8 ++++++++
>>>>>>>>  1 file changed, 8 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
>>>>>>>> index 62a85dbad31a..1994f03a78ad 100644
>>>>>>>> --- a/drivers/net/usb/usbnet.c
>>>>>>>> +++ b/drivers/net/usb/usbnet.c
>>>>>>>> @@ -831,6 +831,7 @@ int usbnet_stop(struct net_device *net)
>>>>>>>>
>>>>>>>>         clear_bit(EVENT_DEV_OPEN, &dev->flags);
>>>>>>>>         netif_stop_queue (net);
>>>>>>>> +       netdev_reset_queue(net);
>>>>>>>>
>>>>>>>>         netif_info(dev, ifdown, dev->net,
>>>>>>>>                    "stop stats: rx/tx %lu/%lu, errs %lu/%lu\n",
>>>>>>>> @@ -939,6 +940,7 @@ int usbnet_open(struct net_device *net)
>>>>>>>>         }
>>>>>>>>
>>>>>>>>         set_bit(EVENT_DEV_OPEN, &dev->flags);
>>>>>>>> +       netdev_reset_queue(net);
>>>>>>>>         netif_start_queue (net);
>>>>>>>>         netif_info(dev, ifup, dev->net,
>>>>>>>>                    "open: enable queueing (rx %d, tx %d) mtu %d %s framing\n",
>>>>>>>> @@ -1500,6 +1502,7 @@ netdev_tx_t usbnet_start_xmit(struct sk_buff *skb, struct net_device *net)
>>>>>>>>         case 0:
>>>>>>>>                 netif_trans_update(net);
>>>>>>>>                 __usbnet_queue_skb(&dev->txq, skb, tx_start);
>>>>>>>> +               netdev_sent_queue(net, skb->len);
>>>>>>>>                 if (dev->txq.qlen >= TX_QLEN (dev))
>>>>>>>>                         netif_stop_queue (net);
>>>>>>>>         }
>>>>>>>> @@ -1563,6 +1566,7 @@ static inline void usb_free_skb(struct sk_buff *skb)
>>>>>>>>  static void usbnet_bh(struct timer_list *t)
>>>>>>>>  {
>>>>>>>>         struct usbnet           *dev = timer_container_of(dev, t, delay);
>>>>>>>> +       unsigned int bytes_compl = 0, pkts_compl = 0;
>>>>>>>>         struct sk_buff          *skb;
>>>>>>>>         struct skb_data         *entry;
>>>>>>>>
>>>>>>>> @@ -1574,6 +1578,8 @@ static void usbnet_bh(struct timer_list *t)
>>>>>>>>                                 usb_free_skb(skb);
>>>>>>>>                         continue;
>>>>>>>>                 case tx_done:
>>>>>>>> +                       bytes_compl += skb->len;
>>>>>>>> +                       pkts_compl++;
>>>>>>>>                         kfree(entry->urb->sg);
>>>>>>>>                         fallthrough;
>>>>>>>>                 case rx_cleanup:
>>>>>>>> @@ -1584,6 +1590,8 @@ static void usbnet_bh(struct timer_list *t)
>>>>>>>>                 }
>>>>>>>>         }
>>>>>>>>
>>>>>>>> +       netdev_completed_queue(dev->net, pkts_compl, bytes_compl);
>>>>>>>> +
>>>>>>>>         /* restart RX again after disabling due to high error rate */
>>>>>>>>         clear_bit(EVENT_RX_KILL, &dev->flags);
>>>>>>>>
>>>>>>>
>>>>>>> I think this is racy. usbnet_bh() can run from two different contexts,
>>>>>>> at the same time (from two cpus)
>>>>>>>
>>>>>>> 1) From process context :
>>>>>>> usbnet_bh_work()
>>>>>>>
>>>>>>> 2) From a timer. (dev->delay)
>>>>>>>
>>>>>>>
>>>>>>> To use BQL, you will need to add mutual exclusion.
>>>>>>
>>>>>> Yeah, I missed that.
>>>>>>
>>>>>> I guess synchronizing with the lock of the sk_buff_head dev->done makes
>>>>>> sense? The same locking is also done right before in skb_dequeue.
>>>>>
>>>>> Or only protect the netdev_completed_queue(dev->net, pkts_compl,
>>>>> bytes_compl) call,
>>>>> adding a specific/dedicated spinlock for this purpose.
>>>>>
>>>>> spin_lock_bh(&dev->bql_spinlock);
>>>>> netdev_completed_queue(dev->net, pkts_compl, bytes_compl);
>>>>> spin_unlock_bh(&dev->bql_spinlock);
>>>>>
>>>>> I am assuming no usbnet driver is setting dev->lltx = true (or plan to
>>>>> in the future)
>>>>> so usbnet_start_xmit() is protected by HARD_TX_LOCK() already.
>>>>
>>>> Yes, I also want to only protect the netdev_completed_queue(dev->net,
>>>> pkts_compl, bytes_compl) call. However, I am wondering what you mean with
>>>>
>>>> spin_lock_bh(&dev->bql_spinlock)
>>>> ...
>>>>
>>>>
>>>> Do we want to protect against usbnet_start_xmit()? Maybe I am missing
>>>> something, but other BQL implementations also do not seem to protect
>>>> against their respective ndo_start_xmit.
>>>
>>> BQL has been designed so that producer/consumer can run in //
>>>
>>> However, all producers need exclusion (typically done with HARD_TX_LOCK)
>>> All consumers need exclusion (typically done because of NAPI sched bit)
>>>
>>>>
>>>>
>>>> My approach would just protect against usbnet_bh calls from another
>>>> context with the same locking as skb_dequeue():
>>>>
>>>> spin_lock_irqsave(&list->lock, flags);
>>>> netdev_completed_queue(dev->net, pkts_compl, bytes_compl);
>>>> spin_unlock_irqrestore(&list->lock, flags);
>>>
>>> I tend to prefer not masking hard irq unless really necessary.
>>>
>>> Also, reusing  a lock for different purposes makes things confusing
>>> in terms of code maintenance.
>>>
>>> usbnet is hardly performance critical, I would keep list->lock only to
>>> protect the list of skbs :)
>>
>> Thanks for the clarification!
>>
>>
>> So in usbnet.h I will just
>>
>> #include <linux/spinlock.h>
>>
>> and then save the new field
>>
>> spinlock_t bql_spinlock;
>>
>> in struct usbnet and will then call
>>
>> spin_lock_bh(&dev->bql_spinlock);
>> netdev_completed_queue(dev->net, pkts_compl, bytes_compl);
>> spin_unlock_bh(&dev->bql_spinlock);
>>
>> in usbnet_bh. Am I right?
> 
> You also need to spin_lock_init() this new lock in setup phase (usbnet_probe)
> 

Yes, thanks.

> Test/Run your code after enabling LOCKDEP in your .config
> (CONFIG_PROVE_LOCKING=y)

Okay, I will test the new code :)

