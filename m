Return-Path: <netdev+bounces-179544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF5CA7D93A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B365B188AE80
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 09:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C29E230BE5;
	Mon,  7 Apr 2025 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfwkR1Cr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046123098D
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017309; cv=none; b=VIdlelm9GdZOSCb3rwhqmuRvj8FIHtTV5isqGpPBoG4rw6oyIgwj/92Ibu6OqR5ppN4LIYEj3vga5dSp0xXjw9ojB7M11sg2STYeeZQL7shls+Z6x9UQTdbb37DQ+Gy1oaTAucQWRHr97oLJTvGMD0iNOPgEegOdy62HZ9lnKr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017309; c=relaxed/simple;
	bh=rtv3uKl9VXHeF0/KLPL+wj6KGBUj48JJzaaj2N5fSzQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YaJcG1rUlLM8Dn2t9TeoTOphsxdFF8Zvj+xtLqxe4VdTt7i6UgL8HHZaHspsXJzy8LIlG+Z/ioU0TJbcOFoW7/rkT14SFt6/z1uZDP6zwo7YWdt1wH5qocy+VuqMUsqTPm5CasTg6iO3v3HqaWHsGNiokF9PE3agoWagkD88IT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfwkR1Cr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744017306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGi2ao5xTS6q7xxogEZT7ErGY12oS2SGlQvSkjIpc0I=;
	b=QfwkR1CrTfodta3YChKW0JARZOV1D2baAYf0ejTolEPYOQGz39QmhMX3WUcvQ5j7zT+UG7
	CdYqIhre8dKhgeMfaz6LNCIiitNkOjUBqIosexH0nnP1pvWOTBH7CbldMO6O425HMHwUku
	awQ8mm2NflEPeLOpNmrvgQZ9YIWbQcQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677--9jVzyjnPJyeKmRIvSoweA-1; Mon, 07 Apr 2025 05:15:03 -0400
X-MC-Unique: -9jVzyjnPJyeKmRIvSoweA-1
X-Mimecast-MFC-AGG-ID: -9jVzyjnPJyeKmRIvSoweA_1744017302
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac737973c9bso316624966b.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 02:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744017302; x=1744622102;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGi2ao5xTS6q7xxogEZT7ErGY12oS2SGlQvSkjIpc0I=;
        b=ahC4dJ9XWAWVU+YoEdfqLLls8YLj6oBUYWpmPKCVYd9+tSZFVAxqO8oYWHGyd+cI1/
         sWeu/goE3IUNm3H5bDBTVu/odAC/Wo2tHLAiX0iyYVlzKvqdu5x7Oeq3t4HBved+aehG
         SNNut9WteSBL+4qHTHnHZtJGpHHH9BFEGtcAzlpLDkDPIdz7/LvyU/S86RKOMaHuzA2Z
         RaiAyJpwUK+MLq66dPQXOxMtZ57cpVrF8T2ECKXw7TdTGiaW5HMLT9+HscCqGAWnlsP5
         RyZVUWztst9g9cdiKM/vB2T78kxiv/iyNquHsP1e7FMtcI+uinOBWBPo5CmzKSCFPysI
         R0Yg==
X-Forwarded-Encrypted: i=1; AJvYcCW2+hrF063VhF7iXFa/raihVNyMhdtMQte1CE2aFdiE0RY8ujQTDXDI6fWZzIH+udTHjNgwHV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDPc8c84XwoSQNtQSlO8y2RNCZ4J40JhAksaeVju5EJYQWpOsU
	MqzAPMgcNQikQlJ+SL86aVR2t98AgIfW0+rHri86I0BzFoOzAT+fdXSGHHZ/q+/8z1HS/TV4jUh
	5dJxe0ysaMHdkVUBti0cFJ+6dWS8XGWrukeyF0KINqUM1U/bM4A+YlQ==
X-Gm-Gg: ASbGncvxA3CZOSSmtuYPSb3f1PHnHKFoisGBvBkjhS/aOH5y4IckSG6nkQDVdR9mRwi
	9zVvJQFP8j8VrhlxgPYYVBfoXfXaty4J0RI8AoLyzTiGHfbVMtksddNn2JmteEBXDtYJN+Wlb2Q
	4BFRD7nEbS1keB6TWfMCvY42Wu3hgXxt3T76T5ZxR6dDx0ksNSCO7c9+nIV5IB+xugSv6RwJ06x
	4sVcNoI8GxOpqj5GiRIiPrwObGvPZQ91bPJv+6bBTS7BrqU7mUGaqRTTcnht3nzsDO21gbBvJHm
	aUkmK3nEW2MtaxDYwSI8l8j7JN1ePXuGCmWcVuDu
