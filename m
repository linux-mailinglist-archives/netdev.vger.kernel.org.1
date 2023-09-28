Return-Path: <netdev+bounces-36762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE327B19B7
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 13:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 48D9F1C20975
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 11:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E41D3716D;
	Thu, 28 Sep 2023 11:05:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15F235896
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 11:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D268FC43395;
	Thu, 28 Sep 2023 11:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695899150;
	bh=0P4fQQ7SkEsC3hdW3vPp6OWO9DCcnlz/5E+g/XegbtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EA8PS94M7lAThjFIrSWRW/phMmXb7E4FNcL+kYmUWn6cw7DLcdSW5/2gppPEEnfvA
	 +JOVBlG+8UuxuMvUMkJ9MK//m7GaXZP3/jC+uhHT/RcGN+ZcNDI+llhl33R3odfpn9
	 aTgjA6Q6g57eLFUVH9bkc7dprQP0CRmxZpW1dBhlyLbVfLTsjSSrmY3VEPtGsWPxv4
	 WVxrjXhTRPigxRgC94P9mX/7RG52Z4zoJTLGsSrBPKZcvRb+uDAaI9itQf6LpqFd3D
	 JjwpgpdE40vHp/XmjgG4t8InfS95vqShUoICMDUdjsVB5D5euNREctIgoEnT/ZDdxh
	 h7QrD3HmWkEIA==
From: Jeff Layton <jlayton@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 81/87] net/sunrpc: convert to new inode {a,m}time accessors
Date: Thu, 28 Sep 2023 07:03:30 -0400
Message-ID: <20230928110413.33032-80-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/rpc_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index f420d8457345..dcc2b4f49e77 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -472,7 +472,7 @@ rpc_get_inode(struct super_block *sb, umode_t mode)
 		return NULL;
 	inode->i_ino = get_next_ino();
 	inode->i_mode = mode;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	switch (mode & S_IFMT) {
 	case S_IFDIR:
 		inode->i_fop = &simple_dir_operations;
-- 
2.41.0


