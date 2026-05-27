Return-Path: <netdev+bounces-292404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF+zCGwjF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:01:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 681D55E81B9
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A27F83020D48
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F7C3D564D;
	Wed, 27 May 2026 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIotKwkC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNCYsAx/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E342C14ABE
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901027; cv=none; b=k6BVIDlmqfPI+rI4fJ4t/jhpqPL2B1pUTJNh16GSqdsEGcugJ5yCuWtZiUfwMQKDKqwt2xXOWU9eUh0GuxURX3fINGmSrZ3CeEUrpIRguOmVvD2JJ91HimkXC0AVWux+sey2aMXdE8ZI2bJeUVSHrJ5w98hGaFB9xFI/emSKqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901027; c=relaxed/simple;
	bh=FMjcfw1gtJdikk24XijqfIJL4SbFpptAzdt7sAv5s8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pb2YdcQw/7NvdvRVxeBIjbC9WWbMSpOUbTYwjvQQf1FkKZHsvEjQg2zefJfne1tChsOHo2ah9btG4B2Cy21NCye3JacvdE2bfO3+XZI2Cho04tHurVs6OeVEI7LiuuJZ/cos0Fl2g3nH0wzSlfGw2O2CyHihdXr4kpbXV7kgL2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HIotKwkC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNCYsAx/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779901025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0WmbZJHv2AsF9zQV/NwZubD/+GCGOwEnHV2WswAkLVs=;
	b=HIotKwkCAh7AC1x1FhpGhYzW52cDL26tKwtI6nFBsYjS8IUQR+3EO4SHlXxAGezZapppGo
	4zRed97qaQS5fSy+urpqwlxKIqx3CZa/ONuWzRBG5bOTJkqsLueLxvxobYsV+T/Dglc30S
	KO54URmK2VfbLNa7YTsQvGQ7oicaMEM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-8Q2WAmCbMVaDhscFVVQxEg-1; Wed, 27 May 2026 12:57:02 -0400
X-MC-Unique: 8Q2WAmCbMVaDhscFVVQxEg-1
X-Mimecast-MFC-AGG-ID: 8Q2WAmCbMVaDhscFVVQxEg_1779901021
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49051422d55so49432425e9.2
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779901021; x=1780505821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0WmbZJHv2AsF9zQV/NwZubD/+GCGOwEnHV2WswAkLVs=;
        b=hNCYsAx/N2urAKFAf5BzBgI0RSTRceZNFi552SOeDZboXymBAYu1TYkXt7LPcr45/H
         Rozy81r9NiVXp90H04HfsGzyW90WzM8xL2xlS9QYGOAaDw1tXR3WeYlWaDWE6PeF129a
         n1MeEto67zJ/Xfjfl10AJLNHoSX50nCNsQkUgZUCmVveM4v3wzMTtB5ZzLtPIe6x4dHx
         y1gPr7tXDVQL3/BbMHCr7Co7fcGu33Js1XdRV8/SBuuD6doivL+xjsbfQtwl14jZ3Rv2
         EP4auuIwhGsi19+SX6NZW9SG0BSKuikZmXWeOkZnG/w8ywSr2H23HrL2IWzidlp27ZBS
         Fu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901021; x=1780505821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WmbZJHv2AsF9zQV/NwZubD/+GCGOwEnHV2WswAkLVs=;
        b=nk4+IiqxwipRUK06CG/VdbXrPniv+ciM54Ah1B5AUA11D3Cd1kmdux/spCQe8Vqccm
         Ra9g3KMC0e/JMxo8iUhW7TSTMP3Tya8C6FCqBkWAKrP1bS0LYZzKqwq8h6tDRSk21e0e
         WGxDSgqJTWeYq7q3Xv16acw86D5WHsuN9FMvDAwi/NRmlcRxQB+iPuaxPEeYjsYHIQmz
         A0gYpwYjvh3pKt1AOHe0U1+SiDw302iBERN+iNHephHL5R4rDwY3KhDuRA79DJ5hPush
         qEHf78Pc1Wje2QXPZWCo4gA9cDp+jQB1YBP26ifzHaAy8Q5cVDOV3P3Vu2mHenR+gQQS
         F4NA==
