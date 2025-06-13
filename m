Return-Path: <netdev+bounces-197331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C90AD821A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 06:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D287176A63
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 04:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006B623D2AE;
	Fri, 13 Jun 2025 04:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LuVENKno"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC7020B804
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 04:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749788904; cv=none; b=hUXApQpWogwlbdNIyRFXWtgL5arL5PP2dArrNSY/Fdsdkn4GyORHEvcmiMjBj+bOQNdPw44+HZEzOb2IvaLvggR0dnxf9G4nqKBaDOB902pPj5WiCDcmrmLjv1oaUenAghlVEVTLfQgIbCvnKXZnquztsOgj5qb6pFLEXumgoKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749788904; c=relaxed/simple;
	bh=ajuHnnSRgwwpumvdXLZB+CCnOw6RWfwS4TirYIkFOco=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jKeKzblMYvUrnwmmbuUSnf5bghDhUG31MdjJgMQWWo+47B4M5VhObnLhRK+NTnXLSWUyCo+v+jJ1ypQAFtF5qj1rHesnj/c3Jnjt93wDDvygTol7XYMH0giCH1t5qdh0dLN78lb92ZSnUIXa8jFCgUZYJmWdzPUU2GEq2aXaoUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LuVENKno; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31332dc2b59so1477133a91.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 21:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749788903; x=1750393703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OMs4el2zdME0U5Bh0u38RmmxtHkZW7DUfeo5MQZot3o=;
        b=LuVENKnonGHeos7U0m4y+eucCFMWSlYbACDFv35ANzZnhpoLQhFOWnqKD2geeJXeab
         Tg+FezyNbOpncNO9xWFFWPab65YbdKvL3VN47FNthJv5aHIqn7OU7LMkr1n7fbg/R00H
         K4lxAD/DmDXbZPhIj4Oj5C3dPof+XqhW8wTHmUH0R6KRPi8N/MoiQ7A/75WSQEyLH7TS
         6ASem8JTYuXlFKj05WIvqg1fxrhzKiCFZbzqel8KFiKFSDBrMG/5oQ5T3HxrWrWkD8J8
         kPoTM4KAHrEt5pAhYJauIMln3H8rhlEzNfV4Ca6mLqs4zCt/mb2yofmIYC6Uf8fyAer+
         tBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749788903; x=1750393703;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OMs4el2zdME0U5Bh0u38RmmxtHkZW7DUfeo5MQZot3o=;
        b=rHoHyNq1NZpAr15Z81P9xg9JhVjzdlCdYqleeQLZFXJco/wBpESsW3XH6gYctnCR2Y
         FvDPELbuV7gdmeJokN3SQJMLEpLq9xtr7AHVHcRSgHoz1crjXPM1DfSr0XVjj9VusK4U
         BQr4lblsBBOe93N/zu0c6aK7OGnb4X2w80YS1wU7C8LjDI8mxa2krP9MgOIpVxopBvJH
         itZKeGLgTXZ69k/cDVmlPRxgNULIU08/ZgNzo/sDxl725xPkC6bByc8YiupmpLbNydWa
         RqvOiBMA1b5CkbaMi/SWlFS/QkJbnC/2LS19MqaUt/uIFg5yU6ufsGM6YaW6oFobYuz+
         iFFw==
X-Gm-Message-State: AOJu0Yye6o7nzzNKU0EVg8tWX8vy5wTByhlDhdhAyUHZPMsPeaf206qK
	C2E/kGnGLb2bSbotxRLt7Fp4QZel9tPawqxzbh3s8zK3sJgIQusIQPmhh8bEfk19WIJgZPLVU/j
	lyNTne1+k1a+iCeSX4ybj3xyUaNvJFGTHezG4hPihmX9p3UyrYifxHRnf4AsfELLbFZCdQhFfxA
	yrejGSDgsZ+bEkgo62/Kr/JMFwNng8m9gusAZtp2vV74Uz0PeCvLnXXjjvJEByuEI=
X-Google-Smtp-Source: AGHT+IEokZ+VFPB53+gBJoGAUqzmEK3QBv1KmzWNzDUXYog11k26C5cCePG3sYOEDR3ejCqBCKhLhSef9kk2MmSKqQ==
X-Received: from pjbta16.prod.google.com ([2002:a17:90b:4ed0:b0:30e:6bb2:6855])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17c4:b0:311:ffe8:20ee with SMTP id 98e67ed59e1d1-313d9c306aamr2594977a91.11.1749788902651;
 Thu, 12 Jun 2025 21:28:22 -0700 (PDT)
Date: Fri, 13 Jun 2025 04:28:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613042804.3259045-1-almasrymina@google.com>
Subject: [PATCH net-next v1 1/4] net: netmem: fix skb_ensure_writable with
 unreadable skbs
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

skb_ensure_writable actually makes sure that the header of the skb is
writable, and doesn't touch the payload. It doesn't need an
skb_frags_readable check.

Removing this check restores DSCP functionality with unreadable skbs as
it's called from dscp_tg.

Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/skbuff.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 85fc82f72d26..d6420b74ea9c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6261,9 +6261,6 @@ int skb_ensure_writable(struct sk_buff *skb, unsigned int write_len)
 	if (!pskb_may_pull(skb, write_len))
 		return -ENOMEM;
 
-	if (!skb_frags_readable(skb))
-		return -EFAULT;
-
 	if (!skb_cloned(skb) || skb_clone_writable(skb, write_len))
 		return 0;
 

base-commit: 6d4e01d29d87356924f1521ca6df7a364e948f13
-- 
2.50.0.rc1.591.g9c95f17f64-goog


