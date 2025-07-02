Return-Path: <netdev+bounces-203501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A7CAF62B1
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 21:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327DF4E5446
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C7C2BFC8F;
	Wed,  2 Jul 2025 19:32:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E6B221FC7;
	Wed,  2 Jul 2025 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751484756; cv=none; b=epLTHd2bSp7KocRwYLJiVy0wnUthTuyN63xGGTI+UqkYUL2/NafFKpCu6E8WGbzLcezbdLmURJLMCDFzpHw+q5ZpUVsk0fUSGngiOpeX6h70bDf7H0TqIa5WnT5/Wce++GBPDm3azpCknT47os0txBV8DhHmPn1OfxGcbYZdrDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751484756; c=relaxed/simple;
	bh=S3tlkmGLslmWoPL3TROuxDeeglOQMYTuEQbmKPjlm+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OT78Otg8bIQ1zQr3MqOycaoos1ZdwdLA/ftOhkewqOLm28rq/vkvS+kV7gsFdF4T5+dBzNpNyiidbSdlr5TVCsz7d6Q5Izg5TMgstM2TVVAbUTzNWIcYcz7DnsdqwROyeAVI8RRaXlBSOHVsBu8MHKo7223lb68WnFqTbBtQTvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1uX32X-00080G-Pq; Wed, 02 Jul 2025 19:22:41 +0000
From: Lee Trager <lee@trager.us>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Su Hui <suhui@nfschina.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Lee Trager <lee@trager.us>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next 0/6] eth: fbnic: Add firmware logging support
Date: Wed,  2 Jul 2025 12:12:06 -0700
Message-ID: <20250702192207.697368-1-lee@trager.us>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmware running on fbnic generates device logs. These logs contain useful
information about the device which may or may not be related to the host.
Logs are stored in a ring buffer and accessible through DebugFS.

Lee Trager (6):
  eth: fbnic: Fix incorrect minimum firmware version
  eth: fbnic: Use FIELD_PREP to generate minimum firmware version
  eth: fbnic: Create ring buffer for firmware logs
  eth: fbnic: Add mailbox support for firmware logs
  eth: fbnic: Enable firmware logging
  eth: fbnic: Create fw_log file in DebugFS

 drivers/net/ethernet/meta/fbnic/Makefile      |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  27 ++-
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |  29 +++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 179 +++++++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  36 ++++
 .../net/ethernet/meta/fbnic/fbnic_fw_log.c    | 123 ++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_fw_log.h    |  45 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  21 ++
 9 files changed, 451 insertions(+), 13 deletions(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h

--
2.47.1

