Return-Path: <netdev+bounces-248033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F75D02806
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 12:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC413309F974
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 11:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2667A3FB6C0;
	Thu,  8 Jan 2026 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UIO6CaEs"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-103.ptr.blmpb.com (sg-1-103.ptr.blmpb.com [118.26.132.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C983F23B6
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867535; cv=none; b=KG4p4RF4lrvjFRsYoPhPVewJzGAw2vgNxJTgXzzln+L4Jqu4Vw18Q7Xpj+XONKYw88J+L+/8mwQ0teiSVqHeewwl/77Iq9puuzDuMbvbvBZHCLcK84zId+DhWIWNGX9e7WN53fdWeRNJq0eMjYRvuZQ+waXQmFM5sP+1rS9KrVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867535; c=relaxed/simple;
	bh=JZ3g6PRNm24rcwaSJzuaTWVXlS0Oz7zyfnO5GVwym2E=;
	h=Subject:Date:Message-Id:Mime-Version:From:Content-Type:To; b=DpNCv0UZWF9+pc736D76QpJlKWMZFkWvqDSBFsm0KK9in8B2iCftry0Ri57wm29g20lzljDXJGWjoybOhJL1VPXOb8nVCYIsoKYHC8iZo6mqar1crnUva+PR7derHYpdohlvMvNcAFaOIKmcZcSfFTZZwWNWqURHQN3F/lKJ6jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UIO6CaEs; arc=none smtp.client-ip=118.26.132.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1767867523; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=EELGF/QRlwwwrX0driH/TLyxb0FIIjjfOwxxpl8bL5M=;
 b=UIO6CaEseM7KliEK6hr1De4tY55ZZa1SCfvXReqYA04W3vmSwW+zwIPR6z2ZQoFRt+Uw8d
 gS3kdVD7sK+OTaqZudD5c3AFUMe9zTJV6x2Tdl0/JdbsMUngyEcoViHdca2E1hDNispxue
 uh5YOcq6o8FUiVZjpXokdOoYrL16D5BtG/yACGtxOwJLoZ7GIzvkzSwoemdl6SROZqfgE1
 S/JRoLmihKec6RMtd4dcuQGIfnK7hfAxuyfpVjCbzoasCwU2rPES4ZpUXnrphdVd/jfD5P
 VezvccQahkC18CYORik0dK6xtFnlfXkyjA7FLxMOgTLThcYWqwerYOVGHMoANg==
Subject: [PATCH] net: mctp-i2c: fix duplicate reception of old data
Date: Thu,  8 Jan 2026 18:18:29 +0800
Message-Id: <20260108101829.1140448-1-zhangjian.3032@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.20.1
From: "Jian Zhang" <zhangjian.3032@bytedance.com>
X-Original-From: Jian Zhang <zhangjian.3032@bytedance.com>
X-Lms-Return-Path: <lba+2695f8481+8cf922+vger.kernel.org+zhangjian.3032@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: "Jeremy Kerr" <jk@codeconstruct.com.au>, 
	"Matt Johnston" <matt@codeconstruct.com.au>, 
	"Andrew Lunn" <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>

The MCTP I2C slave callback did not handle I2C_SLAVE_READ_REQUESTED
events. As a result, i2c read event will trigger repeated reception of
old data, reset rx_pos when a read request is received.

Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
---
 drivers/net/mctp/mctp-i2c.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index f782d93f826e..ecda1cc36391 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -242,6 +242,9 @@ static int mctp_i2c_slave_cb(struct i2c_client *client,
 		return 0;
 
 	switch (event) {
+	case I2C_SLAVE_READ_REQUESTED:
+		midev->rx_pos = 0;
+		break;
 	case I2C_SLAVE_WRITE_RECEIVED:
 		if (midev->rx_pos < MCTP_I2C_BUFSZ) {
 			midev->rx_buffer[midev->rx_pos] = *val;
@@ -279,6 +282,9 @@ static int mctp_i2c_recv(struct mctp_i2c_dev *midev)
 	size_t recvlen;
 	int status;
 
+	if (midev->rx_pos == 0)
+		return 0;
+
 	/* + 1 for the PEC */
 	if (midev->rx_pos < MCTP_I2C_MINLEN + 1) {
 		ndev->stats.rx_length_errors++;
-- 
2.20.1

