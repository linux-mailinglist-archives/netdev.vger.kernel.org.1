Return-Path: <netdev+bounces-86365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4F589E7CF
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 03:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 089A6B21FC9
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A8E4C6B;
	Wed, 10 Apr 2024 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiEx6yOz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022F51854
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 01:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712712506; cv=none; b=sThCIFUwL0B2VfCEr5XTRaJ9j1LgsXKko1n0A4mguOx2JgPejf2ObGVjOQF197rqfvnUEVL9DhqyfNqS2ZYg5avxB+qBlxblIoYQqdXIGg1FHPp+72HOAdNd9o05da+Gkrp4KVl00G8+GVwGRkOOE84LYRCdgiTV0Cove58Zd/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712712506; c=relaxed/simple;
	bh=DWZK/UJGZHhquHjjYLX9QdvhDHNBqfJ5AazYXNuKFtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFyIfGLcnNo0NLqRxQqjBRGtcPUCFlkqj2fuZajOKNztmAEikrF39CZ230OFnm0t9r/4Uh0Rz5SZ/j8uB5/KV3rbU5w71+w8YWfGPfnmx2QXP03R1eLkheDG9KIW0eXAPSpma23FKWqjwy6/DhNcPUiAIpEH/ElNm0ijbDUPLtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiEx6yOz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-416920b1a2aso14487175e9.2
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 18:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712712503; x=1713317303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Xy7Rp0Ks4CrFC/soZjLWSDkjjF/4a6OhQT4APR7Aqw=;
        b=jiEx6yOztwGKmCoOX0FZMg/ZMnHsLVf85Kw7HYRwMnkVypwYBEzBG62oqfde257ow4
         jvjWil9mnyobufgzZM4FLne9y9ygEumVwzJXt4Pb6JGulnrvOsaVhM7HpphCnugJsxqc
         FQX7AaWKZXYmRkeCyWUF7O4G5fGSASiZrnol2iwXoEjpjk6cEWU89gCaM/quwvmrb0yI
         p5moDjRC/MLILACilUKmwD718TsSdsdVOoqqp+dVd2D8avn2g7wykgmWPAZ0udkfQWf9
         wo69d19IRUGlJf9htCAXcO9JY9Emg/LhcF3PA9O4+j5K1zcxncVqrVrsMDDWkdHWnirC
         wzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712712503; x=1713317303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Xy7Rp0Ks4CrFC/soZjLWSDkjjF/4a6OhQT4APR7Aqw=;
        b=RDLhvoV4ijJw6AxF2uJTo04pbYxEicS6YZtjK607iJu7yW2qx1Z451jh8UwnWnPG/J
         fxDYBSxMFkKrxy5bVP2xiLeiPo06Fk4tHeoSlpncfpFYyIRLvrAnyRaGM5EFbuheNXhQ
         YIYziGUdzltVbJxAH25WpR6q6U8v0fTFmJDjSqDZqRrxDcVrxsI92L7G3oT1NQ4vnh7J
         4pfN4fzL3Vdm3WnBtGaXc/ja5y7jp+4qF12CRrFWD8PaublMAsYqZQAKbDk32lxFEkiv
         1C8Ob9+MQ+GAR1TFIprhh7TO4zDro4+9r2eYz4KDc2hrXKLKXyE7x5q0e/Kt77C4EhLL
         bfog==
X-Gm-Message-State: AOJu0YwwnfuRNB3qb0U7IYfJ1tDPg5Yad0qfnvRTldnOGs/N3HTFC5aF
	JDNoVihH0SvanzPK40Hp1cNLTHqaUedl3AsB/XU8kyExXMSTqT6cjYWrh8SU
X-Google-Smtp-Source: AGHT+IHEar27TtXu2kfG4hO3nDUvjwzBBDyE5Bgx8O6pCrxWuZVgTIcdQvwdTiPg8wz/c+vXU05+bA==
X-Received: by 2002:a05:600c:4f02:b0:416:a6da:beeb with SMTP id l2-20020a05600c4f0200b00416a6dabeebmr814160wmq.4.1712712503173;
        Tue, 09 Apr 2024 18:28:23 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.132.24])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c314800b00416b8da335esm659522wmo.48.2024.04.09.18.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 18:28:22 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next v4 2/2] net: use SKB_CONSUMED in skb_attempt_defer_free()
Date: Wed, 10 Apr 2024 02:28:10 +0100
Message-ID: <bcf5dbdda79688b074ab7ae2238535840a6d3fc2.1712711977.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712711977.git.asml.silence@gmail.com>
References: <cover.1712711977.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_attempt_defer_free() is used to free already processed skbs, so pass
SKB_CONSUMED as the reason in kfree_skb_napi_cache().

Suggested-by: Jason Xing <kerneljasonxing@gmail.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 62b07ed3af98..dd266f44aaff 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6983,7 +6983,7 @@ static void kfree_skb_napi_cache(struct sk_buff *skb)
 	}
 
 	local_bh_disable();
-	__napi_kfree_skb(skb, SKB_DROP_REASON_NOT_SPECIFIED);
+	__napi_kfree_skb(skb, SKB_CONSUMED);
 	local_bh_enable();
 }
 
-- 
2.44.0


