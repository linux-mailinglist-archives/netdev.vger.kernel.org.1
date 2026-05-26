Return-Path: <netdev+bounces-291590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIxPCKxcFWp7UgcAu9opvQ
	(envelope-from <netdev+bounces-291590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:41:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C38A5D290E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A73E30237FE
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489A93CE4A7;
	Tue, 26 May 2026 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="GGoVDkn5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f97.google.com (mail-ed1-f97.google.com [209.85.208.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F0F3CC7DF
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779784869; cv=none; b=P7Wyli4+q19WNQ9/lqmSljXHWbmavHK1xnINBIcQ+zQnelPM6s0o5ozzbODy6HjubAxVrPzUh5XgvfDCXA/A/bfFxRaK1mSPaSwXGPLXTwTiJB6nD34qXvZhYcFDJbAKlawwXjogdbRLaP5HOVb7g/KJ+xtp8m1wJNOcpRjXGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779784869; c=relaxed/simple;
	bh=IgZ7j8GnG5oODVfa1hAUMgVIQMST7dOOLAOhz+f/tz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jo2g+He1aw4iNkkAdvYtrkDTcMS7t68FeKmOosZ2hJlp1s3lbRNKijQmmcdI3aMqDnChJx8ccLrtpvf+YCqHqpfnITLHtS2t6bDjv5kKEbU7Xf/m3Rj7h7cKz0OMlqf4XL5tzU9pRfFs/yHCoEge2EqKnJF1XfhKqvAKXVrSZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=GGoVDkn5; arc=none smtp.client-ip=209.85.208.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f97.google.com with SMTP id 4fb4d7f45d1cf-6804e24803bso4747401a12.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779784865; x=1780389665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R0CvXvlxmltT/5aitbnrUNMMRt+oD5AqR8jw/NUZMEI=;
        b=GGoVDkn5Pj1BdygYo06OEVtN91KBvkrc584vQ+eww8GEXVpZxw1Q5AkojEryFUiQ36
         iTURFBCUGUN37hhGkexiGjCY5nUsU1YZrU11MU5+R7BC+g91/OdXw//bdkFBJOd8+Yf9
         KFgy+oXl87zXW65wmSSYtFTpr+S7vGPGG45WvLGjA9BLX3ibBynaba81y8F7D8o8v0DC
         /fasIjUGgbN+D8mjitatkdg+zqMoU155VWQnXpMbY70gO41rPIpSbCw3EMBhUsgtwbY7
         X8alYFI6n/5xIATSUdGnr4Vc8g4RiO4IhN+f1kIid/9libuUaQ0biog5kd4+LWV5HiDQ
         Eraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779784865; x=1780389665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0CvXvlxmltT/5aitbnrUNMMRt+oD5AqR8jw/NUZMEI=;
        b=M6H22kC7qx6OQcqDqCikHDYUffuiQGY8C86olZIs6dSR+J7nW5xyhy2lPwJnBnyASM
         wPfOWXTcbfuTKHlC2oJCmU6wRrmc8BhtPDmjIUfO310uxSMewhw8m7cpL1tBUXRAlteg
         u/ZCXLMnXeR9tBtxewiPo94dWngbHXVVISQrkt/iHjM8QeZx2WlALeAmxlctFAkOkJJ8
         GK4DpgHZinT7Vp1QaRlEONJdbyuma/Ak816uS4Kpdrq9iHbYjRxre1lazCBvqObXspia
         2/WKy3F8jmN19R0X84HADxPGli2o4slExKUtW9z1T/oCBekiIDi2yfZUJu8OPDQVliQv
         g5dw==
X-Gm-Message-State: AOJu0YzhHY7u2Fb0XRdV96oGOFU3DN0YDnuqVa/Fs7i/ETZUil0XELlu
	SzKQdbQ3/0gfCHD/sSYtaEgKhkwM4/Jh+gnkkQlnU3GI2PYx/wl1sexFD25QkG3e7YgsGtAuo8a
	RztxfFTcVlYAO25NKEPSebuFThhrpFNRQMej6
X-Gm-Gg: Acq92OH+Np4ZahPK/hIZHZn0z48rV1vyBC8IhbBk4I13++IeDXazbif8ApPFA/QInRK
	cweVm3qprZGF5uUVyADcPKCKi5p9FB2Cmg8JtUScf6P43w19KsbAVCzXao1TwzUJm4IjXAL6Cf7
	3vYyuFZL6Pl2UywySwyWERJWrEZ6r2Rqg3ueXLKrcBpvxxXxBNMQP36IBbYAwiaariJriMRcBHQ
	J0sd/Pc0dhPDhzASCz3tr/dAjGz/aXMpxAIyo+1XxBkJEno6nqKWoBqhz9vUcGq/LWrlZwpYKIC
	XUzh1n35Fp0XK63eFSFBDIK8ts2KlGcmhElHZA2jYTmY/dR+jcUQEQ6HX6qSZK9gPtjE232yaJH
	Cg3Ja6QtrWPoYspVDcpmnBROY3IeOLzXcimDk7NTNNzetuvn018xL
X-Received: by 2002:a17:907:a647:b0:bda:24df:21b with SMTP id a640c23a62f3a-bdd251373e1mr720977366b.5.1779784865176;
        Tue, 26 May 2026 01:41:05 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-bddc2749a03sm68057366b.24.2026.05.26.01.41.05;
        Tue, 26 May 2026 01:41:05 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 050AF124AD;
	Tue, 26 May 2026 10:41:05 +0200 (CEST)
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
Subject: [PATCH net v7 0/6] bonding: 3ad: fix carrier state with no usable slaves
Date: Tue, 26 May 2026 10:40:42 +0200
Message-Id: <20260526084048.1696544-1-louis.scalbert@6wind.com>
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
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com,6wind.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-291590-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8C38A5D290E
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
 drivers/net/bonding/bond_3ad.c                |  22 +-
 drivers/net/bonding/bond_main.c               |   1 +
 drivers/net/bonding/bond_netlink.c            |  16 +
 drivers/net/bonding/bond_options.c            |  27 ++
 include/net/bond_options.h                    |   1 +
 include/net/bonding.h                         |   1 +
 include/uapi/linux/if_link.h                  |   1 +
 tools/include/uapi/linux/if_link.h            |   2 +
 .../selftests/drivers/net/bonding/Makefile    |   1 +
 .../drivers/net/bonding/bond_lacp_strict.sh   | 347 ++++++++++++++++++
 12 files changed, 447 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_strict.sh

-- 
2.39.2


