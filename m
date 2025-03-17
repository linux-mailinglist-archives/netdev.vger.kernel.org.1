Return-Path: <netdev+bounces-175188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B1AA6426D
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FD016F445
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 07:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8351721ADC4;
	Mon, 17 Mar 2025 07:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEELfaAE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5455121ADB5;
	Mon, 17 Mar 2025 07:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194855; cv=none; b=VoK+Ka5UMhDXnBoSYmOjOqFlG/Ywgf3cN4Eq68QS1MJDBows/9/voVjSHYPkG8YoULt1EXXwdVPj2OBwq8TWz6qId2UwLBgUYso30DpHC4YLCaARWnobxfDLMdGirVwodvBlsm51kU76JAGOtqeGc+TpYEHZjTZxqoYCFDLz7T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194855; c=relaxed/simple;
	bh=yigraz6gtl0qy6j2K57A2C+zse8kZCtw33CRv7cnvHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmGqHUODL4T40+4MzpylUgTsAD96KjPz/ak0ZXSkJzylDekcAWP09y6uBkMDYk8+jnq3349hzWZ4YA2akNVS6PvVHWdS7BMVdJzN6dvFhuGiV4juN7KjP6xEyITcmR/dKjJ6Grz/BkxgRgSVKJmzhXxkyWu6NLzCreejynDAZu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEELfaAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106CAC4CEEF;
	Mon, 17 Mar 2025 07:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194855;
	bh=yigraz6gtl0qy6j2K57A2C+zse8kZCtw33CRv7cnvHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fEELfaAEZyx4zAeonEc7yuW8832rUeOgP7L8ySAY96F4wYOA6tG+O+8lRBun4T4cN
	 lMcndyT5Y7pXW7mbi93x2x5wBhK68r21gwTdwpuJXAUGR0ujbLZFGJFORJiZXdWeoI
	 vSbon5VkhcJYMqBMUScT3Lblhuz8oefXVWEmAKs7OZycgSzHZ6NNGAU47p8Pd7kUrs
	 dtuwJ3AG/9K0z3V+LEfBqLY1s21BaxQNRqEz2JIBR2IpG0kXEJ6ROP5FwgxTU+twsi
	 qfg6U1QqmrI5cbqI080Jm1rZTGI64oSQ8UtvBXUyTxwaojFwGNGBrY9ZmzFQKaCoRt
	 0WsMLRvDNOgLw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 03/31] tty: caif: do not use N_TTY_BUF_SIZE
Date: Mon, 17 Mar 2025 08:00:18 +0100
Message-ID: <20250317070046.24386-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317070046.24386-1-jirislaby@kernel.org>
References: <20250317070046.24386-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

N_TTY_BUF_SIZE -- as the name suggests -- is the N_TTY's buffer size.
There is no reason to couple that to caif's tty->receive_room. Use 4096
directly -- even though, it should be some sort of "SKB_MAX_ALLOC" or
alike. But definitely not N_TTY_BUF_SIZE.

N_TTY_BUF_SIZE is private and will be moved to n_tty.c later.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
 drivers/net/caif/caif_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index ed3a589def6b..e7d1b9301fde 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -344,7 +344,7 @@ static int ldisc_open(struct tty_struct *tty)
 	ser->tty = tty_kref_get(tty);
 	ser->dev = dev;
 	debugfs_init(ser, tty);
-	tty->receive_room = N_TTY_BUF_SIZE;
+	tty->receive_room = 4096;
 	tty->disc_data = ser;
 	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 	rtnl_lock();
-- 
2.49.0


