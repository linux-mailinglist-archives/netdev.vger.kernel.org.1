Return-Path: <netdev+bounces-212335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF61B1F608
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 21:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A6D189A338
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 19:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3ED204C0C;
	Sat,  9 Aug 2025 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="CtykW8c3"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8556E2E36EE;
	Sat,  9 Aug 2025 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754768355; cv=none; b=Z3hF4KGTPrg/cc7ECb1joVqooD4M0g+RilcaTG3mSBY3BlpjMIWcnVUKlf7EI8pAJJ9xxXcMBRFdKWM5WViyU6doyDr7xh8OS/Y9O6cCVsjHVAUIlBJuIAIDMJZfTfQvzwmXspcGNRFxTMXzUx/g0SnTOgjz9ECslBxV9w+I6YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754768355; c=relaxed/simple;
	bh=zzXagsdZjyMJCSLzaIeqtrRNOPlpf/3Jd863TtCs83c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nlV4+EwnhneUirAh1x6rN2gfHkI41DlvWvGjENZOTeKYw67FTWPIEH21/dwI2yIkwzkWmRx7/Aox+2uiTAbd02A44XLFXqwsMwjx0B+0zrFe+rqELsa/NEyTjeINHkIFbYgkxTEj3ncnZmjaor1ywwjVyEo95GeXDFTgv61z/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (2048-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=CtykW8c3; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from tu-ex02.tu-dortmund.de (tu-ex02.tu-dortmund.de [129.217.131.228])
	by unimail.uni-dortmund.de (8.18.1.10/8.18.1.10) with ESMTPS id 579Jd1h3012867
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 9 Aug 2025 21:39:01 +0200 (CEST)
Authentication-Results: unimail.uni-dortmund.de;
	dkim=pass (2048-bit key, unprotected) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=1 header.b=CtykW8c3
DKIM-Signature: v=1; a=rsa-sha256; d=tu-dortmund.de; s=1; c=relaxed/relaxed;
	t=1754768340; h=from:subject:to:date:message-id;
	bh=yAtA+z6YtDJtuD8j8AwpzA/1En2QzWhwPNHnJVal6A4=;
	b=CtykW8c36+3TckHRD8Q0qvk+ATjzac56399SNTPbZ6bNcC2eH2hxiXv+RLn0nHLmffqWjIsS15s
	ZiA5k6nKkco7UTiDbxgDOEvGc90K+PZcvO7hY6t8dJRsu4OvNOOtDUPXLOddYcioF8KlJKgcjY0JF
	rv5FHkNsZVTJYaTy0177m1md19EKooeccB7kfP80SXOLC/kYNSO3QqYhDwDAmdKHDpRr7b+Rjwjcf
	DCGUPyfKxSKcGBJvQ0W7XtEjAFYyDvSX7zKaB6bv3XzvbKxr/uTZGxLxoncCM9Xi8UiE3u/YSWy6Y
	5teNOuG0jsbgkOPOCth3lWltBUETQXBJBfCw==
Received: from [192.168.178.143] (129.217.131.221) by tu-ex02.tu-dortmund.de
 (2001:638:50d:2000::228) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.57; Sat, 9 Aug
 2025 21:39:00 +0200
Message-ID: <5ecb2214-db34-43c3-b51a-1c7a2f8d8e50@tu-dortmund.de>
Date: Sat, 9 Aug 2025 21:39:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net] TUN/TAP: Improving throughput and latency by avoiding SKB
 drops
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Tim Gebauer <tim.gebauer@tu-dortmund.de>
References: <20250808153721.261334-1-simon.schippers@tu-dortmund.de>
 <689757e093982_2ad3722945f@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <689757e093982_2ad3722945f@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: tu-ex05.tu-dortmund.de (2001:638:50d:2000::231) To
 tu-ex02.tu-dortmund.de (2001:638:50d:2000::228)

