Return-Path: <netdev+bounces-114040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0A8940C24
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE781F286FD
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA7619415C;
	Tue, 30 Jul 2024 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUEn6ha8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9340193099;
	Tue, 30 Jul 2024 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329202; cv=none; b=cfHACwksYN8vGEqA6WKH2DmC1k5gYG92k9O0bWyu8gayYBr34gTi80Pq8Bza6GMelAXoOoJXFYKRvbg9bW1qnfV6vQTUPmIcdNuKah/NLLbW+iHpL4kLw7GbuUIty2duFECtCcFchoVtUJXrq8IOu1tiJ2vy1QX62T8Y2jflM9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329202; c=relaxed/simple;
	bh=b4LKj5n8JEGCAFCr0XTCE2Vt4PRZBGKVYg2iWYChsqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f1tolCUxeBebT99Hc4Wux799uOTxvX1D2eHTwNWfpYs92mhuZW90FkSOynQ1QbVdLFOzQyK5KVO8FJlH4vnfQlKC6dNYSil98uqR/W8qbQRtOLL7knZTdKGTRpL/eS8iAw6RSDeTjHwlFiPlNnjYbj7NSJ8Qq1k1a2vAkFt7wO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUEn6ha8; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-70d1c8d7d95so2606217b3a.2;
        Tue, 30 Jul 2024 01:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722329200; x=1722934000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+JfbO8SiiD7QjLOWye4GDcjfYdtq1pCx+OMdv4xqVP0=;
        b=KUEn6ha8B/sz2xzW7SaJb3eC3ESgVk4ghaTiruM79QoWG2nXLGohAQUt3OukNpJtlC
         PVbhyuiqVQVBxw2qnPzeA/CqXnd5N9PgjLHiMgccEwUjepo6lgOjjdIsoOg5nko+7/0s
         DC5J0ZiCsR12HQOSSaYJvOcueimuwnmRZ038ryMqpkpXRUvWPpVXlzySpIZ6/18hAP3R
         Wjk0yadSxbIkclATf5lIXRuF0bsJDu5nAFCrKr9tdgCejK2BjnKVki0I4nReYv8abSKR
         kMhlSa4Gjt3MHH/YlXCrgXOQcHgXFkPItlbafKdNK7Q+/Vb01PbccPLXNYfKmGT7toI/
         ZaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722329200; x=1722934000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JfbO8SiiD7QjLOWye4GDcjfYdtq1pCx+OMdv4xqVP0=;
        b=KZ4cOBFSUuW1BZ1YZaMSCw9XC6xVYZMyFBX6KVmVfnBIO0ZhYwrpk3aLW6bykx6qVo
         FT9fi5RBwx9xF35EIid/HSOurZO++G0zLg2fFz1ULU35I+1NoFPUp5vrVWf4gwnubKik
         bHY+UfbzBz79m+S9H4T8kQVM910Fhdnu5Y1nfRsynbO0+hkvFakOyqAUD7WMFP3pw2WS
         nSrBa5gTpbqDkXiLNNX6qhdBVaFf4pPFrBCCW5mLmCOtr3mKBoqufZ2IgGN4/y3+OzEF
         WdHXBZhinWWHNBjoVgcK7ZEnoOc5h4Ke3tYZRJJVPvRGNmS+9Uyb77zPKa9NN1UItfVc
         LxdA==
X-Forwarded-Encrypted: i=1; AJvYcCW6tkcBHfpgtCj4Sfk4SxIm+WnKBheqyYcIvihfhwkjVoFWJjnKiwH3PwiL8V6ijvj9D7x+OkZedWVyhpG4/mcxcQgr/e4BarE5weAL
X-Gm-Message-State: AOJu0YysDnrqkMnFQnOZagpQHU+UktLv2r6dkVZz4eIZ4Bi3EMFFtlSp
	IkatsOzRhlmeOnhZsb/m7ne1CfE49ewhk1AGOPWg0i0YtDlmiE9/
X-Google-Smtp-Source: AGHT+IFQuHjLUgaNkWjNiK7mJEi9/3hLzHn67EugJva8Qbb2ioG5mLhyCfZDiRuQR7NHgrAG7lHKwg==
X-Received: by 2002:a05:6a20:9e4b:b0:1bd:1df4:bd43 with SMTP id adf61e73a8af0-1c4a14fdcd6mr8385337637.54.1722329199545;
        Tue, 30 Jul 2024 01:46:39 -0700 (PDT)
Received: from localhost (66.112.216.249.16clouds.com. [66.112.216.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73efdf2sm11967837a91.29.2024.07.30.01.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 01:46:39 -0700 (PDT)
From: John Wang <wangzq.jn@gmail.com>
X-Google-Original-From: John Wang <wangzhiqiang02@ieisystem.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: mctp: Consistent peer address handling in ioctl tag allocation
Date: Tue, 30 Jul 2024 16:46:35 +0800
Message-Id: <20240730084636.184140-1-wangzhiqiang02@ieisystem.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When executing ioctl to allocate tags, if the peer address is 0,
mctp_alloc_local_tag now replaces it with 0xff. However, during tag
dropping, this replacement is not performed, potentially causing the key
not to be dropped as expected.

Signed-off-by: John Wang <wangzhiqiang02@ieisystem.com>

---
v2:
  - Change the subject from 'net' to 'net-next'
  - remove the Change-Id tag
---
 net/mctp/af_mctp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index de52a9191da0..43288b408fde 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -486,6 +486,9 @@ static int mctp_ioctl_droptag(struct mctp_sock *msk, bool tagv2,
 	tag = ctl.tag & MCTP_TAG_MASK;
 	rc = -EINVAL;
 
+	if (ctl.peer_addr == MCTP_ADDR_NULL)
+		ctl.peer_addr = MCTP_ADDR_ANY;
+
 	spin_lock_irqsave(&net->mctp.keys_lock, flags);
 	hlist_for_each_entry_safe(key, tmp, &msk->keys, sklist) {
 		/* we do an irqsave here, even though we know the irq state,
-- 
2.34.1


