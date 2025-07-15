Return-Path: <netdev+bounces-207175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE84B061DA
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9659C4A383F
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A608D1F7098;
	Tue, 15 Jul 2025 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsiyGR8F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC11EF36B
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590812; cv=none; b=HUzoRdQbqHQrrcCkXHpOZXa61Xhjo1CM1ubR2KyI5U488ujur5TZ9oee2EIbmyffXGDwccE0iZ2To46RE59Q5tBG9vjJOC3p1MGYutPm9HxewrlxbyCznaduOgEd92zIZfw5l3NP+SED7qh4gvz2VCQj0djOUaBEkpE1eGqve3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590812; c=relaxed/simple;
	bh=BHNFsVJgp3UXOwLMO63md6+vLI8302/jTGy35SCXoSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NANuyzFA9bLImuE7qk8HyGdTi2lKGDk4cuSN9nYWNVV2oq9+IR/0+wGN09uM5sSDHoFieP24Pfym6xprrVkYbvMr5O2YbUceFHS1zMe6uhAd6TCzEeqR837FrocGs16/62F9pO3/bdmHbpQLzgcHzKh9QgA3RrQyB/r9k6TD6QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WsiyGR8F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752590809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZeZIBHa9w6zHlOJ9URR1VQUp7AWpbsTzT7CBAvQ9n3I=;
	b=WsiyGR8FMu0IYSJihhnapETTiok9VcPqLXDnb6K4V3FxbHDacS4kAhogSKjnR0Jb7nLzi0
	uouiURmIX5eBHUrQGL4zqmCdKpNmEoKBzO65ijSMXU9GTUmXQ8HFy/IRrn4ZIVXdnvMTUL
	I/tR+x2/Og/2IDPbeQhs8QV8KttMYpQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-Lfnve5iDO1WlyWPh0VbE-g-1; Tue,
 15 Jul 2025 10:46:45 -0400
X-MC-Unique: Lfnve5iDO1WlyWPh0VbE-g-1
X-Mimecast-MFC-AGG-ID: Lfnve5iDO1WlyWPh0VbE-g_1752590803
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9082F195604F;
	Tue, 15 Jul 2025 14:46:42 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.225.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D85F19560A7;
	Tue, 15 Jul 2025 14:46:38 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v2 0/5] dpll: zl3073x: Add misc features
Date: Tue, 15 Jul 2025 16:46:28 +0200
Message-ID: <20250715144633.149156-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add several new features missing in initial submission:

* Embedded sync for both pin types
* Phase offset reporting for connected input pin
* Selectable phase offset monitoring (aka all inputs phase monitor)
* Phase adjustments for both pin types
* Fractional frequency offset reporting for input pins

Everything was tested on Microchip EVB-LAN9668 EDS2 development board.

Ivan Vecera (5):
  dpll: zl3073x: Add support to get/set esync on pins
  dpll: zl3073x: Add support to get phase offset on connected input pin
  dpll: zl3073x: Implement phase offset monitor feature
  dpll: zl3073x: Add support to adjust phase
  dpll: zl3073x: Add support to get fractional frequency offset

 drivers/dpll/zl3073x/core.c | 171 ++++++++
 drivers/dpll/zl3073x/core.h |  16 +
 drivers/dpll/zl3073x/dpll.c | 818 +++++++++++++++++++++++++++++++++++-
 drivers/dpll/zl3073x/dpll.h |   4 +
 drivers/dpll/zl3073x/regs.h |  55 +++
 5 files changed, 1062 insertions(+), 2 deletions(-)

---
v2:
* fixed Paolo's findings (see changelog in the patches)

-- 
2.49.1


