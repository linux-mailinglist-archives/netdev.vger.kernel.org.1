Return-Path: <netdev+bounces-284375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNwEC5jp+WnWFAMAu9opvQ
	(envelope-from <netdev+bounces-284375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:59:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3622C4CE0E3
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 240A3306804D
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 12:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D7942EEC5;
	Tue,  5 May 2026 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NT6bdEek";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="byF3Z4NU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C0C436375
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985069; cv=none; b=mlNy+Asp1CXeyKLVaY0IvoY1jR1YUChmBf65dKyyY3/joH5bD/j58nT5Iotkm3NMpaIUDF+v2V/WphCvw92TOF6OlJ/WGRGyxnlnNmsqbpbeqEjb9YET7aOKoD+vZ2hgaR5UiyDYWq80gQL3UvBLcPuroUHvnp9ue4ISNpMnWdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985069; c=relaxed/simple;
	bh=hz98aOu66uNVwuTZiRLja0C8i6pImQOrnxxcY7S6SyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pD9oEfzm5XR1aN0pv0tDdu8rpAovSKeTYWf/WgbOXQWdBvq5cavmOst2oWh8ynx+qcp42GQr+P+h/OR6rcqmFHddvLS/ssyDclz3cQmhHhLf4jXDTd8Si64GqJz1jeYmZ1jdrolF8SeoG2Le31+Vkf12jwwrFwBLdxn6jRwNSFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NT6bdEek; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=byF3Z4NU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777985067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwSGsuiyqii/zr4WOQ6nXZFN/nOITIhLrEP6HdZcP9o=;
	b=NT6bdEekw1okQrCR1uzL8Yen8nDqQ/hawt0PlK7pVz9870RqXlKnbt+3UWdRKB8wWxuOyC
	ea6jxGY6OVbj8bH6Vf2oTU39dul3dlEQGuYKwGJWt5P83KOyJ4LumP5rX6gtqsdnuoau99
	1FfOyT1lqCHZcC/wOH+BSmWYZTmaMwA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-QPXYnTEUPTakciYJn7_iAA-1; Tue, 05 May 2026 08:44:23 -0400
X-MC-Unique: QPXYnTEUPTakciYJn7_iAA-1
X-Mimecast-MFC-AGG-ID: QPXYnTEUPTakciYJn7_iAA_1777985062
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44d68ed8f95so1650239f8f.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777985062; x=1778589862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jwSGsuiyqii/zr4WOQ6nXZFN/nOITIhLrEP6HdZcP9o=;
        b=byF3Z4NUEDg841ZEoHUmvCNTzJvR+1RkguBk03pNuHAPFut56h3rF3Z6rhBy2M2/eX
         lRTxHBSTOsp4B/F3py0jWUuB2T/cKWiYEpLTKy+/TIzX7dVwjQ+Wc3C2JB3ZYWjBVknz
         SI/14BsPswu07ortmuBvosS9Ez7gWvWwCYNEtICF3vGPjcaWnzYvYEFz/MwPrCP2psuc
         /npu9MKC28KazhFdInaG6A1hvbGCnGNDQqOI7Y72O8lPmddseVK3aIWgeuJM1QIE6j3j
         ideBFHaIwZX5xoIOMB8UngkTaBjOutOb8vj1uzAC9skDJp2LWXr6upb4zspNsSSa2ssY
         nHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777985062; x=1778589862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwSGsuiyqii/zr4WOQ6nXZFN/nOITIhLrEP6HdZcP9o=;
        b=m8AF+znJiGZSjv/JaTYuyt9t0ebh4/Sr9A8NLQBfI3gOu0Nahrmc9pgFbOfDiNdLyY
         axH0npWddI4Y8NUHXEcQgCoQ7ZwppZSgUEMPWuG8rYP3avJ6aJmYbOip+qYTwDPQcTcK
         WM9W9nGc9EsUVKe3kEaZHJMlrN2HJ7H8qinB+giyqa1v1W3eh2ZQ2P3a7JlkL3tminzN
         0p4HxKeF8rNXL4VuYuSzO+JkS4ik4rY2UEEvNbjOwRLYzD4a8biPorKDBsBdRyOccxau
         Aow5ic8s+FyaxclXWmjiocb8ng8xBmhKcME+0cWhbzadwCdvUNRvAPOfuoz6fRJ4SW66
         L7oA==
X-Forwarded-Encrypted: i=1; AFNElJ/BlUs66UTto/deeAK94dxTX9Rqkwuq9hzn2cePiZ0UaMbqGlZbZpeKhp43Fn1FbdRtV9ahoA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9sbq6WgJttXTZWpaquUIGvSFXcMnmwlv5W8qbvEiEsI+oScfp
	nORLzNCXFQdq3kV1/r6kSZTwiKm5C4dwfBL7uTOnxCkmVkZ9Pn9xfgbulj82mLPT/+olrMot07+
	8MKU4I7Z+kD4enB2WcbwFHsbn3IndJD0IgyKcEGC5sYYP6ckpOFMRYZTAXQ==
X-Gm-Gg: AeBDiesOzjeSqLzp7Q/0h3bHyg/OQ0moKg2NswmUo7hzd/730/pB3VCq6ltV4QSgyqT
	jJamUSfJYjDhDEiy70dQKWbktqy56ngHUd/juFr01ZDScmARPP6JZHwlARM7xwY1kzT2my+t35L
	wsPl078XdeidWOSn6RJnlFmS/n5GKRp+kURtCABhI/u7t4XTnLRsLmZoBhTZBL1eQSLtuEyzNDd
	N0SKtXuZR45xONTXcoRoxeIyupGdsQsFPEqT+CcPnvysEFpJn85dIYmesYmpSmeW/cJkOFWPouA
	oBhrTuH41cTQvyEha6a5FfwcCVrf/JvcSzWA/Yp9n9h49VOy6IYZL8nVP18UKt8UgsGformIRGC
	//VJO76q9wkjqusIeHxJat2xksF81LgXjg26JMZyNqC8g75SUCKRtmo85NwnoQZqeWnpdcuZ6iQ
	==
X-Received: by 2002:a05:6000:186b:b0:449:b7dd:4a75 with SMTP id ffacd0b85a97d-44fdee4405cmr6456582f8f.20.1777985062387;
        Tue, 05 May 2026 05:44:22 -0700 (PDT)
X-Received: by 2002:a05:6000:186b:b0:449:b7dd:4a75 with SMTP id ffacd0b85a97d-44fdee4405cmr6456485f8f.20.1777985061805;
        Tue, 05 May 2026 05:44:21 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505238e6e0sm4243514f8f.6.2026.05.05.05.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:44:21 -0700 (PDT)
Date: Tue, 5 May 2026 14:44:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby Eshleman <bobbyeshleman@meta.com>
Cc: stefanha@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, Yiqi Sun <sunyiqixm@gmail.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap
 copy
Message-ID: <afnXIGtswspSEk8x@sgarzare-redhat>
References: <20260430071110.380509-1-sunyiqixm@gmail.com>
 <f4e52dcd-59ba-4c2e-9936-49cf27528b21@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f4e52dcd-59ba-4c2e-9936-49cf27528b21@redhat.com>
X-Rspamd-Queue-Id: 3622C4CE0E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284375-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,linux.alibaba.com,davemloft.net,google.com,kernel.org,gmail.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

CCing Arseniy and Bobby.

On Tue, May 05, 2026 at 12:26:21PM +0200, Paolo Abeni wrote:
>On 4/30/26 9:11 AM, Yiqi Sun wrote:
>> vsockmon mirrors packets through virtio_transport_build_skb(), which
>> builds a new skb and copies the payload into it. For non-linear skbs,
>> this goes through virtio_transport_copy_nonlinear_skb().
>>
>> Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
>> As a result, skb_copy_datagram_iter() sees zero writable bytes
>> in the destination iterator and copies no payload data.
>>
>> This becomes an info leak because virtio_transport_build_skb() has
>> already reserved payload_len bytes in the new skb with skb_put(). The
>> skb is then returned to the tap path with that payload area still
>> uninitialized, so userspace reading from a vsockmon device can observe
>> heap contents and potentially kernel address.
>>
>> Fix it by initializing iov_iter.count to the number of bytes to copy.
>>
>> Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
>> Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
>> ---
>>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 416d533f493d..6b26ee57ccab 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
>>  	iov_iter.nr_segs = 1;
>>
>>  	to_copy = min_t(size_t, len, skb->len);
>> -
>> +	iov_iter.count = to_copy;
>>  	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
>>  			       &iov_iter, to_copy);
>
>@Stefano, @Stefan, the patch LGTM, but sashiko pointed out to a
>pre-existing issue you should probably want to address:
>
>>  	to_copy = min_t(size_t, len, skb->len);
>Does this length calculation account for the offset when a packet is
>split across multiple transmissions?
>If a packet is requeued, VIRTIO_VSOCK_SKB_CB(skb)->offset is increased,
>but to_copy still evaluates to the full length of the skb.

