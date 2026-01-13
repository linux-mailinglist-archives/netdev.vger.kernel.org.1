Return-Path: <netdev+bounces-249471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07907D198FE
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 846BB303527C
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 14:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B562BF3F3;
	Tue, 13 Jan 2026 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxSfx36p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uCtC8EPk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B529AB15
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315203; cv=none; b=pr70VQWrX5BtiC6MxhhpGMUR7EavxV9ZJNQONA/bR6spSQWK00PS+jNDgDDlY1lUgE0YcHwyy0VL1TWj8vUeXH9BCXGtyHPn2zVULmLNVpf0ptYHMRfd6K2CERAGw3GUjO7OudL2k07SQCZ2a3JPY7vGZh/zEUbadmTiq+L1vQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315203; c=relaxed/simple;
	bh=2hZQd5ccuxCC0AQonBSE9AjAhDyO99yxUSsTxYrB3Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3sjKDIlODUhzEL2gQ6anOVOehjIwSalC0hseD/c3qsFQukjm4TesQdPXPzzBewINmbAr+OAQ4VyxngAW0fuIsD1HFnjhu4ftnKzdQT7i3/pa1VXpWgr+gCB6HulhTnrnhOlkL1EVYQFGI9oOVSGP4MTu1C8znqm2RNKBj4Qlv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XxSfx36p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uCtC8EPk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768315201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vI5WiD76L9Ehd6Z/1lg+/ZLNpd63ZuSYDf1K66rRYIM=;
	b=XxSfx36pt58PzoTc7hYyrmE0HyWJnaT6ng0XY2+tvtsiJ3wpBgfbWSM5A/BiZAQ8cPqUFd
	lfBQ/l7i8P8V709pB8V4mWKb25pNz4aVfK48tCdf3LjOOywf5YBdpXqYWHcl+EAqGFcdZ1
	NbTWm36JFlvp1sDARwVbuhIllieDHw4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-qO4eyokNM-eUx3_CVwzXCA-1; Tue, 13 Jan 2026 09:40:00 -0500
X-MC-Unique: qO4eyokNM-eUx3_CVwzXCA-1
X-Mimecast-MFC-AGG-ID: qO4eyokNM-eUx3_CVwzXCA_1768315199
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d3ba3a49cso70387145e9.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 06:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768315199; x=1768919999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vI5WiD76L9Ehd6Z/1lg+/ZLNpd63ZuSYDf1K66rRYIM=;
        b=uCtC8EPktpg79KJq3NhZmLMOojjsGV36QOQ2C75RV7tWhldmcNscRQm68h53HdPDVQ
         bVF0CC7s4O548jj2mF1mjj6n0LkckDcrqb/X5ChgYz6OrOrwDu660ihuweWk6iAWb1aD
         naiUHhUscfXXl1VT4FZKDSK1am9Uek4xEZBYDDqiFCCMEw/3IEPLJ+y/VZpoW06OL1G8
         egnGO8O/ybtmHBva9LTtPHIVZKazn035rTXLOyYSv702biO5Fnr35Yay+BpuARBjJmlJ
         K5TcZkk7kqTC42zHvR1z4iBCv6Gr3wxh99a8/j7/Gz8f33DLqvyUdRtXvLyZM/525745
         0MpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768315199; x=1768919999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vI5WiD76L9Ehd6Z/1lg+/ZLNpd63ZuSYDf1K66rRYIM=;
        b=w19Cq54zbxX0xkBncb+atIv9iB/OfwUnii3cKsz1JoBoU3ZMpyhjiXbiDuNhfBRnr1
         YftV9TF3KdRDe25vre3vjf1mfRKGUTKKoFHcc561Lrb7+pNV/TyxViNi4Cs9Cfs7X6g7
         +Q+DRV8ZBYyNeQ1hnArYizfXcgcDJg79QTiIsWtCBd79OVk6CED1GDEG2SjIUs46m9OJ
         ay+PoLyCKuhlr3oXGUX6qfJehmgN8J5/Mhlj/fQM1toYZu6uh3T5sqB13lz5T5t8mES5
         H/ydFKQrs5l0sYvMkVSkUJYHmFZ0dywpIDFndRIAZcT7qWMMjqaok0ovx9RMXRkEU20j
         eChw==
X-Forwarded-Encrypted: i=1; AJvYcCUswhhmY/HZw+vutMOdYSO7mOwNGJeiFMsMJGPXBnJpSOe4/sBOW7QpYD5qyKChPKiIkVIaVGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySmQ3QT+C/0xfyNFiYcImHWjTW0lyeMmAgR0n2fNMecZu1TEQN
	KwUyQvso8OrXjUkW0P6bMKb3iNDMbGBVn67vd4c2WjCGQJUGUNdhXxa4/imJCD3VPkVPKvlHSIe
	MS35xWoXA6ctlCwi1aZWsE+T4aJRAnSnpIonwYlMfk3s7TBlkrcAleGD6ZQ==
