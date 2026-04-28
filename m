Return-Path: <netdev+bounces-281946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOjFM6nQ8GlVZAEAu9opvQ
	(envelope-from <netdev+bounces-281946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:22:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 568F0487B99
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FB2930342AA
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77C83ACA4C;
	Tue, 28 Apr 2026 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVSR79Tb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E65313298
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389685; cv=none; b=YpMmTQKiXyjsJ25fjzjgvKPNmRH1qhJtA+slcS1EZUqc2o0NFy/F2jseY/5KM45mBBMQYaWFlkpyfzhl/WrCrPje0h26d0LxH6B8DYRCfMeQncvKWPayrp3nOunw40Awos1ncjZxrdJJAQQCMEVnQ5myXn7nn01V/OPqPIK8SEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389685; c=relaxed/simple;
	bh=g3rDPyoB6o4kkf/H7aV+Lm6OUjp2XBxk2DcKL6j6PQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jkH0PPNCOZXdq61vFAZ71WZGOQbtVm0wuWQv0u3igO1jj1cfUh4mlmsrqGTGtMfp2SThbBP9yTkQSQIN9VpiGpqwrygHdQS/NB8Fjr0PA1sR1quyg54atx1kIksGg60Joo3Twcp0g5UtZDzBEJ6lCZE7HNC4CgBgoBEYYCMN4Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVSR79Tb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777389683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xa8EOyAJjy38ToKv34WfFIs+LAjWNfKa6AvBw4bHfkg=;
	b=AVSR79Tbpn7qT0LG252P5w59U7RUEz+93BTaOfQygE75Ga+Y/RGXR/hqIO5aXPPYuvB3q+
	7lbbVWJiQUT+gWMPyxf5vSqPqimf2eUyJ+eA7VhBVyxZzGfV3c+HvKlEoUX/YscCe7I7V5
	vQOQAe6iboRj8Rh3PY2i0QMXLV+wews=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-w0XEgs7aMse4fMOuAT3HJQ-1; Tue,
 28 Apr 2026 11:21:20 -0400
X-MC-Unique: w0XEgs7aMse4fMOuAT3HJQ-1
X-Mimecast-MFC-AGG-ID: w0XEgs7aMse4fMOuAT3HJQ_1777389679
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBABA19560B4;
	Tue, 28 Apr 2026 15:21:18 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.49.234])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 27F2B195608E;
	Tue, 28 Apr 2026 15:21:16 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next 0/2] dpll: phase unit display and frequency monitoring
Date: Tue, 28 Apr 2026 17:21:13 +0200
Message-ID: <20260428152115.2815860-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 568F0487B99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281946-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This series improves dpll pin output formatting and adds support for
the frequency monitoring feature.

Patch 1 adds picosecond unit to phase-adjust-min, phase-adjust-max
and phase-adjust attributes. It also introduces the DPLL_PR_PHASE_OFFSET
macro that properly formats phase-offset as fractional picoseconds by
dividing the raw kernel value by DPLL_PHASE_OFFSET_DIVIDER.

Patch 2 adds support for the new frequency monitoring feature including
the DPLL_A_FREQUENCY_MONITOR device attribute and
DPLL_A_PIN_MEASURED_FREQUENCY pin attribute. The measured frequency is
displayed as fractional Hz using the DPLL_PR_MEASURED_FREQUENCY macro
since the kernel reports the value in millihertz. It also refactors
phase-offset-monitor parsing into a shared helper.

Tested on EDS2 development board with zl3073x DPLL:

  # dpll pin show package-label REF0P
  pin id 196:
    module-name: zl3073x
    clock-id: 13709406750444215013
    board-label: SyncE IN M1 CLK1
    package-label: REF0P
    type: synce-eth-port
    frequency: 125000000 Hz
    measured-frequency: 124999326.000 Hz
    frequency-supported:
      2500000 Hz
      25000000 Hz
      125000000 Hz
    capabilities: 0x6 state-can-change priority-can-change
    phase-adjust-min: -2147483648 ps
    phase-adjust-max: 2147483647 ps
    phase-adjust: 0 ps
    parent-device:
      id 14 direction input prio 10 state selectable phase-offset 0.000 ps
      id 15 direction input prio 0 state connected phase-offset 323.000 ps

Ivan Vecera (2):
  dpll: add ps unit to phase-related pin attributes
  dpll: add frequency monitoring support

 bash-completion/dpll |  4 +-
 dpll/dpll.c          | 89 +++++++++++++++++++++++++++++++++++---------
 man/man8/dpll.8      | 19 +++++++++-
 3 files changed, 90 insertions(+), 22 deletions(-)

-- 
2.53.0


