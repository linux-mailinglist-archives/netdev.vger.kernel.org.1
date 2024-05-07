Return-Path: <netdev+bounces-94022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5358BDF76
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DEFF1C210C1
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB43D14EC49;
	Tue,  7 May 2024 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRoDewtv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D09214E2DA
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715076729; cv=none; b=qxZ4xnTja0LbS7inr7bvl0bUHrRbU8pae+gJ85qnvwJamrwyJXtOd2BhnXIgDir+/5866eaTDwUGb+0lxievSVZpPtXTSH/CPEKWI0Fdm/Rhhc12XCi8JZD9xxQifl6mbdOvyoYxuGXvazktQeStWkVRTIt7+RPl46JP8+oV74I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715076729; c=relaxed/simple;
	bh=tXxOHhjDDB5rcLEzF9ClVBFmMEOOJWkNutyzz73cYAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyXQ+WFw+farV2TGQ3ooKz3zbvPmxerak7sDtmIQ737++HZ8pN9ppCsCIt1mqoLxybHoRhxOnRrmzJrSPIYspsZE5wSGY6TVcFAThQe6Ywolxpo5tm30MInKHOTOPbezrqXxbr2tnYce/kYN7EMGoZK/bewBOxQTThqOsvoYR+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRoDewtv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715076727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQ5X9hL/qDis7OokPWC3P2IJWvEjdXKNS2X1OZdXtLE=;
	b=bRoDewtvgTNf6WT4K+o71YuY9DivjBEfRnp2TyPzcO0Ybcs7TQpn9wWrStnCd8sWLAHZbQ
	VolwOby8Ql6wy7itd075HJmZuc1ShVnrmH6TkC5P7OoGewvsMOuVQnQizL0hoIpxOEHk3Z
	TqFlQuG9J8kNCfKaXvJCE2QJuSY6RlE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-2C2NVb5QMVSbMbaLZ0ZGBQ-1; Tue, 07 May 2024 06:12:05 -0400
X-MC-Unique: 2C2NVb5QMVSbMbaLZ0ZGBQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34e0836d91eso2202631f8f.2
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 03:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715076724; x=1715681524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQ5X9hL/qDis7OokPWC3P2IJWvEjdXKNS2X1OZdXtLE=;
        b=AKbNHF1XlhuC1qfTbPeE79p7NYeoA9JzDxokFNjUriTISCUiQEnNmR/4YwWszUEK4p
         QumXhmdCIKfYjbg+nimU7B2Bi7aVoJ4uriMPjXEaT+qBo/+riqoYC0qA1Hc/Fi+fDjS5
         vkXEwb987IOWpxZjrIBb6btd5BXQ5E7nIVMvtRsUmeIMc42NEamwW8KBPxbfpvWCJgvd
         thdoeHlug/GpjwglAbSdfSgWbpV6d2vD/X6Y+zHx6ub7OkUQRM0JuFIqC00KDuvUTKJM
         kv0uaIHdqObHISJGwE8iNiTZi4MOy0fS0316Qx0saQnWjOBVESIY4CzsDg6INYhuwqKU
         6/uw==
X-Forwarded-Encrypted: i=1; AJvYcCXlAGN6A/5VTWGrfOxXvJ9CShYiLIwPXcSOgY8iHGtehjaC4G5hdaEfjj4N3m+qgMqIUKsrJmd0NAAQq+LSmdeD0Z0AV1XK
X-Gm-Message-State: AOJu0YwJN4YefHI3CvxNCMNV4f7gJyunGPESlEEgsLjwNaOIo9PEMdG7
	p/El/KU5TbIW4aPuBEBOO5t9btk4mlLjF/aD2hP8g0LkXyR6fzVyoY3n9tEA+J6ENrNstL6XZZM
	D0ctsrp/YeHrVI5qLZKNPEnFr6xh89DkzQ+scB4l2lENeslCtOQOLYg==
