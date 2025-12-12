Return-Path: <netdev+bounces-244486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B474CB8C3A
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 13:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A6173065E39
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 12:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720FE320A0F;
	Fri, 12 Dec 2025 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZNgU1sB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3rCRyvV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E73C2E173E
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765540953; cv=none; b=HmwUjdx/fjWrKwx/9Nv1B3AO9DAxegeVzTozXyFeCx+p2h60bAg2TmsL53p8yuFVzM/7W74qmlX6ireL9NuoObclyfTbQ8DcEKmkks0Cwd6PEjAPLoVxcZ/uOtWLl2KsnCssPfMRxJcciU2PmOndqLQDeRrpnLCgBY8pP0LWlwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765540953; c=relaxed/simple;
	bh=Knk/DG1B2Fp8H3CFOuJ2poakK9uXBDLmeJdDZ5Cv5OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXcvhyNiO3h+JpznimEHxOUedKPr/odcFKNyg9QfRqV0H5rt4TcGtzQ3PDdAwqg2w3OVm5zbKsLgCZhW6bf3WaT0MVnXxJQtw5HWjwKLhHzD/lOII66P5uN7UNDuz9fmA45lsFcTt7R44/YdSiXAJhp5/5W/5VC1wHWa4O1njww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZNgU1sB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3rCRyvV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765540950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=anI5Vw1WVw9tlaNczVPzG2vmerSgW/74zlvbCR0SJVA=;
	b=ZZNgU1sBgiENnIfJD6sudR9LVlSBwMbl1ye97FYSrM/wTDCOhIibHMl7/GhXzTJqbF77yb
	tQerOIkVByoxFI/qLCXFLkWM2jBAP9CrkjVtx9KBxErNjcfiduXMxYLkYmousG+MUGRoZZ
	Qy2dFhJPCr4Vmtcg+d2Cq4PM3kjgVgE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-6hhCZsmXOWy7g2cQFWHj9g-1; Fri, 12 Dec 2025 07:02:29 -0500
X-MC-Unique: 6hhCZsmXOWy7g2cQFWHj9g-1
X-Mimecast-MFC-AGG-ID: 6hhCZsmXOWy7g2cQFWHj9g_1765540948
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42e29783a15so629313f8f.1
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 04:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765540948; x=1766145748; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=anI5Vw1WVw9tlaNczVPzG2vmerSgW/74zlvbCR0SJVA=;
        b=e3rCRyvV3TFC+ukGeba1r7QSL7slAnJCqkMUqm/u0Bq1aprXgfvEmAxIVTbamBetLX
         gW234YmmaASTAePp8K5+iFh0kuKj6l8nUVFk3RiEyGPlkYj/EDLPSrdpOPrcUM8Yi9ry
         7ETWssgJPOyRDddlBCPBX2M0xFpmC6G9IEiVkRS/e9M9jxU1BsNz0Wq+SENbE4ILn4NE
         wz6PkB6q2JjtGVPbKAxrkx0LVBK6ueAVKsqRjkRcSH4MhFLL+A2DsmHcXVd6EtHMNKnb
         bJqou7fTQ0flLot7ytIP9qrnH4IZKgTfjWQjWXjGAgGE8bgqsvFBxqRCFXbU5SYzeHJy
         Qk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765540948; x=1766145748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anI5Vw1WVw9tlaNczVPzG2vmerSgW/74zlvbCR0SJVA=;
        b=mT7CyvnlbK3DSTw4EKCtIErZU3W7Xd5JV0P0yeFKf1OfomdVWfUBIE5hbZOHnonjSX
         0BdDTVZEaVTFiyEkDViCM2i27RB/yq/mo9dG2t9PyhAZzcNHlqmdkiCT1Gjq0WKaZ3Lf
         N61lld1N4KlH2bLp6SionMV2giJBKpqg9agmNtTN0zkK9RkO3AprzyRoI9mZXuK0XYbj
         s3YQv72cwGe5eH4pt4MqDRU6HB66LlevnibFCMbYeqATD6ojsORQK3RspGeVFMmdOdat
         TtgQKxqzATZGJIMIG+JVOJ7wlzTL+GB2ODrCLixXuGkniPSxYW0NffS9ytevejpPXdQ8
         4fGg==
