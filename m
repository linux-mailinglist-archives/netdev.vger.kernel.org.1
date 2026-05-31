Return-Path: <netdev+bounces-293471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB5EO7mPHGpdPQkAu9opvQ
	(envelope-from <netdev+bounces-293471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 21:44:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB5F617AF3
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 21:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 735BE303BB3F
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 19:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4066133B969;
	Sun, 31 May 2026 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOY9mDq8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6788C32F749
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780256681; cv=none; b=pUGDgKr7Pj/KLM7z1KDeR2GmQkV8Ufq2fiB/YARaTIrf7IJzM9yNaM4UnrlJh5baFkVftOr5YZp1iiDAiwsXj4TWRkqQFnzk4qlsXMJs0kQGGaJTBu4KfNroV1To2oQEyv5uR2AoPo/L1yFyr1T/j5II946AMRzaCqJ3zXMamhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780256681; c=relaxed/simple;
	bh=uvamcTWol4tPyXd7Vz0cuXmQA7Q4aJ7Et6Vv+Z/z2Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eh3Hr+GgULE94JgwWAUvOld/s90xI6WpVKPXecvDEjDDQ/jBoN46lVlaJptuzQfQX063fFT0XuWxdQE0KRuFnWNPNPzdxLLm5VUp+iqekX4V+R/gkjs43KBauuxWpwQ+Er8JV5bBgw1MsOsjtIPdcGulL/y0GjcOh3ViZRViUUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LOY9mDq8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780256678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7kgY/cPIaDUw1tDlXR1NIsfvxx0BIO2ZXXIoNgu7NtI=;
	b=LOY9mDq8rs0B7dQjWDRa9NjyG1kDId85Do9T/ybj3C73B385jd8PYFCY949NWOSSrJQGJK
	lZQxlEBGSPtjw2TAP9RkODl21zhibACmO/eatzRLIsRS/Dac2G7kC8TYD2sw4b4BjsFAB3
	l24BixOK/LuPWuK0hJuF+z65sXgloaY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660--7-vX7djMQKOpJfaWgA5uQ-1; Sun,
 31 May 2026 15:44:31 -0400
X-MC-Unique: -7-vX7djMQKOpJfaWgA5uQ-1
X-Mimecast-MFC-AGG-ID: -7-vX7djMQKOpJfaWgA5uQ_1780256669
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEBD319560B5;
	Sun, 31 May 2026 19:44:28 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.62])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F1091956053;
	Sun, 31 May 2026 19:44:24 +0000 (UTC)
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
Subject: [PATCH net-next v5 0/4] dpll: add NCO pin type and zl3073x support
Date: Sun, 31 May 2026 21:44:19 +0200
Message-ID: <20260531194423.383366-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,microchip.com,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293471-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5CB5F617AF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new DPLL_PIN_TYPE_INT_NCO pin type for virtual pins representing
the NCO mode of a DPLL and implement support for it in the zl3073x driver.

Patch 1 adds the new pin type to the DPLL netlink spec and UAPI header.

Patch 2 replaces the single 2s poll timeout with per-operation timeouts
based on Microchip proprietary source code and own measurement.

Patch 3 adds a per-DPLL serialization mutex taken by all DPLL callbacks
and the periodic worker, establishing a single lock that protects all
per-channel state. The chan_state_update() call is moved under this lock.

Patch 4 adds a virtual NCO input pin to the zl3073x driver that allows
userspace to switch a DPLL channel into NCO mode. The pin reports
connected/active state when the channel is in NCO mode and handles
the hardware-specific details of mode transitions including automatic
df_offset capture and 1PPS phase preservation.

Changes:
v5:
  - Rebased on net-next after the freq_monitor per-device fix
    landed via net.
  - Move phase_offset_avg_factor_set notification loop outside lock
    to avoid lockdep false positive on multi-channel devices (patch 3).
  - Configure dpll_df_read register before NCO mode switch (patch 4).
  - Add 5ms delay before reading nco_auto_read captured df_offset,
    determined by HW testing (patch 4).
  - Mark df_offset as unknown at probe when firmware left channel
    in NCO mode (patch 4).
  - See individual patches for detailed changelogs.
v4:
  - New patch 2: per-operation poll timeouts
  - New patch 3: per-DPLL serialization lock
  - See individual patches for detailed changelogs.
v3:
  - fixed SoB position
v2:
  - See individual patches for detailed changelogs.

Ivan Vecera (4):
  dpll: add DPLL_PIN_TYPE_INT_NCO pin type
  dpll: zl3073x: use per-operation poll timeouts
  dpll: zl3073x: add per-DPLL serialization lock
  dpll: zl3073x: add NCO virtual input pin

 Documentation/netlink/specs/dpll.yaml |  13 +
 drivers/dpll/dpll_nl.c                |   2 +-
 drivers/dpll/zl3073x/chan.c           | 124 ++++++-
 drivers/dpll/zl3073x/chan.h           |  48 +++
 drivers/dpll/zl3073x/core.c           |  44 +--
 drivers/dpll/zl3073x/core.h           |  10 +-
 drivers/dpll/zl3073x/dpll.c           | 488 ++++++++++++++++++++++----
 drivers/dpll/zl3073x/dpll.h           |   4 +
 drivers/dpll/zl3073x/regs.h           |  11 +
 include/uapi/linux/dpll.h             |   4 +
 10 files changed, 651 insertions(+), 97 deletions(-)


base-commit: 8415598365503ced2e3d019491b0a2756c85c494
-- 
2.53.0


