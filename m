Return-Path: <netdev+bounces-223442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6495B5926F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C313BC73B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9120229B783;
	Tue, 16 Sep 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="baePdZDL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20A29A310
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015564; cv=none; b=CIBPT3UBiA3hEnbRD8WLzjYBbiHENiAw+y52J4icnlUN93g4o3UBLHVEzua0Gt+Jq2GKs0ddzW/fHpGuNm64f37FJsaLULEcbKevEkPEYda2E94SrdhgbRkcr6Oph01d5d2LqZhrhnz0B4fQ+AC1wJplFC2ktnlqGX550WGOLVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015564; c=relaxed/simple;
	bh=6DRYBwPSDQW1jpjkTq0DHNAJkPr8od/IdlP5PW4dxXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lz2kWdHhDc+2RT+ZxZLA+ESVOBxaXoVh+AMID1DT7YXoGJanVKxnVe3yrm4h7IbfMmyTMipEHkvWHfR61Vt8O1fOMae8Q1n35VXqsHHl31wnheutdi9Qxk5VulfQRVwcyIu/6JiJ/twmW9HmzU3McUASG0MzrwWKrNTnGgrBZsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=baePdZDL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758015560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mg7T0kQEdQ7FBfapeuxsmVNYMds4ObzbW92Zj/OuxmU=;
	b=baePdZDLqzGU4yxCTa+EUBX59xTXbewyP93kPvkKjDg2FWe6xJBh/U53W+0vXW4zwr8B54
	yUvzorX2ibCiNRsRxXqBpJKTsPdEHt99RcHMzZ/xnUnZvmgkCs6YIEhX6yKBOrP7Y84Nel
	JyiDGErWMH0HMPvKrrfgu7atXrhABwk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-sD0A-l5zOUeAUiMF9zbvUw-1; Tue, 16 Sep 2025 05:39:18 -0400
X-MC-Unique: sD0A-l5zOUeAUiMF9zbvUw-1
X-Mimecast-MFC-AGG-ID: sD0A-l5zOUeAUiMF9zbvUw_1758015557
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b0467f38c91so620245666b.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 02:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015557; x=1758620357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mg7T0kQEdQ7FBfapeuxsmVNYMds4ObzbW92Zj/OuxmU=;
        b=GTIFo3js4fBPrwOtJnel7e2rdhjM91UJkf3tjfxzCCgPy6maQwmXIxeoCxeeufQSwB
         JBlN1aW2LSvnkXpDNUbBOvTNWROGPISD0W+9yk2mHRWBMRApmV2POCh6mgQgWu57kQC7
         6XEQOlcz18aMyTaAhgLeANCccVgkcbvCrtngF05DPmKGHmfl5HdFiqKfOwCn+RUfrZCZ
         la5QrmGcTQrLF8u1ejdbDOY/tW4eiXEIH+tz9ZHCxp45xEqGYwuqIi3i+d4BuOlADiN3
         qR07e566hoMer2yYddARO3tPnVuDhKEqZE2H8KWsgpGA0Oo2HdVXCZ+H7Bd70jb+/RO3
         evgg==
X-Forwarded-Encrypted: i=1; AJvYcCUGGZZ3bawYQlFSuO6nfrNbmvBROXkzMAdNTFIe1V8j8q7WN/u5MUL+1XqRMrL4ElVbNqBlPOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjY/JqbZ4m/SO7fKIXaCmzx+PgonwmefkklknkCQCjveZ4hM4y
	ddB56Qor2wc1LY521IxSiImZn32kiQX1qKhegoqd4Y5Ezmk8s2uL2Vec4232URNIvEtDgNUoqMg
	6ftXME4CJoiV3DGDj6xAIDWYtQT1Twyh/mUT4VL1E24gTi0EHozjilp45Fw==
X-Gm-Gg: ASbGncvRCBFxlByWsXFOGObqlI6DhgpduNO2kC0/bqPDv3tHcXH7eUULuLdgXKrNgpS
	6iDmC0HxiwSaQiDdB/vINRTjY8GWswtcPFhLJLp1fl835wQruCejAqHkijfvGQKKQDgEXhHRHqX
	Sz2yEpYJW9IXwpoW/cjeWOQ5jDTsucsuvlO/rZnlXVVZ4peOClebUqUbzNXvIlLLDyzAWMcLOnR
	PuwQSA3yBxzRggBMEcVREJyTV2hqa1S7gAtmRhzjZFeIYXMWA52Rhk+Wh4EpGIYFsHDCWR2l1qe
	sQjY1DamM/BM8GAaePakHBbdTH8n
