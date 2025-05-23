Return-Path: <netdev+bounces-193149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9A9AC2A9A
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 21:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C33A7B0A1B
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 19:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D07717A2FF;
	Fri, 23 May 2025 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8bLDR3R"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD6512D1F1
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748029865; cv=none; b=kRlPkpGlM7QdGS/XE0ZOPtyql01RXJRlDIeM/7vle2wDHcR1cBNI7y/VIUognm1oXQ+ZaFOY3KTsmaOX63juhjPUG7MN0BYzW5AMGHNzpDsa8w+XD/RR2gsp7X0zjVBTwbjJFKTUTcU/ZaIiHMiGmO3FWxo1oX/Th5hDI4m48Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748029865; c=relaxed/simple;
	bh=5Uvuazls/qTbwEpK7NqnBCR3Fq3kHqnl1PbxoQBV8uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5nNpayaRJXR3TcpaKPgAFuQ928zo/wAVWE/2uf055kddNQ+AW0uCtJS3qd8fnSAdmz6BeH9MGAfkjwo9UDnsvesTWIn636hN+RYtjoCh6ojZRDfzrubUlce8marG2moESoYdU+PSgMVg1DYF7M5BILyKaEnl9Y2JiybJ5AiroY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8bLDR3R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748029861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W55bARO0MHFr1KrH6fi/B1dVeDCrcnhMxKpWe99zXPs=;
	b=D8bLDR3R0M9m/GmfkzrVj4TT0+trW3LpWjvoy9KnV9DF/793OSPxXbs+AdO7kTHAz9N4Ax
	hsB7eBRyaffJErJPESll5oHabn3+4NGyUlntVhav2tY4KHKm1pIXhbl3vfoZtDqBZKkv2o
	27gIzYEzeABfAWPPAq3sJuhdNM1PZpU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-3EvuCv_RMUGIGxMod3okag-1; Fri, 23 May 2025 15:51:00 -0400
X-MC-Unique: 3EvuCv_RMUGIGxMod3okag-1
X-Mimecast-MFC-AGG-ID: 3EvuCv_RMUGIGxMod3okag_1748029859
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-442dc702850so963755e9.1
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 12:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748029859; x=1748634659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W55bARO0MHFr1KrH6fi/B1dVeDCrcnhMxKpWe99zXPs=;
        b=jVRB5xd3/gVDQGKu6+tPC0rQ+XMUPdhj85twphHxbyeyxJ2y2fb0bLSrVAKaWMlX44
         NEBQbrsmbGhFYyTaw6vET7dtyRvrr1hW8gsNPCq5HjpNqOVJ8ksCmj4DNIMXx8DUTozu
         JDFW5zBY2LGyCarDFyNYGpsT3nnmxYB39T4uT8aoY/3L0vrDx+zeRsGGiKsXPLpRu+ch
         UTPDDigEO1f7RI7N2CW+P4gvKoEHyZKOEkbG4U1SHddS2vinMtQsu9Y9em90Vte9/8iL
         +nMlncWCV5Pl1KPW///kiTqcMtjdxY+pvEqyxUQDsLwBQYmTrEoa/w2Hq6mFL3ymFNO8
         avpw==
X-Gm-Message-State: AOJu0YwaCSkGP2X/dIKzdUYpEhIfvKC0ZhXiFNWcV72K2aSjNe5iGxQI
	v27MYuFMX+aIY7RWPG0rEYGlW8+Txe3xTxr9/jbmEb61tznSxHjiXfTooAOk56PT9+nS636Obx7
	lv11jY29IjQU/5iTsiWu3XmviCojnPviQuO+P9i0PGQ+0Lfk1kqXEb7YoWA==
