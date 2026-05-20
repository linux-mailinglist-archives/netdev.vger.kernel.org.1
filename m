Return-Path: <netdev+bounces-289905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMfEN0+dDWoS0AUAu9opvQ
	(envelope-from <netdev+bounces-289905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:38:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6297058CBC4
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B092300F168
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA4F3E7BDE;
	Wed, 20 May 2026 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="ix2+MP7+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f98.google.com (mail-ej1-f98.google.com [209.85.218.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5A83C661A
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276346; cv=none; b=F65tVRHSkTNATKfpU+WMgHoVZcaoDmE6+5AVpkQaF0ZCwHIWrRjGI3WFxiH0h/Bq3fwRtNLttaMiUs2l4xZ61sCfROgt0gDdjL2TeXfLGdjjsTZhQEg0iVHs4sNkes9HWt5z3wkEEWeM1Ot01iaQ6xwF6F2igJBrC+l4ha/gCWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276346; c=relaxed/simple;
	bh=7juzTveXUeaB3fsBdJmZ/nA5HHfUkOLD/Q2nyXqayLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UusKohA4/mTwDDJMN+E7gySFWQhoX/eGBMXsJpunOJFVrKCY3/9af1n8YKhOjMihWwrOSutA2zghBGHtradRuovjRyK483HW7NVtCmnBY5zavnssIKx9/pUy8XkgXwHsa2yFgIaaziHM7KWNiL/uZLraRN9VNIIezeFmpbNzRow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=ix2+MP7+; arc=none smtp.client-ip=209.85.218.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f98.google.com with SMTP id a640c23a62f3a-bd8f9725b30so380074166b.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 04:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779276341; x=1779881141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbvKu8M5hQerrHEUTFB6c6pcUL6vC+91lraKZ1m/HRo=;
        b=ix2+MP7+6FcKtWV4GRZbLtuHwPNr2FM7rmwGzaXkF9azlAWE7dxuzpH9Gdn6rHK1vw
         5eOubBFsEPwMOQ0OYGl/bbRjSCR9j9l92l0Htey2lSY6MB184NWOoywfPK87FA7iT9bG
         JakiVIPzlc36O0WS9djYge6AugfFEg72yK/01de0wp8GKFprkoG5Dz9rbJT1EeKz1E85
         DWWm6yn7zDCuCuvYhuVJss1RO5x/IEtlUMxcqotFYgIcLauZ5OPEAClN/CUOnD1JI7Hm
         EOKdQiS3Pf5sJAV/yXaDG5R9afRvDwRjdysR0XUZcK34iZnBUbs9kY0ppB7s+sdxHzS7
         5t1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779276341; x=1779881141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbvKu8M5hQerrHEUTFB6c6pcUL6vC+91lraKZ1m/HRo=;
        b=q+/gv48A0YkRJ3Voc3JYK+H6msHfI36tVL2Tj5LZR39vglXQIHF6VUdBmX/LTFNTVq
         2Lkb3gMZYE0UOVPZ34FATQAAyf7ynA5sHLR7p350n5hpqC+TvmHsAFORMLDoGIFM2uul
         1cwqjUcyTD4qXunCNSlS4wb8vJF43IrMcTLTgr/j6SDeunY4pC2JkwfK9u4qJCHIS8FN
         6cFHvDagRr4UMyIBq+cELxizO6tlOqmh9AlEBEvGcAUZ1SCgzIPdwI0y0Ko3mPfiGNlV
         ic+hhUG6xjkgZ1xCGlUyFEhs4kpxuzJXG+TFGj11NZaIoK2RYH81KXRC0R5e0wriXDL6
         mCZw==
X-Gm-Message-State: AOJu0YzG1ERx4GQfieZOTrxJuhf9lvGU1dr6S3VIk4IMRWFwMiqLi13j
	xG+T8I4htkPLtj0/HkzFLTd89FGXTdytzLPyH3u2/VLMk13xFbZcaR2ULEV5GiHD3Z45s/ygxTw
	R3FlaBfOc/sScsnH5tYjVTOjXwJh1QBDKaqRN
X-Gm-Gg: Acq92OG2OtOcKvr7rogb6DIYm+k8yeGGx6PhHAbcaN+2miFOy1fPFz7vYEM4ula+BMl
	Ff/ugbYYj2C3/6+e715RJ0Vr1YkffFSuejOyJEBi4drzKDi8QifSW2tn8H2ELpOMKa0KYbPFgET
	XIFnb2AdTTZCD6X9hYkJPr7TSxyGYj6vfD29BdEAugTQCGi+kW5D/KdUSi/95AqOe7BZN7d5QQ3
	gZ5K3eiRi3819L2Y589Lgv76Ys5c08NeM+M+s/Evo5OrkJk6NOOvNuBVo1Zt5AE6ZjhdsLuXRnc
	wMZeJtgkD3MXeXeWaVD3f+r4tlSQDXcn7ox2NkLDHRu3WbdLDWnovF48+j7Ouf6T7uMYl97AT4S
	Jlk+sYIsa5rQJOr1dZqiGfIMcCTXYPhV5zETSO26HXyUcuEIp/zZG
X-Received: by 2002:a17:907:a286:b0:bd3:2b8a:2164 with SMTP id a640c23a62f3a-bd517842e7dmr1382243466b.16.1779276341444;
        Wed, 20 May 2026 04:25:41 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-bd5048b1deesm116545966b.19.2026.05.20.04.25.41;
        Wed, 20 May 2026 04:25:41 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 3CAD71153D;
	Wed, 20 May 2026 13:25:41 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	jonas.gorski@gmail.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v6 0/4] bonding: 3ad: fix carrier state with no usable slaves
