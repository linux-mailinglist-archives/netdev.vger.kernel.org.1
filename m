Return-Path: <netdev+bounces-171935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FC2A4F7DD
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 08:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABB8188FE80
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 07:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB09C1EC00B;
	Wed,  5 Mar 2025 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqHcVqs9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC01EA7E9
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 07:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741159641; cv=none; b=C8Sv0honwTFWGL/PTdO7RPa1GDK1t96Xy/AkiXOo0jcfyKnr9keQF3BpNG0i8/q2ct+YpnCwCmrnKP0tK9uCXvnLYyr4CQ5hFTvdzD49BmV92FUQDBvTxSv6br+a60Ed+cpCZpVIF6VXJSbw5PwC+vp/OLl+azoDebW1Z/pBvqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741159641; c=relaxed/simple;
	bh=ggBjNt/KlzNhbq7zUAZEYyviD7fOL0zcgpYxjiglnLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6P3TG/KUzaGVkgdNRyQnqNeO+q9XJQyedOzcwq5nYEXResfZ9mxyRxL3Rgcn4V2Kg8QFD0bGj5n9QE2eWFyG543cKPJajViMI3zFvCWFlbAMXvbjWCCj1/d3/laGxeMYjKMIuCn9++AWh+OUIBZx/dqZNp3k0MG8CejdwM5iyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KqHcVqs9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741159638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Gqpuh7OkhW6l3/SGFe53202mdgSid6lnY8KI4KHLQM=;
	b=KqHcVqs9gkuBBotJ0UU52PmR+tXG3tRCKBCpXh60+sgr507VKdcuJ6HoUd4KUJVATziGZt
	bOeZTrXs/WgbXPla72WCj40gzoafUSK4LRxWYW/A7edy91yCpa62OKPaydgBhERuS36EsT
	IOAS/hNEVYDDOpOvuHubbB1J0ja8QIg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-YSiiLFGaOdi1VGV508Iagw-1; Wed, 05 Mar 2025 02:27:17 -0500
X-MC-Unique: YSiiLFGaOdi1VGV508Iagw-1
X-Mimecast-MFC-AGG-ID: YSiiLFGaOdi1VGV508Iagw_1741159636
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3911232fd8bso1769051f8f.3
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 23:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741159636; x=1741764436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Gqpuh7OkhW6l3/SGFe53202mdgSid6lnY8KI4KHLQM=;
        b=NLQYtLCDNj1lKZGqvcNxABfya6Df+56ar+qmXeDhDXoUR7U42sqV4PGV6EV7ii4XLZ
         YftWMHxkOKwbiNYmTjZxnTDufHeQvZQIfVYKouovu69R8JbWsnhuXvqUJBfiJVYogWb4
         U8MHjHJHkE4jTdODDqEMtjByqbUUSOLAX/yqwP65Ag6cbu9cEgFUWNfdBP5csNmb+Moa
         p/k1ZjrU45Ms5P0dkkRriAG39ioGKV2EIfah92UFwITwD0aASXxSRTN7ZRYyCoLQPt+l
         xbMq/zP6KuyBThg7nWFO1FJ/9JekgHQ++rfByQggHD3thJjWSJajVREx9EgmXlfvh7+L
         WNDg==
X-Forwarded-Encrypted: i=1; AJvYcCUqc37Q2bQx8OeJPAcp4p1iERLfthCCh7PuhFjsEMqa5pWiCQeBZ/R3nDWbVqmIngV1usEVMGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4JjLEXKZBavR9gjXag319mh1lux/pE6K4MY4wdV5/PkiVas60
	GJmXNQxEpui8yFQLtRl7UAqwvmrQegqTteiwOeACjwwJeeZOdhtHNoVE2V+OI+6M5lToZEP+0lc
	rw1AwLnrxkoHAklNP9xeOp3wwhxq9V2f/ky8t0O1U0QEgTi0CMs1Beg==
X-Gm-Gg: ASbGncv9pdVnHtHxFGR0GVyq0a6zaMbegsOJ23qZdKRG0l43joSc4eoHM4T1RQ8SyDB
	ihWrd5yloQtT9IfO43UpKI3MOF1axylFQVeAQMmi+vZazCw9o1IAOz3AFFPSRLfxMwQIk9YOuX5
	Yh524atlzD9QUD2DpPzaRF0V8EbVnUdKQc7SYRgEtqGEaJFu03BfsXCYa2S6+qLaVbdpIGRGSz8
	KxQ2D9RbBIhLk3MuKO2V9ZuDI/fJ0Y0BQys29jneJ5Y4Ot8pBb84jPKXuRj/KIxy6k/oGQooXeK
	SpBPNdtlHg==
X-Received: by 2002:a5d:588c:0:b0:391:1222:b459 with SMTP id ffacd0b85a97d-3911f7bd7b9mr1100769f8f.49.1741159636295;
        Tue, 04 Mar 2025 23:27:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFSwg2gbLwAPlPAn2L1vg/ffvpbpIN3dglqIqZN8294KCbPeBfUkyQP4He1JGn832GdDHxeA==
X-Received: by 2002:a5d:588c:0:b0:391:1222:b459 with SMTP id ffacd0b85a97d-3911f7bd7b9mr1100756f8f.49.1741159635943;
        Tue, 04 Mar 2025 23:27:15 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7b88sm19898221f8f.40.2025.03.04.23.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 23:27:15 -0800 (PST)
Date: Wed, 5 Mar 2025 02:27:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>, davem@davemloft.net,
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <20250305022248-mutt-send-email-mst@kernel.org>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com>
 <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>

On Tue, Mar 04, 2025 at 04:39:02PM -0800, Bobby Eshleman wrote:
> I think it might be a lot of complexity to bring into the picture from
> netdev, and I'm not sure there is a big win since the vsock device could
> also have a vsock->net itself? I think the complexity will come from the
> address translation, which I don't think netdev buys us because there
> would still be all of the work work to support vsock in netfilter?

Ugh.

Guys, let's remember what vsock is.

It's a replacement for the serial device with an interface
that's easier for userspace to consume, as you get
the demultiplexing by the port number.

The whole point of vsock is that people do not want
any firewalling, filtering, or management on it.

It needs to work with no configuration even if networking is
misconfigured or blocked.

-- 
MST


