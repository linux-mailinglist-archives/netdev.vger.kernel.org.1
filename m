Return-Path: <netdev+bounces-225007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F04B8D08F
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 22:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5AB7C7F20
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 20:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A44274B46;
	Sat, 20 Sep 2025 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx2fa9ZS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A212144D7
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758399136; cv=none; b=eToVsuu2OLrC4O5XtTecG4Ui58Ll0BTuQBVUuiLDbfRc1seioyGD/8507vhgHdtuMiyYcp7nppJHWXDU23PVW8d/OHBDGS2RUfo37dzas3T0cOjY9+bBWWwBcOvI1a8JkIIq1ozBfieKPa2Z1/lmhvv7d7LOEY9n033a3MsgjaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758399136; c=relaxed/simple;
	bh=feKc9PJGPZqt/uE+zM0sTjLZY7BjOt/apiF8YLIoW0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kb4p+/EO8zpSEG326BhKksP6VX0w2wEnmx19pTgV9FQODo4wzkemCAt4gWoLja3b8X2ImLpt/qr9BbSTXbDzRgzQzJ49BlW3VgCXaiIFzOgN/kmdA+u2uzNTFuypelftdguIOlO4p9cODrfnNyged/wlRSyNcY30mDw3yNW8A40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hx2fa9ZS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77e69f69281so1708812b3a.1
        for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758399133; x=1759003933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NfxhpuR4uEPQTXMkMfbx8NFTCu/dYBMS+9D8zFtE8M8=;
        b=Hx2fa9ZSigpYUBKxFgnFo4s1MOstHJ4uA+8Yaf+dKydK1P222s8OLnMQTUvGngFxWQ
         bRz+YKgya2x3ZJpXqkRCZc8toK3riiR7OF99r9cRLvwyJKPMPtO/s1MeAMxYMlCQteql
         F+DaibwN0/hgW6tdxPWfxSV2TZfvlgNp0Ztjmz4JymSc2dca3Yexh9egXExSaTXyrurJ
         /dLOAxGb0oGT8lPXZ70PTxtdwqEiIlkB8pQvJRg+eTWua7SBnzorNkhPZyl8Nw3w+bwd
         /hReW2qe6qjJVPPAz1+QQwgPflAIcDh34YAjx0Aikz941TJ/iGvcCbInNBG/6KNy9UDn
         iVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758399133; x=1759003933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfxhpuR4uEPQTXMkMfbx8NFTCu/dYBMS+9D8zFtE8M8=;
        b=hbudRxeqkRV8StFu/krJEFQsIME23t79+lnRhVPLdibyqB49eJgSNcZXbunUhW1o1v
         5j6GzRw5MRwSxNDNzNBQ7Hnn8VFapQ1UMTecCAeXrNIwuKDoIhj+BnknLiWTiGqfbgtq
         IH5haR0J3FnurirNg9HgRs88WYSEIqqasgskPoNdkg7o4hSJ9Nha93VTKnGHB59ZTwZj
         rySG++d5gPjPD7Q7ojzqsW1TU6a/+jhslonStU9qejWU2quMvUArmBKId1oK2L3rzqx8
         HNlhuEsQXvy8syD5tD82E97HIWLBDAP7MEqSPjm2P83cJqkHEcrw1UBZChCLb36PD6VF
         B6OA==
X-Gm-Message-State: AOJu0YwhEoCBxZ/WwmgW0MmQKkuXp2U7IkIpD70S0x9nS7q8gAozOj/R
	3vF32KdQ4k8x5OFXITHD97p0BU/vFVMzWfcKgoa231bYiXi1rjCERWrh
X-Gm-Gg: ASbGnctBql5cC1Vl1lls8oDWmy6zcrxyHjrPfSBMSSVF1rKYNmqCOpKEkXBeYVrHVtp
	UpFJTX85lgKz8EM1jRzfqBVIUpkqYpKekmeJtDfl+FJ4GrLpi6Gms0IdvlC/MqD97uC+e1Ijuh2
	oKM13OaFKNAtUEAFM9Jz+dgEW3KAHFvWS2tZP3djb1GAfiRrlZKuvsyzQiyaCCQk9Il1PdE4Dq8
	wOahvylwkWIiuV2mQVUsfE/nSIGou5yXnBluhHscLsMQ6h3+nAWSleRqdhH/Ax559ervq821aEz
	cxxl1IREHUV8KPcA9ETV4fUVgVWJ0+4y2WTLUcm8EOXFXc68R6T8IZECc2xUWZuyka0eRbiShHq
	igliasVfepvBBi+Y/N5QBysQ7CnGUKdIf4MLKDGnW4O23Ddnjrun21IwHdRGpN2ElgRorHI8xaT
	87pxdl6Hpy76wXpW8iQT/iCMR2JQ==
X-Google-Smtp-Source: AGHT+IG2y+MxKod/XzAN+M1gu7tYhwj5v+CW7f8oWw+t8RRRrPcsei0GeMMgdnDja1lZ4nyAdg49Ig==
X-Received: by 2002:a05:6a21:329b:b0:263:57a:bb46 with SMTP id adf61e73a8af0-2920875282bmr11094636637.13.1758399133055;
        Sat, 20 Sep 2025 13:12:13 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e2b7d8078sm5919446b3a.81.2025.09.20.13.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:12:12 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kerneljasonxing@gmail.com,
	martin.lau@kernel.org,
	mhal@rbox.co,
	almasrymina@google.com,
	ebiggers@google.com,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com
Subject: [PATCH] [PATCH v2] net: skb: guard kmalloc_reserve() against oversized allocations
Date: Sat, 20 Sep 2025 20:11:38 +0000
Message-Id: <20250920201138.402247-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an explicit size check in kmalloc_reserve() to reject requests
larger than KMALLOC_MAX_SIZE before they reach the allocator.

syzbot reported warnings triggered by attempts to allocate buffers
with an object size exceeding KMALLOC_MAX_SIZE. While the existing
code relies on kmalloc() failure and a comment states that truncation
is "harmless", in practice this causes high-order allocation warnings
and noisy kernel logs that interfere with testing.

This patch introduces an early guard in kmalloc_reserve() that returns
NULL if obj_size exceeds KMALLOC_MAX_SIZE. This ensures impossible
requests fail fast and silently, avoiding allocator warnings while
keeping the intended semantics unchanged.

Fixes: 7fa4d8dc380f ("Add linux-next specific files for 20250821")
Reported-by: syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5a2250fd91b28106c37b

---
v2:
 - Add WARN_ONCE() to make oversized allocations visible

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 net/core/skbuff.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ee0274417948..70588f98c07e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -591,6 +591,13 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	/* The following cast might truncate high-order bits of obj_size, this
 	 * is harmless because kmalloc(obj_size >= 2^32) will fail anyway.
 	 */
+	if (unlikely(obj_size > KMALLOC_MAX_SIZE)) {
+		WARN_ONCE(1,
+			  "%s: request size %zu exceeds KMALLOC_MAX_SIZE (%lu)\n",
+			  __func__, obj_size, KMALLOC_MAX_SIZE);
+		return NULL;
+	}
+
 	*size = (unsigned int)obj_size;
 
 	/*
-- 
2.34.1