X-Gm-Message-State: AOJu0YyY7rIHdppNpZpK8LXlzCl75/UKjQUBimaZ7f4lcmp7qtd8/dth
	+BYcU+UOLpqzIlcJ2KKbiqFf+OVX0UZKcQooB6jvMC2ufoWYQiHq+Mn1oCrabvsHTuckKFLN8v3
	XZGa5twEo0wZN+2NFDHILpcd4j/JeqYl4x3XVMSvC0nafS70wnKfOCpZH3Q==
X-Gm-Gg: Acq92OGUuTIcXi6rI0/GeJKEmV2PqHaiZBFtIsKBrZo+pzjrbn42t2VITsEaEWJCTD/
	0Yfemyvc/dTuymtKGp5BP0sUSm17BJR6gHf4cGE3J0pBgoFXpt646jelri6H2Pxayo+TMIKMGWF
	R+D5seN89phVI1tUxvdmJzLWXOgqpJl/JAk58VIqkDrM/NMxREKQ1sCBHh6w0sAfenXhBxJo15z
	MpR7VxgaFSwX+u/Vd34zmgwRlTa4rzqY0+ORjuL2Smu099xSTent9P7g6lw4pgz0gRmv+28vG/1
	mHsrjk7EYt6sQ2TIMyKt+NyJGNIM/QLECqfaMTxC93pbEj4OyABYCNKfyAeNYFWlK/EsKGx8LGM
	YHxggxi4rvwgB
X-Received: by 2002:a05:600c:1992:b0:48a:9428:5522 with SMTP id 5b1f17b1804b1-490426bc7dcmr392285745e9.16.1779901021278;
        Wed, 27 May 2026 09:57:01 -0700 (PDT)
X-Received: by 2002:a05:600c:1992:b0:48a:9428:5522 with SMTP id 5b1f17b1804b1-490426bc7dcmr392285215e9.16.1779901020732;
        Wed, 27 May 2026 09:57:00 -0700 (PDT)
Received: from redhat.com ([31.187.78.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb558f52sm7678278f8f.14.2026.05.27.09.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:56:59 -0700 (PDT)
Date: Wed, 27 May 2026 12:56:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH net] Revert "vsock/virtio: fix skb overhead overflow on
 32-bit builds"
Message-ID: <20260527125631-mutt-send-email-mst@kernel.org>
References: <20260527164843.125054-1-sgarzare@redhat.com>
 <ahchEKOnRwGJBL2V@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahchEKOnRwGJBL2V@sgarzare-redhat>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292404-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 681D55E81B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 06:54:21PM +0200, Stefano Garzarella wrote:
> On Wed, May 27, 2026 at 06:48:43PM +0200, Stefano Garzarella wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > This reverts commit 4157501b9a8f ("vsock/virtio: fix skb overhead
> > overflow on 32-bit builds"). The fix was semantically correct (although
> > it would have been better to use mul_u32_u32(), as David pointed out),
> > but in practice we are estimating the memory used to allocate the SKBs,
> > and this will never cause a 32-bit variable to overflow on a 32-bit
> > system, since the memory would have run out long before that. On 64-bit,
> > SKB_TRUESIZE() already evaluates to size_t, so the multiplication is
> > already in 64-bit arithmetic without the cast.
> > 
> > Let's revert this to avoid unnecessary 64-bit multiplies on the
> > per-packet receive path on 32-bit systems.
> > 
> > Reported-by: David Laight <david.laight.linux@gmail.com>
> > Closes: https://lore.kernel.org/netdev/20260523173557.5cc4f4f6@pumpkin
> > Suggested-by: "Michael S. Tsirkin" <mst@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > net/vmw_vsock/virtio_transport_common.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> aaarg, something wrong on my new setup, CC list was missing several people
> and mailing lists, including LKML. Please let me know if I should resend
> this.
> 
> Sorry for the noise,
> Stefano


yea just do it. Put PATCH resend in the subj.

> > 
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index b143290a311d..d4d26fba9e37 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -417,7 +417,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> > 					u32 len)
> > {
> > -	u64 skb_overhead = ((u64)skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> > +	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> > 
> > 	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
> > 	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
> > -- 
> > 2.54.0
> > 


