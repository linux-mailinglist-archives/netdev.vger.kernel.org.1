Return-Path: <netdev+bounces-202121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3357AEC53B
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 07:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE023BCF7F
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 05:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7AC220F30;
	Sat, 28 Jun 2025 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKgaL/Df"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACBB21E087;
	Sat, 28 Jun 2025 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751089487; cv=none; b=p3+m0pSN+qdJIqFZ90KROPLam2GrQsOcSAJLT4hV7qpBa9OMDPz2rxBSrWsf0U6ryhEDxumIY65420lIP5FkWmwXoK/m6H7HDRfgxp0DG/elcFfqZgQuTgtRHufmB7QV0i4DoTKzRteTNVvcc3tmOVEz/LmgfiZe8EbIgi7HGZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751089487; c=relaxed/simple;
	bh=dpDcT0JGPHxnE3OT+sUCmMdAicGM1TQ8WJOYe+HFJCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qtGjYO2ADPaW8kHaIriTAXlAjVhQUMx35BSV1ZkVgKUPQ5Xtr2Y3qePKhLdGQoppmn0CNCjQ8Uv5/3AATYi3d6QEsh0m3oz/pGU5L7u7QpnZqs2e2UvMs8TQeBycPIlA7hdo2f+jCvPbTMF2l0LmWlTCsHH77p2nlPGiyJy1TyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKgaL/Df; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5137C4CEEE;
	Sat, 28 Jun 2025 05:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751089486;
	bh=dpDcT0JGPHxnE3OT+sUCmMdAicGM1TQ8WJOYe+HFJCc=;
	h=From:To:Cc:Subject:Date:From;
	b=OKgaL/DfcCOo9Mdys6/xM4PvMcJg5uNhsLK8Em3NX9BYIVrO50PVaVUq4nSkpNmgf
	 IbN8VfS2zqxDMebYiCUoeyC4kwWLCKx3MAIBL/trHaVOZh72ZIFfy324Hu2Bb0yCWV
	 D6BGpNsUUQiElqG8Q8LGtAOei8ESIMeenJ9dgMzdaWAy2R76QnSLyc/0kLRMPf4L9J
	 Hzh5puij23jq4SY4HwwhxsPVZhQEb7ak71eLoyO7AQeVtMePa7ClDw54FC1fGWmutL
	 jj+vfpXAuvDErjEgWXGPtvmyiRSCcYG6McR7AgSMYxlllQ1QP0Tr6ZqkKiZgH1Yu9y
	 aWiz36OusLR4A==
Received: by wens.tw (Postfix, from userid 1000)
	id 4048C5FD53; Sat, 28 Jun 2025 13:44:44 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH net 0/2] allwinner: a523: Rename emac0 to gmac0
Date: Sat, 28 Jun 2025 13:44:36 +0800
Message-Id: <20250628054438.2864220-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

Hi folks,

This small series aims to align the name of the first ethernet
controller found on the Allwinner A523 SoC family with the name
found in the datasheets. It renames the compatible string and
any other references from "emac0" to "gmac0".

When support of the hardware was introduced, the name chosen was
"EMAC", which followed previous generations. However the datasheets
use the name "GMAC" instead, likely because there is another "GMAC"
based on a newer DWMAC IP.

The first patch fixes the compatible string entry in the device tree
binding.

The second patch fixes all references in the existing device trees.

Since this was introduced in v6.16-rc1, I hope to land this for v6.16
as well.

There's a small conflict in patch one around the patch context with 

    dt-bindings: net: sun8i-emac: Add A100 EMAC compatible

that just landed in net-next today. I will leave this patch to the net
mainainers to merge to avoid making a bigger mess. Once that is landed
I will merge the second patch through the sunxi tree.


Thanks
ChenYu


Chen-Yu Tsai (2):
  dt-bindings: net: sun8i-emac: Rename A523 EMAC0 to GMAC0
  arm64: dts: allwinner: a523: Rename emac0 to gmac0

 .../devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml  | 2 +-
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi              | 6 +++---
 arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts     | 4 ++--
 arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts     | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.39.5


