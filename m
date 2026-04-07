Return-Path: <netdev+bounces-275843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJtsHcpv1GkruAcAu9opvQ
	(envelope-from <netdev+bounces-275843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:45:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 770D73A9356
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 433B43004DAF
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 02:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FF81A317D;
	Tue,  7 Apr 2026 02:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaQOYSSt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D7372B37
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 02:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775529923; cv=none; b=okAxevMThQndcCFH3y57SG/y4sPFFKGCInBV1Ol6t3jClrXcaatqQLc1jnIM0nGGMHiXAlEdyyntmq/DQOJfA+8PIrQbm7RZNWN/+qWRnZ8cqFEIfwYK+msh2Tas65Y/NYmHucu8v2GWg7D7m2BUGC0Bu/szQ1Q90LK6Rydghqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775529923; c=relaxed/simple;
	bh=yQUOKSy6VfcfXDDIRY90Etg+nb+Y+n6W8ukWh0hXxsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sc1l84wr1Y4J59Iwgrsp8uA70ICr2aX3MIs/yLPDCWNcaXKAnA2XUD0esLrgRlRQjvmPIhyslvDNBQE6JcxWWdsZp/LzwHKfAg8vdwvAc84iB8brDq6g2hn4XyprKW2/ljDp1iTbZE2H2MuuikhzXTKrQIYPX5IFNYdue/cA9Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YaQOYSSt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775529921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FDDFUAQFNb512S/LxyDIQRQ2l8wUPzRCjDTUtKlW1rE=;
	b=YaQOYSSt4TGJLns0vabDwzdGckU3mh3r5LgWXfirxte3Bgt6MR9ublciPmG6kby18fsXTh
	Xy85/rDdXN0pOqhhqvzPKt8k/qBgj6PWb4qUK+7sYAsj0NJGMZglhyqK7C9ITtw4N3jAFk
	gVd29cPt5yVV20Gs15aWyLtLta9st2I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-yI-jBFHzNAyTZgkTk-uDZQ-1; Mon,
 06 Apr 2026 22:45:20 -0400
X-MC-Unique: yI-jBFHzNAyTZgkTk-uDZQ-1
X-Mimecast-MFC-AGG-ID: yI-jBFHzNAyTZgkTk-uDZQ_1775529918
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99E801800359;
	Tue,  7 Apr 2026 02:45:18 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.com (unknown [10.72.116.131])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95B6B300019F;
	Tue,  7 Apr 2026 02:45:14 +0000 (UTC)
From: Xu Du <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 0/4] selftests: drv-net: tso: add double tunneling GSO tests
Date: Tue,  7 Apr 2026 10:45:07 +0800
Message-ID: <cover.1775527362.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275843-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[xudu@redhat.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 770D73A9356
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series extends the TSO selftest (tso.py) to cover double-encapsulated
tunnel scenarios, ensuring that hardware offload and the kernel GSO path 
correctly handle packets with two layers of tunnel headers.

Xu Du (4):
  selftests: drv-net: tso: retry connect on EHOSTUNREACH
  selftests: drv-net: tso: add helpers for double tunneling GSO
  selftests: drv-net: tso: add Geneve double tunneling GSO test
  selftests: drv-net: tso: expand double tunnel GSO test coverage

 .../drivers/net/hw/lib/py/__init__.py         |   4 +-
 tools/testing/selftests/drivers/net/hw/tso.py | 267 +++++++++++++++---
 .../selftests/drivers/net/lib/py/__init__.py  |   4 +-
 .../testing/selftests/net/lib/py/__init__.py  |   4 +-
 tools/testing/selftests/net/lib/py/utils.py   |  19 +-
 5 files changed, 248 insertions(+), 50 deletions(-)


base-commit: 2f60df9e61aa48bf40c36254bf2e839f09cffd98
-- 
2.53.0


