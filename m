Return-Path: <netdev+bounces-249481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 574AED19C16
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51DC13038182
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B4E3876DD;
	Tue, 13 Jan 2026 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTSAYshh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEXDcMHZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF7436A02C
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316961; cv=none; b=ry8Yul1JqIP1DkUnHQMVyWyotPaodbghBRt7sihJqtG10+c/MY0X7oD8Zyk2W76bJgelp4tvQNB3As5J3LENA7coW2euuWQlofMW6rr//XNtmCa5B9dmUKnXDlLGuffl0eUwFzDrHVzQCyLMgn56W/4G80Jc0kCr0Z2UyBzp4bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316961; c=relaxed/simple;
	bh=3zXEgrW72T0HFBYPdNsvotJZJOcjsWCZn/aiSz49gwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVLXZUE0b8Nhfv+Bwaw9bJVUCNUV8QFuKpkPnLillSCiL3mvfiCPv3xxb4uG3jk706JiiwISUZVfKRRXqyrYCjChr7XVsl611mdImLjdmfD9ZRMiVEq8UHF9ZvidhFit0I7Okpbe1co/GsVUWD+ExvksHNoTRoAk37h7V4tvdAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTSAYshh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEXDcMHZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768316959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Iv7jtHfyu2FIw37q1VMrstnC0/mkNFUj9G8Fyvhg8A=;
	b=ZTSAYshhQHQ8tFptQB0FUpPLMmqqWMww0lfmXr+gaVjZwxjdNIgEa26iyp7/jTWFcylopM
	OMVMCUjNy6m9oA5D+9yHVJJ35+40raFxuGJz2+42qwDMbTk8sP89KX6lgzEULsEcvRMzRl
	QZu2+g/DRm60EX4dy4eAaBLHSfcQ610=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-vlha9fC8NrqROEwXuOjb8A-1; Tue, 13 Jan 2026 10:09:17 -0500
X-MC-Unique: vlha9fC8NrqROEwXuOjb8A-1
X-Mimecast-MFC-AGG-ID: vlha9fC8NrqROEwXuOjb8A_1768316956
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso59677665e9.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 07:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768316956; x=1768921756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Iv7jtHfyu2FIw37q1VMrstnC0/mkNFUj9G8Fyvhg8A=;
        b=fEXDcMHZyQYw2smszmrNzvVI2b3aYw23dLHVbQ52F5JENul18DY3ivbHku5ZKnjTe3
         AUiPfGT7Nlp5Inop2MWaQSdjrvi9VENhYbTY2xqBnMqp+t4qmwV3QNdyiE3As6JMNQ6m
         Wl4u13npCUHk8p8vbDL8jMBtOM9aWdMhn2jnVBiK7sEOAz5TeI0oJ2uPe5XMedtLY2XV
         VihehCcVAewbdMNOJ3kePa3tQqb+Bdj+gQQM+9UsjqAsEiux7E3UFtmGq0UB/q385lYV
         bUrEBdDJbvgVDjY/uIpCDS19oR/BnBdb79hQT9x9csQAiyzBWZwMDg49jxdGScXXJ2x5
         ndjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768316956; x=1768921756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Iv7jtHfyu2FIw37q1VMrstnC0/mkNFUj9G8Fyvhg8A=;
        b=f+u4Sd5kgb6p2ZcWPDvF8FryCNqalLNH9Yal8PsdUm/FDEaRecgbqYlYzuhetSjAuE
         q97UWKd9Gze1ZOdUO/jgXXKOf7Ce76p+qESuqXyZAaxyKVQWIXqfV6YAVH5SbRAnjO0m
         rH7Ntd3c32J9kA8rHe8RzVXsRh0Ok7844nI/ekSpu62u54Bakp3OGBMAU+HqTnCH4EWL
         EL0i9CSS1pH7HqrpkEU25c3UDRG5RQwtu6fiqHxBmr90NsEEwLFzSkemnrTuus/LV+kR
         xTN8RD8lYAblhBTs3zLsKkudYgi8uRZfbOS4RrHVXvl9aSlW1fuk4BR5v+heiX/Ainse
         jnFA==
X-Forwarded-Encrypted: i=1; AJvYcCX2C88zXNo653s3G62TX7EmjVhXNG4qlSM2rq/tCjpMo5/qBc79oFgcskS1x2SiFSAbCGy53dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzNi4K3tgvktKPK3P82O75ZekbKLiV8jQYJ3y1AEQucm4mo2+M
	zJOgDC4ERgIH3E2hEInvL5Qh7k9UUafenhfQ997501wwOvEM68hANbJq/b0xSJcgEcObm8gwKY6
	JMSJiT4y4Mi5J7ZxysnW6NS6FJSUU8kxkWqQjY17e5579wEpLs6tYN8MMmA==
X-Gm-Gg: AY/fxX4H01g9YOTAN7ix9p6MzO557hPrLl9xwbUVOtwwfh9vPz+MhUMxalBm/uFQ8fy
	gGfp3pXeQuDSer0wxRkGy5ooRNGAlBftYddEsSAt1pOadOi/1DecxYnwX2rw2rfGuWr0IxRTxiY
	jh1qmrruPvjOh5hZ1e0gMk/AiPtXC/FQ78tWcnnmWtX92BFJMeZWbRzugydugXufOrun8L798rT
	5MNLwQ5nV1nhXBn6bp9CpqJ2bOGWatbZiyD+nMMy14yfj8m545oxRZUT5tZKHXcbQy5+NWBX65A
	+TSFkqRCxYtMZEZJMWtOptetBJ8aGpT1fPJdFzRCVVC94x30tNo7oxB/0RTwx5Tn/SQ5qCzORwu
	FxIN+n69ZcsO1GLBaOHn6BGXX5sXd0XU=
