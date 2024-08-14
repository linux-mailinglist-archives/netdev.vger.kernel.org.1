Return-Path: <netdev+bounces-118467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052CB951B5F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85BA31F23C4A
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E9E1B012C;
	Wed, 14 Aug 2024 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LF6xQuzs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC391AED2E
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640816; cv=none; b=WzNGmia99leALDQK6l0FLumxTkqg+02R3Y6hMqCOTS+ZxGm8l44YYbENndUHqrtoy08n7SpKOFs8Zz8HK0CMTEnsPN4ubi/PXuzIa+7V9juMgDXUOlxz7YS/0exvog2VOtnbMsyjqIbNZ4eLpoinxvk+kSnwVoTj+wX5MW+b7jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640816; c=relaxed/simple;
	bh=v/yXJrBDlpAQrlFKowIyb4g9XUvrM0bLLMWzVwzKonU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmZPcd9aMLFV4AwaQU4UB+QggxbYHImKpoGl9c3JNxUJKNGQEdy2q96gNRUkNo/Qnrp82r6O9fttDTbzyAIjZhQlrmNl0Lx3q3BZLMhi2zjHwCpvtMZ3/tgs9mLrtTyg92uI5HGJd5q7jGnN8DqceucMkj0HX4XzTB2ols9MfZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LF6xQuzs; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-710d1de6e79so4582704b3a.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723640814; x=1724245614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vsfsWl1qU21FyjK2pca4Vhgh1w520tV98Txp3TT/7s=;
        b=LF6xQuzsYjBRh90q9VzS89X+WNyQp9IQVSFREGoHySUlc54vVQwWXGRaM7iIC+D7pW
         KOCd0lav/X0h9+4GKhEYHpPgju82FGlT7S2+I39hZ0SDx8JdR7QczJKizEaKwAyS1v4R
         zVQuzIJ+I4xa26y+ZzMkX2KoSgHnDi6nseC30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723640814; x=1724245614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vsfsWl1qU21FyjK2pca4Vhgh1w520tV98Txp3TT/7s=;
        b=C/YOkLqR8ZtiMrF5J0d2B8xpDvd7dztq6BrHfbeIN88R39J8caP9dBIURM26A8el0R
         H4WqUnM4cJDKytynx921N2nmwjpA2Oz8hjlfuIf4jGvMahMQhtWN2m94NeSn0qEP/BNv
         r/EdbjnfpLQSEw9mbZRch0u60woyhc391xEyayUJrUAmT+/pXlbNU/AWJ5s4LJfBarSF
         IcF0zmASIJXvCj6K/AG2+qQQjwBfRku3TDGmopgUjnQWtYULv92fUVSNOVHiDljedazi
         yszaOJSZ6UN8MtdSnY3qxpAfEH6A5BVH6X8KFEaBdSiIgPZ5rq++gAyllQRbRHwEfvO1
         jQJQ==
X-Gm-Message-State: AOJu0Yy7kvrwSr/TX5fA/hdfouxy2jt3F3R+aSIwWjFzRzERnFgiNYPa
	sL5Mqx+bgSviTj0Az3uhuZN9eYwvZs2UNIFw67YKVvbNdcj6ddyMFeGr4AkstsGUKvW7p6v6UPl
	+zwxOTLu5pvqTIcCaaDvgfMv8AYiCIAoYUlAE0vYGz/63+DX9bae2gJHS+l/9wsgrhGCH3gK+WX
	vdHFLgM9uyRV1pKXPKjUk+w46XK6QcpIbX94SSnlKgjmUm5k3p
X-Google-Smtp-Source: AGHT+IEV9Z75VXA9r04zQ9iN3coGrXnqqdUMsX+f3yCJOgJT9JGiA0P/WXHNQ+FFXEwgfGla+VSB0w==
X-Received: by 2002:a05:6a20:9f89:b0:1c4:818c:2986 with SMTP id adf61e73a8af0-1c8eae895acmr3377500637.13.1723640813475;
        Wed, 14 Aug 2024 06:06:53 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-711841effe9sm4904543b3a.31.2024.08.14.06.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 06:06:52 -0700 (PDT)
From: Boris Sukholitko <boris.sukholitko@broadcom.com>
To: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: [PATCH net-next v2 4/6] act_vlan: open code skb_vlan_push
Date: Wed, 14 Aug 2024 16:06:16 +0300
Message-ID: <20240814130618.2885431-5-boris.sukholitko@broadcom.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240814130618.2885431-1-boris.sukholitko@broadcom.com>
References: <20240814130618.2885431-1-boris.sukholitko@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare to do act_vlan specific network header adjustment by
copy-pasting several lines of skb_vlan_push code.

Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
---
 net/sched/act_vlan.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 22f4b1e8ade9..84b79096df2a 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -49,10 +49,15 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
 			goto drop;
 		break;
 	case TCA_VLAN_ACT_PUSH:
-		err = skb_vlan_push(skb, p->tcfv_push_proto, p->tcfv_push_vid |
+		if (skb_vlan_tag_present(skb)) {
+			err = skb_vlan_flush(skb);
+			if (err)
+				goto drop;
+
+			skb->mac_len += VLAN_HLEN;
+		}
+		__vlan_hwaccel_put_tag(skb, p->tcfv_push_proto, p->tcfv_push_vid |
 				    (p->tcfv_push_prio << VLAN_PRIO_SHIFT));
-		if (err)
-			goto drop;
 		break;
 	case TCA_VLAN_ACT_MODIFY:
 		/* No-op if no vlan tag (either hw-accel or in-payload) */
-- 
2.42.0


