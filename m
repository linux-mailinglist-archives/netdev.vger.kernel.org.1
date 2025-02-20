Return-Path: <netdev+bounces-168103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5A3A3D827
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 12:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3511517869B
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1BB1F4E21;
	Thu, 20 Feb 2025 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2yjMtzj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3B1F4703;
	Thu, 20 Feb 2025 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050179; cv=none; b=tYwmNvCTKuFp3Of3rUOifyUcRcC0prJDF52iQTEiNYyBjRg/xmgK33O45d+pUzlSiviYQHjgDlKRfZWpSKqaTYEdGAuyk8COKNM17b02RFUtxkW/jp9hjsbCGRhSG6mrR55bdkgrftc873H9J5gHeYj/Z/mNwCHNgl105KxACNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050179; c=relaxed/simple;
	bh=WbIbJP8V1uaYvMyiXLy9rg/qAp/4D3SlYH4GG3NpwO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkL9c3c9GfpSTNemyXHu6l8NMnD2pAumNe5tXa3drh8wAmbS5DJcs73QQUBZ/yyZtfbguiwcLQ0ZY1e3l2qTIVoPAQkqDEv8a5C2wHlawHfsrmJY0NdtmT4eZHABWhtUXmVC5V+2SobSF/Fp/b5rxWHu5ww4wlQWMlyDPvmSmvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2yjMtzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F49CC4CEE3;
	Thu, 20 Feb 2025 11:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050178;
	bh=WbIbJP8V1uaYvMyiXLy9rg/qAp/4D3SlYH4GG3NpwO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q2yjMtzjXSeVJC7h5fsIgqV1EUf5vIiYqndGU4VC/zqRISxdGNXUnyIBFqgSZlhbL
	 dltiA0Iqs70r/w3SU7LnYOA+c/Z7ssyC71hBktYxAirrszteC+oIeW746Y+lDEyq/I
	 oG4ZTigA0sl05+Q5oqNoi/DpWpGQkbwo+VDEN7lv61sGPVZbObYuB+4qLWdThggn+N
	 uFamXbLqScpRtulGiCgFnak0PuWUpEuL+OtR+uHS7K/RmGAEDS7O4mJT+HdC0rwFn7
	 oNIthpYIt/di4XYOH+ZjgtB8vaKFpze2GB+A7zFsynxF9jWd92rrSNXypjs0Ht6J/A
	 8s1g/GIpnWU8A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH 03/29] tty: caif: do not use N_TTY_BUF_SIZE
Date: Thu, 20 Feb 2025 12:15:40 +0100
Message-ID: <20250220111606.138045-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220111606.138045-1-jirislaby@kernel.org>
References: <20250220111606.138045-1-jirislaby@kernel.org>
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
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
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
2.48.1


