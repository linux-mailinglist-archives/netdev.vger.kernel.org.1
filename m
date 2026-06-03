Return-Path: <netdev+bounces-294800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YcvdCuhNIGrl0gAAu9opvQ
	(envelope-from <netdev+bounces-294800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:53:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A4963971E
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:53:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=Y3HfO5F9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294800-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294800-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F13CD319634E
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9903A7D98;
	Wed,  3 Jun 2026 15:03:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f100.google.com (mail-lf1-f100.google.com [209.85.167.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B99395ADB
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:03:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499016; cv=none; b=VNvRAKAnGXn5usv8FLBKMIjrr1obfPBD/AvlqFhAx+MefbW6lHUEEfYXsFrQR8kbyK3WNUnuvCB3SSsw4+ZFpsFmFO/1MycHfUoJqw+LgWhx++bbPgj6mFhKqQgEzVx9rcgk0Sik9NwSejHto/XTpjkWz5OAzYrkAUdvOfGApjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499016; c=relaxed/simple;
	bh=v7AlIkE86uMdMywWLQ2PYmpPeTrXeaYw71dO2pMZyj0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=orFyD0dVRd64x1/ouxIBXl41ZMJAhI3WhloX/HcQQ9ccfKnZICgjC22PtPs3XJof/u+H0y1lJUIt9DLHiN9r83FKqLHP/foHFNPahQhnCQMqze9h3lcf1A8uhps6wHABRT/xct8jPBvk+oMurb4DzMqO6001AeOdMilGgWU4kis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Y3HfO5F9; arc=none smtp.client-ip=209.85.167.100
Received: by mail-lf1-f100.google.com with SMTP id 2adb3069b0e04-5aa5f11deb2so5723531e87.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1780499013; x=1781103813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sitH+C2YkJHE3T6BdVFHI4tCRKAS8aNYg5Ke501cBds=;
        b=Y3HfO5F9w14yRCsEsvO/gdMTgPXOJOK1z2mM/J9JKUtVrs6Kj+FjdbcREr9EZuwQ+y
         uCUmOkSSOV1IZZLKroMmfOctWbTr109ph0v+aYKnqD8fRltsypbJx0uGTWPoycuo/fBd
         n2oolmfnOJ2NBuFzJmlNnz3C72ug42rnslMHXVwx3LWa2BRrQkUHF45zU/j6tpncJ0q+
         nGySpR7c32AhxIbwkuddzdG2A+InidQSSKeyaam9Uh7WjOFrL/j1XIiNPIzUyAK0nyu/
         5L2CzDfbn+l7Gil/dogXdXPicQN16eMrddHgCw4TZcm/6UgIFzpQZGZVAM+PyEJr03eW
         /+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499013; x=1781103813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sitH+C2YkJHE3T6BdVFHI4tCRKAS8aNYg5Ke501cBds=;
        b=kAa3w4Td100KMIBo4lo6oSZOS6RSwlKgRIUqB8ILv/j3wKIEqork+gv12uIu0txm/A
         no0lW57zqigYXXjj+RJz4otx6zAYIIQ7yvkyVzPS7vqVv+r5Tb9zZWJ9VltRWZHfkgfx
         jmIvWjI9M0GKwu7G6V6dTZE8hK9nLrNe99ep9K6NBmNQkDZ+PIsYj6CBsCYsITXXEsbQ
         Rmb9WV8b2bgVvGSbzFNr1d21hBiV7ayRtnroakKFizkbqjZRVF/yynrlBanMjQ/aS6V6
         wjwEjHeADEgvGDEpAL9u0pAZJWJzOGysuLTpH/RnwOqSgdluSeLwTWmp3M2r4jzaNHo5
         zosA==
X-Gm-Message-State: AOJu0YwsEGp8qdzZqlU7OULZkPMno6D6QEOLlFDDupPGC+ufKZ0mcC0J
	rF7zlQmMXyoRed0q2W6TohPNDe2ZvcuXkp4GpmJeZcQa0xmeAl8h5+LjYMQomnEWAsUU80ZRA20
	66veZZxtgpGtKa/5N+VV7Ap71Dugp5hpIHldc
X-Gm-Gg: Acq92OF4ocnCAxCRr8zEpFmAAeSvwXRKe8xG2k1KmSFS/tazl4hBwX1/GR8Cqlt0fGr
	dCOOlWwVQoTDt+c/1Bl6Pb81uzIojOUd28F3sVgR1B1sJGy+YD7BZTdNXpNb73b2HlDt5oR0UiO
	vnJFMB8OHx33gosCwgvf4z7DObvA4zpAS3zSsfSO7Kxwo0JNs7nwkCSwfS16DNSkgbWstTShWVt
	CjksBmldopkzY1Ti2CuvZVRXpsEKNMi5jrjJ+gEXb8+zuK7Zy2WhJKu9md5Ibv/eFxWbVMjAicx
	TbBWUZ+80rgBN4GWhkplzVd+Jrzc+IVgP8GhrR+HQdNUwoq3uoPxTm+6DPcRjZ7EVgjcJuF+YW0
	MhAq0XBhb8UJGgZdVGP2buLn6nNucKDSAaKDwsfslLgnpTLo9wJJCktqQs9tLWuk=
X-Received: by 2002:a05:6512:3f21:b0:5aa:71fd:de75 with SMTP id 2adb3069b0e04-5aa7c125954mr1471063e87.39.1780499013239;
        Wed, 03 Jun 2026 08:03:33 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5aa7b8888e3sm194024e87.0.2026.06.03.08.03.33;
        Wed, 03 Jun 2026 08:03:33 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id D61B41470F;
	Wed,  3 Jun 2026 17:03:32 +0200 (CEST)
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
	horms@kernel.org,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v8 0/6] bonding: 3ad: fix carrier state with no usable slaves
Date: Wed,  3 Jun 2026 17:03:25 +0200
Message-Id: <20260603150331.1919611-1-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294800-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com,6wind.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:jv@jvosburgh.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:fbl@redhat.com,m:andy@greyhouse.net,m:shemminger@vyatta.com,m:maheshb@google.com,m:jonas.gorski@gmail.com,m:horms@kernel.org,m:louis.scalbert@6wind.com,m:andrew@lunn.ch,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:mid,6wind.com:from_mime,6wind.com:dkim,sashiko.dev:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15A4963971E

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
Link: https://lore.kernel.org/netdev/20260408152409.276358-1-louis.scalbert@6wind.com/

Patch 1 adds the missing IFLA_BOND_BROADCAST_NEIGH in if_link
UAPI header.

Patch 2 adds missing broadcast-neigh to YAML rt-link specs.

Patch 3 introduces the lacp_strict configuration knob, which is
applied in the subsequent patch. The default (off) mode preserves
the existing behavior, while the strict mode (on) is intended to force
the bonding master carrier down in this situation.

Patch 4 addresses the core issue when lacp_strict is set to strict.
It ensures that carrier is asserted only when at least 'min_links'
slaves are in the Collecting/Distributing state.

Patch 5 fixes a side effect of the previous patch. Tightening the carrier
logic exposes a state persistence bug: when a physical link goes down, 
the LACP collecting/distributing flags remain set. When the link returns, 
the interface briefly hallucinates that it is ready, bounces the carrier 
up, and then drops it again once LACP renegotiation starts. Fix by
resetting Collecting and Distributing state as soon as the link goes
down.

Patch 6 adds a test for bonding lacp_strict both modes.


Changelog:

v7 -> v8
  - Patch 3: addressed the Sashiko review comments, as requested by Simon
    Horman. When transitioning to DETACHED Mux state, reset Collecting /
    Distributing so the bonding carrier state is correctly re-evaluated.
    Also, re-evaluate the bonding carrier state when moving from
    Distributing to Collecting Mux state (coupled_control disabled).
  Link: https://sashiko.dev/#/patchset/20260526084048.1696544-1-louis.scalbert%406wind.com
  Link: https://lore.kernel.org/netdev/20260526084048.1696544-1-louis.scalbert@6wind.com/

v6 -> v7
  - Add patch 1: sync missed IFLA_BOND_BROADCAST_NEIGH in if_link
    UAPI header.
  - Add patch 2: add missed broadcast-neigh to YAML rt-link specs.
  - Patch 3 (was patch 1 in v6): add lacp-strict to YAML rt-link specs
    and IFLA_BOND_LACP_STRICT to if_link UAPI header.
  - Patch 6 (was patch 4 in v6): move bond_lacp_strict.sh in Makefile
    to preserve the sort order.
  Link: https://lore.kernel.org/netdev/20260520112539.798275-1-louis.scalbert@6wind.com/

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

Louis Scalbert (6):
  tools: missed broadcast_neigh if_link uapi header
  netlink: specs: rt-link: missed broadcast-neigh
  bonding: 3ad: add lacp_strict configuration knob
  bonding: 3ad: fix carrier when no usable slaves
  bonding: 3ad: fix mux port state on oper down
  selftests: bonding: add test for lacp_strict mode

 Documentation/netlink/specs/rt-link.yaml      |   6 +
 Documentation/networking/bonding.rst          |  23 ++
 drivers/net/bonding/bond_3ad.c                |  27 +-
 drivers/net/bonding/bond_main.c               |   1 +
 drivers/net/bonding/bond_netlink.c            |  16 +
 drivers/net/bonding/bond_options.c            |  27 ++
 include/net/bond_options.h                    |   1 +
 include/net/bonding.h                         |   1 +
 include/uapi/linux/if_link.h                  |   1 +
 tools/include/uapi/linux/if_link.h            |   2 +
 .../selftests/drivers/net/bonding/Makefile    |   1 +
 .../drivers/net/bonding/bond_lacp_strict.sh   | 347 ++++++++++++++++++
 12 files changed, 450 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_strict.sh

-- 
2.39.2


