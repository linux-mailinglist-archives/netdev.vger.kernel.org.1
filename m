Return-Path: <netdev+bounces-284940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB4YEGFo+2miawMAu9opvQ
	(envelope-from <netdev+bounces-284940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:12:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A36A84DDE9B
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41BAA300F501
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 16:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19813EE1FD;
	Wed,  6 May 2026 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="FIS4BYpU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f98.google.com (mail-ej1-f98.google.com [209.85.218.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2E8481235
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083919; cv=none; b=ps2E60Ros6GD1fB5I9dc9xhwxMnQw8M8Ngbw9t75q4XrlPkoPr1uRytoPhAiD2bAY64A/ZkkdemWqdHxvpeUeHLPibIe/Pf4W5lzwbLFGIw1mXJ1rF74KukQl2RoDSzdW5X6/uS6nmaLakMbMFlUyffP9p4dmYvYBUbjQdpxtzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083919; c=relaxed/simple;
	bh=TkroxrHRlpC0OhWh7xx6aPQJ1+tW0lRwmemjmqsklP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ElNvZKBfOVCPsFbps5zAgjQcGb/NkQcIrZO7XKurKcN3ptA9SVXxD2gfZY0wr3WJeh/CySwSPPN0eeEkiP9ZFXP63FsJm3PT8I+VMyENQsp9INIMt+JxJ2B2ZJbsathgFOgQohYpUR4FMlnrcHt4Y8gA1GR4+yJTR2VcKmVVjuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=FIS4BYpU; arc=none smtp.client-ip=209.85.218.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f98.google.com with SMTP id a640c23a62f3a-bc2a455fd55so484929466b.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1778083908; x=1778688708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aZ2rtxHSRDTew4NRGhGIsuHknpEzggRW1eGGz2cEL8E=;
        b=FIS4BYpUPDJFQ+JVZ0Y33SozMrh25Dcjphxn/P4w3QoEfqfrbsbqft02yBGx90qXmL
         hFFL411mVXx6tAEHEDvUXXrxtrwtLhns+rjrSKe6nGyENe0F5jmigKeJ5WUcieenHPqv
         nX0Ss8ycjVXu7xhx79Lc4J37fxp3xksFuMySVRT7Z5KU5q60JiiN+rbB96ggyJ7RJBxY
         65UH/MvsKWiQjpBq9LkbF6JVUVGiOrM/M9Oz7XueSsNu8QKt6nUxaljZtY4SuosEvhYB
         JSQq8hhZNyzNEmf0uCll1drLbMa76gxpYUXIGXPl6FuCjRMy6GikCW9qAlRmpm82amCA
         GXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083908; x=1778688708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZ2rtxHSRDTew4NRGhGIsuHknpEzggRW1eGGz2cEL8E=;
        b=Bc8uJMJhrHBI8NIJdJZA04Itjt/lH8OglW/I5dIb0q7863EwRkoZQK0C0VPrHGZKKX
         H1A1q1lkxqJ3pQP7w+vLKJ6MX2CWPYJifZilAZZa8UyX9sfUcJP7ZFiHpK0kEeWqqAq0
         GtGqi6INnNI5/sntXbwUSdjzC2sRzs3lndHZTdc4R2uATbq659BhcVF0ZajQ/jc51RV1
         nyKlwN+UWnx0/4G02fbOnP/p6VHiIYHJpkAb2NM+PVmIIbPykio5L7jgPW+pli3VlWir
         3BEhvFIG13cUJT988W0XPT/Z3S5L/OSrQEuhQx2M+RMQaz0IpVX2YyI6+niv9Q77dxnu
         XSbA==
X-Gm-Message-State: AOJu0YzU2Io1rFuryuyhlinyovTJF3t9Rf7v5yG688G0bN00OLt1dPy/
	tkWMMbDY9RimBuX7geEQkjfAHwyiqYS74Jhjk4viFnDcebx069KcpqGf4RI/X2neDeholef79HF
	M9906ieoAUgrV21xSvv3N7c43A7lAnOGbyuQ1
X-Gm-Gg: AeBDietI/d76wia06nJChFgw+BzbmTc49Bs5D2I28Gg/GA1MgfBLlE5oXylp71h+39h
	5FO+KP0l1j3hBuLsZxJQXj05SbyHb0HNAnZyNG/EklzQ1Lm0X+tjeqWtM84+u3zNoFNdBGR5p9y
	29szzJgTGIuzPik770w3hTBg4v4e1uu26YiYxYzRFZaK8aPpzj9ZCtmW8q1UJNdUqttE/e+aZ7w
	0zGaJxfcSUfJXQmJRC7aGV1SPyurxB6MHmtItkfiBRIKksU+QkKgzLoVd7XF5hwUDn3yeLiCb6O
	mcaK2PrPI198kIDfxyKp+VfJl+R1r+SoHZYXEAIuTCuskt/IYrZq3GEkr4VVY/xsgir32rjw/o2
	OCO3sWfBC9tur60RBH0YwqCkh0fEkNkUQ10fOaDkcYjGK1yoO5J83VcFZaPxKfnA=
X-Received: by 2002:a17:907:6d03:b0:bba:5baa:171c with SMTP id a640c23a62f3a-bc56b32187amr215792566b.15.1778083908171;
        Wed, 06 May 2026 09:11:48 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-bc55c679acfsm16550966b.35.2026.05.06.09.11.48;
        Wed, 06 May 2026 09:11:48 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 04DC11755B;
	Wed,  6 May 2026 18:11:48 +0200 (CEST)
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
Subject: [PATCH net v5 0/4] bonding: 3ad: fix carrier state with no usable slaves
Date: Wed,  6 May 2026 18:11:40 +0200
Message-Id: <20260506161144.465485-1-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A36A84DDE9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com,6wind.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284940-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
 drivers/net/bonding/bond_3ad.c                |  28 +-
 drivers/net/bonding/bond_main.c               |   1 +
 drivers/net/bonding/bond_netlink.c            |  16 +
 drivers/net/bonding/bond_options.c            |  27 ++
 include/net/bond_options.h                    |   1 +
 include/net/bonding.h                         |   1 +
 include/uapi/linux/if_link.h                  |   1 +
 .../selftests/drivers/net/bonding/Makefile    |   1 +
 .../drivers/net/bonding/bond_lacp_strict.sh   | 347 ++++++++++++++++++
 10 files changed, 445 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_strict.sh

-- 
2.39.2


