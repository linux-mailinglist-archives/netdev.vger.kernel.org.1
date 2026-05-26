Return-Path: <netdev+bounces-291567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HniEaVPFWpMUQcAu9opvQ
	(envelope-from <netdev+bounces-291567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:45:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C61C25D1DC3
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB574300FFB6
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2483CC7C7;
	Tue, 26 May 2026 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xj9pDVMQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ADB336ED2
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781538; cv=none; b=KibMlRsp4uvr94e5SkVNbm7cwryu/RhYq9JnO77StSG7ohkeAZpYNHxv5JmMRJxlPDwGYIVBqQSgZ8d3gdGHoH3cPwOlGjf9/BxF8fwCQsA+F5esT80yzLknBIvbAyYNU5kVOyKXi9yuxYOyuZwKsXM32dUgSRm2pWtJqcOqZXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781538; c=relaxed/simple;
	bh=4SbBPP01S+B5igUJIx7BK4jtxIbJNICzrK/HLZhaFQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qzUamcYYKAdUjPRh51sbwAybQrb/bF41rdYyxL0GsrpeBLLlximrL5A6kA7pUWfVgrw805jlo7CXE+DgzdbYuGJyumgj2TaTOw+CS0eCiJoj+oXkiX29ZNwSqnl7pYxCjpeI05DFlRjA6HPzwJVAlntfudAT9lJVIPQGr/Ohfjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xj9pDVMQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779781535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5qKZomUE4wWCl9/a367jmjYUhecTHVQkRwv4RKuFR/s=;
	b=Xj9pDVMQVzMl/GGKlfv+ZxxZDSTTvu6a3m9lSbWf55qNykggUqPAutcU2vIeTCVqFy58E1
	7XQpOd2czvGA1tAwN6hvBsy8eXbKDGUwbSIyfZuLsSwN8qOiyalOnS2n7c8xTuBy628j1p
	MzcFqLiZOrRinouWR6kgf9gh77VWPCQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-FfBrcZxIMum-3EeZK8vL_w-1; Tue,
 26 May 2026 03:45:31 -0400
X-MC-Unique: FfBrcZxIMum-3EeZK8vL_w-1
X-Mimecast-MFC-AGG-ID: FfBrcZxIMum-3EeZK8vL_w_1779781529
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F24018002D0;
	Tue, 26 May 2026 07:45:29 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.138])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D4D2180034E;
	Tue, 26 May 2026 07:45:26 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Petr Oros <poros@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] dpll: zl3073x: various fixes
Date: Tue, 26 May 2026 09:45:22 +0200
Message-ID: <20260526074525.1451008-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291567-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C61C25D1DC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Three fixes for the zl3073x DPLL driver.

Patch 1 exports __dpll_device_change_ntf() for use by drivers that
need to send device change notifications from within callbacks
already running under dpll_lock.

Patch 2 replaces the change_work workqueue mechanism with direct
calls to __dpll_device_change_ntf(), eliminating a race condition
where the work handler could dereference a freed dpll_dev pointer
during device teardown.

Patch 3 moves the freq_monitor flag from per-DPLL to per-device
scope to match the hardware behavior where frequency measurement
registers are shared across all DPLL channels.

Ivan Vecera (3):
  dpll: export __dpll_device_change_ntf() for use under dpll_lock
  dpll: zl3073x: use __dpll_device_change_ntf() and remove change_work
  dpll: zl3073x: make frequency monitor a per-device attribute

 drivers/dpll/dpll_netlink.c | 13 +++++++--
 drivers/dpll/zl3073x/core.c | 19 ++++++-------
 drivers/dpll/zl3073x/core.h |  4 ++-
 drivers/dpll/zl3073x/dpll.c | 55 ++++++++++++++++---------------------
 drivers/dpll/zl3073x/dpll.h |  4 ---
 include/linux/dpll.h        |  1 +
 6 files changed, 46 insertions(+), 50 deletions(-)

-- 
2.53.0


