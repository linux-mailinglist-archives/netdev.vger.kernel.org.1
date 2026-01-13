Return-Path: <netdev+bounces-249425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DE4D18A92
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 13:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 895F8300E014
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 12:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC6138F22D;
	Tue, 13 Jan 2026 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgNqBv0n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B655536657B
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306610; cv=none; b=H/B07fjojJdr8tIUvbMWHPb5hsxEuQB0qdFrUwP9nqG8hcRR+hDuQGvhFqwsMpndTz+oFVa60NzZD/eBWYpL0pAhgi2dEI7bxcK/yObpKtrR5H/Zv65lLEw4d7W3qqqjvd8EdQ+gvhqeasot0itj9d6A7M29tw2z1h+w5shw5NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306610; c=relaxed/simple;
	bh=15XRqH7R/RxGogfgkL4oC0Xx7K1JIHEOSLhERD77Qnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JPU1+iQw4jIQV4F+biQsMmPeHjt1UEDxCgx2HTWeFOuL6xBmgI6R1qjQGVzN6vHe9WjwpXSSdxM2UTI5XPx9xlYj5ZT/s8bcXdxdIgwxv5AP4gP2Rac3Dpvvxu4G6UUrsm6jSMNSfWqlY5Elrifp79uu3VQeNFhDnKE7i5LNWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TgNqBv0n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768306607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0JNGNvBziTaoOvYW4PsewM8UhjwXEaQNNqkgeKTFmuA=;
	b=TgNqBv0npJYyMs9wzbC0Wbm4DAuA9j7dZLNZ0u/xSJiZ7X5ttYYKTb7/om+W7sSiHHGZO9
	u8wndwAjX0UhYjYt6EfWINM3VC6DgTcvQTLx6puG+lUdaDTZ8suRtvAhdmHqeSlBnRv7/t
	jzsQr4vwhlJRW0jlmV1MrcRTOD6limY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-NU9MEMljPW27twYVFiuXTg-1; Tue,
 13 Jan 2026 07:16:44 -0500
X-MC-Unique: NU9MEMljPW27twYVFiuXTg-1
X-Mimecast-MFC-AGG-ID: NU9MEMljPW27twYVFiuXTg_1768306602
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A475180035C;
	Tue, 13 Jan 2026 12:16:42 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A877A19560AB;
	Tue, 13 Jan 2026 12:16:37 +0000 (UTC)
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
Subject: [PATCH net-next v2 0/3] dpll: support mode switching
Date: Tue, 13 Jan 2026 13:16:33 +0100
Message-ID: <20260113121636.71565-1-ivecera@redhat.com>
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


