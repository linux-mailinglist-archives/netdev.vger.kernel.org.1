Return-Path: <netdev+bounces-207976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9EFB092DF
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD653B720C
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE6B2F94AA;
	Thu, 17 Jul 2025 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faoYpRrV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532831A2C06
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772273; cv=none; b=Xrk6kp8ilMQGr2hvKfwq3BLI/SXsdI3pFuIXYg/GJzh2NV5IImBf+ywDkc9YZdW+0/ziN5GQcErIIcy9ZDO1Upcw9UH16FlZFZ6iQ90YXoa1Vm9jnS4AqI6jE4nsxqDLXp9NnV5FlfwzD3vnkW3V6wyGf64J1TcuZqqAPoP3d1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772273; c=relaxed/simple;
	bh=GVUHGju2+ZDh6FoEwREwk2SXt0lnoraJ0qlp8NVftCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1XH6QW2du9LYc4ksg/pUrK/wvV1fFFfwDp9vGFHrH9q+AEDupXtniQLq10rgyiYyJAGEY5mCletAbEftzlxJeyahzx8uxGaeUlHqcy6S8hC0ialwi8lAZ511HL+N1isjfwK87z5lSW5zww8IzbGse4YlsczBWJH5duZi5cLZ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=faoYpRrV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752772270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3JDncZPC9OMcQ6vJ0w/uC4y2BfDtUILRnDAHQlRDKF4=;
	b=faoYpRrVFSJCxJ4MbU5xw//VedGkqdvpkjfTr9WA3WDBEMTQsYJCZqF1msO6U7ocL1frYT
	BgBlrVPPOqqrpLI6cF7+RZYo1bWNiu8macBBrGAt+lgihj0IcdSz3AMYZah1jb0/ODjsVX
	6FtlQOKwOgPyBYbbIeEUQTLj/Ucnpog=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-gScbiNX9OQaGZX7tjnFFVA-1; Thu,
 17 Jul 2025 13:11:07 -0400
X-MC-Unique: gScbiNX9OQaGZX7tjnFFVA-1
X-Mimecast-MFC-AGG-ID: gScbiNX9OQaGZX7tjnFFVA_1752772265
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38B0E19560B6;
	Thu, 17 Jul 2025 17:11:05 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.34.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C5CD195608D;
	Thu, 17 Jul 2025 17:11:01 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next 0/2] dpll: zl3073x: Read clock ID from device property
Date: Thu, 17 Jul 2025 19:10:58 +0200
Message-ID: <20250717171100.2245998-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The current ZL3073x firmware revisions do not provide any information
unique for the particular chip that could be use to generate clock ID
necessary for a DPLL device registration.

Currently the driver generates random clock ID during probe and a user
have and option to change this value using devlink interface.

The situation is very similar to network controllers that do not have
assigned a fixed MAC address.

The purpose of this series is to allow to specify the clock ID property
through DT. If the property is not provided then the driver will use
randomly generated value as fallback.

Patch breakdown:
Patch 1 - adds clock-id property to dpll-device DT schema
Patch 2 - adds support for this DT property in zl3073x driver

Ivan Vecera (2):
  dt-bindings: dpll: Add clock ID property
  dpll: zl3073x: Initialize clock ID from device property

 .../devicetree/bindings/dpll/dpll-device.yaml |  5 +++
 drivers/dpll/zl3073x/core.c                   | 32 ++++++++++++++++---
 2 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.49.1


