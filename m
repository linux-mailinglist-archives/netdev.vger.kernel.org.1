Return-Path: <netdev+bounces-302434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FEPwCQ6qQWrutAkAu9opvQ
	(envelope-from <netdev+bounces-302434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 01:11:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE49B6D53D4
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 01:11:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OaVqy7Mf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302434-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302434-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C242302D0B8
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 23:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C265374A13;
	Sun, 28 Jun 2026 23:09:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB54374E63
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 23:09:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782688191; cv=none; b=UWWf8iyBozTglKB2rO+6vRXQR9NvXW9HFuJFXfzFsjfhnqw72DP2fTm5YVqgG6ZNJSkczs1+fqMiQkHCCxdTeQQpZXShGE5y02mwOcCjktDzvHWWAmkwutwNfQ9aOFXx0A1xTBw03ieKJlIkECk8X3s0sPCJ3xWJ1gAM022BoaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782688191; c=relaxed/simple;
	bh=pgzcKYlJVil9kefxceGW45ZxZj82Frlmo2ozp8igyRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKv3BkPhUE4DBDexwdk0WiUdXpxMtCmmtfikIQjJqIBWe71tumXQ+jNHx1yYN082Di3Kcceb11TaPbbXKlHnYfmWEDBk0q1Evk3yzirNLOJMQaBJf3ZFQHsZPKdeR9NexDl/njwodUCUyCC15dJRY23RxHhMZ8ul87je2btvMzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaVqy7Mf; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37e4098e920so874238a91.3
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 16:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782688189; x=1783292989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsUunEzMvfoSD5miqaR3mLdOKOwRKoQGXpU7oQBkiQs=;
        b=OaVqy7MfqnpxQrUMAj6hEJNo8XDpkSdxX7OXIUBS/MWUYfv0wqXeCvq2mMqPJu00xO
         yI9eZcvu1dlZiPL8W308Ehz51PoTQcprt2/haugFlqcGcV8dwDt4xyuT7d5t+CZJxXgK
         o/uaqL9WL1+jzjPa/W7FrNjDUjBnnmN2AkEzmgvAFhzgu3Qe058t1H78Q0mdvu0jt++N
         r7EhOfn9ISFUJtHWA6PsAHhALLhobxFFppjLaMMA3/k9AKprUdXkaVF74nER+17JGuzO
         s9wmQK/0iHwB6K8gk2D2CzcEicG/trXs5ExMUoyeWLUb7db++QUU49BMS+1MLLouppzN
         zlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782688189; x=1783292989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DsUunEzMvfoSD5miqaR3mLdOKOwRKoQGXpU7oQBkiQs=;
        b=LJU7VkD6JQOiEHV+dhRM2ZmXyv8mAXOA5VGjJFXlpootpwtezUBPB78TUbvxEgyQJX
         qzWa59VtE6kMJjeeyfeMUftGUqgo5K1b/oLIoVGUdNPBDUhoeW4Y0yalaqPnqIYcvi/M
         j/dQCTyI1dD7a2Y4NJneveh8fmDpmcq6EwAK+U2sBljENZ2cLDOvU+cVc+1DabqObuTF
         4ahp/67sIww+sjVgNzAGGoMqspBBWfb3EodRbyqwDc3imQ3IAwjMKdGUjZ1SjsyEzQS/
         T0Z+rt82r1Pnf53uvN8fw+YO59beADxsD9cxa5gr8T2SI5v9pxH3APIpcNMFzqzK9ux0
         gAFA==
X-Gm-Message-State: AOJu0Yxy9F6dBD/Msgu4vZXNJ1tsO2RQyztMubA56PkoBogcasIp82P+
	fDYC03hNBA3fYzWAKqCCBK2cSqz6PIJQonOrQ7nWjfpUQKQC/1gjW2o+hSWzBA==
X-Gm-Gg: AfdE7ckpgD+qonrtrY7Mrm04gIVTokGMATWDE/U2DIYfHELA4JVJnaTlqgaaXq3csSk
	wv0NuP5MVCt4PCA7DhygW338C4J0FOyDgD9RWFT7GArdVWHwwB3Tzb0qKNTbCk8tHpkNQhEYlYu
	/rgmJ/byKOe0oCQkWpcptN2ujp9ZGvTKbK5yQUQk9efMBl0ey3OwE8fU5j0JKLjEML8Mxbg+t7v
	apMLL4bY6P9Xs06fJ0Y2y27zTM899rrBkVo4zVCsB4st4MJ1KeiFxRyUACLrsA1wxpDo1ZZTM2I
	238gaSVrhlo+5yvHh5/XTeyNYs7m7mm009QgflG3IPoAKREKiLg6tjYCfnssVrayYkH8sPwlE1Y
	W7F/V3wMvJN2zS2oWsXWBHAJ6edJHUmciTwUhMZsos5r9pW7iEwG8rTqE6RYJKrVpWFXY+UJRdC
	Lj2IB6MzFiw7YHJn/SyrEk2xwwxFQ/Wv0pV41MJd5u9zP6m+ZI0MLeuQA/RN8974TvM4JC08Cbb
	X5ttNr5Og==
X-Received: by 2002:a17:90b:5826:b0:372:b4a1:21d8 with SMTP id 98e67ed59e1d1-37dfa235fc9mr13498743a91.13.1782688189129;
        Sun, 28 Jun 2026 16:09:49 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3800b9c834dsm606960a91.6.2026.06.28.16.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 16:09:48 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] net: ag71xx: remove MMIO read-back drain from register writes
