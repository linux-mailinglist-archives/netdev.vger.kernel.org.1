Return-Path: <netdev+bounces-239870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57541C6D547
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B992D3A00D6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BEE32ABCF;
	Wed, 19 Nov 2025 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+AatFsl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qI76pcys"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3E531B133
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763539131; cv=none; b=Ert6dqW03dTPz3cRuZLHDDQWkLp/jx8JJlwokj+mnOtim2xJGovxp4RJRgeCFcz/tgvCvOS8b3qKAdmMIdBR42aQg8K217KSkgUf9qFeNQZ2GKbttlz0ELYFcrpkPCE10BLnQ5Q5y1fgclZJjJXNZ/tay5/Ii/dhmx7shHdKPZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763539131; c=relaxed/simple;
	bh=ztPb0Oi9ktxAOJLg1T9PzO/fl6i4U/jNw5A/87EltNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7exypBnhmGH64ySDyY3abPDV5LV55Lb8NUKWfimQmfpa/i7BsLxt4TZUpCxAwGmPP0GnAEzzOHtwcrQVzzr5j0gHk4/l1BMjsuH5Xbko02sS+ToJdxUb+RWUQrWH1U+KIDHNMuLei18pVoKXdZlsifPY4aTcwl349D4iKiLZw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+AatFsl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qI76pcys; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763539126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1kdukhMv0e5PS6jWRdXt6KYB0O1bYUGO99kB+sjRgQ=;
	b=T+AatFslTlib88SmRl9MpbV+XLPIMbdfeh4ONUfKzXby9e+T40Sxtp9p5JYBufOnsgR0Jf
	oJmnTl+DiGkQji+AF2V3mmqZs1ZHV9C2zBF6qHAUU7sUNfu/kYLZTN62Yhr9b3C4Psz452
	lKVx2b4zFh86n/D7D9zSbgXPHJb7PUw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-oOXXArj_OeqyckhkJZTboQ-1; Wed, 19 Nov 2025 02:58:44 -0500
X-MC-Unique: oOXXArj_OeqyckhkJZTboQ-1
X-Mimecast-MFC-AGG-ID: oOXXArj_OeqyckhkJZTboQ_1763539123
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429cbd8299cso2958458f8f.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763539123; x=1764143923; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h1kdukhMv0e5PS6jWRdXt6KYB0O1bYUGO99kB+sjRgQ=;
        b=qI76pcysZic5E21w8D+rsBZdukfMfleNARdiaqrV7bXJeASL/5AZxngwBgC/e66nji
         JeApmZ+jz2XB9/9gvyx0oD7S40LyN3Z4dN2B2HgB99MB279FtfYZ5AC3iUq3RN3BIUeO
         0aDHeU7Pep7NeSuFldlb/owhuy2kRFXt0C/iUXenZl5Yz3lFmlGPYg5QHPCDOQDzIkyR
         CuKrnOzBBUlvbS6hY1okFTrBbEuttTXtisV82bCwJAS3yBRjYsAq6SrEP9pbVE2wqwHz
         FWw+jskkHGKEyHLmdOC0i3CrWFfTAP+hwE8b8c/B6n3lEpbx3yDcnBa337amA7I/GW/B
         t2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763539123; x=1764143923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1kdukhMv0e5PS6jWRdXt6KYB0O1bYUGO99kB+sjRgQ=;
        b=Rs+sQ4eygO16rArcq8TyCwORDPXTVDFmGClSnE0WpxO7YLHFGc2daXrPYNj3HCZHrN
         jHPyTMyztDwKHbT7wwgZNxgg6D+OUHxcqC6L4rYPUGL944qN03riJXBy59BjmQhcyzFk
         O4+DYJ0m1DTMvubks9/uTazaawuqd118Uwa/BBn8FWx88Sb1itiqT2ro2yKPLAXAwJ2h
         PwrJMxLn/bA27WxrdF6IKH/7Gif1egpQeskI5sRFAVjUsxwTugUhNOBHgV6lzjNR00B6
         W/yZK8C8AL6dXcPq0x8GjxQvv6qHKoKrodBuYSudp00lBhqthbaxN1aD60N7cJJtvrYO
         EvtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeiul4xsNvCbmftU3pWkfRlL9JCnPsd8AZjrVZ0w2I9tGRlXS6sFyIvEMUCrQdNOtcVHzF7No=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy85q+KF1m5AzgnHtGt/NGFT5s4WoU/IqJKJ5zwqmoomukkqw4g
	QJg6jV0CUa9wcVKV1nwSir4A3IP26YzqcknfbWOvob0aTZACz98xPWEIWOUzElJugmvhJsdDb06
	sAHUjY8XUBo58YR4QrO4RrXUuSKdr/sfqKThenLVMMYdfIONgZFvB3hTFng==
