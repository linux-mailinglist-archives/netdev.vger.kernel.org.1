Return-Path: <netdev+bounces-302405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DKazHgJRQWpAngkAu9opvQ
	(envelope-from <netdev+bounces-302405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 18:51:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4166D4728
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 18:51:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=oj45Ka7L;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302405-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302405-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC93F30073FC
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 16:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD8C29B8E1;
	Sun, 28 Jun 2026 16:51:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F71148850
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 16:51:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665471; cv=none; b=L4maDH3vBenF2PVsPEz5HDTXZxppeH5Q3qnva/szFXisp4uoyfpJL1h1lcBoZEUBYk5pH/vH495CBmpQnmeK88AiLP7TdR3vG2em1Tn5l5yh6ocIgOQcSwPyC4TP3q2ZBGtzL/NhORrp5eUZq+sD1FfNg+ObeJHIEXbVViiQOxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665471; c=relaxed/simple;
	bh=DLZAG/jvCuQ64ytJWF+23hdM2Ezj9VMclpD0ZpWkC0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oFXkzNkPkBNUTWkko3smgF+WiYaQ1yi9X9X1NepYiAryExId+uDhts0mei+JKaoJARSc2oNmQaG8TOp1BYm6RMjcSWUPxa6+EAtMf24hPJgkSoTkH6qwccfDR7tbFMAX7LNbhCvE5qti5iWtB7V9pJL5oSWzbaOb3beLfHR0F54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oj45Ka7L; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-472a14c9965so519841f8f.1
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782665469; x=1783270269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WZzhdJwd+CLxmg2Ls3OFaFn+ZKd5IWUX/1g96vuNOVc=;
        b=oj45Ka7LGRJzLtDsp0ktfDcVVC83WK40NJ1Xxne3QvoLcx6srQ8jAWrIrN2Xp/1Cim
         r7z/XYBy3YXeXB5bO8VtUamDQMs0jFvsFNCaIjer7jedPrGc783551ICec1R2DxSO+HT
         +53N6VqCNl7ttvk22aWprIPW0NqtyRA4UkWmMrojhCSwXVkk0wT7BdEPocPtreJLAJ8F
         rrKA0y3UMWwazS13cAu/4/GFr7SW05Ps5nvmlfIrprLTU7bJmzN/WH3fRFqhzFy7y92Q
         T97tWK0F4arPQfFkcHFKfskiIQSOqtMw5u41ebDTp6F3GZVDjbvLYSazkwYaOcsAP3Jb
         eH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782665469; x=1783270269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZzhdJwd+CLxmg2Ls3OFaFn+ZKd5IWUX/1g96vuNOVc=;
        b=iyg27pUTdWq9gjstE/DNvito04iSgRyNsnF1ri0VPYrJd58+XKvT7psI8MFGJtAUvl
         DVGUnyE/JJlC/rR1L1sOeTrPCjMfw/Hq8N+kHN09QGAV2zCH2hS3t6BygyC+o6sjQtju
         ZKLbrBk5znRltuti1iW8f84PU96gikm3KsAQyXfvKmTuJx/89OJqbT9S3Rb7yvMSB9ms
         AA0F+wlHzHG/cfXlvOjsPbjnLlLplmavvK+B5/wipAnNwpwCkIOnmYzTngklVAJaFDYn
         nHKQJJtS+1eUTrMiwJfKSlVs5LMBcifbxG8+D9TCmgx270WS28KfRrw9XqVen+pvUwy6
         gwKQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7uogx07j37dAOvsrqZeYTZgawMrFFtg+e9VzvlCWCFlvT/YK13trV0D9JOrWbVX7cdYGc5YI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Zm/2v4lnhSDODhJ9YNx6z4a9H9ubLpjtcfyPh8/NM6BFpi0a
	7bFu6yLJFFy0Vs3rtpelMK4Q+EQ7mqN4yl4UxkKDUGCAv2xlv1aAk5NQ
X-Gm-Gg: AfdE7ck+O4gVq4k64YJkxSXszk/yzvJgDZsEqP506L5YJVqSxBJyi8FURicqJlt6s1j
	u6ynNXPTFZVYhOE5GYhvalYHqhqupMg/DiPpxWx61adYIEZphPR4QK0+aQGUw7iy59PNROEqW2Y
	260cmWk8Pmpgi0gt6hLTOarCmC0+EAds04Ujh5JvAQslqKRCxWa6gNDw6l17wZwOsNdksPMEb+g
	oLS3fbuwgdT1J1hEA6fGGegvtoROOrQzonZ79QffzAeu/2ZvB6/zVumdGBFdqDFEqE8u/y6SxIX
	mimFDg6j6uOXVV5rwnk9m8sIMwdFCE4Cipghka7s2ly9nldkxxbJuf6jvLK0anEGXTouZ39H6Nz
	0QOpU5Q1j0W2V4sHzwZSSFrXTmxY93evL1FqkKgNjV0E5JeHRl6ZLU54n+lhoDUAiYEJYcfxc+r
	pin0Gc3HPwO3fQppbqDHavku1GNg==
X-Received: by 2002:a05:6000:2485:b0:460:e0f:8d19 with SMTP id ffacd0b85a97d-46dbfe8cd80mr22542385f8f.9.1782665469170;
        Sun, 28 Jun 2026 09:51:09 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-472de944719sm7435499f8f.2.2026.06.28.09.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:51:06 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH net-next v3] net: usb: rtl8150: handle link status read failures
Date: Sun, 28 Jun 2026 18:50:33 +0200
Message-ID: <20260628165033.17842-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302405-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:petkan@nucleusys.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com,m:alhouseenyousef@gmail.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,9db6c624635564ad813c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB4166D4728

set_carrier() ignores the result of the USB control transfer and tests
the stack variable supplied as its receive buffer. If the device rejects
or aborts the request, that variable remains uninitialized and the driver
chooses an arbitrary carrier state.

Leave the existing carrier state unchanged when the link status cannot be
read. A transient USB error should not be treated as link loss.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9db6c624635564ad813c
Suggested-by: Petko Manolov <petkan@nucleusys.com>
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/net/usb/rtl8150.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index c880c95c41a5..d51e43170e03 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -732,7 +732,9 @@ static void set_carrier(struct net_device *netdev)
 	rtl8150_t *dev = netdev_priv(netdev);
 	short tmp;
 
-	get_registers(dev, CSCR, 2, &tmp);
+	if (get_registers(dev, CSCR, 2, &tmp))
+		return;
+
 	if (tmp & CSCR_LINK_STATUS)
 		netif_carrier_on(netdev);
 	else
-- 
2.54.0


