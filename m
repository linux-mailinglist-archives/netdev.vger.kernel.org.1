Return-Path: <netdev+bounces-279345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBTpKQ5L4mnx4QAAu9opvQ
	(envelope-from <netdev+bounces-279345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:00:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2763C41C56E
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC3103038A66
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC073A168D;
	Fri, 17 Apr 2026 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Elu1zkZf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF6F27A133
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776437966; cv=none; b=WIK5J5/ZlLMHkhKOZlRAwxH5GR5M5PHwPaVSEH3/Ykx4hcLlJqybZjyfKTxsLrnhn41Q3bUe06ULw8BBSY6wJvZEkzLED0RQxZ5JLBQvs4vBKg1V4qZypF295m9+5BCvlsyjktAqtPYbfPsYECAN81el9Uv+T4f2l/RK84aTIJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776437966; c=relaxed/simple;
	bh=8/ShQI2tcr1+jH//wB7FQS8Aj4RICVbyp4dVyOFeW4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oDdqepbCsAhQaHLIxlra8DUepCF10RY8JsFdIBVHuz3Ol7Of3IPZlNmGW/Ds2ZgaAgWdW9Ye1Z3sp2ZTK++tYaXtiMmxoiAps9vY7wD+qH+vKj1F5WMVH21XtcLLpWeenPzZHqpi+d1HyqiLUitBjYnalLVuQHYFZgtR5Tu2jkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Elu1zkZf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776437963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9Ttb12HYWY7Ea82iFBVHynj+VUTRAVF7RCJbsh2p51M=;
	b=Elu1zkZf3oOlVOuYKkuMpxGg6NUns8Fn/WU4TtlXT0Sa24UyhrIxX9vx5ryqtnAbtNW7bU
	QWSTjmyIkUDqeU1Oeya7/rF//qPBYSSOGLnjmuIxFA87aGng9n+1kj3B1zh8zm+yFucrgI
	rObkHoaRDdlyKPYDJtIMT3bV39jipik=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-8Tn1GChdNhGF9RphoU8yiA-1; Fri,
 17 Apr 2026 10:59:20 -0400
X-MC-Unique: 8Tn1GChdNhGF9RphoU8yiA-1
X-Mimecast-MFC-AGG-ID: 8Tn1GChdNhGF9RphoU8yiA_1776437957
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51AB8195607B;
	Fri, 17 Apr 2026 14:59:17 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.76])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8FD9930001BE;
	Fri, 17 Apr 2026 14:59:10 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Ivan Vecera <ivecera@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net v7 0/3] ice: fix missing dpll notifications for SW pins
Date: Fri, 17 Apr 2026 16:59:04 +0200
Message-ID: <20260417145907.696307-1-poros@redhat.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279345-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2763C41C56E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The SMA/U.FL pin redesign never propagated dpll notifications to the
software-controlled pin wrappers.  This series fixes that in two steps
plus a prerequisite dpll core change.

Patch 1 exports __dpll_pin_change_ntf() so ice can send peer
notifications from callback context where dpll_lock is already held.

Patch 2 fixes HW-to-SW notification propagation: periodic work now
notifies SW wrappers when their backing CGU input changes, and
phase_offset reporting for SW pins reads the backing pin's value.

Patch 3 adds SW-to-SW peer notification: when SMA or U.FL pin state
changes via PCA9575 routing, the paired pin gets a dpll change event.

Ivan Vecera (1):
  dpll: export __dpll_pin_change_ntf() for use under dpll_lock

Petr Oros (2):
  ice: fix missing dpll notifications for SW pins
  ice: add dpll peer notification for paired SMA and U.FL pins

 drivers/dpll/dpll_netlink.c               | 10 +++
 drivers/dpll/dpll_netlink.h               |  2 -
 drivers/net/ethernet/intel/ice/ice_dpll.c | 79 +++++++++++++++++++----
 include/linux/dpll.h                      |  1 +
 4 files changed, 79 insertions(+), 13 deletions(-)

---
v7:
 - split ice patch into two: HW-to-SW notification propagation and
   SW-to-SW peer notification (requested by Jiri Pirko)
 - drop spurious blank line removal in ice_dpll_sma_direction_set()
v6: https://lore.kernel.org/all/20260416113952.389405-1-poros@redhat.com/
v5: https://lore.kernel.org/all/20260409102501.1447628-1-poros@redhat.com/
v4: https://lore.kernel.org/all/20260319205256.998876-1-poros@redhat.com/
v3: https://lore.kernel.org/all/20260220140700.2910174-1-poros@redhat.com/
v2: https://lore.kernel.org/all/20260219131500.2271897-1-poros@redhat.com/
v1: https://lore.kernel.org/all/20260218211414.1411163-1-poros@redhat.com/