Date: Wed, 20 May 2026 13:25:35 +0200
Message-Id: <20260520112539.798275-1-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com,6wind.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289905-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6297058CBC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi everyone,

This series addresses a blackholing issue and a subsequent link-flapping
issue in the 802.3ad bonding driver when dealing with inactive slaves
and the `min_links` parameter.

When an 802.3ad (LACP) bonding interface has no slaves in the
collecting/distributing state, the bonding master still reports
carrier as up as long as at least 'min_links' slaves have carrier.

In this situation, only one slave is effectively used for TX/RX,
while traffic received on other slaves is dropped. Upper-layer
daemons therefore consider the interface operational, even though
traffic may be blackholed if the lack of LACP negotiation means
the partner is not ready to deal with traffic.

This patchset introduces an optional behavior, widely adopted across
the industry, to address this issue. It consists of bringing the
bonding master interface down to signal to upper-layer processes
that it is not usable.

This patchset depends on the following iproute2 change:
ip/bond: add lacp_strict support

Patch 1 introduces the lacp_strict configuration knob, which is
applied in the subsequent patch. The default (off) mode preserves
the existing behavior, while the strict mode (on) is intended to force
the bonding master carrier down in this situation.

Patch 2 addresses the core issue when lacp_strict is set to strict.
It ensures that carrier is asserted only when at least 'min_links'
slaves are in the Collecting/Distributing state.

Patch 3 fixes a side effect of the second patch. Tightening the carrier 
logic exposes a state persistence bug: when a physical link goes down, 
the LACP collecting/distributing flags remain set. When the link returns, 
the interface briefly hallucinates that it is ready, bounces the carrier 
up, and then drops it again once LACP renegotiation starts. Fix by
resetting Collecting and Distributing state as soon as the link goes
down.

Patch 4 adds a test for bonding lacp_strict both modes.


Changelog:

v5 -> v6
  - Patch 3: the v5 patch was compliant with 802.1ax-2020, but the target
    specification is 802.1ax-2014. The fix has been reworked accordingly.
    Collecting and Distributing were not cleared on port down because the
    Receive state machine was not clearing the Partner Sync flag.
  Link: https://lore.kernel.org/netdev/20260506161144.465485-1-louis.scalbert@6wind.com/

v4 -> v5
  - Patch 4: replace the use of netem, which is not included in the
    bonding selftests configuration. Instead, use a dedicated netns to
    forward frames between the partner and DUT. The partner and DUT are
    bridged within that netns. Since Linux bridges do not forward LACP
    special frames by default, group_fwd_mask is configured on bridge
    interfaces to allow them.
  Link: https://lore.kernel.org/netdev/20260417140505.3860237-1-louis.scalbert@6wind.com/

v3 -> v4
  - Rename the configuration knob to lacp_strict on/off instead of
    lacp_fallback legacy/strict.
  - Patch 1: change the command documentation accordingly and wrap
    text at approximately 75 columns.
  - Use "usable" wording instead "valid" for LACP Collecting /
    Distributing state in code and commit log.
  - Patch 2: test collecting and distributing state regardless of
    coupled_control
  - Patch 3: Reworked because removing the SELECTED flag was not
    compliant with 802.1AX. Instead, to transition to the WAITING state
    on port disabled, except when already in the DETACHED state.
    And remove Collecting and Distributing state in WAITING state.
  - Patch 4 is removed. It was a fix for patch 3 but it is no more
    needed since patch 3 was reworked.
  Link: https://lore.kernel.org/netdev/20260408152353.276204-1-louis.scalbert@6wind.com/

v2 -> v3
  - Add an initial patch introducing the lacp_fallback configuration
    knob (no behavior change yet).
  - Patch 2 (was patch 1 in v2): apply the new behavior only when
    lacp_fallback is set to strict, and re-evaluate the bonding
    master carrier when the setting changes.
  Link: https://lore.kernel.org/netdev/20260325134439.3048615-1-louis.scalbert@6wind.com/

v1 -> v2
  - Patch 1: split a comment line that exceeded 80 characters.
  - Move the change from patch 2 in __agg_ports_are_ready() into a third
    patch, as it is actually a side effect of the fix introduced in
    patch 2.
  - Patch 2: Expand the commit message and add a code comment describing
    the change in ad_port_selection_logic().
  - Patch 3: Check the READY_N flag only on ports in the WAITING state,
    rather than on all enabled ports. This more closely matches 802.3ad.
  Link: https://lore.kernel.org/netdev/20260316131838.3257889-1-louis.scalbert@6wind.com/

Louis Scalbert (4):
  bonding: 3ad: add lacp_strict configuration knob
  bonding: 3ad: fix carrier when no usable slaves
  bonding: 3ad: fix mux port state on oper down
  selftests: bonding: add test for lacp_strict mode

 Documentation/networking/bonding.rst          |  23 ++
 drivers/net/bonding/bond_3ad.c                |  22 +-
 drivers/net/bonding/bond_main.c               |   1 +
 drivers/net/bonding/bond_netlink.c            |  16 +
 drivers/net/bonding/bond_options.c            |  27 ++
 include/net/bond_options.h                    |   1 +
 include/net/bonding.h                         |   1 +
 include/uapi/linux/if_link.h                  |   1 +
 .../selftests/drivers/net/bonding/Makefile    |   1 +
 .../drivers/net/bonding/bond_lacp_strict.sh   | 347 ++++++++++++++++++
 10 files changed, 439 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_strict.sh

-- 
2.39.2


