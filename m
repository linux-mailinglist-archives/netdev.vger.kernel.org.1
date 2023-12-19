Return-Path: <netdev+bounces-59001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BE3818E97
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 18:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568491F2214C
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 17:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE623B783;
	Tue, 19 Dec 2023 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="Y8Zdcafj"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5BD3A8EE
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2023121917462014949821e8bce9a3e2
        for <netdev@vger.kernel.org>;
        Tue, 19 Dec 2023 18:46:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ZqN2tJGSh8krS2qjM3LQQyItJGkgLnuWJvYSIGQ1Zxc=;
 b=Y8ZdcafjRoR8ojYovKtGRigSGkDNSZ8MPtAPwctxjXBTGVhx1B5s6S6UObeQXrXX0WFx8z
 1NuYhuqRAdL/nz9HsiSPBTne7zF1MDwP93xoMk8pejvnUGJ442tiTKwI+EZk0JlKPtRND89E
 Xw9O2CMqxfolOXnz8oD8qPDLRFbNU=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	dan.carpenter@linaro.org,
	grygorii.strashko@ti.com,
	jacob.e.keller@intel.com,
	robh@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>
Subject: [RFC PATCH net-next 0/8] Add support for ICSSG-based Ethernet on SR1.0 devices
Date: Tue, 19 Dec 2023 17:45:38 +0000
Message-ID: <20231219174548.3481-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Hello,

This series extends the current ICSSG-based Ethernet driver to support
Silicon Revision 1.0 devices.

Notable differences between the Silicon Revisions are that there is
no TX core in SR1.0 with this being handled by the firmware, requiring
extra DMA channels to communicate commands to the firmware (with the
firmware being different as well) and in the packet classifier.

The motivation behind it is that a significant number of Siemens
devices containing SR1.0 silicon have been deployed in the field
and need to be supported and updated to newer kernel versions
without losing functionality.

This series is based on TI's 5.10 SDK [1].

[1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y

Diogo Ivo (7):
  net: ti: icssg-config: add SR1.0-specific configuration bits
  net: ti: icssg-prueth: add SR1.0-specific configuration bits
  net: ti: icssg-classifier: Add support for SR1.0
  net: ti: icssg-config: Add SR1.0 configuration functions
  net: ti: icssg-ethtool: Adjust channel count for SR1.0
  net: ti: iccsg-prueth: Add necessary functions for SR1.0 support
  net: ti: icssg-prueth: Wire up support for SR1.0

Jan Kiszka (1):
  dt-bindings: net: Add support for AM65x SR1.0 in ICSSG

 .../bindings/net/ti,icssg-prueth.yaml         |  62 +-
 .../net/ethernet/ti/icssg/icssg_classifier.c  | 113 +++-
 drivers/net/ethernet/ti/icssg/icssg_config.c  |  90 ++-
 drivers/net/ethernet/ti/icssg/icssg_config.h  |  61 +-
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  10 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 556 ++++++++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  21 +-
 7 files changed, 812 insertions(+), 101 deletions(-)

-- 
2.43.0