X-Received: by 2002:a17:907:7e84:b0:b04:3302:d7a8 with SMTP id a640c23a62f3a-b07c3a77ef1mr1835870766b.58.1758015556775;
        Tue, 16 Sep 2025 02:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL9xm1d3rRrWqvJve/PLiCDKmVMyNZWdCqpuRPm8Fk1iVgEX6WsHMd5ecb9Pr8TQ5Xn3WbGQ==
X-Received: by 2002:a17:907:7e84:b0:b04:3302:d7a8 with SMTP id a640c23a62f3a-b07c3a77ef1mr1835869266b.58.1758015556348;
        Tue, 16 Sep 2025 02:39:16 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b08cab32303sm687037066b.72.2025.09.16.02.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:39:15 -0700 (PDT)
Date: Tue, 16 Sep 2025 05:39:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] vhost-net: correctly flush batched packet before
 enabling notification
Message-ID: <20250916053418-mutt-send-email-mst@kernel.org>
References: <20250912082658.2262-1-jasowang@redhat.com>
 <20250912082658.2262-2-jasowang@redhat.com>
 <20250915120210-mutt-send-email-mst@kernel.org>
 <CACGkMEufUAL1tBrfZVMQCEBmBZ=Z+aPqUtP=RzOQhjtG9jn7UA@mail.gmail.com>
 <20250916011733-mutt-send-email-mst@kernel.org>
 <CACGkMEu_p-ouLbEq26vMTJmeGs1hw5JHOk1qLt8mLLPOMLDbaQ@mail.gmail.com>
 <20250916030549-mutt-send-email-mst@kernel.org>
 <CACGkMEt2fAkCb_nC4QwR+3Jq+fS8=7bx=T3AEzPP1KGLErbSBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEt2fAkCb_nC4QwR+3Jq+fS8=7bx=T3AEzPP1KGLErbSBA@mail.gmail.com>