Yep, I just checked and vhost-vsock is the only place where we call 
virtio_transport_deliver_tap_pkt() wiht an offset != 0, but I agree that 
we should also fix it.

Looking better in net/vmw_vsock/virtio_transport_common.c I think this 
is a regression, indeed we have this comment in 
virtio_transport_build_skb():

	/* A packet could be split to fit the RX buffer, so we can retrieve
	 * the payload length from the header and the buffer pointer taking
	 * care of the offset in the original packet.
	 */
	pkt_hdr = virtio_vsock_hdr(pkt);

Before commit 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with 
sk_buff") we read the payload lenght from the header that is always set 
to the right value before delivering the packet to the tap.

 From that commit, we don't to consider the offset anymore since we 
started to use `len` from the skb, so IMO we should go back to what we 
did before it, I mean:

	payload_len = le32_to_cpu(pkt->hdr.len);

@Bobby do you remember why we did that change? Or if you see any issue 
going back to what we did initially?


Also IMO we should avoid to set all the iov_iter fields by hand and 
start to use iov_iter_kvec(). Plus, we can just use 
skb_copy_datagram_iter() in any case, like we already do in vhost-vsock, 
since it already handles linear vs non linear.

At the end I mean something like this:

@@ -171,7 +150,7 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
  	 * care of the offset in the original packet.
  	 */
  	pkt_hdr = virtio_vsock_hdr(pkt);
