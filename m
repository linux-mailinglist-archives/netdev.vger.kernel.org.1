Return-Path: <netdev+bounces-79614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D6E87A404
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 09:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0111F21576
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 08:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A09917588;
	Wed, 13 Mar 2024 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhlKzV7C"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B228A18629
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317841; cv=none; b=R6mafyaIzMu1oRllhjc+JcfimVv1if2zqnimxrLLRgQJdlqZtrkaYv5xSasbuKBGzDJFkuQFG35IzcNPtYjljkPfwP/24h9rppQxk8OeP04uQZT4wxcN8mWUhsWIyzgYXq4Nk3hy55LQB9M2gLd8/y1jOmFuq941W3reonfUgww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317841; c=relaxed/simple;
	bh=R7UrPyomiogXTOEePhUSBvSOHyrsJBsiTYmFkWgfznk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=OOCUTvD7oBi/FDTS71C+Cu6QY7ci9bmAvLD5oyyRuQZlgg58K3n8UrLTCg6Wbxy3GwnRCaC67Tqu7BbRfaY3df9R8hxYhLmS4Ai8ePTjw5xhoVP59jdWbIFAajQOzrUQF+ljMYO7fnjMmyJoyvk49dMeQEJqNtsny6EnoccV75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhlKzV7C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710317838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7UrPyomiogXTOEePhUSBvSOHyrsJBsiTYmFkWgfznk=;
	b=UhlKzV7CYrv4UoWrIDKYp2ohJu9qd4XMVNLeR/0L49Qq6FAR+CRWqa60PQEoBf6kN+JTpd
	rHKOTHXCq5gcWe0cTabuiWn2HciwUy93/PxrjXB+pjiJ5+6S0NM6Su9+vHBY/6jpKV5Lqk
	PNl+mpTjr6VvU03RTVLLm0sWKACMRBg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-sASfXibLP_KkMwtU8aFqsQ-1; Wed, 13 Mar 2024 04:17:14 -0400
X-MC-Unique: sASfXibLP_KkMwtU8aFqsQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF9CE80026D;
	Wed, 13 Mar 2024 08:17:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 624AA1C060A4;
	Wed, 13 Mar 2024 08:17:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240312233723.2984928-1-dhowells@redhat.com>
References: <20240312233723.2984928-1-dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Yunsheng Lin <linyunsheng@huawei.com>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] rxrpc: Fixes for AF_RXRPC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3060407.1710317831.1@warthog.procyon.org.uk>
Date: Wed, 13 Mar 2024 08:17:11 +0000
Message-ID: <3060408.1710317831@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

David Howells <dhowells@redhat.com> wrote:

> Here are a couple of fixes for the AF_RXRPC changes[1] in net-next.

Actually, this should be aimed at net now that net-next got merged.

David


