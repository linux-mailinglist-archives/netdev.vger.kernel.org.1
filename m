Return-Path: <netdev+bounces-185541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D99EA9AD63
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BADF5A36C4
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C3A238166;
	Thu, 24 Apr 2025 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="easqI5iP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7592367A9
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497608; cv=none; b=CoNLewmg8ceJ3lUq1L3ogbLRFIEQVvuHhWhqYnFk4t5M1kBCPs5MumVnM3dU3aMKsXW3oyLteYlE06Xyw14MluH0KDb2ZSTQeTB5L8fztYekq6TyxKQ5ah3vGD9tR277AItAfC7/ftMzbhwtynwBMlc0vKoZKYdGWImD44ZA0ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497608; c=relaxed/simple;
	bh=qH94Zg8HHuTGEsjzE7t/Q/Z/oX9xV89qxY576wt/+Kc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=EFxwBVBqC1yw7wM3hhwWb1LaocR2E490RnaXkjnBxTDqTSrTDTeWA81xLM6VQz68xlgXrn0xualuIjpmdiWenThgPj/gjtp7jP8wW9nxzYZ8f+JN7FsFt6dA/icWDtBth8jKzOZYVXOEiRle445ANPNJdIoGt9wLbIgy5SgAoG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=easqI5iP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745497605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QC/L5dA3dOSeibATP2lFtsY0DYuXP89RpuDsJDZIFBQ=;
	b=easqI5iPGQ89u/EZ+7g2mY+zg6xpXC5W94ghh+vIbJ0pd1aT+p/TPa1T7EeXEBL8Xy3uva
	iV/e1hFlmJhtYbnJxn3VjXl3ogY5nnKwyfa/axyjGDanm8vodBmhrhE7txYCEWAXRR7utZ
	WXahvKXSryarPeINRzjQpg1h9F6JVSM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-6G4aEBPBNemdl7lnN7eo_Q-1; Thu,
 24 Apr 2025 08:26:41 -0400
X-MC-Unique: 6G4aEBPBNemdl7lnN7eo_Q-1
X-Mimecast-MFC-AGG-ID: 6G4aEBPBNemdl7lnN7eo_Q_1745497600
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D049A195608E;
	Thu, 24 Apr 2025 12:26:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B89A21956095;
	Thu, 24 Apr 2025 12:26:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aAikCbsnnzYtVmIA@stanley.mountain>
References: <aAikCbsnnzYtVmIA@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    linux-afs@lists.infradead.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] rxrpc: rxgk: Fix some reference count leaks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3113807.1745497595.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Apr 2025 13:26:35 +0100
Message-ID: <3113808.1745497595@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Dan Carpenter <dan.carpenter@linaro.org> wrote:

> These paths should call rxgk_put(gk) but they don't.  In the
> rxgk_construct_response() function the "goto error;" will free the
> "response" skb as well calling rxgk_put() so that's a bonus.
> =

> Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class=
 (GSSAPI)")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: David Howells <dhowells@redhat.com>


