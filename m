Return-Path: <netdev+bounces-238492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71A3C59B14
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 20:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250A53BDBD7
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D4C31A06C;
	Thu, 13 Nov 2025 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tB3voCBX"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B0A212574
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061239; cv=none; b=BFkR/e/sKbqFtKojrSVv9WyeP/+VCRr8H9OfPSSpqdr0vqQ+tFvfH08sKffSYZs4VD9RE30TPxr/Acj57CO/CzHfcdodmd+0DYuArl072esRrSDkdCJYAYQonwrXKzX+iN5DwqXfLsP4Qo15qSMQ6nn8cW4jVqrkpnF+dxgEmts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061239; c=relaxed/simple;
	bh=DUNvaVI3QHwsobRb18SkJSAMmtH9JWMzkGkuBkOcUdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nUuhD9jaJuws/OBe/RegHaXfSjk49RfM7y2eQ2c6j9QuISB01J2BU6j0J5cvo0nDaef1o3HpiOXabIPpILsU5vT9kHDfAJzsBrEe5Tk8xA1th6g/uT4Vit4MFHY6Pu6qCBvEVpa7NVDlRVtRLJv9aa0xpSpwIHuhhLed1gl8qLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tB3voCBX; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763061234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DVXMEspK3sVPGc2hxafKHd0CDPjmXDBUNTyhK9hQH+w=;
	b=tB3voCBXAacKMVKnfikstfQeXC3wlpP5/2JVQjNrwXv63sJmsXSr2NnNNhBwisj+s30547
	Pm8ODjqbwK6GyRsM8QTtz31Vx0r0PcdngBQcmNmDAXcH2oWmIYtXEUQIRpqzVBexDz+vTi
	qyS4vVBIju7XiP+gxxIgroPgLcvcAm8=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 0/2] convert drivers to use ndo_hwtstamp callbacks part 4
Date: Thu, 13 Nov 2025 19:13:23 +0000
Message-ID: <20251113191325.3929680-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patchset is a subset of part 3 patchset to convert bnx2x and qede
drviers to use ndo callbacks instead ioctl to configure and report time
stamping. These drivers implemented only SIOCSHWTSTAMP command, but
converted to also provide configuration back to users. Some logic is
changed to avoid reporting configuration which is not in sync with the
HW in case of error happened.

v3 -> v4:
- improve tx_type checks to the slightly more resilient variant
- restore netif_running() check in qede driver
v2 -> v3:
- keep bnx2x driver's logic as is. Improvements will be sent as
  follow-ups
v1 -> v2:
- remove unused variable in qede patch

Vadim Fedorenko (2):
  bnx2x: convert to use ndo_hwtstamp callbacks
  qede: convert to use ndo_hwtstamp callbacks

 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 67 ++++++++++------
 drivers/net/ethernet/qlogic/qede/qede_main.c  | 22 +-----
 drivers/net/ethernet/qlogic/qede/qede_ptp.c   | 76 ++++++++++++-------
 drivers/net/ethernet/qlogic/qede/qede_ptp.h   |  6 +-
 4 files changed, 98 insertions(+), 73 deletions(-)

-- 
2.47.3


