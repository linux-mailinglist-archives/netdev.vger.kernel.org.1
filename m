Return-Path: <netdev+bounces-248949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 353A3D11C20
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 11:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCA403002286
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 10:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B0029A9FE;
	Mon, 12 Jan 2026 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Efk8wGTw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4B529BD87
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212864; cv=none; b=V01u6LzR/oCnYaxPM4qK3wRpeJpssnFXgBF8KiTqoLDM0C6FC0fl26zV8vs/jv5CYRLeEPcI8cDPijdj8Uygek3b7e17yCzLE8wSfV3jvnnxOr9e2iw0W490DigHiAWyPk+rCMdXLg51v29ExdXq5SVxIjWjIjVeUyajCGw5oOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212864; c=relaxed/simple;
	bh=U7rcsAy0C1SDW2IF6ZI2vQASrV+uPclfYRSHrzoU5qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mOfJdOVJh1E0jY9LjiUnedxmnL3SqfZcv650YBOGs8baKu5Pu3F2JKCIZtdSYF+5FNWEKlp776Fm8369lpcQKPjnRcFYJywOR4ZLdx2TKcAhJhCTY0GDvoz9Xa9C3a02oQF14zZLUe6hX1a20yr+nIZmmg9HBGWExDOJTnJ26hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Efk8wGTw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768212861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7x/u06KzAqUE68taglVCz2s/+hHqiQTSFSrIPu82tkg=;
	b=Efk8wGTwOtTi5nlSECMYEcYZIQ3SfS1a+E9nXmF1LM4y4fv+xXzN3+j5DLIJMcPOm0+uBG
	lKLoChA4nq8PWUXBbIW9fVbXWfCXh4zFSREZ52iIYRUleY1+4o+Rj2e7Vd2+vmWtJUU2t3
	Wfcd58pSMftmVGHqftcvlwHGfLIkgD8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-r5Aq6wXPOfi8h4LEl2ulKA-1; Mon,
 12 Jan 2026 05:14:18 -0500
X-MC-Unique: r5Aq6wXPOfi8h4LEl2ulKA-1
X-Mimecast-MFC-AGG-ID: r5Aq6wXPOfi8h4LEl2ulKA_1768212856
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE35218005AF;
	Mon, 12 Jan 2026 10:14:15 +0000 (UTC)
Received: from p16v.bos2.lab (unknown [10.44.32.158])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 434141800665;
	Mon, 12 Jan 2026 10:14:11 +0000 (UTC)
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
Subject: [PATCH net-next 0/3] dpll: support mode switching
Date: Mon, 12 Jan 2026 11:14:06 +0100
Message-ID: <20260112101409.804206-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

Ivan Vecera (3):
  dpll: add dpll_device op to get supported modes
  dpll: add dpll_device op to set working mode
  dpll: zl3073x: Implement device mode setting support

 Documentation/netlink/specs/dpll.yaml |   1 +
 drivers/dpll/dpll_netlink.c           |  71 +++++++++++++++--
 drivers/dpll/dpll_nl.c                |   1 +
 drivers/dpll/zl3073x/dpll.c           | 106 ++++++++++++++++++++++++++
 include/linux/dpll.h                  |   5 ++
 5 files changed, 176 insertions(+), 8 deletions(-)

-- 
2.52.0


