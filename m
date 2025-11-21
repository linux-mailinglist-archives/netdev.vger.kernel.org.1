Return-Path: <netdev+bounces-240807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F24C7ACA6
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E4FC342EB8
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14A834E779;
	Fri, 21 Nov 2025 16:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5840034FF6B
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741425; cv=none; b=XLP4x4sq7zyFhH9wFQ8sifIY0S4Aw3QlliLdL/qFda2293jOR/YPisRTFatYaWs3p4jzBZNCOnzxxnqz+rK7NaH0lvdTYiMcWLHlNUZaf4Ha3C5fevYUB1/cKmS2S7J74eEf/+M12xlXzIDRR+EOAMeSbq4cmZFcaCJiWU0PH3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741425; c=relaxed/simple;
	bh=koPu2OS4xs2Z4RrjCJxtqJsDcimXkzohnNY5nQoIwWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnOhTAjeClfhDO+jx4ndoJeFBuupQ8o3u3scqzcOb+3WOY6EZr+liOcA3n+XpDikK/Zf04ZQzb+eO83PKZFthVHJM7pvJeHhmse/0gnO3EQxzGYt1gNFrTCvtYw/oLhJXyqQrGorRUfjTrxpRaOwgtOAdQstcRSqyqqIye0GWSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A86CF219AE;
	Fri, 21 Nov 2025 16:10:14 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59C3B3EA61;
	Fri, 21 Nov 2025 16:10:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Rl8OCuaOIGmSeAAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 21 Nov 2025 16:10:14 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	netdev@vger.kernel.org,
	io-uring@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2 3/3] io_uring: Introduce getsockname io_uring cmd
Date: Fri, 21 Nov 2025 11:09:48 -0500
Message-ID: <20251121160954.88038-4-krisman@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121160954.88038-1-krisman@suse.de>
References: <20251121160954.88038-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: A86CF219AE
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

Introduce a socket-specific io_uring_cmd to support
getsockname/getpeername via io_uring.  I made this an io_uring_cmd
instead of a new operation to avoid polluting the command namespace with
what is exclusively a socket operation.  In addition, since we don't
need to conform to existing interfaces, this merges the
getsockname/getpeername in a single operation, since the implementation
is pretty much the same.

This has been frequently requested, for instance at [1] and more
recently in the project Discord channel. The main use-case is to support
fixed socket file descriptors.

[1] https://github.com/axboe/liburing/issues/1356

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 include/uapi/linux/io_uring.h |  1 +
 io_uring/cmd_net.c            | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 3d921cbb84f8..6a97c5376019 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -1010,6 +1010,7 @@ enum io_uring_socket_op {
 	SOCKET_URING_OP_GETSOCKOPT,
 	SOCKET_URING_OP_SETSOCKOPT,
 	SOCKET_URING_OP_TX_TIMESTAMP,
+	SOCKET_URING_OP_GETSOCKNAME,
 };
 
 /*
diff --git a/io_uring/cmd_net.c b/io_uring/cmd_net.c
index 27a09aa4c9d0..90f58f883f62 100644
--- a/io_uring/cmd_net.c
+++ b/io_uring/cmd_net.c
@@ -132,6 +132,27 @@ static int io_uring_cmd_timestamp(struct socket *sock,
 	return -EAGAIN;
 }
 
+static int io_uring_cmd_getsockname(struct socket *sock,
+				    struct io_uring_cmd *cmd,
+				    unsigned int issue_flags)
+{
+	const struct io_uring_sqe *sqe = cmd->sqe;
+	struct sockaddr_storage address;
+	struct sockaddr __user *uaddr;
+	unsigned int peer;
+	int __user *ulen;
+
+	if (sqe->ioprio || sqe->__pad1 || sqe->len || sqe->rw_flags)
+		return -EINVAL;
+
+	uaddr = u64_to_user_ptr(READ_ONCE(sqe->addr));
+	ulen = u64_to_user_ptr(sqe->addr3);
+	peer = READ_ONCE(sqe->optlen);
+	if (peer > 1)
+		return -EINVAL;
+	return do_getsockname(sock, &address, 0, uaddr, ulen);
+}
+
 int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	struct socket *sock = cmd->file->private_data;
@@ -159,6 +180,8 @@ int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
 		return io_uring_cmd_setsockopt(sock, cmd, issue_flags);
 	case SOCKET_URING_OP_TX_TIMESTAMP:
 		return io_uring_cmd_timestamp(sock, cmd, issue_flags);
+	case SOCKET_URING_OP_GETSOCKNAME:
+		return io_uring_cmd_getsockname(sock, cmd, issue_flags);
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.51.0


