Return-Path: <netdev+bounces-302432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id shMfD8OpQWrjtAkAu9opvQ
	(envelope-from <netdev+bounces-302432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 01:09:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 272CA6D53C7
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 01:09:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RK7a6Fni;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302432-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302432-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC4863002F7B
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 23:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6568A37419B;
	Sun, 28 Jun 2026 23:09:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AA936683D
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 23:09:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782688189; cv=none; b=r5hF+2z6/V76cI3KBgVyrSxb8oe/rRuyb7eUvrl4msQmWMwPOcxuJQ6+tAHbMTvWp5Rp+AX+AIiVBAdghETUnV9JRVrebfTbqX/ubT9LYrj9kEujRe0Eau5EzxQX+BcsxyR7ug21CzQoPMt7LnOsm6YiUTp1uaIhJvbfEMZ21hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782688189; c=relaxed/simple;
	bh=LLwlsDT32jQY7igZz7tUnFSUG1UFdyvJJB6/B4mx1Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qKauZrRGdFzJPrO9n9Y/ezLeN2txngbDRtoaKbGTFwZWnHkM2+SeYpAiFKHCn7QwHQBbairq5a0Pmc7n7VAKtXiFh3pgCJWk0OO+m1RiSw+E0B+w68pNs9BA+W3ZNzoCuid8kkjVkBiFHAT+SSkRftyqErxhXW+gfG/bN6cM3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RK7a6Fni; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37fc01a7835so514185a91.3
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 16:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782688187; x=1783292987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DVnh4LbQ3kz20s2UX3kTG5JB1aSdqwqf5wBEeB9fYHY=;
        b=RK7a6Fnix6/Ii4MAgmlorAEJ4fFnwLP3mzMFkn7FIJIJplSxCj3S6g6g2XgV61alZH
         fJC2iCIGUGMwuUlviVfwWx1vG1uiMqTo6W64qFsCkLKC/MchxMge/WW9fXWF1auYWnT5
         iouetgkBA8JlIuMlxS8igwOtpyvt/MRA0lYTAXXbBQTFOZiXLNVD6cAL69D2ohLkXy7v
         6NaD0I+amcVAK5J7dgqR2GjYkwnmFx4P1MVqqkS88IudPATnapvvvhMHgdOCR9QUT5e7
         YzQEC2Zr1PBzq47rn1pOIzUVhmay1Ywuv+zjqtWuCPlN7Y+XhC4J3rUuJ4VmOAALScYf
         XriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782688187; x=1783292987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVnh4LbQ3kz20s2UX3kTG5JB1aSdqwqf5wBEeB9fYHY=;
        b=WfsS3j2MRFgEFE9/PUhyGFDKyQas9d2FFj+VHCqV/ZvWhCdtYrevyOX+X5r5AD5DJt
         KDB+bEa/wFfre/GgRknPKR/KiRMWjfrn7mkd2KWxncZ3Oq4n2zlr/PzAC1BUayWuBP6f
         dTaf6F5srBl20iilVGIklNkDg4ATdskX83bjCfvez8NtVPCk193Wu2puRnf4DuSSnL/9
         JPT5s6Gh5t65TTEssZ6zTkgE2S32ztg5/HM6jhdAT6A/qvDDaU5/ekX2e4L2EljU+l03
         Ix0qeIxIDNTJpyeNv1MyIGqHWeZL7p5EukSCmIh2zM1lm3NdvJHbu3uZI1NDHtdsuJEr
         7hDw==
X-Gm-Message-State: AOJu0YwKVuV5Z5Zeadq8NA6Wo105+Mras6FUja42dsU8Bt5PcBq/1Axb
	IiCjVmT9Y0hGCGVPiZAfuu3t3VMR9KHyRkp8YA+bu5EYqHwmqVzmTLiYmhvtpQ==
X-Gm-Gg: AfdE7clCFID2x87bdRNvmKYmLFtigtvZXb96+zdGhRfRoLXKDAeGPJBcdXX24K6ngq0
	reNyRK9Yi4qAQPb058sOW99HR7Y0kUrq5Lwpve1Bcf94r0BBUr76Rc1hO8Ahn9CBseCgThpB5+I
	lnMswrVJisVufVsXVMwCbXqQAVHoapmygpqOjnQZjHNZ/L9Bumtm+YPmeURzg/yhhntcy87xBIg
	rHdwcFIDAmHA63JRivQzBKSPffJV2OcWnDQL6iIXbF9ahTGnskVQb3zSycrWsUecBopCEgSq9sT
	u/lkcSVPaO3358kBIv7oXOChzsU2BUkngSB/KKiQAYk+VWTN2Cj7t6M9K/eGfI/x9MBD34mEIvj
	6ohVQuahN3gCX820hcKHClGzcZ5Ki/ucwn23o5rnmYszwPR8wPM+aLHrPxrv8ihINuKpMTYodRi
	G9t91YUmmk1UbZENsZfh3HSd+VXZ/yVeInlL+MC/Cs9Zc68v85cLGLcRZq5gWrAR4Hnv200CGzx
	7EseAFUcg==
X-Received: by 2002:a17:90b:3c4e:b0:37d:ac3a:2f4f with SMTP id 98e67ed59e1d1-37dfa25153fmr13328791a91.13.1782688186684;
        Sun, 28 Jun 2026 16:09:46 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3800b9c834dsm606960a91.6.2026.06.28.16.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 16:09:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/3] net: ag71xx: NAPI weight, MMIO drain, and TX OOM fix
Date: Sun, 28 Jun 2026 16:09:41 -0700
Message-ID: <20260628230944.1244501-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302432-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:chris.snook@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:chrissnook@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 272CA6D53C7

Drop the custom NAPI weight in favour of the core default, remove
unnecessary MMIO read-back drains from register writes for a small
performance gain, and fix a TX stall that occurs when the RX ring
runs out of buffers.

Rosen Penev (3):
  net: ag71xx: Use default NAPI weight
  net: ag71xx: remove MMIO read-back drain from register writes
  net: ag71xx: re-enable TX interrupts on RX OOM

 drivers/net/ethernet/atheros/ag71xx.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

-- 
2.54.0


