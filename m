Return-Path: <netdev+bounces-25800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3485775972
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 13:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900B4281BA8
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FEE1774C;
	Wed,  9 Aug 2023 11:00:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8151774D;
	Wed,  9 Aug 2023 11:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CB5C433CB;
	Wed,  9 Aug 2023 11:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1691578811;
	bh=dVBAkrIYNCNukXN1fuSFIY/HtrxN633d6BXx6ActWB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KGIgFWNRFmJseG0OVklQh1wNnayyLDrEvJ+LvRd0QNhs+EHLeosK8TG+l8jZlxp6/
	 Dpfa/6Rvmsy47XKDLefowMHrjj+bYYsaex5ybAp9VrOiEMtEFc75m+gsIiZ1NJ0usv
	 sCUT2NS8t5dq6nYPM7qd7tAJvjpeaQOSJNxiVu9Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pietro Borrello <borrello@diag.uniroma1.it>,
	netdev@vger.kernel.org,
	Laszlo Ersek <lersek@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 66/92] net: tap_open(): set sk_uid from current_fsuid()
Date: Wed,  9 Aug 2023 12:41:42 +0200
Message-ID: <20230809103635.872225656@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
User-Agent: quilt/0.67
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Laszlo Ersek <lersek@redhat.com>

commit 5c9241f3ceab3257abe2923a59950db0dc8bb737 upstream.

Commit 66b2c338adce initializes the "sk_uid" field in the protocol socket
(struct sock) from the "/dev/tapX" device node's owner UID. Per original
commit 86741ec25462 ("net: core: Add a UID field to struct sock.",
2016-11-04), that's wrong: the idea is to cache the UID of the userspace
process that creates the socket. Commit 86741ec25462 mentions socket() and
accept(); with "tap", the action that creates the socket is
open("/dev/tapX").

Therefore the device node's owner UID is irrelevant. In most cases,
"/dev/tapX" will be owned by root, so in practice, commit 66b2c338adce has
no observable effect:

- before, "sk_uid" would be zero, due to undefined behavior
  (CVE-2023-1076),

- after, "sk_uid" would be zero, due to "/dev/tapX" being owned by root.

What matters is the (fs)UID of the process performing the open(), so cache
that in "sk_uid".

Cc: Eric Dumazet <edumazet@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Pietro Borrello <borrello@diag.uniroma1.it>
Cc: netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: 66b2c338adce ("tap: tap_open(): correctly initialize socket uid")
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2173435
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -523,7 +523,7 @@ static int tap_open(struct inode *inode,
 	q->sock.state = SS_CONNECTED;
 	q->sock.file = file;
 	q->sock.ops = &tap_socket_ops;
-	sock_init_data_uid(&q->sock, &q->sk, inode->i_uid);
+	sock_init_data_uid(&q->sock, &q->sk, current_fsuid());
 	q->sk.sk_write_space = tap_sock_write_space;
 	q->sk.sk_destruct = tap_sock_destruct;
 	q->flags = IFF_VNET_HDR | IFF_NO_PI | IFF_TAP;



