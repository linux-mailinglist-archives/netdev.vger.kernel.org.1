Return-Path: <netdev+bounces-248976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E7511D123CA
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 12:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B16C301D336
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 11:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0A63563DA;
	Mon, 12 Jan 2026 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VThqg0rt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2D2TFl9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85D335502B
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216774; cv=none; b=HXgM5CK4kGszx+/CET6RXJtZjGq+YCqtZe1qxVJju+cgKHZlA/t97YHXV2WuEULq0BJCrlCEJ++AcxoXojrSWaGRg494Nqnm4sh+Ua8o9BEQaUgc2tmF0lmQsqNBxRw+X31ZcALAPXT6BXSyVdtxlFJyjG5qJDEsFk9gF3v2PeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216774; c=relaxed/simple;
	bh=dEODH6OKSSM3wWFAUIvzs3xEPFKgpqUcd7jKkQTVgAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVUaulWgNJF8Sn4YTObFxlZrwN8AAPrWn3P0dp0iknppwg5Oc8+LU9rto4LdUsWTdrOC28OS7kUEO5TTjxIDZfW/n73ApLsel4AJ5LY4Eq66Ry7/b1Hj2BgEmGsgDfh5keGpizmLbb99NYSY9pll1XPkGPb2eirl0tWBEfjgxAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VThqg0rt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2D2TFl9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768216771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPyEp35yrxB/6+/GJhhyFrjf6xeA9T1VOzgBIjcqhzY=;
	b=VThqg0rt88hfyMNui99m4pwwNAU8eyQxVgKSAJdHb5uEOERSh9L3m87hhxip9Laq2uLD2D
	3ufx3rsArfXKEVLemCQeyJG0A0672INLjc9PPqBMeKnckdWHoy+mjNm7b1LgfXXeaVNPfu
	bzfnGkTzyF6nG/X4XkrAbaxI5eDcgHI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-eHcgConfMruh7-jkaaNaQQ-1; Mon, 12 Jan 2026 06:19:30 -0500
X-MC-Unique: eHcgConfMruh7-jkaaNaQQ-1
X-Mimecast-MFC-AGG-ID: eHcgConfMruh7-jkaaNaQQ_1768216769
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43284f60a8aso3525046f8f.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 03:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768216769; x=1768821569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uPyEp35yrxB/6+/GJhhyFrjf6xeA9T1VOzgBIjcqhzY=;
        b=G2D2TFl9rSLlAVjvIu6DDVA4CIer0RBQFvuAz1SG0c88kQmhl+ffMIjnOEppRo44b1
         xjLCA1kPNUyWxbq5HUQ7Hru+NAqsmdvOIhLCYaPLkRsIDerFtIFrgy53ucwgEhOj/hU4
         5FdtYErlJCDevrPzCNDr/SBSa1iYx4s9EHJ++DuKBz6KPehK5uKh5ZhDpooxPoiwM1u5
         C+ntek5azmmGzdkNBVxXvW4c5iEO1TxWYkMfxKHERqzg89l83S0laZVJ5ZuBpyTWNWhc
         wYsflk0WlqiMyIMuevpbrTMA3M7VMK4BO0ad7p6OdOCZyIcrMRt53ZJe7d7ebbTcL+Zn
         06IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768216769; x=1768821569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPyEp35yrxB/6+/GJhhyFrjf6xeA9T1VOzgBIjcqhzY=;
        b=QpD9+cdF5bSsiLFALatd5xezxhE2f4PS99n1P/f6mc2KxioSQrL8wgScdLyDlcHPCD
         p1CrkzZZ6QPUF6Q5dvL0c9auP6cBRqMeg+BLymkwFBH8TBWPYQV8cwsF1+X07r1HCuwL
         ImfwSXfEmrYa8MnjCDsBO4OjsJFmVwZc/44PHq18fyj2oltITydFH/ZVXYNUHsIg0Ozo
         ZTelL9oaWF7SMC1/rDJb+WwgEBdp9IPEI0LLRvZwTPxjuoSwi15yZBz6m1stZyu/nnqQ
         /P3jwazLnvLvH4V/l79euXWjjHYG5TUAX9Z8tYv6r05kcz+0ihXzgd6UWOOMoP/UPEnO
         VwPg==
