Return-Path: <netdev+bounces-241648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 923EFC872E3
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4ECF64E39D8
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 21:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8A22DF6F4;
	Tue, 25 Nov 2025 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="NheQOEAM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6050727FB34
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764104535; cv=none; b=HQpyPqsdrR6SlJMLBkAaTQJmh14AXShPAUAME3ckwv7W0alHoMVk+S4J1wnVCr5C/CQx/1pCqnZR0aElre6vVIdbjMJV05pZlJJQRlEWLP6Tsh81bGlprseVSI1rs596M+KIhOtGeBNj6Jgf8NrSC0wcPHU+s8E+QwQ7MEY0O+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764104535; c=relaxed/simple;
	bh=+X2NL/mQII+GwsSzlRCjIi8ay0Fc5THQSfbr7naxGpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IPHZ02TH4xQsVXDHsYogAV5+3r3s3XFvTfKZKeweY23axX9McCKlv50WaaQz+g75Y7LEX4Vx1fGdI5fNGD/9vanshwhHER8PmcvCCA7gM1c8UbCqcLe1Y4xA4c0RPPAiHhh26pE2RmhrIxszs4Xm93Vk24Br+30T2Ag8ETBmCUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=NheQOEAM; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so5472770b3a.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 13:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1764104533; x=1764709333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=osXunqhAfL4H6EY3Us+4JhzQ2RBABGSGYhjkFwEvKR0=;
        b=NheQOEAMt2csDZrmQHXPMGiIiY4CP+ovscc8uhsyDMWbTdM3dTPT7hM3QYl8ECYg0z
         n5kCW3NH9n8/BblY0W6xYX4EkbvZ4gIkuNXV78QXFv8tu52xJSQNi8OJ0h/ShUi70HiJ
         HuD14Iy1Pw4VeBFxGi4BGxFhcymgXxjLeTtqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764104533; x=1764709333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osXunqhAfL4H6EY3Us+4JhzQ2RBABGSGYhjkFwEvKR0=;
        b=LoRXcmRXt0EqZE5/sJQxXupMC09TYHNwNoT4n836fdBzk+l/ULhFAxGAV6MI7kWPiR
         b/W0XFC+qIypleEFIw0rEpJxBAIISKpj7Y7TNQtDzLw1cXLMQDSxoppe/nv2FmzVOTLp
         Y0rW4n+RyqXuVOGq/CQjXhZNoYU1KfYWS32WDIlxBiRjbRD3PZkF4R5YWLVJsnrlNBlu
         2hKKPe4JAmMT2cqxW16gvMD1q4oy/NX6d626pK43M9QZsa8H5PJU8H87NBK48TXhRs3u
         xQg0CMNUtHAaoLm5nvvxpC0nC/eUy87AetPDhjelZ2RCAkNCo3WbhcM7zqmTfR+Io/zN
         nKaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ5hUByleWk40cP25zPcJ5dnKeM+4uT1P1FNkGnPx/ozJVbGSdPLvupnXzMcv6a7GNOXNbK34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDg2iD4J5cKVtI+2zoFrXJTWrixFhUc30ZUWwZ/M0f4rYPQZiN
	u9j808kQYt2P65GhM+N1/PWhef7cj3cTeTK/omM5x9D6bUDfs5s/DDleD6cDm9qVGnw=
X-Gm-Gg: ASbGncugxOEMP/1Xxhtccafw+azjSSQbPTj0iDPAKiGXzgysGPoHV7BiuioAFFRedwF
	x3snxli1wE90SMHIdK4sNl++zPT8G+YDEwH9Pg3ucVRLlk2/MYcAD5KItuJ4E8N1oM/6bm+m21J
	UD1in4w2GD2hA5m7x4HLPZGpwTMRapCDIT1xIdw9CIx+DGje+h2hh7rbx6L8FzrM4HryzLmkUDo
	K9bX2vj3wrUSDF/tPFT5TlbLOZha4Og55khF2a06L0OrJ5ac+8sXcrgIZhC2KgAKwzFrT5RSR5H
	ADWIOT4opS4B54Vqwnp+/bkkI6PV8k9lwoSaIC1smAPv90vrauYk5308iqd0sWmafVYW4SHRAUY
	aTPlbe9wyt591McWANh0l5usRWDmaRrLQtt+HdRLDX743XTmrFMmfC59VibEFC26NXw0RoG0fPP
	RHarUvzKPTqij+JyZZNP7AaGpcwcB9wP06Zsg4sZTmeFSJhSFRPx0+hgLp
X-Google-Smtp-Source: AGHT+IF8rHdGCk+hPhh11+D10Hl7dwICt6inpTxsalZAZAlVFcjaUhKIhxOQY9T2iFRuI0A5OjEuPQ==
X-Received: by 2002:a05:6a20:a12a:b0:342:e2ef:332d with SMTP id adf61e73a8af0-3614edf0345mr18775051637.40.1764104532467;
        Tue, 25 Nov 2025 13:02:12 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2405:201:31:d869:2a74:b29f:f7bf:865c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75e4c9ff5sm16915596a12.9.2025.11.25.13.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 13:02:11 -0800 (PST)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Felix Maurer <fmaurer@redhat.com>,
	Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
	Arvid Brodin <arvid.brodin@alten.se>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com
Subject: [PATCH] hsr: fix NULL pointer dereference in skb_clone with hw tag insertion
Date: Wed, 26 Nov 2025 02:31:58 +0530
Message-Id: <20251125210158.224431-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

When hardware HSR tag insertion is enabled (NETIF_F_HW_HSR_TAG_INS) and
frame->skb_std is NULL, both hsr_create_tagged_frame() and
prp_create_tagged_frame() will call skb_clone() with a NULL skb pointer,
causing a kernel crash.

Fix this by adding NULL checks for frame->skb_std before calling
skb_clone() in the functions.

Reported-by: syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2fa344348a579b779e05
Fixes: f266a683a480 ("net/hsr: Better frame dispatch")
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 net/hsr/hsr_forward.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 339f0d220212..4c1a311b900f 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -211,6 +211,9 @@ struct sk_buff *prp_get_untagged_frame(struct hsr_frame_info *frame,
 				  __FILE__, __LINE__, port->dev->name);
 			return NULL;
 		}
+
+		if (!frame->skb_std)
+			return NULL;
 	}
 
 	return skb_clone(frame->skb_std, GFP_ATOMIC);
@@ -341,6 +344,8 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
 		hsr_set_path_id(frame, hsr_ethhdr, port);
 		return skb_clone(frame->skb_hsr, GFP_ATOMIC);
 	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
+		if (!frame->skb_std)
+			return NULL;
 		return skb_clone(frame->skb_std, GFP_ATOMIC);
 	}
 
@@ -385,6 +390,8 @@ struct sk_buff *prp_create_tagged_frame(struct hsr_frame_info *frame,
 		}
 		return skb_clone(frame->skb_prp, GFP_ATOMIC);
 	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
+		if (!frame->skb_std)
+			return NULL;
 		return skb_clone(frame->skb_std, GFP_ATOMIC);
 	}
 
-- 
2.34.1


