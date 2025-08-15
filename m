Return-Path: <netdev+bounces-214029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60654B27E22
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 12:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C590A2442B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 10:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DD22FD7B1;
	Fri, 15 Aug 2025 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieKanSU3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F82FCC07
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253386; cv=none; b=HM79edUTie/v/+atQ1RniIPs+PdcEXlOGxJrsC/IaQ+4eTNdXcJhFE7nFa9HvgIkhlIFFh+w2LB+ELQyxw/sBflS2z6KsuJV35WEf73uZRlwOM5lv9tz0K05X3VsaL+CoyTGOcDbxxnygWypohwQMdi+Dq2om9oyEbZiWgeu0ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253386; c=relaxed/simple;
	bh=WE1rN9CQDbCOvNfVAG7gWcd5KU32gMMFHCTSQAiwbWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDMHmqA/07QPIqNZF7hcyFqKdmTgFeIdPmTeDFERjtZvavUGH+o9rUtbruccJmAZ41mV13aZ//JQrYYpF2le4/vxt9TiDd1Q2tWFjRyo/XrYxN4v2KadIFYCKG5QF/S8ocEYcNhCz5z7vUsjC5CfaIrVU3VRBMlUhbqtBu3aEbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ieKanSU3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755253383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mXZQB1LE0AtxSpGbCGCAth6SRq5k5i0cLzQs1mJzr8w=;
	b=ieKanSU3UdiYuMj+T5TZDX/Cp46ICWPqbsLytf5ZcDkwa2+3xZ/w3K3Hv4lAKNXw28wS8Y
	v+V7R59JwkLAfq+N/F4bx2+LXQBIh0VTENMDoTUCwDCDeNQJbrnIk3EttBoHOO0qNRnBG9
	Ok1PCBN5FUNTyrCsypBh9SvuThzX5gQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-YgOBU-hlOdyeTdDRiZLuug-1; Fri, 15 Aug 2025 06:23:01 -0400
X-MC-Unique: YgOBU-hlOdyeTdDRiZLuug-1
X-Mimecast-MFC-AGG-ID: YgOBU-hlOdyeTdDRiZLuug_1755253381
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9e4146aa2so938657f8f.2
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 03:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755253381; x=1755858181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXZQB1LE0AtxSpGbCGCAth6SRq5k5i0cLzQs1mJzr8w=;
        b=YP1OVx86A61QVtJ+3mFeX0q0iJovvcvC6efZlUf0tBKlxJ9R+OnnNE6wpcCsBDgSIQ
         bVFcfOe5eItihwprPFlB1rQiLnQbBb1ra0VXa9R1Mu/AVeWIU0WwNIM+tW3LK4Ht5Z+n
         gNmFA93TL7uIhxeS035Qy3WH3mUs16kl+E+pWqzfIwvu+npun/XuzYyfbwQzAVf1NicQ
         44EXbZ3my13T1wekjZqqUXn96FO7TD5vpxq9AQSRlDMrNOI8Aok+euaSEO8CXzIMVPIX
         Z1Kyf2O5epEr9wQz2sG4HqKLOu4zVCVWod/9w7vE0ukwTE1pxGe/GwM+qOLnX3lkR1DZ
         LhaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+ExWVUHYfCpODFHYe8gk9Z4VbF0WpR1L/kqGo2hMwoia8FVvzctzHa5yi6azKfm/kblQrQD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqasaRP2XSCtnTZXYXjqvMz6gAeaMExqqhP+XJCsYYNjktO/ah
	2qYabOFN7ewYmF7eLMaUvSz8HKQC0iaY7jDT7T7uM2B/odfmCw9y0CRoL1WAEjXzurjxL9JGvTZ
	GwdI6h7JR1OQPbWE4aNTsBzV5PAwEaRa5dqpio9exCYwzT1YYMVC5i8kRag==
X-Gm-Gg: ASbGnct2sPOubztqYt02vId47zXxTOCePZI0dGv8W/gBKFTVS2+h+a0YSK0Krdnmn4t
	ktXxpJrb+pNhmQHTMQcG+T53Egg/+/UNqFYcPyj+aP1uqVSK6kCjk5UlbjQDDA+g62N8mkqwW5h
	4mtyP3AUfCnAeA805E2RnkUKAqQ1vrbMl9MiI89jHeJ75tYxF4RQ1fxsNJxxsXXfI1uScyORVPP
	UC6gFtorsNyxer63e2c9kLmcSlCtVZBqpCKZZ/tZYxYOHCWYDk44yKbkmIEXaRXoBWT/Qb3Uh/c
	L0wO6Ap6fS1FfG+o0nv0hmi8S5k2FNRNaTk=
X-Received: by 2002:a05:6000:26c3:b0:3b8:d08c:cde5 with SMTP id ffacd0b85a97d-3bb68fdd70bmr936460f8f.43.1755253380602;
        Fri, 15 Aug 2025 03:23:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXcWSGeWgeyeaq8Y6Kdy9hPI87jT5jAViHEaJ65V0tcueR2T7DgVvat00CErWZfwSwgGPjEA==
X-Received: by 2002:a05:6000:26c3:b0:3b8:d08c:cde5 with SMTP id ffacd0b85a97d-3bb68fdd70bmr936446f8f.43.1755253380209;
        Fri, 15 Aug 2025 03:23:00 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73cf:b700:6c5c:d9e7:553f:9f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a223197fbsm14231915e9.8.2025.08.15.03.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 03:22:59 -0700 (PDT)
Date: Fri, 15 Aug 2025 06:22:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v4 9/9] vsock/virtio: Allocate nonlinear SKBs for
 handling large transmit buffers
Message-ID: <20250815062222-mutt-send-email-mst@kernel.org>
References: <20250717090116.11987-1-will@kernel.org>
 <20250717090116.11987-10-will@kernel.org>
 <20250813132554.4508-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813132554.4508-1-hdanton@sina.com>

On Wed, Aug 13, 2025 at 09:25:53PM +0800, Hillf Danton wrote:
> On Wed, 13 Aug 2025 04:41:09 -0400 "Michael S. Tsirkin" wrote:
> > On Thu, Jul 17, 2025 at 10:01:16AM +0100, Will Deacon wrote:
> > > When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
> > > virtio_transport_alloc_linear_skb() to allocate and fill SKBs with the
> > > transmit data. Unfortunately, these are always linear allocations and
> > > can therefore result in significant pressure on kmalloc() considering
> > > that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
> > > VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
> > > allocation for each packet.
> > > 
> > > Rework the vsock SKB allocation so that, for sizes with page order
> > > greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
> > > instead with the packet header in the SKB and the transmit data in the
> > > fragments. Note that this affects both the vhost and virtio transports.
> > > 
> > > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > 
> > So this caused a regression, see syzbot report:
> > 
> > https://lore.kernel.org/all/689a3d92.050a0220.7f033.00ff.GAE@google.com
> > 
> > I'm inclined to revert unless we have a fix quickly.
> > 
> Because recomputing skb len survived the syzbot test [1], Will looks innocent.
> 
> [1] https://lore.kernel.org/lkml/689c8d08.050a0220.7f033.014a.GAE@google.com/


I'm not sure I follow that patch though. Do you mind submitting
with an explanation in the commit log?


-- 
MST


