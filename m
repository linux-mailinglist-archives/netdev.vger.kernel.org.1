Return-Path: <netdev+bounces-251841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGNtKgyocGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:18:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F22C55196
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3307D608E07
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEC4480DEA;
	Wed, 21 Jan 2026 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAC+He0X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C4947DF91
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989919; cv=none; b=BabVO5Q7caJFJK6xN5h5nebOfMivR/kOsu7yshlskN2BOj2+GNWYRCMHNKsTx2/nBSDO31RTyeMLDpLPdShZ/ZcXeCuMap+X3gmCjINrv9h6Mbo5ordZ2HE/+6+nXEn5/IM2E6py/s2OOBt8AcvoJXRaIN2FAkPGBPHmvqV33Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989919; c=relaxed/simple;
	bh=nNSs7YokmRk1k1on08BdoALUpjc6jTLbZ3Q3VkoaYgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9NE5UsxOVE3mW/0bb/TFR0yxaqqEkp1oWajEdKq+JcLkwwwFeE+vPSIXP9zRK9xFd/EBqQuhOj1Ctf9RNi7ERl7aJZHVwSEvuF7yEekQeJE04O3BBnZnbd7DT32KTResCEWXiqhyJg5ZCkA1kZ66httNn2UJqxe91q6nWp9LzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WAC+He0X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768989917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1AOyQ4niMZQF0Ucl4X/QFKfMomvo3M8iWx16PQL5iA0=;
	b=WAC+He0XzrT7FpDpYCn9JKCHFq2lBkpyMqQ9GWcqygPGSmXlqX88qCCMlItZto+1JIucz+
	cg1zt4uJo3OEy2vbvry/Hx4vgn43FoMtiYv9PGOomjmH9XIxQxGB+PcU2wtHR8hycPB3hi
	Jun2rrJ9nueS69n/I5H/ZqqTCq4m1DY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-pQmYttFePfyuMJ-COpLlgg-1; Wed,
 21 Jan 2026 05:05:11 -0500
X-MC-Unique: pQmYttFePfyuMJ-COpLlgg-1
X-Mimecast-MFC-AGG-ID: pQmYttFePfyuMJ-COpLlgg_1768989910
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F73E18005B2;
	Wed, 21 Jan 2026 10:05:10 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.72.116.124])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 43E491800665;
	Wed, 21 Jan 2026 10:05:04 +0000 (UTC)
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
Subject: [PATCH net-next v6 0/7] selftest: Extend tun/virtio coverage for GSO over UDP tunnel
Date: Wed, 21 Jan 2026 18:04:54 +0800
Message-ID: <cover.1768979440.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-251841-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[xudu@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 8F22C55196
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The design strategy is to extend the existing tun testing infrastructure
to support this new use-case, rather than introducing a new or parallel framework.
This allows for better integration and re-use of existing test logic.

---
v5 -> v6:
 - Fix the Makefile format errors.

v5: https://lore.kernel.org/all/cover.1768800198.git.xudu@redhat.com/
 - Refactor the rtnetlink utilities to use YNL.
 - Use Geneve tunnel instead of VXLAN tunnel.
 - Revert tap refactor as YNL lacks macvtap support.

v4: https://lore.kernel.org/netdev/cover.1767597114.git.xudu@redhat.com/
 - Rebase onto the latest net-next tree to resolve merge conflicts.

v3: https://lore.kernel.org/netdev/cover.1767580224.git.xudu@redhat.com/
 - Re-send the patch series becasue Patchwork don't update them.

v2: https://lore.kernel.org/netdev/cover.1767074545.git.xudu@redhat.com/
 - Addresse sporadic failures due to too early send.
 - Refactor environment address assign helper function.
 - Fix incorrect argument passing in build packet functions.

v1: https://lore.kernel.org/netdev/cover.1763345426.git.xudu@redhat.com/

Xu Du (7):
  selftest: tun: Format tun.c existing code
  selftest: tun: Introduce tuntap_helpers.h header for TUN/TAP testing
  selftest: tun: Refactor tun_delete to use tuntap_helpers
  selftest: tun: Add helpers for GSO over UDP tunnel
  selftest: tun: Add test for sending gso packet into tun
  selftest: tun: Add test for receiving gso packet from tun
  selftest: tun: Add test data for success and failure paths

 tools/testing/selftests/net/Makefile         |  16 +-
 tools/testing/selftests/net/tun.c            | 898 ++++++++++++++++++-
 tools/testing/selftests/net/tuntap_helpers.h | 390 ++++++++
 3 files changed, 1265 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/net/tuntap_helpers.h


base-commit: c5e7b1d1cc8a6cb8b709eef34c93a9458427ab2e
-- 
2.52.0