X-Gm-Gg: ASbGncurMLFE5andUCtDDngWA1aQy0sQmEuuwcF4jEIhRoFf1DPt3YBvwcYc87Pzh9v
	/yqUcrwSgvjGQWn7tCw1NqjyTKmlQwUy/mZU/xD0Lu7Fr+l0ubk9Gm+12m7GmCjKZi7JqDIbIri
	2vIkzqBTlp1M87FnThIzRooSMJWSTi7fe83zwGOyUFQ5ZyAIZBdSFJAnP8IWa4YfWONmusimxQI
	ktGkgA4w7weJXJfHsauFuU3q42pmzqtVczM92PpLq/qUMXsbGnjV0H5wyryzc9rOozEmg1oUEUm
	sHAhuXJpPIccG6HBx7S+EcfEQao8LkCDFJFGH4kKR/THDILQ1AKf/p/Jm9vjEDxjpeBPfp2sWmf
	styDWW+uYCs57jZsg2joXxnOZs8Hl6g==
X-Received: by 2002:a5d:5d01:0:b0:42b:4177:7131 with SMTP id ffacd0b85a97d-42b595add99mr19386655f8f.44.1763539123178;
        Tue, 18 Nov 2025 23:58:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/d9kIia5C1Rk173uB/q7uMGiJORCrpd/szircj7eTupOsjnjxbBmEFPJg4z/3AWkkns9YXA==
X-Received: by 2002:a5d:5d01:0:b0:42b:4177:7131 with SMTP id ffacd0b85a97d-42b595add99mr19386634f8f.44.1763539122739;
        Tue, 18 Nov 2025 23:58:42 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f174afsm35614093f8f.33.2025.11.18.23.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:58:42 -0800 (PST)
Date: Wed, 19 Nov 2025 02:58:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liming Wu <liming.wu@jaguarmicro.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH] virtio_net: enhance wake/stop tx queue statistics
 accounting
Message-ID: <20251119025546-mutt-send-email-mst@kernel.org>
References: <20251118090942.1369-1-liming.wu@jaguarmicro.com>
 <CACGkMEvwedzRrMd9hYm7PbDezBu1GM3q-YcUhsvfYJVv=bNSdw@mail.gmail.com>
 <PSAPR06MB39429783A41F42FDD82477A2E1D7A@PSAPR06MB3942.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PSAPR06MB39429783A41F42FDD82477A2E1D7A@PSAPR06MB3942.apcprd06.prod.outlook.com>

