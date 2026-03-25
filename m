Return-Path: <netdev+bounces-271704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB3NNhs6xGnkxQQAu9opvQ
	(envelope-from <netdev+bounces-271704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:40:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B0232B5B5
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 688F83009510
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 19:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC45347BC4;
	Wed, 25 Mar 2026 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/95TNwc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F59346ADC
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 19:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467568; cv=none; b=Xsc/Wod12rMKRgTxRez7bG736JkFeM2HSqfpIkr+Dlw5LbYCu7H6eI47vDtTQ7XwDupZFiS+EupeOMVeAB+pMrh7VwAk6x60qbp00vnXT0Zp7D/QZ0td9b9uDWEmzosp4Tm1Xl2q0L+gcf3uN4PmoUZwSRJszLtBYkt28KR6X18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467568; c=relaxed/simple;
	bh=59OAXgMlCD0McRBaNkU2QmS1Je3lTiCQddJMoA12x1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KSSrLuVezLSfk8dOd8rnSkmzqn+X87yx0FOt/EQQJNXQ40/CovkoDjjWtpkIsft2qgFZVJms3uKQB+k9mepo10nk8ytBqyDexIrerB6PRNo7ljxsw7kNrBCeyMh1Mwt1mDPUmBawT+AV83HBOspuj9o56u3mr7yj3hdh7U4eP20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/95TNwc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774467566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tD6g6arGh6ZkVTmfd5lNdWtfQqJ85M2hvfdIUn4iV0k=;
	b=F/95TNwczP0EiyrLDtdL5WgNpUkj1CTqAvY/zTLQObLY6w6te/l2LIztX/NKcNYj/q41JB
	FFNeDKNsu68TCWTwzI9BYSKQ6hrfX19M6KN1DWqXQ3sns4pJU4V3pkppvBfS34mzHAVlT4
	euCGpe90hiYHIxooM+O/J/1FSXKN1bs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-aBK317bUP-qQkKNp2CvK-A-1; Wed,
 25 Mar 2026 15:39:23 -0400
X-MC-Unique: aBK317bUP-qQkKNp2CvK-A-1
X-Mimecast-MFC-AGG-ID: aBK317bUP-qQkKNp2CvK-A_1774467561
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3210B1944F01;
	Wed, 25 Mar 2026 19:39:21 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.254])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79EA43000223;
	Wed, 25 Mar 2026 19:39:15 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Petr Oros <poros@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] dpll: add actual frequency monitoring feature
Date: Wed, 25 Mar 2026 20:39:11 +0100
Message-ID: <20260325193914.124898-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
	FREEMAIL_CC(0.00)[linux.dev,intel.com,resnulli.us,lwn.net,linuxfoundation.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,microchip.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271704-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 43B0232B5B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds support for monitoring the actual (measured) input
frequency of DPLL input pins via the DPLL netlink interface.

Some DPLL devices can measure the actual frequency being received on
input pins. Previously, the ZL3073x driver exposed this through the
hwmon interface using custom sysfs attributes, but this was rejected
as frequency is not a valid hwmon attribute. This series implements the
feature properly through the DPLL netlink interface instead.

The approach mirrors the existing phase-offset-monitor feature:
a device-level attribute (DPLL_A_FREQUENCY_MONITOR) enables or
disables monitoring, and a per-pin attribute (DPLL_A_PIN_ACTUAL_FREQUENCY)
exposes the measured frequency in Hz when monitoring is enabled.

Patch 1 adds the new attributes to the DPLL netlink spec (dpll.yaml),
regenerates the auto-generated UAPI header and netlink policy, and
updates Documentation/driver-api/dpll.rst.

Patch 2 adds the callback operations (freq_monitor_get/set for
devices, actual_freq_get for pins) and the corresponding netlink GET/SET
handlers in the DPLL core. The core only invokes actual_freq_get when
the frequency monitor is enabled on the parent device.

Patch 3 implements the feature in the ZL3073x driver by extracting
a common measurement latch helper from the existing FFO update path,
adding a frequency measurement function, and wiring up the new
callbacks.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Ivan Vecera (3):
  dpll: add actual frequency monitoring to netlink spec
  dpll: add actual frequency monitoring callback ops
  dpll: zl3073x: implement actual frequency monitoring

 Documentation/driver-api/dpll.rst     | 18 ++++++
 Documentation/netlink/specs/dpll.yaml | 17 +++++
 drivers/dpll/dpll_netlink.c           | 90 +++++++++++++++++++++++++++
 drivers/dpll/dpll_nl.c                |  5 +-
 drivers/dpll/zl3073x/core.c           | 88 ++++++++++++++++++++++----
 drivers/dpll/zl3073x/dpll.c           | 88 +++++++++++++++++++++++++-
 drivers/dpll/zl3073x/dpll.h           |  2 +
 drivers/dpll/zl3073x/ref.h            | 14 +++++
 include/linux/dpll.h                  | 12 ++++
 include/uapi/linux/dpll.h             |  2 +
 10 files changed, 320 insertions(+), 16 deletions(-)

-- 
2.52.0