Willem de Bruijn wrote:
> Simon Schippers wrote:
>> This patch is the result of our paper with the title "The NODROP Patch:
>> Hardening Secure Networking for Real-time Teleoperation by Preventing
>> Packet Drops in the Linux TUN Driver" [1].
>> It deals with the tun_net_xmit function which drops SKB's with the reaso=
n
>> SKB_DROP_REASON_FULL_RING whenever the tx_ring (TUN queue) is full,
>> resulting in reduced TCP performance and packet loss for bursty video
>> streams when used over VPN's.
>>
>> The abstract reads as follows:
>> "Throughput-critical teleoperation requires robust and low-latency
>> communication to ensure safety and performance. Often, these kinds of
>> applications are implemented in Linux-based operating systems and transm=
it
>> over virtual private networks, which ensure encryption and ease of use b=
y
>> providing a dedicated tunneling interface (TUN) to user space
>> applications. In this work, we identified a specific behavior in the Lin=
ux
>> TUN driver, which results in significant performance degradation due to
>> the sender stack silently dropping packets. This design issue drasticall=
y
>> impacts real-time video streaming, inducing up to 29 % packet loss with
>> noticeable video artifacts when the internal queue of the TUN driver is
>> reduced to 25 packets to minimize latency. Furthermore, a small queue
>
> This clearly increases dropcount. Does it meaningfully reduce latency?
>
> The cause of latency here is scheduling of the process reading from
> the tun FD.
>
> Task pinning and/or adjusting scheduler priority/algorithm/etc. may
> be a more effective and robust approach to reducing latency.
>

Thank you for your answer!

In our case, we consider latencies mainly on the application level
end-to-end, e.g., a UDP real-time video stream. There, high latencies
mostly occur due to buffer bloat in the lower layers like the TUN driver.
Example:
--> A VPN application using the TUN driver with the default 500 packet TUN
queue and sending packets via a 10Mbit/s interface.
--> Applications try to send a traffic > 10 Mbit/s through the VPN, 1500
Bytes per packet.
--> The TUN queue fills up completely.
--> Approx. Delay =3D (1500Bytes * 500 packets) / (10 Mbit/s / 8 Bit/Byte) =
=3D
600ms
--> We were able to reproduce such huge latencies in our measurements.
Especially in cases of low-latency applications, these buffer/queue sizes
reflect the maximum worst-case latency, which we focus on minimizing.

Just reducing the TUN queue is not an option here as without proper
backpropagation of the congestion to the upper layer application (in this
case through the blocking of the queues), the applications will consider
the TUN network as of "unlimited bandwidth" and will therefor e.g. in case
of TCP treat every dropped packet by the TUN driver as a packet loss
reducing its congestion window. With proper backpropagation, the
application data rate is limited, resulting in no artificial packet loss
and maintaining the data rate close to the achievable maximum.
In addition, the TUN queue should depend on the interface speed which can
change over time (e.g. Wi-Fi, cellular modems).
--> This patch allows to reduce the TUN queue without suffering from drops.
--> It lets the qdisc (e.g. fq_codel) manage the delay.
--> Allows the upper-level application to handle the congestion in its
prefered way instead of deciding to drop its packets.

