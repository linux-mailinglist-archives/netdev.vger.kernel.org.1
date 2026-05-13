Return-Path: <netdev+bounces-287456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UALfN0sqBGrfEwIAu9opvQ
	(envelope-from <netdev+bounces-287456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:37:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5498052EC50
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 225143009F93
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 07:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864463D5258;
	Wed, 13 May 2026 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMPYnxtm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B65A3D3D14
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657739; cv=none; b=Mcww6uP37MDocWuoxM4sdeE+k9mLOH7LWP131FLPlnJ31W2icLxfqJRKx14Z6PgtQGfAR5PfalBPkUhXZA6ugQMWUnIU3j5rQ1xJheHsC3yiNBMgGLj76PF9twalNYI8l+a5ZyBIKCC/WPXIdYZ+AtDIMLuYX4YYMWWFtQp+QoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657739; c=relaxed/simple;
	bh=km5U6IuBbJNaVAgypChS9PyPL33mLRp6Z28kZyDfKdw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=MGcSWTaHbPsHFAuujAbGSnfYbrqD9GOYifJklz8Aq6x6G3Ru7cCuSajSf01eHx8M+GN8ckRK6pfsSWXK2VzW5g3Tk2cNMoLFWVyGt3IjuJjjdqVVFiBw/AUY8eHpSz9oj3s76LfRQY9Zmg1A2xrVdTtaQTe/b0aRbNE7t3Eauzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMPYnxtm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778657737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLPZCkDr/w2MCC7v5l4kXWCAtP/5O4FTvsQkzLK1BTQ=;
	b=QMPYnxtm0SLPMoEPMHy3k2zLofi+AnOZZLfKB03dSvGjI4QMeXb00/Diz2z2rVJ7b1ktt1
	Hnupf3/jcpb49Zb/RJyA/N5/QYYRE4aKZ/xWGSfWB7+06Xo3t2VEjDJDEUnE4oO4Bk0oF4
	+QzxnpFxrtHYnn7zkCnKdoshUIANZPY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-X4860i0vOWSiLaf4i69Vlg-1; Wed,
 13 May 2026 03:35:32 -0400
X-MC-Unique: X4860i0vOWSiLaf4i69Vlg-1
X-Mimecast-MFC-AGG-ID: X4860i0vOWSiLaf4i69Vlg_1778657730
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84D881956061;
	Wed, 13 May 2026 07:35:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.83])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E42C1800576;
	Wed, 13 May 2026 07:35:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260512170650.4acfad72@kernel.org>
References: <20260512170650.4acfad72@kernel.org> <20260511160753.607296-1-dhowells@redhat.com> <20260511160753.607296-4-dhowells@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Hyunwoo Kim <imv4bel@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org, Jeffrey Altman <jaltman@auristor.com>,
    Jiayuan Chen <jiayuan.chen@linux.dev>, stable@kernel.org
Subject: Re: [PATCH net 3/3] rxrpc: Fix RESPONSE packet verification to extract skb to a linear buffer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1353424.1778657724.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 08:35:24 +0100
Message-ID: <1353425.1778657724@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 5498052EC50
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,auristor.com,davemloft.net,google.com,kernel.org,lists.infradead.org,linux.dev];
	TAGGED_FROM(0.00)[bounces-287456-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Jakub Kicinski <kuba@kernel.org> wrote:

> net/rxrpc/conn_event.c:254:10: warning: variable 'ret' is uninitialized =
when used here [-Wuninitialized]
>   254 |                 return ret;
>       |                        ^~~
> net/rxrpc/conn_event.c:250:9: note: initialize the variable 'ret' to sil=
ence this warning
>   250 |         int ret;
>       |                ^
>       |                 =3D 0

I'm puzzled why gcc doesn't report a lot of these, even compiling with W=3D=
1.
This one is pretty obvious.

David


