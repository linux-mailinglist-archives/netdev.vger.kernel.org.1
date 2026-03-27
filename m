Return-Path: <netdev+bounces-272482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEQ5AGlUxmkkIwUAu9opvQ
	(envelope-from <netdev+bounces-272482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:56:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FFD342123
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C80B1311ACE3
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 09:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABA837C10F;
	Fri, 27 Mar 2026 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StECY9it";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nye2tSPZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08BD369999
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605042; cv=none; b=XbUvQa3VjNxYL1U4U9qnQ/HcUV5n4rVjA9453+dOL1Vgl+WomRBG2OU13HdNF3BCDGMNgMLvs7B6KeaF2RJ3jCbIJfOe+zP5siU3BN6TRSsEgSsu1QTNBk+0KVey+Fqej3ljnZfcC77DUCfHo/7dDlpl7LJMSwDiHAOCMyBpELY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605042; c=relaxed/simple;
	bh=zQK+UFbcJY00osSm1ovVGVumFIC1ZKVw5TCrOSuDcTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C5wPMrTrca45z90AzfaBdSbzSOBTGc5+PZwwa9hbvKHB5zaWlvUoyzMvIPAHAfB4miejGCT8mveh+aWd4t0cpMSOSRNxLN3aDrwQProYGQN2ePoU8w5M5DpuO1DYDWTbYuz16x1aF2KR8CoEr66EidKgMBKD6vC4/wSV/ZAMPIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StECY9it; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nye2tSPZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774605040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2gnCHCxPr//brYsrsapB3a7JnHExamc+y/iGlBeTp6Q=;
	b=StECY9it6iqLokguP+f7vWUJ3OineWtvODi0YgXzK/wTqjBZADnnfEHgxf1Z7MsyGQCC3z
	km+E1mxOea2Vnsh+hsvf0I9b70uAb/yffFnS+c4sgCg0l1rDNOz1KPr2HiMWkMFg8SVhyP
	Aw+nLlgDDJCmpprxoZV4UesdVqVjU4Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-ibaeJ3-KPEic6xODCKemrQ-1; Fri, 27 Mar 2026 05:50:38 -0400
X-MC-Unique: ibaeJ3-KPEic6xODCKemrQ-1
X-Mimecast-MFC-AGG-ID: ibaeJ3-KPEic6xODCKemrQ_1774605037
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-486f830f4e4so6218785e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 02:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774605037; x=1775209837; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2gnCHCxPr//brYsrsapB3a7JnHExamc+y/iGlBeTp6Q=;
        b=nye2tSPZjhc+ej9T3V8gkyLouX5sNMA3gS8k7VrgvTJzuhS2o252FXOM/7iPzAYyHm
         QGLcW7oicQjQtP5zm+yU0QBoFH76Det3rpIwRDp0i9m+o69ddw8yNGPLKGKaC6pywEmb
         S7mPUmo1lOJIjdoagTq+p0ReSmx71Cw0wNoTexECR0LGURi8mp1Rof3kptU0vrF12RQH
         Br2MwEBLF9pHftuMyd8yB0Uw8qWrxbxjAxqnJeAqQrGN9nXV/5wvvEdsCcbDjxXyXkJz
         gamG6nNDW6HNrfLB9Ok1SAySvpzbfuwGjdR2k2UQKwtxUcFdI5ajmQtpZxlQojQ0/x9t
         mhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774605037; x=1775209837;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2gnCHCxPr//brYsrsapB3a7JnHExamc+y/iGlBeTp6Q=;
        b=aVtjItARqqFl2UJpb87O59cjUpNhQrmGYg1+1VrpHS2Zb0iepkL7wEr6iE+ZGmnVP/
         iOlD6OjGcQj/Y8ZARiZSbKnxUdvFacXz5hWeHuVinFGKTNm+ZcEMx0yQl14TqEAlKrrU
         3zi1Qo7xyz3xGaN9VGjs9cfhDRdfLv2dxSxeat+vB76kUtavSHN8MKjLhuesY+bdUd0/
         lPsEvxPub0qWqHTvaAqD/emoGA0fcjj0dcuOBbAbR7/Qrg5gjIYffM8z5OaxdvaOnn/1
         lpQh1BYkrNvcgvVFZ2ChDWQQ0BarMg4Pv4Gems/tHHSEm7PwMkJ192SZC4b7aFE2xULb
         XQxw==
X-Forwarded-Encrypted: i=1; AJvYcCVgj0e72FyorQsjCO4HfIta5nr+RgteYuZpDBBKiGYx43KHbWsX9Uz08e7NB8oErSCb3fls8hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzifErvJ8SUfVhilWG697IO7qOZNAFrcnD/1sgXJr7ts0aXJoID
	mMsp/s4jgVr99+N52ft81vP/eY8mg6jAG/qHgC8CnpX7DFVZkpQBvWm3QV2hgdqxAHVI8j59Xc0
	hhCUwz2pO4BDlZqJtYqLeLIupM45caZxyewKruRpD16ZNmGz/3kdYv8h04Q==
X-Gm-Gg: ATEYQzwIQfSxus2fjjztDrb6rdVI+csic/+YJTDZre2UdZsf0A1bvgijX9w3Sb4JO9w
	HYaBYHcn+q/zzIgx5POpUgh+1bmqvVYkUoTBgjE76icGTvzC5E9RQ1RdRu02k40njsBss3kk4wp
	8y3tV4HD9I8kALgpVspbVPGZhrWvPLoPI25DS0DChmymefY2oOk93VUJ82QIoEMooAC8l5PL+8L
	yrJCw2DbtuuHVkGKhN6vx9uwfRAgkG3E9pGKHsAUuJQSGQPnf0QjlI3z0ub1SeD6YFDUxMoFMv8
	GE8XGqhId6ugoDH6fE+6y4erd3VFX4AAqvSLGTbNvJkFsruz66wXjl+fY+jESMQopIAYFI9awax
	sunioE2VXWNh4Td6bJ4U+K+GWpLjBFpqTz7/it037E8FVDg==
X-Received: by 2002:a05:600c:c493:b0:471:700:f281 with SMTP id 5b1f17b1804b1-48727ef16f4mr28016755e9.25.1774605037275;
        Fri, 27 Mar 2026 02:50:37 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:471:700:f281 with SMTP id 5b1f17b1804b1-48727ef16f4mr28016155e9.25.1774605036663;
        Fri, 27 Mar 2026 02:50:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722fa8dc6sm146914295e9.1.2026.03.27.02.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:50:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1056F5FD6CD; Fri, 27 Mar 2026 10:50:35 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: hawk@kernel.org, netdev@vger.kernel.org
Cc: hawk@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, j.koeppeler@tu-berlin.de,
 kernel-team@cloudflare.com, Chris Arges <chris.arges@gmail.com>, Mike
 Freemon <mike.freemon@cloudflare.com>
Subject: Re: [PATCH net-next 0/5] veth: add Byte Queue Limits (BQL) support
In-Reply-To: <20260324174719.1224337-1-hawk@kernel.org>
References: <20260324174719.1224337-1-hawk@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 27 Mar 2026 10:50:34 +0100
Message-ID: <87h5q1d2j9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [0.43 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,mojatatu.com,resnulli.us,tu-berlin.de,cloudflare.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272482-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,toke.dk:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 84FFD342123
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hawk@kernel.org writes:

> From: Jesper Dangaard Brouer <hawk@kernel.org>
>
> This series adds BQL (Byte Queue Limits) to the veth driver, reducing
> latency by dynamically limiting in-flight bytes in the ptr_ring and
> moving buffering into the qdisc where AQM algorithms can act on it.
>
> Problem:
>   veth's 256-entry ptr_ring acts as a "dark buffer" -- packets queued
>   there are invisible to the qdisc's AQM.  Under load, the ring fills
>   completely (DRV_XOFF backpressure), adding up to 256 packets of
>   unmanaged latency before the qdisc even sees congestion.
>
> Solution:
>   BQL (STACK_XOFF) dynamically limits in-flight bytes, stopping the
>   queue before the ring fills.  This keeps the ring shallow and pushes
>   excess packets into the qdisc, where sojourn-based AQM can measure
>   and drop them.

So one question here: Is *Byte* queue limits really the right thing for
veth? As you mention above, the ptr_ring is sized in a number of
packets. On a physical NIC, accounting bytes makes sense because there's
a fixed line rate, so bytes turn directly into latency.

But on a veth device, the stack processing is per packet, and most
processing takes the same amount of time regardless of the size of the
packet (e.g., netfilter rules that operate on the skb only).

So my worry would be that when you're accounting in bytes, if there's a
mix of big and small packets, you'd end up with the BQL algorithm
scaling to a "too large" value, which would allow a lot of small packets
to be queued up, adding extra latency (or even overflowing the ring
buffer if the ratio is large enough).

Have you run any such experiments? And have you tried just accounting
the queue in packets, so instead of:

+		netdev_tx_sent_queue(txq, skb->len);

you'd just do:

+		netdev_tx_sent_queue(txq, 1);


?

-Toke


