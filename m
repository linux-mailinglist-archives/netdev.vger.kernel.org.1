Return-Path: <netdev+bounces-140938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7107C9B8BC5
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 08:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E871C20DF6
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 07:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D939E155303;
	Fri,  1 Nov 2024 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eQnBa29f"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934F31534FB;
	Fri,  1 Nov 2024 07:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445012; cv=none; b=e7KwVjmbe7Z/0XP/TTesRRpAT5s0R+izi7/zEKP5OmgPbtJbyQnkxA9sAGP34bCnY0Nc15koSV8UlYszdQ6tq7LNJLiAIYHBabb4r6ngHj6/CgOPOsuoUSpd8yhHSLnVGI2JWGtqqvDIgIKBF/5CLrRGJCvW+MxvHP7/0maH68I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445012; c=relaxed/simple;
	bh=8SBtAFIZv6QdmDpsSm24E8xxTeonWxMbs9IQUu8QsfA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=kg0MaqJyaPrHEEnFMuiW97sBy7a0SQKHt/4/p+aKJ8N0WdmXZ4C8h5hXVe/ucyRZ1O+uOh2hA8o07yQKghJ4N9eBf3zE3EE3Zp5WVXKmu2MKXMdxoSux8TRIuFC465pYxqnCcZSlZF8MmuoGHxAtXOC6GuapEtaY1tGYFFU3UHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eQnBa29f; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730445010; x=1761981010;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=8SBtAFIZv6QdmDpsSm24E8xxTeonWxMbs9IQUu8QsfA=;
  b=eQnBa29ffZbscWhz46GlTzr7lAtpVsr57QIgO69jWKrnVpYOwycUF4eS
   zT7Jp2dE6aeeV3qtu3/cx4gbUWIHic5Q1R1vd6BWGiP/8dB2tYGEt4vJD
   /f4C/DguuG1tRDhC1HFsjNegSQ66XuwtyzVCfaCMphCQLbytTo2b6Y6XU
   I0cwGL2KpZS9GheEOljZ/kuKzSsNv+h/IieOkN+XyOdmWcmNZPCt+dgDV
   9rTlxcmewBpDOKynFg5W/cWBaKTXLmH+IaW1Bgs/XQCeRUVADFvYawhbj
   eZQYq4CHu6M7uIMfMJ1BrPw288cnmkLHgDCus04kukFEWzuBuspehd4nE
   w==;
X-CSE-ConnectionGUID: NPrwf/hMSSa00KPy6thoyw==
X-CSE-MsgGUID: ROduA6SrQSevCJ88YzhLHQ==
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="201180317"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Nov 2024 00:10:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Nov 2024 00:09:52 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 1 Nov 2024 00:09:49 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next 0/6] net: lan969x: add VCAP functionality
Date: Fri, 1 Nov 2024 08:09:06 +0100
Message-ID: <20241101-sparx5-lan969x-switch-driver-3-v1-0-3c76f22f4bfa@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJJ+JGcC/x2NywrCMBAAf6Xs2YU8ajX+inhI09Us6Fo2pQZK/
 93ocRiY2aCQMhW4dBsorVz4LQ3soYOUozwIeWoMzrjeGm+xzFHrEZ9RwhAqlg8vKeOkvJKix0D
 u1A90Ho330CKz0p3rf3AFoQWF6gK3ZsZYCEeNkvJv8IossO9f2Doum5EAAAA=
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<jacob.e.keller@intel.com>, <christophe.jaillet@wanadoo.fr>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

== Description:

This series is the third of a multi-part series, that prepares and adds
support for the new lan969x switch driver.

The upstreaming efforts is split into multiple series (might change a
bit as we go along):

        1) Prepare the Sparx5 driver for lan969x (merged)

        2) Add support for lan969x (same basic features as Sparx5
           provides excl. FDMA and VCAP, merged).

    --> 3) Add lan969x VCAP functionality.

        4) Add RGMII and FDMA functionality.

== VCAP support:

The Versatile Content-Aware Processor (VCAP) is a content-aware packet
processor that allows wirespeed packet inspection for rich
implementation of, for example, advanced VLAN and QoS classification and
manipulations, IP source guarding, longest prefix matching for Layer-3
routing, and security features for wireline and wireless applications.
This is all achieved by programming rules into the VCAP.

When a VCAP is enabled, every frame passing through the switch is
analyzed and multiple keys are created based on the contents of the
frame. The frame is examined to determine the frame type (for example,
IPv4 TCP frame), so that the frame information is extracted according to
the frame type, port-specific configuration, and classification results
from the basic classification. Keys are applied to the VCAP and when
there is a match between a key and a rule in the VCAP, the rule is then
applied to the frame from which the key was extracted.

After this series is applied, the lan969x driver will support the same
VCAP functionality as Sparx5.

== Patch breakdown:

Patch #1 exposes some VCAP symbols for lan969x.

Patch #2 replaces VCAP uses of SPX5_PORTS with n_ports from the match
data.

Patch #3 adds new VCAP constants to match data

Patch #4 removes the is_sparx5() check to now initialize the VCAP API on
lan969x.

Patch #5 adds the auto-generated VCAP data for lan969x.

Patch #6 adds the VCAP configuration data for lan969x.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Daniel Machon (6):
      net: sparx5: expose some sparx5 VCAP symbols
      net: sparx5: replace SPX5_PORTS with n_ports
      net: sparx5: add new VCAP constants to match data
      net: sparx5: execute sparx5_vcap_init() on lan969x
      net: lan969x: add autogenerated VCAP information
      net: lan969x: add VCAP configuration data

 drivers/net/ethernet/microchip/lan969x/Makefile    |    3 +-
 drivers/net/ethernet/microchip/lan969x/lan969x.c   |    3 +
 drivers/net/ethernet/microchip/lan969x/lan969x.h   |    8 +
 .../microchip/lan969x/lan969x_vcap_ag_api.c        | 3843 ++++++++++++++++++++
 .../ethernet/microchip/lan969x/lan969x_vcap_impl.c |   85 +
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |   15 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |    3 +
 .../ethernet/microchip/sparx5/sparx5_vcap_ag_api.h |    2 +
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.c   |   48 +-
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.h   |   21 +
 10 files changed, 3995 insertions(+), 36 deletions(-)
---
base-commit: 157a4881225bd0af5444aab9510e7b6da28f2469
change-id: 20241031-sparx5-lan969x-switch-driver-3-9e2746e8b033

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


