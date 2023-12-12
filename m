Return-Path: <netdev+bounces-56494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B3D80F1FB
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C855281A4C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEC077F0A;
	Tue, 12 Dec 2023 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LikqK9FR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BECD3
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 08:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702397481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gDJ4BJvrh413d67atQh4JmcBdn9fiHCIFP3pSXKUEOs=;
	b=LikqK9FRZzwW5IOx9EQNmOboIVvW+BPeAdboncCdhCRHSI83AS7HILikK7lzMVDgcTJXZU
	9WP9ARB77osNK3dZsvK3sznhCSmDmdZ3+cnKqjXGJy9MdxWMnhEBkhrlHGSfyXm5CgC9Ci
	kl91jMJygQoFUbSkpLAhDPQDyF06IJc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-fi2vr6lOOiiQkT0o4AMIDA-1; Tue, 12 Dec 2023 11:11:19 -0500
X-MC-Unique: fi2vr6lOOiiQkT0o4AMIDA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1f99dd182dso152965566b.3
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 08:11:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397478; x=1703002278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDJ4BJvrh413d67atQh4JmcBdn9fiHCIFP3pSXKUEOs=;
        b=QmhXKt10eDGoSCw9H1LDsPvMENAi42pHdfHm9lsicqUcf+5iWT9q1sNjmDjh51qEWI
         +dQIH5GETuIvuw7iUJxs2OcR+oAM28d+YjHNig+TVpp0XAXlGFR1wZSnehBbx9sZBPLh
         fMj8s8hkbkDPODk/wjHJv34GjjdWtnOgeatbgB53vyrWvix3ckvJK/DZxv0sUsuTC0zB
         x6U4Clh4hlQhvVK9kljNeSm+jsKR6jBf/RhQ5PhSVcpeSNxbm9wefXrexxKMlmyIbCBd
         vEeOV6tHDFiXNfngldiS3OZcS8Mgs/ohUxUjwNP7TJkrkTq8G5TDXuStxCk3VeHKxmEP
         9xaQ==
X-Gm-Message-State: AOJu0YznDjl2xHMDsmC4eDrMGnMyl6uKwAAPIdKhAhpMKIbxMFD/J0q+
	0tW2JgElqLj0Cxb0a+JMrpyX3oQTabcuPn1BMNC+5uIEMCqF5/4+T45DS1n/vsU9LiUceLSvTVu
	cBMtUWzw2EApoQoxy
X-Received: by 2002:a17:907:948f:b0:a04:4b57:8f27 with SMTP id dm15-20020a170907948f00b00a044b578f27mr3729858ejc.60.1702397478647;
        Tue, 12 Dec 2023 08:11:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCmdg/6lDFekXlVbpsIxgUSkkmTZGgKOXN7kgsWywVrdXY9qocK2cPhMevqdguDpeicUzVpg==
X-Received: by 2002:a17:907:948f:b0:a04:4b57:8f27 with SMTP id dm15-20020a170907948f00b00a044b578f27mr3729847ejc.60.1702397478298;
        Tue, 12 Dec 2023 08:11:18 -0800 (PST)
Received: from redhat.com ([2.52.23.105])
        by smtp.gmail.com with ESMTPSA id ld4-20020a1709079c0400b009a19701e7b5sm6464141ejc.96.2023.12.12.08.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:11:17 -0800 (PST)
Date: Tue, 12 Dec 2023 11:11:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v8 3/4] virtio/vsock: fix logic which reduces
 credit update messages
Message-ID: <20231212110953-mutt-send-email-mst@kernel.org>
References: <20231211211658.2904268-1-avkrasnov@salutedevices.com>
 <20231211211658.2904268-4-avkrasnov@salutedevices.com>
 <20231212105322-mutt-send-email-mst@kernel.org>
 <f8b52c41-9a33-def4-6ca1-fc29ed257446@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8b52c41-9a33-def4-6ca1-fc29ed257446@salutedevices.com>

On Tue, Dec 12, 2023 at 06:50:39PM +0300, Arseniy Krasnov wrote:
> 
> 
> On 12.12.2023 18:54, Michael S. Tsirkin wrote:
> > On Tue, Dec 12, 2023 at 12:16:57AM +0300, Arseniy Krasnov wrote:
> >> Add one more condition for sending credit update during dequeue from
> >> stream socket: when number of bytes in the rx queue is smaller than
> >> SO_RCVLOWAT value of the socket. This is actual for non-default value
> >> of SO_RCVLOWAT (e.g. not 1) - idea is to "kick" peer to continue data
> >> transmission, because we need at least SO_RCVLOWAT bytes in our rx
> >> queue to wake up user for reading data (in corner case it is also
> >> possible to stuck both tx and rx sides, this is why 'Fixes' is used).
> > 
> > I don't get what does "to stuck both tx and rx sides" mean.
> 
> I meant situation when tx waits for the free space, while rx doesn't send
> credit update, just waiting for more data. Sorry for my English :)
> 
> > Besides being agrammatical, is there a way to do this without
> > playing with SO_RCVLOWAT?
> 
> No, this may happen only with non-default SO_RCVLOWAT values (e.g. != 1)
> 
> Thanks, Arseniy 

I am split on whether we need the Fixes tag. I guess if the other side
is vhost with SO_RCVLOWAT then it might be stuck and it might apply
without SO_RCVLOWAT on the local kernel?


> > 
> >>
> >> Fixes: b89d882dc9fc ("vsock/virtio: reduce credit update messages")
> >> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> >> ---
> >>  Changelog:
> >>  v6 -> v7:
> >>   * Handle wrap of 'fwd_cnt'.
> >>   * Do to send credit update when 'fwd_cnt' == 'last_fwd_cnt'.
> >>  v7 -> v8:
> >>   * Remove unneeded/wrong handling of wrap for 'fwd_cnt'.
> >>
> >>  net/vmw_vsock/virtio_transport_common.c | 13 ++++++++++---
> >>  1 file changed, 10 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >> index e137d740804e..8572f94bba88 100644
> >> --- a/net/vmw_vsock/virtio_transport_common.c
> >> +++ b/net/vmw_vsock/virtio_transport_common.c
> >> @@ -558,6 +558,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> >>  	struct virtio_vsock_sock *vvs = vsk->trans;
> >>  	size_t bytes, total = 0;
> >>  	struct sk_buff *skb;
> >> +	u32 fwd_cnt_delta;
> >> +	bool low_rx_bytes;
> >>  	int err = -EFAULT;
> >>  	u32 free_space;
> >>  
> >> @@ -601,7 +603,10 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> >>  		}
> >>  	}
> >>  
> >> -	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
> >> +	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
> >> +	free_space = vvs->buf_alloc - fwd_cnt_delta;
> >> +	low_rx_bytes = (vvs->rx_bytes <
> >> +			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
> >>  
> >>  	spin_unlock_bh(&vvs->rx_lock);
> >>  
> >> @@ -611,9 +616,11 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> >>  	 * too high causes extra messages. Too low causes transmitter
> >>  	 * stalls. As stalls are in theory more expensive than extra
> >>  	 * messages, we set the limit to a high value. TODO: experiment
> >> -	 * with different values.
> >> +	 * with different values. Also send credit update message when
> >> +	 * number of bytes in rx queue is not enough to wake up reader.
> >>  	 */
> >> -	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
> >> +	if (fwd_cnt_delta &&
> >> +	    (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE || low_rx_bytes))
> >>  		virtio_transport_send_credit_update(vsk);
> >>  
> >>  	return total;
> >> -- 
> >> 2.25.1
> > 


