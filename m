Return-Path: <netdev+bounces-268895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMUEIj9Tumm8UQIAu9opvQ
	(envelope-from <netdev+bounces-268895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:24:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C262B6E1C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94FD330417A0
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561FB369988;
	Wed, 18 Mar 2026 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ya/NWwCt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD79B30648C
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773818487; cv=none; b=Fen6JTGNfX0m3CP1GMmSWsrC68F5PBVDb6KeCPLQiM8HoBIfsHj0oqbrzr34UEtTmQhJPrC88mh6Qm0qsEXjxyQEHnvI0HxnX8O7yY95O2CbJwExTOqZmyyfh8Z0t7GZdWLVV/K+xwnE+lPng8in+UcZD03CmvWyfeoUFa6JzZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773818487; c=relaxed/simple;
	bh=jWI+fZMdaa7C6bdHNsC42By7A9pHxAKy5ZjrcxXIyOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGTuDOMGzBHpuoOjU6giMTqg2o+aZitPC+zc8kYR1+vCPo60zkU0FU4k4xDUBcIKG9kmMcg2cX2vDcoOfr/M9G2YE3SVnG7mSDVMHKjbl67t5lgPw75k0PLzRbX74himLTP+JXaQjB8/Xv/Uzv/4geYJfu0eb/DDbq3oB+hcXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ya/NWwCt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773818484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qUtMnyvJ48a8DiNLaO779bigs+p52aLvbezA9QZoYCk=;
	b=Ya/NWwCtvqmVQtqSZ+IJUQVut5fIlSlBLcP30Nve8WWiLrgqOxaEGfPLGP1kt5M5Flq/W5
	cm84YAWzG5hEhtL5rVuUihGdNk8zPQ1q3QLu4JWPRwLI1QeC0FeH1P5P37Ce2GgtJ0HnJg
	RwuWnRR5eurLlo+t9+Jls8oASnIo40E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-VCYDempFPY2KX6U7Cs3fdg-1; Wed,
 18 Mar 2026 03:21:20 -0400
X-MC-Unique: VCYDempFPY2KX6U7Cs3fdg-1
X-Mimecast-MFC-AGG-ID: VCYDempFPY2KX6U7Cs3fdg_1773818479
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2912B1944DC4;
	Wed, 18 Mar 2026 07:21:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.192])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF81419539A0;
	Wed, 18 Mar 2026 07:21:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: ouster@cs.stanford.edu
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: Re: [net-next,v17,03/14] net: homa: create shared Homa header files
Date: Wed, 18 Mar 2026 08:20:22 +0100
Message-ID: <20260318072022.268417-1-pabeni@redhat.com>
In-Reply-To: <20260316223228.2611-4-ouster@cs.stanford.edu>
References: <20260316223228.2611-4-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268895-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 00C262B6E1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: homa: create shared Homa header files

homa_impl.h defines "struct homa", which contains overall information
about the Homa transport, plus various odds and ends that are used
throughout the Homa implementation. homa_stub.h is a temporary header
file that provides stubs for facilities that have omitted for this first
patch series. This file will go away once Homa is fully upstreamed.

> diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
> new file mode 100644
> index 000000000000..f55a7b80431d
> --- /dev/null
> +++ b/net/homa/homa_impl.h

[ ... ]

> @@ -0,0 +1,512 @@

[ ... ]

> +/**
> + * homa_set_doff() - Fills in the doff TCP header field for a Homa packet.
> + * @h:     Packet header whose doff field is to be set.
> + * @size:  Size of the "header", bytes (must be a multiple of 4). This
> + *         information is used only for TSO; it's the number of bytes
> + *         that should be replicated in each segment. The bytes after
> + *         this will be distributed among segments.
> + */
> +static inline void homa_set_doff(struct homa_data_hdr *h, int size)
> +{
> +	/* Drop the 2 low-order bits from size and set the 4 high-order
> +	 * bits of doff from what's left.
> +	 */
> +	h->common.doff = size << 2;
> +}

Does the comment in homa_set_doff() accurately describe what the code
does? The comment says "Drop the 2 low-order bits from size" which would
be a right shift (size >> 2), but the code performs a left shift
(size << 2).

Looking at similar usage patterns in TCP where the doff field stores
header length in 4-byte word units, the code appears correct - it's
converting a byte size to 4-byte word units by shifting left.

The comment should probably say "Shift size left by 2 bits to store in
4-byte word units" or "Multiply size by 4 and store in doff field" to
match what the code actually does.

[ ... ]


