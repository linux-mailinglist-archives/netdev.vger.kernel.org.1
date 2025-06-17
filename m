Return-Path: <netdev+bounces-198388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AA2ADBECE
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4637A1888989
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEF518DB35;
	Tue, 17 Jun 2025 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIk56aMX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66882CCC5
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124936; cv=none; b=S4o8yETeGEEIdAP/03m/IWYECYjce5XmbVi1HS+smrZtTJD1lxgkcMx9ODCRjWZjmieeB8g4e0ENDJD7Jz8hW7WFCYKdSp+KsrcBvW+4ptt3O/7o1djppAZUFk5qXsXmM0FCt37ejpShJwTevhMkg+BpFScAvOA39iwrX1afXFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124936; c=relaxed/simple;
	bh=Ni2cLXFvTQiRrcWQZnXG0E5HnXPSm/0A9Q7Cdj8T7o4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LmS/83Vs7mOrGevi6VJbhl6ESRTjY/2+i35jzLEIFrS4Qeb9fSvJc0Di5KkScXd42vug6oRF9pCCc7ZriWMoluABajvHvy/0cyH4ut8k8xf3kgwWyPDyBJhmvsiCbJKe+60g0+zASV1Jixt2r2ZjU85vVPc3jkWerYmNZNU1zXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIk56aMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03A5C4CEEA;
	Tue, 17 Jun 2025 01:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124936;
	bh=Ni2cLXFvTQiRrcWQZnXG0E5HnXPSm/0A9Q7Cdj8T7o4=;
	h=From:To:Cc:Subject:Date:From;
	b=MIk56aMXoLnznKTL+nnFESQ6XQOTBOKmKKwpGSn8EdIs2+yF9fTtJw0CYXPxY5Dji
	 zCff/wZPTE8sBwJQhfGLiE8LZtHXTOCW6/CiZ1XXz/FeB7Dfj3XZ5Wf9UXFcet2x+S
	 GYFLTtbFY6C2Daf+4mn88uqnXeuc72tBltlr/CKNSjE9D96W9nGZk3PMn71EK7h+ta
	 ldVhXbcU71VYHSaOGG7K7q0GAmp7/H+geRp5FIaNCw/EEAvNvKolBvt3I5hEnjwRGF
	 GTXpoD+Xr2QZXyIH53scjm/bzrnQThnWzBSfN1AMPffMxmkryA2KqUj9Wph3Mvmb5t
	 to0WmVDYKiybA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	madalin.bucur@nxp.com,
	ioana.ciornei@nxp.com,
	marcin.s.wojtas@gmail.com,
	bh74.an@samsung.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/5] eth: migrate more drivers to new RXFH callbacks
Date: Mon, 16 Jun 2025 18:48:43 -0700
Message-ID: <20250617014848.436741-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate a batch of drivers to the recently added dedicated
.get_rxfh_fields and .set_rxfh_fields ethtool callbacks.

Jakub Kicinski (5):
  eth: niu: migrate to new RXFH callbacks
  eth: mvpp2: migrate to new RXFH callbacks
  eth: dpaa: migrate to new RXFH callbacks
  eth: dpaa2: migrate to new RXFH callbacks
  eth: sxgbe: migrate to new RXFH callbacks

 .../net/ethernet/marvell/mvpp2/mvpp2_cls.h    |  6 ++-
 .../ethernet/freescale/dpaa/dpaa_ethtool.c    | 44 +++---------------
 .../ethernet/freescale/dpaa2/dpaa2-ethtool.c  | 36 ++++++++++-----
 .../net/ethernet/marvell/mvpp2/mvpp2_cls.c    |  6 ++-
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 31 ++++++++++---
 .../ethernet/samsung/sxgbe/sxgbe_ethtool.c    | 45 +++----------------
 drivers/net/ethernet/sun/niu.c                | 17 +++----
 7 files changed, 80 insertions(+), 105 deletions(-)

-- 
2.49.0


