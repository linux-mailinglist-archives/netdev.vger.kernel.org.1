Return-Path: <netdev+bounces-220762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C51B488B0
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 11:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D39D188B88A
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EEF2EC55F;
	Mon,  8 Sep 2025 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOLWNka9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C17E292918
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324377; cv=none; b=rp+v+JUttz2K0Sel8JgXOSARS8lYPwAfRB7CLRh2oFBWTJDna8n4jPy+hF6B1wzOIR6BNm5WWrM/PWSukf/YeO0na7025Ftdy3CvrskTpcSfCLNqRBgSSimhbD0fv0zDicDK/uyhxD/FaTMVfXOXbnp+DbXc/4EdSnSmzzdh1lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324377; c=relaxed/simple;
	bh=frn6MTJWR//VJW92bdNtX5qG2M4LrHlltRbZnb5+cSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bwp9okAnmp5lsR6Q0CZ/cBMY+f7s7zOtGo9e4bxJUYcOr1Hdfqmx7EphggtZaXTx6IsNpLuERSIjh6EkrL0El/G7C8ILn/gOvU7nFoA8mcWmvCX4SkDiprUnup3pnVq7wIRNOs+NfUAohnoZvS9IwOdItn8WhDasPi5g0BL6VW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iOLWNka9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757324374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lXf6ZTHJqw350jIUEEtaGMR8Q7V7MNq8Dan21RyLa+w=;
	b=iOLWNka9qjhG8f8DRJUubq35taj4jSuGbUYJjfMckJlnkZ0k+1Y6SjLhjlWsSiIxASuikE
	TZIMVMgxgHLMZIR6L1PLpY/tToidiYLuWNYdh5d1+Tm8qNqK82PWWrZjx5zm6w0+dzEfZN
	D8DztVhY/eHYTM63pf70v6z8HsTjh5s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-79M4r4PrOVOKNPsCyXw5pw-1; Mon,
 08 Sep 2025 05:39:33 -0400
X-MC-Unique: 79M4r4PrOVOKNPsCyXw5pw-1
X-Mimecast-MFC-AGG-ID: 79M4r4PrOVOKNPsCyXw5pw_1757324371
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA3911800365;
	Mon,  8 Sep 2025 09:39:30 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB3571800446;
	Mon,  8 Sep 2025 09:39:25 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v5 0/5] dpll: zl3073x: Add support for devlink flash
Date: Mon,  8 Sep 2025 11:39:19 +0200
Message-ID: <20250908093924.1952317-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add functionality for accessing device hardware registers, loading
firmware bundles, and accessing the device's internal flash memory,
and use it to implement the devlink flash functionality.

Patch breakdown:
Patch1: helpers to access hardware registers
Patch2: low level functions to access flash memory
Patch3: support to load firmware bundles
Patch4: refactoring device initialization and helper functions
        for stopping and resuming device normal operation
Patch5: devlink .flash_update callback implementation

Changes:
v5:
* additional fixes for issues reported by Jakub
v4:
* fixed issues reported by Jakub (see patches' changelogs)
v3:
* fixed issues reported by Przemek (see patches' changelogs)
v2:
* fixed several warnings found by patchwork bot
* added includes into new .c files
* fixed typos
* fixed uninitialized variable

Ivan Vecera (5):
  dpll: zl3073x: Add functions to access hardware registers
  dpll: zl3073x: Add low-level flash functions
  dpll: zl3073x: Add firmware loading functionality
  dpll: zl3073x: Refactor DPLL initialization
  dpll: zl3073x: Implement devlink flash callback

 Documentation/networking/devlink/zl3073x.rst |  14 +
 drivers/dpll/zl3073x/Makefile                |   2 +-
 drivers/dpll/zl3073x/core.c                  | 362 +++++++---
 drivers/dpll/zl3073x/core.h                  |  33 +
 drivers/dpll/zl3073x/devlink.c               | 156 ++++-
 drivers/dpll/zl3073x/devlink.h               |   3 +
 drivers/dpll/zl3073x/flash.c                 | 665 +++++++++++++++++++
 drivers/dpll/zl3073x/flash.h                 |  29 +
 drivers/dpll/zl3073x/fw.c                    | 419 ++++++++++++
 drivers/dpll/zl3073x/fw.h                    |  52 ++
 drivers/dpll/zl3073x/regs.h                  |  51 ++
 11 files changed, 1695 insertions(+), 91 deletions(-)
 create mode 100644 drivers/dpll/zl3073x/flash.c
 create mode 100644 drivers/dpll/zl3073x/flash.h
 create mode 100644 drivers/dpll/zl3073x/fw.c
 create mode 100644 drivers/dpll/zl3073x/fw.h

-- 
2.49.1


