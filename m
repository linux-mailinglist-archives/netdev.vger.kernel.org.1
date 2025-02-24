Return-Path: <netdev+bounces-169024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C7BA4221A
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B4B67A70A8
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E58253B6D;
	Mon, 24 Feb 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDnvfa0d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E27252904;
	Mon, 24 Feb 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405213; cv=none; b=s06+8m7pgPP2oFM/rl4vapj8epRyvmOFsg/ukQj9e3F61cevSflsPy5LWLNASopULVGuPhnPPoGgMX65S3nscCj8qwNbcTOJlL+x4+8YHah8oczHQ9IhVbhMRDNGciPqOJadB8xNY0qMf/DtBOjTrE3CAH+g2ufZgr6rF0FaFeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405213; c=relaxed/simple;
	bh=LKpViahJnjb57e2QKzJqBEkvH0fvBIPmBteCaKsB344=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uEKmsf0tnu3LzM682sAhd49d6CV36lvh3jr+SglHlCM3P5BwRsw3pp4AvZb0eN5lPq1gbuPohhGkVB8ZmCCdbmM5sDCVm1AOGxUjR6EWcK0Ai60CuKXFcCx3ecn49jhGg8ifU961bstUc4mYryL3h5SpvSth1fT5p8gO9zNB34Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDnvfa0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDD9C4CEE6;
	Mon, 24 Feb 2025 13:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405213;
	bh=LKpViahJnjb57e2QKzJqBEkvH0fvBIPmBteCaKsB344=;
	h=From:To:Cc:Subject:Date:From;
	b=QDnvfa0dRuDgLw+jLcSlJS/wejROZfs2DvSB4M/2sX6tToPXffRfHA8/IXeIjjNBI
	 GOqY6NP3pb37ZcTkqmxG8g9Z+2qWEyRmKpPXcR24PSDE1wB0UaDfY9rVPO+9/TybTC
	 fvuAtO4+AM3vcT36ax6N4OZeBBvSLM0Evo0TST0Utvjx0DDllyeeiyaY5Rsk1VXDXw
	 uhXMaImML52IinRoWicgfatHtOpiTxlLolieiKfmLVVO5yuDlpQ0XIhiJPd5YiyWLd
	 PUcZWI0LpEru1LRTwLcUWFW0ijMR3k/6Yd8UmD52NSREuGH9GaYuCzMVIGubULoJHP
	 mWE1L4A4VQNOw==
From: Philipp Stanner <phasta@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Philipp Stanner <pstanner@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Qing Zhang <zhangqing@loongson.cn>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH net-next v3 0/4] stmmac: Several PCI-related improvements
Date: Mon, 24 Feb 2025 14:53:18 +0100
Message-ID: <20250224135321.36603-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
  - Several formatting nits (Paolo)
  - Split up patch into a patch series (Yanteng)

Philipp Stanner (4):
  stmmac: loongson: Pass correct arg to PCI function
  stmmac: loongson: Remove surplus loop
  stmmac: Remove pcim_* functions for driver detach
  stmmac: Replace deprecated PCI functions

 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 31 ++++++-------------
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 24 ++++----------
 2 files changed, 15 insertions(+), 40 deletions(-)

-- 
2.48.1


