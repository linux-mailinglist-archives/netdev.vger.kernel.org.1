Return-Path: <netdev+bounces-182006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F50A87511
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 02:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744733A97C9
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 00:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5981F3398B;
	Mon, 14 Apr 2025 00:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="h0ddCXeC"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF88F66;
	Mon, 14 Apr 2025 00:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744591987; cv=none; b=chdxy4tgZ219i0Lyf6MPxQ15nNq4EqhlUGPHYiie7KU1VcodId/Y0OFw8MrtCtYbGxZPzpDONoCm3dVGr5qRaMmy8iW+ZI3Uoz5jd7ZfUmHcK6ChK5lpDRo1wdIqRubfE2F+zLylz55Af24ILBf2y5VUwVAqLNdBO6446Ge9B5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744591987; c=relaxed/simple;
	bh=N/t4wXiYwuP4mcMzZ2f66VL9skmU+uidLosV086W/4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Za1k9CQNddYhjjMjoECz6ELLFku9pxIl1XZ6/wu8XpHyffCTn0twrRztlSkgxMXlFjCcjhjaCRmDzD269Orpjodc8F4y6BhZpziGaR2BBp3jo6UcwRyco3WgWFpqPoAugwYYJoXiXNKhd1qqI8LashbJkvp8CvjrPwy1x023cZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=h0ddCXeC; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=83QHPUSOcr9nZsb9LHZ0Z/lAAHhntM1ANX1pFaut9pI=; b=h0ddCXeCA4Y7IZQ0
	sXlZW0z2OhzrIL7DznBttYjwfoIyRL57n+4gmw5d+0P25bpXie0w0EuK2gUgibDWczQF8iywAG5j9
	7sMSAsMYy6Q9JreAOtVA4yP+JDebU4jauhCsjLWn0wr7AYDXfbiRbZ1QCAECQCjvqgI+hPsYMkAtZ
	IbJOHK2yOSBhE+JXNk9KpY+AlvuYlq97QJ5tR5VhkNVQemE/DzrLoeRHKGemQpBH5/2AWwquRg9lj
	2EuRWk3uyaIc1urG+0ZqdvMIaILciNjS7anrAMjHClL4VzfNVQ+GhhMtQ/GkUrMmzsC2/F9Lc2VRc
	BTbplklgWoH0MTCRxA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1u4848-00B6OC-2A;
	Mon, 14 Apr 2025 00:52:48 +0000
From: linux@treblig.org
To: manishc@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next 0/5] qed deadcoding
Date: Mon, 14 Apr 2025 01:52:42 +0100
Message-ID: <20250414005247.341243-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This is a set of deadcode removals for the qed ethernet
device.  I've tried to avoid removing anything that
are trivial firmware wrappers.

  One odd one I've not removed is qed_bw_update(),
it doesn't seem to be called but looks like the only
caller of the bw_update(..) method which qedf does
define.  Perhaps qed_bw_update is supposed to be called
somewhere?

Dave
Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (5):
  qed: Remove unused qed_memset_*ctx functions
  qed: Remove unused qed_calc_*_ctx_validation functions
  qed: Remove unused qed_ptt_invalidate
  qed: Remove unused qed_print_mcp_trace_*
  qed: Remove unused qed_db_recovery_dp

 drivers/net/ethernet/qlogic/qed/qed.h         |   1 -
 drivers/net/ethernet/qlogic/qed/qed_dbg_hsi.h |  31 ----
 drivers/net/ethernet/qlogic/qed/qed_debug.c   |  25 ----
 drivers/net/ethernet/qlogic/qed/qed_dev.c     |  19 ---
 drivers/net/ethernet/qlogic/qed/qed_hsi.h     |  52 -------
 drivers/net/ethernet/qlogic/qed/qed_hw.c      |  11 --
 drivers/net/ethernet/qlogic/qed/qed_hw.h      |   9 --
 .../ethernet/qlogic/qed/qed_init_fw_funcs.c   | 138 ------------------
 8 files changed, 286 deletions(-)

-- 
2.49.0


