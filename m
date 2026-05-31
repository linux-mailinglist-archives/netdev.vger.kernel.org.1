Return-Path: <netdev+bounces-293366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7t6IDkN6G2oDDgkAu9opvQ
	(envelope-from <netdev+bounces-293366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 02:01:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88474613F24
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 02:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A383302A2C3
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 00:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B05B286881;
	Sun, 31 May 2026 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/h5ElXC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0962265606
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 00:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780185663; cv=none; b=NbUPbildyl7RZQYrA0D3/COTITtb1JFF2fTZMq9cwBvQxXZi6Tiq4rPnS7ik0ZrKAHrqInNNH1XMpa94DDtAUE75g6QA4R0ScFe1e3UeebDHBihupJ2gncFJ89JEs4UtFUAnz1CFaKEaqAkADLJwQ4fqmG7BmpClYiPp56fXL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780185663; c=relaxed/simple;
	bh=zh/J5O9cbpUUOMNdVuju+UqlCfC3OlTpS7JetQPYw3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BJkYAA0VVsfTqD+4Ekm8DqxmHi4GGi2iW7qSfx3P7tm9ngCusYHaMm1S3moohR3Q8NioCqsnyMYV6V5ROnyjRtCSddssBewZYzJW6V+h8bbTKbpoyp4vzfUL8P8ijkdTyL11lfCKUl9Bg1FXPjQ+TM6YvpB73mJbooGF2Ba9dW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/h5ElXC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0b944f6edso3701745ad.2
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 17:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780185662; x=1780790462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z9xBFzOHM8JQ7cF0W3FG0+6As5LbaCUbhnxVDSKZaKQ=;
        b=P/h5ElXCpBAPWTRJHyh/tIMm1+DNHjYywWak53QCoFzv6qmU4cl6B2aunNbPJrVMiU
         YHLX9sJT+zPjJoEaVSdrShGEr8lVu8UZHdICSehm4DdmNtJv3Jy5SOlc0MZazuQGw+Xd
         qdgl6DHtxhkgHw3WINLAHMyuLjb3PPHGpriUj1xKxVmO/Y4qJ/eqXstSbChpEPNB/TYa
         eKFB/tgQHNeOdTArhpfUhETV6H560AVMD1/rxRR09E8nVyCkhnC7qTmgUQXn6Xd+vDZy
         bK2NaLHOgqw2Y8yVtHQsWYD13h/rNgfOgDsV8Rv99GxrIOQCZtQR7QflEBW4Ztgm6Miy
         Ol3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780185662; x=1780790462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9xBFzOHM8JQ7cF0W3FG0+6As5LbaCUbhnxVDSKZaKQ=;
        b=DOrWLUSHArGx5gY7OoCkpLGseUoKpCp5BhtS6sGGZ8DIl5YeMuvnuQ1BvyOj2PIIMb
         TzISDDsW1jeaHTgvCfQLUyTVat0pQCFz+UImZXCrmtlCUcslAVSot6ezUYDqU088NQkC
         5s9+29O4EkdosASSKDg20ABf1YIbs2B3mJBY/77W+aDuLSzsxvr6pH2JEXHVT3DU4D2R
         UVuFgy0vfIA604VBuki80bW+VkpA+CXqXUvAar/9ZmCGaJAEKzvj/NyWEpu23o/6BQcM
         XKrEO0siTUHyUHKt03CHExdcVlHDBXOaV7NgznmN+RgWfIqc3WgLd5vqb5oUjuAVSu4K
         KSOA==
X-Gm-Message-State: AOJu0Yzj6c6R+LZizzSMbmZPG689Z56RR43zXZbezTLBWih29vk7bdbg
	I9hbm9eBwiPanuTcVbJqKclcjxlXbI+RaWs7JXMRw/PWta41udCl0KWQR/qoMX8a
X-Gm-Gg: Acq92OGAHSoa348JYdi9EfgviszsnEG37px2AEDdSqN5JgrUIAbziCu1+PM6leirkng
	4BqkhjDiqB0Fl0MDMhQVdNYCHqX9DyFFySigp7kGKY/gSmrgBuqwtQuAIKdaRurZE+Y5E0hLAcd
	2Ns0AZWgqmiuWFtDf7RlMKQSsz1uRAhmDZGr7pFoC7Fbabh3GQXA1fhp7dxZJvrRg0Sft0umQbk
	GVifTx0xzfP0QpsvcwCpG+NCWqnellMLwuU2Vtkk0cvLmObWbEzdm0bUnONZCcwgxvwdyLlfkox
	wLZ6Kf/WW8kTnU/BKrXa9khfSw1EKTdxMmQTBqVgTlbf1SPHGD2I69ZvpHjE3Z59yr5fJOIfpeB
	di2bnNm5ZEYxjzgYAtBIhsa2qnOradN+ncQkvL8XkMEZyjERfHy5z2fXnz/BZNAMVNTaUdhrIii
	KQsHXiJVWS7EWKIwH2OfbbTXzRbOubBD7Vh9BAkXsHE4WEiBcFfe5Vg0unrxhEqHbERK6Iy+nh7
	P8dujfSn+pul9k9CrzH2qmSuCKZnNqlwzCiaAWZdLmJwQ==
X-Received: by 2002:a17:902:cf12:b0:2ae:ce35:2686 with SMTP id d9443c01a7336-2bf36779df6mr63872475ad.5.1780185661996;
        Sat, 30 May 2026 17:01:01 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e71cbsm59106165ad.15.2026.05.30.17.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 17:01:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: fec_mpc52xx: add missing kernel-doc for @may_sleep
Date: Sat, 30 May 2026 17:00:42 -0700
Message-ID: <20260531000042.369043-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293366-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 88474613F24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the missing @may_sleep parameter description to the
mpc52xx_fec_stop kernel-doc comment.

Fixes: c35a0824e88b ("net: fec_mpc52xx: Replace in_interrupt() usage")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/fec_mpc52xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx.c b/drivers/net/ethernet/freescale/fec_mpc52xx.c
index a770e7edb1dc..4f555bc13ddf 100644
--- a/drivers/net/ethernet/freescale/fec_mpc52xx.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx.c
@@ -692,6 +692,7 @@ static void mpc52xx_fec_start(struct net_device *dev)
 /**
  * mpc52xx_fec_stop
  * @dev: network device
+ * @may_sleep: whether the caller can sleep (e.g., to wait for tx drain)
  *
  * stop all activity on fec and empty dma buffers
  */
-- 
2.54.0


