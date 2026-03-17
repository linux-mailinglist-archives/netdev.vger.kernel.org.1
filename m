Return-Path: <netdev+bounces-268649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MT3JnpwuWm8EgIAu9opvQ
	(envelope-from <netdev+bounces-268649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:17:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F13682ACD1E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F20E30E794F
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAB63EB7FF;
	Tue, 17 Mar 2026 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YS3Tl2+O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDD93EAC69
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760151; cv=none; b=piuPF3R/0diE2t7d5QeojCOioJX5c2QEq9HjCb1hTpkeGtWyKsjH4qA1f85uxAGU2wRlAnksiIWTmU5zlyNWQxi6qRqRwtRtPPbCdrlCfhIfCBhzX1WNi1cCXlyklTER4xNmvLnmv17RcBuXADUz3g55iTRHA9LPc756LTZQUaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760151; c=relaxed/simple;
	bh=wtHHM/I1oS3G1oE4TeCP9+YpOBG+rFOYjr+OJxN89Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tR6H3BYvtkpaJV1BRmly167g/dzabVAtn3bImYIcsp9oowavg0X1UIN8hqeZFVk57p0b5DELzD+c3ggjM4eHdQ23Hdux9gjOky4OBNDIXTwnviabblh6h4J0HWsPHuhB/CfPsqDOXssmuvU2cz2UWQW+oe7zOg8RlZc88sYj5bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YS3Tl2+O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773760149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bMomWsv/a3QHLhi+jI8oKvpdw53x5AlmZsAKVUThLi4=;
	b=YS3Tl2+OEu9SN+drcVBdHMWGMAdX1zsgDggjhwMXtw9veRPNgecFs329Tl5rAQg75vf77a
	v/qp3slJ9cFXSmDGD0cKme8JKUBzI1KOtX/NKgz8J9g0vKrnXxSn4nBC9tmkahpybo3yw7
	W5+rJ8cGO2opttZteDyVgVibFeSdU98=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-rfAOx7S3NTytiZ__-Q0E9A-1; Tue,
 17 Mar 2026 11:09:05 -0400
X-MC-Unique: rfAOx7S3NTytiZ__-Q0E9A-1
X-Mimecast-MFC-AGG-ID: rfAOx7S3NTytiZ__-Q0E9A_1773760143
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3056D1800365;
	Tue, 17 Mar 2026 15:09:03 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.224.95])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9BFC1955F19;
	Tue, 17 Mar 2026 15:08:58 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next v3 0/3] netdevsim: support ETS offload
Date: Tue, 17 Mar 2026 16:06:07 +0100
Message-ID: <cover.1773759815.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268649-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F13682ACD1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 - patch 1 moves netdevsim tc offloads to a dedicated file
 - patch 2 enables ETS offload on netdevsim
 - patch 3 is a tdc test for ets offload on netdevsim

v2: don't use x-macro (Jakub Kicinski)
v3: move function declaration from the bottom of netdevsim.h (Jakub Kicinski)

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


