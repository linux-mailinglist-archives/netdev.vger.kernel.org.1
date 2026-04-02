Return-Path: <netdev+bounces-274662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG11GPW5zmmTpgYAu9opvQ
	(envelope-from <netdev+bounces-274662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 20:48:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 014D438D61D
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 20:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0B4A302B3BB
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 18:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE843D3CE2;
	Thu,  2 Apr 2026 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6q3fGWo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E91345CAE
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155271; cv=none; b=J34VoVLlOmSVieY2BeJlh8K6ps+HDFeebsBRXF33f1OBX52uvip7UQgkYuY7sjX2Ei7BnSsf5OyRNrtJWUh3zzojMBsNDruMFmivQobF67TlZtW088fA2Ohze9J9gEPBVznO6bWuaPbWMHV/jdtxt8HcMXnMsJN9XtKunT2yUl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155271; c=relaxed/simple;
	bh=SoODdgq1bm5UbD8AcFc3p/xEVRysByNUQKP5eyv/I3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GV6yWHOSUaHpUxdNXPMaflrksa0ws9gYedj+0+L57hA0tR5x6LX9o4Hd/Z9DMlCIpcplyc/v5h8BDvhIzaSrinvTWOj58wn37SL/bm+tq+umoriCbBPJo/kCha+WFAugB0M4A8LkOUlr8/src9/5vjswa+QkL8wpfKSQQKTYmew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G6q3fGWo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775155268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XWWNnGjyJcIfn9aV2POXN+RhyDEVtpAda+Zpl8WEu78=;
	b=G6q3fGWo6b0+rgryuu2U8gqNn1kgGxZ9SwaCI34t8tGM5kGOVcKjQypTNmO+9CAXIVqp9o
	x5c2AINvqdEOZVoe9VtSVpEAcajonBMvr2dxo6MR4zn/O1gRYaZOphrbq0pUOUWeUZ+75M
	ZBPlm/433xLlBPgDfGDxArEnAPVNrvA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-DgmqR5J9Pf-GOu-PR7Nu4w-1; Thu,
 02 Apr 2026 14:41:06 -0400
X-MC-Unique: DgmqR5J9Pf-GOu-PR7Nu4w-1
X-Mimecast-MFC-AGG-ID: DgmqR5J9Pf-GOu-PR7Nu4w_1775155264
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB2CC18005B0;
	Thu,  2 Apr 2026 18:41:03 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.129])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B44841800361;
	Thu,  2 Apr 2026 18:40:58 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] dpll: add frequency monitoring feature
Date: Thu,  2 Apr 2026 20:40:54 +0200
Message-ID: <20260402184057.1890514-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,lwn.net,redhat.com,microchip.com,linuxfoundation.org,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274662-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 014D438D61D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds support for monitoring the measured input frequency
of DPLL input pins via the DPLL netlink interface.

Some DPLL devices can measure the actual frequency being received on
input pins. The approach mirrors the existing phase-offset-monitor
feature: a device-level attribute (DPLL_A_FREQUENCY_MONITOR) enables
or disables monitoring, and a per-pin attribute
(DPLL_A_PIN_MEASURED_FREQUENCY) exposes the measured frequency in
millihertz (mHz) when monitoring is enabled.

Patch 1 adds the new attributes to the DPLL netlink spec (dpll.yaml),
the DPLL_PIN_MEASURED_FREQUENCY_DIVIDER constant, regenerates the
auto-generated UAPI header and netlink policy, and updates
Documentation/driver-api/dpll.rst.

Patch 2 adds the callback operations (freq_monitor_get/set for
devices, measured_freq_get for pins) and the corresponding netlink
GET/SET handlers in the DPLL core. The core only invokes
measured_freq_get when the frequency monitor is enabled on the parent
device. The freq_monitor_get callback is required when measured_freq_get
is provided.

Patch 3 implements the feature in the ZL3073x driver by extracting
a common measurement latch helper from the existing FFO update path,
adding a frequency measurement function, and wiring up the new
callbacks.

Changes v3 -> v4:
- Moved freq_monitor_{g,s}et validation from netlink to pin
  registration with WARN_ON (Vadim)

Changes v2 -> v3:
- Improved frequency-monitor doc wording (Jakub)
- Changed measured-frequency to mHz with divider constant (Jakub)
- Made freq_monitor_get required when measured_freq_get is present (Jakub)

Changes v1 -> v2:
- Renamed actual-frequency to measured-frequency (Vadim)

Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Ivan Vecera (3):
  dpll: add frequency monitoring to netlink spec
  dpll: add frequency monitoring callback ops
  dpll: zl3073x: implement frequency monitoring

 Documentation/driver-api/dpll.rst     |  20 ++++++
 Documentation/netlink/specs/dpll.yaml |  35 +++++++++
 drivers/dpll/dpll_core.c              |   5 +-
 drivers/dpll/dpll_netlink.c           |  90 +++++++++++++++++++++++
 drivers/dpll/dpll_nl.c                |   5 +-
 drivers/dpll/zl3073x/core.c           |  88 +++++++++++++++++++----
 drivers/dpll/zl3073x/dpll.c           | 100 ++++++++++++++++++++++++--
 drivers/dpll/zl3073x/dpll.h           |   2 +
 drivers/dpll/zl3073x/ref.h            |  14 ++++
 include/linux/dpll.h                  |  10 +++
 include/uapi/linux/dpll.h             |   5 +-
 11 files changed, 353 insertions(+), 21 deletions(-)

-- 
2.52.0


