Return-Path: <netdev+bounces-277088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCGULx/k12kVUQgAu9opvQ
	(envelope-from <netdev+bounces-277088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:38:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1103CE3A4
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A01A23037D43
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 17:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5B03AA4E5;
	Thu,  9 Apr 2026 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glYRh29D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0A52DA775
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775756245; cv=none; b=bIBEtfu18Wc1/vZfYUYiTCBUZELFFNs2vEMERbmAiJmN7uTHi/m45jVtoXULzaS1DEPwe1d4eio3adINxvVE+ueBvI9uF0QqN1aKQk8GZFbV6DfBzJfN4CfX4Dm3nNffY8q1egSfFED2Z2ABBwk0Yu8JG6/Wcu7OIAItoW2rBQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775756245; c=relaxed/simple;
	bh=a63k0bx3cRG6TjOyfrDArgLRA9ovNJvMUrr3yOCUuxU=;
	h=In-Reply-To:References:To:Cc:Subject:MIME-Version:Content-Type:
	 From:Date:Message-ID; b=lWetpB96V72lRiVAxd78bI9RgUujTMerwnJ1HamooxD8YKKEDNqJW5+p7AVUSB9Zd8tRTa4j2ecvFiuvDnEz/IJVDuMNf0IH80nwqWLYRdjjjTCGXlq+tGzkbTfZn2GxMxm3EbbUNeGSLrjpJKtCN8gjCZ9dKXvml3vmKHbD7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=glYRh29D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775756243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nffPNSW2MkPDKaf79tbQo0yLAbEX2cyy28WA2Y32fCE=;
	b=glYRh29DT6llRAIttikruSB3FmUIW+maZqrWZMxgEU3vGwkPwqfF1szok0mIwYYA4SeHNU
	gnrs6yFQ1ewoHEiYxKPWrjpcnHrmdGOpLLQb5zbsDxSaGrueaCS/OsXFlkrzHu0RRCuS0B
	8AoKjObCwGU1GO2biJKUDCWa0Z5MS0g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-Na4VCd5XO16VyND_FxAwww-1; Thu,
 09 Apr 2026 13:37:19 -0400
X-MC-Unique: Na4VCd5XO16VyND_FxAwww-1
X-Mimecast-MFC-AGG-ID: Na4VCd5XO16VyND_FxAwww_1775756237
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37B231956054;
	Thu,  9 Apr 2026 17:37:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.47])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B331195608E;
	Thu,  9 Apr 2026 17:37:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <20260409073711.57020-6-thorsten.blum@linux.dev>
References: <20260409073711.57020-6-thorsten.blum@linux.dev> <20260409073711.57020-4-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: dhowells@redhat.com, Jarkko Sakkinen <jarkko@kernel.org>,
    Kees Cook <kees@kernel.org>,
    "Gustavo A. R. Silva" <gustavoars@kernel.org>,
    netdev@vger.kernel.org, keyrings@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND net-next 2/2] KEYS: annotate struct user_key_payload with __counted_by
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2442664.1775724997.1@warthog.procyon.org.uk>
From: David Howells <dhowells@redhat.com>
Date: Thu, 09 Apr 2026 18:37:13 +0100
Message-ID: <2641132.1775756233@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277088-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A1103CE3A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thorsten Blum <thorsten.blum@linux.dev> wrote:

> +			__aligned(__alignof__(u64)) __counted_by(datalen);

Can that be __aligned(8)?

David


