Return-Path: <netdev+bounces-145885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824AD9D13D3
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397D41F23205
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9F11AC45F;
	Mon, 18 Nov 2024 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIab/NWO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE81E529
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942026; cv=none; b=WbjAuJcWbgCNNN5B/VQLz75UiFxtl8OGILR23gkkuY/EqyYKCByspiGiHBB5OiFNeCvfJeoPzh2Qawsmuw8nengKUpuKtHoUGAg145eHZGGofPIAPNFvm95js1IYlLSBkGZsENUGFGdWoVaU3KgZyjubi7oP8TWLhXVXq9KJn0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942026; c=relaxed/simple;
	bh=osolB0cyVpIVsTVcw/NUpVzM/FR+xiFAx7qOUeDKt30=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=X0K1h64wZVqAVWQUiY/aKMtCkqSnUrhs2rquqSnwX3i0CfQww1psimitap2vSq7XhBr3Q8YnQ2iFbX4HyNcE0iGmtpIgQ+QDojO4dGdCzuYZTYoUMJ9M84LvUtvrnHXi/QTZOV8iYp6vjtlr7wA7p9BiuNklLLm2j3a51EnBFzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iIab/NWO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731942023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ChWi/k+snGKLwA/khcA5djHIdedI2XLUo5ychYHO4Uk=;
	b=iIab/NWOOxlpTEWd5ESE6se7hf/B//IksHO1duNbHsK3ITBBU6MOAbrhgNEX41I7ps1s4v
	a5EheyaCKGLlg0+3rtlQ3AAN2nUIrHkewtNx9Z2Wv3tumrYHL3yuNCUrpZe9+nP7SNGlQk
	e/2Mri92PRPWHtp2Kkzli3v+nlXh3rk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-77U2MGWSPr2aBou8UgLGJQ-1; Mon,
 18 Nov 2024 10:00:20 -0500
X-MC-Unique: 77U2MGWSPr2aBou8UgLGJQ-1
X-Mimecast-MFC-AGG-ID: 77U2MGWSPr2aBou8UgLGJQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 742891945CAE;
	Mon, 18 Nov 2024 15:00:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.207])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A126A1955F4A;
	Mon, 18 Nov 2024 15:00:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241105191959.2871-1-zoo868e@gmail.com>
References: <20241105191959.2871-1-zoo868e@gmail.com> <671acd8e.050a0220.381c35.0004.GAE@google.com>
To: Matt Jan <zoo868e@gmail.com>
Cc: dhowells@redhat.com,
    syzbot+14c04e62ca58315571d1@syzkaller.appspotmail.com,
    davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    marc.dionne@auristor.com, netdev@vger.kernel.org, pabeni@redhat.com,
    syzkaller-bugs@googlegroups.com, skhan@linuxfoundation.org
Subject: Re: [PATCH] rxrpc: Initialize sockaddr_rxrpc directly
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <883285.1731942012.1@warthog.procyon.org.uk>
Date: Mon, 18 Nov 2024 15:00:12 +0000
Message-ID: <883286.1731942012@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Matt Jan <zoo868e@gmail.com> wrote:

> In rxrpc_lookup_peer_local_rcu(), removed the redundant memset call
> that zeros out the sockaddr_rxrpc structure before setting its fields.
> Instead, initialize the sockaddr_rxrpc structure directly in
> rxrpc_input_error().
> 
> This change simplifies the code and ensures that the sockaddr_rxrpc
> structure is properly zero-initialized.

How does that actually fix the issue?

All the patch does is move the initialisation of srx from
rxrpc_lookup_peer_local_rcu() into its only caller - and nothing samples the
contents of srx between.

Looking at the bug report, the history of the uninitialised location goes back
further, to a network address generated/assembled in the ipv6 stack or from
the transmission side of the rxrpc stack, possibly call->peer->srx.transport.

David