X-Forwarded-Encrypted: i=1; AJvYcCVxVwFSzcI9Kcobfr+B8QP2KRxA25F6uAKPDVjr5AjO8g/ms10CZiUVbr9cK3yY+DnfUY/magY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiJ6mUp+d2zOmGbZw42EuVTqgyeaAR8aBSC6ZHP7dP1R3NgITd
	oEEhZ+sG8Szw0GZJXHTmgUyveRja1wthbUgtDLmEhDJqNbbAf548iMfo+8WMSYtEAYKCQzZwsXR
	uYKUkNJuRLX+BWNpeYxqqr/0Ds5AqEvdAstZtMp/25f5dfB2zUvnxJVRH8w==
X-Gm-Gg: AY/fxX7uBeCKT0wXl6qFUDCC6xYOb8t7XKYK5zDtQFmBGCnkfxpAwMHza10zR45V0b9
	ZvB7C024H46YEI1VJYITeatBBi7stWGTM+PxD2p2XZjg8XZ1uQVvWq9I0JISaoLTxCIhMew1op9
	WKhwqR2TOMJSuPZGFwzSm21DxaNNk/eN3lMMw/iEdR2TOPQpCuf2JXdgVHZ6zUc8onDxHAfPEsK
	qrV/V6rsh8TdLJ/km9VQ9PgjeCTkYeBoklGLPCFanP66nIg1MqVLAjrIAUqPX/qPxLCJJ544/bF
	w5v+FZcf4bJv4eb+nU6FwsT3sUOht5ShXM4ZyvcLrBdPMk0vjDCR7oP7bpdBAE/UYOQxIqcPPmc
	XVuDuDA5Pz3w0ZT8xHKCqUMdPIMKRrhw=
X-Received: by 2002:a05:6000:250d:b0:429:ccd0:d36c with SMTP id ffacd0b85a97d-42fab263a8cmr6193242f8f.14.1765540947798;
        Fri, 12 Dec 2025 04:02:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgNplNvjgfynSoRpZJNSdadFjCTOplxc6/OltvD4Fk12TY/a/3F2tktiV+W2AeV26wGiXpVg==
X-Received: by 2002:a05:6000:250d:b0:429:ccd0:d36c with SMTP id ffacd0b85a97d-42fab263a8cmr6193191f8f.14.1765540947236;
        Fri, 12 Dec 2025 04:02:27 -0800 (PST)
