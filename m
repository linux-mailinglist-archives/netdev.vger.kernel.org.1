Return-Path: <netdev+bounces-273125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LauIJhWymn27gUAu9opvQ
	(envelope-from <netdev+bounces-273125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:55:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F29BD359C25
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBB16303B95B
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7973B47FC;
	Mon, 30 Mar 2026 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Za8O/dPl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391E21FF5E3
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867782; cv=none; b=Bg7LqI5Rpfe6OJtC07vM3zKx1ZWgAzOr7/B6GNbrjsjw8Eh7aYrRZdvw6zHHtCQjr2G+nWnWkApQAHiqNQ84gPd8kwHP+cSbfmPX+yCu5eW6B/zgIq42EV7f2euNa+F7HSmjAlPisxAeVhVtd/F+0WaIANLkd++idUXY+kGRMWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867782; c=relaxed/simple;
	bh=TkWSAOyKf9pHzREC1ZInMjKXj+zxxRlCU5cWRTHk0bs=;
	h=In-Reply-To:References:To:Cc:Subject:MIME-Version:Content-Type:
	 From:Date:Message-ID; b=dMF0ei4D/P4pxm4zGgGXIpoXg95IErsNoehtT9cReCz1DUNySdbysWLsavSdM2Br9cBaX8TdnWH5zMlLVu6bKRY15Ky/FED5XNwGMxmlqVo7VkqVkQbyF1gKXBZ9qoXTzax16rnegENcAJ5Na0xeXKEDns8xRaxT5A2NZpeTHDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Za8O/dPl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774867780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T6CbeBbXEhiNM7kEGDQxi0LjkO7hSdtdP9Ej33IXIkE=;
	b=Za8O/dPljq+2mdnNwvD96Bgn4Kc/x34FwXSmadNLbF8+tW4MTjcIAv1pKsRQOxAT2v7zk5
	KEzNLHChQM6ZgfpAcF64SThMDjv2pmVwnpgkWH4F+8JctWlZ3xpnN8J9Kze4Cl5zYaAX8W
	diwoFzox4Hl/JIVYFuzBg4moDv7GjlE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-vgCQ4JUgMBOlmC67iSTGSQ-1; Mon,
 30 Mar 2026 06:49:37 -0400
X-MC-Unique: vgCQ4JUgMBOlmC67iSTGSQ-1
X-Mimecast-MFC-AGG-ID: vgCQ4JUgMBOlmC67iSTGSQ_1774867775
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5587C195608E;
	Mon, 30 Mar 2026 10:49:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.35.245])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C7AD1955D84;
	Mon, 30 Mar 2026 10:49:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <CAHk-=wiJ6gEELLviexdmSHnyjVoG7MFo8Qwhd1zxs_tCnL-=gQ@mail.gmail.com>
References: <CAHk-=wiJ6gEELLviexdmSHnyjVoG7MFo8Qwhd1zxs_tCnL-=gQ@mail.gmail.com> <20260326131838.634095-1-dhowells@redhat.com> <20260326131838.634095-5-dhowells@redhat.com> <20260329121208.6092419d@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Jakub Kicinski <kuba@kernel.org>,
    netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
    John Johansen <john.johansen@canonical.com>,
    Minas Harutyunyan <hminas@synopsys.com>,
    Simon Horman <horms@kernel.org>, apparmor@lists.ubuntu.com,
    linux-usb@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH net v3 04/11] list: Move on_list_rcu() to list.h and add on_list() also
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <972872.1774858862.1@warthog.procyon.org.uk>
From: David Howells <dhowells@redhat.com>
Date: Mon, 30 Mar 2026 11:49:25 +0100
Message-ID: <1179840.1774867765@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273125-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email,warthog.procyon.org.uk:mid]
X-Rspamd-Queue-Id: F29BD359C25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> ... and I do *not* see a huge advantage to a helper function that just wraps
> "list_empty()" with another name that is actually *less* descriptive.

I don't like list_empty() as the name of the function used to find out whether
an entry is on a list.  Yes, technically, all it's doing is seeing if the
list_head is 'empty', but, linguistically, it looks wrong: the question you're
asking is not if the list is empty (you're not looking at the list head), but
if the entry is on a list.

So if I see in the code:

	if (list_empty(p))

what is the test actually asking?

Note that various other list types in the kernel have separate "is the list
empty" and "is the entry on a list" primitives, though, granted, usually
because they require separate functions programmatically.

Anyway, I'll find a different way to do this, not involving checking the prev
pointer.  What I don't want to do is hard code "prev == LIST_POISON2" into my
stuff.  Anything like that really needs to be in list.h.

David


