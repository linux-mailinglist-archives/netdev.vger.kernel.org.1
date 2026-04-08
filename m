Return-Path: <netdev+bounces-276443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI7rOmU01mlZBwgAu9opvQ
	(envelope-from <netdev+bounces-276443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:56:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 780C73BB031
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52BCE304077C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 10:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C415B3BB9E3;
	Wed,  8 Apr 2026 10:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YX8n8TcA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731C72874F8
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 10:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645651; cv=none; b=VOzmoHxSggcX8sRAuIY4Q+i10xD95FX40qbDAY7jpgSLqGbLYC/fnVyw6fdryLF0fdaCjfPTVBY1F3KOfAg/jSb7QTdkAUesNdK5lZxSphjwYVDXatmZZJaCHkRRS/VrQx3RCubHwrh2r8uWGjxnokJgEJ1/rueI67xuEudPteY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645651; c=relaxed/simple;
	bh=Qg4IhS0Qdpxb6/qhQxkeUSVPSaiglX0bHabdDboIuac=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=fcXsrsSiqNZ0eBpkojsfIAAmJckstrFpeCak8JI3vSI5QnJHfXw79h5pLh+9VT5a7EgszbaT64Fn9Y5ToX8Z242EfxMb1iL+ZanpVuCNAuLfz/RKNK8iLZwNydyapfUMYdw8VToA9nfj/LXLVn/THc4fywwUmTVLETyjej2hAIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YX8n8TcA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775645649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jY1ukOkI+Lcpd2UuRoCXivEO6jxQxrYJgx37ibiZJKg=;
	b=YX8n8TcAtv6X3t2cz/QFU/uhNj3z8dqtUb2yA1HC4jzFxXZ/GttEiZ0BtJGiwIW2uy41zI
	2W8SaJR1fJO3IjC2LOKBgTXwC23uSOOaRrQ/9qCsVAT9VqdwCmATzofM4xKiVH1ZAfVXSr
	7AgO2LUciHrtB4V2xSLXQQnFRKDaV0Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-EzblanOwN2yQztDPQf64fg-1; Wed,
 08 Apr 2026 06:54:03 -0400
X-MC-Unique: EzblanOwN2yQztDPQf64fg-1
X-Mimecast-MFC-AGG-ID: EzblanOwN2yQztDPQf64fg_1775645639
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9D89195608E;
	Wed,  8 Apr 2026 10:53:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 15ECC300019F;
	Wed,  8 Apr 2026 10:53:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2234233.1775645449@warthog.procyon.org.uk>
References: <2234233.1775645449@warthog.procyon.org.uk> <aa7aeb86-2430-4c67-9d5d-bb27ad037865@allelesecurity.com> <20260401105614.1696001-1-dhowells@redhat.com> <20260401105614.1696001-16-dhowells@redhat.com>
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S.
 Miller" <davem@davemloft.net>,
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
Content-ID: <2234583.1775645631.1@warthog.procyon.org.uk>
Date: Wed, 08 Apr 2026 11:53:51 +0100
Message-ID: <2234584.1775645631@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-276443-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[warthog.procyon.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,allelesecurity.com:email]
X-Rspamd-Queue-Id: 780C73BB031
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

David Howells <dhowells@redhat.com> wrote:

> Anderson Nascimento <anderson@allelesecurity.com> wrote:
> 
> > Isn't this the same issue addressed by my patch "[PATCH net v4 08/15]
> > rxrpc: Fix keyring reference count leak in rxrpc_setsockopt()"? Just
> > asking to make sure this is intended.
> 
> Actually, I think it's probably better to use Luxiao Xu's patch rather than
> yours as it puts the check down into the function that actually makes the
> change.

I also then need to remove the rx->key check.

David


