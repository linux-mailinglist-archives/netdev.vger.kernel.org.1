Return-Path: <netdev+bounces-286617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL8zH4i1AWr2igEAu9opvQ
	(envelope-from <netdev+bounces-286617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:55:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2391750C4F4
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62433300D341
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C873DB64D;
	Mon, 11 May 2026 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOcR0HU2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMMNIoRT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA4E346E5A
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496899; cv=none; b=lmKAhWLGzRl+1RAIfFMGpBk13yPjwfkgeqt/DjXjt99vzgxYdxtkNOSLUNHjEOgB+FhCf+jR/UznX4O463yhRN3orqDR0Df0hGraqesGSx53pXsB6jrcXKyijq/NJn/+bKKcrQgxYpkSwJW2DL88hetkVOYmIPUoike1W0bUgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496899; c=relaxed/simple;
	bh=V8eg8l9LTNxtrgGj41tiN9oiWfET/lpJ8WKuJ9lm5aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALnCLa1Qhjjp6HTCsjSZ1z6H6od6bg3danLLyzw6H13uxIvRPbOk/v/No5mviZ5FjEXHafIYL7iyOv+SNiiVfEXyUphB7smDdEJHZ78Zgz4XC/rKwS0QIWsyyg3XLOsJDEPQZmpFHDUUhPdi2cOax2ZyrVIORDuzbSwMYXxtR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOcR0HU2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KMMNIoRT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778496896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DNWy/CV2WRe1jDYLvFjqxiC49eSLSSASB8hrdzj5ZF0=;
	b=cOcR0HU2c2KM+Rj99XNjcn47AKPmN3ndK2tYcblXyomIRx5Uq6/SAorL6MJmhq15T8KWCq
	06eEOtDQ/t8MKwy/z7luA6jwXht64X1QtTgPkAl29opaofQ5N+TniqxtU7iz/d/y4ioIu2
	pWNUwKU7KZlVLXAEUBWabLuFtkXabZI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-j8VcLkpONzCc5cy-9PNenw-1; Mon, 11 May 2026 06:54:54 -0400
X-MC-Unique: j8VcLkpONzCc5cy-9PNenw-1
X-Mimecast-MFC-AGG-ID: j8VcLkpONzCc5cy-9PNenw_1778496894
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44d68ed8f95so3294255f8f.1
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 03:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778496893; x=1779101693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DNWy/CV2WRe1jDYLvFjqxiC49eSLSSASB8hrdzj5ZF0=;
        b=KMMNIoRTQ1PE3gjeGqNAwP/J1pMAWDx+BowNVLLFEDY4LQoH1c4Lue50VvtgPHQv6r
         f/ETmP/Jud2ekBAHWSr80AMdN5ypGD/V1m64+/g3NgruP1ECxwg84ZAV6IAAgrMrSG4o
         Xz70/pqc+zxLLdY+UxiEl7gdlydlhNg3wqen/nOEysQrR82YExlknSWP3o6C0O6Eh/3R
         1dxSjtuZIA574WVueyGZ/YXexVfs8wvOI9IF6LvWNEAKxVuq4z2oUyD5wmoZL084sslf
         rsW4y6q+jYHBH1tZKCRum07XqXiobUyrf5At6NKl0/fwufpdvTk5iGnUUQSFImrOwC2B
         UX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778496894; x=1779101694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNWy/CV2WRe1jDYLvFjqxiC49eSLSSASB8hrdzj5ZF0=;
        b=D78WPc/fJXOGFj3ASSW1/jFRD4SPTotu6Qx3tQROT7oHAANSeBA91eFUSNuwuQMSMQ
         bedHn4vkD/zfNHjbESialeBeUaFNH+JKKbvcqIjdzlUQ3k34JmHF9hNrGiX4r9aX+pXC
         FxkgmZc2Hnx9L+mZbEz3+GjKvmE5zDERv+tj7G7ZADGbl6Mqncdr9l0a5mWN5htyk2ml
         nF6XK/2y97asNpo9AHkPfUHZjhZKTnqYAh9sZf2exfOIs/Z93z+92O6gln1mwU8UmvIg
         nyCOzeZxW3w7KbTcIGvYHgyAyJL4NQEuOVJxsxISsf4CBilkoyq8v/BRuU3Huly2xqVp
         TIhA==
X-Gm-Message-State: AOJu0YzepTBMLMf/RYFcbgUdiL7E0JmlJkNm4jnHarpk1BgeYmOqPuPY
	UmSSWqWxvh0I141yIs7WV77mxTSzLfLapeg5S395OCbb7l2gXZye14ttctYinfU3dqTVu4C61Bk
	CIT/2NPJK7KHMksJPU86ecFypppSV2ijpS/am5B1K+WR5zc04VvtOZgdVpw==
X-Gm-Gg: Acq92OEKHDsQ/hhvUHFu/+v9a94Ou7A6OdgnYZgxe5Zj0vXGG0XwFEDs0AMSyJ/8obq
	vw4D8zApfxOLTMFgFaSlIUNFWkUDTz9FRWF90X3w5QPrG8iPVbq6AwSadNagkuQ4MCd8Z7CISQ5
	gCVkmhhusjiseNNMvK458EqmLb83WphlQr3oV29115RMsoxc4jyA0eH7Nxb9O+uO44+G82Y6rro
	HhOTN/IoMN1mJp3FvsSTbIvFwB2+NW9P120kg4RC1jICazIUYz0YUVCZD9kFy9obI+yUwKTGXPT
	z2UpJwvYLU84iYtXD8YIHclD8ocNwKhH8vyriGo5Rmk9QlaAuHbx9CfAMuAuQ8rfn57xGlRYr+/
	RH+jGcSKIhpNFxnO3poSIZuuv2qJHvIMTxE47/ilR4aU81LADdMqipeZJ9ufr4Z8ruZBc9zQztr
	fPnWDbhVJ5
X-Received: by 2002:a05:6000:270f:b0:457:d27e:e4ee with SMTP id ffacd0b85a97d-457d27ee505mr6306189f8f.8.1778496893562;
        Mon, 11 May 2026 03:54:53 -0700 (PDT)
X-Received: by 2002:a05:6000:270f:b0:457:d27e:e4ee with SMTP id ffacd0b85a97d-457d27ee505mr6306143f8f.8.1778496892956;
        Mon, 11 May 2026 03:54:52 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6cd75sm23669841f8f.16.2026.05.11.03.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 03:54:52 -0700 (PDT)
Date: Mon, 11 May 2026 12:54:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <CAGxU2F65pw0P1uKOOJpBc4p6KjCz8iePEh9aPybUyECBm1=otg@mail.gmail.com>
References: <20260508092330.69690-1-sgarzare@redhat.com>
 <20260508055125-mutt-send-email-mst@kernel.org>
 <af2y2Fyp7H-om-ur@sgarzare-redhat>
 <20260508063104-mutt-send-email-mst@kernel.org>
 <af28MAV0LF4qHVmB@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af28MAV0LF4qHVmB@sgarzare-redhat>
X-Rspamd-Queue-Id: 2391750C4F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286617-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, 8 May 2026 at 12:38, Stefano Garzarella <sgarzare@redhat.com> 
wrote:
>
> On Fri, May 08, 2026 at 06:33:13AM -0400, Michael S. Tsirkin wrote:
> >On Fri, May 08, 2026 at 12:01:50PM +0200, Stefano Garzarella wrote:
> >> On Fri, May 08, 2026 at 05:53:07AM -0400, Michael S. Tsirkin wrote:
> >> > On Fri, May 08, 2026 at 11:23:30AM +0200, Stefano Garzarella wrote:
> >> > > From: Stefano Garzarella <sgarzare@redhat.com>
> >> > >
> >> > > After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
> >> > > queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
> >> > > buf_alloc when checking whether a new packet fits. This reduces the
> >> > > effective receive buffer below what the user configured via
> >> > > SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
> >> > > silently dropped and applications that rely on the full buffer size
> >> > > to deadlock.
> >> > >
> >> > > Also, the reduced space is not communicated to the remote peer, so
> >> > > its credit calculation accounts more credit than the receiver will
> >> > > actually accept, causing data loss (there is no retransmission).
> >> > >
> >> > > This also causes failures in tools/testing/vsock/vsock_test.c.
> >> > > Test 18 sometimes fails, while test 22 always fails in this way:
> >> > >     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
> >> > >
> >> > >     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
> >> > >     Resource temporarily unavailable
> >> > >
> >> > > Fix this by introducing virtio_transport_rx_buf_size() to calculate the
> >> > > size of the RX buffer based on the overhead. Using it in the acceptance
> >> > > check, the advertised buf_alloc, and the credit update decision.
> >> > > Use buf_alloc * 2 as total budget (payload + overhead), similar to how
> >> > > SO_RCVBUF is doubled to reserve space for sk_buff metadata.
> >> > > The function returns buf_alloc as long as overhead fits within the
> >> > > reservation, then gradually reduces toward 0 as overhead exceeds
> >> > > buf_alloc (e.g. under small-packet flooding), informing the peer to
> >> > > slow down.
> >> > >
> >> > > Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> >> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> >
> >> >
> >> > unfortunately, this is a bit of a spec violation and there is no guarantee
> >> > it helps.
> >>
> >> Loosing data like we are doing in 059b7dbd20a6 is even worse IMHO.
> >>
> >> >
> >> > a spec violation because the spec says:
> >> > Only payload bytes are counted and header bytes are not
> >> > included
> >> >
> >> > and the implication is that a side can not reduce its own buf_alloc.
> >> >
> >> > no guarantee because the other side is not required to process your
> >> > packets, so it might not see your buf alloc reduction.
> >> >
> >> > as designed in the current spec, you can only increase your buf alloc,
> >> > not decrease it.
> >>
> >> We never enforced this, currently an user can reduce it by
> >> SO_VM_SOCKETS_BUFFER_SIZE and we haven't blocked it since virtio-vsock was
> >> introduced, should we update the spec?
> >
> >
> >it's not that we need to enforce it, it's that all synchronization
> >assumes this. as in, anyone can use an old copy until they run out
> >of credits.
> >
> >
> >> >
> >> > what can be done:
> >> > - more efficient storage for small packets (poc i posted)
> >> > - reduce buf alloc ahead of the time
> >>
> >> That's basically what I'm doing here: I'm using twice the size of
> >> `buf_alloc` (just like `SO_RCVBUF` does for other socket types) and telling
> >> the other peer just `buf_alloc`.
> >>
> >> But then, somehow, we have to let the other person know that we're running
> >> out of space. With this patch that only happens when the other peer isn't
> >> behaving properly, sending so many small packets that the overhead exceeds
> >> `buf_alloc`.
> >>
> >> Stefano
> >
> >what is "not proper" here, it is up to the application what to send.
>
> Sure, but here we're just slowing down the application by telling it we
> don't have any more space.
>
> Again, without this patch we are just dropping data, which IMO is even
> worse.
>
> So I think we should merge this for now, while we handle better the EOM.
> If you prefer, I can drop the part where we reduce the buf_alloc
> advertised to the other peer, but at least we should drop data after
> `buf_alloc * 2` IMO.

Okay, I thought it over over the weekend, and I agree that this patch 
still doesn't solve the problem and would still result in packet loss.
So, until we resolve the issue permanently, and since 059b7dbd20a6 is 
coming to stable, I'd like to rework this patch so that we only start 
dropping packets when the overhead plus the queued bytes exceeds 
`buf_alloc * 2`.
Removing the other changes to reduce the buf_alloc advertised, but 
terminating the connection so that both peers are aware that something 
went wrong.

Any objections?

Stefano