X-Gm-Gg: ASbGncvw0dCzvZblaTGhQo0JYDDgdzMZ0FpdkyTx0u6eDB2e81749S06tKILu9ez6O9
	6AMJAShoosiMTcZAsBvbR2YLqtyb3/sducAAORRlD4jZ451TOHBD8bfK5g8NVpujovY58VAdKXx
	M85oJiJNWSfA28H/CXUSJvdil3vslXOnuVPcbxBOBWZZwD0dTMvPMZvTD1ViYlaXCNRtnq9J/xK
	IQRI+WxtDcXP2SpNkZZ154Qn0/JiftXAzGTpiGUTQx4oTw9gx5SUz/A3dYOZ2+VT6CY3N7a34dN
	lz/XOw==
X-Received: by 2002:a05:600c:1d20:b0:442:d9f2:c753 with SMTP id 5b1f17b1804b1-44c92f21e58mr2811215e9.26.1748029858994;
        Fri, 23 May 2025 12:50:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAJPekD/PczA6t64MSkk89jHa3GJycPUAqAVhKXWEt0hcdDi2c/AAlC+0DbeOnyjKOz844Mg==
X-Received: by 2002:a05:600c:1d20:b0:442:d9f2:c753 with SMTP id 5b1f17b1804b1-44c92f21e58mr2811015e9.26.1748029858568;
        Fri, 23 May 2025 12:50:58 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f38142aasm148555015e9.27.2025.05.23.12.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 12:50:56 -0700 (PDT)
Date: Fri, 23 May 2025 15:50:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH net-next 1/8] virtio: introduce virtio_features_t
Message-ID: <20250523154934-mutt-send-email-mst@kernel.org>
References: <cover.1747822866.git.pabeni@redhat.com>
 <9a1c198245370c3ec403f14d118cd841df0fcfee.1747822866.git.pabeni@redhat.com>
 <20250521115217-mutt-send-email-mst@kernel.org>
 <fa55e26b-54f7-400f-88f7-530f3a95a0e9@redhat.com>
 <d85926bf-ad6b-4898-9c12-693ee185f3d6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d85926bf-ad6b-4898-9c12-693ee185f3d6@redhat.com>

On Thu, May 22, 2025 at 05:26:33PM +0200, Paolo Abeni wrote:
> On 5/22/25 9:29 AM, Paolo Abeni wrote:
> > On 5/21/25 6:02 PM, Michael S. Tsirkin wrote:
> >> On Wed, May 21, 2025 at 12:32:35PM +0200, Paolo Abeni wrote:
> >>> +++ b/include/linux/virtio_features.h
> >>> @@ -0,0 +1,23 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>> +#ifndef _LINUX_VIRTIO_FEATURES_H
> >>> +#define _LINUX_VIRTIO_FEATURES_H
> >>> +
> >>> +#include <linux/bits.h>
> >>> +
> >>> +#if IS_ENABLED(CONFIG_ARCH_SUPPORTS_INT128)
> >>> +#define VIRTIO_HAS_EXTENDED_FEATURES
> >>> +#define VIRTIO_FEATURES_MAX	128
> >>> +#define VIRTIO_FEATURES_WORDS	4
> >>> +#define VIRTIO_BIT(b)		_BIT128(b)
> >>> +
> >>> +typedef __uint128_t		virtio_features_t;
> >>
> >> Since we are doing it anyway, what about __bitwise ?
> > 
> > Yep, I will add it in the next revision.
> 
> Uhm... this is actually problematic, as a key point of keeping the
> diffstat manageable is converting only the relevant drivers to use the
> extended features set - and adjust accordingly local variables and
> expressions.
> 
> The above means that in other devices a lot of code relies on extended
> features being (harmlessly, because nobody is going to set the highest
> bits for such features) downgraded to u64, or u64 promoted to
> virtio_features_t.
> 
> The __bitwise annotation generates warning for each of them; avoiding
> that warning require touching the same code I wanted to leave unmodified
> (and bring back a terrible diffstat).
> 
> /P

I am not insisting here, we can do it later as a patch on top.
But - could you give an example pls?


