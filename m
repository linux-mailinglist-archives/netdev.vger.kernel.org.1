Return-Path: <netdev+bounces-220129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6515B4488A
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 23:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E404917E5F1
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6342129D275;
	Thu,  4 Sep 2025 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpyyAYnB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBAB28DB71
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021502; cv=none; b=oTMGsrlzhLfPgsjvqFth2wSm5s6EIT9JimxYDdgXFntbRuIiByvFTBiu1bhQVdzBzqRgzewpE45q9KNG4BXZppLiYxZgFVzl+aZwoApcOhP6Y2RmKd9Xopy3wUgfeBOXiAmmLV4NRQcYgmW5p2SMTqqSvenogmEpYHr34/6PIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021502; c=relaxed/simple;
	bh=UTOOlZIQ4c9dm1bWMI/1leIB+NQMUt7B2+b+Jnoq2CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uc6lX+srvuLDKWHRnfr3708oZpOaGdVvvAZKtISj41wYMqyIjglkgQG4w+Ddf4tL9ylsi1c2Jn2y+f0Ye4c2PpME1oMmhgRLiP/LY2uzpRtktItYj1hlloCb4rURBbItKcs35xTiFi31WTCb4dQV/2+Lf1QGw/ropBXeiUATtfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MpyyAYnB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757021499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ENzZgn6QrvH6M67TV54TxO3IiK3WQ2Mya06rqToR830=;
	b=MpyyAYnBTHHqE+i5A4mwfexBp8MguUAR5fkoNAeR5iQljt67NCv73tiZ+L29Nb9ie0urrQ
	DmDaQKxMNkGa/1wg0Xb0PjdRx0R5R6x9DRbKDwT8uikpJSWXLtQPtrUvemwaJGd4LNkWtD
	/VIL1xtLIPFk8n7IDTRliJ0QzBRAB/U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-fet3edMtOQKJHCFL9SWuzg-1; Thu, 04 Sep 2025 17:31:38 -0400
X-MC-Unique: fet3edMtOQKJHCFL9SWuzg-1
X-Mimecast-MFC-AGG-ID: fet3edMtOQKJHCFL9SWuzg_1757021496
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3d17731ab27so1122479f8f.0
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 14:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757021496; x=1757626296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENzZgn6QrvH6M67TV54TxO3IiK3WQ2Mya06rqToR830=;
        b=BK0zbSQb3HFYBdUf2nsMCgTaRYrgLBp9Jo/tgNoluexnW71ypvdkwvngVERYPBhNpm
         qFvYt4bQbSI6CTnEblc59eJgewhy0lXWxxHvKEN1HCy93aw7amrdxGxwD0apSCMdGpF6
         OJydXQbsJI/ufAIGuZnwxelBnfxKS/yyBO7Tg7h6IO6lN35cUYNQjNFPOKluGL5uzH77
         wNBNNjKAGXOsS3MwpLPBUt0AxuQ00Rx3Dkaxeac2YVUzkr8e14AF7zJ9tsRfJX16iBU9
         u2ybir3SqKNHQdizIcBjzLovRtXxVvw3BcbtOKh7V+qXF/bLloZD9q8Kj0eTToMBbItH
         p2WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHNHinhJ2Vko4+cSdF8EhDSf9iPXb6IQeYFYVyNijQdGVx9p1KR0yl6o0Y9fgfeJIzL/EHIr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgxkwc50qWGKjLon2LdG9l2+cZ01MSnS2jc2+ifmB/TDo965y9
	rFxidBX6X/cZbRmD/JoWDDR0u0zGBPvoajGDUmDU81qf5O59buFSQH7KJDCs4h68XIphlrgvC5c
	6Mr/21iQQSezVxyVjTWW0PKkS60uqNrzNRKEIYM63mAcUqRSbUDl9hR6eVQ==
X-Gm-Gg: ASbGncsDc8wDGxTtz2YbfEYmPe+M05UjYVwKs3a5Cp3rnaxoiTeY1kznPRWpGX0ovYk
	Z23dSaysjUxX/TXU9222wQ6KR2jEikTqrKFGVFdocBsLCYXImVCrTZqBp6G72MZiGiGL1DoBgkf
	Ihuq24b8nTyEpMny9XR8BkLiwhcK6xs8LsmVpN0nu1wR90zdgS8MypQmH4xYzl5Aawkx8rUgpPM
	nAe+GYj23NqinR3vnL0ZstYRk/208kpY7s0oEPa8vf/pSuv/+wna0xuszGYRhnirNkVVcBEZOsN
	UDQgSq+bySGzd00TFILizZ/TjPJItoWc9cX2LwTvbvMWGC9RQmDW9LEqr9yhUew9Ew==
X-Received: by 2002:a05:6000:381:b0:3d7:38a7:35aa with SMTP id ffacd0b85a97d-3d738a7398bmr13118407f8f.24.1757021496225;
        Thu, 04 Sep 2025 14:31:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER4VSHQehlxm9viGCaLCiSUfIBqClOaGylclXglywjo1Jhx+yPCFvISOavLQeeDAzgnPEefA==