X-Received: by 2002:a17:907:948c:b0:abf:7636:3cab with SMTP id a640c23a62f3a-ac7d17d874dmr978657066b.29.1744017302197;
        Mon, 07 Apr 2025 02:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2TSfWBoxbxnNZnNOPTgh1JM4sNEzsnpKewmkg6V6GZg94v/B6Ci2rqDrTGx7DOnxrfL+nGw==
X-Received: by 2002:a17:907:948c:b0:abf:7636:3cab with SMTP id a640c23a62f3a-ac7d17d874dmr978655366b.29.1744017301660;
        Mon, 07 Apr 2025 02:15:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe9adc6sm718530366b.59.2025.04.07.02.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 02:15:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 45B261991862; Mon, 07 Apr 2025 11:15:00 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 tom@herbertland.com, Eric Dumazet <eric.dumazet@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@cloudflare.com
Subject: Re: [RFC PATCH net-next] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
In-Reply-To: <174377814192.3376479.16481605648460889310.stgit@firesoul>
References: <174377814192.3376479.16481605648460889310.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 07 Apr 2025 11:15:00 +0200
Message-ID: <87a58sxrhn.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> In production, we're seeing TX drops on veth devices when the ptr_ring
> fills up. This can occur when NAPI mode is enabled, though it's
> relatively rare. However, with threaded NAPI - which we use in
> production - the drops become significantly more frequent.
>
> The underlying issue is that with threaded NAPI, the consumer often runs
> on a different CPU than the producer. This increases the likelihood of
> the ring filling up before the consumer gets scheduled, especially under
> load, leading to drops in veth_xmit() (ndo_start_xmit()).
>
> This patch introduces backpressure by returning NETDEV_TX_BUSY when the
> ring is full, signaling the qdisc layer to requeue the packet. The txq
> (netdev queue) is stopped in this condition and restarted once
> veth_poll() drains entries from the ring, ensuring coordination between
> NAPI and qdisc.

Right, I definitely agree that this is the right solution; having no
backpressure and a fixed-size ringbuffer is obviously not ideal.

> Backpressure is only enabled when a qdisc is attached. Without a qdisc,
> the driver retains its original behavior - dropping packets immediately
> when the ring is full. This avoids unexpected behavior changes in setups
> without a configured qdisc.

Not sure I like this bit, though; see below.

> With a qdisc in place (e.g. fq, sfq) this allows Active Queue Management
> (AQM) to fairly schedule packets across flows and reduce collateral
> damage from elephant flows.
>
> A known limitation of this approach is that the full ring sits in front
> of the qdisc layer, effectively forming a FIFO buffer that introduces
> base latency. While AQM still improves fairness and mitigates flow
> dominance, the latency impact is measurable.
>
> In hardware drivers, this issue is typically addressed using BQL (Byte
> Queue Limits), which tracks in-flight bytes needed based on physical link
> rate. However, for virtual drivers like veth, there is no fixed bandwidth
> constraint - the bottleneck is CPU availability and the scheduler's ability
> to run the NAPI thread. It is unclear how effective BQL would be in this
> context.

So the BQL algorithm tries to tune the maximum number of outstanding
bytes to be ~twice the maximum that can be completed in one batch. Since
we're not really limited by bytes in the same sense here (as you point
out), an approximate equivalent would be the NAPI budget, I guess? I.e.,
as a first approximation, we could have veth stop the queue once the
ringbuffer has 2x the NAPI budget packets in it?

> This patch serves as a first step toward addressing TX drops. Future work
> may explore adapting a BQL-like mechanism to better suit virtual devices
> like veth.
>
> Reported-by: Yan Zhai <yan@cloudflare.com>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

[...]

> +/* Does specific txq have a real qdisc attached? - see noqueue_init() */
> +static inline bool txq_has_qdisc(struct netdev_queue *txq)
> +{
> +	struct Qdisc *q;
> +
> +	q = rcu_dereference(txq->qdisc);
> +	if (q->enqueue)
> +		return true;
> +	else
> +		return false;
> +}

This seems like a pretty ugly layering violation, inspecting the qdisc
like this in the driver?

AFAICT, __dev_queue_xmit() turns a stopped queue into drops anyway, but
emits a warning (looks like this, around line 4640 in dev.c):

			net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
					     dev->name);

As this patch shows, it can clearly be appropriate for a virtual device
to stop the queue even if there's no qdisc, so how about we just get rid
of that warning? Then this logic won't be needed at all in the driver..

-Toke


