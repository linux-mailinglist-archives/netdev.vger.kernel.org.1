Return-Path: <netdev+bounces-286643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH7WCWnRAWryjwEAu9opvQ
	(envelope-from <netdev+bounces-286643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:54:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D60D50E481
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAFB5303D2E8
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA28390CA1;
	Mon, 11 May 2026 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0LRcqN4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnHpC4b+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455603630AD
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503589; cv=none; b=Dw0cYL48gVFPEwJ2E4bklmcURiwNM+uiW8M2wlXdIfkLOfxQRxb9Q99JWLUnFYIP9H2f3EPMM9rw25QOZl3OEY2kIqnOI5a6tz9tvO1BNyGeEuAYs4a6QMQkzc51/ox3HrWub/fFg4KOxxYDYRsxXuWAumXWsyvMAo3TWABiHms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503589; c=relaxed/simple;
	bh=Ugs/xjDpsbPmanWITKMhKdhwotw3HHy735HCKeIxttI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLCBaB0TeFRUAh2LdtQ7xApgHeiGoq76x1e1f9DhZ/rXgAP1TZhiNyrVxtobWg+fZwgjWuXQRcwUdqWuRX/BMM157OCX7S80UBNXyI/Alqvc95beYrHF7Et0FmjPjI7OI4wzoar4+7P8mmr9L5VgpReh0Fz9O1C5+GAFEfgI0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W0LRcqN4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UnHpC4b+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778503587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Xz/1zJ+MWlJ9Av9Kr7QaYQGfRn7oNzrnu40h3srvyM=;
	b=W0LRcqN4gs+qriITT1SBBCYAF8XmdmAqHbtHRjo3uf+IxcIkGa+Ael6YZdL7IlDaONSKrH
	rbaICpPr3YnxRt0gty1vhtP8pbI444BrJBY6Tx3/xicmB0QprEADnYMmSGLl9Tez66WRgb
	n6hsmJUL2n7+nkH+CvGYFknHB9oDHSg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-Gt1lpMv9Nna1b5HCnxG7LA-1; Mon, 11 May 2026 08:46:26 -0400
X-MC-Unique: Gt1lpMv9Nna1b5HCnxG7LA-1
X-Mimecast-MFC-AGG-ID: Gt1lpMv9Nna1b5HCnxG7LA_1778503585
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48e6af7a9cdso18585145e9.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 05:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778503585; x=1779108385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Xz/1zJ+MWlJ9Av9Kr7QaYQGfRn7oNzrnu40h3srvyM=;
        b=UnHpC4b+7TUffE5IDNk7xeMSjwd43jGXFzk27dViG4rr5UzG/qZhfZ0xmCoRIWNg3m
         csyybr9JbsWRzpVdpFVmAtPRwX81HdJRkfHZZ86AElC4UyyeTgTe4Tz18Nihz5h9CE8T
         7ld3BIjTK+lQCfMaMwa3m6hqdNTqrJ0GyFe6uH7C7PyPSekcXj9Jlc55tInX2gIuG/IZ
         lYlzo70cWp7D6GWlJfCsSL53Qa16iCxu6aATknXh8ElIWLK6g8gfr8f9SLrkg9UxZYN1
         FqYR+JZdNQXCz3kkQNk8A4Ie1335Ye4xU3B1qNVZUNO7na/irlrcha3En2KPGIacy68H
         2j/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778503585; x=1779108385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Xz/1zJ+MWlJ9Av9Kr7QaYQGfRn7oNzrnu40h3srvyM=;
        b=JM8zY174etJ+G4RmGsXVwaygmGJfsF5FFqGd3HUW7Pxypea/JOxuu+FhwZG0anE7U7
         35O62FPN/qAg7vyGHGor1QmrdsXQh/pPnpssEJUMXhaAREm8Pp/TpUr2g+Cmenf/8aN/
         qOX/eBPsr9nYeZtd2CEHc/O6lfkHvK6ojMx4xYQrk3bARE70up+coAYNTM1voiZVCpeT
         MweGpjhVOkY8R/I83d3+Y7MPqnsWNOoSl1oddHnQrcoGbqTdvN2sGNDFebePCoQqJZ48
         salY/KMFIe3nEYIC7fqDiidvId8Z2BbA15g64Igd7vp8QjIPMxHFvM8vSOTdlZndk1OG
         /Pjw==
X-Gm-Message-State: AOJu0YzJebWfIw1q2iGTTzzjxwnUFOCLwHJoKv3HqbXRKxzUWlYUwPhp
	QnekJc0vnS/04kMXltGa+qlXAAXukgJREVzybfM0Gw31y4oIcvoSz9mp7fgXCtvcBGKW+Sojj7T
	VWfN9lXWlzVfgnP6R7jsmssIXvdf9hAa+BL9KRd880lOwAuqUc4+aKMj6WNrAXVQVD2Il
X-Gm-Gg: Acq92OGG/N/hwBEa/9gXXhh8YMWqGsuVbk5afJeZlT3fdslwoYnxK0u+gmqOMOYomOy
	WqAg+nRUBN4ux3ns67u30p4G5RY8PsIvRHdWHpcL2yh8Ba3NQiTGAIiXKMY7jjhFXebs1EZoX0+
	V1aaNOzF35RlvB0M1BdeqWk7aypOI/EUQyiGgQrGPVfT0pkOr+5NqerDD0UhKozSI+V6Mlieuhg
	aBWFSC+Tg3rUqYlPCvoBfWS/AaPBEINz6XY9RLK2dS27y52CUrNmCE2JZ21DX14DAuC+nJpRwz7
	Ag8HVzOWISeq2fzYvO/exsB32shJt05l+FY/PvEb/iYoUpOYP47HJ9m0d4wFyI2AkBcs6yp0Jls
	1sj+lTCpaqeejvFMnCrp9DtqsqwW3FS0WYnN091RW
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-48e635a1b95mr271700065e9.2.1778503584618;
        Mon, 11 May 2026 05:46:24 -0700 (PDT)
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-48e635a1b95mr271699365e9.2.1778503584063;
        Mon, 11 May 2026 05:46:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d895781sm114542925e9.0.2026.05.11.05.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:46:23 -0700 (PDT)
Date: Mon, 11 May 2026 08:46:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <20260511084551-mutt-send-email-mst@kernel.org>
References: <20260508092330.69690-1-sgarzare@redhat.com>
 <20260508055125-mutt-send-email-mst@kernel.org>
 <af2y2Fyp7H-om-ur@sgarzare-redhat>
 <20260508063104-mutt-send-email-mst@kernel.org>
 <af28MAV0LF4qHVmB@sgarzare-redhat>
 <CAGxU2F65pw0P1uKOOJpBc4p6KjCz8iePEh9aPybUyECBm1=otg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F65pw0P1uKOOJpBc4p6KjCz8iePEh9aPybUyECBm1=otg@mail.gmail.com>
X-Rspamd-Queue-Id: 7D60D50E481
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286643-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 12:54:44PM +0200, Stefano Garzarella wrote:
> On Fri, 8 May 2026 at 12:38, Stefano Garzarella <sgarzare@redhat.com> 
> wrote:
> >
> > On Fri, May 08, 2026 at 06:33:13AM -0400, Michael S. Tsirkin wrote:
> > >On Fri, May 08, 2026 at 12:01:50PM +0200, Stefano Garzarella wrote:
> > >> On Fri, May 08, 2026 at 05:53:07AM -0400, Michael S. Tsirkin wrote:
> > >> > On Fri, May 08, 2026 at 11:23:30AM +0200, Stefano Garzarella wrote:
> > >> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > >> > >
> > >> > > After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
> > >> > > queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
> > >> > > buf_alloc when checking whether a new packet fits. This reduces the
> > >> > > effective receive buffer below what the user configured via
> > >> > > SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
> > >> > > silently dropped and applications that rely on the full buffer size
> > >> > > to deadlock.
> > >> > >
> > >> > > Also, the reduced space is not communicated to the remote peer, so
> > >> > > its credit calculation accounts more credit than the receiver will
> > >> > > actually accept, causing data loss (there is no retransmission).
> > >> > >
> > >> > > This also causes failures in tools/testing/vsock/vsock_test.c.
> > >> > > Test 18 sometimes fails, while test 22 always fails in this way:
> > >> > >     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
> > >> > >
> > >> > >     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
> > >> > >     Resource temporarily unavailable
> > >> > >
> > >> > > Fix this by introducing virtio_transport_rx_buf_size() to calculate the
> > >> > > size of the RX buffer based on the overhead. Using it in the acceptance
> > >> > > check, the advertised buf_alloc, and the credit update decision.
> > >> > > Use buf_alloc * 2 as total budget (payload + overhead), similar to how
> > >> > > SO_RCVBUF is doubled to reserve space for sk_buff metadata.
> > >> > > The function returns buf_alloc as long as overhead fits within the
> > >> > > reservation, then gradually reduces toward 0 as overhead exceeds
> > >> > > buf_alloc (e.g. under small-packet flooding), informing the peer to
> > >> > > slow down.
> > >> > >
> > >> > > Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> > >> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > >> >
> > >> >
> > >> > unfortunately, this is a bit of a spec violation and there is no guarantee
> > >> > it helps.
> > >>
> > >> Loosing data like we are doing in 059b7dbd20a6 is even worse IMHO.
> > >>
> > >> >
> > >> > a spec violation because the spec says:
> > >> > Only payload bytes are counted and header bytes are not
> > >> > included
> > >> >
> > >> > and the implication is that a side can not reduce its own buf_alloc.
> > >> >
> > >> > no guarantee because the other side is not required to process your
> > >> > packets, so it might not see your buf alloc reduction.
> > >> >
> > >> > as designed in the current spec, you can only increase your buf alloc,
> > >> > not decrease it.
> > >>
> > >> We never enforced this, currently an user can reduce it by
> > >> SO_VM_SOCKETS_BUFFER_SIZE and we haven't blocked it since virtio-vsock was
> > >> introduced, should we update the spec?
> > >
> > >
> > >it's not that we need to enforce it, it's that all synchronization
> > >assumes this. as in, anyone can use an old copy until they run out
> > >of credits.
> > >
> > >
> > >> >
> > >> > what can be done:
> > >> > - more efficient storage for small packets (poc i posted)
> > >> > - reduce buf alloc ahead of the time
> > >>
> > >> That's basically what I'm doing here: I'm using twice the size of
> > >> `buf_alloc` (just like `SO_RCVBUF` does for other socket types) and telling
> > >> the other peer just `buf_alloc`.
> > >>
> > >> But then, somehow, we have to let the other person know that we're running
> > >> out of space. With this patch that only happens when the other peer isn't
> > >> behaving properly, sending so many small packets that the overhead exceeds
> > >> `buf_alloc`.
> > >>
> > >> Stefano
> > >
> > >what is "not proper" here, it is up to the application what to send.
> >
> > Sure, but here we're just slowing down the application by telling it we
> > don't have any more space.
> >
> > Again, without this patch we are just dropping data, which IMO is even
> > worse.
> >
> > So I think we should merge this for now, while we handle better the EOM.
> > If you prefer, I can drop the part where we reduce the buf_alloc
> > advertised to the other peer, but at least we should drop data after
> > `buf_alloc * 2` IMO.
> 
> Okay, I thought it over over the weekend, and I agree that this patch 
> still doesn't solve the problem and would still result in packet loss.
> So, until we resolve the issue permanently, and since 059b7dbd20a6 is 
> coming to stable, I'd like to rework this patch so that we only start 
> dropping packets when the overhead plus the queued bytes exceeds 
> `buf_alloc * 2`.
> Removing the other changes to reduce the buf_alloc advertised, but 
> terminating the connection so that both peers are aware that something 
> went wrong.
> 
> Any objections?
> 
> Stefano

Let's try to first fix it upstream properly please. Discuss backporting
later.

-- 
MST


