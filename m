Return-Path: <netdev+bounces-305907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8laSE2aDTmoFOQIAu9opvQ
	(envelope-from <netdev+bounces-305907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:05:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D958672900F
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:05:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=c4auNSH1;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305907-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305907-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 574FD300CB1D
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 17:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3767D420874;
	Wed,  8 Jul 2026 17:05:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CFE24293C
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 17:05:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530340; cv=none; b=bu9C0HuphUlxsPZKHeZRnGFGhry0wTMUCoRjczibu9tWrhhbNAz1z2fV+a01g02O94A1esErZlkIGzROo5QS0zMVYdqW2fXERxh1HcnNbdGuVO5IcJrTZ/+zZTqPy2R1n3BKJN1rgHWnZ9yx7ui/mqpUGOFKJ1IVlp9nzEd4gXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530340; c=relaxed/simple;
	bh=AMRkLzyiB5i3JMQPLkZMZH5BinpullLCQ8jwbASnzE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B55X+Seg2miy+tzBYzyH68mReFxkzs3URHHkE1Fmu+GJSYPMeHMQRnAIJiIJQExbcuxivMdOBnthZc6fe24EuGirP5qT0H6ud+BsznZ7wUPNr6g9jElSNisHpYn+kTG+XXdFPIL62XdWOoFgQf264vf5JvttlVe1D36ra7fkCV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4auNSH1; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783530337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=08zkJt+XFu3Cfo28xiFdMRI98lhX3XbfdcY7juf8PLQ=;
	b=c4auNSH1HxCQb6+VxiRV6bIEN5XWqtWTN2xebfmJgSYQzjIPd2qEB2JfdVqG/2iguV9b77
	tgOwga4XaLHk8h8J3yL/QDYVs3eQLxZ10xDQxUcNJYsnQhfF6cIiX04q1hiEwdba3dBOqU
	XiDW9SN5QnHLWeFnWLuV7sjlAGRSkxY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-ljC84MB1MgWx26Tohkqydw-1; Wed,
 08 Jul 2026 13:05:36 -0400
X-MC-Unique: ljC84MB1MgWx26Tohkqydw-1
X-Mimecast-MFC-AGG-ID: ljC84MB1MgWx26Tohkqydw_1783530334
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FD6118001D1;
	Wed,  8 Jul 2026 17:05:34 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.50.138])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CEEA195606C;
	Wed,  8 Jul 2026 17:05:29 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pasi Vaananen <pvaanane@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] dpll: zl3073x: add PTP clock support
Date: Wed,  8 Jul 2026 19:05:23 +0200
Message-ID: <20260708170527.916035-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,kernel.org,resnulli.us,redhat.com,microchip.com,gmail.com,linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305907-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:arkadiusz.kubalewski@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:richardcochran@gmail.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D958672900F

Add PTP hardware clock support to the zl3073x DPLL driver.

Patch 1 adds channel ToD read/write, phase step and delta frequency
offset operations as low-level building blocks for PTP callbacks.

Patch 2 registers a PTP clock device for each DPLL channel with
gettimex64, settime64, adjtime, adjfine and perout callbacks.
The adjtime callback splits multi-second adjustments via ToD
read-modify-write and sub-second remainders via output phase step.

Patch 3 adds a channel TIE (Time Interval Error) write operation
for sub-picosecond resolution phase adjustment.

Patch 4 adds PTP adjphase and getmaxphase callbacks using TIE write
for phase adjustment in AUTO and REFLOCK modes, extends adjtime to
handle non-NCO modes via TIE write, and removes the NCO-only gate
from PTP clock registration.

Ivan Vecera (4):
  dpll: zl3073x: add channel ToD and phase step operations
  dpll: zl3073x: add PTP clock support
  dpll: zl3073x: add channel TIE write operation
  dpll: zl3073x: add PTP clock adjphase and TIE support

 drivers/dpll/zl3073x/Kconfig |   6 +-
 drivers/dpll/zl3073x/chan.c  | 307 +++++++++++++++++++
 drivers/dpll/zl3073x/chan.h  |  48 +++
 drivers/dpll/zl3073x/core.c  |   8 +
 drivers/dpll/zl3073x/core.h  |   8 +
 drivers/dpll/zl3073x/dpll.c  | 575 +++++++++++++++++++++++++++++++++--
 drivers/dpll/zl3073x/dpll.h  |   6 +
 drivers/dpll/zl3073x/regs.h  |  56 ++++
 8 files changed, 978 insertions(+), 36 deletions(-)


base-commit: 4a13f31a92f35161b499bf29638336885259da78
-- 
2.53.0


