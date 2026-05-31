Return-Path: <netdev+bounces-293367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFNfEe96G2oDDgkAu9opvQ
	(envelope-from <netdev+bounces-293367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 02:03:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A9E613F4B
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 02:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6DDC53007A5D
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 00:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFAF1FC7;
	Sun, 31 May 2026 00:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFCyUC1W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A118B0A
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 00:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780185834; cv=none; b=KGQuy4eGf422hBQT3XQd+1kdbUztKdlKGW5Rj967sDRo9iRRALAE91NQbICUZCe9myV3DRn3R6Sn7r3Mr6bVrJBVNWoeud6ar/OLh+WlM6cFO5e7MMWjiK6tHK5qsORya6yKW/b7SGG8CyrrN/PMJUxn4pgJnAVeMg+pWhrzzyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780185834; c=relaxed/simple;
	bh=QyBHhcNYCuqZuqlbaH9ljeT9Kq7W+viZwDTY/D6sse0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YGX2elZLstLJIP6XEcVN5k4cll6HE2zJ5qLizQRZT/4v+R/xCSuIGOTUlxCv4TqB5191tIeanINAtgV0y/wLZ153+uWU0xPStPdu5ouwjfFO+3UmK9Sg5xjmKnykNQxyo1jA6hcm0Pu2zmCEzJDQ63VdQrN68qpZEKcw2SlWEa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFCyUC1W; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf30d530bdso14423505ad.3
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 17:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780185832; x=1780790632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iL9btqhhqOWOE8PiDezZ5qlfknrW8Ydi6glTHZIZ+4Y=;
        b=aFCyUC1WNtEucrYRbk5usd/DOEGK/04McSSVYWirM30xjmLHc6DT0FW73YnHMewKdc
         BKwbWcDY5iw/4g9lQmzSzBvM/hMcNlp9aHk/n3OTwWbPfGlJqrIkfvXdkbgAnEU9MjLk
         Yr/nkRqgblmvNwWW2hV6lLe7m6rwEOpq9OMVqNUpb5sCN1GB6m8BD63xiBYq5/eMNNE1
         xKxaWsNreO/ruy+E/sZp6rWmtO/Kksm2GBmwzmbw5F91uDQkc1ZPMC6ctpikyJ/huoZl
         ZbWtqm55LWn15GCqckdzA/mBuRqdKbLjRNaBlkjEA5TjhgX4hJ/1sUaVv43RB4uwCWuI
         UIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780185832; x=1780790632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iL9btqhhqOWOE8PiDezZ5qlfknrW8Ydi6glTHZIZ+4Y=;
        b=E4EjXB5mJMXpCdMD1Kf5Z2EdMIimj5se9aKxiYac+oLDcBheBHfo0rzTBHsXUOgObk
         KWqcpkBzD8lfr2OKxYtvJWrzYZcCcKmMLZY8pxzBU0TUByYMVuv1XWk4EuyreIxYyjkT
         iWGxhO5EQUdAg76vcnf8aBxbltbU2KZjgMKjOKG79PjbpIHCTc0+/0dCri4iztOW2NpS
         IolbyS/JT5Px5V+uc270PKbplLf8JA4MAYBM5DN89DXpz+ZhjbJAz/spSViffOPiFt1h
         0QZMvROwLKX1msbIRC4bfsJS3yvNGZviOccEtiaZEudZ+oI1913iT/zYn6aFjMW+XOd/
         hLXA==
X-Gm-Message-State: AOJu0Yzb12TLCgLsVLy78w9Q4MeKXbBOOyLrJgoSylMn9Q/lHafH77Ez
	iDFRfrY/i04ijeXAYp5Nth6ZtZ3DyMiPf67XSz+vSwbhYVYGOjwCCL/udjV92RPV
X-Gm-Gg: Acq92OEXg6uGwuADnze2D97ZdZnkwBXLgm1qaMNAtLIbyC3/yk1z5EpcwHT1xQZC/0E
	E9nD/0vNZYsPS0r2pWr0ViYsJXvGmiCQNd9yD6cdJsUILGLwIahU5IQr4Cm7MjPaJDmcHpAzWCt
	AWLxoVYKcxekQF0OWvy1CYwIuF5WAHx74135G4USiHEDEKFnPp7FsigdNL9PZ+rUqwE7uK/IcGU
	d5K0eBApQ5CWlwCqtx1jrbP+/VEAZb5r3szEo/8joeqXoBc8SEISp6HiEhJVPD5KHqCamo2K+pU
	PlUA8Ry+EWUlpe687ZVVBnkDDIJBENYyAqfaO/Qvk+JkZu9MbRl0jvjx6r/bMaJgJ1/+ge338MK
	2QxvwNwekWsiNY8SwT/8JhPAFntHq+kQU8yURG/0vl3bMgS8BmAPDmZPPuzYZFpG+qR62GCTDgD
	ybNpPou+hKIGLHo/oN9hCcqAqzOsYTFAtg8glYiZ8cUNIxCKMV8kEvFhaiNfjOfr1iNIdYIjObi
	lCMg2PJN222+dWKxKY+jZHerrslMiQGIGBYesOVZqd12Q==
X-Received: by 2002:a17:902:cf12:b0:2b2:5503:1b8d with SMTP id d9443c01a7336-2bf36779f68mr62415415ad.6.1780185832345;
        Sat, 30 May 2026 17:03:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c30646sm58589955ad.68.2026.05.30.17.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 17:03:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: b44: use ethtool_puts
Date: Sat, 30 May 2026 17:03:34 -0700
Message-ID: <20260531000334.388351-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293367-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 51A9E613F4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There's a subtle error with the memcpy here, where b44_gstrings should
not be dereferenced. Dereferening causes the following error with W=1:

In file included from drivers/net/ethernet/broadcom/b44.c:17:
In file included from ./include/linux/module.h:18:
In file included from ./include/linux/kmod.h:9:
In file included from ./include/linux/umh.h:4:
In file included from ./include/linux/gfp.h:7:
In file included from ./include/linux/mmzone.h:8:
In file included from ./include/linux/spinlock.h:56:
In file included from ./include/linux/preempt.h:79:
In file included from ./arch/powerpc/include/asm/preempt.h:5:
In file included from ./include/asm-generic/preempt.h:5:
In file included from ./include/linux/thread_info.h:23:
In file included from ./arch/powerpc/include/asm/current.h:13:
In file included from ./arch/powerpc/include/asm/paca.h:16:
In file included from ./include/linux/string.h:386:
./include/linux/fortify-string.h:578:4: error: call to
'__read_overflow2_field' declared with 'warning' attribute: detected read
beyond size of field (2nd parameter); maybe use>
  578 |                        __read_overflow2_field(q_size_field, size);
      |                         ^

Instead of fixing the memcpy, use ethtool_puts, which is the proper
helper for printing ethtool gstrings.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/broadcom/b44.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 90df02e0039c..f994636fbd5f 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -2031,11 +2031,11 @@ static int b44_set_pauseparam(struct net_device *dev,
 
 static void b44_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
-	switch(stringset) {
-	case ETH_SS_STATS:
-		memcpy(data, *b44_gstrings, sizeof(b44_gstrings));
-		break;
-	}
+	if (stringset != ETH_SS_STATS)
+		return;
+
+	for (int i = 0; i < ARRAY_SIZE(b44_gstrings); i++)
+		ethtool_puts(&data, b44_gstrings[i]);
 }
 
 static int b44_get_sset_count(struct net_device *dev, int sset)
-- 
2.54.0