-	payload_len = pkt->len;
+	payload_len = le32_to_cpu(pkt_hdr->len);

  	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
  			GFP_ATOMIC);
@@ -214,13 +193,17 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
  	skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));

  	if (payload_len) {
-		if (skb_is_nonlinear(pkt)) {
-			void *data = skb_put(skb, payload_len);
+		struct iov_iter iov_iter;
+		struct kvec kvec;
+		void *data = skb_put(skb, payload_len);

-			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
-		} else {
-			skb_put_data(skb, pkt->data, payload_len);
-		}
+		kvec.iov_base = data;
+		kvec.iov_len = payload_len;
+		iov_iter_kvec(&iov_iter, READ, &kvec, 1, payload_len);
+
+		skb_copy_datagram_iter(pkt,
+				       VIRTIO_VSOCK_SKB_CB(pkt)->offset,
+				       &iov_iter, payload_len);
  	}

  	return skb;

And removing virtio_transport_copy_nonlinear_skb().

If you agree, I can send a proper series with these changes that should 
fix the issue reported by Yiqi Sun introduced by commit 4b0bf10eb077 
("vsock/virtio: non-linear skb handling for tap") and the issue 
introduced by commit 71dc9ec9ac7d ("virtio/vsock: replace 
virtio_vsock_pkt with sk_buff").

Thanks,
Stefano


