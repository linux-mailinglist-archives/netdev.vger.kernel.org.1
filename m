Return-Path: <netdev+bounces-305275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CsFnNceMTGprmAEAu9opvQ
	(envelope-from <netdev+bounces-305275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 07:21:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEBD7176D6
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 07:21:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Rg7QkQtg;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305275-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305275-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA6EB301AC11
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 05:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEE6381AEF;
	Tue,  7 Jul 2026 05:21:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB39C2EBB99
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 05:21:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783401668; cv=none; b=I5Zin6uJ9rvt5wP272ezDrs2kYJBFI95yNEyy5G7hDIlOtGcjaXT2EKdjagfWhMkXrhJy/0+LnAaX+wlekSqlymr9HRGAbwDJbwqb0+jYwGMZONOduxPm57dqxcQYGBcdMmgLDbF6T8bvq8yvAEm+5zMpCXvkXT0jLAywuTweYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783401668; c=relaxed/simple;
	bh=qXIWHSLyD+fTq5CYIL5RdrArR1kMbF2BZZFtbn1U3K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqkGm4XF7H6D4bkgEdKPcZoV2elnocPhbLC6JlraCIin4WE0vNXuhRE9KiLtRJUmjCIPRHcDAQfY0FEBb0j+FYkY6LBLAlYxAbQkmzJHMndmdmqPcT6qnWi2XQwZ73ChuRN+DIVHpX4jGH9doDHc2lKK+GUdloTl0GuIKHgDDHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rg7QkQtg; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-381b831d535so4272289a91.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 22:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783401666; x=1784006466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Blyrj+ntsWafQiuA8MTgFjvm/6Vjz++htzHBsCCdax8=;
        b=Rg7QkQtgjI8Nm7+44hbGHGJGJulxcf6jPFHQ/1LJpWv+N67+zcoi1as/Z+cE8hy71D
         BoLDbR1QV35x/a3Teznw8eXH9Yio/WEpMtZomgXOnrSZ6tDWl07uhRnMFqqHTFp896Dz
         crWOVfzqcC27WosYJrRIBjU/3MpgNp0WPpKlvwjWqxkfBAPaGcirR73A4aIZMt6L1ky3
         8AQFrbr9caACBtoG+PYjVBsg9pqzpjtVISGisaXTvTd8/mmQhno8dRCImmrCAFuWpBt4
         YGMojhaeXJx5ZR4qcukfD3ApYPPPTxMFob6YU9xgfyfC2/q8dDNmiTQ1UsloixmnwpPn
         gUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783401666; x=1784006466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Blyrj+ntsWafQiuA8MTgFjvm/6Vjz++htzHBsCCdax8=;
        b=UjD406Z/snhbG16BPxQ0sGQscNd6OiwJ36oLQ/KTRQW+LzRMgukbEozfOvFOapIdmT
         IeqZaVnE40rScqfa4KoaCqka1WjkHLs8RaY8EMzZV/kg9pdcw5oF/9RB/CAR9UsuER86
         xG6JIvImIgwjwt/ucioZZBP+SKH+3ggs+ubVhyY1DAX/LXzU6QWc2+B8gS+RnqP7I0uM
         oFrZJ0wwhvKzcgTCldKgZ6H/T7z/kGHn4bj3u3Fe3OmFXIIuXf3fqajeijoU2nFRzsjJ
         iKHnJ5eiY+0ZIBNR35f+7r8+Kw7uZOCw7cge7KBGerFgL91DKjCI5KdzmWR7w38jQlAL
         E9YQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFavpucIc6DX5LhZwodEAO+0iyeAxUZ1tEnr+O129slePu/Qqhc6hSfqyTW9JYPIg6kN7q6Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxloH1h+3xXlJ2sGHdDHorTazP/vM4K101WI7tiAZ4dGuz2ekxX
	eWtysKoZgzeWNubGPC8KKVignZXsxZ/5I0s6kmWCVJq1Tir19juG16cX
X-Gm-Gg: AfdE7cmmMrNEa6s7KCQXj2oEjesgd/l439yoFab1LBojR73lv0z2owFcCHJAWdB7GNU
	8yC5NJvGYqwfBAjL3FhLdHLka1UJ8/VLhF5mXSPNLBR5L5qcEEwVIaiVc5fUYuHHoLqlNqnQUMK
	1kiyl3BiCfdDz3UaS9R4RKHQOiL1mEEW1nZWAPC0gj51mhr3Lz7tnyaGRy3fzzP0WVOhJC97ttp
	wRzg62APgtVDHr9d7cFGogYQvzGXYQ31e9V2GAfCTxOBxQ5x1zkYXFJtWh6+ho9UkZ+IMTXoLpr
	aJQ7GTPUa5FHHQBxE8z2DZtO9h+IrGoCvuVtqHir14odv5Xwo7KxMEt3I936cEEW3nnSwZ4ReMh
	ajevHQOHsrb86Xm7fYAqERC2DDREm715czjkS3dug7R72rsUxBW0HROQ+3i1pHtl1Bn+HoJRAx2
	0bmYf63gnaQ7YfCAIjp8+dwFI91ptYuvQ=
X-Received: by 2002:a17:90b:2688:b0:37f:caeb:69df with SMTP id 98e67ed59e1d1-38758164244mr3838662a91.22.1783401666109;
        Mon, 06 Jul 2026 22:21:06 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([123.114.53.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d15f149bsm419814a91.5.2026.07.06.22.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 22:21:05 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Cc: cel@kernel.org,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	fuzhen5@huawei.com,
	yuantan098@gmail.com,
	dstsmallbird@foxmail.com,
	enjou1224z@gmail.com,
	rakukuip@gmail.com
Subject: [PATCH 1/1] sunrpc: fix use-after-free in __rpc_clnt_handle_event and __rpc_clnt_remove_pipedir
Date: Tue,  7 Jul 2026 13:20:47 +0800
Message-ID: <7cc1079bdd86c196d5c714c91df38dfc73aa40b6.1783393213.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1783393213.git.rakukuip@gmail.com>
References: <cover.1783393213.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-305275-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,brown.name,redhat.com,oracle.com,talpey.com,davemloft.net,google.com,huawei.com,gmail.com,foxmail.com];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:cel@kernel.org,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:fuzhen5@huawei.com,m:yuantan098@gmail.com,m:dstsmallbird@foxmail.com,m:enjou1224z@gmail.com,m:rakukuip@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[enjou1224z@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[enjou1224z@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CEBD7176D6

From: Luxiao Xu <rakukuip@gmail.com>

Normal client creation goes through rpc_setup_pipedir(), which records
clnt->pipefs_sb, but the mount-event path in __rpc_clnt_handle_event()
calls rpc_setup_pipedir_sb() directly and never refreshes that field.
The umount path also removes the directory without clearing
clnt->pipefs_sb.

After a late pipefs mount or any remount, rpc_clnt_remove_pipedir()
compares the current superblock against a stale pipefs_sb pointer and
skips cleanup, leaving pipefs dentries whose inode private data still
points at a freed rpc_clnt, leading to a potential use-after-free during
subsequent rpc_info_open() or rpc_show_info() calls.

Fix this by properly updating clnt->pipefs_sb upon mount events and
clearing it during unmount or failure paths.

Fixes: bfca5fb4e97c ("SUNRPC: Fix RPC client cleaned up the freed pipefs dentries")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <dstsmallbird@foxmail.com>
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
---
 net/sunrpc/clnt.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index bc8ca470718b..85fdd8ba94a4 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -96,7 +96,10 @@ static void rpc_unregister_client(struct rpc_clnt *clnt)
 
 static void __rpc_clnt_remove_pipedir(struct rpc_clnt *clnt)
 {
-	rpc_remove_client_dir(clnt);
+	if (clnt->pipefs_sb) {
+		rpc_remove_client_dir(clnt);
+		clnt->pipefs_sb = NULL;
+	}
 }
 
 static void rpc_clnt_remove_pipedir(struct rpc_clnt *clnt)
@@ -177,19 +180,28 @@ static int rpc_clnt_skip_event(struct rpc_clnt *clnt, unsigned long event)
 }
 
 static int __rpc_clnt_handle_event(struct rpc_clnt *clnt, unsigned long event,
-				   struct super_block *sb)
+				    struct super_block *sb)
 {
+	int err = 0;
+
 	switch (event) {
 	case RPC_PIPEFS_MOUNT:
-		return rpc_setup_pipedir_sb(sb, clnt);
+		clnt->pipefs_sb = sb;
+		err = rpc_setup_pipedir_sb(sb, clnt);
+		if (err)
+			clnt->pipefs_sb = NULL;
+		break;
 	case RPC_PIPEFS_UMOUNT:
-		__rpc_clnt_remove_pipedir(clnt);
+		if (clnt->pipefs_sb == sb) {
+			__rpc_clnt_remove_pipedir(clnt);
+			clnt->pipefs_sb = NULL;
+		}
 		break;
 	default:
 		printk(KERN_ERR "%s: unknown event: %ld\n", __func__, event);
 		return -ENOTSUPP;
 	}
-	return 0;
+	return err;
 }
 
 static int __rpc_pipefs_event(struct rpc_clnt *clnt, unsigned long event,
-- 
2.43.0

