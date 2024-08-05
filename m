Return-Path: <netdev+bounces-115706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788B7947974
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7541C211D3
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 10:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0304515C15A;
	Mon,  5 Aug 2024 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUiDXu22"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE64815B99D;
	Mon,  5 Aug 2024 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853266; cv=none; b=mFHpxzcDFwTCnbv78pMkZZ3FZB4viM5Ud0gcL5EjYN2N8Ex08QVO+EvPd9Vi9WxsDulLoyq6ukTzzz91BextsNxojbGHFMLJApEKRoYOswrcBP41Ij67AYcqW8tYUbFCr1JE5fqopOKUYyxQOP8FbFHfCIbJitflmhtfJOTS9YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853266; c=relaxed/simple;
	bh=9Fik8RXRQRa2crOyQlS1nroMylh+Z+5N4egxIxbBjx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klEUddxaW82RF5V5MCaxOGSlNJIxJRs8FwkX065DXaemjPUvzpH7yelKg+qyLAuAXHnzr3r2g7X9pjTpZ7IU6bNk/J6W25+IMFTihWWq9/LsnqRsmY9SUQF1Q4P0oseHfMbBXzCg7+5Yx0Cm7i7RUUcJUcLZ04nWsMfLkRROzec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUiDXu22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB14C32782;
	Mon,  5 Aug 2024 10:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722853266;
	bh=9Fik8RXRQRa2crOyQlS1nroMylh+Z+5N4egxIxbBjx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eUiDXu22uB+jbLMph18hBLd/KCcOpYlxMPBisM53NfJD624xvBT1xw5G0sB7ATIAg
	 78zkxf2hgsDgGOaRgopFdiJuMsGQJ5l7921xAAnYhmGXQIQiHmExHcncJUw8KGMJaJ
	 Dk0mRDZIg3RuwZDfBtgyXJrMibNd3Nk3hI5V/Uzspymd8d5sTKncay2pPY1D4374RL
	 V0j4Tg+tZ516U3PEzWv0t5v2TG2tlPWsTcjRgGXhbhgnFpK1ckm+ZOBELLESiGGjFo
	 f2NgbJuSLg+OISfrxIQ1j9B+3AR2a0sqE8Dcfsqx4Q87QXz4/j2upBKjTccoCPJnVx
	 UBXeHhIN/Lc6A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH 08/13] mctp: serial: propagage new tty types
Date: Mon,  5 Aug 2024 12:20:41 +0200
Message-ID: <20240805102046.307511-9-jirislaby@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240805102046.307511-1-jirislaby@kernel.org>
References: <20240805102046.307511-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tty, u8 is now used for data, ssize_t for sizes (with possible
negative error codes). Propagate these types (and use unsigned in
next_chunk_len()) to mctp.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
 drivers/net/mctp/mctp-serial.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-serial.c
index 5bf6fdff701c..78bd59b0930d 100644
--- a/drivers/net/mctp/mctp-serial.c
+++ b/drivers/net/mctp/mctp-serial.c
@@ -64,18 +64,18 @@ struct mctp_serial {
 	u16			txfcs, rxfcs, rxfcs_rcvd;
 	unsigned int		txlen, rxlen;
 	unsigned int		txpos, rxpos;
-	unsigned char		txbuf[BUFSIZE],
+	u8			txbuf[BUFSIZE],
 				rxbuf[BUFSIZE];
 };
 
-static bool needs_escape(unsigned char c)
+static bool needs_escape(u8 c)
 {
 	return c == BYTE_ESC || c == BYTE_FRAME;
 }
 
-static int next_chunk_len(struct mctp_serial *dev)
+static unsigned int next_chunk_len(struct mctp_serial *dev)
 {
-	int i;
+	unsigned int i;
 
 	/* either we have no bytes to send ... */
 	if (dev->txpos == dev->txlen)
@@ -99,7 +99,7 @@ static int next_chunk_len(struct mctp_serial *dev)
 	return i;
 }
 
-static int write_chunk(struct mctp_serial *dev, unsigned char *buf, int len)
+static ssize_t write_chunk(struct mctp_serial *dev, u8 *buf, size_t len)
 {
 	return dev->tty->ops->write(dev->tty, buf, len);
 }
@@ -108,9 +108,10 @@ static void mctp_serial_tx_work(struct work_struct *work)
 {
 	struct mctp_serial *dev = container_of(work, struct mctp_serial,
 					       tx_work);
-	unsigned char c, buf[3];
 	unsigned long flags;
-	int len, txlen;
+	ssize_t txlen;
+	unsigned int len;
+	u8 c, buf[3];
 
 	spin_lock_irqsave(&dev->lock, flags);
 
@@ -293,7 +294,7 @@ static void mctp_serial_rx(struct mctp_serial *dev)
 	dev->netdev->stats.rx_bytes += dev->rxlen;
 }
 
-static void mctp_serial_push_header(struct mctp_serial *dev, unsigned char c)
+static void mctp_serial_push_header(struct mctp_serial *dev, u8 c)
 {
 	switch (dev->rxpos) {
 	case 0:
@@ -323,7 +324,7 @@ static void mctp_serial_push_header(struct mctp_serial *dev, unsigned char c)
 	}
 }
 
-static void mctp_serial_push_trailer(struct mctp_serial *dev, unsigned char c)
+static void mctp_serial_push_trailer(struct mctp_serial *dev, u8 c)
 {
 	switch (dev->rxpos) {
 	case 0:
@@ -347,7 +348,7 @@ static void mctp_serial_push_trailer(struct mctp_serial *dev, unsigned char c)
 	}
 }
 
-static void mctp_serial_push(struct mctp_serial *dev, unsigned char c)
+static void mctp_serial_push(struct mctp_serial *dev, u8 c)
 {
 	switch (dev->rxstate) {
 	case STATE_IDLE:
@@ -394,7 +395,7 @@ static void mctp_serial_tty_receive_buf(struct tty_struct *tty, const u8 *c,
 					const u8 *f, size_t len)
 {
 	struct mctp_serial *dev = tty->disc_data;
-	int i;
+	size_t i;
 
 	if (!netif_running(dev->netdev))
 		return;
-- 
2.46.0


