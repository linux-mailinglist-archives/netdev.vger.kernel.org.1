Return-Path: <netdev+bounces-276341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJIoJXwN1mmfAwgAu9opvQ
	(envelope-from <netdev+bounces-276341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:10:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 330D23B8CAE
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25DA93033D18
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8953C39D6C3;
	Wed,  8 Apr 2026 08:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ae8CUc5g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A25939BFE6
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635746; cv=none; b=SSZJ8Vk1ZDDG98p5xIo8Bo3yvSZ28RvwaPIF37yCVbXE9J57nFwhfboIhROn1hvrseNpc32zil0cZ6o+MbOmyHqMewTSlA3InZvdSAKpMxD2oz/ZTCANlO83bNCZKtHGCv6ImpcYMDB3uMU+kfNRAdGWV/8eBA4ozKP0VGgo0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635746; c=relaxed/simple;
	bh=mLt2C0s2KyAsNwVLTTv7BbRoRfLCKUrwFZgp0QRxVEE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=i2knntKkg2IBI/obUE2Dupz61kaAsRLH364DAKH4W0+orhaECQbK9MCQXXcXhiMTeGYEljiSQv/7hQ7Wio8QHNRs/Zuj39hBHk/THfaPgVxac5tSczTxNh8MtdbgXg5q1kEuqsXJ6kc+bYB3dfde31bdTP5FwrZnTowrhRC7oR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ae8CUc5g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775635743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zeEBLfMWwRXn7LjfjGZoPqN0AzwNh8KR8qE3RA3PjVM=;
	b=ae8CUc5gdcpd06yTfN3jSEnfeqpK6/Yjk+Iw5bieVeUM7a5qCdB2QLeumXcsKRaDA7Q3Rn
	N6kVMFzdqEgVUTRgtpHs+VRI16iKITSOUwTwXeVyKL7wGxGbBUkbbMLcmsqHqYGcNXfCwt
	P44406PSXsoe7o4kpkQBqJIVKnRUCgE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-dSMkaXfsNCe2IJmji36-Dw-1; Wed,
 08 Apr 2026 04:08:59 -0400
X-MC-Unique: dSMkaXfsNCe2IJmji36-Dw-1
X-Mimecast-MFC-AGG-ID: dSMkaXfsNCe2IJmji36-Dw_1775635738
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8574E1956056;
	Wed,  8 Apr 2026 08:08:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E11FE1800768;
	Wed,  8 Apr 2026 08:08:53 +0000 (UTC)
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
Content-ID: <2207315.1775635732.1@warthog.procyon.org.uk>
Date: Wed, 08 Apr 2026 09:08:52 +0100
Message-ID: <2207316.1775635732@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276341-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[iscas.ac.cn:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,warthog.procyon.org.uk:mid]
X-Rspamd-Queue-Id: 330D23B8CAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> -	char lbuff[50], rbuff[50];
> +	char lbuff[RXRPC_PROC_ADDRBUF_SIZE], rbuff[RXRPC_PROC_ADDRBUF_SIZE];

This might be saved upstream by the compiler padding the buffers out to
sizeof(long) because they're on the stack.

David