X-Forwarded-Encrypted: i=1; AJvYcCWgNqeP7862AWtOh2tDekSYtmP6tow91WJB6DZqUYGYXIXwa5RhxsUnqI2Q5xfOFLu/CevUOvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGCyZqivmdiEIxrHVuRvrGPOZG7hfVs5HFmAKF+4b1ZOWsvBqn
	kMZH4aQLgs+X4a1ZYFvgwGDjGmv9OMUI4OcnOWiKA8aZcjHs7jYoWO6/XgTxe/w8RS8epRyt7OD
	Gv0QMQ9ZCXgzP8i70dPxjyQgZwvIqzFOOR82bJZZ4k0HQdiLws2Ya3sROwQ==
X-Gm-Gg: AY/fxX6D4iwLCY81m0bMmyectGwdwjsM0+W5Ao6sXEeH9tIIL3eGZ7DB/EC5PPniz0s
	SQVS7EjFSJZzFEZBsKUKoU0Lyb4PyJNjDtmu0/uH2XzrjEEkOZKx29WU5ybW4XgmRIQCrrtsLgx
	VA8nYtrcj61u7yaySQFzwgcZFNNTectD60KO0jjRLo51Ssz+mxkSoDYeROC/GC21na6ooHZeGwP
	UBGUCX9ePT7Yu1MtgqkQdEyXT5k2zm5TpQuQwUey+cHL+2ttYaZ6dx9H3zdK+tf7xJ+Wr2WcUGd
	rVUeK1hN+p3dqa6we7EqSygU+wfhw4+CXGrnuHnzkULvyXo0a9CtOhemOjnKS6q6+LWYYwQlVBM
	B1NNic/IRkuUruinxR/fzbCJKkQ1FJ+M=
X-Received: by 2002:a05:600c:3146:b0:477:b642:9dc9 with SMTP id 5b1f17b1804b1-47d84b3b513mr189681955e9.28.1768216769322;
        Mon, 12 Jan 2026 03:19:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkXiyM0dc1PZUdH5UxPIiTHeham2VtB7pwju2vrblwSj2QD/OERovKHTVGzk8mENQ3pAgOlw==
X-Received: by 2002:a05:600c:3146:b0:477:b642:9dc9 with SMTP id 5b1f17b1804b1-47d84b3b513mr189681475e9.28.1768216768829;
        Mon, 12 Jan 2026 03:19:28 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f653cd6sm367623105e9.9.2026.01.12.03.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 03:19:28 -0800 (PST)
Date: Mon, 12 Jan 2026 06:19:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Jason Wang <jasowang@redhat.com>, willemdebruijn.kernel@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v7 9/9] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when qdisc is present
Message-ID: <20260112061831-mutt-send-email-mst@kernel.org>
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-10-simon.schippers@tu-dortmund.de>
 <CACGkMEuQikCsHn9cdhVxxHbjKAyW288SPNxAyXQ7FWNxd7Qenw@mail.gmail.com>
 <bd41afae-cf1e-46ab-8948-4c7fa280b20f@tu-dortmund.de>
 <CACGkMEs8VHGjiLqn=-Gt5=WPMzqAXNM2GcK73dLarP9CQw3+rw@mail.gmail.com>
 <900c364b-f5ca-4458-a711-bf3e0433b537@tu-dortmund.de>
 <20260111233129-mutt-send-email-mst@kernel.org>
 <55bcb1ec-bdbb-44aa-8fa0-470916e986aa@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55bcb1ec-bdbb-44aa-8fa0-470916e986aa@tu-dortmund.de>

On Mon, Jan 12, 2026 at 12:17:12PM +0100, Simon Schippers wrote:
> On 1/12/26 05:33, Michael S. Tsirkin wrote:
> > On Fri, Jan 09, 2026 at 11:14:54AM +0100, Simon Schippers wrote:
> >> Am I not allowed to stop the queue and then return NETDEV_TX_BUSY?
> > 
> > We jump through a lot of hoops in virtio_net to avoid using
> > NETDEV_TX_BUSY because that bypasses all the net/ cleverness.
> > Given your patches aim to improve precisely ring full,
> > I would say stopping proactively before NETDEV_TX_BUSY
> > should be a priority.
> > 
> 
> I already proactively stop here with the approach you proposed in
> the v6.
> Or am I missing something (apart from the xdp path)?

Yes, I am just answering the general question you posed.

> 
> And yes I also dislike returning NETDEV_TX_BUSY but I do not see how
> this can be prevented with lltx enabled.

Preventing NETDEV_TX_BUSY 100% of the time is not required. It's there
to handle races.

-- 
MST