X-Received: by 2002:a05:6000:1745:b0:34d:b183:1345 with SMTP id m5-20020a056000174500b0034db1831345mr8651928wrf.39.1715076724510;
        Tue, 07 May 2024 03:12:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPcGR+BV/qx04dYgSQFU7A6M4BMxt3edyPS8prsMfuRNZeFzxod9ePgPK8b63tLUNFDddypg==
X-Received: by 2002:a05:6000:1745:b0:34d:b183:1345 with SMTP id m5-20020a056000174500b0034db1831345mr8651900wrf.39.1715076724077;
        Tue, 07 May 2024 03:12:04 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-56.business.telecomitalia.it. [87.12.25.56])
        by smtp.gmail.com with ESMTPSA id dl6-20020a0560000b8600b00343dc6a0019sm12586659wrb.68.2024.05.07.03.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 03:12:03 -0700 (PDT)
Date: Tue, 7 May 2024 12:11:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, 
	Luigi Leonardi <luigi.leonardi@outlook.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kuba@kernel.org, stefanha@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kvm@vger.kernel.org, jasowang@redhat.com
Subject: Re: [PATCH net-next v2 2/3] vsock/virtio: add SIOCOUTQ support for
 all virtio based transports
Message-ID: <dlqbbypoowki556ag74zgnsiscsctjf2xfcw5e5lf4b4pg6f6g@af4lxbljrw7x>
References: <20240408133749.510520-1-luigi.leonardi@outlook.com>
 <AS2P194MB2170FDCADD288267B874B6AC9A002@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
 <c18d4b9220a85f8087eda15526771dac5f8b4c0a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c18d4b9220a85f8087eda15526771dac5f8b4c0a.camel@redhat.com>