On Tue, Sep 16, 2025 at 03:20:36PM +0800, Jason Wang wrote:
> On Tue, Sep 16, 2025 at 3:08 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Sep 16, 2025 at 02:24:22PM +0800, Jason Wang wrote:
> > > On Tue, Sep 16, 2025 at 1:19 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Sep 16, 2025 at 10:37:35AM +0800, Jason Wang wrote:
> > > > > On Tue, Sep 16, 2025 at 12:03 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Sep 12, 2025 at 04:26:58PM +0800, Jason Wang wrote:
> > > > > > > Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> > > > > > > sendmsg") tries to defer the notification enabling by moving the logic
> > > > > > > out of the loop after the vhost_tx_batch() when nothing new is
> > > > > > > spotted. This will bring side effects as the new logic would be reused
> > > > > > > for several other error conditions.
> > > > > > >
> > > > > > > One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> > > > > > > might return -EAGAIN and exit the loop and see there's still available
> > > > > > > buffers, so it will queue the tx work again until userspace feed the
> > > > > > > IOTLB entry correctly. This will slowdown the tx processing and may
> > > > > > > trigger the TX watchdog in the guest.
> > > > > > >
> > > > > > > Fixing this by stick the notificaiton enabling logic inside the loop
> > > > > > > when nothing new is spotted and flush the batched before.
> > > > > > >
> > > > > > > Reported-by: Jon Kohler <jon@nutanix.com>
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
> > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > ---
> > > > > > >  drivers/vhost/net.c | 33 +++++++++++++--------------------
> > > > > > >  1 file changed, 13 insertions(+), 20 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > > > > > index 16e39f3ab956..3611b7537932 100644
> > > > > > > --- a/drivers/vhost/net.c
> > > > > > > +++ b/drivers/vhost/net.c
> > > > > > > @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > > > > > >       int err;
> > > > > > >       int sent_pkts = 0;
> > > > > > >       bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
> > > > > > > -     bool busyloop_intr;
> > > > > > >       bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
> > > > > > >
> > > > > > >       do {
> > > > > > > -             busyloop_intr = false;
> > > > > > > +             bool busyloop_intr = false;
> > > > > > > +
> > > > > > >               if (nvq->done_idx == VHOST_NET_BATCH)
> > > > > > >                       vhost_tx_batch(net, nvq, sock, &msg);
> > > > > > >
> > > > > > > @@ -780,10 +780,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > > > > > >                       break;
> > > > > > >               /* Nothing new?  Wait for eventfd to tell us they refilled. */
> > > > > > >               if (head == vq->num) {
> > > > > > > -                     /* Kicks are disabled at this point, break loop and
> > > > > > > -                      * process any remaining batched packets. Queue will
> > > > > > > -                      * be re-enabled afterwards.
> > > > > > > +                     /* Flush batched packets before enabling
> > > > > > > +                      * virqtueue notification to reduce
> > > > > > > +                      * unnecssary virtqueue kicks.
> > > > > > >                        */
> > > > > > > +                     vhost_tx_batch(net, nvq, sock, &msg);
> > > > > >
> > > > > > So why don't we do this in the "else" branch"? If we are busy polling
> > > > > > then we are not enabling kicks, so is there a reason to flush?
> > > > >
> > > > > It should be functional equivalent:
> > > > >
> > > > > do {
> > > > >     if (head == vq->num) {
> > > > >         vhost_tx_batch();
> > > > >         if (unlikely(busyloop_intr)) {
> > > > >             vhost_poll_queue()
> > > > >         } else if () {
> > > > >             vhost_disable_notify(&net->dev, vq);
> > > > >             continue;
> > > > >         }
> > > > >         return;
> > > > > }
> > > > >
> > > > > vs
> > > > >
> > > > > do {
> > > > >     if (head == vq->num) {
> > > > >         if (unlikely(busyloop_intr)) {
> > > > >             vhost_poll_queue()
> > > > >         } else if () {
> > > > >             vhost_tx_batch();
> > > > >             vhost_disable_notify(&net->dev, vq);
> > > > >             continue;
> > > > >         }
> > > > >         break;
> > > > > }
> > > > >
> > > > > vhost_tx_batch();
> > > > > return;
> > > > >
> > > > > Thanks
> > > > >
> > > >
> > > > But this is not what the code comment says:
> > > >
> > > >                      /* Flush batched packets before enabling
> > > >                       * virqtueue notification to reduce
> > > >                       * unnecssary virtqueue kicks.
> > > >
> > > >
> > > > So I ask - of we queued more polling, why do we need
> > > > to flush batched packets? We might get more in the next
> > > > polling round, this is what polling is designed to do.
> > >
> > > The reason is there could be a rx work when busyloop_intr is true, so
> > > we need to flush.
> > >
> > > Thanks
> >
> > Then you need to update the comment to explain.
> > Want to post your version of this patchset?
> 
> I'm fine if you wish. Just want to make sure, do you prefer a patch
> for your vhost tree or net?
> 
> For net, I would stick to 2 patches as if we go for 3, the last patch
> that brings back flush looks more like an optimization.

Jason it does not matter how it looks. We do not need to sneak in
features - if the right thing is to add patch 3 in net then
it is, just add an explanation why in the cover letter.
And if it is not then it is not and squashing it with a revert
is not a good idea.

> For vhost, I can go with 3 patches, but I see that your series has been queued.
>
> And the build of the current vhost tree is broken by:
> 
> commit 41bafbdcd27bf5ce8cd866a9b68daeb28f3ef12b (HEAD)
> Author: Michael S. Tsirkin <mst@redhat.com>
> Date:   Mon Sep 15 10:47:03 2025 +0800
> 
>     vhost-net: flush batched before enabling notifications
> 
> It looks like it misses a brace.
> 
> Thanks

Ugh forgot to commit :(
I guess this is what happens when one tries to code past midnight.
Dropped now pls do proceed.

> >
> >
> > > >
> > > >
> > > > >
> > > > > >
> > > > > >
> > > > > > > +                     if (unlikely(busyloop_intr)) {
> > > > > > > +                             vhost_poll_queue(&vq->poll);
> > > > > > > +                     } else if (unlikely(vhost_enable_notify(&net->dev,
> > > > > > > +                                                             vq))) {
> > > > > > > +                             vhost_disable_notify(&net->dev, vq);
> > > > > > > +                             continue;
> > > > > > > +                     }
> > > > > > >                       break;
> > > > > > >               }
> > > > > > >
> > > > > > > @@ -839,22 +847,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > > > > > >               ++nvq->done_idx;
> > > > > > >       } while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
> > > > > > >
> > > > > > > -     /* Kicks are still disabled, dispatch any remaining batched msgs. */
> > > > > > >       vhost_tx_batch(net, nvq, sock, &msg);
> > > > > > > -
> > > > > > > -     if (unlikely(busyloop_intr))
> > > > > > > -             /* If interrupted while doing busy polling, requeue the
> > > > > > > -              * handler to be fair handle_rx as well as other tasks
> > > > > > > -              * waiting on cpu.
> > > > > > > -              */
> > > > > > > -             vhost_poll_queue(&vq->poll);
> > > > > > > -     else
> > > > > > > -             /* All of our work has been completed; however, before
> > > > > > > -              * leaving the TX handler, do one last check for work,
> > > > > > > -              * and requeue handler if necessary. If there is no work,
> > > > > > > -              * queue will be reenabled.
> > > > > > > -              */
> > > > > > > -             vhost_net_busy_poll_try_queue(net, vq);
> > > > > > >  }
> > > > > > >
> > > > > > >  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> > > > > > > --
> > > > > > > 2.34.1
> > > > > >
> > > >
> >


