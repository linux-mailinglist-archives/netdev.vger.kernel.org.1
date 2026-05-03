Return-Path: <netdev+bounces-283610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHMSKT1m92n6gwIAu9opvQ
	(envelope-from <netdev+bounces-283610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:14:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 201374B632F
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E564E300461F
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 15:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5932C21D8;
	Sun,  3 May 2026 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K43Zi1DH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E372C11E8
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777821240; cv=none; b=hFxwIix+WZbqOYPeeH3iZkSjlMJJyek/APB7dGJmouEY0JKGR9B53VkHankG7hBXHUY0WsoAmM3v2wS9ffXdwI9ncFDEHwvH/kLFx/Co91ORBzOe4bCINy1HiBEWlRe9VyaQrMo3/SJSsw7yuXj9OqY1mT2M3Z3W4/B2RZLT+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777821240; c=relaxed/simple;
	bh=j7nmmeV2jGzaSD4hDFgmCCRdM+D5aytBNkpBJS6jI0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O2bZy+U5bb7lV1s4cmV1uJ+4PCZqKaHnDq43lDSwb2MPhvxYaBxuDs2E7kWU6+G7sTgfHS/gBvFRyzk+zxjhllYPVrDOCIzLKgv+CK7G+DGLGMcZYpO6ANfXClLmEHRyJEbG15pN3DeFyTV52gCZJPaQu+eskctNRRDBLg3wxPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K43Zi1DH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777821237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ylMpLjYVnS6O73U/GUCnlrghivV8gYlFpPdeSj1oh8w=;
	b=K43Zi1DHi6dHYtgSzK0R3iKqaFS8ATAF71GKAN/005FElqtR0QZMqmmB/tH3mhpnbaspT6
	B5JABjRGd/zNxCQQSi17V1JjfPdt9mEcFsYxHJN+JPOxpFtenTqsg2dp1d9QoDi/Ezybf4
	XNX6VxmzUgOwe78TvteK2ZFeKPOLzpk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-VZeZ3ibwPzeJKsssN27Ldw-1; Sun,
 03 May 2026 11:13:56 -0400
X-MC-Unique: VZeZ3ibwPzeJKsssN27Ldw-1
X-Mimecast-MFC-AGG-ID: VZeZ3ibwPzeJKsssN27Ldw_1777821235
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6447195608E;
	Sun,  3 May 2026 15:13:55 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.48.53])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2C7830001A1;
	Sun,  3 May 2026 15:13:53 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next v2 0/2] dpll: phase unit display and frequency monitoring
Date: Sun,  3 May 2026 17:13:50 +0200
Message-ID: <20260503151352.136509-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 201374B632F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283610-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

Changes:
v2:
- fixed very long line in the man page

Ivan Vecera (2):
  dpll: add ps unit to phase-related pin attributes
  dpll: add frequency monitoring support

 bash-completion/dpll |  4 +-
 dpll/dpll.c          | 89 +++++++++++++++++++++++++++++++++++---------
 man/man8/dpll.8      | 19 +++++++++-
 3 files changed, 90 insertions(+), 22 deletions(-)

-- 
2.53.0


