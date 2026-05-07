Return-Path: <netdev+bounces-285202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FvSIGdX/GmvOQAAu9opvQ
	(envelope-from <netdev+bounces-285202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:12:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6714E5938
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1E58301B92F
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 09:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CCC3B6364;
	Thu,  7 May 2026 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWv2xYON";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb1iyvKb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BA63AB275
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778145012; cv=none; b=OAlZny3+brCm1HcARW+LuQ9TOUtptUW8YmEeT0y3u/f7OyIVycsGIh0/W0RYQI8qVIjGq33BUVwmWab8///hnRw4xrkO2ugwRJHxgiBIn8/qNEQJZcW5TVovC0Bp4O8V0kSyXohVZXpDlIsReicUMVr2/kLDTWWw9t1fAILt3I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778145012; c=relaxed/simple;
	bh=Su7MqlfynL8vSWqkM5vxWmtynu5V1wq3cdMpdL7zE08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMdrAHQ78hJ35frn2iiaCIyZvXlUfblkFaMF6pliNOsinBNTG9Wa8JqmvCBA//QNudf9MZkFZ6ouSm8LsWUNOS0w8w1JsbomEI47GQ+cNQB1w6p/HkNJXOk+cM7idmUHtzQS7x4jxmcZaNbaErE6fD0RktG58eqIfQOBPJ1T+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bWv2xYON; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eb1iyvKb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778145001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0+Dw+cwNE8SIW/NQeUoL6sJg8a8J+n/owA/XlUfbDM=;
	b=bWv2xYONscM92OeCdL00yrt2ta2kVDB5d1oHRxbvx91RgNaBao4VIyY0ohI94XfdNbT42O
	em++TBOyUY1TTJSb37WZgoRpuBe/pxcCIy/h+g6GZeyNjKnIxEWMNEzyjdYYbqtBi1ut/m
	w2U1kjQp5SjhTC7lma1FbIAdo0/5pbY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-EB8XlxYuNW6dy_hlWXOCNQ-1; Thu, 07 May 2026 05:10:00 -0400
X-MC-Unique: EB8XlxYuNW6dy_hlWXOCNQ-1
X-Mimecast-MFC-AGG-ID: EB8XlxYuNW6dy_hlWXOCNQ_1778144999
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44a52d5e572so363746f8f.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 02:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778144999; x=1778749799; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r0+Dw+cwNE8SIW/NQeUoL6sJg8a8J+n/owA/XlUfbDM=;
        b=eb1iyvKbS1Hz0+ztLNwNgMd/5ZzHj91ouzO9jQhldkmdSa7ZEoTsmkavdqqxjZJ0Np
         42fOmJQSg+Al3z8z21M7L/w655Qkt5FvyF+sixHU0S5NQesjs2THbzj1+VLZDNJgONB/
         BJUtDO/fRir82ltWhf83DT1SfGvz9d5aTY3h5bUfSxerf83FCFuj5pAEa+kTOGr2TX/7
         736I8hn0iybLJYdYrh76nyEpw0plstt6W2mI8OYLypOzzbxGcJx9CEuKbfYzxH/7eBXU
         bLnieaDw/itv2XLLsj/DQYvp0rRcaKpgFC1+DL+B9eYN+McJY3/INJbzuKbSgFicnEZP
         SeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778144999; x=1778749799;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0+Dw+cwNE8SIW/NQeUoL6sJg8a8J+n/owA/XlUfbDM=;
        b=jNxDrgc+KeNwn94O/LdlzpCsMLb+Yio1/GcI0cuKzhoh1WUkPrERtsa2iXd5iPiNqS
         82gArQ4XC8Hs41168Nh3GCsglgt2keTfXukUx41ePW5DCEqf8DYgtuOFNPq7UGNu76Q8
         JhKtc4A+LoHHFVz1C/Yqp7QoU/yi7pp0SMTYvaJr1A/fukkcmQZx6LEHpZPvMalU4pN0
         0E0JLfC2VQB1ChqCCha2vp4RPTB0GwBqtKNehFfY04SJc5joW1gzDZq/FLpt5FmzU7iz
         Ug7dLUEdTIu4SueiJfxtRXkfq0YwCtgaHgWBOjl3Tu7+zqJHUwd9HFiTvDIAYScA08oy
         qKaA==
X-Forwarded-Encrypted: i=1; AFNElJ8VI+CZuAxqV8P3jjFvksdbgK7A1PfUhUf8ueNuHQTsKmf+vDASk0nDs2QEwt/maIjJ2a63Mmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOH6n8hPyfG47ZVZeFlGORZF/C71VQjnF8oa4wOGV5q9K3pj+k
	6Mct+tY9+RK2maoKGz5EI3I4fLC0ojDPwtmpsNzorG7H2Kyz0Gm652epO0j6k/ElHnvwbSh53/Y
	UtR15m3gh4F6vAmXTC4svcTmtlmePKgVghlToU0EcRso4ydkaV6N+aXmRPw==
X-Gm-Gg: AeBDieuIMKbWuzSly/CD2MaK7pWJ0VnYCLY4kH44WFVnBcJTqvkxynOyWHeycVlEDBw
	jJqougBFeW/j7F/CArQa4p8pCue9P0A8MDBG2/mf10Cxkxc2jOqY2VXPMsBhuaJtFMgg/1PyUvR
	aWwuCW7yvbxepuftibIUgs0k+XCiBeXFguXRnAmovxuQoVwHOx4V8z7GzINWQtYpQup7d2QVDIW
	5v1gNiaWR3iHpGx0jRVUVCrUUGRbjDnsFGNJrTwmT3z9ZDNuL3CvqPaJCbeJIkimrmcpiSuhfD3
	4M0XI9UAL3mAx2ltVdSF/FTqCAYwIlwD//obPAGuoH3KHvH0ypv9YYGO6i2XAgdwGgQk49ijvDw
	dhYwnCrhasAeAeyjljP2CWg6a1QbgzwlA/r5TfUTcwor7i2uNETqtW6oBSVa1g1/huU1tP5Ls9g
	==
X-Received: by 2002:a05:6000:310a:b0:43b:4f86:e985 with SMTP id ffacd0b85a97d-4515d3dcac9mr11750302f8f.33.1778144998961;
        Thu, 07 May 2026 02:09:58 -0700 (PDT)
X-Received: by 2002:a05:6000:310a:b0:43b:4f86:e985 with SMTP id ffacd0b85a97d-4515d3dcac9mr11750200f8f.33.1778144998234;
        Thu, 07 May 2026 02:09:58 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960973sm18883323f8f.30.2026.05.07.02.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 02:09:57 -0700 (PDT)
Date: Thu, 7 May 2026 11:09:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <afxVH2So9BbZ3Gta@sgarzare-redhat>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506113554-mutt-send-email-mst@kernel.org>
X-Rspamd-Queue-Id: ED6714E5938
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,salutedevices.com,meta.com,redhat.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-285202-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 11:37:45AM -0400, Michael S. Tsirkin wrote:
>On Tue, May 05, 2026 at 06:11:13PM +0200, Stefano Garzarella wrote:
>> On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
>> > On Tue, May 5, 2026 at 6:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> > >
>> > > On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
>> > > >virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
>> > > >
>> > > >virtio_transport_recv_enqueue() skips coalescing for packets
>> > > >with VIRTIO_VSOCK_SEQ_EOM.
>> > > >
>> > > >If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
>> > > >a very large number of packets can be queued
>> > > >because vvs->rx_bytes stays at 0.
>> > > >
>> > > >Fix this by estimating the skb metadata size:
>> > > >
>> > > >       (Number of skbs in the queue) * SKB_TRUESIZE(0)
>> > > >
>> > > >Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>> > > >Signed-off-by: Eric Dumazet <edumazet@google.com>
>> > > >Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> > > >Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> > > >Cc: Stefano Garzarella <sgarzare@redhat.com>
>> > > >Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> > > >Cc: Jason Wang <jasowang@redhat.com>
>> > > >Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> > > >Cc: "Eugenio Pérez" <eperezma@redhat.com>
>> > > >Cc: kvm@vger.kernel.org
>> > > >Cc: virtualization@lists.linux.dev
>> > > >---
>> > > > net/vmw_vsock/virtio_transport_common.c | 4 +++-
>> > > > 1 file changed, 3 insertions(+), 1 deletion(-)
>> > > >
>> > > >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> > > >index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
>> > > >--- a/net/vmw_vsock/virtio_transport_common.c
>> > > >+++ b/net/vmw_vsock/virtio_transport_common.c
>> > > >@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>> > > > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>> > > >                                       u32 len)
>> > > > {
>> > > >-      if (vvs->buf_used + len > vvs->buf_alloc)
>> > > >+      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>> > > >+
>> > > >+      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
>> > > >               return false;
>> > >
>> > > I'm not sure about this fix, I mean that maybe this is incomplete.
>> > > In virtio-vsock, there is a credit mechanism between the two peers:
>> > > https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003
>> > >
>> > > This takes only the payload into account, so it’s true that this problem
>> > > exists; however, perhaps we should also inform the other peer of a lower
>> > > credit balance, otherwise the other peer will believe it has much more
>> > > credit than it actually does, send a large payload, and then the packet
>> > > will be discarded and the data lost (there are no retransmissions,
>> > > etc.).
>> >
>> > I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
>> > state to account credit")
>> > and find a better fix then?
>>
>> IIRC the same issue was there before the commit fixed by that one (commit
>> 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")), so
>> not sure about reverting it TBH.
>>
>> CCing Arseniy and Bobby.
>>
>> >
>> > There is always a discrepancy between skb->len and skb->truesize.
>> > You will not be able to announce a 1MB window, and accept one milliion
>> > skb of 1-byte each.
>> >
>> > This kind of contract is broken.
>> >
>>
>> Yep, I agree, but before we start discarding data (and losing it), IMHO we
>> should at least inform the other peer that we're out of space.
>>
>> @Stefan, @Michael, do you think we can do something in the spec to avoid
>> this issue and in some way take into account also the metadata in the
>> credit. I mean to avoid the 1-byte packets flooding.
>>
>> Thanks,
>> Stefano
>
>Why do we need the metadata? Just don't keep it around if you begin
>running low on memory.

I don't think removing the skuffs will be easy; we added them for ebpf, 
zero-copy, and seqpacket as well. For now, we're already doing 
something: merging the skuffs if they don't have EOM set.

As a quick fix, I'm thinking of reducing the `buf_alloc` value to 
account for the overhead and notifying the other peer, at least until we 
find a better solution.

Stefano