X-Received: by 2002:a05:600c:37ce:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-47d84b18ee1mr256230585e9.1.1768316956297;
        Tue, 13 Jan 2026 07:09:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIU9tLi+rd1piE3qCw9ltmh0taJcQjyrQSmq1XLBBBIKhKDikjGjztln4jAEzKC9qSMm64QA==
X-Received: by 2002:a05:600c:37ce:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-47d84b18ee1mr256230115e9.1.1768316955786;
        Tue, 13 Jan 2026 07:09:15 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47edee4cbc2sm18216645e9.4.2026.01.13.07.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:09:15 -0800 (PST)
Date: Tue, 13 Jan 2026 10:09:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2][next] virtio_net: Fix misalignment bug in struct
 virtnet_info
Message-ID: <20260113100902-mutt-send-email-mst@kernel.org>
References: <aWIItWq5dV9XTTCJ@kspp>
 <e9607915-892c-4724-b97f-7c90918f86fe@redhat.com>
 <20260113093839-mutt-send-email-mst@kernel.org>
 <916a6c1a-681e-4e5e-8d49-75d0de5c46a1@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <916a6c1a-681e-4e5e-8d49-75d0de5c46a1@redhat.com>

On Tue, Jan 13, 2026 at 04:06:05PM +0100, Paolo Abeni wrote:
> On 1/13/26 3:39 PM, Michael S. Tsirkin wrote:
> > On Tue, Jan 13, 2026 at 03:30:00PM +0100, Paolo Abeni wrote:
> >> On 1/10/26 9:07 AM, Gustavo A. R. Silva wrote:
> >>> Use the new TRAILING_OVERLAP() helper to fix a misalignment bug
> >>> along with the following warning:
> >>>
> >>> drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> >>>
> >>> This helper creates a union between a flexible-array member (FAM)
> >>> and a set of members that would otherwise follow it (in this case
> >>> `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> >>> overlays the trailing members (rss_hash_key_data) onto the FAM
> >>> (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> >>> The static_assert() ensures this alignment remains.
> >>>
> >>> Notice that due to tail padding in flexible `struct
> >>> virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
> >>> (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
> >>> offset 84 in struct virtnet_info) are misaligned by one byte. See
> >>> below:
> >>>
> >>> struct virtio_net_rss_config_trailer {
> >>>         __le16                     max_tx_vq;            /*     0     2 */
> >>>         __u8                       hash_key_length;      /*     2     1 */
> >>>         __u8                       hash_key_data[];      /*     3     0 */
> >>>
> >>>         /* size: 4, cachelines: 1, members: 3 */
> >>>         /* padding: 1 */
> >>>         /* last cacheline: 4 bytes */
> >>> };
> >>>
> >>> struct virtnet_info {
> >>> ...
> >>>         struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */
> >>>
> >>>         /* XXX last struct has 1 byte of padding */
> >>>
> >>>         u8                         rss_hash_key_data[40]; /*    84    40 */
> >>> ...
> >>>         /* size: 832, cachelines: 13, members: 48 */
> >>>         /* sum members: 801, holes: 8, sum holes: 31 */
> >>>         /* paddings: 2, sum paddings: 5 */
> >>> };
> >>>
> >>> After changes, those members are correctly aligned at offset 795:
> >>>
> >>> struct virtnet_info {
> >>> ...
> >>>         union {
> >>>                 struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
> >>>                 struct {
> >>>                         unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
> >>>                         u8         rss_hash_key_data[40]; /*   795    40 */
> >>>                 };                                       /*   792    43 */
> >>>         };                                               /*   792    44 */
> >>> ...
> >>>         /* size: 840, cachelines: 14, members: 47 */
> >>>         /* sum members: 801, holes: 8, sum holes: 35 */
> >>>         /* padding: 4 */
> >>>         /* paddings: 1, sum paddings: 4 */
> >>>         /* last cacheline: 8 bytes */
> >>> };
> >>>
> >>> As a result, the RSS key passed to the device is shifted by 1
> >>> byte: the last byte is cut off, and instead a (possibly
> >>> uninitialized) byte is added at the beginning.
> >>>
> >>> As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
> >>> moved to the end, since it seems those three members should stick
> >>> around together. :)
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
> >>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >>> ---
> >>> Changes in v2:
> >>>  - Update subject and changelog text (include feedback from Simon and
> >>>    Michael --thanks folks)
> >>>  - Add Fixes tag and CC -stable.
> >>
> >> @Michael, @Jason: This is still apparently targeting 'net-next', but I
> >> think it should land in the 'net' tree, right?
> >>
> >> /P
> > 
> > Probably but I'm yet to properly review it. The thing that puzzles me at
> > a first glance is how are things working right now then?
> 
> Apparently they aren't ?!?
> 
> rss self-tests for virtio_net are failing:
> 
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/471521/15-rss-api-py/stdout
> 
> but the result is into the CI reported as success (no idea why?!?)
> 
> /P

and this fixes it?


