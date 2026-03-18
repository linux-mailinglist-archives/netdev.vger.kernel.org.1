Return-Path: <netdev+bounces-269189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCfgDSkdu2lofQIAu9opvQ
	(envelope-from <netdev+bounces-269189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:46:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE25F2C31E3
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05526302194B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2949230BF67;
	Wed, 18 Mar 2026 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A93YMN8X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2215FA81
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870374; cv=none; b=hhJlPcWPSI666LgfHoYtBDKYVj4Tew6DvlTgQJETS84PAUQZlW0ZuEDGVdHYRbt7MjqxdAFVaf5Wp8IqnJi6lnMuT912Ok4ZpoQrgHTRY2Dq8VLr+nFDNoIHI3We9oXPutH7P1EeJsaW7eC8ZaTjcC6oEulPjM2CjmnYfyDgL3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870374; c=relaxed/simple;
	bh=UG3J5FEKPJH5QkrX0U0DllPVFlG8JjoGekVM2Jvxjwk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=WomcJxxblY0KMi4pGhx/anxgCI+lCxwEQ/d4SowHgQaNonjVkpYVcybNHkUrXJaIO33oYw8g0kGfjjfh8dEUXT/8AVI1uGZoK3pQ1gM6h/6QZ1mYe7B245rnG323VT8x/LdonCXZNteFPNnuXKHadcmpH3VoKRvqYEEiT+FGUM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A93YMN8X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773870371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HXMqBPRmfkg8Znsu+4p0fyfYL27fc9w4khDPRfLlo54=;
	b=A93YMN8XPIqAdCZ29mcS9nGoqHxU7VOGOa9r1geZoPmvbnKy/l533c/KbNvHDjsuEIjEqt
	U+d+2WxNEW6LbyJz71wo4scTmL0eYFldxYfDYn8BKTG3XnBsUmQOWxasnQ4JIYXC2+0Ht5
	yghhqGL3QYF8NVL5qx2fL4dSr+303dM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-SXpFhTsuM7GtvR01r0Ks4g-1; Wed,
 18 Mar 2026 17:46:07 -0400
X-MC-Unique: SXpFhTsuM7GtvR01r0Ks4g-1
X-Mimecast-MFC-AGG-ID: SXpFhTsuM7GtvR01r0Ks4g_1773870365
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 544BB195604F;
	Wed, 18 Mar 2026 21:46:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.45.224.65])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7CE4F1800769;
	Wed, 18 Mar 2026 21:46:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260313132327.409785-3-anderson@allelesecurity.com>
References: <20260313132327.409785-3-anderson@allelesecurity.com> <20260313132327.409785-1-anderson@allelesecurity.com>
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
    edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
    horms@kernel.org, linux-afs@lists.infradead.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rxrpc: Fix key reference count leak in rxrpc_alloc_client_call()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3916441.1773870360.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Mar 2026 21:46:00 +0000
Message-ID: <3916442.1773870360@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269189-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,warthog.procyon.org.uk:mid]
X-Rspamd-Queue-Id: CE25F2C31E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Anderson Nascimento <anderson@allelesecurity.com> wrote:

> @@ -227,6 +227,7 @@ static struct rxrpc_call *rxrpc_alloc_client_call(st=
ruct rxrpc_sock *rx,
>  =

>  	ret =3D rxrpc_init_client_call_security(call);
>  	if (ret < 0) {
> +		key_put(call->key);
>  		rxrpc_prefail_call(call, RXRPC_CALL_LOCAL_ERROR, ret);
>  		rxrpc_put_call(call, rxrpc_call_put_discard_error);
>  		return ERR_PTR(ret);

It's probably better to do this in rxrpc_destroy_call() if we can as a las=
t
fallback.  In fact it's probably always leaking the call->key, not just un=
der
this circumstance.

David


