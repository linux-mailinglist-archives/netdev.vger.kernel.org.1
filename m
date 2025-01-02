Return-Path: <netdev+bounces-154799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3099FFCF3
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A333A3189
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925CC17B425;
	Thu,  2 Jan 2025 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ZtFBZR+Y"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7BA14F9F7;
	Thu,  2 Jan 2025 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839712; cv=none; b=B+y/a7rAzcmZQn+Gs+Kmuk5ifQDkU8V3J1yJwwO1zJHeqY/VZA9mYT6fWjo/QxnLLZfohJxrYSn/YYs62F6w7iQERQVZhiaQbG0wZ2kNaDz0DXBhwLtz2EiXhAm21E3a1AMruH8XMVN/5RcXr5MqUIJaKpAEVjYtXGtrk6DBpDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839712; c=relaxed/simple;
	bh=5ufCv98DSwRxBKQWU4pO46MLE+ZaGHMSy3YSwB5ikPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZPphDXQlwpdw8ZctAEgmJddg1+cJGuk5hMV0coWmamb4VNNJKIELe92A6Xfxcbn30iGbpxKX3Hp4igl3UsUndHRUS2jn+cQDZlhso90l/aHkmShrCLra4LfeR5R0zjN90+JoQQdJLztLF0iJngLUnGpUvnQ7sArmgExmZUT75ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ZtFBZR+Y; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=AQObr0bA1IYS/3zsfu/8IsXvh0M/fYclu9jnYLuEaMQ=; b=ZtFBZR+YXDXmBFBD
	FWyXObzJihdONc70lOgEP+kh+8T2Jx/7aadhZuPBc0ciOqzfRj1orVMKO4KPJm1zIM3Ywx/G9N/rF
	zZxjPOizPAPANTaT7appG1ztmZThGNAHeC+ddOi+kUsAGreLMatf8oBNIFMjSFpYTt0WJX+19POwl
	SDcE/s7jG3LNnrGLrVATnIvZprorkR5rcBYmG6nB4X+TjxL1Q0K8VbQvo22jhI0AyWQiIs8YWZuRs
	rI/zuR72Z9rTHlvR3krI6w6qfY8ucWqHBNaJsJTgms+LPJXQoI4DvOs3vZda4YhmvwWHgXXB5Sljk
	ppJWXE0ogekOkugNGw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tTPCZ-007u04-2l;
	Thu, 02 Jan 2025 17:41:43 +0000
From: linux@treblig.org
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next 0/3] igc deadcoding
Date: Thu,  2 Jan 2025 17:41:39 +0000
Message-ID: <20250102174142.200700-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This set removes some functions that are entirely unused
and have been since ~2018.

Build tested.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
(Repost now netdev is open)

Dr. David Alan Gilbert (3):
  igc: Remove unused igc_acquire/release_nvm
  igc: Remove unused igc_read/write_pci_cfg wrappers
  igc: Remove unused igc_read/write_pcie_cap_reg

 drivers/net/ethernet/intel/igc/igc_hw.h   |  5 ---
 drivers/net/ethernet/intel/igc/igc_main.c | 39 ------------------
 drivers/net/ethernet/intel/igc/igc_nvm.c  | 50 -----------------------
 drivers/net/ethernet/intel/igc/igc_nvm.h  |  2 -
 4 files changed, 96 deletions(-)

-- 
2.47.1


