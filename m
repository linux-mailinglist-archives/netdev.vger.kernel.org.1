Return-Path: <netdev+bounces-48367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B027EE292
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3954F1C209CD
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0A531A68;
	Thu, 16 Nov 2023 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNaTV5W+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DB3130
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 06:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700144302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=greVKMKfr76MqoUq6gz6BvckYAphWjbfLaTerpqXr4c=;
	b=WNaTV5W+douhqsNEvgFy7zuyhqH/AU0+dnfUttUooZabMEWBLJ8nrIP/9KzprGrgfZ+nQv
	o3axqkkuJqYKiYTM9MstZUVkURsmdQZ6be6NMe77DEPLdVxJ7/aZU4F329oDMbL5utebs1
	2QEWx09QVDg1bSZ33w3HZ/+tBMp6o9k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-C0cl4XhrPL2OSimzHsOHDw-1; Thu,
 16 Nov 2023 09:18:20 -0500
X-MC-Unique: C0cl4XhrPL2OSimzHsOHDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20E9D1C06909;
	Thu, 16 Nov 2023 14:18:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.39])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A12A81121306;
	Thu, 16 Nov 2023 14:18:17 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	weihao.bj@ieisystem.com
Subject: Re: [PATCH 2/2] net: usb: ax88179_178a: avoid two consecutive device resets
Date: Thu, 16 Nov 2023 15:18:15 +0100
Message-ID: <20231116141816.21950-1-jtornosm@redhat.com>
In-Reply-To: <020ff11184bb22909287ef68d97c00f7d2c73bd6.camel@redhat.com>
References: <020ff11184bb22909287ef68d97c00f7d2c73bd6.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Thu, Nov 16, 2023 at 10:42 AM Paolo Abeni <pabeni@redhat.com> wrote:
> We need a suitable Fixes tag even here ;)
Ok, I will add it in my next version.

> > ---
> >  drivers/net/usb/ax88179_178a.c | 13 -------------
> >  1 file changed, 13 deletions(-)
> >
> > diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> > index 4ea0e155bb0d..864c6fc2db33 100644
> > --- a/drivers/net/usb/ax88179_178a.c
> > +++ b/drivers/net/usb/ax88179_178a.c
> > @@ -1678,7 +1678,6 @@ static const struct driver_info ax88179_info = {
> >       .unbind = ax88179_unbind,
> >       .status = ax88179_status,
> >       .link_reset = ax88179_link_reset,
> > -     .reset = ax88179_reset,
> >       .stop = ax88179_stop,
> >       .flags = FLAG_ETHER | FLAG_FRAMING_AX,
> >       .rx_fixup = ax88179_rx_fixup,
>
> This looks potentially dangerous, as the device will not get a reset in
> down/up cycles; *possibly* dropping the reset call from ax88179_bind()
> would be safer.
Ok, I had the doubt about which reset would be the best, because it seemed 
to me that reset would be better as soon as possible.
I will try what you say to avoid down/up cycles.

> In both cases touching so many H/W variant with testing available on a
> single one sounds dangerous. Is the unneeded 2nd reset causing any
> specific issue?
Actually, this double reboot somewhat masked the first problem, because the
probability of getting a successful initialization, if there is a previous
problem seems to be higher. So, it is not strictly needed but I think it is 
better to avoid a second unnecessary reset.
Ok, if I modify the call from ax88179_bind() I will be respecting the reset
operation of all devices.

Thanks

Best regards
José Ignacio


