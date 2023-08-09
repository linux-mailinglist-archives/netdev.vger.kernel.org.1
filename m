Return-Path: <netdev+bounces-25798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06D47758DF
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B2B1C2123D
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 10:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55641774D;
	Wed,  9 Aug 2023 10:55:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3B41774C;
	Wed,  9 Aug 2023 10:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFEBC433CD;
	Wed,  9 Aug 2023 10:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1691578505;
	bh=o5kVOmmulYHn0UuyrUiUIxhNbTitBnpOWApY0H1ojgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QuLApYWH8OVHeqvtqJ0pkRnmA9kCTl1HDzaoUmIpid5LEQPeyswE7HMyOxi6nQety
	 uECT/CXiPuX4+E2TjVwYBxZdGpqpVTUkM8o5cEmJJDJ5yfapF4X20Og0TPZLb6zFgz
	 4953EWBYUqM91+gbTnymCWMHljbLG8iayOrjhq4k=
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
Subject: [PATCH 6.1 084/127] net: tap_open(): set sk_uid from current_fsuid()
Date: Wed,  9 Aug 2023 12:41:11 +0200
Message-ID: <20230809103639.436767604@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
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
@@ -533,7 +533,7 @@ static int tap_open(struct inode *inode,
 	q->sock.state = SS_CONNECTED;
 	q->sock.file = file;
 	q->sock.ops = &tap_socket_ops;
-	sock_init_data_uid(&q->sock, &q->sk, inode->i_uid);
+	sock_init_data_uid(&q->sock, &q->sk, current_fsuid());
 	q->sk.sk_write_space = tap_sock_write_space;
 	q->sk.sk_destruct = tap_sock_destruct;
 	q->flags = IFF_VNET_HDR | IFF_NO_PI | IFF_TAP;



