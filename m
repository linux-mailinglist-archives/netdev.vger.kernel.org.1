Return-Path: <netdev+bounces-276454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKHsHSs/1mkFCwgAu9opvQ
	(envelope-from <netdev+bounces-276454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:42:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4593BB666
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5009630684DA
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 11:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606523B6C01;
	Wed,  8 Apr 2026 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bug2iL9U"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE06C33C52F
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775648417; cv=none; b=TtFvcBrsIXSBTPzSC4JcICUJZTa5VYV8loYo/+IaveJ2HtbiX4EWtlZ1FlVReKFVkNWlQTBRBmTxPlGY3Qxde/8YrzAnwZh0pjpudrKwlP138KBCzjztjO+CYT3Rio6wCevAvAKzizuN3nx0fUlGtYEMYoHgI+WxJV4goDsm/Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775648417; c=relaxed/simple;
	bh=jSPVDZvrxwFH4JgOU4z4KL9fg1rE0EVL+yAkN0sJ16I=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=NqJwQIUG9Zli12IeT0xEx8qAzqVkRwPEvhu/7N+lHA+OLPLVEOz8/U36XCBTCn0NvkXm/AhVqEQmRSpMhm0Iv+DivYbr9jFR6KECVqjMeUbtqXWy4JXlP4EynZbOuiZTJpq0ytftaJyS3BvBtsWT7Lokyk/8FJoHzkpI39+7KiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bug2iL9U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775648414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4mb2C1qLL4sWx3KmZjX2k1BMpNaArf+nYlwAG/cUh98=;
	b=bug2iL9UHMFewj8ndQmFYpIwb4EdqspiaGwL0lURBPsrl+nMt3WAckVuLfyCDTntTxV/N1
	RZyJrSy/hAbgxlGbEL8GXCgVKaBSd1oIEMxWhweJe7v0P/BkFCm6Br1b6KbzLixcSKmZq4
	3RXfNXCWIAiVJRg1YG0skRTDxNBTr2U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-dPSNUmPPNdGzQY9nsE-PVA-1; Wed,
 08 Apr 2026 07:40:11 -0400
X-MC-Unique: dPSNUmPPNdGzQY9nsE-PVA-1
X-Mimecast-MFC-AGG-ID: dPSNUmPPNdGzQY9nsE-PVA_1775648409
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBCAD18005B9;
	Wed,  8 Apr 2026 11:40:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.94])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E60E1955F2B;
	Wed,  8 Apr 2026 11:40:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260406170001.2-rxrpc-proc-v2-pengpeng@iscas.ac.cn>
References: <20260406170001.2-rxrpc-proc-v2-pengpeng@iscas.ac.cn> <20260404190004.4-rxrpc-proc-pengpeng@iscas.ac.cn>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    linux-afs@lists.infradead.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rxrpc/proc: size address buffers for %pISpc output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2245481.1775648403.1@warthog.procyon.org.uk>
Date: Wed, 08 Apr 2026 12:40:03 +0100
Message-ID: <2245482.1775648403@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276454-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,warthog.procyon.org.uk:mid]
X-Rspamd-Queue-Id: DE4593BB666
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm going to add:

    Fixes: 75b54cb57ca3 ("rxrpc: Add IPv6 support")

and change the subject to "rxrpc: proc:" rather than "rxrpc/proc:"

David


