Return-Path: <netdev+bounces-260418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPKYJzNsnWnhPwQAu9opvQ
	(envelope-from <netdev+bounces-260418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:15:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34523184669
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34E8A31412A0
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B6C36A025;
	Tue, 24 Feb 2026 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gT/wZBrf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A905336A01A
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924375; cv=none; b=TpAKjbgmwhk+uJi8TJ4xdcw/GkGpvrZUkufBR5lB21BOKy2ogP85O3cnpnneNIXMkwbkJ3juZ7Cdb5TRFBZfDr4g69uo9WM0L+NgndrUxdcACeBnq0ykuS1AxtbLx3x8jXSfaLiBfcVV7V8DI0zrBMkbVoyQnCbaP7kVD0lvy8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924375; c=relaxed/simple;
	bh=Pvoo+QrzR1TNxTX6h7C7DC0P+HbuipE93JDHn62K2EI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QgQz8BFFtWMyYktilEZMhufXdhEv2Jv+ueOh7c+REBjreUVgiweRXnmKCCNDO2OaEKP9NjGkeq8/JRAnwkMCKIBslz5VbBSF7FOR6g+Pxew+PRplCr7jTBuwYFD/lPuiwd7fIW8Jc/GktiJSjqh2wzlxWhALcSkO7L8NKT7gGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gT/wZBrf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771924373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xEe9Fxu2h6vOMZdzmnVoxmVFdYeutTNRi4iDzPCUJ3w=;
	b=gT/wZBrfMQSGv2V5ED9vd2GLkOll7ZJggOWIFAoJZvdyZuTReOs4RNCIsXDaie65gtrPwK
	jmAwEb5h9ijlzP0Y3+W/gt3egKPf5YfTnIFoMRfjw8KHUkQnODDTWWHnAuusFEtBisafyB
	qh51PMnrKdOQeyGAMEE3dWRfUvCJ/n0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-t2gjHirGP_6qdwE9cuN4-w-1; Tue,
 24 Feb 2026 04:12:50 -0500
X-MC-Unique: t2gjHirGP_6qdwE9cuN4-w-1
X-Mimecast-MFC-AGG-ID: t2gjHirGP_6qdwE9cuN4-w_1771924369
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 108521956052;
	Tue, 24 Feb 2026 09:12:49 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.225.132])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A1FDB1955F43;
	Tue, 24 Feb 2026 09:12:47 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next 0/4] dpll: add client-side filtering
Date: Tue, 24 Feb 2026 10:12:39 +0100
Message-ID: <20260224091243.58501-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260418-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34523184669
X-Rspamd-Action: no action

This series fixes a parsing bug in dpll pin id-get and adds
client-side filtering support for dpll device show and pin show
commands.

Patch 1 fixes a bug where "dpll pin id-get type gnss" would read
the keyword "type" as the enum value instead of the actual type.

Patches 2-3 add client-side filtering for device show and pin show.
Users can filter output by various attributes (module-name, clock-id,
type, etc.) with AND semantics. Kernel-side dump filtering for dpll
is not yet available, so all filtering is done in userspace.

Patch 4 replaces the non-functional server-side "device" filter in
pin show (kernel ignores DPLL_A_ID in pin dump requests) with
client-side parent-device and parent-pin filtering that checks
nested multi-attrs. The argument is renamed from "device" to
"parent-device" to reflect the actual semantics.

Each patch includes corresponding man page and bash completion
updates.

Petr Oros (4):
  dpll: fix pin id-get type filter parsing
  dpll: add client-side filtering for device show
  dpll: add client-side filtering for pin show
  dpll: add pin filtering by parent-device and parent-pin

 bash-completion/dpll |  55 +++++-
 dpll/dpll.c          | 387 ++++++++++++++++++++++++++++++++++++++++---
 man/man8/dpll.8      |  80 ++++++++-
 3 files changed, 488 insertions(+), 34 deletions(-)

--
2.52.0


