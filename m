Return-Path: <netdev+bounces-283949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDQKJqrJ+Gls0wIAu9opvQ
	(envelope-from <netdev+bounces-283949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:30:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C4A4C15EC
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84E35300B459
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACD83E3C5A;
	Mon,  4 May 2026 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5CvL0To"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704F19460
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912222; cv=none; b=EfFUoJ8nvThyNshsRWC1trrSjovFMBJWGMztlrpsC7vQTEApsvD4aX4lK0w4USas05JWgU482KxGvhWLXtFKE69OvmbXsWdLR0Smr0eXDSXc5P9q6m6j5uB7W5Ez+fGsn2sNJkSCml/bEnPcAyUoc7LmbaLBNVt+mUWhCsLFRJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912222; c=relaxed/simple;
	bh=nmTbwph7RUbeefZJvRicagQEUwXIqEHd7P8CMMRjn6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOy6Yr1IXlqjnxwqPhnAnlz8GlB5kz5onZ+LqNO0Z+x9bNHBr3uYFyrcC0FC93XVrqQFzlJzuAT0rLOYQb0uBkGWXTIgTtE5WO5uBRYauXarQHjs4afXwDZ3jDDhGZEx2piUWGQEfM2Zx8xBuq4YB7FdiQrRlzWj0a+92Edx+1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5CvL0To; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777912219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wnhfUfqrnBbCaueGjQ+g9qYn044B4g95Fe76WBlON+4=;
	b=M5CvL0TovvU9ANkrfEKmxExXJlwXZoxyxg5dYKhVemeBBYTsoyVpUd+KigUI3/Bm/7aNTq
	3ospuDq/kEi6ssBU+KeANMirNJREgwVZWnXMFyLTvcHMV6rqK2UsQI/K5lW8RmS18dG61b
	mDenFyClE7Ap9IH1cH27XMz7GBZMN0E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-X-1hemWTOzaiaV9m7SizGQ-1; Mon,
 04 May 2026 12:30:18 -0400
X-MC-Unique: X-1hemWTOzaiaV9m7SizGQ-1
X-Mimecast-MFC-AGG-ID: X-1hemWTOzaiaV9m7SizGQ_1777912217
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6909A1800605;
	Mon,  4 May 2026 16:30:17 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACABC19560A6;
	Mon,  4 May 2026 16:30:15 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next v3 0/2] dpll: phase unit display and frequency monitoring
Date: Mon,  4 May 2026 18:30:12 +0200
Message-ID: <20260504163014.416317-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 43C4A4C15EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283949-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

This series improves dpll pin output formatting and adds support for
the frequency monitoring feature.

Patch 1 adds picosecond unit to phase-adjust-min, phase-adjust-max
and phase-adjust attributes. It also introduces dpll_pr_phase_offset()
helper that properly formats phase-offset as fractional picoseconds by
dividing the raw kernel value by DPLL_PHASE_OFFSET_DIVIDER.

Patch 2 adds support for the new frequency monitoring feature including
the DPLL_A_FREQUENCY_MONITOR device attribute and
DPLL_A_PIN_MEASURED_FREQUENCY pin attribute. The measured frequency is
displayed as fractional Hz using dpll_pr_measured_frequency() helper
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

Changes:
v3:
- replaced DPLL_PR_PHASE_OFFSET and DPLL_PR_MEASURED_FREQUENCY macros
  with dpll_pr_phase_offset() and dpll_pr_measured_frequency() functions
- added frequency monitor status to device show man page output list
- simplified device set synopsis in man page
- removed stray blank line in patch 1
v2:
- fixed very long line in the man page

Ivan Vecera (2):
  dpll: add ps unit to phase-related pin attributes
  dpll: add frequency monitoring support

 bash-completion/dpll |  4 +-
 dpll/dpll.c          | 93 +++++++++++++++++++++++++++++++++++---------
 man/man8/dpll.8      | 21 +++++++++-
 3 files changed, 96 insertions(+), 22 deletions(-)

-- 
2.53.0


