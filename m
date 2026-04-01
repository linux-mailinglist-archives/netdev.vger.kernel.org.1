Return-Path: <netdev+bounces-273997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMiRF7PizGmjXQYAu9opvQ
	(envelope-from <netdev+bounces-273997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:17:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 215DA377702
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E29430971C7
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 09:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B450C3BED08;
	Wed,  1 Apr 2026 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4NWDVBI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD9201278
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034779; cv=none; b=rjR/+My1WWHueuSm/3QBqIa3drySI6OHB23OgzKUR0PbPYmduHY8oWsEMo7VkkK0iKH4XlcbU2EU7HWzmgwBUeXzbcMf5xBM0D17qQGakblFaGR+9YnWDiMJ4yqN+Ab6gXYuUMhWtdi0g2+FN6VEfjFZr3FrHqn9cQ0k85F1LDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034779; c=relaxed/simple;
	bh=GNoCTaEcHI4HVkQfCSAkJ3sbsI31FUU8NEL5Xt7qdTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZCxWCLJJkUUKCZJIhaM7l4NigjzXFiH6wAImz5u1WT7kdHJ++vzHYhwUTSFOlbtI7SEnYWmAE/o0bj6XgqinPHQ/oR2S2C0EKsN3iZ5iwh9Crvlh2kZKbE9tb3KCGP1wKIGg9BqRE4klNpSDa+EzR7nz4L6eQ9mvSVvhtVgsTws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4NWDVBI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775034777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jW+VvEvXVqVr9yZXBwq6ev934woPZETN0YLwNbnDBN4=;
	b=Q4NWDVBIu5C9gSRVGzffA0cBN9aGcPUpqwFyRb3ZyJRVb4AY/CQQAvSH31nqDzA+mlPpL4
	jW2Kms/65yT0oVdF8+iu9U31Engvj7sy/1R17YKDdeXWx5CuEhn6WyynidvG02dp5d3gwr
	Rmmsinlj9aZm5IaQ2yvmQS8lCkpWXoo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-luEw8JOCMxq7fNG9WgbhFA-1; Wed,
 01 Apr 2026 05:12:47 -0400
X-MC-Unique: luEw8JOCMxq7fNG9WgbhFA-1
X-Mimecast-MFC-AGG-ID: luEw8JOCMxq7fNG9WgbhFA_1775034765
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B55B195609E;
	Wed,  1 Apr 2026 09:12:44 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.175])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 080CA19560AB;
	Wed,  1 Apr 2026 09:12:38 +0000 (UTC)
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
Subject: [PATCH net-next v3 0/3] dpll: add frequency monitoring feature
Date: Wed,  1 Apr 2026 11:12:34 +0200
Message-ID: <20260401091237.1071995-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,lwn.net,redhat.com,microchip.com,linuxfoundation.org,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273997-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 215DA377702
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
 drivers/dpll/dpll_netlink.c           |  92 ++++++++++++++++++++++++
 drivers/dpll/dpll_nl.c                |   5 +-
 drivers/dpll/zl3073x/core.c           |  88 +++++++++++++++++++----
 drivers/dpll/zl3073x/dpll.c           | 100 ++++++++++++++++++++++++--
 drivers/dpll/zl3073x/dpll.h           |   2 +
 drivers/dpll/zl3073x/ref.h            |  14 ++++
 include/linux/dpll.h                  |  10 +++
 include/uapi/linux/dpll.h             |   5 +-
 10 files changed, 351 insertions(+), 20 deletions(-)

-- 
2.52.0