>> length also drastically reduces the throughput of TCP traffic due to man=
y
>> retransmissions. Instead, with our open-source NODROP Patch, we propose
>> generating backpressure in case of burst traffic or network congestion.
>> The patch effectively addresses the packet-dropping behavior, hardening
>> real-time video streaming and improving TCP throughput by 36 % in high
>> latency scenarios."
>>
>> In addition to the mentioned performance and latency improvements for VP=
N
>> applications, this patch also allows the proper usage of qdisc's. For
>> example a fq_codel can not control the queuing delay when packets are
>> already dropped in the TUN driver. This issue is also described in [2].
>>
>> The performance evaluation of the paper (see Fig. 4) showed a 4%
>> performance hit for a single queue TUN with the default TUN queue size o=
f
>> 500 packets. However it is important to notice that with the proposed
>> patch no packet drop ever occurred even with a TUN queue size of 1 packe=
t.
>> The utilized validation pipeline is available under [3].
>>
>> As the reduction of the TUN queue to a size of down to 5 packets showed =
no
>> further performance hit in the paper, a reduction of the default TUN que=
ue
>> size might be desirable accompanying this patch. A reduction would
>> obviously reduce buffer bloat and memory requirements.
>>
>> Implementation details:
>> - The netdev queue start/stop flow control is utilized.
>> - Compatible with multi-queue by only stopping/waking the specific
>> netdevice subqueue.
>> - No additional locking is used.
>>
>> In the tun_net_xmit function:
>> - Stopping the subqueue is done when the tx_ring gets full after inserti=
ng
>> the SKB into the tx_ring.
>> - In the unlikely case when the insertion with ptr_ring_produce fails, t=
he
>> old dropping behavior is used for this SKB.
>> - In the unlikely case when tun_net_xmit is called even though the tx_ri=
ng
>> is full, the subqueue is stopped once again and NETDEV_TX_BUSY is return=
ed.
>>
>> In the tun_ring_recv function:
>> - Waking the subqueue is done after consuming a SKB from the tx_ring whe=
n
>> the tx_ring is empty. Waking the subqueue when the tx_ring has any
>> available space, so when it is not full, showed crashes in our testing. =
We
>> are open to suggestions.
>> - Especially when the tx_ring is configured to be small, queuing might b=
e
>> stopped in the tun_net_xmit function while at the same time,
>> ptr_ring_consume is not able to grab a packet. This prevents tun_net_xmi=
t
>> from being called again and causes tun_ring_recv to wait indefinitely fo=
r
>> a packet. Therefore, the queue is woken after grabbing a packet if the
>> queuing is stopped. The same behavior is applied in the accompanying wai=
t
>> queue.
>> - Because the tun_struct is required to get the tx_queue into the new tx=
q
>> pointer, the tun_struct is passed in tun_do_read aswell. This is likely
>> faster then trying to get it via the tun_file tfile because it utilizes =
a
>> rcu lock.
>>
>> We are open to suggestions regarding the implementation :)
>> Thank you for your work!
>>
>> [1] Link:
>> https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publication=
s/2
>> 025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
>> [2] Link:
>> https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffect=
ive
>> -on-tun-device
>> [3] Link: https://github.com/tudo-cni/nodrop
>>
>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>> ---
>>  drivers/net/tun.c | 32 ++++++++++++++++++++++++++++----
>>  1 file changed, 28 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index cc6c50180663..e88a312d3c72 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -1023,6 +1023,13 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *s=
kb, struct net_device *dev)
>>
>>      netif_info(tun, tx_queued, tun->dev, "%s %d\n", __func__, skb->len)=
;
>>
>> +    if (unlikely(ptr_ring_full(&tfile->tx_ring))) {
>> +            queue =3D netdev_get_tx_queue(dev, txq);
>> +            netif_tx_stop_queue(queue);
>> +            rcu_read_unlock();
>> +            return NETDEV_TX_BUSY;
>
> returning NETDEV_TX_BUSY is discouraged.
>

I agree with you:
In the unlikely case when the start/stop flow control fails and
tun_net_xmit is called even though the TUN queue is full, it should just
drop the packet.

> In principle pausing the "device" queue for TUN, similar to other
> devices, sounds reasonable, iff the simpler above suggestion is not
> sufficient.
>

The current implementation pauses in the exact moment when the tx_ring
becomes full and that proved to be sufficient in our testing.
Because the tx_ring always saves same size SKB pointers, I do not think we
have to stop the queuing earlier like virtio_net does.

I will adjust the implementation and also fix the general protection fault
in tun_net_xmit caused by the ptr_ring_full call.

> But then preferable to pause before the queue is full, to avoid having
> to return failure. See for instance virtio_net.
>
>> +    }
>> +
>>      /* Drop if the filter does not like it.
>>       * This is a noop if the filter is disabled.
>>       * Filter can be enabled only for the TAP devices. */
>> @@ -1060,13 +1067,16 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *=
skb, struct net_device *dev)
>>
>>      nf_reset_ct(skb);
>>
>> -    if (ptr_ring_produce(&tfile->tx_ring, skb)) {
>> +    queue =3D netdev_get_tx_queue(dev, txq);
>> +    if (unlikely(ptr_ring_produce(&tfile->tx_ring, skb))) {
>> +            netif_tx_stop_queue(queue);
>>              drop_reason =3D SKB_DROP_REASON_FULL_RING;
>>              goto drop;
>>      }
>> +    if (ptr_ring_full(&tfile->tx_ring))
>> +            netif_tx_stop_queue(queue);
>>
>>      /* dev->lltx requires to do our own update of trans_start */
>> -    queue =3D netdev_get_tx_queue(dev, txq);
>>      txq_trans_cond_update(queue);
>>
>>      /* Notify and wake up reader process */
>> @@ -2110,15 +2120,21 @@ static ssize_t tun_put_user(struct tun_struct *t=
un,
>>      return total;
>>  }
>>
>> -static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *er=
r)
>> +static void *tun_ring_recv(struct tun_struct *tun, struct tun_file *tfi=
le, int noblock, int *err)
>>  {
>>      DECLARE_WAITQUEUE(wait, current);
>> +    struct netdev_queue *txq;
>>      void *ptr =3D NULL;
>>      int error =3D 0;
>>
>>      ptr =3D ptr_ring_consume(&tfile->tx_ring);
>>      if (ptr)
>>              goto out;
>> +
>> +    txq =3D netdev_get_tx_queue(tun->dev, tfile->queue_index);
>> +    if (unlikely(netif_tx_queue_stopped(txq)))
>> +            netif_tx_wake_queue(txq);
>> +
>>      if (noblock) {
>>              error =3D -EAGAIN;
>>              goto out;
>> @@ -2131,6 +2147,10 @@ static void *tun_ring_recv(struct tun_file *tfile=
, int noblock, int *err)
>>              ptr =3D ptr_ring_consume(&tfile->tx_ring);
>>              if (ptr)
>>                      break;
>> +
>> +            if (unlikely(netif_tx_queue_stopped(txq)))
>> +                    netif_tx_wake_queue(txq);
>> +
>>              if (signal_pending(current)) {
>>                      error =3D -ERESTARTSYS;
>>                      break;
>> @@ -2147,6 +2167,10 @@ static void *tun_ring_recv(struct tun_file *tfile=
, int noblock, int *err)
>>      remove_wait_queue(&tfile->socket.wq.wait, &wait);
>>
>>  out:
>> +    if (ptr_ring_empty(&tfile->tx_ring)) {
>> +            txq =3D netdev_get_tx_queue(tun->dev, tfile->queue_index);
>> +            netif_tx_wake_queue(txq);
>> +    }
>>      *err =3D error;
>>      return ptr;
>>  }
>> @@ -2165,7 +2189,7 @@ static ssize_t tun_do_read(struct tun_struct *tun,=
 struct tun_file *tfile,
>>
>>      if (!ptr) {
>>              /* Read frames from ring */
>> -            ptr =3D tun_ring_recv(tfile, noblock, &err);
>> +            ptr =3D tun_ring_recv(tun, tfile, noblock, &err);
>>              if (!ptr)
>>                      return err;
>>      }
>> --
>> 2.43.0
>>
>
>

Wichtiger Hinweis: Die Information in dieser E-Mail ist vertraulich. Sie is=
t ausschlie=C3=9Flich f=C3=BCr den Adressaten bestimmt. Sollten Sie nicht d=
er f=C3=BCr diese E-Mail bestimmte Adressat sein, unterrichten Sie bitte de=
n Absender und vernichten Sie diese Mail. Vielen Dank.
Unbeschadet der Korrespondenz per E-Mail, sind unsere Erkl=C3=A4rungen auss=
chlie=C3=9Flich final rechtsverbindlich, wenn sie in herk=C3=B6mmlicher Sch=
riftform (mit eigenh=C3=A4ndiger Unterschrift) oder durch =C3=9Cbermittlung=
 eines solchen Schriftst=C3=BCcks per Telefax erfolgen.

Important note: The information included in this e-mail is confidential. It=
 is solely intended for the recipient. If you are not the intended recipien=
t of this e-mail please contact the sender and delete this message. Thank y=
ou. Without prejudice of e-mail correspondence, our statements are only leg=
ally binding when they are made in the conventional written form (with pers=
onal signature) or when such documents are sent by fax.

