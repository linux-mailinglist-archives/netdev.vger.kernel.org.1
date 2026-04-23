Return-Path: <netdev+bounces-280866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLquOMJ56mkUzwIAu9opvQ
	(envelope-from <netdev+bounces-280866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:57:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 454DF45712D
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A81B30131C1
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14DE39446F;
	Thu, 23 Apr 2026 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3Qn7cWn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9397B34B1AD
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776974200; cv=none; b=A7yqh+lqw3RFI6ZJuG1OI6USbNFGA1klFMLxEjLP1Ik7BMzQh+9DeQo53nhOSm5d7i86RGrodQ6ieIG9mw+xZnXpyvJzp3LV6PYp8inc2UCMCgwXywpCUFowTcJiWjguOqYUwIEvmOFYZ2mjlPwEyF9kzN3PB4hZLpw4AKodd7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776974200; c=relaxed/simple;
	bh=gMgmVmlxa7ovReRgHTlGcgL+SoczKjd4eQVfTmLTet4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=FbMjPegO6oeLyMgqRc3iB0bLBB8ji7EXmmBZrlmQ8sWjHn983PdYeI5YnRTGpbIzxhMu1gBVuMFDk8kPwREyLZVxP4E6B3Jj3g5/NBm9iUyZdQoZi+YP1lT8xxGy1t++ibyxjww/h6UwG/5zJrZYw7/ZxKVYQkLY8uXLBdEs1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3Qn7cWn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776974198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X07foacc4iZIeJCjBihvUZxV0FoTwIiEUiMjOGRRzVc=;
	b=X3Qn7cWn/MBhvesx448Xm/Go/9lBC0xl30ndY70BY4VnLNg3hA/xQE+ZQMB3bFD3gteit5
	dPd3QmmoZ26II+sNnBNeUkmBBp91fkzXdXjJQZtqSs2p2m6WTj5SbeIWhQmMoeBTE9DJrR
	8dc5tINkija1f5DiHJM65dgiRH0W8tY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-c1_0_uiaPVWUtlUV2Ml9Vg-1; Thu,
 23 Apr 2026 15:56:35 -0400
X-MC-Unique: c1_0_uiaPVWUtlUV2Ml9Vg-1
X-Mimecast-MFC-AGG-ID: c1_0_uiaPVWUtlUV2Ml9Vg_1776974191
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E505195608B;
	Thu, 23 Apr 2026 19:56:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE8E1180047F;
	Thu, 23 Apr 2026 19:56:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260423123947.156ce741@kernel.org>
References: <20260423123947.156ce741@kernel.org> <20260423105639.6e0a0a7e@kernel.org> <20260422161438.2593376-1-dhowells@redhat.com> <2990993.1776970042@warthog.procyon.org.uk> <20260423115853.59273351@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>,
    Anderson Nascimento <anderson@allelesecurity.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/6] rxrpc: Miscellaneous fixes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3047315.1776974185.1@warthog.procyon.org.uk>
Date: Thu, 23 Apr 2026 20:56:25 +0100
Message-ID: <3047316.1776974185@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280866-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 454DF45712D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski <kuba@kernel.org> wrote:

> I've been hacking up Sashiko on top of Claude in these past few days,
> and it's far less nit picky. For this series it doesn't flag a thing.
> I'll just pull this in, if you could LMK whether any of the "real
> Sashiko" reports are actually valid commentary on the current patches
> I'd greatly appreciate.

They're all valid comments.  I've expanded my series by two further patches
and modified two others (one just a trivial missing space) and will post a v3
shortly.

David