X-Gm-Gg: AY/fxX419S7qPw0QixR/D5Jxv1H8l2dsSoEMOydNrt2I9vvhjNuUReHlhy7zqwov0sx
	xz0tAh8sns7fHLBm2NNQHrLjROX0dtZGke6FZvzLrxhBfDM54HoNRPUY5K+ar7G6Z7qFnLJJOdv
	mFKw/4/PdHzsdxoTAXoZKu/b61K6VmFqVJWvlBefDvOR6JsmzF0ZthXsuPCeUZq4dGAeWx2aY1C
	MKuaaHH+KdtZKK2hlhLC+QT0tst2Z4KMlv17s2/Cn9Chn8lO6k3RoT4kG0cEkt804mvj96utMSw
	dyGXbV9MkjSDB41JksaJsJ6P1gV5fE50tqxAv01RaSvfO5jZ+lTGH11twYYQj0PLjfKlLhwXRej
	jYqzD54AVTP2UEXliSaEWDlCGxnthA1k=
X-Received: by 2002:a05:600c:c493:b0:477:639d:bca2 with SMTP id 5b1f17b1804b1-47d84b0aaaemr221925725e9.4.1768315199009;
        Tue, 13 Jan 2026 06:39:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEegKDUfwO8TWm5wKSLnhblYGT24MNgG1NnbHZguDqFhvW2s+7iCnFk9O9XcmwAVqNDE6f4XA==
X-Received: by 2002:a05:600c:c493:b0:477:639d:bca2 with SMTP id 5b1f17b1804b1-47d84b0aaaemr221925125e9.4.1768315198204;
        Tue, 13 Jan 2026 06:39:58 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6953fasm398836085e9.5.2026.01.13.06.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:39:57 -0800 (PST)
Date: Tue, 13 Jan 2026 09:39:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2][next] virtio_net: Fix misalignment bug in struct
 virtnet_info
Message-ID: <20260113093839-mutt-send-email-mst@kernel.org>
References: <aWIItWq5dV9XTTCJ@kspp>
 <e9607915-892c-4724-b97f-7c90918f86fe@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9607915-892c-4724-b97f-7c90918f86fe@redhat.com>

On Tue, Jan 13, 2026 at 03:30:00PM +0100, Paolo Abeni wrote:
> On 1/10/26 9:07 AM, Gustavo A. R. Silva wrote:
> > Use the new TRAILING_OVERLAP() helper to fix a misalignment bug
> > along with the following warning:
> > 
> > drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > 
> > This helper creates a union between a flexible-array member (FAM)
> > and a set of members that would otherwise follow it (in this case
> > `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> > overlays the trailing members (rss_hash_key_data) onto the FAM
> > (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> > The static_assert() ensures this alignment remains.
> > 
> > Notice that due to tail padding in flexible `struct
> > virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
> > (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
> > offset 84 in struct virtnet_info) are misaligned by one byte. See
> > below:
> > 
> > struct virtio_net_rss_config_trailer {
> >         __le16                     max_tx_vq;            /*     0     2 */
> >         __u8                       hash_key_length;      /*     2     1 */
> >         __u8                       hash_key_data[];      /*     3     0 */
> > 
> >         /* size: 4, cachelines: 1, members: 3 */
> >         /* padding: 1 */
> >         /* last cacheline: 4 bytes */
> > };
> > 
> > struct virtnet_info {
> > ...
> >         struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */
> > 
> >         /* XXX last struct has 1 byte of padding */
> > 
> >         u8                         rss_hash_key_data[40]; /*    84    40 */
> > ...
> >         /* size: 832, cachelines: 13, members: 48 */
> >         /* sum members: 801, holes: 8, sum holes: 31 */
> >         /* paddings: 2, sum paddings: 5 */
> > };
> > 
> > After changes, those members are correctly aligned at offset 795:
> > 
> > struct virtnet_info {
> > ...
> >         union {
> >                 struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
> >                 struct {
> >                         unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
> >                         u8         rss_hash_key_data[40]; /*   795    40 */
> >                 };                                       /*   792    43 */
> >         };                                               /*   792    44 */
> > ...
> >         /* size: 840, cachelines: 14, members: 47 */
> >         /* sum members: 801, holes: 8, sum holes: 35 */
> >         /* padding: 4 */
> >         /* paddings: 1, sum paddings: 4 */
> >         /* last cacheline: 8 bytes */
> > };
> > 
> > As a result, the RSS key passed to the device is shifted by 1
> > byte: the last byte is cut off, and instead a (possibly
> > uninitialized) byte is added at the beginning.
> > 
> > As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
> > moved to the end, since it seems those three members should stick
> > around together. :)
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> > Changes in v2:
> >  - Update subject and changelog text (include feedback from Simon and
> >    Michael --thanks folks)
> >  - Add Fixes tag and CC -stable.
> 
> @Michael, @Jason: This is still apparently targeting 'net-next', but I
> think it should land in the 'net' tree, right?
> 
> /P

Probably but I'm yet to properly review it. The thing that puzzles me at
a first glance is how are things working right now then?

-- 
MST


