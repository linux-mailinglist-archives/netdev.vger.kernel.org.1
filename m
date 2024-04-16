Return-Path: <netdev+bounces-88520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DA88A7888
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 01:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9C4282D36
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 23:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F7713AA3A;
	Tue, 16 Apr 2024 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASTDo5Gh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE9113AA37
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713309701; cv=none; b=EY48xpfH7tVpGVpCXpCjx1z1waLUn/64qTIDPk6KzTV6kXEi+miQJ8VYKJmzE/QSPSyq2wKkN8Ejr98yGibg+MsOVKh7ucvuDROScSoyVeOdvWw0XagBz/eMutjhKkVg6pve41/Nn6VHyZ+bgegRlgNkJBZvry0yjLkGAr1D4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713309701; c=relaxed/simple;
	bh=VRRb4vqJE4sMSqtH4l0aA79+CD9Wq9bJlebsCzEL7CE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z4yFdMsblTAUPUqkMtYrhB8f/7fXIEw3NcVO4sgG/hLusRPWFLWhc/FasUzBHVwKco/OG3VAQlyfkwf7vABScD1izU+DIRsXx86ute/K3F0hMlADSmrE3u+tLsH6Z4ut4Yll1mnjtkYMaEz5K7T6Z8QjkKUK1EYpsSTjz3ve0E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASTDo5Gh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1164BC32781;
	Tue, 16 Apr 2024 23:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713309701;
	bh=VRRb4vqJE4sMSqtH4l0aA79+CD9Wq9bJlebsCzEL7CE=;
	h=From:To:Cc:Subject:Date:From;
	b=ASTDo5GhXCA4OKKO9PqS5lWk5RJk/2B+L0AhK9vuGomjViUjHGNXWQn2c1Iub/KUe
	 4v6ZZJiDHNw7L9NbomD+O2wrGXqJ57+moLe/WbbKkEyBBFXLI6BxwgucMdjqaM4cXW
	 Wv/JHq/5Y3XHn2rWfpESeTmp947VjDWnFL0YYpI37yDR9YALrsZaz0bHISp71BaeF+
	 scMnp8b7hw59KQdDD5oidB+9wQlnp/mZ0K2SmKQDJY2I2Xnpz9//QjZeQkfX70NH1w
	 Gs7a/bqUlMzRP3JKBxzkgnM5zEejKN5laGW5xgdtamGq88u/15RM/anYd8fn2fkzJ+
	 MS1Fc3esziw5Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net-next] net: netdevsim: select PAGE_POOL in Kconfig
Date: Tue, 16 Apr 2024 16:21:37 -0700
Message-ID: <20240416232137.2022058-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

build bot points out that I forgot to add the PAGE_POOL
config dependency when adding the support in netdevsim.

Fixes: 1580cbcbfe77 ("net: netdevsim: add some fake page pool use")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404170348.thxrboF1-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202404170527.LIAPSyMB-lkp@intel.com/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index f0663cf1f755..9920b3a68ed1 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -640,6 +640,7 @@ config NETDEVSIM
 	depends on PSAMPLE || PSAMPLE=n
 	depends on PTP_1588_CLOCK_MOCK || PTP_1588_CLOCK_MOCK=n
 	select NET_DEVLINK
+	select PAGE_POOL
 	help
 	  This driver is a developer testing tool and software model that can
 	  be used to test various control path networking APIs, especially
-- 
2.44.0


