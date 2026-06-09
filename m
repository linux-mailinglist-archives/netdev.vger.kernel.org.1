Return-Path: <netdev+bounces-297019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tmLROk70J2oL6QIAu9opvQ
	(envelope-from <netdev+bounces-297019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:09:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E5F65F510
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:09:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Usxk2Zp7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297019-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297019-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ACCF30421FB
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 11:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C7D3FCB34;
	Tue,  9 Jun 2026 11:06:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C68B3FC5B7
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 11:06:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003195; cv=none; b=H1uccL6GXZh5686WWdIo2gLnwac7aTBbnZ1xHjLHnQzAcjN2I8f2LSQKbAfGVtlOsgzyn3nELYzLIZZHj9C5DdqmrhkJUbvNBuv+FjN9+SmsbiA7Ijv80mu/J4g7U92/lVIeReDY4MZFiRib2qXRib5BNwnd40jI8AHJjPl+CKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003195; c=relaxed/simple;
	bh=AOcKZuFx/azQdwXcVpOXgJNhyio42f13QH5YqlSZKwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgwDRfO6bCirf3BIxuYY0e1yqSwWQIJkHQAyV3/H+DAZvBlIGZE1YWHFnEfiZUPVtuulXS0JRYYtECD95+9bhz4MaF3Mc/sVM10tUtRRsZc3L/UvryBoNpgGNwiA+ZKmud+zWJs/PuNWsici9heDnAqebzi/uej2JI0RkHAaw3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Usxk2Zp7; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781003192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y17cxi8kkPSr+8QFQJlEXOIBw/gAA9pL1DpslweEtNw=;
	b=Usxk2Zp7G73x6KqAgyRDkKSeFOKZL69W9GDj3N/qgbYw/DfdDF4c9qrSEX948FTa+nhuMY
	3ayYmxI2H0FalzTtCopEKKOCf2JB5dc4yD0WmzMgbiHdD4xMKnmITDa+E0LyPu+sxKIMGx
	uWtOn5xTTDVdOcV7rsHylaz4/ix1xkg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-JolvAdtIPYeLI0XQlXTNEQ-1; Tue,
 09 Jun 2026 07:06:29 -0400
X-MC-Unique: JolvAdtIPYeLI0XQlXTNEQ-1
X-Mimecast-MFC-AGG-ID: JolvAdtIPYeLI0XQlXTNEQ_1781003187
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8821A195D01D;
	Tue,  9 Jun 2026 11:06:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.0])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0DE993008B38;
	Tue,  9 Jun 2026 11:06:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: bestswngs@gmail.com
Cc: 3chas3@gmail.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	xmei5@asu.edu
Subject: Re: [PATCH net] net: atm: fix use-after-free in sigd_put_skb()
Date: Tue,  9 Jun 2026 13:06:15 +0200
Message-ID: <20260609110615.196819-1-pabeni@redhat.com>
In-Reply-To: <20260604164916.2681964-2-bestswngs@gmail.com>
References: <20260604164916.2681964-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297019-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com,lists.sourceforge.net,asu.edu];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:3chas3@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:horms@kernel.org,m:linux-atm-general@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47E5F65F510

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
net: atm: fix use-after-free in sigd_put_skb()

This commit addresses a use-after-free in sigd_put_skb() by pinning the
socket with find_get_vcc() and checking if it is marked SOCK_DEAD under
the callback lock.

> diff --git a/net/atm/signaling.c b/net/atm/signaling.c
> index b991d937205af..3dbe8e0fdc9af 100644
> --- a/net/atm/signaling.c
> +++ b/net/atm/signaling.c
> @@ -54,14 +54,31 @@ static struct atm_vcc *find_get_vcc(struct atm_vcc *vcc)
>  
>  static void sigd_put_skb(struct sk_buff *skb)
>  {
> -	if (!sigd) {
> +	struct atm_vcc *vcc;
> +	struct sock *sk;
> +
> +	vcc = find_get_vcc(READ_ONCE(sigd));

[Severity: Critical]
Does this introduce a regression where an ABA vulnerability allows a KASLR
bypass if the daemon socket is freed and reallocated?

If the signaling daemon is closed, sigd is cleared and the socket freed, but
an unprivileged thread in sigd_put_skb() might have already latched the old
sigd pointer.

If an unprivileged user subsequently creates a new ATM socket, couldn't the
slab allocator reuse the exact same memory address? In this case, find_get_vcc()
would match the raw pointer and return the attacker's new socket.

Since the attacker's socket isn't marked SOCK_DEAD, sigd_put_skb() would blindly
enqueue the signaling message to the attacker's receive queue.

Because the message contains literal kernel pointers (vcc, listen_vcc),
wouldn't this allow an unprivileged KASLR bypass and message injection?

[ ... ]

[Severity: High]
This is a pre-existing issue, but does sigd_send() leak memory when queuing
SKBs to a closing listening socket?

When processing an as_indicate message, sigd_send() resolves the listening
socket via msg->listen_vcc, acquires lock_sock(), and appends an SKB:

net/atm/signaling.c:sigd_send() {
    ...
    lock_sock(sk);
    if (sk_acceptq_is_full(sk)) {
        ...
    }
    sk_acceptq_added(sk);
    skb_queue_tail(&sk->sk_receive_queue, skb);
    ...
}

Does this code blindly queue an SKB without checking if the socket has been
marked closed (ATM_VF_CLOSE) and already purged?

If the listening socket is concurrently closed, vcc_release() will lock the
socket, purge its receive queue, mark it closed, and release the lock.

Could sigd_send() then acquire the lock and append the new SKB to the dead
socket's receive queue? Since sk_free() expects an empty queue and does not
purge it during memory free, would this permanently leak the SKB and allow
an attacker to exhaust kernel memory?
-- 
This is an AI-generated review.


