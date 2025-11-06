Return-Path: <netdev+bounces-236388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF41C3B81D
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 14:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A126D1A42267
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 13:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD5F335BBB;
	Thu,  6 Nov 2025 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+nzBUd6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16D53043A1
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437508; cv=none; b=RYzijwRGWpgK5N31NW6MD/dS84oEPR1J7nYz1iFQZ059lgmQsaT7DE6nuyJsNa91lpm7LKOmTUpnUILOUob9HE8XOU0y6Yr4/wTVOVC2hWcFIQaW2YJQrhoCsIdMgwNO6EtP7UsTXbuIxCeu9mut99ScJxe9G7oUSlso2+OIW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437508; c=relaxed/simple;
	bh=zrM2PCMHTJ+hS4n00Wujxh07B+51gM7047RGagXqk+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OjKc2bVapFmOXR398XoDy+E5xFNrd5vYSw2F7c9C4w88kheRrs/pRjvSceaHQFMcKZA45wOZzOhvuKw60U27a5oWsOroV6cYTLmqmdSMpFgNUynpuzrIb42utJFB+ZRyPB+lolTQ00SIobUQud+N20bAOZdWv3hdh54CTVeNSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+nzBUd6; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-3307e8979f2so191787a91.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 05:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762437505; x=1763042305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95xsXqtqpxl4DVLujugvMY+qm/mCPkORVkUJK+NXUMI=;
        b=O+nzBUd6+r9GxAqI32uBqtQmyEBhnQE3u+EoZ0D/4Wd/HXpWS5t4UorVeRlex5VW8p
         oJWb6qhWSczZzyJvaCkeso4buVy/8erhpvVZXKJkWrH2Ltozq5LC9L0Ye73Y+K3xO6Zb
         7NMUs/oktERoFqSIcqHpDIUDZ+THVPIQmNG3IY6hf8RPfHZh6quHEfzGQdTy5gcSBMic
         GBIkTsONaVYyzXGqG6vEWBVPRLIjHRsCFyh3BHP4s5WCU2BxWWBOzdSDox+jNOdhM6Zs
         sLlNtywhbnKofX4yOupyZRwEqtONIHYr5SnZIW5rSlmo7HspSgj8+1z9M8TsHBQKa64O
         kbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762437505; x=1763042305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95xsXqtqpxl4DVLujugvMY+qm/mCPkORVkUJK+NXUMI=;
        b=Gvb/RQljsgQ4dOpdEkFsE+TXAPTOIMZaxU1Gem9StDLhB0FmXgetmhTzSyaLnrNbnu
         gR+IdVhdsr6n2UQOKDDGfXyl0fiWWC/4oLRrjZd53k6Bt/zaVjnyVCCgxolVTbjj+26g
         F8klXMfgLfo0eKEoCnT6mZViwon/LGmzN8oVS8LJXJUnELTGaHod5rrAKmYNOdSJi2zJ
         VRHVTFAn8kbTpRd40ll+49UUeh1J2Dg839/YVASOBFr0RJDzWnEZzkAolB5+Bv0jNRP6
         XPnLRIYcAbhwW6N2dlqs+NL8XFhpEbXJcNjnHNbABuVoqBtmLPPOcq/zWZcfm4VC9WzY
         K/eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu0Ruq7zhCTunz23vj2AfMpDbAnOulDOjKoue7OV8rCxUtFH5aEGfuW50Ix/faFm5v93iEVhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfqOcE1AjhIxpfootrUXKfqiL5nYIBc4LGsUaBigp9M9CubiMz
	sBTD3oG/GNgyWUDJsWGrKeP4sfQ0w0dzsuITvW+MVGyCgjCO1sY6ba8m
