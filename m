Return-Path: <netdev+bounces-160849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C2DA1BD48
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 21:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CB33A34B9
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 20:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F8C2253E1;
	Fri, 24 Jan 2025 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="fJ77H04s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F63A224B18
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737749975; cv=none; b=qoDWEnglRfzcGjFFig+2YVYGdSCgtzTUT5xeNAtJRLk88eFVZmAWS/8gPq6CE3WqIdaoa2ufwA0BCnZ7VFjt7CG6EZjjiamHzeXNAzNP+UOAZoKN8xRBpCU4GmSYPvRCeG0bSsLNtD0OLxaaxKZMeeSnGfoizYFFeGV/bJ+5QAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737749975; c=relaxed/simple;
	bh=Mct/s8icCxgISw7/YyvdW0tKtb93dWIuER94Ecuz9fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PD6+6+gmI1j6NdiDu1VZZ7wXln/mPhBzi8txDC4Xuowy33G7AuHkyEWrTjgoiyilyI54INuwM7Ajjh55HSJOg6jqIOgv/9mHkdJ7217PQOMsDDDL9aj6Fj9owupg8Z+Xh1rX/8wMx/qL32xOWjwpPux3cJDpx2RRV79n+hxTKx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=fJ77H04s; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2167141dfa1so46961115ad.1
        for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 12:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737749973; x=1738354773; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ixB98NmCHGnppTZhm0g8E8pIn7GO1Kr2T45neZxhNN4=;
        b=fJ77H04s4NXigN7rJvooQI4i9A6U4pBsiImLukbQtXIAfk+d6g7+GzviSrgUS0Lshd
         gEzTa/vCSLQwKxmy4cooKNVRgknR4k/96te91aZ9FJGox+BXsNv0Y+Cycfg8e9niiG5W
         VEqd1Fzg+c1SjsdzkHsDi8InVX3mqmBhaNlCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737749973; x=1738354773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixB98NmCHGnppTZhm0g8E8pIn7GO1Kr2T45neZxhNN4=;
        b=PHbnND/X0AN9hKRKJxmVCn0lS8v0wUsdAvr/6TC1csqWOxVnJ6eKAPmOu0QGNGY4c0
         zBBsid4cNS5Odwmrockm7LJZwfXTaNEIaE57TOkc1hBNQ45gRBFKyUwngmAPKyH85lC8
         DuDptqilXyuB6/U++wkHu8XsgG3FgPH5g5FdPLflf+sMHDYoGBEpDLQy7UMdruJ38ykc
         eywSeY3g9X69DaLieu9c4HMOUwiomSpcbz/L+nwuVFTTWM8fRXP47pf336i6KYyHrM+q
         74KJVVS9OIH/3cRJvjDLhBVoDXkfZ9IsuJkZoyMGsxgSx+HbqFIYGf+GDhBfsdnrIZ1S
         QU3A==
X-Gm-Message-State: AOJu0YzGhKJSXN6VPFcV2yXdnvzfHg828RPwtyj6KJHkJqUrE1e8EEmy
	j/stujJ51nhXvzyWJ02AraZ9ns2OWf1eDgJ2KUjEJrz0s3q2+6qSmgfYqWVVMXs=
X-Gm-Gg: ASbGncvXDTbgEL0FZ4sam3ibJJ0n3N9dyjEUwoFGJj6fGz5WG9QwYIKw6JiT3YCIKXE
	kOfOXGQZJGbGv61OY7A9WiM+USpSO2EcBZ4S9gqzumgahqW5QYF+D1tXOk1o11Bn3M0Xf0u/ZpV
	q5KPzXUdH+bxBp+tNtyblflYqldwzl69lmsDVz49igicbFBLKxQgZtPCSjCTr0G+O7X1NItkJ/b
	ixinrTfaTtuhzTQxky1bxGDF1YFGz4h1Pud39juuZi0U+3yc91/14zcWBte8Ko3Pt/2qErwBpTw
	0l9TxapnxhfESIwNrOg=
X-Google-Smtp-Source: AGHT+IEBBQUc9yHPlJE7U8Le9EEy/Ys7qdfN3dt6zEwH5EOWHAFcdEMVQEDbDI0xb6cM5LEEwx21fg==
X-Received: by 2002:a17:902:f541:b0:216:5db1:5dc1 with SMTP id d9443c01a7336-21d993172e2mr138168385ad.1.1737749973160;
        Fri, 24 Jan 2025 12:19:33 -0800 (PST)
