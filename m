Return-Path: <netdev+bounces-213471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B2AB25305
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 20:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79971C8419E
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 18:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C202E54D8;
	Wed, 13 Aug 2025 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="KUSbWiPx"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A6D303C99;
	Wed, 13 Aug 2025 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755109645; cv=none; b=t4d90Wmzmeki0+GgE47DVWVCTQJRk6ZeGlPVYIg6tvxDGt/w0bHLa3XJccepjyA9fNeEGx5NJ29WqLIZbXnySVyH0QMkNy2L+v8DFFZBKiOm37WRCvAKujSOAuBuY2xJ3jh2oW3KHDH5VvNHwUJcAMEAgU9Qu7cKEX/8NmBc+5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755109645; c=relaxed/simple;
	bh=1fnCtPI9hc9mxoPa4pC7+exlHl5N905T5kmy087sg88=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=COT/MazPSUc+JCKSwj963J4hX30tUwadAETZJZxRy47LQ2r5WlIZJ/qiS61zAYNrBr89ku8fzBigk6AJYUK9cmgEPL7xO6X0Qk14d7q30Qi9UfZEienpnb7pzS5C5sxMoX5n7zVx83U06AqbTX3EyePKqFA0321YL0ALmFtcusU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (2048-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=KUSbWiPx; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from tu-ex02.tu-dortmund.de (tu-ex02.tu-dortmund.de [129.217.131.228])
	by unimail.uni-dortmund.de (8.18.1.10/8.18.1.10) with ESMTPS id 57DIRCGB004857
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 20:27:12 +0200 (CEST)
Authentication-Results: unimail.uni-dortmund.de;
	dkim=pass (2048-bit key, unprotected) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=1 header.b=KUSbWiPx
DKIM-Signature: v=1; a=rsa-sha256; d=tu-dortmund.de; s=1; c=relaxed/relaxed;
	t=1755109632; h=from:subject:to:date:message-id;
	bh=DkPiYN++kSWdtTfK7OsuF/wgCgpjfka4Ys6hx9JKmPw=;
	b=KUSbWiPxEBHzBTkquJOkObCbuMUmMJi12wt8y67q/1LGnoFimtlQ+Imh7vAWAauOaB4nWW3YXla
	4RttCq1vt1xLlAz/QzpUzVjL+nNcMT4iVqaDg4hdOP80GuDlMGZrdB6MTy6y8CdeBDo9fniT2qx5c
	XsnmV1d3ZEAZ3nnnlOx7uQbkN3LNvQTNhB98CKCHWRYjdd3G/3e/5fRE/gMJgUTiWmdZaLXhcro39
	yxSSJY8mWElLOwa6IJsvOJ5tFx6J0fMsiMnsh10pchnb4l5GMqTtXyNamtCTUiMqnHjzCmt+dSFoZ
	cY2HbEX7OIciTdkVbddAtpGgmEmQASLWzwdQ==
Received: from [IPV6:2a01:599:41d:36e2:83f0:e388:1505:7af] (129.217.131.221)
 by tu-ex02.tu-dortmund.de (2001:638:50d:2000::228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.58; Wed, 13 Aug 2025 20:27:11 +0200
Message-ID: <8982048b-f5dc-4fec-bc53-f7ad88fbe199@tu-dortmund.de>
Date: Wed, 13 Aug 2025 20:27:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net v2] TUN/TAP: Improving throughput and latency by avoiding
 SKB drops
To: Jason Wang <jasowang@redhat.com>
CC: <willemdebruijn.kernel@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>
References: <20250811220430.14063-1-simon.schippers@tu-dortmund.de>
 <CACGkMEvqYWH-dcG4ei8dERy_OXvyF3cgrzQ2_YO-imEsPoYSbQ@mail.gmail.com>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <CACGkMEvqYWH-dcG4ei8dERy_OXvyF3cgrzQ2_YO-imEsPoYSbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: tu-ex04.tu-dortmund.de (2001:638:50d:2000::230) To
 tu-ex02.tu-dortmund.de (2001:638:50d:2000::228)

Jason Wang wrote:
> On Tue, Aug 12, 2025 at 6:04=E2=80=AFAM Simon Schippers
> <simon.schippers@tu-dortmund.de> wrote:
>>
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
>>
>> In the tun_ring_recv function:
>> - Waking the subqueue is done after consuming a SKB from the tx_ring whe=
n
>> the tx_ring is empty. Waking the subqueue when the tx_ring has any
>> available space, so when it is not full, showed crashes in our testing. =
We
>> are open to suggestions.
>> - When the tx_ring is configured to be small (for example to hold 1 SKB)=
,
>> queuing might be stopped in the tun_net_xmit function while at the same
>> time, ptr_ring_consume is not able to grab a SKB. This prevents
>> tun_net_xmit from being called again and causes tun_ring_recv to wait
>> indefinitely for a SKB in the blocking wait queue. Therefore, the netdev
>> queue is woken in the wait queue if it has stopped.
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
>
> I would like to see some benchmark results. Not only VPN but also a
> classical VM setup that is using vhost-net + TAP.
>

I completely overlooked that in tap.c there is also a tap_do_read function.
I would like to apologize for that and also implement the same behavior
from the tun_ring_recv function there.
The implementation is already done and it proved to be working but I will
test it a bit more before submitting a v3.

Regarding your proposed vhost-net + TAP setup: I need more time to
implement such a setup. However I am wondering what kind of tests you
would like to see exactly? TCP connections to a remote host like in our
paper?

>> [1] Link:
>> https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publication=
s/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
>> [2] Link:
>> https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffect=
ive-on-tun-device
>> [3] Link: https://github.com/tudo-cni/nodrop
>>
>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>> ---
>> V1 -> V2: Removed NETDEV_TX_BUSY return case in tun_net_xmit and removed
>> unnecessary netif_tx_wake_queue in tun_ring_recv.
>>
>>  drivers/net/tun.c | 21 +++++++++++++++++----
>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index cc6c50180663..81abdd3f9aca 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -1060,13 +1060,16 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *=
skb, struct net_device *dev)
>>
>>         nf_reset_ct(skb);
>>
>> -       if (ptr_ring_produce(&tfile->tx_ring, skb)) {
>> +       queue =3D netdev_get_tx_queue(dev, txq);
>> +       if (unlikely(ptr_ring_produce(&tfile->tx_ring, skb))) {
>> +               netif_tx_stop_queue(queue);
>>                 drop_reason =3D SKB_DROP_REASON_FULL_RING;
>
> This would still drop the packet. Should we detect if the ring is
> about to be full and stop then like a virtio-net?
>
> Thanks
>

I am a bit confused. You omitted the important part of the code which
comes right after that. There I stop the netdev queue when the tx_ring
gets full. Therefore tun_net_xmit is not (very very unlikely) called when
there is no space for another SKB and no SKB's are dropped. It is only
called again after the netdev queue is activated again in the
tun_ring_recv function.

In virtio-net whole SKB's they basically do the same in the tx_may_stop
function. The function is called after inserting a SKB and see if there is
enough space for another max size SKB, which is the same statement as if
their send_queue is full.
Correct me if I am wrong!
Thank you!

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

