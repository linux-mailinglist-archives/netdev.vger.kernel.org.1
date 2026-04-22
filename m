Return-Path: <netdev+bounces-280411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DQMHHfD6Gm9PwIAu9opvQ
	(envelope-from <netdev+bounces-280411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:47:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E3444624D
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F88B30EDF82
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAED53DEAD5;
	Wed, 22 Apr 2026 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igsTucES"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3953D9047
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861490; cv=none; b=DZJq1K/PflVZ5hpwBVWeuOQi5GrXJbnHF27uA+34Y68Z0XG1PDR+17kVmL0CMB8d8jWmQbGDspEORGuEO7YvNJ1/7XQOqWCelifyq4ev3Ifqz9NT8MbQzTgje7V1W7RayziR8wx+BB1ZwpanL8beHzO52uqWY/rtwenq9mQ2xig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861490; c=relaxed/simple;
	bh=OYSFEGZ+L+Izc2TVCxIS4VSiouTtIE9ZV57L87ilEBo=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=rV3HtXwRqR1nXKCQqdhBzV1jCWntkVkU2tFBdw/Jd1rqTV7iHKRGdRFhZ3QulTsvAvw1GVUv+Twi+TxJdc63E5Z6BHV5FeS2AW4wpbD7pae2VZuVUIjjF6A/OnJXd9kEYFF+CJoyPEC5EzSGXmJUrt+sfujltd76k9Il7r29JFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=igsTucES; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776861486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OYSFEGZ+L+Izc2TVCxIS4VSiouTtIE9ZV57L87ilEBo=;
	b=igsTucESy3TMkN5Mm11TB/mHiq1aK2C6HWQ+Oqnh4Mmlh967obziSAFkK7ipOAUqedoZV1
	RwNcnB7A72kM/PgSKE7U2YH/hJnhcd4zXmiU5TSPmyC6zFANcgd/ije4GyM5PEvi3k4soC
	TLlZFlW0LypwBvRrdqaLToUsSrK9Dfc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-BSdnHa68P9qHSVB-9njKMg-1; Wed,
 22 Apr 2026 08:38:02 -0400
X-MC-Unique: BSdnHa68P9qHSVB-9njKMg-1
X-Mimecast-MFC-AGG-ID: BSdnHa68P9qHSVB-9njKMg_1776861480
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 451E11800348;
	Wed, 22 Apr 2026 12:38:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7D751956095;
	Wed, 22 Apr 2026 12:37:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260422003206.1017863-1-anderson@allelesecurity.com>
References: <20260422003206.1017863-1-anderson@allelesecurity.com>
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Steve Dickson <steved@redhat.com>, linux-afs@lists.infradead.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc: fix missing validation of ticket length in
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2475723.1776861474.1@warthog.procyon.org.uk>
Date: Wed, 22 Apr 2026 13:37:54 +0100
Message-ID: <2475724.1776861474@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280411-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,warthog.procyon.org.uk:mid]
X-Rspamd-Queue-Id: D8E3444624D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Subject: [PATCH] rxrpc: fix missing validation of ticket length in

...in rxrpc_preparse(), I presume?

David


