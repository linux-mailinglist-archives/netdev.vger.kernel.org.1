Return-Path: <netdev+bounces-274243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBd/EvNyzWnYdgYAu9opvQ
	(envelope-from <netdev+bounces-274243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 21:33:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B59FB37FD8C
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 21:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B53E30162B0
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 19:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FA33644AF;
	Wed,  1 Apr 2026 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aY2yJcnb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A257C3644DE
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775071975; cv=none; b=IZSmXraLKh67a8sVd7t1DNDUFyIfnVPqadmX2+umwW2d6nwE4oA0WgBddRnRxHkxbgRtU0oFPQQYgWTXs1e8ieOigBGn4nVsIrX00BTKP28AWgbC8LKFT0cvi5d78RSPtX1DnD8XVJQSq/lCm3m24bWQIxpnaxs+4NgZ0fC8WeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775071975; c=relaxed/simple;
	bh=/n2qF4cnslCp1mznzDlQWisTFF+NgYVkFBLrp4MXPSc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=a2vNpPg2GK7+XMSQvOOTvRRhSiiaxG6Q1Qi8nDgxU4VJTslrmWyjDk0zS6rckGcA2gt4FaeI8NYKC+ltJAe9orxfAS2tZkIAXztdpEXmS81JUMxQPKUu7Zzwrufzxt1BqH5P5ogScdbQ3mMxLORROTKNshIdWKtPf6y4AwcMSUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aY2yJcnb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775071972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6I8n4YjZblJVuQfwib51x4yoN6cxyiSxf4lByaZ4dvU=;
	b=aY2yJcnb4JOvN5LkHBY7evU5dDGGYiGP1/fv3bZgeU+jRA7RhWBStllvbBTOpBl18Zfoc2
	K07iXls1dSakP/hcZt1ZBxfA3fxMIFYlWL/VbEfASvitnvgsTbvC2eUovDKDWsk5Cnes+l
	kcohEcURJtS6HLtqjTYazpnzvHZ+sfw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-msXqGOkJOvOLKYlW47RWHw-1; Wed,
 01 Apr 2026 15:32:47 -0400
X-MC-Unique: msXqGOkJOvOLKYlW47RWHw-1
X-Mimecast-MFC-AGG-ID: msXqGOkJOvOLKYlW47RWHw_1775071965
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7549195608B;
	Wed,  1 Apr 2026 19:32:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.35.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8831C19560AB;
	Wed,  1 Apr 2026 19:32:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aa7aeb86-2430-4c67-9d5d-bb27ad037865@allelesecurity.com>
References: <aa7aeb86-2430-4c67-9d5d-bb27ad037865@allelesecurity.com> <20260401105614.1696001-1-dhowells@redhat.com> <20260401105614.1696001-16-dhowells@redhat.com>
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    Luxiao Xu <rakukuip@gmail.com>, Yifan Wu <yifanwucs@gmail.com>,
    Juefei Pu <tomapufckgml@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
    Xin Liu <bird@lzu.edu.cn>, Ren Wei <enjou1224z@gmail.com>,
    Ren Wei <n05ec@lzu.edu.cn>, Simon Horman <horms@kernel.org>,
    stable@kernel.org
Subject: Re: [PATCH net v4 15/15] rxrpc: fix reference count leak in rxrpc_server_keyring()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1938757.1775071956.1@warthog.procyon.org.uk>
Date: Wed, 01 Apr 2026 20:32:36 +0100
Message-ID: <1938758.1775071956@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-274243-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,allelesecurity.com:email]
X-Rspamd-Queue-Id: B59FB37FD8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Anderson Nascimento <anderson@allelesecurity.com> wrote:

> Isn't this the same issue addressed by my patch "[PATCH net v4 08/15] rxrpc:
> Fix keyring reference count leak in rxrpc_setsockopt()"? Just asking to make
> sure this is intended.

Actually, yes.  This is a different way to fix the same bug, so I'm happy to
drop it from the series in preference to yours.

David


