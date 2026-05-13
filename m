Return-Path: <netdev+bounces-287632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA5zJFSQBGoVLgIAu9opvQ
	(envelope-from <netdev+bounces-287632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:53:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D186535815
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B632301954D
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3397B38CFEE;
	Wed, 13 May 2026 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTP6ml7T"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B3B38D3EA
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683886; cv=none; b=solEfduxkGc4QnycEo2iUWHznvYSNFZC+zkO5+bHLxdxPY6VKFAjS+zgaYwFgMY67hMrf0RuCg3oqKSFhEYvIHenSQpLopr6Q1a5xIdqdsFY5asWIGHOby0ld4yD/0EELOO0MFnfNPcTMuViIzQGutjiWM4Yw+k9b2HKPmvreXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683886; c=relaxed/simple;
	bh=h3B710Bu9q651nbKQmewlEWYUEMfge7ZF0/aZSG0+h0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hy4kCJGONQcDh0XOpWwV3apTDUXwKdjQjxAarZtLEMBTPKcOjz7YdOtGCRHHT87aIgATGDIjaFPDD7P3vVnjo3t5sStec29w7E7bm3u1ASiBIyDVjAETbKUXedKoAqXh+mFr/vibh2Ky89PXU8hE/1fPGxYp9p/3Q4NsTmljfvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTP6ml7T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778683883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=42PscUWVHpuBWuxDRa4lkspQENM93hO1UgQyDx1RJE0=;
	b=UTP6ml7T86KAORKh333VDb+hKb2ajm2fwecJfZxfL2xXlF5Q7IubCnHpt2bqhw3Tqr2an7
	2OkuW0FBz5Qk9Xs9uUQjKkKLkUqUD1V035UiITyQM7V3z+GmH73g62DpaSN7UInVCpHzTp
	olehazcqBG6PvE1+DBwZXT3JNi1Cl6Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-jVmZ_H3WP-CdHXL9Xga_nA-1; Wed,
 13 May 2026 10:51:20 -0400
X-MC-Unique: jVmZ_H3WP-CdHXL9Xga_nA-1
X-Mimecast-MFC-AGG-ID: jVmZ_H3WP-CdHXL9Xga_nA_1778683879
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC0AE195607B;
	Wed, 13 May 2026 14:51:18 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33E5C19560A2;
	Wed, 13 May 2026 14:51:16 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 0/2] dpll: add pin operstate and fractional frequency offset to parent-device
Date: Wed, 13 May 2026 16:51:13 +0200
Message-ID: <20260513145115.174597-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 2D186535815
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287632-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add support for two new pin-parent-device nested attributes:

Patch 1 adds pin operstate attribute support with filtering.
Patch 2 adds fractional-frequency-offset (PPM/PPT) display in the
parent-device context alongside the existing top-level attributes.

Ivan Vecera (2):
  dpll: add pin operstate attribute support
  dpll: add fractional-frequency-offset to parent-device

 bash-completion/dpll |  7 +++-
 dpll/dpll.c          | 77 ++++++++++++++++++++++++++++++++++++++++----
 man/man8/dpll.8      | 18 +++++++++--
 3 files changed, 93 insertions(+), 9 deletions(-)

-- 
2.53.0


