Return-Path: <netdev+bounces-279326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOFYOLc+4mmB3wAAu9opvQ
	(envelope-from <netdev+bounces-279326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:07:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D6B41BDEF
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C17530C83AA
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD60B3B0AD6;
	Fri, 17 Apr 2026 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="HDzJXT8v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f100.google.com (mail-ed1-f100.google.com [209.85.208.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424202D7DC6
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776434711; cv=none; b=Ua939uorhZUPBO2ACxlKJm9alScMsi1g3xoBDQK3Bo5Ta5h3d3wGhw/rfUSzT/TFHTb33tsOgW//xEvUGFU3yPEC8UubTeBYq1OlaBriHhVOAvhfsmjal7+QzW2UE2Dj6kMnQlS0q+339YPYODUzFnYiIGXKnGNfeThGttq8LFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776434711; c=relaxed/simple;
	bh=8gf2bXFYik4CReIzMQ4zAC5OXHtzgCN5M+F0QoG0zKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sAnl+vkAiLNEKa8cGOEX9L7R+cqSEByduzo/K+di9r32KVG40AdvUTaZcXSi6bCX/yKtYSXgBHtmRxG+5HlSyp9xzByt+PppeSfzfzg0/dRjFm/AMza9VpWvfO0p/LCJ+E84Uv+96lsY/XvfXHfUZrM6iRM6UFTNLYMmTLP1/ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=HDzJXT8v; arc=none smtp.client-ip=209.85.208.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f100.google.com with SMTP id 4fb4d7f45d1cf-671dad7cac8so1116857a12.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1776434709; x=1777039509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jdlhv0+MMf+afk0WQf+9d4l/m6rjbKwKx66KpbNgDuc=;
        b=HDzJXT8vbGbAYTBU68qakuKp+LSeSwiwCoGohjn3h0crH4zSW1LCT9QEp8MkOR7+d7
         cJeTKujfAwirlzVnQ9Lf3L23xwzZZQa19xFaFO0fWtd1ukkgTXpJ+YSS8IzOyzBShQQx
         OKaFKCBE0w64uA26igcV300OLrPk0mq+0vdU3Woc6YkW9j25OX4mOtJMqDS2h8P41vNO
         lr1T127uYxQAykK/V/g4TIf14l+FUhuLtd9TMK602u7WdMY1lvK1KY6pGj99Om+x39Rh
         tk9Lbpqk75eblbfNYXPKQhW0AzY8Z+ixS1yclXda/lpquPfDj+5pFL/8OpzjXeMluey/
         xSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776434709; x=1777039509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdlhv0+MMf+afk0WQf+9d4l/m6rjbKwKx66KpbNgDuc=;
        b=AdrfV8Jw7wfKs2DKhafNSJAgu97cRDJK10dOKsbFZZJoLcDuMGgrBWbxS3bZc46qXP
         XJk44IYd53/IV1yhcmcN4O1tPmh3zHePKKyanqsWcbGMpSUihuWQOOUe0w6FX9YT+aXw
         yaSkqD+kY+uy8mKo0iyGArG4PKozDEQP/RjjD//voTonJQv/cteO4fP/ZAAbI52MWDg4
         5pM+G+SlpNMpTZvbgZeL+6NIZcIeusLtZUWiKxyxfvYMwQ/RK5EJsytuUa00PDJCFBKC
         nqcekSuwSGv10upVW/CT+mksx0s6a6n0SGDFEH20fwFOXYOFbcN2D4addPrWnbOqZAb/
         9fpw==
X-Gm-Message-State: AOJu0YwLA8n8W3gimseTfFbo9EOi9cmEYjHzpkuyWGhqc67zCua3HzMq
	vOU//4WR6KN96OrGeUl3g3hQuO1PoUTRRTh0zMiAEBCy0mss6c6FttkgI6aNK/UWes3epQzpEKZ
	YxNBBXPXu9qMEiJ4ISsLQcT7NhGkKSkc3P/n3
X-Gm-Gg: AeBDietOn3vAdUntZdZS+f7Fbt+KCMY2y96c/pQA6xGn4PNnrtBK6NGM+ki+yErIfVi
	41LHLeVJoE8owFxDcMjUAmRqIqczFiIn9icU/744E1xRh53H2QqvGJUh8i0OpzCJ3BaY3DCbns3
	gN3Z9h+oXsP41qrP+syr4CaweXloW5u5Zcd8kTc3ykOGi4/jpy3Ru8YfJqzCqM7yiIFN19fM5Rh
	0uOQUZSiR6aaVp4RoCfu4gjurS7o1xXR2DDbVursxK3AG6o2BbOJpa0EMXn2nx26cgs7iuEgfjC
	3wj/ZnY2MrMT3RztYeNih6M/8JKR63D+3hf0DMDj2ihiPdnVm6kqNyNCd0U6PnxbfXMGpJSSGEC
	b9ckDuGIRayzJbNH4551GORmzJ+zjO5p8ZU96Tq0VHg9G4YCyPzx8xgUUpUuN21k=
X-Received: by 2002:a17:907:c9a7:b0:b9f:1812:a496 with SMTP id a640c23a62f3a-ba41ac02cdcmr119862266b.36.1776434707293;
        Fri, 17 Apr 2026 07:05:07 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-ba454e2813fsm13434166b.76.2026.04.17.07.05.07;
        Fri, 17 Apr 2026 07:05:07 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 1CD351364D;
	Fri, 17 Apr 2026 16:05:07 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v4 0/4] bonding: 3ad: fix carrier state with no usable slaves
Date: Fri, 17 Apr 2026 16:05:01 +0200
Message-Id: <20260417140505.3860237-1-louis.scalbert@6wind.com>
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
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279326-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.987];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:mid]
X-Rspamd-Queue-Id: 40D6B41BDEF
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
  bonding: 3ad: fix carrier when no valid slaves
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
 .../drivers/net/bonding/bond_lacp_strict.sh   | 299 ++++++++++++++++++
 10 files changed, 397 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_strict.sh

-- 
2.39.2


