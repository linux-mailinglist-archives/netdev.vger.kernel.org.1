Return-Path: <netdev+bounces-288655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ//ISywCGrz1AMAu9opvQ
	(envelope-from <netdev+bounces-288655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 19:58:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C1A55D010
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 19:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F1B13010D85
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 17:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFC33E51D4;
	Sat, 16 May 2026 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/iY1il9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204D3D5241
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778954278; cv=none; b=FvphLltxrh+RbDNS1MY7mzS3NcEcXECRdc49rGUN+xlSjFjMOzWOvE/LVDd90802ZQfGIo8CRJIx7+V5Gi3Alx5Y7tM/lXTtFglAT4CEcAx1p96BbIVtcdbXyLs4XW4GbGWz+vPVXvyUKQf1kskvyqucpmNVxMC7Ct5HHvM7n84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778954278; c=relaxed/simple;
	bh=3eQbhciZ2ms82/xXAp0EfMf7Mp0Zm7E1c8pujxGpLzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VxPyy+FA/wPbYbCHv2a7gupWsZk9tK+zwSiVnPN+Qp0tWUJE+SkrFW5aLMrh+GAScjix2CgZO76nOT/P811BWwMVV5ok4iY+gEyDjReovzDkV2SYZoLIPlkOv16mV1GQ9xO9n4NdmBq63tdTvCF3sWfxaVZsfaM4zlI/A6uM3bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C/iY1il9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778954276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U7R+O4HfrDPOR3HenEThWErLWG+/bK6rpBiWQYgms5Y=;
	b=C/iY1il968GtZJ/AF4asdvV6CpDFqhnqEcahbg6U7OBSQZz2+dA/LjS0onsvEoJxWbTtWc
	PrxSWtXuOSNdUFdCjMuFQByI5hJG3OQwbCeuILGku/iNIawxCdIybZl43ymVMB9t16M2cw
	N1gRA3gbACl5CwdL9TnwdRj0WQHg5q0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-HO2dj-SgNDauqfm2wxzrRg-1; Sat,
 16 May 2026 13:57:52 -0400
X-MC-Unique: HO2dj-SgNDauqfm2wxzrRg-1
X-Mimecast-MFC-AGG-ID: HO2dj-SgNDauqfm2wxzrRg_1778954270
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 616A8195608E;
	Sat, 16 May 2026 17:57:50 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.48.13])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A13691956053;
	Sat, 16 May 2026 17:57:45 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pasi Vaananen <pvaanane@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] dpll: add NCO pin type and zl3073x support
Date: Sat, 16 May 2026 19:57:42 +0200
Message-ID: <20260516175744.26749-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: D8C1A55D010
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,microchip.com,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288655-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add a new DPLL_PIN_TYPE_INT_NCO pin type for virtual pins representing
the NCO mode of a DPLL and implement support for it in the zl3073x driver.

Patch 1 adds the new pin type to the DPLL netlink spec and UAPI header.

Patch 2 adds a virtual NCO input pin to the zl3073x driver that allows
userspace to switch a DPLL channel into NCO mode. The pin reports
connected/active state when the channel is in NCO mode and handles
the hardware-specific details of mode transitions including automatic
df_offset capture and 1PPS phase preservation.

v2:
  - See individual patches for detailed changelogs.

Ivan Vecera (2):
  dpll: add DPLL_PIN_TYPE_INT_NCO pin type
  dpll: zl3073x: add NCO virtual input pin

 Documentation/netlink/specs/dpll.yaml |  13 ++
 drivers/dpll/dpll_nl.c                |   2 +-
 drivers/dpll/zl3073x/chan.c           |  68 ++++++-
 drivers/dpll/zl3073x/chan.h           |  25 +++
 drivers/dpll/zl3073x/dpll.c           | 277 ++++++++++++++++++++++----
 drivers/dpll/zl3073x/dpll.h           |   2 +
 drivers/dpll/zl3073x/regs.h           |   7 +
 include/uapi/linux/dpll.h             |   4 +
 8 files changed, 357 insertions(+), 41 deletions(-)

-- 
2.53.0


