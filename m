Return-Path: <netdev+bounces-134985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0315E99BBB6
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 22:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C761C20C6E
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 20:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6535F14D2A0;
	Sun, 13 Oct 2024 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Yr5U/Gee"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0470149E13;
	Sun, 13 Oct 2024 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728851927; cv=none; b=bVtBe2+FL3Z/VJt1/odIo8EY9Ey/zOuAOB6k7uk+IzPJbB1bQ9le+WZyxmX6ypKSBGn8SJKMGowWR4mPcawp1JxtlWlDfJoRSfr+YSOfFBcgnWOgQwSqJuVbqmefTAK6Ui8KYAEJ8vk5mFD6hHyB2NYj0QdomZpK+dTzdu/vBFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728851927; c=relaxed/simple;
	bh=Fj0J825jzpGUhzbd+jhdu/I+6ynYvltWXDjamahmznw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3AqrK9WvZJlPgqroOV562Kg7ntTmjE1tGQ8ik/HewaED6yIEVNvIQ9RRGdGbe/GZ9LcTs2pI0FETLrC6AKmVIrsQ2LMm+GUU2XqIeeGrxXLd2f3aFLmzFxIsFy1FFaq1R2BGLpQxC6CEZAoQtjfh3uvHp3t6Jy9H0EWIYB7m2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Yr5U/Gee; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=ucizAdyhiCOUunoRreah5hE0Z6dugC99p9oKd7SBn3c=; b=Yr5U/GeeGe/fB90o
	glrN8yAtk4UE+pz3KL0EulPFuOXV70kbSdrN5w1XSbSCLM/9Y3kRqb46G/Bs0fFQ6kl+iH1QUOHj2
	J+c+CfCKo2X/C+NukLJmd3gvBRIRwuubRx9A4VfYoVveUKJg1UNoDjVgHL2kLdiSojjG7zpkJujxe
	iGCcCforhBUSDfO/iW6CpqcFOlRav4zYDCUH8dL7IXXpATdKaxZW/jAkNVdRhlBPyw8cLZPlmr86m
	5ezl5P67IGfML+nZjw6AOz9QtQ+eIDKWxhOViYdkusiKnR2y21CT9fDe7aYCHdPEvYzClv5f0cSMw
	K0UrVHAmGBfuFaKMLg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t05MK-00AnUX-24;
	Sun, 13 Oct 2024 20:38:36 +0000
From: linux@treblig.org
To: bharat@chelsio.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next 0/6] cxgb4: Deadcode removal
Date: Sun, 13 Oct 2024 21:38:25 +0100
Message-ID: <20241013203831.88051-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This is a bunch of deadcode removal in cxgb4.
It's all complete function removal rather than any actual change to
logic.

Build and boot tested, but I don't have the hardware to test
the actual card.

Dave

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (6):
  cxgb4: Remove unused cxgb4_alloc/free_encap_mac_filt
  cxgb4: Remove unused cxgb4_alloc/free_raw_mac_filt
  cxgb4: Remove unused cxgb4_get_srq_entry
  cxgb4: Remove unused cxgb4_scsi_init
  cxgb4: Remove unused cxgb4_l2t_alloc_switching
  cxgb4: Remove unused t4_free_ofld_rxqs

 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    | 23 -----
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   | 12 ---
 .../net/ethernet/chelsio/cxgb4/cxgb4_mps.c    | 98 -------------------
 .../net/ethernet/chelsio/cxgb4/cxgb4_uld.h    |  2 -
 drivers/net/ethernet/chelsio/cxgb4/l2t.c      | 19 ----
 drivers/net/ethernet/chelsio/cxgb4/l2t.h      |  2 -
 drivers/net/ethernet/chelsio/cxgb4/sge.c      | 16 ---
 drivers/net/ethernet/chelsio/cxgb4/srq.c      | 58 -----------
 drivers/net/ethernet/chelsio/cxgb4/srq.h      |  2 -
 9 files changed, 232 deletions(-)

-- 
2.47.0


