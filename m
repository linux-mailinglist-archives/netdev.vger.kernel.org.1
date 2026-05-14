Return-Path: <netdev+bounces-288022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMb7FnLpBWrpdQIAu9opvQ
	(envelope-from <netdev+bounces-288022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:25:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C92C8543FC9
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57E0B313EE31
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C759340B6EB;
	Thu, 14 May 2026 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAVRkAaS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaFolo8M"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CC1406278
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771792; cv=none; b=mw38JcoA5sZ5JS3T4oS6DUq5Ajtc1HSNhYgvwcyFZYtgNvVLj2ai6deNcfyVbZgVoV7E3hroiTRU6um95bxlEWP+LjvMF4cakJUzbADSAmSTEtqG5p8+cPRNpWaV76mhRH/r8Ck/m7C5LL9t3/mlQumJzqL+irygn5zmm0qRexI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771792; c=relaxed/simple;
	bh=q7uNPrD0eUP4HNkAIIdlYAOXifDzpyw/ZOQANdgddGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaGHU8L7MuEbUgN9BInGAkNawPrPBqKt12L9y2iZJX9THvLj8GvC/qgRClG9855b1iA+Wwv3P+G0oL3Lx/kXvZA4jSpf6X2Rz4C5k52dtWAz6xccYjCkHl0TdOBb+a74TDj9w+nLcxep4m0nGs9gvwFK9uhYx1mPEkKg+1Ht2sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAVRkAaS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaFolo8M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778771790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s6SqjJFaYe/G8HVu0q1mvVzTnaE1hb029hYuoyhIe+M=;
	b=GAVRkAaShD1YrlSwka6pg5vvD0Rl9ve68a1ulF/VEsCHsSbAbC8xC85u2MvaQzQHaEgGxo
	tpDAGFqv95otJcIU06UOSKS85SmOZ+j2i0BFcD0zwua4B4d9mCvsNVtELtD8Pf7gMz+/Ma
	WOjqqYGUER4gU6/qjpNfC0Sm3oq9BGM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-o3DogRDuPoqzhIlNNSmDSg-1; Thu, 14 May 2026 11:16:29 -0400
X-MC-Unique: o3DogRDuPoqzhIlNNSmDSg-1
X-Mimecast-MFC-AGG-ID: o3DogRDuPoqzhIlNNSmDSg_1778771788
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488d3eec9bcso57263095e9.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 08:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778771788; x=1779376588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s6SqjJFaYe/G8HVu0q1mvVzTnaE1hb029hYuoyhIe+M=;
        b=JaFolo8Mw5acZPfyjJ5G9nQAzD+fxbL3mi2d5yC42AhHsAh6bqKogALDZVXaUg5pQH
         2c2HtqXqCORsrw8xvZLMRPj/LyHq47xj/bU5xjsjdJoPpaR5lUvBQDqSNZ1w1u7/1OuQ
         ETDA1Olf6DVVWu/dUqqpUDOqTsdlBM9QoXogtM89MlH81eHthSvWwklBznvaLV8yyO0K
         dKftkVsXkiHhFcapYVLwleCWe8CvVEQ35YL8nhmeGrl/nNw683ogk579Q2uoiWJEjOnn
         INpJS1EMJDpoGQ5M85Z+j5WCXLHiIg5olfyytoKIaJEklEfo/iGKfYBy+bCefhLVDCgd
         lzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778771788; x=1779376588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6SqjJFaYe/G8HVu0q1mvVzTnaE1hb029hYuoyhIe+M=;
        b=WCBVxCDxDwiJRuUT+Rdr1ZCCDQZjbm6h/dUm37nSuGiJv6MKYXxNFYnKZ1ioaXrLnk
         Gj5LHD4HMuzjw6yzwDR76Y+19grHYR//7d/0kxVuzgUSNTsF3wEMK41CSVQdG9zPd3ZP
         u1gXY9tdFGgwJ8tmU8EVY7rbSotavPKCpesPhXgjVrUwn25ArT9d0SxbBd/YWrkznLm9
         MRqfmouYp3bJySBmB8fe8T7whi5cV5Hecko3y8UTYLbf2Tyr5QLPLhz8ETvQUnsVxNG+
         ZLIlRo7KNVYOj3cYJT+dM81jNOqXEWVT8FkO8V6gVXo+5NlNLVZC9HmDKBm7wNtTm2+I
         8BVQ==
X-Gm-Message-State: AOJu0YyMH5oemEAJI9pmW4UTbZIgwekUpPsxgfRhuC+355Z7lr8F4lR6
	eN+ws5cJ/hBSizRuLKRP+JrTeXL2D72cTPpqOxHNrF6ob22RP7eGQ4797vRrqLPPEs+nLfS/noo
	2zkrz8pdb8+ZXabSOF5f39Wu2M/Ly8b0QY3qtyd6rZcL3R3ybitm43dNovw==
X-Gm-Gg: Acq92OHhYhL8K/fQFcbYennIlxjwLor37/kon2XC8dCsGbFJLdv8xHHXv9aC+POXBkR
	QxxkQV4hXcL48OyvF6r9zPlGzPaGDYwHUx4t7tu9naPxTE7Zfd+hqqACeQRYZa4zZULlxx74kQm
	sG/q7KoQtL2r7E5ySa9Pw5IfS43IIu2BTCoKDSFvbWrVjpyadUUV7iAOJnZ7gkdRJW2WPURyz+d
	u3LEMEjuHacMT7bZe+yKx5LfeHp5no2fKKD+Dp2ITw9Y97FI+XKhFsdhwwuNfXu29oqDewlDYuS
	VyYd7Kl0UN250JJHlzCxkAREeXK0DOekWGCBthQhWKmwWWX7Dc0tJlV2yg1Yg5j1NfbaQFQ8yjb
	+65GGR23rfbgXphYSkCNSkKdtZQs5YEt6msrfHPat
X-Received: by 2002:a05:600c:4fc9:b0:489:1c1f:35f1 with SMTP id 5b1f17b1804b1-48fc9a030eemr107778195e9.4.1778771787722;
        Thu, 14 May 2026 08:16:27 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc9:b0:489:1c1f:35f1 with SMTP id 5b1f17b1804b1-48fc9a030eemr107777655e9.4.1778771787145;
        Thu, 14 May 2026 08:16:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767d0bsm6761145f8f.3.2026.05.14.08.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 08:16:26 -0700 (PDT)
Date: Thu, 14 May 2026 11:16:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving
 queue overflow
Message-ID: <20260514111513-mutt-send-email-mst@kernel.org>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-2-sgarzare@redhat.com>
 <agXh36gUe1K6__Bk@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agXh36gUe1K6__Bk@sgarzare-redhat>
X-Rspamd-Queue-Id: C92C8543FC9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288022-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 04:57:16PM +0200, Stefano Garzarella wrote:
> On Wed, May 13, 2026 at 12:54:16PM +0200, Stefano Garzarella wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > When there is no more space to queue an incoming packet, the packet is
> > silently dropped. This causes data loss without any notification to
> > either peer, since there is no retransmission.
> > 
> > Under normal circumstances, this should never happen. However, it could
> > happen if the other peer doesn't respect the credit, or if the skb
> > overhead, which we recently began to take into account with commit
> > 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
> > is too high.
> > 
> > Fix this by resetting the connection and setting the local socket error
> > to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
> > packet, so both peers are explicitly notified of the failure rather than
> > silently losing data.
> > 
> > Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > net/vmw_vsock/virtio_transport_common.c | 19 ++++++++++++++-----
> > 1 file changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index 989cc252d3d3..4a4ac69d1ad1 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1350,7 +1350,7 @@ virtio_transport_recv_connecting(struct sock *sk,
> > 	return err;
> > }
> > 
> > -static void
> > +static bool
> > virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > 			      struct sk_buff *skb)
> > {
> > @@ -1365,10 +1365,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > 	spin_lock_bh(&vvs->rx_lock);
> > 
> > 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> > -	if (!can_enqueue) {
> > -		free_pkt = true;
> > +	if (!can_enqueue)
> > 		goto out;
> > -	}
> > 
> > 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
> > 		vvs->msg_count++;
> > @@ -1408,6 +1406,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > 	spin_unlock_bh(&vvs->rx_lock);
> > 	if (free_pkt)
> > 		kfree_skb(skb);
> > +
> > +	return can_enqueue;
> > }
> > 
> > static int
> > @@ -1420,7 +1420,16 @@ virtio_transport_recv_connected(struct sock *sk,
> > 
> > 	switch (le16_to_cpu(hdr->op)) {
> > 	case VIRTIO_VSOCK_OP_RW:
> > -		virtio_transport_recv_enqueue(vsk, skb);
> > +		if (!virtio_transport_recv_enqueue(vsk, skb)) {
> > +			/* There is no more space to queue the packet, so let's
> > +			 * close the connection; otherwise, we'll lose data.
> > +			 */
> > +			(void)virtio_transport_reset(vsk, skb);
> > +			sk->sk_state = TCP_CLOSE;
> > +			sk->sk_err = ENOBUFS;
> > +			sk_error_report(sk);
> 
> sashiko reported some issues related to setting TCP_CLOSE state and not
> removing the socket from the connect table:
> https://sashiko.dev/#/patchset/20260513105417.56761-1-sgarzare%40redhat.com
> 
> I'll change this by calling virtio_transport_do_close() and
> vsock_remove_sock() in the next version.
> 
> Stefano
> 
> > +			break;
> > +		}
> > 		vsock_data_ready(sk);
> > 		return err;
> > 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
> > -- 
> > 2.54.0
> > 


And so the bag of hacks grows. I feel this is energy not well spent.
Please, let us fix this properly *first*. And then worry about how to
backport.  Maybe it will not be so terrible to backport after all.