Received: from redhat.com (IGLD-80-230-32-59.inter.net.il. [80.230.32.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b8a950sm12918506f8f.32.2025.12.12.04.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 04:02:25 -0800 (PST)
Date: Fri, 12 Dec 2025 07:02:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, stefanha@redhat.com,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net v3] vsock/virtio: cap TX credit to local buffer size
Message-ID: <20251212065127-mutt-send-email-mst@kernel.org>
References: <20251211125104.375020-1-mlbnkm1@gmail.com>
 <20251211080251-mutt-send-email-mst@kernel.org>
 <zlhixzduyindq24osaedkt2xnukmatwhugfkqmaugvor6wlcol@56jsodxn4rhi>
 <CAMKc4jDpMsk1TtSN-GPLM1M_qp_jpoE1XL1g5qXRUiB-M0BPgQ@mail.gmail.com>
 <CAGxU2F7WOLs7bDJao-7Qd=GOqj_tOmS+EptviMphGqSrgsadqg@mail.gmail.com>
 <CAMKc4jDLdcGsL5_d+4CP6n-57s-R0vzrX2M7Ni=1GeCB1cxVYA@mail.gmail.com>
 <bwmol6raorw233ryb3dleh4meaui5vbe7no53boixckl3wgclz@s6grefw5dqen>
 <deccf66c-dcd3-4187-9fb6-43ddf7d0a905@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <deccf66c-dcd3-4187-9fb6-43ddf7d0a905@gmail.com>

On Fri, Dec 12, 2025 at 11:40:03AM +0000, Melbin K Mathew wrote:
> 
> 
> On 12/12/2025 10:40, Stefano Garzarella wrote:
> > On Fri, Dec 12, 2025 at 09:56:28AM +0000, Melbin Mathew Antony wrote:
> > > Hi Stefano, Michael,
> > > 
> > > Thanks for the suggestions and guidance.
> > 
> > You're welcome, but please avoid top-posting in the future:
> > https://www.kernel.org/doc/html/latest/process/submitting-
> > patches.html#use-trimmed-interleaved-replies-in-email-discussions
> > 
> Sure. Thanks
> > > 
> > > I’ve drafted a 4-part series based on the recap. I’ve included the
> > > four diffs below for discussion. Can wait for comments, iterate, and
> > > then send the patch series in a few days.
> > > 
> > > ---
> > > 
> > > Patch 1/4 — vsock/virtio: make get_credit() s64-safe and clamp negatives
> > > 
> > > virtio_transport_get_credit() was doing unsigned arithmetic; if the
> > > peer shrinks its window, the subtraction can underflow and look like
> > > “lots of credit”. This makes it compute “space” in s64 and clamp < 0
> > > to 0.
> > > 
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c
> > > b/net/vmw_vsock/virtio_transport_common.c
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -494,16 +494,23 @@
> > > EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
> > > u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32
> > > credit)
> > > {
> > > + s64 bytes;
> > >  u32 ret;
> > > 
> > >  if (!credit)
> > >  return 0;
> > > 
> > >  spin_lock_bh(&vvs->tx_lock);
> > > - ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
> > > - if (ret > credit)
> > > - ret = credit;
> > > + bytes = (s64)vvs->peer_buf_alloc -
> > 
> > Why not just calling virtio_transport_has_space()?
> virtio_transport_has_space() takes struct vsock_sock *, while
> virtio_transport_get_credit() takes struct virtio_vsock_sock *, so I cannot
> directly call has_space() from get_credit() without changing signatures.
> 
> Would you be OK if I factor the common “space” calculation into a small
> helper that operates on struct virtio_vsock_sock * and is used by both
> paths? Something like:
> 
> /* Must be called with vvs->tx_lock held. Returns >= 0. */
> static s64 virtio_transport_tx_space(struct virtio_vsock_sock *vvs)
> {
> 	s64 bytes;
> 
> 	bytes = (s64)vvs->peer_buf_alloc -
> 		((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
> 	if (bytes < 0)
> 		bytes = 0;
> 
> 	return bytes;
> }

some explanation of what all these casts do, can't hurt.

> Then:
> 
> get_credit() would do bytes = virtio_transport_tx_space(vvs); ret =
> min_t(u32, credit, (u32)bytes);
> 
> has_space() would use the same helper after obtaining vvs = vsk->trans;
> 
> Does that match what you had in mind, or would you prefer a different
> factoring?
> 
> > 
> > > + ((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
> > > + if (bytes < 0)
> > > + bytes = 0;
> > > +
> > > + ret = min_t(u32, credit, (u32)bytes);
> > >  vvs->tx_cnt += ret;
> > >  vvs->bytes_unsent += ret;
> > >  spin_unlock_bh(&vvs->tx_lock);
> > > 
> > >  return ret;
> > > }
> > > 
> > > 
> > > ---
> > > 
> > > Patch 2/4 — vsock/virtio: cap TX window by local buffer (helper + use
> > > everywhere in TX path)
> > > 
> > > Cap the effective advertised window to min(peer_buf_alloc, buf_alloc)
> > > and use it consistently in TX paths (get_credit, has_space,
> > > seqpacket_enqueue).
> > > 
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c
> > > b/net/vmw_vsock/virtio_transport_common.c
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -491,6 +491,16 @@ void virtio_transport_consume_skb_sent(struct
> > > sk_buff *skb, bool consume)
> > > }
> > > EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
> > > +/* Return the effective peer buffer size for TX credit computation.
> > > + *
> > > + * The peer advertises its receive buffer via peer_buf_alloc, but
> > > we cap it
> > > + * to our local buf_alloc (derived from SO_VM_SOCKETS_BUFFER_SIZE and
> > > + * already clamped to buffer_max_size).
> > > + */
> > > +static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
> > > +{
> > > + return min(vvs->peer_buf_alloc, vvs->buf_alloc);
> > > +}
> > > 
> > > u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32
> > > credit)
> > > {
> > >  s64 bytes;
> > > @@ -502,7 +512,8 @@ u32 virtio_transport_get_credit(struct
> > > virtio_vsock_sock *vvs, u32 credit)
> > >  return 0;
> > > 
> > >  spin_lock_bh(&vvs->tx_lock);
> > > - bytes = (s64)vvs->peer_buf_alloc -
> > > + bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
> > >  ((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
> > >  if (bytes < 0)
> > >  bytes = 0;
> > > @@ -834,7 +845,7 @@ virtio_transport_seqpacket_enqueue(struct
> > > vsock_sock *vsk,
> > >  spin_lock_bh(&vvs->tx_lock);
> > > 
> > > - if (len > vvs->peer_buf_alloc) {
> > > + if (len > virtio_transport_tx_buf_alloc(vvs)) {
> > >  spin_unlock_bh(&vvs->tx_lock);
> > >  return -EMSGSIZE;
> > >  }
> > > @@ -884,7 +895,8 @@ static s64 virtio_transport_has_space(struct
> > > vsock_sock *vsk)
> > >  struct virtio_vsock_sock *vvs = vsk->trans;
> > >  s64 bytes;
> > > 
> > > - bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
> > > + bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
> > > + ((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
> > >  if (bytes < 0)
> > >  bytes = 0;
> > > 
> > >  return bytes;
> > > }
> > > 
> > > 
> > > ---
> > > 
> > > Patch 3/4 — vsock/test: fix seqpacket msg bounds test (set client
> > > buf too)
> > 
> > Please just include in the series the patch I sent to you.
> > 
> Thanks. I'll use your vsock_test.c patch as-is for 3/4
> > > 
> > > After fixing TX credit bounds, the client can fill its TX window and
> > > block before it wakes the server. Setting the buffer on the client
> > > makes the test deterministic again.
> > > 
> > > diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/
> > > vsock_test.c
> > > --- a/tools/testing/vsock/vsock_test.c
> > > +++ b/tools/testing/vsock/vsock_test.c
> > > @@ -353,6 +353,7 @@ static void test_stream_msg_peek_server(const
> > > struct test_opts *opts)
> > > 
> > > static void test_seqpacket_msg_bounds_client(const struct test_opts
> > > *opts)
> > > {
> > > + unsigned long long sock_buf_size;
> > >  unsigned long curr_hash;
> > >  size_t max_msg_size;
> > >  int page_size;
> > > @@ -366,6 +367,18 @@ static void
> > > test_seqpacket_msg_bounds_client(const struct test_opts *opts)
> > >  exit(EXIT_FAILURE);
> > >  }
> > > 
> > > + sock_buf_size = SOCK_BUF_SIZE;
> > > +
> > > + setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
> > > +    sock_buf_size,
> > > +    "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
> > > +
> > > + setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
> > > +    sock_buf_size,
> > > +    "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
> > > +
> > >  /* Wait, until receiver sets buffer size. */
> > >  control_expectln("SRVREADY");
> > > 
> > > 
> > > ---
> > > 
> > > Patch 4/4 — vsock/test: add stream TX credit bounds regression test
> > > 
> > > This directly guards the original failure mode for stream sockets: if
> > > the peer advertises a large window but the sender’s local policy is
> > > small, the sender must stall quickly (hit EAGAIN in nonblocking mode)
> > > rather than queueing megabytes.
> > 
> > Yeah, using nonblocking mode LGTM!
> > 
> > > 
> > > diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/
> > > vsock_test.c
> > > --- a/tools/testing/vsock/vsock_test.c
> > > +++ b/tools/testing/vsock/vsock_test.c
> > > @@ -349,6 +349,7 @@
> > > #define SOCK_BUF_SIZE (2 * 1024 * 1024)
> > > +#define SMALL_SOCK_BUF_SIZE (64 * 1024ULL)
> > > #define MAX_MSG_PAGES 4
> > > 
> > > /* Insert new test functions after test_stream_msg_peek_server, before
> > >  * test_seqpacket_msg_bounds_client (around line 352) */
> > > 
> > > +static void test_stream_tx_credit_bounds_client(const struct
> > > test_opts *opts)
> > > +{
> > > + ... /* full function as provided */
> > > +}
> > > +
> > > +static void test_stream_tx_credit_bounds_server(const struct
> > > test_opts *opts)
> > > +{
> > > + ... /* full function as provided */
> > > +}
> > > 
> > > @@ -2224,6 +2305,10 @@
> > >  .run_client = test_stream_msg_peek_client,
> > >  .run_server = test_stream_msg_peek_server,
> > >  },
> > > + {
> > > + .name = "SOCK_STREAM TX credit bounds",
> > > + .run_client = test_stream_tx_credit_bounds_client,
> > > + .run_server = test_stream_tx_credit_bounds_server,
> > > + },
> > 
> > Please put it at the bottom. Tests are skipped by index, so we don't
> > want to change index of old tests.
> > 
> > Please fix your editor, those diffs are hard to read without tabs/spaces.
> seems like some issue with my email client. Hope it is okay now
> > 
> > Thanks,
> > Stefano
> > 


