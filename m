Return-Path: <netdev+bounces-249829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7064BD1EBC1
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BD9030010DD
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 12:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81737395275;
	Wed, 14 Jan 2026 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbjC6k+3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E21428469E
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393662; cv=none; b=YJruPB7ZtH7Qrr84O2/CGu9Nv7CqmXk8RmFqbNR9E9GjF3L1bSqjBAXjPc/opJY48hyVitNiYemv0BPT73QhlV+R/IpzxHUwzDE6m7r38geqUheGmaQXOcmDG4XuQtHKv+41LUspnkuPRgew9Gb12qzYvMk+QRx4I+gABVK+7oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393662; c=relaxed/simple;
	bh=RRMPE5Uwe3bGl6crR830X1+0XSG+3d4rfva3zN8Drvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNZiB9DqWAk5JzNkpaVDp2E6Xh2DnO12BRic6/rgtyznpHFQDU4CBBhyOOXMx43qbzbEPd7zLg6EJVyXjblM28fb9sJmFkSOLkLVF1rIyf0cIjahIBgaUxq1A67fbSID0yyp0UyEEr74F/9u/DGxQ0MHRNhheW4b5AiRMFV9nVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EbjC6k+3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768393660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E37khAmOowy5nW9WqJmZa4Qtgnu7VDjSJG9/3jN2iBY=;
	b=EbjC6k+3OARQwrQXfNe6j4+3ByvScuI3T+Qq1FdV+p5He7emQfRYAW0Riq75t9gjk/mPds
	PWi7+o5GjYSYDkw1HEmYY6sGEtybKHArIIKcwaXivMusFFpGrOjX4RkQeMkEtdnRXcUrS/
	QIqAOtkGNMCAt7qOHwQFqkv0Qcf7Ywc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-8xD9JA1BNkOeOSltyDCPsg-1; Wed,
 14 Jan 2026 07:27:34 -0500
X-MC-Unique: 8xD9JA1BNkOeOSltyDCPsg-1
X-Mimecast-MFC-AGG-ID: 8xD9JA1BNkOeOSltyDCPsg_1768393653
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FD4D19560B2;
	Wed, 14 Jan 2026 12:27:32 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E0A21956048;
	Wed, 14 Jan 2026 12:27:28 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Petr Oros <poros@redhat.com>,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>
Subject: [PATCH net-next v3 0/3] dpll: support mode switching
Date: Wed, 14 Jan 2026 13:27:23 +0100
Message-ID: <20260114122726.120303-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This series adds support for switching the working mode (automatic vs
manual) of a DPLL device via netlink.

Currently, the DPLL subsystem allows userspace to retrieve the current
working mode but lacks the mechanism to configure it. Userspace is also
unaware of which modes a specific device actually supports, as it
currently assumes only the active mode is supported.

The series addresses these limitations by:
1. Introducing .supported_modes_get() callback to allow drivers to report
   all modes capable of running on the device.
2. Introducing .mode_set() callback and updating the netlink policy
   to allow userspace to request a mode change.
3. Implementing these callbacks in the zl3073x driver, enabling dynamic
   switching between automatic and manual modes.

Changelog:
v3 - fixed reverse xmas tree order in dpll_mode_set()
v2 - addressed issues reported by Vadim

Ivan Vecera (3):
  dpll: add dpll_device op to get supported modes
  dpll: add dpll_device op to set working mode
  dpll: zl3073x: Implement device mode setting support

 Documentation/netlink/specs/dpll.yaml |   1 +
 drivers/dpll/dpll_netlink.c           |  71 ++++++++++++++--
 drivers/dpll/dpll_nl.c                |   1 +
 drivers/dpll/zl3073x/dpll.c           | 112 ++++++++++++++++++++++++++
 include/linux/dpll.h                  |   5 ++
 5 files changed, 182 insertions(+), 8 deletions(-)

-- 
2.52.0


