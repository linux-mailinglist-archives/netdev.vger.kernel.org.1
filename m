Return-Path: <netdev+bounces-256369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KAqK80tgmnzQAMAu9opvQ
	(envelope-from <netdev+bounces-256369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:18:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A29DCA8F
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13C48301C279
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 17:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3053231B832;
	Tue,  3 Feb 2026 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfkPIK9I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F3E30E0E7
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138917; cv=none; b=XuAbSneQu7op70HWpmrO3NnmqWXC8X37RGTuxjl8a/4vEvuXML1EmO+ywm20PmFKyntqWRM3jVGO+XX0upJrazYwN7OU+Bib/C5DUm/JaazOtUAJLTAm3tspYpr3HpowacfwiNV4XMbvaw93ao0rVWRzKKP3LLucFBi51esgn3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138917; c=relaxed/simple;
	bh=KRb0iP9qT/mRjkBvphytxm5Z8BqLPEO3+/hIbKUjY+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f05oiBPVfHdRg+wjfPLMLvSPi9X5lrNk0oERseC0xEzKqeDIDS5ExfBDHJo1F5glWNOC+06Aju0AkxFrxjPGAuT725RNtuSFcpIjt+M1WdfyimpKP93Q0uRKV2+UpkR9UFwTI0D2HOpb3zgxFXkUw4DCtjOrZ+d0EePiBhCziXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfkPIK9I; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82318b640beso3320739b3a.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 09:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770138915; x=1770743715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsxA1AJP4YlB7qBCtC2YXQ1d9/cM6CmoIs6IA95vh2g=;
        b=IfkPIK9IfckroYbpJEsJnPBuBDYIF08mUQAHD+rQg/RCS4mPFQqZAv9VkYA+VXwiMB
         svxU+RPTv0CNa30nn5vfdnQPFiyrtAQgF+DtBwtN6yFV4PYjMkXBqb+AsEENVmljlgcl
         R6hkaOZ9ABvjhknb7eAGSLtDizX3WHmfkIjeoZLZNz6XrjPu+kxIbcMF2cGHMMB3fCjT
         kHh0m0ny66JkztH08IGyEOS33o37M3vSGXuOqLzc0vEcq3CGVWKJqG6UkngsOTv5DG1p
         8KFxj4E0EOZ51Lqf5QnIUS/VsNYltSEYXwkY7EJgR8FL58gwdWmymO66L3Wukmeogr2V
         dA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770138915; x=1770743715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vsxA1AJP4YlB7qBCtC2YXQ1d9/cM6CmoIs6IA95vh2g=;
        b=Iox0VyqsPH7SV2aRWfMgKKPIqeIkxb10oyDqTzNGZpd+QxkiV8Ww3JgWlwZ8mg2wE4
         lNB0TjQTgPrSZqE2dqtoTT9JXxvaD9rVnJjA1WOeigFjG+G23UeiDbPn+0Jc7833wZzG
         Oaoh3cnQXrbmqZ+7UhzXfBvSxApNkbpycG8hmo2I7FbilVCywQR4DGE4NVobe1sJ7k95
         pNbapfiXo907LOU0zUaHyfT2iPAVeGSHEaY0P9YEgH//ggtxpMwtKXkQMC91dz1LKCRT
         0FgsipuUULj1A52OtFDB6qdXWsAMXlXGy2WcFkygAbDtfYPeb9WhRW8Ja1oKbdhsPRCH
         1VGw==
X-Gm-Message-State: AOJu0Yw7/eyMIZsv5sF26zeZ04OKAgAHQ9qU/OI3FU/E1FK4VXDPwz3+
	wm+9vzSZ51SMDF5Q+46IOEwv/Mi/vfRiCkm+ce+y1i9KRHuGMlrHwwV6wD35vi/G
X-Gm-Gg: AZuq6aKqZVIROD0D++40IWDBlGHZCAhw0cRAGxr++nS5K0tF2MJYuhzVCSJw+f/Re3Y
	WQxdWi2nYNq9E7bgeoQCsO7yB2aa/Hd41PLpheQ2keXjpffy8kOWBvF/DgdGDw1PnhzLz0lVYM4
	DDWBbdEE8WKb1NUGku2QX37YvqzbRTxEmfW5UgnyW9TcgFnVfb9wZRrNE1jPNj9FWVYOIL0xZ5L
	3BFgsYKmQ9+UmLRKz7WJcFljYdaVG7YQEB1jebEE3vCORcH6R+kovpglq8FTvZRq2a4J5HzKMth
	//9MAGncRwSnsCP+fSt0WH1RBj+eYqVYd3T5zvXLDNekaMp551JhaS3L4OLC0K/ItNpCYFdCU9t
	Cyq6UzHxwVsdmKYOuahHkL65vtsS/OLyt5nDxZZAAeDdTMyL4KpsquC28NVl2Y7XiuR1cea/uXp
	w03bau80Ju0ii73RkPyYZC7qJ2+pGJsaXvp8WSFWnx2lA7SFDdcP2jWTmXDk+fCUdiN2bk7WcLU
	bsT3LG6K33o/R/L4xtxR2k=
X-Received: by 2002:a05:6a00:92a9:b0:7e8:4587:e8ce with SMTP id d2e1a72fcca58-8241c78d8efmr86588b3a.65.1770138914596;
        Tue, 03 Feb 2026 09:15:14 -0800 (PST)
Received: from d.home.mmyangfl.win (tunnel997320-pt.tunnel.tserv3.fmt2.ipv6.he.net. [2001:470:1f04:2c7::2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-823cdf6fa26sm11075817b3a.58.2026.02.03.09.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:15:14 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: dsa: yt921x: Return early for failed MIB read
Date: Wed,  4 Feb 2026 01:12:42 +0800
Message-ID: <20260203171305.95085-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260203171305.95085-1-mmyangfl@gmail.com>
References: <20260203171305.95085-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256369-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D2A29DCA8F
X-Rspamd-Action: no action

This patch does not change anything effectively, but serves as a
prerequisite for another patch.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index ce2878ef9b24..b9f507b07d1f 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -714,6 +714,11 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 		WRITE_ONCE(*valp, val);
 	}
 
+	if (res) {
+		print_port_err(dev, port, res, "read stats for");
+		return res;
+	}
+
 	pp->rx_frames = mib->rx_64byte + mib->rx_65_127byte +
 			mib->rx_128_255byte + mib->rx_256_511byte +
 			mib->rx_512_1023byte + mib->rx_1024_1518byte +
@@ -723,9 +728,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 			mib->tx_512_1023byte + mib->tx_1024_1518byte +
 			mib->tx_jumbo;
 
-	if (res)
-		print_port_err(dev, port, res, "read stats for");
-	return res;
+	return 0;
 }
 
 static void yt921x_poll_mib(struct work_struct *work)
-- 
2.51.0


