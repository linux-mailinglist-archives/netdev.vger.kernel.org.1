Return-Path: <netdev+bounces-233463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AB8C13B92
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 10:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0CC935415B
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 09:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238B52E9EB1;
	Tue, 28 Oct 2025 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7yBZpRD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAAF2D879F
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642636; cv=none; b=hKkKttYQ/CVaVTxtW5aJqUekHBQabjokIth1OYeUqbVOJ0R+0XdCvhqDUe08f/k8dPzBRVMlaT9tzYjP4yL2hfUpBZ9CU/bGuTihMAg+S+SQaqO/a7QQJezVktzmvdNAa99qhUZbVTbp6CjHIsGSuLJ4+xrjJ1cfSueQZ+lNUrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642636; c=relaxed/simple;
	bh=gsaXk6rPSnT3/htmS1wC1UxgQ9W8HC0fe87DUuj7boA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iF4I6hD7TgUU63qJR4OeNrx5J0d5jyDRLMPUnfnsf951LnZjSRUHrgFsZkglZRPVnMWhNVc/l0Dow83Iohbdo2l26R+ITCtVurAAjnc1+d82mdEH835XzdrSKkq5L7XhNW9/XhVP9sqGvsUsqN+Y7eoE3s8Tru7ge3+zHyjfCQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7yBZpRD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761642633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fC2VCoLVnfLvc+GVN6vMzms7DTor0VnmsdHYFXK6aw=;
	b=H7yBZpRDmG6FDvDNe1OUeNStN7meFo7sma3g0PNcS3W6GigR8K4PMCOX90Y4SobWXlnDXa
	/O4EjRe9ZvqXEfr/yyvLmyEG5bVdYkStdg8MFuzYjqvPrfKQPCHKCdNvGbXga3hGr3LUH4
	0OoSC1JOqCSpffsOmWT9mwrIfhONPic=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-gJGmQCBTPsWLwOHLhUrR3w-1; Tue, 28 Oct 2025 05:10:31 -0400
X-MC-Unique: gJGmQCBTPsWLwOHLhUrR3w-1
X-Mimecast-MFC-AGG-ID: gJGmQCBTPsWLwOHLhUrR3w_1761642631
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b6d7ad47b58so336874666b.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 02:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761642631; x=1762247431;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fC2VCoLVnfLvc+GVN6vMzms7DTor0VnmsdHYFXK6aw=;
        b=f9Vs9b7UDiKz2cQsj8UdkE2ZCfIMv7CPSY41AShxuca68u76fm7Pz5LrREJlBWDVG2
         mKvpU85wiSXrQ3ykM2YuGKt32Nsvc65B0s67Z2HYyZYjUUH4AQYRFSPr2REq/nzs6Leo
         9+46UNpixtqYyKhCn7BRPXn40+cOWu9jaxvOk6V3hkBHVyvM1pIIlyp/RzUvPEyr94dK
         eMMguInELeM+oV8Zkjum1IZ46crQiiodsRxtMRQ8npNZnYKyXFSbKcgtwk7HXx7ei95M
         8aqi+8R+N+lsv85xsfRUU3bRkfOoxxMH8frlFXfxXe5YOIOHsMO39SsZFzYE1NhwXqRC
         bsUw==
X-Forwarded-Encrypted: i=1; AJvYcCU2Vaob8WCRjrBFjCt0W0/W1TgWxUpYV6l1nAJhkSt+AGeoqgcXB4OClEe55L0mlthN/7lCFsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMUilIFk8D6FrRRd/drXdmt3PMwQndAHeKcakjWnVu7bWS4LDL
	sQucLXWnU1xCtkn7VFudPSIqE0sM0CfKNVzYf7d74uqUkA1dS//8/W3EXtRRcZ0th0VIWgKPzuJ
	9wtB/KiGJJepGtoL9GQ90C36Pm2w6vE2135C6bUzaCRZoLSdc9374CkKPxQ==
X-Gm-Gg: ASbGnct1nAcxsTJLSnlBKvTXCqureluNBkxHl0qBoeis1AQbaGypg4FmNAlg8GEEeFk
	7iACCJLQBvUDEnSzu2iciodsk7R8qdrEyTkcGGJZbjb/WVAZYgZqzQrUYoaZwqoKAijfiBWoZlN
	6k6ee2zSHwrmt0g2II4o4maWwl2Wfp/73VX2Q+2VOtJlTY5duxbceG/or1+nCA0Zvs5AxULHGJw
	A+wBHPIvzlaRCYHzGWmRyBbWRs8BzDInioExoY9LbQ5nUq6pER65rzwoby1tY/y+ZIobrgDt+SE
	9JC4jecIRVc2DyMkMIG7krUF1vmJM6KRAYnhnkUw1DBg0yQInGbwf05pZmJwt/B08OUIiFGS2LI
	eMQ8FA0kxWrbT/OJzyksA1DM=
X-Received: by 2002:a17:906:7314:b0:b6d:5f02:51e1 with SMTP id a640c23a62f3a-b6dba48ed89mr308759466b.20.1761642630725;
        Tue, 28 Oct 2025 02:10:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp5fIM3h+FEyqEOS5MHMS5ieohkbVb2Z5rr/lbPP90LvTja8uJXC93IQE7iLbY3k1MDqtHAA==
X-Received: by 2002:a17:906:7314:b0:b6d:5f02:51e1 with SMTP id a640c23a62f3a-b6dba48ed89mr308756366b.20.1761642630332;
        Tue, 28 Oct 2025 02:10:30 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8548ed9asm1045251566b.74.2025.10.28.02.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 02:10:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C0E5E2EAC74; Tue, 28 Oct 2025 10:10:28 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 ihor.solodrai@linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 makita.toshiaki@lab.ntt.co.jp, toshiaki.makita1@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net V2 1/2] veth: enable dev_watchdog for detecting
 stalled TXQs
In-Reply-To: <176159553266.5396.10834647359497221596.stgit@firesoul>
References: <176159549627.5396.15971398227283515867.stgit@firesoul>
 <176159553266.5396.10834647359497221596.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 28 Oct 2025 10:10:28 +0100
Message-ID: <87ecqne6ij.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> The changes introduced in commit dc82a33297fc ("veth: apply qdisc
> backpressure on full ptr_ring to reduce TX drops") have been found to cau=
se
> a race condition in production environments.
>
> Under specific circumstances, observed exclusively on ARM64 (aarch64)
> systems with Ampere Altra Max CPUs, a transmit queue (TXQ) can become
> permanently stalled. This happens when the race condition leads to the TXQ
> entering the QUEUE_STATE_DRV_XOFF state without a corresponding queue wak=
e-up,
> preventing the attached qdisc from dequeueing packets and causing the
> network link to halt.
>
> As a first step towards resolving this issue, this patch introduces a
> failsafe mechanism. It enables the net device watchdog by setting a timeo=
ut
> value and implements the .ndo_tx_timeout callback.
>
> If a TXQ stalls, the watchdog will trigger the veth_tx_timeout() function,
> which logs a warning and calls netif_tx_wake_queue() to unstall the queue
> and allow traffic to resume.
>
> The log message will look like this:
>
>  veth42: NETDEV WATCHDOG: CPU: 34: transmit queue 0 timed out 5393 ms
>  veth42: veth backpressure stalled(n:1) TXQ(0) re-enable
>
> This provides a necessary recovery mechanism while the underlying race
> condition is investigated further. Subsequent patches will address the ro=
ot
> cause and add more robust state handling.
>
> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to =
reduce TX drops")
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


