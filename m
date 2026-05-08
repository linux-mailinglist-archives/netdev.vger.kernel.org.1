Return-Path: <netdev+bounces-285923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHyZJnUK/mm1mQAAu9opvQ
	(envelope-from <netdev+bounces-285923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 18:08:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B514F9349
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 18:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A1A330C2872
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 16:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0B93FFAC3;
	Fri,  8 May 2026 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzvUgbr7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWfezEw0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B663CF671
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255938; cv=none; b=SP/iJ6FFqG5OWvIuJedQl9MRXXCz/leiTql0LKreeKLif8CyDi7aQJ/+turmtr0/x61/GG7IKIDOnGiAXHkkxDtnK3HK6x5P2PfAI3iqyANy9lOQ+NAsaSCFSgqmJktRspkNunJOo038Wk1P1gNQhpPjHnHgqLMagKrMfaSXGS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255938; c=relaxed/simple;
	bh=4F7maXO0a9FkT9euxBuc8PxcpOM2bW3TZJpMRTTqC3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omloMPbX6z8QMPv1GwGxjCntJvWn/IxZ6q0KHEyI0pUVYZhwpxmvCdkNcyqZdeBRfmujGsmhu+syib2wNoTUoYFOPAPY6UF+7ok0Wm0uYyKDGF7oHXvXHqMUN6uoY7K9HuodpoWQgy0qeLmAe+w2GsayQkVvKiygFk64cPizYuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzvUgbr7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cWfezEw0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778255929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gt9PkZ1udEZB7A5kTfc6cLitnqLtrOlHUOEwVlvJ/vE=;
	b=YzvUgbr7oOL7kNHXFkflXdraEvyM5AwgBrrWC23MfbZXtg3XTqy17DivbbWw5D7q08KJGB
	hhrFFUudUfAX0Dh/6wmB/3J1O05sIfoUZJPCiSUtKvJkYc+eXuMYdvVkNLfUmYpL+GfAna
	NwSrB5fzdwDGJ7K85ZA5GMD6IyKyf3g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-pHK5sepxNAyRCojP_9p8mQ-1; Fri, 08 May 2026 11:58:47 -0400
X-MC-Unique: pHK5sepxNAyRCojP_9p8mQ-1
X-Mimecast-MFC-AGG-ID: pHK5sepxNAyRCojP_9p8mQ_1778255927
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4518f777225so1406962f8f.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778255926; x=1778860726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gt9PkZ1udEZB7A5kTfc6cLitnqLtrOlHUOEwVlvJ/vE=;
        b=cWfezEw0FCvu+CqDWzSBR2snnV9vd5blKlgtKebCOl5J8NJ/L9CWTG7A4n8zkj287B
         lGas1OdPtyjXgm2mFzfTcT9HVonoxyGx7Vr/3POpFcdTh9PLL7+w5GtcUEpV1lRp72YJ
         D27HP98xD3BvdyjTCbs48VE/PIqh/YEvPjYvvLgv3d/RkV3Kuf2DAbeIYGcZP2ULJBtN
         tRY2Qm+vdCLaFeeBFsIWz75Clf2Sk+Dy/YwGe15BPbtdzSNHtECDkkrJUtQQt5KGmCbN
         G5C+42PmzKb1kp06zNG423a6kXtP3sjJI13imUWzi5FbAD41JzpG2emXMiB+TBerpbPR
         iz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778255926; x=1778860726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt9PkZ1udEZB7A5kTfc6cLitnqLtrOlHUOEwVlvJ/vE=;
        b=KKp08VX/QFVKEu7qHxpQoQAaWsxf8NAUwHRy8c8y1Ep4ZG8GJfygVuAieqtJe7lWUm
         bm67wCBN6Va7HnuxI3sBDsZb9JQd02R232Y96AYKkvfy8+V21LBjygK/9nfJMzhsEI3q
         lUw83k0qvFaVZRwIMCfT1WRJBWdOZ9F9q9iq5rjNYAnfDqUSNzH4whALZszbbXSJZqnD
         EEc5hyi42Q6th7WU3cx8ksSb8mt15fzdpP/NcngcGWtSzl9oNWpssB7dhNq1XCiCkCfa
         fIl3FE2FHTYL/Q9olAeyLKgS64TUrfCYSJ9bbGnfVHkB0wuvB1BUnLYkHTKXwV74/RaX
         g6zw==
X-Forwarded-Encrypted: i=1; AFNElJ/OZXWXL/FHbadae0aSWqrklXFThbRtndYTIBdahZBN/bP5f0DHkxyGBTEIZ6xnsMKuPU+gp1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwztlvfRaRnSjOMN0u6NQ6fx+vR2NlJb5gyMm04uDUVY/07afCN
	LvyuH0d0ucbq1l1edi7kxywySgyyxmBC4YUm3mIaI49SEI0LF9wyy3hviUj7IQPEtcIlBiJH0BH
	ED5QmTRNHrGgLQciwNR4os1xuTgVui2T9ZLlhXKGjhRZmz91jJ08HN0j4uQ==
X-Gm-Gg: Acq92OExZl9FoOr+B65LIi5f8fgFI0l0/HCeI3+Af+2L+HcdCpu2WgNhF1EQwyJajmH
	jQfBUGbKEf/aA06CO85PVTU9O/JzK97U0ZtPHUlVaqgHxnxErFvMRYnnQMXSJVFvNosa3KLProC
	m0n8JYL80t3dGE43cNBnNW9NHh/B2fbzyYr8UpC7vFVf3fOXJgyVg6T/djRyk03QiVYgLC3DPd9
	4pacta/TJ/aoBr0G4/mHLPjj5omoLERSSlpP5uYYhR7Cghz6Th/TqMMgMwOZJbqoKZWeExTHvj8
	pxWzKbDM57ucQt2bsL8rKTSzrDnMepKV/9QZZIoKn00RWS8YtOvXPzxPhFTRtBGn6vlijzpKhYS
	f3SuOfezAOEw0Bu26xUVoftmhWH/fRn46djiF44T1UOajiR9+xXteof2szpRRCYA4Biv2vK9aPQ
	==
X-Received: by 2002:a5d:588b:0:b0:43d:71f4:7ed4 with SMTP id ffacd0b85a97d-4515b525075mr22331108f8f.15.1778255926221;
        Fri, 08 May 2026 08:58:46 -0700 (PDT)
X-Received: by 2002:a5d:588b:0:b0:43d:71f4:7ed4 with SMTP id ffacd0b85a97d-4515b525075mr22331047f8f.15.1778255925539;
        Fri, 08 May 2026 08:58:45 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6c79fsm5529634f8f.15.2026.05.08.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:58:44 -0700 (PDT)
Date: Fri, 8 May 2026 17:58:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby Eshleman <bobbyeshleman@meta.com>, stefanha@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org, 
	Yiqi Sun <sunyiqixm@gmail.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap
 copy
Message-ID: <af4IAzRUFZdYKvaq@sgarzare-redhat>
References: <20260430071110.380509-1-sunyiqixm@gmail.com>
 <f4e52dcd-59ba-4c2e-9936-49cf27528b21@redhat.com>
 <afnXIGtswspSEk8x@sgarzare-redhat>
 <afzyM6fTTAl0Hnvm@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <afzyM6fTTAl0Hnvm@devvm29614.prn0.facebook.com>
X-Rspamd-Queue-Id: F2B514F9349
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285923-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,salutedevices.com,meta.com,vger.kernel.org,linux.alibaba.com,davemloft.net,google.com,kernel.org,gmail.com,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 01:12:35PM -0700, Bobby Eshleman wrote:
>On Tue, May 05, 2026 at 02:44:16PM +0200, Stefano Garzarella wrote:
>> CCing Arseniy and Bobby.
>>
>> On Tue, May 05, 2026 at 12:26:21PM +0200, Paolo Abeni wrote:
>> > On 4/30/26 9:11 AM, Yiqi Sun wrote:
>> > > vsockmon mirrors packets through virtio_transport_build_skb(), which
>> > > builds a new skb and copies the payload into it. For non-linear skbs,
>> > > this goes through virtio_transport_copy_nonlinear_skb().
>> > >
>> > > Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
>> > > As a result, skb_copy_datagram_iter() sees zero writable bytes
>> > > in the destination iterator and copies no payload data.
>> > >
>> > > This becomes an info leak because virtio_transport_build_skb() has
>> > > already reserved payload_len bytes in the new skb with skb_put(). The
>> > > skb is then returned to the tap path with that payload area still
>> > > uninitialized, so userspace reading from a vsockmon device can observe
>> > > heap contents and potentially kernel address.
>> > >
>> > > Fix it by initializing iov_iter.count to the number of bytes to copy.
>> > >
>> > > Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
>> > > Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
>> > > ---
>> > >  net/vmw_vsock/virtio_transport_common.c | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> > > index 416d533f493d..6b26ee57ccab 100644
>> > > --- a/net/vmw_vsock/virtio_transport_common.c
>> > > +++ b/net/vmw_vsock/virtio_transport_common.c
>> > > @@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
>> > >  	iov_iter.nr_segs = 1;
>> > >
>> > >  	to_copy = min_t(size_t, len, skb->len);
>> > > -
>> > > +	iov_iter.count = to_copy;
>> > >  	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
>> > >  			       &iov_iter, to_copy);
>> >
>> > @Stefano, @Stefan, the patch LGTM, but sashiko pointed out to a
>> > pre-existing issue you should probably want to address:
>> >
>> > >  	to_copy = min_t(size_t, len, skb->len);
>> > Does this length calculation account for the offset when a packet is
>> > split across multiple transmissions?
>> > If a packet is requeued, VIRTIO_VSOCK_SKB_CB(skb)->offset is increased,
>> > but to_copy still evaluates to the full length of the skb.
>>
>> Yep, I just checked and vhost-vsock is the only place where we call
>> virtio_transport_deliver_tap_pkt() wiht an offset != 0, but I agree that we
>> should also fix it.
>>
>> Looking better in net/vmw_vsock/virtio_transport_common.c I think this is a
>> regression, indeed we have this comment in virtio_transport_build_skb():
>>
>> 	/* A packet could be split to fit the RX buffer, so we can retrieve
>> 	 * the payload length from the header and the buffer pointer taking
>> 	 * care of the offset in the original packet.
>> 	 */
>> 	pkt_hdr = virtio_vsock_hdr(pkt);
>>
>> Before commit 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with
>> sk_buff") we read the payload lenght from the header that is always set to
>> the right value before delivering the packet to the tap.
>>
>> From that commit, we don't to consider the offset anymore since we started
>> to use `len` from the skb, so IMO we should go back to what we did before
>> it, I mean:
>>
>> 	payload_len = le32_to_cpu(pkt->hdr.len);
>>
>> @Bobby do you remember why we did that change? Or if you see any issue going
>> back to what we did initially?
>
>I think this was just one that made it through the cracks. I vaguely
>recall a few other instances where I assumed skb->len could stand-in for
>hdr.len, but it didn't hold.
>
>Using hdr.len like the original looks correct to me.

Thanks for confirming, I'll fix it.

Stefano


