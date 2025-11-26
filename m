Return-Path: <netdev+bounces-241731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7D7C87D84
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046E73B7584
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 02:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4310430B52E;
	Wed, 26 Nov 2025 02:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f02hnfG8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8DD30B51D
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 02:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764124656; cv=none; b=D0+fGMxEX4slrj7h8sON2fphITewgWKhrHO0Ruz+gu6Se/ByjnjqHuPYZ190o9FpX++mRtW9IPLbDacgSJHCeQ53yYQTFkGP11AAUmmrKIeix17fSxAdv2ERb+H76uLFVGXmkfXeTDpHrAtYS3O/QV9syxZod9Iibmh8c2fIyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764124656; c=relaxed/simple;
	bh=entLQ00bQ62t/dTRgSabG0fNBdbyrs85rvRHU1HwGTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=echCenw76E/IP+W0o7SQN5nrA6brpoJGzU92ix2Stvxwxo96hbFvztUfJQnNLqwR9pXtPSvJTcVHODSHznO36OKIicOkODsILZkhsLb2Ww63ekYzOCeKiQuzUx1mAXTL+Bg0u6l513nWggZCeQP7debHEsBOUJn1UoroDv/aARU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f02hnfG8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-297ef378069so56642465ad.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 18:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764124654; x=1764729454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=57/iOTQ4I+Y5hbIzCA+HosZ78NtoHBq+y9GUVuWjdbw=;
        b=f02hnfG88imzcF16LKnqx+iYXEjsOu9yyEroCAaetG/dSONCY0B2YckA4bxeYYpufG
         pawDV2932eJxixGEKT/4uG0IDhXQjfwBzR79ogxqDt8xZqBgU9h7j1TR3m1EZwU/uAA2
         WfpnOwsRIpjEoqD+jt+TVkPkV0YphwFJA13xay0pXuHAItPi0giKR9PLdqG8guJQojI9
         T10fOHJL9BOJc5QoogzheosbdFfz7diqAnl4pIQQAOzvhKNIZELBBXB2QAXMoblBUUbo
         QvPMPcKaz3bbykkpLOfw935ODVTSuiDLzgIvoBm0T4RwiTiv0vHsbBPskWxXGqUQRn3o
         2Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764124654; x=1764729454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57/iOTQ4I+Y5hbIzCA+HosZ78NtoHBq+y9GUVuWjdbw=;
        b=g4VBndSghwghbxEqAERLbgnYrAcvdW8Pg1X02Bkj5yFBVc5j4TOpUz93Rc5IxmoJPf
         ou4f9PBIy0wA9nfaLhkj4SQo4Xe3r+5Xe0cDslwdRiW2eL+LwSGPYD6W3RIs4JBke7ir
         j2K1KdVv27wZDQjkSa3Ry5S3YsJG/eiWjodTrayoknnDWM7V+kVPVWsQ1CQ5WrG6F47v
         H4qLN1JdT7Y3cD9nPIsW3s3uL3MYkhFxNBYE5oPGbjOWzzWg1HugQPQOX+EAwa3ckBND
         mE+qsJMxJIToCI9J16hOM8S3aqMgdGZlug0DfTbXY00kjSg5d7M9O+vydmzTTzEQMsDR
         MFPA==
X-Gm-Message-State: AOJu0YyNgXCfv/Z/YjpO7ZvkaZmZ1Mej1skkrxdRyoq1TyDE0D8Z7dJK
	QcMU0MEECRwRvv+PzwLlfbrTvk2kXMr7415gXikBGvZ8qHuTRRREhFpY5kaO+NYilG4=
X-Gm-Gg: ASbGnct1bbIUKHAWEPSX8cLCh48wDBjRG3So51OHtHeFr4nXoY5Da9zKfAR9NqmbQ4T
	sjiKCyxJc98iSCV0ilT2Cxzj7DpWZ8uKJgN8RbXtdh8DE6l8Mfy1yk7J9Jth9rp77F9R6TK/tMD
	Paczu+O+B4+mIIoDxZbnHor/JXi4CZ2DwhyjkJii7tGkKudjh6X7wrRAuU8r2bjRlf3lfmw9nFG
	4DZw8VJjxglqAvYfm0APPawwCgfdpodGr8nZGrHJyvsqkyYqMKpNIIcVW/CjLPYdjbGl1/9SNu+
	kAJ3+N5yAjxmK3HOj28JJ0f+ojK0bXwsS6wFjIIvFjaPOZq8+PRXepHDSvuH+lMtj0Jdb1xBSAF
	CzduiaWpzVlh1GAB5TUBgiiOcCdO8vVwWG26fxx+96I6Ka/i/bSl6C49sp5M60ch/11JfqK3Vu+
	GuKzCeQV435XcrbhTQtsxdAgaPgXxSpnTBKAcC0S9hdkQEIQ==
