Return-Path: <netdev+bounces-14142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C2373F39D
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 06:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE8A1C20A58
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 04:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2D010EF;
	Tue, 27 Jun 2023 04:45:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C077EDA
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 04:45:03 +0000 (UTC)
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD6CDA;
	Mon, 26 Jun 2023 21:45:00 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
	by mx.sberdevices.ru (Postfix) with ESMTP id CFBAD5FD20;
	Tue, 27 Jun 2023 07:44:58 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1687841098;
	bh=DZNK5j/xeNsVyBBEv+RLRU1x3PU1HApCTn4LArt68Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=fLuVZLz4loF2srtztSqFqfVQX8aWoZ0d8ZsmzBR7YTP80A0nkT6kvSuQu9V8yzlXR
	 m78uJf6V3HAQjk23uo3qYRBDoU5uGUhkcx4CAeZ9P9f4uN7XNkrL6noNkMUQaqFOiN
	 ujpE4nfQ8bBtew7sJsFbfORDYvvHrfs/kQl6MQ0L7hSWvNcsLPGIPGCEwoDGra0Mel
	 /rrRVCkjeG+94MKEpEpAlaWHtynyhANCzu5+OfWQ4SavwPTVUDkOwxJljr79Ktv72g
	 GTOfRYzNGDlIhW+RIvvDeRX+Zly3crfCcDCXW+ObeVIFbcxVpOnF+viDGr4TCdz3zw
	 04UVHaWTIZGOA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	by mx.sberdevices.ru (Postfix) with ESMTP;
	Tue, 27 Jun 2023 07:44:58 +0300 (MSK)
Message-ID: <0a89e51b-0f7f-b64b-c827-7c943d6f08a6@sberdevices.ru>
Date: Tue, 27 Jun 2023 07:39:41 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v4 03/17] vsock/virtio: support to send non-linear skb
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Bobby Eshleman
	<bobby.eshleman@bytedance.com>, <kvm@vger.kernel.org>,
	<virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>, <oxffffaa@gmail.com>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-4-AVKrasnov@sberdevices.ru>
 <3lg4apldxdrpbkgfa2o4wxe4qyayj2h7b2lfcw3q5a7u3hnofi@z2ifmmzt4xpc>
From: Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <3lg4apldxdrpbkgfa2o4wxe4qyayj2h7b2lfcw3q5a7u3hnofi@z2ifmmzt4xpc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/27 02:11:00 #21585463
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 26.06.2023 18:36, Stefano Garzarella wrote:
> On Sat, Jun 03, 2023 at 11:49:25PM +0300, Arseniy Krasnov wrote:
>> For non-linear skb use its pages from fragment array as buffers in
>> virtio tx queue. These pages are already pinned by 'get_user_pages()'
>> during such skb creation.
>>
>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> ---
>> net/vmw_vsock/virtio_transport.c | 37 ++++++++++++++++++++++++++------
>> 1 file changed, 31 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>> index e95df847176b..6053d8341091 100644
>> --- a/net/vmw_vsock/virtio_transport.c
>> +++ b/net/vmw_vsock/virtio_transport.c
>> @@ -100,7 +100,9 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>>     vq = vsock->vqs[VSOCK_VQ_TX];
>>
>>     for (;;) {
>> -        struct scatterlist hdr, buf, *sgs[2];
>> +        /* +1 is for packet header. */
>> +        struct scatterlist *sgs[MAX_SKB_FRAGS + 1];
>> +        struct scatterlist bufs[MAX_SKB_FRAGS + 1];
>>         int ret, in_sg = 0, out_sg = 0;
>>         struct sk_buff *skb;
>>         bool reply;
>> @@ -111,12 +113,35 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>>
>>         virtio_transport_deliver_tap_pkt(skb);
>>         reply = virtio_vsock_skb_reply(skb);
>> +        sg_init_one(&bufs[0], virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
>> +        sgs[out_sg++] = &bufs[0];
> 
> Can we use out_sg also to index bufs (here and in the rest of the code)?
> 
> E.g.
> 
>         sg_init_one(&bufs[out_sg], ...)
>         sgs[out_sg] = &bufs[out_sg];
>         ++out_sg;
> 
>         ...
>             if (skb->len > 0) {
>                 sg_init_one(&bufs[out_sg], skb->data, skb->len);
>                 sgs[out_sg] = &bufs[out_sg];
>                 ++out_sg;
>             }
> 
>         etc...
> 
>> +
> 
> For readability, I would move the smaller branch above:
> 
>         if (!skb_is_nonlinear(skb)) {
>             // small block
>             ...
>         } else {
>             // big block
>             ...
>         }
> 
>> +        if (skb_is_nonlinear(skb)) {
>> +            struct skb_shared_info *si;
>> +            int i;
>> +
>> +            si = skb_shinfo(skb);
>> +
>> +            for (i = 0; i < si->nr_frags; i++) {
>> +                skb_frag_t *skb_frag = &si->frags[i];
>> +                void *va = page_to_virt(skb_frag->bv_page);
>> +
>> +                /* We will use 'page_to_virt()' for userspace page here,
>> +                 * because virtio layer will call 'virt_to_phys()' later
>> +                 * to fill buffer descriptor. We don't touch memory at
>> +                 * "virtual" address of this page.
>> +                 */
>> +                sg_init_one(&bufs[i + 1],
>> +                        va + skb_frag->bv_offset,
>> +                        skb_frag->bv_len);
>> +                sgs[out_sg++] = &bufs[i + 1];
>> +            }
>> +        } else {
>> +            if (skb->len > 0) {
> 
> Should we do the same check (skb->len > 0) for nonlinear skb as well?
> Or do the nonlinear ones necessarily have len > 0?

Yes, non-linear skb always has 'data_len' > 0, e.g. such skbs always have some
data in it.

Thanks, Arseniy

> 
>> +                sg_init_one(&bufs[1], skb->data, skb->len);
>> +                sgs[out_sg++] = &bufs[1];
>> +            }
>>
>    ^
> Blank line that we can remove.
> 
> Stefano
> 
>> -        sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
>> -        sgs[out_sg++] = &hdr;
>> -        if (skb->len > 0) {
>> -            sg_init_one(&buf, skb->data, skb->len);
>> -            sgs[out_sg++] = &buf;
>>         }
>>
>>         ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);
>> -- 
>> 2.25.1
>>
> 

