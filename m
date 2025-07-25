Return-Path: <netdev+bounces-210070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9295FB12111
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 17:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C3E3AA948
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 15:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CBC2EE979;
	Fri, 25 Jul 2025 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhxeIU5Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA1B262BE
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458110; cv=none; b=jXWBBx5k+24QTndmbIKKOtG6LFDIIDsf1psChFbajkQ1kW3UoaymJaeSETuxcTRKA6bEfqfzhHdw/r+CZX2XYTzgU2Co65BkKTX1+viLP+M81LHocCzI8E5Pcs2m2LS67ejtYGQFIqRX6hRenJlRwoU4hYLlbAutHIy9U9KC7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458110; c=relaxed/simple;
	bh=UWAz9h2kHiUacwchZovSad7Eigp/uklJqMHRpEyFkRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hpNSCYK2H15CVOBzINtfwsRZD/C6ijq4la7tNdbSaZ0Zae0Zz4umoYZ043bAqntPSkuNEDPIdFNb0BxU/tUMTeWaT+0UTTcW0nOPWby5w3+OFMKQ/i3V2euJqguFzuIB+iN8fX+2XpDAxs0Oiu8aUatDaCiIjK5PLvgMY85NRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YhxeIU5Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753458107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A1063hFjaItzWTFLiah3UMgBEqOt68ZUKeF8u2lUiKo=;
	b=YhxeIU5QxhOGSanuJh3310WpHKwUgM8hx8zCmOidB3qFts52TbshgR8Z0vFLdXXUVYdKUt
	LGD2vrGZD4vjqanf/Bfn3kfhKuf5ppi3Kjjx6ovr4NQMTmi/tqFHFkWifaPm2OFhkqbeYn
	fRdNC2v6R4T1yMgW3evUbxaEqbEPurs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-_XPXXlniNNWyawo_5LwHYQ-1; Fri,
 25 Jul 2025 11:41:44 -0400
X-MC-Unique: _XPXXlniNNWyawo_5LwHYQ-1
X-Mimecast-MFC-AGG-ID: _XPXXlniNNWyawo_5LwHYQ_1753458102
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4564D180048E;
	Fri, 25 Jul 2025 15:41:42 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.176])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 28CD01966665;
	Fri, 25 Jul 2025 15:41:37 +0000 (UTC)
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
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next 0/5] dpll: zl3073x: Add support for devlink flash
Date: Fri, 25 Jul 2025 17:41:31 +0200
Message-ID: <20250725154136.1008132-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

Ivan Vecera (5):
  dpll: zl3073x: Add functions to access hardware registers
  dpll: zl3073x: Add low-level flash functions
  dpll: zl3073x: Add firmware loading functionality
  dpll: zl3073x: Refactor DPLL initialization
  dpll: zl3073x: Implement devlink flash callback

 Documentation/networking/devlink/zl3073x.rst |  14 +
 drivers/dpll/zl3073x/Makefile                |   2 +-
 drivers/dpll/zl3073x/core.c                  | 362 +++++++---
 drivers/dpll/zl3073x/core.h                  |  32 +
 drivers/dpll/zl3073x/devlink.c               |  92 ++-
 drivers/dpll/zl3073x/devlink.h               |   3 +
 drivers/dpll/zl3073x/flash.c                 | 674 +++++++++++++++++++
 drivers/dpll/zl3073x/flash.h                 |  29 +
 drivers/dpll/zl3073x/fw.c                    | 495 ++++++++++++++
 drivers/dpll/zl3073x/fw.h                    |  52 ++
 drivers/dpll/zl3073x/regs.h                  |  51 ++
 11 files changed, 1715 insertions(+), 91 deletions(-)
 create mode 100644 drivers/dpll/zl3073x/flash.c
 create mode 100644 drivers/dpll/zl3073x/flash.h
 create mode 100644 drivers/dpll/zl3073x/fw.c
 create mode 100644 drivers/dpll/zl3073x/fw.h

-- 
2.49.1


