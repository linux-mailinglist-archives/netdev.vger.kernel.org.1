Return-Path: <netdev+bounces-284859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKf8KqxJ+2lZYwMAu9opvQ
	(envelope-from <netdev+bounces-284859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:01:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4774DB905
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FD39301410E
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8932425CFE;
	Wed,  6 May 2026 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnG++F4+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pZZEr8ZU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B84657E7
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076066; cv=none; b=blmj+hnOXGkCYhPxb0gjuCEpSTJ001owq7xHH7WRuYmzSs8vYIeV8GLBDdFaKZZqjNz1HmeMvbwDZx0PkH+BRZGWQ31PVDSXQhpwimqdT2KSLtNk2E8ztTnMJ5uNgLQ88PqCpnGomFAgE7RjXTTTv8E2jR8MCz8luUFqbNCL4NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076066; c=relaxed/simple;
	bh=SFiFDucNaRObAcaMrKWI6BPwF1qadwuDj2Vt2SN+ha0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cU6FNrO4+O9yJ2p1N19o/wgQHY+kyDhpofAdsFNT6nd8IAAXJW/bnY0k02IL9/yKYvjyL31/oiOCo6KoEQa54A5XDheuaFEuFEkcPPdU4qQEqosWrQAIWxUBOS23qIfPv04tAcGrfvJ3m9DNh6zS85Nxirhi6hR2xYIgATBYBkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnG++F4+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pZZEr8ZU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778076063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCRVTBZQDAEVaqanV0j4+1ERDgnWXkjidry1aEHpyPY=;
	b=VnG++F4+qAcUHowyf+uyrQVrnL8vykawaSgup+HVcPu2jqO/unY195F++DD+W6t5O/clJf
	WW6M68ILLdcjIuY0x9jK0648YWFw37GMfVYgU+jkfBUiOu9C0Gq5Tt7N1F7j5c76I2p/0f
	Vp/nDhz77bn4EqZNk3PnbjgoUJVRgCk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-dYYeidc_NiC0QmhH1wB2lg-1; Wed, 06 May 2026 10:01:00 -0400
X-MC-Unique: dYYeidc_NiC0QmhH1wB2lg-1
X-Mimecast-MFC-AGG-ID: dYYeidc_NiC0QmhH1wB2lg_1778076058
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-441243ba35fso6374503f8f.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778076058; x=1778680858; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cCRVTBZQDAEVaqanV0j4+1ERDgnWXkjidry1aEHpyPY=;
        b=pZZEr8ZUKt2sr1INjD0Sm9EtriSKQNlCpHIS84lbTd+LIPrO0R1DpQTu443WJ8fq2H
         oN37ucg/iahrMowB4k+1FzkQJPmlHPBXKjCjyn7rbb38qA8QpfrZlqmu6UpnHe1OwxRp
         IlL1I+cqWexEkstWGU+llVhEdHY/4y0ToAVWNq7HfpOlIE8ieocFhND3XyN2PBBLo9mU
         AiUpwTUsB3zcj23MxZ0N4G87uw067bRdsVzZX1w+NPII5TQdA1naUTtWNrIdhwO+fpT9
         yyYY5SAQ1PGiz74ZAOjmaRZ1syPFPA/ncOaDpXy8GEXO+KFi4O+a+8Gs5ZjWGZKcyXTm
         vUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778076058; x=1778680858;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCRVTBZQDAEVaqanV0j4+1ERDgnWXkjidry1aEHpyPY=;
        b=XU0lnYtH3AaoFpOZrpoZM0tDsI7EFfPvHQFCridiiBmtRo8Qtu0LhSFEKQhluZhPjq
         X/12Ev8i/WoiT4Nz1OtKVTivfFsyometfGQGX8PhAFWKw2EUDwvrbcjAY4mBsuNnndZx
         Zkm3REbJ1+EettlWQ5Zlpy6I1OJB1oiPBBOPTvqS7v7dG2Euj27cusKBS9CuTXrVMfxQ
         9xro41IEdi7zVZMUVCuUdOdopn9WpCK1yE8WUzxdHeCdjZ59c8jDDME2CHL8v4EOCTSR
         axheOv+nGPlLq6/f7g6u3t9aB9d5hldOXh0yzogJ6CriCfBKPurARJlDDg+JST5Jh97O
         Jigw==
X-Forwarded-Encrypted: i=1; AFNElJ8TbQ/5Q9ILhSPKeaIZxFohrb9oW5vTacbpmiDpo4QsQUo89wBL8mDPVWH77mkXw0ZxMWs+8tE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2NtWoryI2WmuNlTKMEGZolWa7CA2erJgzh7egBIzoDVqgGz2b
	jfIjoMz6p0VSdwAhQL+2IgZAPtR8wQ+nVnArUNKr1A6xQC2uRzKsTDpH8L7yVd1tcbwwIqsHPqJ
	QLNqib9+5e123BOLzFJMOdRvrIfZGiXuiGVKP77Hj88eHUuLEf59Wh1cbVQ==
X-Gm-Gg: AeBDieujR65JxLeI1sc46Qw/jJCJCX31M48bY+311UarpEdqTECVxLg/bH2nWeoE3Z/
	xiEdqXfELGXB/T9952X0KlLhK8VvxbEHQNnN8+X/rUCdvFGPNj1Fa4KY7OVmG73c1NTxden4zM7
	p1ykIKNQZoWVlyFAO1jHIvXh+ZKauQLXWx1wcbZRyxna/pbRPzK5YkViPHYPdHJuu0/w+X6A4Vb
	YxiybwzA/NMbu2gqEZecO4IgamkmpUDqdv5m0/i/Oj61ypcnglzm0tATMXpnaAOjISPUErdLGFT
	jlPq68PSUsQIn426O2G8isfCW/LV/PyoiKw8tWSlGd/U3TwcsQQr5t3XTCJLW15R9rK37g9wEZ5
	/XJNKt8khXGgBCnxM4E/d+dWHMV85iAq43WMBeTQr2TsxuF7vuJIA3X7zQBa9nyBFCk3IBBJcaQ
	==
X-Received: by 2002:a05:6000:2c03:b0:43d:21a:9a3e with SMTP id ffacd0b85a97d-4515d5c54c0mr5877762f8f.32.1778076057291;
        Wed, 06 May 2026 07:00:57 -0700 (PDT)
X-Received: by 2002:a05:6000:2c03:b0:43d:21a:9a3e with SMTP id ffacd0b85a97d-4515d5c54c0mr5877593f8f.32.1778076056142;
        Wed, 06 May 2026 07:00:56 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055d36dacsm12654112f8f.32.2026.05.06.07.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:00:55 -0700 (PDT)
Date: Wed, 6 May 2026 16:00:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <afs9FsY51D3zRA5N@sgarzare-redhat>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <afocwkfBHJ5u10rx@devvm29614.prn0.facebook.com>
 <e1f32df5-b6a1-47a8-a783-fcc8e3c91f25@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1f32df5-b6a1-47a8-a783-fcc8e3c91f25@salutedevices.com>
X-Rspamd-Queue-Id: 0C4774DB905
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284859-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,google.com,meta.com,redhat.com,davemloft.net,kernel.org,vger.kernel.org,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[sberdevices.ru:query timed out];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[avkrasnov.sberdevices.ru:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oasis-open.org:url]

On Wed, May 06, 2026 at 12:50:04PM +0300, Arseniy Krasnov wrote:
>
>
>05.05.2026 19:37, Bobby Eshleman wrote:
>> On Tue, May 05, 2026 at 06:11:13PM +0200, Stefano Garzarella wrote:
>>> On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
>>>> On Tue, May 5, 2026 at 6:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>>>>
>>>>> On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
>>>>>> virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
>>>>>>
>>>>>> virtio_transport_recv_enqueue() skips coalescing for packets
>>>>>> with VIRTIO_VSOCK_SEQ_EOM.
>>>>>>
>>>>>> If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
>>>>>> a very large number of packets can be queued
>>>>>> because vvs->rx_bytes stays at 0.
>>>>>>
>>>>>> Fix this by estimating the skb metadata size:
>>>>>>
>>>>>>       (Number of skbs in the queue) * SKB_TRUESIZE(0)
>>>>>>
>>>>>> Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>>>>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>>>>> Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>> Cc: Stefano Garzarella <sgarzare@redhat.com>
>>>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>>>> Cc: Jason Wang <jasowang@redhat.com>
>>>>>> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>>>> Cc: "Eugenio Pérez" <eperezma@redhat.com>
>>>>>> Cc: kvm@vger.kernel.org
>>>>>> Cc: virtualization@lists.linux.dev
>>>>>> ---
>>>>>> net/vmw_vsock/virtio_transport_common.c | 4 +++-
>>>>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>>>>> index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
>>>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>>>> @@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>>>>> static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>>>>>>                                       u32 len)
>>>>>> {
>>>>>> -      if (vvs->buf_used + len > vvs->buf_alloc)
>>>>>> +      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>>>>>> +
>>>>>> +      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
>>>>>>               return false;
>>>>>
>>>>> I'm not sure about this fix, I mean that maybe this is incomplete.
>>>>> In virtio-vsock, there is a credit mechanism between the two peers:
>>>>> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003
>>>>>
>>>>> This takes only the payload into account, so it’s true that this problem
>>>>> exists; however, perhaps we should also inform the other peer of a lower
>>>>> credit balance, otherwise the other peer will believe it has much more
>>>>> credit than it actually does, send a large payload, and then the packet
>>>>> will be discarded and the data lost (there are no retransmissions,
>>>>> etc.).
>>>>
>>>> I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
>>>> state to account credit")
>>>> and find a better fix then?
>>>
>>> IIRC the same issue was there before the commit fixed by that one (commit
>>> 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")), so
>>> not sure about reverting it TBH.
>>>
>>> CCing Arseniy and Bobby.
>
>Thanks!
>
>>>
>>>>
>>>> There is always a discrepancy between skb->len and skb->truesize.
>>>> You will not be able to announce a 1MB window, and accept one milliion
>>>> skb of 1-byte each.
>>>>
>>>> This kind of contract is broken.
>>>>
>>>
>>> Yep, I agree, but before we start discarding data (and losing it), IMHO we
>>> should at least inform the other peer that we're out of space.
>>>
>>> @Stefan, @Michael, do you think we can do something in the spec to avoid
>>> this issue and in some way take into account also the metadata in the
>>> credit. I mean to avoid the 1-byte packets flooding.
>>>
>>> Thanks,
>>> Stefano
>>>
>>>
>>
>> Indeed the old pre-fix skb code would have the same issue.
>>
>> I can't think of any way around this without extending the spec.
>
>Hi, thanks, agree with Bobby, that accounting metadata (e.g. skb size here) was not implemented "by
>design" in credit logic - another side of data exchange knows nothing about that. Also the same
>situation was before skb implementation was added by Bobby. So looks like need to update spec may be.
>

Even if we change the specifications, we still need to work with older 
devices, so we should find a solution for this as well.

My main concern is data loss, so I'm considering the following options:

1. Notify the other peer of a smaller buf_alloc from the start, leave 
some room for overhead, and when it's running out, notify them that 
buf_alloc = 0. This way, the peer realizes it can’t send anything else.

2. Or update buf_alloc each time by removing the overhead, similar to 
what’s currently done in virtio_transport_inc_rx_pkt(), but also do it 
in virtio_transport_inc_tx_pkt().

As I said, IMO this patch alone is incomplete; we need to communicate 
with the peer somehow regarding space. I don’t think including the 
overhead in fwd_cnt is spec compliant, since the other peer has no idea 
how much overhead is needed, but reducing buf_alloc should be okay, even 
though I’m concerned about packets in flight.

As a quick fix, I think option 2 might be the easiest; I’ll run some 
tests and send over a patch.

But in the long run, I think we absolutely need to improve memory 
management in vsock, perhaps by avoiding custom solutions.

Thanks,
Stefano