On Wed, Nov 19, 2025 at 07:54:07AM +0000, Liming Wu wrote:
> > queue wake/stop events introduced by a previous patch.
> > 
> > It would be better to add commit id here.
> OK, thx.
> 
> > 
> eck. */
> > >                         free_old_xmit(sq, txq, false);
> > >                         if (sq->vq->num_free >= MAX_SKB_FRAGS + 2) {
> > > -                               netif_start_subqueue(dev, qnum);
> > > -
> > u64_stats_update_begin(&sq->stats.syncp);
> > > -                               u64_stats_inc(&sq->stats.wake);
> > > -
> > u64_stats_update_end(&sq->stats.syncp);
> > > +                               virtnet_tx_wake_queue(vi, sq);
> > 
> > This is suspicious, netif_tx_wake_queue() will schedule qdisc, or is this intended?
> Thanks for pointing this out.
> You're right — using netif_tx_wake_queue() here would indeed trigger qdisc scheduling, which is not intended in this specific path.
> My change tried to unify the wake/stop accounting paths, but replacing netif_start_subqueue() was not the right choice semantically.
> 
> I will restore netif_start_subqueue() at this site and keep only the statistic increment, so the behavior stays consistent with the original code while still improving the per-queue metrics.


Please do not send fluff comments like this to the list.

And with em-dashes too, for added flair.

If you can not bother writing email yourself why should
anyone bother reading it?




> > 
> > >                                 virtqueue_disable_cb(sq->vq);
> > >                         }
> > >                 }
> > > @@ -3068,13 +3080,8 @@ static void virtnet_poll_cleantx(struct
> > receive_queue *rq, int budget)
> > >                         free_old_xmit(sq, txq, !!budget);
> > >                 } while
> > > (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > >
> > > -               if (sq->vq->num_free >= MAX_SKB_FRAGS + 2 &&
> > > -                   netif_tx_queue_stopped(txq)) {
> > > -                       u64_stats_update_begin(&sq->stats.syncp);
> > > -                       u64_stats_inc(&sq->stats.wake);
> > > -                       u64_stats_update_end(&sq->stats.syncp);
> > > -                       netif_tx_wake_queue(txq);
> > > -               }
> > > +               if (sq->vq->num_free >= MAX_SKB_FRAGS + 2)
> > > +                       virtnet_tx_wake_queue(vi, sq);
> > >
> > >                 __netif_tx_unlock(txq);
> > >         }
> > > @@ -3264,13 +3271,8 @@ static int virtnet_poll_tx(struct napi_struct *napi,
> > int budget)
> > >         else
> > >                 free_old_xmit(sq, txq, !!budget);
> > >
> > > -       if (sq->vq->num_free >= MAX_SKB_FRAGS + 2 &&
> > > -           netif_tx_queue_stopped(txq)) {
> > > -               u64_stats_update_begin(&sq->stats.syncp);
> > > -               u64_stats_inc(&sq->stats.wake);
> > > -               u64_stats_update_end(&sq->stats.syncp);
> > > -               netif_tx_wake_queue(txq);
> > > -       }
> > > +       if (sq->vq->num_free >= MAX_SKB_FRAGS + 2)
> > > +               virtnet_tx_wake_queue(vi, sq);
> > >
> > >         if (xsk_done >= budget) {
> > >                 __netif_tx_unlock(txq); @@ -3521,6 +3523,9 @@ static
> > > void virtnet_tx_pause(struct virtnet_info *vi, struct send_queue *sq)
> > >
> > >         /* Prevent the upper layer from trying to send packets. */
> > >         netif_stop_subqueue(vi->dev, qindex);
> > > +       u64_stats_update_begin(&sq->stats.syncp);
> > > +       u64_stats_inc(&sq->stats.stop);
> > > +       u64_stats_update_end(&sq->stats.syncp);
> > >
> > >         __netif_tx_unlock_bh(txq);
> > >  }
> > > @@ -3537,7 +3542,7 @@ static void virtnet_tx_resume(struct
> > > virtnet_info *vi, struct send_queue *sq)
> > >
> > >         __netif_tx_lock_bh(txq);
> > >         sq->reset = false;
> > > -       netif_tx_wake_queue(txq);
> > > +       virtnet_tx_wake_queue(vi, sq);
> > >         __netif_tx_unlock_bh(txq);
> > >
> > >         if (running)
> > > --
> > > 2.34.1
> > >
> > 
> > Thanks
> 


