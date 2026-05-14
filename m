Return-Path: <netdev+bounces-288042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNlMGo/8BWrFdwIAu9opvQ
	(envelope-from <netdev+bounces-288042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:47:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B97BC544E87
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D1C63043470
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FAB345749;
	Thu, 14 May 2026 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9Y7mUmi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="elvNK8dw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAA82BE057
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777117; cv=pass; b=gJLyj74zQ7f1+6reUxbbcVZ+Y+buEg5MZzO7fs74yr16BZz+xdrEa73eKhb7vWnZ80uOKAUHZ6h57eDhHDAtE+hC6RTtKk3XnUodoOJQniwtxQ7BVqZhVn8VgFyi5F7e7SSAMtePeZVszB9kN2Fnw3gAjjvZLtRMxitIzov5ONQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777117; c=relaxed/simple;
	bh=zZzMMRJMHDj4bAdx59InN/qWYOHXeVGUIGiGQSI5A2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAKARlRotIbrN163mzVEoIqkv0B4DMcoeE9G45sN6YSagefCC5b9jesp6Hl+eSnOCYxKHPnEEKt/9y+xurCjUHv8RzfiT01YGqg5mpIBt7AIuO0wPqOwcVzq4wy2057yex2qfrE774gS8pXkrYy+8+C01SnR0qLGMAYfxa8RnyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9Y7mUmi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=elvNK8dw; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778777115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GE7Sq5sTYAoJOxhLn6zS0szJk7y05mcClLoUpAWwPBg=;
	b=I9Y7mUmi7VZpRRrL3l0hW4yoyJhdKKgtw6HNRWP4kwz1R+DcijcU905d3sKzaUoJR8Fyz+
	RXtMI37WvA7iPctz9MNb13REWSPhBirnmQEhIUc6mNE2V/EoaRDNlK66lmkYEGS1R4OPuX
	hnyb5FMeKJfr/rKf/C+QJEFS0nlSjWE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-KLAel46FNCubXQycBZ6QYQ-1; Thu, 14 May 2026 12:45:14 -0400
X-MC-Unique: KLAel46FNCubXQycBZ6QYQ-1
X-Mimecast-MFC-AGG-ID: KLAel46FNCubXQycBZ6QYQ_1778777113
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so10130b3a.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778777113; cv=none;
        d=google.com; s=arc-20240605;
        b=N7Lb70tBbFLSTmNOt3MfgiK2YBexaRHZRHXdBFL8yyb3Sw0N2q9MnSSjBJh0aCr6Ka
         YtZX9aSQVvJjiUgtoHQ6tDsFnSKP/ass5k7YEi/65FYYiynE9NHHUwDL4r7AiWRZyOI+
         MMEhp/aiPkbh+ACl6CpUxborZwWKsjVlhhgQr0ziBHkwg6z8KaMlMCIlHUKLtR5W0Jy/
         X4mGHnjSfJphAH+Rfk6xARS5LWjXYheKly3h1dmWflO2YekW8suieATeSUx0sJaSMIAM
         c95mZYua9WFbnurYs+rJbovd9e4p6qekHE69m+csORFzrNZ8apKHRIAhsgG8l+BtfhQ/
         pmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GE7Sq5sTYAoJOxhLn6zS0szJk7y05mcClLoUpAWwPBg=;
        fh=ilGQbjYE7CEyZaiYPiDtafB0Na+ggF7MAKzsjiHGaZg=;
        b=Dt1wd6DFCVD54cKP3snKahpx+Ogytk8m04yxinNMjr/YoeP2oTiFNpaywnKRNshSEj
         C5zx9nGY6uUBuAPZlNFL0hYoUQWAce/PydSaWy15LRHWltseTQYyfABU7LnkrE3JYpsr
         bak/7Km6k8vxOZwjTgk/XnZOWJzKsDUW7Ix4eW3jlFTNosXxQL6cCtpHMQe9R6eywh1j
         8TUCNMd6t9M0UVtFL54UWHWtnoOl5IGUh9LnYqe1Jcfn4bnixE/ydfuE/l4lOarGfNzU
         I2Qzk4BsvRb55lmCRS2nVAFsqVssJJuvl97rHRjttgZvJCS3ZW+B2k1lfadLhjXhp1Uw
         aNNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778777113; x=1779381913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GE7Sq5sTYAoJOxhLn6zS0szJk7y05mcClLoUpAWwPBg=;
        b=elvNK8dwPFPa8bd/SvwkKvoDRKTMlQAvh1I+gty71xBaKnk6/D2aAoY+gXBJIO7z7h
         yrjbG954ar8YEVSBWPhqSKsDkCrC8BsgBPDDsM+kBH/p0Wea289or3c8XiUJT5hynh42
         3tvbs2I/ftgPqcDXbOeSIiCdnma5FANn+P7hfx4i5stTECDYYOM/ZxeYi1SoamSPu2Z4
         WbzGC1pV2Ut6emSGHhi0thWMKgYjNgMrPNVz3A/D8d1qjWaM0Q1hF0Y2l/QxHWfiFFbK
         SO+AJDtREFVuu2pFnRJ7MbvusO9avSLAQgaAf3NX7mcn7LPA5pWiW3ZogYZ2xx/gtspV
         69eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777113; x=1779381913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE7Sq5sTYAoJOxhLn6zS0szJk7y05mcClLoUpAWwPBg=;
        b=f2s7oTOsz9jDvNpxXjXURn9Ra6zBXO42yr7O7rU6LeSxcdm0HAom3tJUDFIBfxZm49
         dcmXAqGTZtarp0aulosl03wPGcq080zDORrgAG+wKOH5580Bgx5FTBMrNNjqlyu9Mmll
         1I9d7U0tp/fO5yEwFl97vSBa4crWnTK8gluWs7EF8VlOpQ7ktNXziezf1wJXwVINtGV/
         JfQs77X++DVXHqR7oCeBK/6Ve5ohh/W2FbRvGMyQYX97gAmhHlMYTB/Q81SbEleOCDFX
         cKNYVX+4Uu0zH9FQZVYFdjyiybFr4zqyTvi1O20uK8GVrSrXyPYzgsi2YPuMPjIT/JSE
         r1bg==
X-Gm-Message-State: AOJu0Yz/qxYyZBCC51CvS3tL+47zGvCXbPWLj8UdtAwtC6elradECnDE
	w+dyM/RDmaJCBzsaX3mZ7Qf2tuiH7OFiRzUap5UNxbK1k1SmhO3VhIQ3+u+eCpf5FaYkgglKUAx
	9MmXIXF7kN8qC1UM1NGJyYp23G+Ce5TEF/9dIxU7jqvE9Fu7LNii1vavZuSf14H28xceCRvGxwS
	XtelY39FHAyP5RdDrNPmy9ghoUvVuoj5s1naLZ8XpSTL0=
X-Gm-Gg: Acq92OGUbIv5aBreiKluBL2y6aEQfA/cA+LimwqV8oHpw+Ck7faNE6LkwOZ9EPsTKL6
	BbpojOZPWk4c8Bqds3whbbjHAd2YOXSquvc0HaQdbJ7+8X9kVPJL9nAoNL9qLL16YGUzBi9FuEU
	Qf7ZTNZmU78DiWlwB35A3R9QhguuKsTrDN08DV/R/squkXfHIyyvGCGmZJiMlXyn3R2V9LOsSee
	taQPg==
X-Received: by 2002:a05:6a00:bc93:b0:837:8a0c:8f70 with SMTP id d2e1a72fcca58-83f18ec2d11mr4217038b3a.28.1778777112652;
        Thu, 14 May 2026 09:45:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:bc93:b0:837:8a0c:8f70 with SMTP id
 d2e1a72fcca58-83f18ec2d11mr4217000b3a.28.1778777112018; Thu, 14 May 2026
 09:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513105417.56761-1-sgarzare@redhat.com> <20260513105417.56761-2-sgarzare@redhat.com>
 <agXh36gUe1K6__Bk@sgarzare-redhat> <20260514111513-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260514111513-mutt-send-email-mst@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 14 May 2026 18:45:00 +0200
X-Gm-Features: AVHnY4I_HyzF3GHdZFExrbox_xrkjrz-SlkZ9VT6btL5CcXjAJ3lI9yS4iPlqv8
Message-ID: <CAGxU2F4qWcQTmXnH74V8xZKADLiEMUmCc0+ktW5fZOXdTP4Bdw@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving
 queue overflow
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: B97BC544E87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288042-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 14 May 2026 at 17:16, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, May 14, 2026 at 04:57:16PM +0200, Stefano Garzarella wrote:
> > On Wed, May 13, 2026 at 12:54:16PM +0200, Stefano Garzarella wrote:
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > >
> > > When there is no more space to queue an incoming packet, the packet is
> > > silently dropped. This causes data loss without any notification to
> > > either peer, since there is no retransmission.
> > >
> > > Under normal circumstances, this should never happen. However, it could
> > > happen if the other peer doesn't respect the credit, or if the skb
> > > overhead, which we recently began to take into account with commit
> > > 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
> > > is too high.
> > >
> > > Fix this by resetting the connection and setting the local socket error
> > > to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
> > > packet, so both peers are explicitly notified of the failure rather than
> > > silently losing data.
> > >
> > > Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > > net/vmw_vsock/virtio_transport_common.c | 19 ++++++++++++++-----
> > > 1 file changed, 14 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > index 989cc252d3d3..4a4ac69d1ad1 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -1350,7 +1350,7 @@ virtio_transport_recv_connecting(struct sock *sk,
> > >     return err;
> > > }
> > >
> > > -static void
> > > +static bool
> > > virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > >                           struct sk_buff *skb)
> > > {
> > > @@ -1365,10 +1365,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > >     spin_lock_bh(&vvs->rx_lock);
> > >
> > >     can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> > > -   if (!can_enqueue) {
> > > -           free_pkt = true;
> > > +   if (!can_enqueue)
> > >             goto out;
> > > -   }
> > >
> > >     if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
> > >             vvs->msg_count++;
> > > @@ -1408,6 +1406,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > >     spin_unlock_bh(&vvs->rx_lock);
> > >     if (free_pkt)
> > >             kfree_skb(skb);
> > > +
> > > +   return can_enqueue;
> > > }
> > >
> > > static int
> > > @@ -1420,7 +1420,16 @@ virtio_transport_recv_connected(struct sock *sk,
> > >
> > >     switch (le16_to_cpu(hdr->op)) {
> > >     case VIRTIO_VSOCK_OP_RW:
> > > -           virtio_transport_recv_enqueue(vsk, skb);
> > > +           if (!virtio_transport_recv_enqueue(vsk, skb)) {
> > > +                   /* There is no more space to queue the packet, so let's
> > > +                    * close the connection; otherwise, we'll lose data.
> > > +                    */
> > > +                   (void)virtio_transport_reset(vsk, skb);
> > > +                   sk->sk_state = TCP_CLOSE;
> > > +                   sk->sk_err = ENOBUFS;
> > > +                   sk_error_report(sk);
> >
> > sashiko reported some issues related to setting TCP_CLOSE state and not
> > removing the socket from the connect table:
> > https://sashiko.dev/#/patchset/20260513105417.56761-1-sgarzare%40redhat.com
> >
> > I'll change this by calling virtio_transport_do_close() and
> > vsock_remove_sock() in the next version.
> >
> > Stefano
> >
> > > +                   break;
> > > +           }
> > >             vsock_data_ready(sk);
> > >             return err;
> > >     case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
> > > --
> > > 2.54.0
> > >
>
>
> And so the bag of hacks grows. I feel this is energy not well spent.
> Please, let us fix this properly *first*. And then worry about how to
> backport.  Maybe it will not be so terrible to backport after all.
>

TBH I don't think this is an hack, but an issue we should fix in any case.
Regarding the second patch, I see your point, but it's a big change
that worries me. I'd like some more time to fix it properly without
rushing. Staying calm without realizing that userspace is broken like
we are now without this series :-(

That said, evaluating further, I think we have a similar issue also
with STREAM on the host side where the skb usually doesn't free space,
so we need a merge strategy also there.

So, I'd like to have time to fix both definitely. If you have time and
want to go ahead, please do.

Thanks,
Stefano


