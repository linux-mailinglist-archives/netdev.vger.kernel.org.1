Return-Path: <netdev+bounces-12684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C187387B9
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA721C20F2D
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 14:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023F218C20;
	Wed, 21 Jun 2023 14:49:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1BF9DE
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B17C433CB;
	Wed, 21 Jun 2023 14:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687358986;
	bh=JWwO7OkTyfMAIqtGyDqlNs9vuPyKQiBHWzkORRbijSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FB1sp0NfdT/B9tJvd6nGwqdwNbxS/X98uvKraj0xUIQbNd4eKX7MimzafkP8GllFY
	 /xdxmP9ablfypq7dNXDLF/nSx+w3X4UB1jbilkmzJne64MOd+t863D2YwksVf/tEvC
	 +Me7UzIgjYJvy7JkOK/mbcD23U2D5+PYVnAshJHpDSgDiKlxYoy/91vhMeR+vz4pgz
	 xKWACMDfdYSQUZRgJlsf8NI2rj4yozHi18lqw9H/Y39rBkl1msBZ5Qm/RVy4euhCVU
	 QkrLmEl/Z/x3r2aFiUUqnQV2dmAe6P+qZaSafXC5Ve2QVeyVF0KuuCBqEGtmqYnbpT
	 CVMXUXji6sUPQ==
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 75/79] rpc_pipefs: switch to new ctime accessors
Date: Wed, 21 Jun 2023 10:46:28 -0400
Message-ID: <20230621144735.55953-74-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/rpc_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 0b6034fab9ab..aa382e7ae982 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -472,7 +472,7 @@ rpc_get_inode(struct super_block *sb, umode_t mode)
 		return NULL;
 	inode->i_ino = get_next_ino();
 	inode->i_mode = mode;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 	switch (mode & S_IFMT) {
 	case S_IFDIR:
 		inode->i_fop = &simple_dir_operations;
-- 
2.41.0


