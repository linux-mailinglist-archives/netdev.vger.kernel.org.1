Return-Path: <netdev+bounces-230752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F970BEEB31
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 20:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CE91896BC8
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 18:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30A5223DE8;
	Sun, 19 Oct 2025 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="OWs4dy4Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411A61E260A
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760897675; cv=none; b=K4BITmIkL2fkKJ4yGQmZ8i21UqwmD4EaS2fUpzC1Jas9xaN0c9z7VV2v27ZF6calxm3HcMfNSIVQBSOSL+Ntg+U3KffKOM97oglAsMoQRWWN1NZLEqP8BsrXTgIL8xtAuPqUD023fXKwx/PXJrvb+JhQogMcuS/RUr0/RvNHYlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760897675; c=relaxed/simple;
	bh=OWtMsh2PHY7TNTIpoc9gwrfTC7Jvnu9TYnZe5lQxTZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EeUYcr30e0xZd8y+cscX92AD8xADJyg/jzV8BZeKIfdrrILuKxsicFAJySdOTQA7Nw/dMqKSxC/cjJEexjKCz3FXJMrveoDt9iYvOuM4+LEedjESZWWsJ9pdVevhtUVfxURM5Ew5+N9O47x0pkLtmm/c4ONXih7rDWW5CuJm/C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=OWs4dy4Q; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7811fa91774so3128778b3a.0
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 11:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1760897673; x=1761502473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IaENTQgKFPGammTZmywdQK3pf3FhrMcENBDsOJC4YvY=;
        b=OWs4dy4QeR6XTePSvJuyrmM80uiOBPdwNIpFx/EeF2TRi7o+yJ42pF1DQO8+ARyKsq
         ip5ZYsD0gNonRq/QA2qfGH6i6uXJI8HOHgoqzStpICpbM4KP+N3tVLLfE+NfnmEYkXj/
         75q184H2FNnZVaDHKnesyMN9+qmZGU2zyeMD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760897673; x=1761502473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IaENTQgKFPGammTZmywdQK3pf3FhrMcENBDsOJC4YvY=;
        b=w2HHr5AsNPVYma/HyaYYPYbPCrpuaWdD33kqEChNMKk7w5WxBtgeaybQIxpgUqSctM
         4YJsoXEmKiPyhR9jAo3PEWx+bhrtbzrjnGYYZOapujM7Su+6lIdIn3rqvQVFfNmuQAHm
         hxWIFzY1Zd0Ib2OG4554hPGCYAsQBIV4BvAGcUhZzUEMhJNWNXXhyJ9Daif+OSOjleXG
         FS/31qXeDp9pcemGOLo6o68fSfsjB1zVeNhMkWWUE7S/8u2FhmUFJTmVwRwOTXG36fTR
         zTYWhmoiOK4E0hAFwAw+NIpxwHxKGrvc9uJNGg6vltn4KT3yYwxhoYqDbX1O+KcUzjuG
         ULRw==
X-Gm-Message-State: AOJu0Yxs9E2OzGlIDjVTAbPKG0GWdVThfzzuceXBYO11Ztv0jI84p66w
	KiAMrxseByYVze6Hy0nvz1bG5IDfGqMRxkbCjg90UDFUpKEc9x6sq5tEQ4PlC2uk2CubvNFqk2N
	jdFKhQFeZCA==
X-Gm-Gg: ASbGncs0C4fsrkQok1fk56q3HbtvooyjZK9z/Dv6cCT7wZ/J78FlMooUM72EFjQw/jF
	3YdyA3lq2ugIfq2DlBlMQYVpcCiCeNb43hiFSOpzSigYJP8UsXiF5eLMvLcVCynYwrndtDHS40Q
	LzwpdOp2NdxRdZz3KgH3JaZoz5ZvfaCXkkdpXa01yId5WhECO0riUs/TudSt0Xo4NRca60/NnIa
	Adfr8b9l3mV5DYmLy+oeA3hKUnrLGfdUBFhCCPjjmESvXcZ0M8Z/hXEFfVW8x5E9/Udd7nDneWz
	FcdOkAECqA97G3mP0dFPzaC1tCmSXLuZjccy3g+k7auPmf0TxBwcFUnKeWja0Z27vWX+052E/QF
	JVp/eX3diLbFaYwt2dhr6UxdCvd5wqUQXP1eZmHR1rgJ0vPsRJptWzg3oZNbclLbUmWh1qW3tTe
	mmrMBIvnm59H+VBNqvQwuw6j8XoSiPitFW2qSMaPV4OAuTHg==
X-Google-Smtp-Source: AGHT+IHzvUrSCJm2EvmnIvQwP7xjuydc12UxhQNsagqenju0dOYpSJfg4ontGV6/TgRQJcjd0gFp9Q==
X-Received: by 2002:a17:90b:3d8a:b0:32b:6820:6509 with SMTP id 98e67ed59e1d1-33bcf8748b5mr13820446a91.9.1760897673018;
        Sun, 19 Oct 2025 11:14:33 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([110.226.181.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de2f94esm5882328a91.13.2025.10.19.11.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 11:14:32 -0700 (PDT)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: netdev@vger.kernel.org
Cc: david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.add,
	shuah@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shinta.sugimoto@ericsson.com,
	yoshfuji@linux-ipv6.org,
	nakam@linux-ipv6.org,
	linux-kernel@vger.kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Subject: [PATCH] net: key: Validate address family in set_ipsecrequest()
Date: Sun, 19 Oct 2025 23:44:21 +0530
Message-Id: <20251019181421.107668-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

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
Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of endpoint address(es)")

Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 net/key/af_key.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 2ebde0352245..713344c594d4 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3526,6 +3526,10 @@ static int set_ipsecrequest(struct sk_buff *skb,
 	int socklen = pfkey_sockaddr_len(family);
 	int size_req;
 
+	/* Reject invalid/unsupported address families */
+	if (!socklen)
+		return -EINVAL;
+
 	size_req = sizeof(struct sadb_x_ipsecrequest) +
 		   pfkey_sockaddr_pair_size(family);
 
-- 
2.34.1


