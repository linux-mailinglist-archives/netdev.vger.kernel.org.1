Return-Path: <netdev+bounces-289372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOggIo8zDGrdZAUAu9opvQ
	(envelope-from <netdev+bounces-289372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:55:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC9957BB01
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 041703032E59
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AF84657E5;
	Tue, 19 May 2026 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0heET/Z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9lsd7cd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD5D44BCA8
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184183; cv=none; b=auozSWKBvYlRazQFcpg2JohsFbgn25mGr6XQKU7EBkgBz4U4RwXW4IAw4KjtKalSaB+xaAaJe/5QUZht7i8I4LzGbo0CQC6ph/Xz3HZe2Nd+R+Vas5CCY/nuhfT/6yBO5M7baEE1MhsHj6NJT8COz8BrT0CIrTdCPAr399w6GPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184183; c=relaxed/simple;
	bh=A3kYDVRcCv+l5IYdjIvqMz4NtZd1ehaoUU/Tc+OxqTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4z0okshYO24uSkPjdYr+lCXdS0/Nqlvl5tFRydg05qUTxX30tEbiO97sxij44OaS35Rg4PC70wn4alyjk5athwOrZuw+L/znb9P7xM1TApV3dv8sP2/rDKU93gSqiVTh96p6xsXrN+vIPtE/9xY7gWttinBFVFMdYxAZ+kr21o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0heET/Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9lsd7cd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779184180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zj2k4OlZU7xwNJcXmWQpbVh/b6JWeCsbljlDYkhC2cc=;
	b=M0heET/Z+kggfrXdhnLXocESv95SAULrGRU/fv1PkQbnrjuCmgnH82QMx7zKT9peOFNgRV
	pVxLxrC3lL6g/btH61xXctxGcbiNKZJsycRCjzJcRsrLV+ihihH7CsdOu4oMv7o5AOq3kR
	O4K7aoKXn2lFsgTnzZdHNFFuDp1Ya4U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-bfRnleiNNEqWiNSyna7iWg-1; Tue, 19 May 2026 05:49:39 -0400
X-MC-Unique: bfRnleiNNEqWiNSyna7iWg-1
X-Mimecast-MFC-AGG-ID: bfRnleiNNEqWiNSyna7iWg_1779184178
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44a52d5e572so2624633f8f.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779184178; x=1779788978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zj2k4OlZU7xwNJcXmWQpbVh/b6JWeCsbljlDYkhC2cc=;
        b=K9lsd7cdgFvdEggg6qdA5b7M7ERg8BNcPgqVBYKd5v1gG0IwrtvLwUl5F2qeNCNKqj
         rBDO7BdZwt7kvnL7RtZPjrVf9Rg++GN/AEQG/AICVDXhzZ7FMBA8ylDnA34Jit6MMMTS
         U76T78cFHa/77CNBrnx0vd7QFqLJ+JfbADVowqBvmS42C4IHZd1VZRsE06k/+dJTKetn
         HRPnW1BVMm8tApi/rVZysro0BFS9TtUcyoHZLnFRyGwt9SUS/5+VJgzCNudYiSnbfL6G
         xTBCdJGmVG8CGFXIjBBkflYO0Cd06XZpFstQRj2O45iJ8Vj/toeoLgq+wvl9CV26gqCd
         0ZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779184178; x=1779788978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj2k4OlZU7xwNJcXmWQpbVh/b6JWeCsbljlDYkhC2cc=;
        b=n5r8IAQw9OkQ0MWgoKQNjmXIoM50/kJQxqPkyM2HIORwx41TcZOEtgNSM36fKZSTXY
         NzELBE5fX5+QpRwsHByef+UGuhNUuVY1yK5GMcIgM1ZObpMrBF4CJF7bt8+2ptsWy1oZ
         FQiADUih1OpkfqtvRRRpdCqxr+6w/xz26Qonw6wXUi2X+UOTaPs+0KruXdg/AZ5HJZkb
         WUJJgVppSb+3VvLOofSvtuHVxC5nO0d2sgRCTZCYkoXa3BKztEfHhBP4QSoUW9q/U5TU
         mrSNHcFkQWNBsO4H/o+loTiBQ0IJs2tew/NMa0XnYbKK6Fmz5Hbjpgfjm0rIWVruQ5v1
         DpnA==
X-Forwarded-Encrypted: i=1; AFNElJ+M5bEDwXropDAyzrcjE6skKWqlZn+VwvGMKPyBBl/BMzVAlBsi9xsd30aa+FHD+36c1kRzvNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzQi+lc4eyqcRraanLkA4ESjVdoziIK3OcFGffBuaAlTnWgpiB
	YlKqLkBFl5VBTbkZdLzpjsvyyoXyPfvCSAFtj4vNTSSLY8DxZiQA3sy3f9WvftcU6UqprHQsLKZ
	neEHajWuVLkU2uPX7M9OZpDkCrkKQJqinETE6iLz1fikoHSluZKWr1vdVNw==
X-Gm-Gg: Acq92OH7x1KpBQa3RZhpWuVDu20dK16D96nRQoMew1qrk9zVt8qRn1kSeLZjbLIFAAE
	vs03pxfvUABYbDCMEVH5dOaMkSjlJMeAZmisAluZ7R4rAueiZ5vKS7VbRSu0YalFDmAMtIeDIwZ
	GG+Q3zaxQ+NnTeaskRpFhvFcBZUqZju6F1m0ShaBJ0hErG+j93//73eRAOzx/6qT8/L23tx3HI2
	N6QUawehezaJUlVRl3Jy4Kl5JFFmbGWWjoy0oy7RaDCIVX20ixE/Nj1i157wBjTtdj+lSykZsG4
	sf8XrOWpg3COA+vFcU8kFs3UAk7pKyeCZ5OqhYrPE9YQSKu4mo9Biqg3IZaO8xLT1bJs7z2m/dj
	OLlHhP3xeB7o+VEnHKoZy6CNrLCWdSeGDlkvrMxsS9bQ1XSm3ukgXOSv5laXQXGGo7ZdU6/1HWi
	TjAr+NEQ2z
X-Received: by 2002:a05:600c:4e55:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-48fe60e510bmr285210305e9.5.1779184178084;
        Tue, 19 May 2026 02:49:38 -0700 (PDT)
X-Received: by 2002:a05:600c:4e55:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-48fe60e510bmr285209745e9.5.1779184177542;
        Tue, 19 May 2026 02:49:37 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5cab7c5sm334163125e9.12.2026.05.19.02.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:49:36 -0700 (PDT)
Date: Tue, 19 May 2026 11:49:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: David Laight <david.laight.linux@gmail.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, 
	Maher Azzouzi <maherazz04@gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb
 sends
Message-ID: <agwwxuQlIWjwXtMN@sgarzare-redhat>
References: <20260514092948.268720-1-sgarzare@redhat.com>
 <20260516125329.7b699c6f@pumpkin>
 <agrXvCtNRlySlwgx@sgarzare-redhat>
 <20260518053223-mutt-send-email-mst@kernel.org>
 <agrg1GVzoJWtNuSd@sgarzare-redhat>
 <20260518115005.5f13bd2b@pumpkin>
 <20260519053951.1C60440015@mx4.sberdevices.ru>
 <aea2227c-3011-4457-b909-d16de1596a6d@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aea2227c-3011-4457-b909-d16de1596a6d@salutedevices.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289372-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,kernel.org,google.com,linux.alibaba.com,lists.linux.dev,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2AC9957BB01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 09:37:23AM +0300, Arseniy Krasnov wrote:
>On 18/05/2026 14:08, Stefano Garzarella wrote:
>> On Mon, May 18, 2026 at 11:50:05AM +0100, David Laight wrote:
>>> On Mon, 18 May 2026 11:54:19 +0200
>>> Stefano Garzarella <sgarzare@redhat.com> wrote:

[...]

>
>Hi guys! Just some replies after quick look:
>
>>>> >> > Surely that block should only be done if can_zcopy is true?
>
>I guess no, since TCP also allocates uarg even if zerocopy is impossible -
>it just sets uarg_to_msgzc(uarg)->zerocopy = 0;
>
>>>> >> > And shouldn't something unset it if info->op != VIRTIO_VSOCK_OP_RW ?
>
>Hm, we can't enter block 'if (info->msg) {' when 'info->op' is not equal to 'VIRTIO_VSOCK_OP_RW',
>because 'msg' is not NULL only for 'VIRTIO_VSOCK_OP_RW'. But anyway You point to right thing - check for
>'VIRTIO_VSOCK_OP_RW' could be removed here. Just with comment why.
>
>>>> >> > If the msg_zerocopy_realloc() fails then can't you just set can_zcopy to false.
>
>Here I guess it is better to follow TCP way to make same behaviour, because exact
>logic for MSG_ZEROCOPY is not documented. TCP also returns error and stops tx loop.
>
>>>> >> >
>>>> >> > It info->msg->msg_buf is already set then I think you have to disable zero-copy.
>>>> >> > The caller has already requested a callback - and you can't add another.
>
>In TCP implementation if 'msg_ubuf' is set they just use it and check for zerocopy in
>the same way as 'msg_ubuf' is NULL.
>
>>>> >> >
>>>> >> > In any case by the end of this can_zcopy and have_uref are really the same flag.
>>>> >>
>
>Need to check it more. But 'can_zcopy' means that we fill frags in skb, have_uref means that we
>allocated completion (but it could be reported with not set 'SO_EE_CODE_ZEROCOPY_COPIED' if
>'can_zcopy' was false).
>
>
>@Stefano, I guess current implementation differs from TCP in two cases (at least from first
>view):
>1) When 'msg_ubuf' is set: in TCP, already set 'msg_ubuf' is passed to 'skb_zerocopy_iter_stream()'
>   (if zerocopy is possible) where it is used as in vsock in call 'skb_zcopy_set()'. In vsock case if
>   'msg_ubuf' is not NULL we will pass just NULL to 'skb_zcopy_set()'. Yes this is will be
>   no-effect call today (due to checks in 'skb_zcopy_set()'), but anyway - in future may be not.
>2) Also i see that 'skb_zerocopy_iter_stream()' in TCP version has some 
>extra checks which are
>   missed in vsock - we only just call '__zerocopy_sg_from_iter()' to fill skb in zerocopy way.
>
>But, I think, instead of trying to compare vsock and TCP versions best way is to just copy
>current TCP flow as close as possible:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/net/ipv4/tcp.c#n1144
>1) Use same flow of checks for 'msg_flags', 'msg_ubuf', SOCK_ZEROCOPY etc.
>2) To copy data we can use 'skb_zerocopy_iter_stream()'.
>3) The only thing that we don't need in vsock is dev mem related code from TCP implementation.
>
>I can take this task, but pls need some time - may be two/three weeks due to another tasks.
>
>What do You think?

If you can work on it, please go head. They seems all pre-existing, so 
2/3 weeks are fine. Please let me know if you can't and I'll try to 
allocate some time.

Thanks for the help!

Stefano


