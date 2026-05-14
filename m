Return-Path: <netdev+bounces-288066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMS4GFEKBmp2eQIAu9opvQ
	(envelope-from <netdev+bounces-288066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:45:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C54545824
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2098F305C5BE
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1207390C84;
	Thu, 14 May 2026 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9cIdF4c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VO89xbW8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC27390C85
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780704; cv=none; b=Iay187ukJS4A4g2vDfRvpzVxMGBVXeC4Rsm1LFRL48rY+/ShDD8CTnjGWQCzjxIxiZDhQInA8bGN3vpzQM6Rpd/kQH979R4u25I1MFRN5tgFcQusYJutnfDdQa4oxujDMQrVp8jprlmJ0dFOTr7a/1cUKiBrqaxEqJjVmuKVuiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780704; c=relaxed/simple;
	bh=uJrp/dJwg6Cte7WCz5lnrjz8/PKP0QJL6LfVLtK5AD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rnf52jWstGBPT6GqI4V62Zo3MiRWrSVV4ebufDlvdVktk2tsgvSRqyuLc/GBAgMP7KXpi6AVi4hvJpt7gRlqoLX+N0G4dorCEHkRIvzJsJLzH85bJoMyvj3HCq+WZTzP614KNBmXiUTD2L8B1eIeOrOm3MoJoo6mq+JHMaNBA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9cIdF4c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VO89xbW8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778780702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LPVhEx3/fFkcUjpHActlkwEdsBsjACMHfijDZCZaQ6s=;
	b=O9cIdF4cw4qrEgtmBnjmwP1sQ+dWkzZRYQFyGXo4UsOvCBrfOCufRsaDGxtFUuIccoiBQN
	0X7VumP4Sb6qn/rAbLxnKTpykt019DxJg1ubKFU2kEBUOANooKpDkqO0jINKS4tEYd+yRh
	1FraJjfAO/lA5Rp3og5dVSfmjbiErsQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-6ueOCHmQNH2fVluoPbfHgA-1; Thu, 14 May 2026 13:44:59 -0400
X-MC-Unique: 6ueOCHmQNH2fVluoPbfHgA-1
X-Mimecast-MFC-AGG-ID: 6ueOCHmQNH2fVluoPbfHgA_1778780698
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-449dcfe8005so7863306f8f.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778780698; x=1779385498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LPVhEx3/fFkcUjpHActlkwEdsBsjACMHfijDZCZaQ6s=;
        b=VO89xbW8e3c1EcgbPNmYawB5CnMrYb3fr4mfaJ9dKdmdIIz87gjzabYtsgttHFVHVn
         CtnWAX6qCocgvNSVWx52FA02MyYr/ZE9jTg4qgxasuVFiJAk3KwJ50d6TFx9Oyd+NLgB
         4OIYLjrhx9peuEJ6Ztb1I3OaEgbwSqeUaWpi5NaSqCP7SuvpcexpRTingR+2JczV+1p/
         48bPIheG6thItK5p38SFmg7OQ9kEAkxU0xYehVDubVUKvtI+SAS8IDJBUDG53n7pqCsJ
         2cdPG0wCWdUh8irm7433wP8EnnZcV1/h2ZVGETTXJ8eO15U729fJ0PmtCqTEsGU0aZL7
         N4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780698; x=1779385498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPVhEx3/fFkcUjpHActlkwEdsBsjACMHfijDZCZaQ6s=;
        b=WdGb2dENiF7IySPEjxxJAYDZ5mRhk6xHXpPJ/Djy9N7GSOSOjaf6qW9Ct/vWhFnmpf
         5HT80d7OHYrHjAO7uTmUBX1Vv2SmMOpxJH65pPHSFpkinnQvRYbMZJdNnFV645/6TqJI
         AgEF/PaT65PTAvDt7VDa4BrnyyO+EE5B2YWwL9rtQ0L6t/tKrYEH9CGJrdTDXkLP5PZx
         N8JBVThtXLdenZlXT9FP8QK5XLodnyeWxfJSrD9tTgSCThsAgCcWVBLNuYVWoGMqj9vZ
         JbwAdbSXsQGiRBKwpb2JUGgdrY7Ns7Bh1PWvp7ifwBrYLrdCWvj1YS4plhdPasnvSKvp
         Gjxg==
X-Gm-Message-State: AOJu0Yx0s0sJ2gXxTamDwxs0FTNQByrPwbC3/hjXfsbRwjGPCVSwXAvv
	3VW1CxKF11PsObyY/lX1GkIIWl4NlAl7R6uRQb8SDVgAoazHjDnQbV7MvK4vlIgv+cosXpErzny
	ZMjdl23f+mynxhG+e7FahBe7ifFqtYcy8viiqygFVbDUtNAJizVaeJ4M38w==
X-Gm-Gg: Acq92OF12zrgWLCjdeQQ+NGCEHE+DVw/TU0uXmZ2BmYcLPl9VaCm9vpwr6S+NkfTazg
	nP/keB+6BCM3jTax0lhfJf+Yy1FzkIVGWNcTKl6X8CNun27wCD8E52aBrEdOM9l+ewSniS4M1nn
	c7UabWC6lssg+oca7uNgCBV0XYx00jZXsB3xNURn9u4d30a7r6/kUkCJih+ZY+nqh1Z0ACGM7Ov
	rrCnb1MYpuIcfd30ZfbxoBiLMdkrQxP/XGnjReGIXIk0IO5DTVff8gaGBL7pZkfa+LEveTi/1CN
	l6Ru4KPNZD2mFsDX/vmvvd+FeHv8cFk32epnCGsaf3uZEmtCQwob+6oBaCS+e7n8VmJ6o2e17b5
	lBHupq0lo0pkUUWbJds3fb7uO8lZIHCHyfP3Fc424
X-Received: by 2002:a05:600c:4e47:b0:48f:e1ac:c94f with SMTP id 5b1f17b1804b1-48fe60eb0ebmr5879605e9.10.1778780698033;
        Thu, 14 May 2026 10:44:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4e47:b0:48f:e1ac:c94f with SMTP id 5b1f17b1804b1-48fe60eb0ebmr5879125e9.10.1778780697532;
        Thu, 14 May 2026 10:44:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd768f75asm22669135e9.29.2026.05.14.10.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:44:56 -0700 (PDT)
Date: Thu, 14 May 2026 13:44:53 -0400
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
Message-ID: <20260514134347-mutt-send-email-mst@kernel.org>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-2-sgarzare@redhat.com>
 <agXh36gUe1K6__Bk@sgarzare-redhat>
 <20260514111513-mutt-send-email-mst@kernel.org>
 <CAGxU2F4qWcQTmXnH74V8xZKADLiEMUmCc0+ktW5fZOXdTP4Bdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F4qWcQTmXnH74V8xZKADLiEMUmCc0+ktW5fZOXdTP4Bdw@mail.gmail.com>
X-Rspamd-Queue-Id: A7C54545824
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288066-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 06:45:00PM +0200, Stefano Garzarella wrote:
> On Thu, 14 May 2026 at 17:16, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, May 14, 2026 at 04:57:16PM +0200, Stefano Garzarella wrote:
> > > On Wed, May 13, 2026 at 12:54:16PM +0200, Stefano Garzarella wrote:
> > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > >
> > > > When there is no more space to queue an incoming packet, the packet is
> > > > silently dropped. This causes data loss without any notification to
> > > > either peer, since there is no retransmission.
> > > >
> > > > Under normal circumstances, this should never happen. However, it could
> > > > happen if the other peer doesn't respect the credit, or if the skb
> > > > overhead, which we recently began to take into account with commit
> > > > 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
> > > > is too high.
> > > >
> > > > Fix this by resetting the connection and setting the local socket error
> > > > to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
> > > > packet, so both peers are explicitly notified of the failure rather than
> > > > silently losing data.
> > > >
> > > > Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > ---
> > > > net/vmw_vsock/virtio_transport_common.c | 19 ++++++++++++++-----
> > > > 1 file changed, 14 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > > index 989cc252d3d3..4a4ac69d1ad1 100644
> > > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > > @@ -1350,7 +1350,7 @@ virtio_transport_recv_connecting(struct sock *sk,
> > > >     return err;
> > > > }
> > > >
> > > > -static void
> > > > +static bool
> > > > virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > > >                           struct sk_buff *skb)
> > > > {
> > > > @@ -1365,10 +1365,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > > >     spin_lock_bh(&vvs->rx_lock);
> > > >
> > > >     can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> > > > -   if (!can_enqueue) {
> > > > -           free_pkt = true;
> > > > +   if (!can_enqueue)
> > > >             goto out;
> > > > -   }
> > > >
> > > >     if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
> > > >             vvs->msg_count++;
> > > > @@ -1408,6 +1406,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > > >     spin_unlock_bh(&vvs->rx_lock);
> > > >     if (free_pkt)
> > > >             kfree_skb(skb);
> > > > +
> > > > +   return can_enqueue;
> > > > }
> > > >
> > > > static int
> > > > @@ -1420,7 +1420,16 @@ virtio_transport_recv_connected(struct sock *sk,
> > > >
> > > >     switch (le16_to_cpu(hdr->op)) {
> > > >     case VIRTIO_VSOCK_OP_RW:
> > > > -           virtio_transport_recv_enqueue(vsk, skb);
> > > > +           if (!virtio_transport_recv_enqueue(vsk, skb)) {
> > > > +                   /* There is no more space to queue the packet, so let's
> > > > +                    * close the connection; otherwise, we'll lose data.
> > > > +                    */
> > > > +                   (void)virtio_transport_reset(vsk, skb);
> > > > +                   sk->sk_state = TCP_CLOSE;
> > > > +                   sk->sk_err = ENOBUFS;
> > > > +                   sk_error_report(sk);
> > >
> > > sashiko reported some issues related to setting TCP_CLOSE state and not
> > > removing the socket from the connect table:
> > > https://sashiko.dev/#/patchset/20260513105417.56761-1-sgarzare%40redhat.com
> > >
> > > I'll change this by calling virtio_transport_do_close() and
> > > vsock_remove_sock() in the next version.
> > >
> > > Stefano
> > >
> > > > +                   break;
> > > > +           }
> > > >             vsock_data_ready(sk);
> > > >             return err;
> > > >     case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
> > > > --
> > > > 2.54.0
> > > >
> >
> >
> > And so the bag of hacks grows. I feel this is energy not well spent.
> > Please, let us fix this properly *first*. And then worry about how to
> > backport.  Maybe it will not be so terrible to backport after all.
> >
> 
> TBH I don't think this is an hack, but an issue we should fix in any case.
> Regarding the second patch, I see your point, but it's a big change
> that worries me. I'd like some more time to fix it properly without
> rushing. Staying calm without realizing that userspace is broken like
> we are now without this series :-(
> 
> That said, evaluating further, I think we have a similar issue also
> with STREAM on the host side where the skb usually doesn't free space,
> so we need a merge strategy also there.
> 
> So, I'd like to have time to fix both definitely. If you have time and
> want to go ahead, please do.
> 
> Thanks,
> Stefano

Well my patch was a start, we just need a strategy how to avoid copying
everything, right?

-- 
MST


