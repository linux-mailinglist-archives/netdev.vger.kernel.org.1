Return-Path: <netdev+bounces-213458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8729B25240
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 19:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91075680E5
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9402877FA;
	Wed, 13 Aug 2025 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/kmy6PH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4FB292B56
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107074; cv=none; b=cbp55Uh1/uJvFRinCcM2Py9g79huIe1uzbdXAkQHA7PaR3PmN+o+o6RMd9a90yCWte1pbpewbJZ1k6i/ZP4eQX1vTr1x0dq2E0eHhpNjtonoo+T+tIShRwCzqnrSkYJ0XID5PwJDkvBG+C7KLU62NXMyCUCeJ2QJgQbhL9t/Xdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107074; c=relaxed/simple;
	bh=IFqFGPgHnzL82Ynu8VaBhBsaEaJ7TGEVlpKuVaIB+88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U9p1mo6Lzgs0Cwzg7MCezCNJD/75kvLSaLEXn92Psx6RhZoRw/KRCh/8AABIzwxsASZYtzGZPU5ZewxdnYnfk0gMtgVXNGfvvx5/TONayUW4q+jhj/tjW9zNLiAXk9oHwQ7F18oAKrFOhbciImIvexhnRbFh6VTwvno+Fdd7deo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/kmy6PH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755107067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TbiQbzQYZL8rumWRxNBL44dhUPNa98NPgdegutYslww=;
	b=e/kmy6PHdwxP7ZBchJdGU1oQrYMoCLQgKwmXiOcw3bXq92vQzOulNWq0FmCloYLexWdgRy
	oQcwMAAGTgKK0Rg2DPx0pRrUiocGXzEbWQKy9vEA7ir2mkWk/0oAg5zonrw3cZoOuF5/ai
	M+DLtL+RoMA7E46XNkWutH+UFNWKMfI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-r3qXGlZZOyW7L9Od7EIYCw-1; Wed,
 13 Aug 2025 13:44:18 -0400
X-MC-Unique: r3qXGlZZOyW7L9Od7EIYCw-1
X-Mimecast-MFC-AGG-ID: r3qXGlZZOyW7L9Od7EIYCw_1755107055
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40C71195608E;
	Wed, 13 Aug 2025 17:44:15 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.146])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5902D180047F;
	Wed, 13 Aug 2025 17:44:10 +0000 (UTC)
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
Subject: [PATCH net-next v3 0/5] dpll: zl3073x: Add support for devlink flash
Date: Wed, 13 Aug 2025 19:44:03 +0200
Message-ID: <20250813174408.1146717-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
 drivers/dpll/zl3073x/devlink.c               |  92 ++-
 drivers/dpll/zl3073x/devlink.h               |   3 +
 drivers/dpll/zl3073x/flash.c                 | 683 +++++++++++++++++++
 drivers/dpll/zl3073x/flash.h                 |  29 +
 drivers/dpll/zl3073x/fw.c                    | 427 ++++++++++++
 drivers/dpll/zl3073x/fw.h                    |  52 ++
 drivers/dpll/zl3073x/regs.h                  |  51 ++
 11 files changed, 1657 insertions(+), 91 deletions(-)
 create mode 100644 drivers/dpll/zl3073x/flash.c
 create mode 100644 drivers/dpll/zl3073x/flash.h
 create mode 100644 drivers/dpll/zl3073x/fw.c
 create mode 100644 drivers/dpll/zl3073x/fw.h

-- 
2.49.1