X-Received: by 2002:a05:6000:381:b0:3d7:38a7:35aa with SMTP id ffacd0b85a97d-3d738a7398bmr13118381f8f.24.1757021495725;
        Thu, 04 Sep 2025 14:31:35 -0700 (PDT)
Received: from redhat.com (93-51-222-138.ip268.fastwebnet.it. [93.51.222.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0a1f807f9sm28148640f8f.38.2025.09.04.14.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 14:31:35 -0700 (PDT)
Date: Thu, 4 Sep 2025 17:31:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Simon Horman <horms@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] virtio_net: Fix alignment and avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20250904172951-mutt-send-email-mst@kernel.org>
References: <aLiYrQGdGmaDTtLF@kspp>
 <20250904091315.GB372207@horms.kernel.org>
 <cac19beb-eefb-4a6a-9eec-b414199ce339@embeddedor.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cac19beb-eefb-4a6a-9eec-b414199ce339@embeddedor.com>

On Thu, Sep 04, 2025 at 08:53:31PM +0200, Gustavo A. R. Silva wrote:
> 
> 
> On 9/4/25 11:13, Simon Horman wrote:
> > On Wed, Sep 03, 2025 at 09:36:13PM +0200, Gustavo A. R. Silva wrote:
> > > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > > getting ready to enable it, globally.
> > > 
> > > Use the new TRAILING_OVERLAP() helper to fix the following warning:
> > > 
> > > drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > 
> > > This helper creates a union between a flexible-array member (FAM)
> > > and a set of members that would otherwise follow it (in this case
> > > `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> > > overlays the trailing members (rss_hash_key_data) onto the FAM
> > > (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> > > The static_assert() ensures this alignment remains, and it's
> > > intentionally placed inmediately after `struct virtnet_info` (no
> > > blank line in between).
> > > 
> > > Notice that due to tail padding in flexible `struct
> > > virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
> > > (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
> > > offset 84 in struct virtnet_info) are misaligned by one byte. See
> > > below:
> > > 
> > > struct virtio_net_rss_config_trailer {
> > >          __le16                     max_tx_vq;            /*     0     2 */
> > >          __u8                       hash_key_length;      /*     2     1 */
> > >          __u8                       hash_key_data[];      /*     3     0 */
> > > 
> > >          /* size: 4, cachelines: 1, members: 3 */
> > >          /* padding: 1 */
> > >          /* last cacheline: 4 bytes */
> > > };
> > > 
> > > struct virtnet_info {
> > > ...
> > >          struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */
> > > 
> > >          /* XXX last struct has 1 byte of padding */
> > > 
> > >          u8                         rss_hash_key_data[40]; /*    84    40 */
> > > ...
> > >          /* size: 832, cachelines: 13, members: 48 */
> > >          /* sum members: 801, holes: 8, sum holes: 31 */
> > >          /* paddings: 2, sum paddings: 5 */
> > > };
> > > 
> > > After changes, those members are correctly aligned at offset 795:
> > > 
> > > struct virtnet_info {
> > > ...
> > >          union {
> > >                  struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
> > >                  struct {
> > >                          unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
> > >                          u8         rss_hash_key_data[40]; /*   795    40 */
> > >                  };                                       /*   792    43 */
> > >          };                                               /*   792    44 */
> > > ...
> > >          /* size: 840, cachelines: 14, members: 47 */
> > >          /* sum members: 801, holes: 8, sum holes: 35 */
> > >          /* padding: 4 */
> > >          /* paddings: 1, sum paddings: 4 */
> > >          /* last cacheline: 8 bytes */
> > > };
> > > 
> > > As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
> > > moved to the end, since it seems those three members should stick
> > > around together. :)
> > > 
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > > 
> > > This should probably include the following tag:
> > > 
> > > 	Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
> > > 
> > > but I'd like to hear some feedback, first.
> > 
> > I tend to agree given that:
> > 
> > On the one hand:
> > 
> > 1) in virtnet_init_default_rss(), netdev_rss_key_fill() is used
> >     to write random data to .rss_hash_key_data
> > 
> > 2) In virtnet_set_rxfh() key data written to .rss_hash_key_data
> > 
> > While
> > 
> > 3) In virtnet_commit_rss_command() virtio_net_rss_config_trailer,
> >     including the contents of .hash_key_data based on the length of
> >     that data provided in .hash_key_length is copied.
> > 
> > It seems to me that step 3 will include 1 byte of uninitialised data
> > at the start of .hash_key_data. And, correspondingly, truncate
> > .rss_hash_key_data by one byte.
> > 
> > It's unclear to me what the effect of this - perhaps they key works
> > regardless. But it doesn't seem intended. And while the result may be
> > neutral, I do  suspect this reduces the quality of the key. And I more
> > strongly suspect it doesn't have any positive outcome.
> > 
> > So I would lean towards playing it safe and considering this as a bug.
> > 
> > Of course, other's may have better insight as to the actual effect of this.
> 
> Yeah, in the meantime I'll prepare v2 with both the 'Fixes' and 'stable'
> tags.
> 
> Thanks for the feedback!
> -Gustavo
> 
> 


I agree. It looks like that commit completely broke RSS
configuration. Akihiko do you mind sharing how that was
tested? Maybe help testing the fix? Thanks!


