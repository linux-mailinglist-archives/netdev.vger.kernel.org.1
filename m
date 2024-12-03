Return-Path: <netdev+bounces-148644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1658C9E2D34
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73073B2A65B
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 19:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6401A202F86;
	Tue,  3 Dec 2024 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2GifQmq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CC81E1035
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255549; cv=none; b=gXzcVJebI/X6rdLpXifjbSbeBh9CQDAf2873vX93eifMrwskanZzpHisytdXrfcEEMEY3LIOdR0nIj5Th0jmTNubbtrt5xC2f2TzWi384PW1rLhFhUNDRh3z5ghyxOw7MhADxm8PFyXBIoqyu/LOBJ6S2Jj8ZgV1RkOifLKyoCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255549; c=relaxed/simple;
	bh=eQhT3lmDB6SLTG0JjVVKytPHuewUrsf19O0GDP6D8Uo=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=V9F50ukkIA4jQba+z2ZHhg2dnw+jB5ixqPYThtRS+z/qEGnKppD45DzYmO8djywC8rEk8drnYhILT57b3t9iThM8KjhtJjeql7dncaBfO1gKvgalsMEi8OK6JMjk+VH3vWV0ivlrMoUz8CUM0XUiETJsZTCzUZf1k2FxV2Yr1Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W2GifQmq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733255546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nIqP7NUY2eFy7rNPuyXXrO7lQOOLNwlmTASFiEYxVm8=;
	b=W2GifQmqyu/Fe4grgKN9+JEwVeUhEdD0dhCrOCb/Wy7cp33GF5c35xIuGsuu4VBYYsQRLs
	oNFy1toY5i3/p0atZqQDlePvvxEmv55PamDkIrw04agA3D/UNwOa4S+JdnFP6tzGRnCcA2
	4KyYkfGcIDm0ier3+ZXfz3UguK3/uRs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-WBrKKZnGOLGNCSDj8cQXoQ-1; Tue,
 03 Dec 2024 14:52:23 -0500
X-MC-Unique: WBrKKZnGOLGNCSDj8cQXoQ-1
X-Mimecast-MFC-AGG-ID: WBrKKZnGOLGNCSDj8cQXoQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF114195608C;
	Tue,  3 Dec 2024 19:52:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE1CC1956052;
	Tue,  3 Dec 2024 19:52:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241202194337.305e0c22@kernel.org>
References: <20241202194337.305e0c22@kernel.org> <20241202143057.378147-1-dhowells@redhat.com> <20241202143057.378147-11-dhowells@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    Yunsheng Lin <linyunsheng@huawei.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/37] rxrpc: Prepare to be able to send jumbo DATA packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <715425.1733255536.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Dec 2024 19:52:16 +0000
Message-ID: <715426.1733255536@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Jakub Kicinski <kuba@kernel.org> wrote:

> clang says (probably transient but since i'm nit picking anyway):
> =

> net/rxrpc/input.c:696:25: warning: variable 'capacity' set but not used =
[-Wunused-but-set-variable]
>   696 |         unsigned int max_data, capacity;
>       |                                ^

Yeah - it's used from patch 29 "rxrpc: Send jumbo DATA packets".

I just noticed that patch 29 adds a member (tx_jumbo_limit) that is only s=
et
once and never used.  I'll remove it.

David


