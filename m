Return-Path: <netdev+bounces-110949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7974F92F1B2
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B701F2276D
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFCB145B09;
	Thu, 11 Jul 2024 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKf2t0GT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F5C42AB5
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735640; cv=none; b=i40zHZ1bca6UKjDwCL2GQyQfVHYQZkNHsFJO3mvb1Oji8Ft1AcmrEh9hOOrmoAIBTWd5yV0AeE5SCuisz7JR4hfZIeO0Fmd76+1Cwqmp1SaisjFpD6nIRDL6hzJze0zTKMZUidJFdZrI2pXs44ZWJ3IUfX1iE41bf8yMtbRtwnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735640; c=relaxed/simple;
	bh=OlpdafalDc48hiWLfH1V+xR+vkDk4s3k3DTKFO7h7UM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CHLon+V1PxeU2RX8XDhLtTGw//YbjUwWoGo+WH4pqJ+b/sdt8wT0Divs8//LSqOSxrKe5+7OwdBt18TIZIN5av2tH1e68EgRPwHxcmnl62JBXOB0bRTaPbfpsDAyoVV5AOnez6VPmcn+cN3VcT0oiUqTWtIFyn1zsR/MOROqhBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKf2t0GT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56B5C116B1;
	Thu, 11 Jul 2024 22:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720735640;
	bh=OlpdafalDc48hiWLfH1V+xR+vkDk4s3k3DTKFO7h7UM=;
	h=From:To:Cc:Subject:Date:From;
	b=GKf2t0GTWbiU4VbArM2RHDtVq0P6saCxUqozzcpJ2t9oSQs57OcMQRfnpWuUocFst
	 WQoJxSce7ulxkDaAJ6OnigsyBZTD/gQd7G+9/cwC+038xuB57rPYR5LX0beiQPLdub
	 Fzjsx5FlBa6ZYsfqIMYHsGj4I++x/2B1IYOiL42ZAxAdRX4rTE09gfh/3UaGj4mWQU
	 MdmeI3q9zPgjKrxFoqfFWUI7QE8L8BxFnevx2mcRJBKZzvh84E4Jmlf9gM5kShavIO
	 7WjZ8M/waF2zG5slVWkEbOSwYXhnUPGKSq40FatZIRZmTWjMju5+qcDjVCutBViDzk
	 AJQaBFqEO0MVA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	michael.chan@broadcom.com,
	horms@kernel.org,
	pavan.chebbi@broadcom.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 00/11] eth: bnxt: use the new RSS API
Date: Thu, 11 Jul 2024 15:07:02 -0700
Message-ID: <20240711220713.283778-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert bnxt from using the set_rxfh API to separate create/modify/remove
callbacks.

Two small extensions to the core APIs are necessary:
 - the ability to discard contexts if for some catastrophic reasons
   device can no longer provide them;
 - the ability to reserve space in the context for RSS table growth.

The driver is adjusted to store indirection tables on u32 to make
it easier to use core structs directly.

With that out of the way the conversion is fairly straightforward.

Since the opposition to discarding contexts was relatively mild
and its what bnxt does already, I'm sticking to that. We may very
well need to revisit that at a later time.

v2:
 - move "lost context" helper to common.c to avoid build problems
   when ethtool-nl isn't enabled
 - add a note about the counter proposal in the commit message
 - move key_off to the end, under the private label (hiding from kdoc)
 - remove bnxt_get_max_rss_ctx_ring()
 - switch from sizeof(u32) to sizeof(*indir_tbl)
 - add a sentence to the commit msg
 - store a pointer to struct ethtool_rxfh_param instead of
   adding the ethtool_rxfh_priv_context() helper
v1: https://lore.kernel.org/all/20240702234757.4188344-1-kuba@kernel.org/

Jakub Kicinski (11):
  net: ethtool: let drivers remove lost RSS contexts
  net: ethtool: let drivers declare max size of RSS indir table and key
  eth: bnxt: allow deleting RSS contexts when the device is down
  eth: bnxt: move from .set_rxfh to .create_rxfh_context and friends
  eth: bnxt: remove rss_ctx_bmap
  eth: bnxt: depend on core cleaning up RSS contexts
  eth: bnxt: use context priv for struct bnxt_rss_ctx
  eth: bnxt: use the RSS context XArray instead of the local list
  eth: bnxt: pad out the correct indirection table
  eth: bnxt: bump the entry size in indir tables to u32
  eth: bnxt: use the indir table from ethtool context

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 126 +++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  17 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 165 ++++++++++--------
 include/linux/ethtool.h                       |  20 +--
 net/ethtool/common.c                          |  14 ++
 net/ethtool/ioctl.c                           |  46 +++--
 6 files changed, 194 insertions(+), 194 deletions(-)

-- 
2.45.2


