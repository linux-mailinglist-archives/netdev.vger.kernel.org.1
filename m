Return-Path: <netdev+bounces-43325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B837D2601
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 23:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136E31C20869
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 21:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D44134CB;
	Sun, 22 Oct 2023 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="W0jDMP76"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC062B
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 21:00:06 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A443F2
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 14:00:04 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id ufYFqwcwpG6boufYFqoC7e; Sun, 22 Oct 2023 23:00:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1698008402;
	bh=73cQQIxO45qz3cOFWQdWJSGSNfMmo4mVxgrZWMonIWY=;
	h=From:To:Cc:Subject:Date;
	b=W0jDMP76iQYbOVkh8s0a7nAGBI9/PsvZpt5OmcjtevMyXpYOxcpRCJivVzH6a+8/b
	 JHWcrTT2HHXpXLixt0PdiPc6KyDxglR4iVrjsHnHfa6aiz1fy0tPnAA7w2JWivP4pm
	 u3CPtXZUYgbL9dzQ7ZSp64O5e5n50XKGz8K5UeNhlO1M2MUG1kKYgcXa4P0rVlfBfm
	 rJTXzrq5Dt497JsQuAeJ3W4+SJEFRCk2C2D0q+A2/eZbnwocU0knlXpk7xjIiyGTHv
	 3gM7JzerLUSCATt/C1dx0NNp+mCNhTerUQK1RbwiMQQmOMb25D4txUe+b8lFpbaANP
	 XZfxbwnQZL+Wg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 22 Oct 2023 23:00:02 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: dchickles@marvell.com,
	sburla@marvell.com,
	fmanlunas@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	veerasenareddy.burru@cavium.com
Cc: felix.manlunas@cavium.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net 0/2] liquidio: Fix an off by one in octeon_download_firmware()
Date: Sun, 22 Oct 2023 22:59:45 +0200
Message-Id: <cover.1698007858.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This serie fixes an off by one related to the usage of strncat() in
octeon_download_firmware().

The first patch is a minimal fix.

The 2nd one is an attempt to remove strncat() which is used in a wrong way
most of the time.
It removes the need of an intermediate buffer but may need further discussions.
(i.e. is it a good idea to update h->bootcmd directly?)

Both patches are compile tested only.

Christophe JAILLET (2):
  liquidio: Fix an off by one in octeon_download_firmware()
  liquidio: Simplify octeon_download_firmware()

 .../net/ethernet/cavium/liquidio/octeon_console.c   | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

-- 
2.34.1