On Thu, Apr 11, 2024 at 09:09:49AM GMT, Paolo Abeni wrote:
>On Mon, 2024-04-08 at 15:37 +0200, Luigi Leonardi wrote:
>> This patch introduce support for stream_bytes_unsent and
>> seqpacket_bytes_unsent ioctl for virtio_transport, vhost_vsock
>> and vsock_loopback.
>>
>> For all transports the unsent bytes counter is incremented
>> in virtio_transport_send_pkt_info.
>>
>> In the virtio_transport (G2H) the counter is decremented each time the host
>> notifies the guest that it consumed the skbuffs.
>> In vhost-vsock (H2G) the counter is decremented after the skbuff is queued
>> in the virtqueue.
>> In vsock_loopback the counter is decremented after the skbuff is
>> dequeued.
>>
>> Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>
>I think this deserve an explicit ack from Stefano, and Stefano can't
>review patches in the next few weeks. If it's not urgent this will have
>to wait a bit.
>
>> ---
>>  drivers/vhost/vsock.c                   |  4 ++-
>>  include/linux/virtio_vsock.h            |  7 ++++++
>>  net/vmw_vsock/virtio_transport.c        |  4 ++-
>>  net/vmw_vsock/virtio_transport_common.c | 33 +++++++++++++++++++++++++
>>  net/vmw_vsock/vsock_loopback.c          |  7 ++++++
>>  5 files changed, 53 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index ec20ecff85c7..dba8b3ea37bf 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -244,7 +244,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>>  					restart_tx = true;
>>  			}
>>
>> -			consume_skb(skb);
>> +			virtio_transport_consume_skb_sent(skb, true);
>>  		}
>>  	} while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
>>  	if (added)
>> @@ -451,6 +451,8 @@ static struct virtio_transport vhost_transport = {
>>  		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>>  		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
>>
>> +		.unsent_bytes             = virtio_transport_bytes_unsent,
>> +
>>  		.read_skb = virtio_transport_read_skb,
>>  	},
>>
>> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>> index c82089dee0c8..dbb22d45d203 100644
>> --- a/include/linux/virtio_vsock.h
>> +++ b/include/linux/virtio_vsock.h
>> @@ -134,6 +134,8 @@ struct virtio_vsock_sock {
>>  	u32 peer_fwd_cnt;
>>  	u32 peer_buf_alloc;
>>
>> +	atomic_t bytes_unsent;
>
>This will add 2 atomic operations per packet, possibly on contended
>cachelines. Have you considered leveraging the existing transport-level
>lock to protect the counter updates?

Good point!

Maybe we can handle it together with `tx_cnt` in
virtio_transport_get_credit()/virtio_transport_put_credit().

Eventually these are called exactly to count the payload we are sending
(`tx_cnt` is a counter that only grows, virtio_transport_put_credit() is
called only to return unused credit, so we can't use it directly but
always need a new variable like `bytes_unsent`).

I mean something like this (untested at all):

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index dbb22d45d203..713197c16b7f 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -133,8 +133,7 @@ struct virtio_vsock_sock {
         u32 tx_cnt;
         u32 peer_fwd_cnt;
         u32 peer_buf_alloc;
-
-       atomic_t bytes_unsent;
+       u32 bytes_unsent;

         /* Protected by rx_lock */
         u32 fwd_cnt;
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 82a31a13dc32..b1a51db616cf 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -419,13 +419,6 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
                  */
                 rest_len -= ret;

-               /* Avoid to perform an atomic_add on 0 bytes.
-                * This is equivalent to check on VIRTIO_VSOCK_OP_RW
-                * as is the only packet type with payload.
-                */
-               if (ret)
-                       atomic_add(ret, &vvs->bytes_unsent);
-
                 if (WARN_ONCE(ret != skb_len,
                               "'send_pkt()' returns %i, but %zu expected\n",
                               ret, skb_len))
@@ -479,7 +472,10 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
                 struct virtio_vsock_sock *vvs;

                 vvs = vs->trans;
-               atomic_sub(skb->len, &vvs->bytes_unsent);
+
+               spin_lock_bh(&vvs->tx_lock);
+               vvs->bytes_unsent -= skb->len;
+               spin_unlock_bh(&vvs->tx_lock);
         }

         if (consume)
@@ -499,6 +495,7 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
         if (ret > credit)
                 ret = credit;
         vvs->tx_cnt += ret;
+       vvs->bytes_unsent += ret;
         spin_unlock_bh(&vvs->tx_lock);

         return ret;
@@ -512,6 +509,7 @@ void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit)

         spin_lock_bh(&vvs->tx_lock);
         vvs->tx_cnt -= credit;
+       vvs->bytes_unsent -= ret;
         spin_unlock_bh(&vvs->tx_lock);
  }
  EXPORT_SYMBOL_GPL(virtio_transport_put_credit);
@@ -915,7 +913,6 @@ int virtio_transport_do_socket_init(struct vsock_sock *vsk,
                 vsk->buffer_size = VIRTIO_VSOCK_MAX_BUF_SIZE;

         vvs->buf_alloc = vsk->buffer_size;
-       atomic_set(&vvs->bytes_unsent, 0);

         spin_lock_init(&vvs->rx_lock);
         spin_lock_init(&vvs->tx_lock);
@@ -1118,8 +1115,13 @@ EXPORT_SYMBOL_GPL(virtio_transport_destruct);
  int virtio_transport_bytes_unsent(struct vsock_sock *vsk)
  {
         struct virtio_vsock_sock *vvs = vsk->trans;
+       int ret;

-       return atomic_read(&vvs->bytes_unsent);
+       spin_lock_bh(&vvs->tx_lock);
+       ret = vvs->bytes_unsent;
+       spin_unlock_bh(&vvs->tx_lock);
+
+       return ret;
  }
  EXPORT_SYMBOL_GPL(virtio_transport_bytes_unsent);


WDYT?

Should virtio_transport_bytes_unsent() returns size_t?

Thanks,
Stefano


