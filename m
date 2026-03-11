Return-Path: <netdev+bounces-266747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFOyFPe7sWmxEwAAu9opvQ
	(envelope-from <netdev+bounces-266747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:01:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEADF268FCC
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 740623038ACA
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5F423C4F2;
	Wed, 11 Mar 2026 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTcLaR0l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DEA3DBA0
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773255668; cv=none; b=HSMF3Vm9JU6v7Jar9RvdtWNvGjVeCfunXRZlqILnkszOybWBKxpHDrI9kTLSGmvW1QVJa2lU8bqd3pu2xVNLXowh/jmTPJGxjakB7bet6mLum569Q62fNA+t2HW1YAxaSLgQ7CpUZtW0DGGEtxi6smIy65+9j/7RbJCM7y01XWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773255668; c=relaxed/simple;
	bh=fKQvuMEzx7DeB35WctRSho4AcCzhvZXQtbPZzQAelDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M33of7R+C8Hkgbl2cQpl1DhhRlL221ouhds9Px+zwIOdFz2LI1ii0v+arEpya+zmKVr49BPajSoXPJt6qIuGUolpDjrgAvlI+tv/P/m+JkJDQFlMa9MPZx2dbC/+AuP52rjT9kYGeAPSw1VSW8FmB/uhF3Mcw7zZTyW5FxEZVvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hTcLaR0l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773255666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YramWqkxwSTYzPT+KKkH96hu01V6G3/L6YTRDyT8DIE=;
	b=hTcLaR0lc4iPsr47LiLvS31EGSgfXJiGzTn/F73+CRD/FCpXYK6Na3cCOszVFEi1eHD+qB
	cs5AU82Lk1ztizAYC72s0IEbKzYA2YJ+sBkyN2UmgNa4lMbhkjcp/yx4Dy7A8avzgacfEY
	KKqkf6FFG/ICsQi0YM0QTV6gFKNXJJw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-Phqw8KC4O0Kqbko2j6PTmA-1; Wed,
 11 Mar 2026 15:01:02 -0400
X-MC-Unique: Phqw8KC4O0Kqbko2j6PTmA-1
X-Mimecast-MFC-AGG-ID: Phqw8KC4O0Kqbko2j6PTmA_1773255661
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C60C1956094;
	Wed, 11 Mar 2026 19:01:00 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.49])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0FC2230002D2;
	Wed, 11 Mar 2026 19:00:56 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Oros <poros@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/6] dpll: zl3073x: refactor state management
Date: Wed, 11 Mar 2026 20:00:49 +0100
Message-ID: <20260311190055.139006-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266747-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DEADF268FCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series refactors the zl3073x DPLL driver to centralize hardware
state management behind dedicated per-module state interfaces, replacing
scattered direct register accesses in dpll.c with cached state and
proper accessor functions.

The driver already uses a fetch/get/set pattern for ref, out, and synth
modules. This series extends and refines that pattern:

First, struct_group() is applied to the existing ref, out, and synth
structures to partition fields into cfg (mutable configuration), inv
(invariants set at init), and stat (read-only status) groups. This
enables group-level memcmp for short-circuit checks and bulk copies in
state_set, and adds invariant validation guards.

A ref_state_update() helper is extracted to encapsulate the per-reference
monitor status register read, keeping direct register access behind the
ref module interface.

A new zl3073x_chan module is introduced following the same pattern,
caching the DPLL channel mode_refsel register with inline getters and
setters. The refsel_mode and forced_ref fields are removed from struct
zl3073x_dpll in favor of the cached channel state.

The chan module is then extended with cached mon_status and refsel_status
registers, converting lock_status_get and selected_ref_get from direct
HW reads to cached state lookups refreshed by the periodic worker.

Reference priority registers are cached in the chan cfg group, removing
the ad-hoc ref_prio_get/set functions and the redundant pin->selectable
flag, which is now derived from the cached priority. The
selected_ref_set function is inlined into input_pin_state_on_dpll_set,
unifying all mode paths through a single chan_state_set commit point.

Finally, selected_ref_get is dropped entirely since the refsel_status
register provides the selected reference regardless of mode, and
connected_ref_get is simplified to a direct refsel_state check.

Ivan Vecera (6):
  dpll: zl3073x: use struct_group to partition states
  dpll: zl3073x: add zl3073x_ref_state_update helper
  dpll: zl3073x: introduce zl3073x_chan for DPLL channel state
  dpll: zl3073x: add DPLL channel status fields to zl3073x_chan
  dpll: zl3073x: add reference priority to zl3073x_chan
  dpll: zl3073x: drop selected and simplify connected ref getter

 drivers/dpll/zl3073x/Makefile |   4 +-
 drivers/dpll/zl3073x/chan.c   | 164 ++++++++++++
 drivers/dpll/zl3073x/chan.h   | 179 +++++++++++++
 drivers/dpll/zl3073x/core.c   |  36 ++-
 drivers/dpll/zl3073x/core.h   |  14 +-
 drivers/dpll/zl3073x/dpll.c   | 490 +++++++++-------------------------
 drivers/dpll/zl3073x/dpll.h   |   4 -
 drivers/dpll/zl3073x/out.c    |  27 +-
 drivers/dpll/zl3073x/out.h    |  21 +-
 drivers/dpll/zl3073x/ref.c    |  58 ++--
 drivers/dpll/zl3073x/ref.h    |  33 ++-
 drivers/dpll/zl3073x/regs.h   |  12 +
 drivers/dpll/zl3073x/synth.h  |  16 +-
 13 files changed, 626 insertions(+), 432 deletions(-)
 create mode 100644 drivers/dpll/zl3073x/chan.c
 create mode 100644 drivers/dpll/zl3073x/chan.h

-- 
2.52.0