X-Google-Smtp-Source: AGHT+IELIwvzumjhkeb3r8Hq6IYtOrVYTz06StNxAdW2mIJzeAWDQwIAW8d3zdgadbvDm5C0h20dKQ==
X-Received: by 2002:a17:903:950:b0:294:ccc6:cd30 with SMTP id d9443c01a7336-29baaf99b4bmr62717285ad.17.1764124653683;
        Tue, 25 Nov 2025 18:37:33 -0800 (PST)
Received: from gmail.com ([183.56.183.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b107edesm177578005ad.5.2025.11.25.18.37.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Nov 2025 18:37:33 -0800 (PST)
From: jiefeng.z.zhang@gmail.com
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	irusskikh@marvell.com,
	Jiefeng Zhang <jiefeng.z.zhang@gmail.com>
Subject: [PATCH net v4] net: atlantic: fix fragment overflow handling in RX path
Date: Wed, 26 Nov 2025 10:37:27 +0800
Message-Id: <20251126023727.52472-1-jiefeng.z.zhang@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiefeng Zhang <jiefeng.z.zhang@gmail.com>

The atlantic driver can receive packets with more than MAX_SKB_FRAGS (17)
fragments when handling large multi-descriptor packets. This causes an
out-of-bounds write in skb_add_rx_frag_netmem() leading to kernel panic.

The issue occurs because the driver doesn't check the total number of
fragments before calling skb_add_rx_frag(). When a packet requires more
than MAX_SKB_FRAGS fragments, the fragment index exceeds the array bounds.

Fix by assuming there will be an extra frag if buff->len > AQ_CFG_RX_HDR_SIZE,
then all fragments are accounted for. And reusing the existing check to
prevent the overflow earlier in the code path.

This crash occurred in production with an Aquantia AQC113 10G NIC.

Stack trace from production environment:
```
RIP: 0010:skb_add_rx_frag_netmem+0x29/0xd0
Code: 90 f3 0f 1e fa 0f 1f 44 00 00 48 89 f8 41 89
ca 48 89 d7 48 63 ce 8b 90 c0 00 00 00 48 c1 e1 04 48 01 ca 48 03 90
c8 00 00 00 <48> 89 7a 30 44 89 52 3c 44 89 42 38 40 f6 c7 01 75 74 48
89 fa 83
RSP: 0018:ffffa9bec02a8d50 EFLAGS: 00010287
RAX: ffff925b22e80a00 RBX: ffff925ad38d2700 RCX:
fffffffe0a0c8000
RDX: ffff9258ea95bac0 RSI: ffff925ae0a0c800 RDI:
0000000000037a40
RBP: 0000000000000024 R08: 0000000000000000 R09:
0000000000000021
R10: 0000000000000848 R11: 0000000000000000 R12:
ffffa9bec02a8e24
R13: ffff925ad8615570 R14: 0000000000000000 R15:
ffff925b22e80a00
FS: 0000000000000000(0000)
GS:ffff925e47880000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff9258ea95baf0 CR3: 0000000166022004 CR4:
0000000000f72ef0
PKRU: 55555554
Call Trace:
<IRQ>
aq_ring_rx_clean+0x175/0xe60 [atlantic]
? aq_ring_rx_clean+0x14d/0xe60 [atlantic]
? aq_ring_tx_clean+0xdf/0x190 [atlantic]
? kmem_cache_free+0x348/0x450
? aq_vec_poll+0x81/0x1d0 [atlantic]
? __napi_poll+0x28/0x1c0
? net_rx_action+0x337/0x420
```

Fixes: 6aecbba12b5c ("net: atlantic: add check for MAX_SKB_FRAGS")

Changes in v4:
- Add Fixes: tag to satisfy patch validation requirements.

Changes in v3:
- Fix by assuming there will be an extra frag if buff->len > AQ_CFG_RX_HDR_SIZE,
  then all fragments are accounted for.

Signed-off-by: Jiefeng Zhang <jiefeng.z.zhang@gmail.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index f21de0c21e52..d23d23bed39f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -547,6 +547,11 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 
 		if (!buff->is_eop) {
 			unsigned int frag_cnt = 0U;
+
+			/* There will be an extra fragment */
+			if (buff->len > AQ_CFG_RX_HDR_SIZE)
+				frag_cnt++;
+
 			buff_ = buff;
 			do {
 				bool is_rsc_completed = true;
-- 
2.39.5