X-Gm-Gg: ASbGncvyUB7EcTNKHglFUd4j441iG5xsvwHvtp64zt4QD9g2S+e25SIzW67yxmHTINW
	SSf38JdsIuM4i+KFFC0XicyyYh8H8oV8j3NMVkvM9D1BV+eHOvNtTW30k0/yH1qAWakJq/UPApL
	s2wIcxpHu7w/RtwY4x2moqsw7JLUJitHLDi1vWLQxs3cHrc4M3NKyY+Dozz1oayRxqbSoxwzsuG
	gKT4IxZfmJiX4LM4iq42O+Lpq0ndd3kd+d9EqKlOzpOAR4ntohI1hYhTkoaFO9Z/WReVwZhT/Kt
	E+Gzh0K31Q3Mdlpl3k85as7GxMNynVOYDxMg5aY96Haz7J71+PNSGgIBZAnTVG15NJG8v4grTCQ
	C7ldIfhPXGh/czZSGSMIG3pZqVJkeJKuOeFqdWOv79d4TWea7ViTciUB1uoOfsVAn
X-Google-Smtp-Source: AGHT+IGIBN1A6WXIAp5cV5s9HGkIYojkGlgq6bso3e+lR+1LOUXP0gknbBO0nEL/1V/95+m6CD5B4Q==
X-Received: by 2002:a17:90b:4c4f:b0:340:b8f2:24f6 with SMTP id 98e67ed59e1d1-341cf343082mr2159229a91.2.1762437505042;
        Thu, 06 Nov 2025 05:58:25 -0800 (PST)
Received: from user.. ([58.206.232.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68bf37bsm6439593a91.7.2025.11.06.05.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:58:24 -0800 (PST)
From: clingfei <clf700383@gmail.com>
X-Google-Original-From: clingfei <1599101385@qq.com>
To: horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	herbert@gondor.apana.org.au,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	steffen.klassert@secunet.com,
	eadavis@qq.com,
	ssrane_b23@ee.vjti.ac.in,
	syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	clf700383@gmail.com
Subject: [PATCH 3/3] net: key: Validate address family in set_ipsecrequest()
Date: Thu,  6 Nov 2025 21:56:58 +0800
Message-Id: <20251106135658.866481-4-1599101385@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106135658.866481-1-1599101385@qq.com>
References: <20251106135658.866481-1-1599101385@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>

Hi syzbot,

Please test the following patch.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master

Thanks,
Shaurya Rane

From 123c5ac9ba261681b58a6217409c94722fde4249 Mon Sep 17 00:00:00 2001
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Date: Sun, 19 Oct 2025 23:18:30 +0530
Subject: [PATCH] net: key: Validate address family in set_ipsecrequest()

syzbot reported a kernel BUG in set_ipsecrequest() due to an
skb_over_panic when processing XFRM_MSG_MIGRATE messages.

The root cause is that set_ipsecrequest() does not validate the
address family parameter before using it to calculate buffer sizes.
When an unsupported family value (such as 0) is passed,
pfkey_sockaddr_len() returns 0, leading to incorrect size calculations.

In pfkey_send_migrate(), the buffer size is calculated based on
pfkey_sockaddr_pair_size(), which uses pfkey_sockaddr_len(). When
family=0, this returns 0, so only sizeof(struct sadb_x_ipsecrequest)
(16 bytes) is allocated per entry. However, set_ipsecrequest() is
called multiple times in a loop (once for old_family, once for
new_family, for each migration bundle), repeatedly calling skb_put_zero()
with 16 bytes each time.

This causes the tail pointer to exceed the end pointer of the skb,
triggering skb_over_panic:
  tail: 0x188 (392 bytes)
  end:  0x180 (384 bytes)

Fix this by validating that pfkey_sockaddr_len() returns a non-zero
value before proceeding with buffer operations. This ensures proper
size calculations and prevents buffer overflow. Checking socklen
instead of just family==0 provides comprehensive validation for all
unsupported address families.

Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of
endpoint address(es)")
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 net/key/af_key.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index cfda15a5aa4d..93c20a31e03d 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3529,7 +3529,11 @@ static int set_ipsecrequest(struct sk_buff *skb,
 	if (!family)
 		return -EINVAL;
 
-	size_req = sizeof(struct sadb_x_ipsecrequest) +
+    /* Reject invalid/unsupported address families */
+    if (!socklen)
+        return -EINVAL;
+
+    size_req = sizeof(struct sadb_x_ipsecrequest) +
 		   pfkey_sockaddr_pair_size(family);
 
 	rq = skb_put_zero(skb, size_req);
-- 
2.34.1


