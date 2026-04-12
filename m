Return-Path: <netdev+bounces-277738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAx5CWoo22m49wgAu9opvQ
	(envelope-from <netdev+bounces-277738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 07:06:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FB03E2C24
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 07:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D99E13009B24
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 05:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC2336494F;
	Sun, 12 Apr 2026 05:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D32v8Is7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D8364040;
	Sun, 12 Apr 2026 05:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775970407; cv=none; b=HpYJlAI7MnVr5qRbObjw9TSw+jeYFeDwCfEejCAfYPIogj/sOmJo8UneM26h1LB4lj53iIZ5oxSiU8Ix9IIB4TQvI6p/DcusYMWwQEm716CupNee+ZLU0F+QIJu+5t7Af3cAfwTtKwyB9RReGjcbda5IVPcOQoWChbbiK4TiNyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775970407; c=relaxed/simple;
	bh=8Y2cZHnHRd+OEA7oYKlo8NGbDuhH+knxvBJlguRu5bQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HfPyX9QXmu2mVplSctBe3v5oO5fRK6csaBL8gYS1wyCFCOJgH/y6plUuRDP0nEDSPylHBuNIlOvY75wDWHP5vOQzW2V0+soQhNy84OBlYotP+WsDPQjACTnYD+WKfYdUc+gNPNPJ3k+0XDxHI4UmOjaHrqvz4543Xzzz1g7iCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D32v8Is7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4B29C19424;
	Sun, 12 Apr 2026 05:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775970406;
	bh=8Y2cZHnHRd+OEA7oYKlo8NGbDuhH+knxvBJlguRu5bQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=D32v8Is7Yr5OIYW8ZiMTXMPrc9AP8vrG+8GU4P9S+2LCRo6oQtcTSn17z8tXCf6On
	 irLWyoSqH4YOajgxHIxT07Ohj+07jEqVK+HufwWyDCvW+PDKu/XRqve2UD9NPbw0d4
	 fojNs+ku/HeUIV0ftZKVXY9rb26NcF6tl+2GzdAnLe4UctdIP8AdkY6xJb8bWk1XDy
	 Jmd6kk+kW8kRcG2oZrK3W28xPMGBeyPjImpuU/d1T1sPzXPBhKB2GvRvwyPkNX+ZN5
	 1NY8B0UUDWNyo41a0N98x8+sMwQff2TR6ZFaGlfbZuZcguWiX8jfXG2Y5qTRztl5ld
	 jKzNdenW5Y8Hg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CB9F3ED5A;
	Sun, 12 Apr 2026 05:06:46 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Subject: [PATCH net-next v4 00/10] enic: SR-IOV V2 admin channel and MBOX
 protocol
Date: Sat, 11 Apr 2026 22:06:26 -0700
Message-Id: <20260411-enic-sriov-v2-admin-channel-v2-v4-0-f052326c2a57@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFIo22kC/5XNwWoCMRAG4FeRnJ2SzaQx21PfQzyEyVgHNJFkC
 Suy725cepBepMd//uH776pyEa7qa3NXhZtUyakHu90oOoX0wyCxZ2W0cdpqC5yEoBbJDZqBEC+
 S4PmZ+Pw8kA4BefTeI6qOXAsfZV4H9irxBInnSR16c5I65XJbl9uw9r8j7t1IG0CDN0R259CFn
 f8mqZQ/KF9WuplXzr/lTOei/owRncFjxL8c/o/Dzg3RjuMYNBLTK7csywPkCtecdAEAAA==
X-Change-ID: 20260404-enic-sriov-v2-admin-channel-v2-c0aa3e988833
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com, 
 Satish Kharat <satishkh@cisco.com>, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775970405; l=3459;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=8Y2cZHnHRd+OEA7oYKlo8NGbDuhH+knxvBJlguRu5bQ=;
 b=/Ckf+/pjk3IPrswfG34RP05j3N9Jt6ehbbmOVftxYvCl4g9toXU4nTpc4/oVV0Lnu+8aGUlUG
 60RYVHdmOGTA/KMXrga2XyoVsg+U2xx3mL9BFWw3PkKtmv2h7CGRppn
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277738-lists,netdev=lfdr.de,satishkh.cisco.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:replyto,cisco.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78FB03E2C24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds the admin channel infrastructure and mailbox (MBOX)
protocol needed for V2 SR-IOV support in the enic driver.

The V2 SR-IOV design uses a direct PF-VF communication channel built on
dedicated WQ/RQ/CQ hardware resources and an MSI-X interrupt.

Firmware capability and admin channel infrastructure (patches 1-4):
  - Probe-time firmware feature check for V2 SR-IOV support
  - Admin channel open/close, RQ buffer management, CQ service
    with MSI-X interrupt and NAPI polling

MBOX protocol and VF enable (patches 5-10):
  - MBOX message types, core send/receive, PF and VF handlers
  - V2 SR-IOV enable wiring with admin channel setup
  - V2 VF probe with admin channel and PF registration

This series depends on "enic: SR-IOV V2 resource discovery and VF
type detection" (Series 1), which has been accepted.

Depends-on: 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
Changes in v4:
- Fix reverse xmas tree variable ordering (patches 1, 6)
- Use kzalloc_obj instead of kzalloc with sizeof (patch 9)
- Add NULL check for pp allocation in V1 SR-IOV disable path (patch 9)
- Link to v3: https://lore.kernel.org/r/20260408-enic-sriov-v2-admin-channel-v2-v3-0-1d4999a03cec@cisco.com

Changes in v3:
- Use early-return pattern in enic_sriov_detect_vf_type to reduce
  nesting (patch 1) [Breno Leitao]
- Link to v2: https://lore.kernel.org/r/20260408-enic-sriov-v2-admin-channel-v2-v2-0-d05dd3623fd3@cisco.com

Changes in v2:
- Fix lines exceeding 80 columns (patches 4, 6, 7, 8)
- Add __maybe_unused to enic_sriov_configure and enic_sriov_v2_enable;
  .sriov_configure wiring deferred to a later series after devcmd
  hardening is in place (patch 9)
- Guard probe-time auto-enable to skip V2 VFs (patch 9)
- Link to v1: https://lore.kernel.org/r/20260406-enic-sriov-v2-admin-channel-v2-v1-0-82cc47636a78@cisco.com

---
Satish Kharat (10):
      enic: verify firmware supports V2 SR-IOV at probe time
      enic: add admin channel open and close for SR-IOV
      enic: add admin RQ buffer management
      enic: add admin CQ service with MSI-X interrupt and NAPI polling
      enic: define MBOX message types and header structures
      enic: add MBOX core send and receive for admin channel
      enic: add MBOX PF handlers for VF register and capability
      enic: add MBOX VF handlers for capability, register and link state
      enic: wire V2 SR-IOV enable with admin channel and MBOX
      enic: add V2 VF probe with admin channel and PF registration

 drivers/net/ethernet/cisco/enic/Makefile      |   3 +-
 drivers/net/ethernet/cisco/enic/enic.h        |  29 +-
 drivers/net/ethernet/cisco/enic/enic_admin.c  | 511 ++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_admin.h  |  27 ++
 drivers/net/ethernet/cisco/enic/enic_main.c   | 218 +++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c   | 546 ++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_mbox.h   |  87 ++++
 drivers/net/ethernet/cisco/enic/enic_res.c    |   4 +-
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  11 +
 drivers/net/ethernet/cisco/enic/vnic_enet.h   |   4 +-
 10 files changed, 1425 insertions(+), 15 deletions(-)
---
base-commit: 3e6ef4fb822c971b464d44910a1561b4e7f9efa7
change-id: 20260404-enic-sriov-v2-admin-channel-v2-c0aa3e988833

Best regards,
--  
Satish Kharat <satishkh@cisco.com>



