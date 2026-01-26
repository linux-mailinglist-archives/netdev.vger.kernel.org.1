Return-Path: <netdev+bounces-253494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKEkFEBzd2n7ggEAu9opvQ
	(envelope-from <netdev+bounces-253494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:59:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8D189394
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 357A2300669D
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BB133B6C5;
	Mon, 26 Jan 2026 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmEQkRaP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A665133ADAC
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435966; cv=none; b=l6vHmtf4VcdClImfhrI5N5ooho191Ni9P9nodr629Cg1M13s+z3CVApPnHmxo55mUPXuP5C2SRLtpLMgy2BtBe1FatXSoES+H9U3oblL7TMV2/rZmq6Uxl9xBTTJ1gGAdGzGjzQCWFt0kvJmCyCgLJTPwTItzD1xwy452yDFXBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435966; c=relaxed/simple;
	bh=YyVPNfEOsRD7xz0I+FVk9lX1gzfrVr0m2ofGUZWRJl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qI/6j+WrevFsmUQ2btfpwjpBrEeDvOI9JFxcDGS5hN+C2/3UY6rOm9UFkMtPdnFw0DsV3KADWvYmQIJyhLyFinaugsVnyJnUMmW+gnb4PKMnPSP7yFdk+3ume1ndz7eG1m38PjP9opR3R7exGJlsQXQt4ceb00G7OXBfHmxVa4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmEQkRaP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48039fdc8aeso23829305e9.3
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 05:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769435963; x=1770040763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XVJ9Z68aHKVQR5TvJwQMXLNoEmAsqHmqBFFlgBpron8=;
        b=SmEQkRaP1HoNYe5NC4uTLBVG5k8MBY1ls9Fgj5Fh7FMU5Go3aqgMUFhpGoOqKtsqDW
         3dTUgqHaYx2jIuqvv1s1a0949e7zTLUpkAft4l8muqtgblldsOJ7BH7l37nNExnWzsmy
         fIMfJRmvOprcodQArhokmQgj0NsEMWwCdzIFxNJxNg1Stfdyjfjo1ZifN4sIf8xzs6VQ
         z3gDAFwmlE9aKf7iuLkZLWfbmF7av142kC6k1O2yQ048KWuQScHtyrqhRxOQQG2h/jsF
         zEbL51gsoNmck/YnAVaiuyepSSEX/v/oDuejObwJrRa+VnEoXVWV/XfQlPGlPcK/vzmd
         tKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769435963; x=1770040763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVJ9Z68aHKVQR5TvJwQMXLNoEmAsqHmqBFFlgBpron8=;
        b=ghh5SxKGWlnT6vHeWYlkAoaItwfROlrev0yrr6D+07wRQonIYQgfrTvmWWMx94lPgu
         8CiZf1ImdTFV5SiHGNKDvFGL0xNPlgCiqcBuQrCHALUTLZeDj07cJiB+fPiAkZnjdxfd
         P+bn0DFr+NsOcniR5MaECNFSghOiECVbyAkKpo2dOM439gAOhlkxigrasUytXMIBsZyw
         P7D6PKC5W34tAa2sNFYUpvtopGVnXiiA+n8/depEKrS2DM/Yxn92qQ6pVL+wBbQxuS8D
         ZoCTNp4CPbFVCR6Csreath3zLIzrNUZaPftZogRKrYbslieZtlUVpn/LyP0XjefK4Cvm
         Trdw==
X-Gm-Message-State: AOJu0YyM5myWgvnR2o1vuRKJsLcbheR/qniu4fXdvrM3/49xa1DvJEIl
	JVIqBZQ5rkpzFxl3zYGC98kL/v/bai5UoWHNuBjMO0i2nFtnBWOgbozifmY2vxLIwg==
X-Gm-Gg: AZuq6aINiny7k3OhbsnX2tjPQaW3qDof1r1QeiSjH8BnaGSngLPYWIkp5bwdiJ1VOts
	X4SOYaBBTBkuZR7p460VP0BndQgzs9dGGgO1O3NUY0a8TJRhRKP0b4Rqy0lfhxgpW/c4d3aYYoS
	7pZMnT0NSXsYXyGLr4DYBOzp2CzGlfRyEFXGoN5k/yUax6CzwrZyI0OEb/21jdu6wpBxfX3RbYl
	5amkLiGeVMCf5tOonQWO+hf6z1RK+WvTuqgcCRzpoL+C1Ud4OdTohMdajoUPiewVygiJ0YznCL7
	mSEoKCD4XsoU0kHv7zzXVwQNE7XPTwjtxHtVOX7W49y5cNA9SChO4R1+YVNI8y0QVWFlro3clmz
	kEW3Iyqx9q4Ssxmu3YIf0Xsx3aqKkeo5qPeTR25Vmqw13Xe+9isV4YlL0ky2CXiGY5x7Zi1ya1X
	ckYW38jwc5IoLeJGY=
X-Received: by 2002:a05:600c:828c:b0:480:1e9e:f9b with SMTP id 5b1f17b1804b1-4805ce4e740mr82914185e9.16.1769435962638;
        Mon, 26 Jan 2026 05:59:22 -0800 (PST)
Received: from localhost ([2a02:169:c21a:1:5aa8:4ea4:a58b:fc48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d5f422csm109898745e9.2.2026.01.26.05.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 05:59:22 -0800 (PST)
From: Tomas Hlavacek <tmshlvck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Yixun Lan <dlan@kernel.org>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Tomas Hlavacek <tmshlvck@gmail.com>
Subject: [PATCH] net: spacemit: k1-emac: program frame size registers for jumbo frames
Date: Mon, 26 Jan 2026 14:59:19 +0100
Message-ID: <20260126135919.77168-1-tmshlvck@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,lists.linux.dev,davemloft.net,kernel.org,redhat.com,google.com,iscas.ac.cn,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253494-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tmshlvck@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE8D189394
X-Rspamd-Action: no action

The driver allows changing MTU up to 4K via emac_change_mtu() and
allocates appropriately sized DMA buffers, but it never programs the
MAC_MAXIMUM_FRAME_SIZE and MAC_RECEIVE_JABBER_SIZE registers.

This causes the MAC hardware to reject frames larger than the default
1518 bytes, even when larger buffers are allocated. Frames exceeding
the default size trigger jabber errors and are discarded.

Signed-off-by: Tomas Hlavacek <tmshlvck@gmail.com>
---
 drivers/net/ethernet/spacemit/k1_emac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index 220eb5ce7583..31b1bdb2827e 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -228,6 +228,12 @@ static void emac_init_hw(struct emac_priv *priv)
 		DEFAULT_TX_THRESHOLD);
 	emac_wr(priv, MAC_RECEIVE_PACKET_START_THRESHOLD, DEFAULT_RX_THRESHOLD);
 
+	/* Set maximum frame size and jabber size based on configured buffer
+	 * size.
+	 */
+	emac_wr(priv, MAC_MAXIMUM_FRAME_SIZE, priv->dma_buf_sz);
+	emac_wr(priv, MAC_RECEIVE_JABBER_SIZE, priv->dma_buf_sz);
+
 	/* Configure flow control (enabled in emac_adjust_link() later) */
 	emac_set_mac_addr_reg(priv, fc_dest_addr, MAC_FC_SOURCE_ADDRESS_HIGH);
 	emac_wr(priv, MAC_FC_PAUSE_HIGH_THRESHOLD, DEFAULT_FC_FIFO_HIGH);
-- 
2.52.0


