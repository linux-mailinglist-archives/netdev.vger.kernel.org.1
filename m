Return-Path: <netdev+bounces-267541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MnbIIZItGk4kAAAu9opvQ
	(envelope-from <netdev+bounces-267541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:25:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F33FD288164
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 380533019911
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F403313267;
	Fri, 13 Mar 2026 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQJNs5T7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150A31DF970
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773422662; cv=none; b=G21J6RN2K3jnamXop8N0Ib1e3Ohuc89ZuSP1bfgA6clgf05iOI2K1orlLLQUC3iLEfMJ37uOeIIjRPJhIcL92IdyDt3X7yGTEs36aUfIa4DI7udk0BhwVKC0ZFyeEdXh9nm77M/amnYSKPkRxEfWi58RPGrop7r9Cg/6A+2vnSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773422662; c=relaxed/simple;
	bh=4qVu06dwwDjxred4PXG8X64uHPhdN/1VnP042RvyxLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IS4FE3HyerbO+R5QgeUaY9nChmBMq30f1JdiakiEDV6BXnCSp0KXxwYpdCSuzXm4yWlgLXKO3LrMw4ksve62870+FxXiXmdEN1UXuyLS6ERuLT6BtMrQ/4D4rOtJnr4P6cNxelm77ECSHiYvVpXVNzVYdAJcVAcJi4rc5XSjUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQJNs5T7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773422659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s7Xjx3nwWvf5KpwtKum8QjCKKdCjQMAGt9WJCPXKccI=;
	b=eQJNs5T7wX5RkJ5pa0XWCv08+vmMI+BTSvnjjDRzZVCYAvWmgYn0WYhJ3MJaQg+WHbyl10
	v8F3GeFIJCf1Q9FGoxO5Si7oLRZfA9EzOb6DqN2mQ0ktoy0aqgyCqoBX2NVsgjTx9hUG+Q
	18YkpiMfFjLUSkeT1eChJ2hQujIIL6c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-Y0G25lDoPWuqQ5-XOZloJQ-1; Fri,
 13 Mar 2026 13:24:16 -0400
X-MC-Unique: Y0G25lDoPWuqQ5-XOZloJQ-1
X-Mimecast-MFC-AGG-ID: Y0G25lDoPWuqQ5-XOZloJQ_1773422655
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F167195608F;
	Fri, 13 Mar 2026 17:24:14 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.44.33.226])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C02D219560B7;
	Fri, 13 Mar 2026 17:24:10 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next v2 0/3] netdevsim: support ETS offload
Date: Fri, 13 Mar 2026 18:23:55 +0100
Message-ID: <cover.1773411667.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267541-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F33FD288164
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 - patch 1 moves netdevsim tc offloads to a dedicated file
 - patch 2 enables ETS offload on netdevsim
 - patch 3 is a tdc test for ets offload on netdevsim

v2: don't use x-macro (Jakub Kicinski)

Davide Caratti (3):
  netdevsim: move TC offload code to a dedicated file
  netdevsim: support tc-ets offload
  tc-testing: add a test case for ETS offload

 drivers/net/netdevsim/Makefile                |  2 +-
 drivers/net/netdevsim/netdev.c                | 51 ------------
 drivers/net/netdevsim/netdevsim.h             |  3 +
 drivers/net/netdevsim/tc.c                    | 79 +++++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/ets.json       | 23 ++++++
 5 files changed, 106 insertions(+), 52 deletions(-)
 create mode 100644 drivers/net/netdevsim/tc.c

-- 
2.52.0


