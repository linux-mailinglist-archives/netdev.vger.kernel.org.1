Return-Path: <netdev+bounces-38045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FA17B8B7E
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1CC55281BB3
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 18:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEEA21362;
	Wed,  4 Oct 2023 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnESdMYE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF292134D
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 18:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DFAC433C7;
	Wed,  4 Oct 2023 18:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696445726;
	bh=n26ifruBeSupq+s8VbXmEVZ3lXfdrda3ueK60gXr4l0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FnESdMYEgrhZH/Almr6hVPT2D1Y98Eg1F6ZKbQWwtmrxCM5IbA7uJn1QExRntQ/P0
	 G9h7myryxeaizxYalsCBYgujn0WIpTw/OINL1z3VDKzaIxevvF3gtRF2oPzdT8l6HJ
	 tkZGwPFD80GYnBN5dPrzeijaeUY1ApsADEYTl2ODNEnlTRVUhGCqhQaJMIIkRHRp3j
	 4W4ueSWil/CVMUfUJD3ijzoLZuXOCuPRPQI1MwDdvmuB0bw1wjMginzccTDfIWerj3
	 304/17y5qcgV0iZ0HBCljj/rKxlHHW+qsacX/5QHApITia8gigeaixxZW+MKo32QGO
	 yydDcmb/0rRPg==
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
Subject: [PATCH v2 83/89] sunrpc: convert to new timestamp accessors
Date: Wed,  4 Oct 2023 14:53:08 -0400
Message-ID: <20231004185347.80880-81-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to using the new inode timestamp accessor functions.

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


