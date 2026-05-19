Return-Path: <netdev+bounces-289352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIyhFkMtDGq0XwUAu9opvQ
	(envelope-from <netdev+bounces-289352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:28:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF3357B4B4
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0CA6302E1CA
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840763F8707;
	Tue, 19 May 2026 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rucx+pmH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qp5g2XXc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2033F86E7
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182884; cv=none; b=jFn6U42TH00bwGH7KnCXBrPP1fSj/HN3okCQ6TXA5A7SYHkB+ecxbdc3cmnlv5oaTqZp06IGgLCt21TyQI4ztx/QNYpX8vNwe+SU1VqqT5TQVW6Dm/IOU2I2OsdxztsUuLeD+aWTQFjtUYFI/sDluzN1eqBSGQ6aFk2YaFz40RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182884; c=relaxed/simple;
	bh=uDEw9No4oP0gv6j/Ado3aaG16haNPWRnDa/SWjuSB2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u71nI3KNC6HSEIMKhoXVHIDXynqEjezsNOhzCHaryJMIGtN3l7QUsXTcBMtXkjNnWXmzbi3RBwKRd9HSRP03gjzZ7UmwOlOBP2xQyob6cxvvIW//RiWm6jYbmnF3oy5giEO8ECDZCwGRLmYQUBojRT7kK1EAuPnLiMIz2xMjjcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rucx+pmH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qp5g2XXc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779182878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3kq5cy4odtanFj4ZmmMjmdUGGp4uB2ZhMg4n7iuzQNs=;
	b=Rucx+pmHvPJcnVky4WdCn6zFhXmdA9HX3+JK+9KSdl6zP5nEK1AjjDnU0U5vGGafE+hyl+
	8TBZv9u+3ycWKPwbN4RvzMlJcg84QxnBeeyWtGWT17zBiohLSwQRbiR3emZgltqwFt0zon
	2YeTi6dODujQQLb+6AvBxwDiP7mm5rw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-DBY923sIO7yh3qZMjj_S7w-1; Tue, 19 May 2026 05:27:57 -0400
X-MC-Unique: DBY923sIO7yh3qZMjj_S7w-1
X-Mimecast-MFC-AGG-ID: DBY923sIO7yh3qZMjj_S7w_1779182876
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45e81291d62so1625470f8f.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779182876; x=1779787676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3kq5cy4odtanFj4ZmmMjmdUGGp4uB2ZhMg4n7iuzQNs=;
        b=Qp5g2XXcUW5pzt09Ok1DfcXRCqJOSLPS5Ths9SasBz3va0oZXd96CZJiWEnmmTg5ju
         ulT2vzEKejVy2Ybn3f0FTNm33XADihQGTYChOCTEjAIbH8+J8EQJgQ9h8lco/13ofs+h
         neQVPFURGpFYz/Ggzut/7i0wVxgWOGbt0VW8ZsdO0Ya5BTr5cRQJt+BiEqPJMzOsSJKz
         0qOUv6tejOWJfPmqENslLKQMINFZ6YdKWrtdVhIq4Rl8bQTNN97dymbC6xFrTRoZcpEX
         FLlqILASe6JlPlEQ8ORNJ6KyMtqvF9P8mYdDO2MHjfqYUfU+OHhjLNpXAsfBCjuV18Rz
         xHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779182876; x=1779787676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kq5cy4odtanFj4ZmmMjmdUGGp4uB2ZhMg4n7iuzQNs=;
        b=DSavCo7rscS09ECDnWAH59egV3hxuuNLnGfR2HII5+/B0LpxhXNclumoBwOW9oJfAy
         xe3+Vr0D6S3ykcvtD9WpPClxWKixnby5o03HmRWhmibwjs/752Tf8/HVbYVVXOjHXPDj
         vEGYSF+Tv/3v4at90E/edmxEv5Vfyin1fEgbRc4ZX1z/IkszJtOjkRaTWg5tqiNBqJ+O
         LQLuIw20NYhcqs6JOdVRuG5yWj0tcAmtq1ppjGLpRygQdkaMiWx9X8dh1ug8kBzVQCm8
         6m/APEvegq0DFBKJbi1WpKAT1GHQbGtStFqY0pPSeLqkA2ne/mPVW8AFW1D/Nebi6CCM
         IgOw==
X-Gm-Message-State: AOJu0Yz1QAVxcg4J+8U0PP5TyFLh8JsD/XUejKY+gMI/5TnTyYq3LoVh
	EksEqtk5LCLHUnF+CGGCMBEU6skddh9uqYsjsPPblDkEXA6YTpRLHD6/MCu8XpT2Zm27mq8hB/Y
	iILCs0NtQ3uNT6vv4iVJpF8++fGIPvlrqK9dluJN4OHl+dBilKXtH246hKMgiBxphDL8wHhDQjd
	IMyPr1XGwpYMfpApl/TXS0YFL8JmKimOIeMGGR+ZmtGw==
X-Gm-Gg: Acq92OHitqeEt7QfSlwEGOpsHf3T5bxhb69ArE8DzhppfRcK/wIzoXZ3ww901lbhmgs
	gGWswFyCa08wfr1C81TfC16Sjznz7zWqIT9yo/hsQEQhVFI+PGm/NHT3sZS0F2+F8dDtNRKfvc8
	l7UPYh/c94QEWGNHrKmUnRi2j0la5SJFleM1jUdP2uWtgMcdQBir6xHhJzJ9uF6wqZpzywGCWRh
	nCiGbZebR741aTGVxHPEdb+nDcgseDwoFKZQ6ySWBnN2qmtqC8i+1p5+PXDZR/yjubKb/9bCNpr
	cI7nBp7ztILUzgoRTAmo/mCjheMSuAF1tQEe0ighlDksa3jhHOrLXITViLI9vmqOBnW1rDlaLsJ
	jetMnkCgyADHG9adzhrrZksn2qsroR6OT0jwGW4JNWLg3K3UtgHp2E1GOHB2CDeKSv2RjRayT5g
	==
X-Received: by 2002:a05:6000:40db:b0:43d:7a97:78af with SMTP id ffacd0b85a97d-45e5c6137f0mr31869436f8f.42.1779182876149;
        Tue, 19 May 2026 02:27:56 -0700 (PDT)
X-Received: by 2002:a05:6000:40db:b0:43d:7a97:78af with SMTP id ffacd0b85a97d-45e5c6137f0mr31869195f8f.42.1779182874171;
        Tue, 19 May 2026 02:27:54 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm43178925f8f.16.2026.05.19.02.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:27:53 -0700 (PDT)
Date: Tue, 19 May 2026 11:27:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH net v4 0/2] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <agwrrRSEZ9akIrx-@sgarzare-redhat>
References: <20260518090656.134588-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260518090656.134588-1-sgarzare@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289352-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EBF3357B4B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 11:06:54AM +0200, Stefano Garzarella wrote:
>Patch 1 resets the connection when we can no longer queue packets,
>this prevents silent data loss, and both peers are notified.
>
>Patch 2 increases the total budget to `buf_alloc * 2` for payload
>plus skb overhead similar to how SO_RCVBUF is doubled to reserve
>space for sk_buff metadata. This preserves the full buf_alloc for
>payload under normal operation, while still bounding the skb queue
>growth.
>
>In the future, we plan to improve how we handle the merging of packets
>to minimize overhead and avoid closing connections.
>
>v4:
>- Split the buf_alloc check to be sure the credit is still respected and
>  to avoid overflow of buf_used [sashiko]
>- call virtio_transport_do_close() and vsock_remove_sock() to properly
>  close the connection and remove the socket from the connect table
>  [sashiko]

sashiko reports 2 issues on the second patch but both IMO are 
pre-existing: 
https://sashiko.dev/#/patchset/20260518090656.134588-1-sgarzare%40redhat.com

The first one related 32-bit architectures should be fixed, but can be a 
follow up since not introduced by this series.

The secong one related to a low value set by the user as buffer size, 
it's also pre-existing and I don't think we can do much.

Please let me know if you prefer to add another patch to this series to 
fix the first issue, or just send another patch.

Thanks,
Stefano


>
>v3: https://lore.kernel.org/netdev/20260513105417.56761-1-sgarzare@redhat.com/
>- Split in 2 patches [MST]
>
>v2: https://lore.kernel.org/netdev/20260512080737.36787-1-sgarzare@redhat.com/
>- Close the connection when we can no longer queue new packets instead
>  of losing data.
>- No longer announce the reduced buf_alloc to avoid violating the
>  spec. [MST]
>
>v1: https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/
>
>Stefano Garzarella (2):
>  vsock/virtio: reset connection on receiving queue overflow
>  vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
>
> net/vmw_vsock/virtio_transport_common.c | 29 ++++++++++++++++++++-----
> 1 file changed, 23 insertions(+), 6 deletions(-)
>
>-- 
>2.54.0
>


