Return-Path: <netdev+bounces-232581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBCBC06C7A
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E570035C2AB
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A559258EDB;
	Fri, 24 Oct 2025 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKjBEcV7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CEB253954
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317384; cv=none; b=c7SNyXYRagzVAB0EhzhhO0JD/x2n+76K6X4HIvoWECwmfTFSkbdRMjfkHre0l1ykFtrD+ROPBr9JZI/8YwUr9sL5T6C3tvnCChzFiRm+cyyJg81frS0kss0lmGrAis1oLlP8ypwqV4NDFi4XFHw1GEjJ2tv/NksKMD1h5qBm9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317384; c=relaxed/simple;
	bh=0BZ0BcSusW7FwFIuN25KkWJWq2tsCJe59ZXpcQinCk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mOiF9viGDLVOnUBqAm4FbEy5I7SkjK8CTlnkRZUoXeK7MUEYym4DahrV60rQWi0WG7qZNN9lXlhDxGx/E1AXKWtfGN0O2Ax4GdXtyocd4u3n74xL3oz8iCy5+0FCHl1EESkSbvRtghQbozQclVCfLhyUvJGmEJLqyz+OdXAXzzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKjBEcV7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761317381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gKT/q9TJF6+VQQMv4iiXzSYNNkUzdFtCQ/W2qSv+h+0=;
	b=GKjBEcV7JMcKwNQGdfMiV2GLmI+U0nxLrlBXZVjqveMP8xM5STfPnECFpgsSps2XZ8i6BC
	QOsh9RRWnikyyaXg7E/wvxFhXEjFsrRZGbAtLLftGrcJh3XqQ++/5nqBXTksZ9AyarwZnN
	5+2GZk0apJ64QwbU0WHVJKj6B0h76cI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-4eMyWcJ1PEOxPWqIFFNTVQ-1; Fri,
 24 Oct 2025 10:49:38 -0400
X-MC-Unique: 4eMyWcJ1PEOxPWqIFFNTVQ-1
X-Mimecast-MFC-AGG-ID: 4eMyWcJ1PEOxPWqIFFNTVQ_1761317374
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2BF61954190;
	Fri, 24 Oct 2025 14:49:33 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.203])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 61E5119540EB;
	Fri, 24 Oct 2025 14:49:29 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] dpll: Add support for phase adjustment granularity
Date: Fri, 24 Oct 2025 16:49:25 +0200
Message-ID: <20251024144927.587097-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Phase-adjust values are currently limited only by a min-max range. Some
hardware requires, for certain pin types, that values be multiples of
a specific granularity, as in the zl3073x driver.

Patch 1: Adds 'phase-adjust-gran' pin attribute and an appropriate
         handling
Patch 2: Adds a support for this attribute into zl3073x driver

Ivan Vecera (2):
  dpll: add phase-adjust-gran pin attribute
  dpll: zl3073x: Specify phase adjustment granularity for pins

 Documentation/driver-api/dpll.rst     | 36 +++++++++--------
 Documentation/netlink/specs/dpll.yaml |  7 ++++
 drivers/dpll/dpll_netlink.c           | 12 +++++-
 drivers/dpll/zl3073x/dpll.c           | 58 +++++++--------------------
 drivers/dpll/zl3073x/prop.c           | 11 +++++
 include/linux/dpll.h                  |  1 +
 include/uapi/linux/dpll.h             |  1 +
 7 files changed, 65 insertions(+), 61 deletions(-)

-- 
2.51.0