Received: from LQ3V64L9R2 ([165.225.242.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141175sm20477535ad.117.2025.01.24.12.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 12:19:32 -0800 (PST)
Date: Fri, 24 Jan 2025 12:19:29 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, gerhard@engleder-embedded.com,
	leiyang@redhat.com, xuanzhuo@linux.alibaba.com,
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v3 2/4] virtio_net: Prepare for NAPI to queue
 mapping
Message-ID: <Z5P10c-gbVmXZne2@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	gerhard@engleder-embedded.com, leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com, mkarsten@uwaterloo.ca,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250121191047.269844-1-jdamato@fastly.com>
 <20250121191047.269844-3-jdamato@fastly.com>
 <CACGkMEvT=J4XrkGtPeiE+8fwLsMP_B-xebnocJV8c5_qQtCOTA@mail.gmail.com>
 <Z5EtqRrc_FAHbODM@LQ3V64L9R2>
 <CACGkMEu6XHx-1ST9GNYs8UnAZpSJhvkSYqa+AE8FKiwKO1=zXQ@mail.gmail.com>
 <Z5Gtve0NoZwPNP4A@LQ3V64L9R2>
 <CACGkMEvHVxZcp2efz5EEW96szHBeU0yAfkLy7qSQnVZmxm4GLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvHVxZcp2efz5EEW96szHBeU0yAfkLy7qSQnVZmxm4GLQ@mail.gmail.com>

On Fri, Jan 24, 2025 at 09:14:54AM +0800, Jason Wang wrote:
> On Thu, Jan 23, 2025 at 10:47 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Thu, Jan 23, 2025 at 10:40:43AM +0800, Jason Wang wrote:
> > > On Thu, Jan 23, 2025 at 1:41 AM Joe Damato <jdamato@fastly.com> wrote:
> > > >
> > > > On Wed, Jan 22, 2025 at 02:12:46PM +0800, Jason Wang wrote:
> > > > > On Wed, Jan 22, 2025 at 3:11 AM Joe Damato <jdamato@fastly.com> wrote:
> > > > > >
> > > > > > Slight refactor to prepare the code for NAPI to queue mapping. No
> > > > > > functional changes.
> > > > > >
> > > > > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > > > > Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> > > > > > Tested-by: Lei Yang <leiyang@redhat.com>
> > > > > > ---
> > > > > >  v2:
> > > > > >    - Previously patch 1 in the v1.
> > > > > >    - Added Reviewed-by and Tested-by tags to commit message. No
> > > > > >      functional changes.
> > > > > >
> > > > > >  drivers/net/virtio_net.c | 10 ++++++++--
> > > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index 7646ddd9bef7..cff18c66b54a 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -2789,7 +2789,8 @@ static void skb_recv_done(struct virtqueue *rvq)
> > > > > >         virtqueue_napi_schedule(&rq->napi, rvq);
> > > > > >  }
> > > > > >
> > > > > > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> > > > > > +static void virtnet_napi_do_enable(struct virtqueue *vq,
> > > > > > +                                  struct napi_struct *napi)
> > > > > >  {
> > > > > >         napi_enable(napi);
> > > > >
> > > > > Nit: it might be better to not have this helper to avoid a misuse of
> > > > > this function directly.
> > > >
> > > > Sorry, I'm probably missing something here.
> > > >
> > > > Both virtnet_napi_enable and virtnet_napi_tx_enable need the logic
> > > > in virtnet_napi_do_enable.
> > > >
> > > > Are you suggesting that I remove virtnet_napi_do_enable and repeat
> > > > the block of code in there twice (in virtnet_napi_enable and
> > > > virtnet_napi_tx_enable)?
> > >
> > > I think I miss something here, it looks like virtnet_napi_tx_enable()
> > > calls virtnet_napi_do_enable() directly.
> > >
> > > I would like to know why we don't call netif_queue_set_napi() for TX NAPI here?
> >
> > Please see both the cover letter and the commit message of the next
> > commit which addresses this question.
> >
> > TX-only NAPIs do not have NAPI IDs so there is nothing to map.
> 
> Interesting, but I have more questions
> 
> 1) why need a driver to know the NAPI implementation like this?

I'm not sure I understand the question, but I'll try to give an
answer and please let me know if you have another question.

Mapping the NAPI IDs to queue IDs is useful for applications that
use epoll based busy polling (which relies on the NAPI ID, see also
SO_INCOMING_NAPI_ID and [1]), IRQ suspension [2], and generally
per-NAPI configuration [3].

Without this code added to the driver, the user application can get
the NAPI ID of an incoming connection, but has no way to know which
queue (or NIC) that NAPI ID is associated with or to set per-NAPI
configuration settings.

[1]: https://lore.kernel.org/all/20240213061652.6342-1-jdamato@fastly.com/
[2]: https://lore.kernel.org/netdev/20241109050245.191288-5-jdamato@fastly.com/T/
[3]: https://lore.kernel.org/lkml/20241011184527.16393-1-jdamato@fastly.com/

> 2) does NAPI know (or why it needs to know) whether or not it's a TX
> or not? I only see the following code in napi_hash_add():

Note that I did not write the original implementation of NAPI IDs or
epoll-based busy poll, so I can only comment on what I know :)

I don't know why TX-only NAPIs do not have NAPI IDs. My guess is
that in the original implementation, the code was designed only for
RX busy polling, so TX-only NAPIs were not assigned NAPI IDs.

Perhaps in the future, TX-only NAPIs will be assigned NAPI IDs, but
currently they do not have NAPI IDs.

> static void napi_hash_add(struct napi_struct *napi)
> {
>         unsigned long flags;
> 
>         if (test_bit(NAPI_STATE_NO_BUSY_POLL, &napi->state))
>                 return;
> 
> ...
> 
>         __napi_hash_add_with_id(napi, napi_gen_id);
> 
>         spin_unlock_irqrestore(&napi_hash_lock, flags);
> }
> 
> It seems it only matters with NAPI_STATE_NO_BUSY_POLL.
> 
> And if NAPI knows everything, should it be better to just do the
> linking in napi_enable/disable() instead of letting each driver do it
> by itself?

It would be nice if this were possible, I agree. Perhaps in the
future some work could be done to make this possible.

I believe that this is not currently possible because the NAPI does
not know which queue ID it is associated with. That mapping of which
queue is associated with which NAPI is established in patch 3
(please see the commit message of patch 3 to see an example of the
output).

The driver knows both the queue ID and the NAPI for that queue, so
the mapping can be established only by the driver.

Let me know if that helps.

- Joe

