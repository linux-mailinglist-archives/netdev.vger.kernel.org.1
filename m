Return-Path: <netdev+bounces-115187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A252894562E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 03:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FAE0B20B7A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 01:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFA415AC4;
	Fri,  2 Aug 2024 01:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGLn16H5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675EFB67E
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 01:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722563969; cv=none; b=PVNfbrdc94wUsmqNM86D5fzIHi1FM1n/U2vtKO9OWflVynrRByzQZ9G829zoKHiHjkRFQwcrIdiMhyrYQzrzZGZhCIPFeeNsKlSTlBjH1CG+Oe/nhBHgkVXedL7l+czdG0VOMgsuC6c1SBxLek3QbMzYfOpkIsxIVfKsDT9PFWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722563969; c=relaxed/simple;
	bh=rdpXqGtfKE2FdKew+zNFA4NHEHynfDYpQJcSwDiJgAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKfyfX+4GhoPM96DSbk6lPDpeP27/gZwQXm9LQS/pFng7ZPsuvJSE8p5yzEGvOHK3Ij1U8a2kZiLIulNsJIu2fhIppdiicGxJfpXLTXtaZBhSQUSwbO3aUEA6z/TZJzZ9vI7hrg6hl6TaRuRdpaZh4oYp7QDKN7jMvN865l6mXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGLn16H5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A745FC32786;
	Fri,  2 Aug 2024 01:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722563969;
	bh=rdpXqGtfKE2FdKew+zNFA4NHEHynfDYpQJcSwDiJgAM=;
	h=From:To:Cc:Subject:Date:From;
	b=UGLn16H5FN/Gm6R/wXtCRy7XpLbrGHVqE+k7DsaHIPy0pyjXYWHmqgs7qbY2zyFxU
	 2zgd80K2tiv6pFg/EwfG54PRterDrAjFj1Tfzfn3v9ehjl15/EIGM4RsF/q4H40/1q
	 0ZJ9ESHzxbvOPr/3ZDzczHqCnD3YNE4e0eY5CdSauY5iAXGMm07bhL+/b8kL0d/frr
	 vwAUMhu20kB0W1C8K1xt1R7yMwGm9hwzv7oHKScXNrJWcKgNueu0Hdc24F5yQWEj7T
	 vAoi0rgVnMorN477qR3rU3vr8RVO1jQLZ6/Hrc8YGVD1zmp8xD+fi1VtG5PjKzBo4q
	 GigGqd2jAmXSg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	kernel test robot <lkp@intel.com>,
	alexanderduyck@fb.com
Subject: [PATCH net] eth: fbnic: select devlink
Date: Thu,  1 Aug 2024 18:59:24 -0700
Message-ID: <20240802015924.624368-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Build bot reports undefined references to devlink functions
in fbnic.ko.

Fixes: 1a9d48892ea5 ("eth: fbnic: Allocate core device specific structures and devlink interface")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408011219.hiPmwwAs-lkp@intel.com/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: alexanderduyck@fb.com
---
 drivers/net/ethernet/meta/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
index c002ede36402..55389f1d22b6 100644
--- a/drivers/net/ethernet/meta/Kconfig
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -23,6 +23,7 @@ config FBNIC
 	depends on !S390
 	depends on MAX_SKB_FRAGS < 22
 	depends on PCI_MSI
+	select NET_DEVLINK
 	select PHYLINK
 	help
 	  This driver supports Meta Platforms Host Network Interface.
-- 
2.45.2


