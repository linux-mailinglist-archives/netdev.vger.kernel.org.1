Return-Path: <netdev+bounces-249525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4FFD1A78E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13E25301F8ED
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB004346AD6;
	Tue, 13 Jan 2026 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTwUMYqV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C411B6CE9
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323183; cv=none; b=IYWV/vmChIh+YmrttRSBw/cKipTZfU6btcNrOu3vqKL37caFRtH496XLTr5nSO6AsaGvh00DHAib2LCLCgXOMUNqjqkYYuCyjnkhwP9iSrCRH3kJnDISBLWonhC7VrIdAJV06u+zWIE4C0JOixiLwUybf4x79QLKVoPa6+EraWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323183; c=relaxed/simple;
	bh=rXmPc5Im099qC/8JbkGbcDimCDqQ39qSDWNlcGyQVdw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=OVc7t0BrmsBlGtjozWTIoya2O2rRb6yrSl+CGBcFGuLLglQjwufstx7vtigC0njrKglihDrw+tQAxxTS1ap8Po6aRMEzvrHasaH3mq9rP6ZQsf7bWqDytiXl2AtFdxeZ2UZCV1wCXO4mw7g87OI/qtzVEh/l5gBsZPNhq1tmkJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTwUMYqV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768323181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rXmPc5Im099qC/8JbkGbcDimCDqQ39qSDWNlcGyQVdw=;
	b=UTwUMYqVt56lqGYUR/SHL8XQlWD6FpcuaMkRTViylXsouzAqWGOXjui7vd/pDl78b2HUJO
	hchAqlAbNYrSVMmyDy/Y4EjbGvOQykzczQWTdlB3DSZxR6Qz55XG6XXS9tahc/Ifs0zZYe
	SF2qdM4v8V+jrPNokF383VLu9UkQ8SQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-XfcamgqROY-BDgovdSznhw-1; Tue,
 13 Jan 2026 11:52:55 -0500
X-MC-Unique: XfcamgqROY-BDgovdSznhw-1
X-Mimecast-MFC-AGG-ID: XfcamgqROY-BDgovdSznhw_1768323173
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C63E18005A7;
	Tue, 13 Jan 2026 16:52:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 147D630001A8;
	Tue, 13 Jan 2026 16:52:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3535584.1768322992@warthog.procyon.org.uk>
References: <3535584.1768322992@warthog.procyon.org.uk>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com,
    syzbot+6182afad5045e6703b3d@syzkaller.appspotmail.com,
    Marc Dionne <marc.dionne@auristor.com>,
    Eric Dumazet <edumazet@google.com>,
    "David S.
 Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    stable@kernel.org, linux-kernel@kernel.org
Subject: Re: [PATCH] rxrpc: Fix data-race warning and potential load/store tearing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3535878.1768323166.1@warthog.procyon.org.uk>
Date: Tue, 13 Jan 2026 16:52:46 +0000
Message-ID: <3535879.1768323166@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Fixes: ace45bec6d77 ("rxrpc: Fix firewall route keepalive")


