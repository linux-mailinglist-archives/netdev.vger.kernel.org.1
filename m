Return-Path: <netdev+bounces-225610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90854B9612C
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0613B8038
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5B11FBCA7;
	Tue, 23 Sep 2025 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3IL54Sk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116022045B5
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635288; cv=none; b=GiSUIedDCXs9AHSDwOwaCKy1ttLj2yIlQIM/aKTTNYqV8FCy5BbMmfajgW6PYbkIcI3gYlKvLIZ6GM4ql2Zl04hcQNO86NjiH0LHLmqOjY/EeatPRoa8gmaK3DPyDhupT7IqtCkILRbvA2bhHZMbkJqhMvRzdZSy7RRVJ64qQZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635288; c=relaxed/simple;
	bh=ubtbo/7i91ihrLlwf65kGCD4rQTWY7ekmlyJ4hBJ8j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKGMvqQdh4ZthTNOTjg453+Yw0y8AGcJ8okEGAtQsa8uWuE1nnKBe3JN6rHKZTJgIprxY2CNiqMLqyV6AtGJ/n7CkOYyluGGMnz8zQjnz/Fu6EVgIs4MPrhiBzl12CWO4SMJgccBxSV1182BJp+I2ivaffrFMf6Xnj+j+jnFUtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3IL54Sk; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso4981494f8f.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758635285; x=1759240085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5k9nEZHDmwE9ekP8wjWhluIJHQ3tjWAvaKboZAzLqlE=;
        b=l3IL54Sk1GbQwpxiEywuhYIZ56kCwi4ZBjYdKWKERDyoGu1lhgDXMrWAxF87dQTIM6
         mjNh90H1VVfrUR0F0NL+ulPAvcxPxhLMfay6dhZlfI6HdtxmeJCj79FifEd2wr2E2vY1
         FQkIgm1+uQFFNolBZdGxct+KhbGAGnJ89SayHBWnC0VFz9paKrdVWg9T26W1w9mU4Rd6
         AzTRM6DfhwdI+kGLYGW05O3Q7+qZJBl1DbSmXovN+V0rBTa4ZgkRQYpeNasP9f/4y9VD
         JNcsp/kAeCiyFDzpisY0bHf8ujh2vGAQBk1hCXS8LGqd0HlOZMZQSSOnuWo3Xk/OM2Yl
         GuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635285; x=1759240085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5k9nEZHDmwE9ekP8wjWhluIJHQ3tjWAvaKboZAzLqlE=;
        b=SUiShSWXandwQbNzbN49RFQuYSic6gL+9kXrsF79S/BykvRA8YsigXgd+bybjhtY0R
         ugyTfKiIc6tuptG16k3dDcGrBAfxvT0WngQUh3bP4FOJxPHyVUQOy/DmHzbMC9SLo19Q
         Bz5miKylxGcNqsf8LoGizE1BqFsZGX0mIPbFtjFiAckSiLoakXS7RUi/sbwSHr2U13oE
         BGfQZHYhBtxvERMSjHQgI0Zs0AyPbEJIR0Z2zyS6/zh8D4lyhZ54AGcLPzUNO0Yb9VeA
         jtfVpvP7tM4rts6xov661LZ+mWK0vs3mU0Q0xOnjCVNHTm55luyT1d0iCY/zy/9whLSr
         Z88A==
X-Gm-Message-State: AOJu0Yy1XS/fAODeUVZqR1Ef4J01A2xEqhy7ifkDVhMUWJZS0SK1Xafj
	mIKXjePJ5SiWN/x9TSgcOxYVH16jppXoF9peRtj9SqdpW2QNply0bKnp
X-Gm-Gg: ASbGnctNqw2nuhMbVcwqemMTolwjXHE5peBQAw4ccAu/cW6WRxxsQMCpH2IpXn0+LtD
	HBoQPkZWi2vDHULX60FQc83ORZxPgCHeS5K1CUa0GLPIYNkwg59qwDJdG1oOW8Lg5r+wex8tGz5
	yolXs6Js46UhzGF3nx9Jr8XJ35/0nCPPDMK582+ndomsmqUPuK4/rKSb//e6PU47dg2aidcYX1E
	HTPQzX7rxurzFU8nKa2qLQ9KsPqnnMTctT9VBzsXfVkFVAeOjJ9Qr3emsrjti+H7ewoNo0iv49W
	IQXbRyNHikgTZtRvdAy+TAI/9In6LvTWzZ2KbGfxRKr5tz91ulk3DsvSpdmDhUzTYQEipeXR6ne
	ernz1QeD4qQPup482v/Y2mpmHDrUHuAzeRRCi4DG25ywSn4CPplQ2Ek54oqw=
X-Google-Smtp-Source: AGHT+IGhagL5j2uXUbZVuLLVlNlAigxx1lnVGHOSSTDsIOGg2VXK41WRQgF99UFHQ8Wi4kmYmSopww==
X-Received: by 2002:a05:6000:40e0:b0:3f4:84d0:401a with SMTP id ffacd0b85a97d-405c551b8ddmr1662334f8f.4.1758635285327;
        Tue, 23 Sep 2025 06:48:05 -0700 (PDT)
Received: from localhost (tor.caspervk.net. [31.133.0.235])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46c9d5d52dcsm116147915e9.8.2025.09.23.06.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:48:04 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	tcpdump-workers@lists.tcpdump.org,
	Guy Harris <gharris@sonic.net>,
	Michael Richardson <mcr@sandelman.ca>,
	Denis Ovsienko <denis@ovsienko.info>,
	Xin Long <lucien.xin@gmail.com>,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH net-next 07/17] ice: Remove jumbo_remove step from TX path
Date: Tue, 23 Sep 2025 16:47:32 +0300
Message-ID: <20250923134742.1399800-8-maxtram95@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250923134742.1399800-1-maxtram95@gmail.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

From: Maxim Mikityanskiy <maxim@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the ice TX path, that used to check and remove
HBH.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 17cda5e2f6a4..5db84ef36fd6 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2427,9 +2427,6 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 
 	ice_trace(xmit_frame_ring, tx_ring, skb);
 
-	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto out_drop;
-
 	count = ice_xmit_desc_count(skb);
 	if (ice_chk_linearize(skb, count)) {
 		if (__skb_linearize(skb))
-- 
2.50.1


