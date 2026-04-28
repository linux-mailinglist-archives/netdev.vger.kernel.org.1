Return-Path: <netdev+bounces-281961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EODJz/X8GlHaAEAu9opvQ
	(envelope-from <netdev+bounces-281961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:50:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAD14883D0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 645313052675
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E143E1CF0;
	Tue, 28 Apr 2026 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGs+y2kT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C133C73D7
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391364; cv=none; b=s0/Jn7JeKNT6FBNZa4/dDcQrjDwt2zgLtr4B4Ytr2E8pLkhXgt4e3G2hNIpE7D8xWcnVP85L04jc8BbRawk/gEdecuqDPScmBL3ds2o5bqPHqNMHbMs2Tjp7wByoYdDBQw5sa5bI2VOa81BezlZylbByL7SQcJ35H+DFtaQtEqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391364; c=relaxed/simple;
	bh=+Z5HXONavSEyjB//byLhSd6h81Jb2iPsZnkfpJKBF/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MXoWFqqvoS7IAv1/+DTsK0WLA2lAzZVePqAxOJLap/u3u3ALiZ4c/IRufX6FlnbNHJwc5XjCNi7tjPz36DPf56H/CG9swp+W4wXZqnMZl7e0j3BYQel15wHQ8jhq69OKO0jCUoUrldG775DjttfwOMiedjQxM/NSC2SSdmg/V0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGs+y2kT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777391362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WnBL6blayqS159iiH3uewuzFbEY/o0MaGUqGJ2MjARg=;
	b=RGs+y2kTvBEEiiE/XJAJOEw8ocxlqG86QEmRjymjcIR8r+ImHel601B3APqpbhmiI5UzgB
	OutE/n9MAEuw3RHBtVANKdDJ20G7dSYr6jQ2d8Lgp2kEbMD/dWXKstr7mhk1R3wIESq66N
	efibq6druZV2H/Gxl4gbgVOF9bg5rpQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-aduUqFe-MSmZ_jmv-B7Avw-1; Tue,
 28 Apr 2026 11:49:17 -0400
X-MC-Unique: aduUqFe-MSmZ_jmv-B7Avw-1
X-Mimecast-MFC-AGG-ID: aduUqFe-MSmZ_jmv-B7Avw_1777391355
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E372B1956054;
	Tue, 28 Apr 2026 15:49:14 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.49.234])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B8DB300756E;
	Tue, 28 Apr 2026 15:49:08 +0000 (UTC)
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
	Pasi Vaananen <pvaanane@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] dpll: add pin operational state
Date: Tue, 28 Apr 2026 17:49:05 +0200
Message-ID: <20260428154907.2820654-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 5FAD14883D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,lwn.net,redhat.com,microchip.com,linuxfoundation.org,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281961-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add pin operational state (operstate) to the DPLL subsystem to
separate administrative intent from actual hardware status.

Currently pin-state mixes what the user requested (connected,
selectable, disconnected) with what the hardware is actually doing.
This makes it difficult to diagnose situations where a user sets
a pin as selectable or connected but the hardware cannot use it
due to signal issues.

The new operstate attribute is reported inside the pin-parent-device
nest alongside the existing state and is read-only. Defined values:

  - active: pin is qualified and actively used by the DPLL
  - standby: pin is qualified but not actively used by the DPLL
  - no-signal: pin does not have a valid signal
  - qual-failed: pin signal failed qualification checks

Patch 1 adds the operstate enum, netlink attribute and the
operstate_on_dpll_get callback to the DPLL subsystem. It also
updates Documentation/driver-api/dpll.rst to describe the
separation between admin state and operational state.

Patch 2 implements the callback for ZL3073x input pins using the
reference monitor status register. It also refactors the existing
state_on_dpll_get to return purely administrative state and switches
periodic monitoring to track operstate changes.

Ivan Vecera (2):
  dpll: add pin operational state
  dpll: zl3073x: implement pin operational state reporting

 Documentation/driver-api/dpll.rst     |  38 +++++----
 Documentation/netlink/specs/dpll.yaml |  31 ++++++++
 drivers/dpll/dpll_netlink.c           |  27 +++++++
 drivers/dpll/dpll_nl.c                |   3 +-
 drivers/dpll/dpll_nl.h                |   2 +-
 drivers/dpll/zl3073x/dpll.c           | 108 +++++++++++++++++---------
 drivers/dpll/zl3073x/regs.h           |   9 ++-
 include/linux/dpll.h                  |   6 ++
 include/uapi/linux/dpll.h             |  23 ++++++
 9 files changed, 192 insertions(+), 55 deletions(-)


base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
-- 
2.53.0