Date: Sun, 28 Jun 2026 16:09:43 -0700
Message-ID: <20260628230944.1244501-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628230944.1244501-1-rosenp@gmail.com>
References: <20260628230944.1244501-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302434-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:chris.snook@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:chrissnook@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE49B6D53D4

ag71xx_wr(), ag71xx_sb() and ag71xx_cb() issue a synchronous
ioread32() after every iowrite32() under the assumption that the
write must be flushed to the device before any subsequent operation.

On the ath79 on-chip MMIO bus the uncached __raw_writel used by
iowrite32() is non-posted - the write completes before the next
instruction executes.  The extra ioread32() therefore serves no
ordering purpose and costs at least one uncached bus round-trip
per call.

Remove the read-back and the associated comments, leaving the
barrier that iowrite32() already provides.

Small iperf3 improvement:

Before:

[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.00  sec   343 MBytes   288 Mbits/sec   32            sender
[  5][TX-C]   0.00-10.00  sec   341 MBytes   286 Mbits/sec                  receiver
[  7][RX-C]   0.00-10.00  sec   183 MBytes   153 Mbits/sec    0            sender
[  7][RX-C]   0.00-10.00  sec   183 MBytes   153 Mbits/sec                  receiver

After:

[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.00  sec   349 MBytes   292 Mbits/sec   28            sender
[  5][TX-C]   0.00-10.00  sec   346 MBytes   291 Mbits/sec                  receiver
[  7][RX-C]   0.00-10.00  sec   180 MBytes   151 Mbits/sec    0            sender
[  7][RX-C]   0.00-10.00  sec   180 MBytes   151 Mbits/sec                  receiver

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 1def2ad4c5ce..77f8e75e98ac 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -397,11 +397,13 @@ static bool ag71xx_is(struct ag71xx *ag, enum ag71xx_type type)
 	return ag->dcfg->type == type;
 }
 
+/* ath79 on-chip MMIO bus is non-posted - iowrite32/iowrite32be completes
+ * before the next instruction executes. No read-back drain is needed.
+ */
+
 static void ag71xx_wr(struct ag71xx *ag, unsigned int reg, u32 value)
 {
 	iowrite32(value, ag->mac_base + reg);
-	/* flush write */
-	(void)ioread32(ag->mac_base + reg);
 }
 
 static u32 ag71xx_rr(struct ag71xx *ag, unsigned int reg)
@@ -411,22 +413,16 @@ static u32 ag71xx_rr(struct ag71xx *ag, unsigned int reg)
 
 static void ag71xx_sb(struct ag71xx *ag, unsigned int reg, u32 mask)
 {
-	void __iomem *r;
+	void __iomem *r = ag->mac_base + reg;
 
-	r = ag->mac_base + reg;
 	iowrite32(ioread32(r) | mask, r);
-	/* flush write */
-	(void)ioread32(r);
 }
 
 static void ag71xx_cb(struct ag71xx *ag, unsigned int reg, u32 mask)
 {
-	void __iomem *r;
+	void __iomem *r = ag->mac_base + reg;
 
-	r = ag->mac_base + reg;
 	iowrite32(ioread32(r) & ~mask, r);
-	/* flush write */
-	(void)ioread32(r);
 }
 
 static void ag71xx_int_enable(struct ag71xx *ag, u32 ints)
-- 
2.54.0


