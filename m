Return-Path: <netdev+bounces-133137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BF6995188
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C65285145
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB401E0495;
	Tue,  8 Oct 2024 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hve8338q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478281E0488;
	Tue,  8 Oct 2024 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397454; cv=none; b=AUu9mGcsR78QJpP3kUDnuGQHYQ8zVAtyi8BXpj/sd1iExyl+l8QHX+F0EvKKDtDP17YUWRpm0F++Rj41PCQe9PC8znRWgTPTZNxacZCSsTAvJLFr9L/zpBT/eAGYVMiGwGKVBvk9ZXgsiX+ppYNs3xlTrTZzaFnwxK0awp0RCHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397454; c=relaxed/simple;
	bh=xmSEGfXWYYnrxahV/hxdM2xvbpsGMckUIHbpupwQeoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cvhlbAwq5sYZuHHkux1UGrYbUZnC7AHqgzuQ166vPFgOxOVktfPNbpdCufpOzufxj/4xlBFki5MEc/CqUtH8eW1rDcdngLnafPk/NiYu4wKCvN/8KTCTvE2PcWPxEnoK3eLIMaPP2LaNkgntSHdwcxSe3rT1TC68Fto+oS/AV/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hve8338q; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20b9b35c7c3so59767515ad.3;
        Tue, 08 Oct 2024 07:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728397452; x=1729002252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLQPPQHkux9UrJBZUqB+t1LpH9/HisAt/+hbWRBu/OA=;
        b=hve8338qaPKc+mtU6TmLw1yW3YsOlOLEH1aJoOqzE1JchN+3+yipWUwsxZzchNnXVZ
         GDaJITru2ch/b4scOvtKoMpgUjF6ieZ/1ESu/m3yd17G+nYBcZ9BFLR7p9ndjvRJR1ly
         NXzOKdFz5GL653Mj27hFm0mxvc7by6kNb8E9JjTdFzeAU3FT8qA9eV/5ZTxMrs9xqbas
         aNOMrb9A9AjrEaIIhrLhr47QmUCiZ/DuA3bXLpHLkI911rUI2v5A9LceY2+Gfs6Jl+KB
         6kWv7rME7N51S9y24jXZIZt0Ueqmgv67UxqDhwmUXptJjwD5a0EJoyo+Zc9tvnUrDKZY
         O7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397452; x=1729002252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLQPPQHkux9UrJBZUqB+t1LpH9/HisAt/+hbWRBu/OA=;
        b=N4c/KSHiO7qYJJeYQ+efm1w3eVlB1BiLvbKx9+JHSc4hKFV4pNah4QvfFnQcxYSANp
         Vp44IIowbFPS8FsWn/xC5kGuRrj8vdKcc5aRFoOJW777QFGfZs22AtFluZSkf5OpfLMl
         L2sWVVh04JBc2ibsEH2V430ZE7znWMJABCIN9feUKiPNlhWSArgVwpYE9inRyrc7ckCg
         kTrC29GF4ZvA/H8Vcif3v7RrNwXcziNAibhK/E4oXZQ3jgQwTuHluTI1KLEaW91KEVN/
         743QFbBvJSveLWPLXGtGuHvNbS+aKIRpqOmH7ooNB4Spn0ffeG2s7xrXxvGO5eLYSjf3
         w8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfqFzkRfPa06JW7+bMONMOeTKKPpaegDD4uon9Xt1BjjgWuC3eo0QbKazVyjw0BLDa1E05wLhf@vger.kernel.org, AJvYcCUkkxmBETfMgdbhaYBLPBnV03a6PiF5/W3oIiJgA//fOOZhgPficDzr4baA+T429BiKrm41dEVf28MkZuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGGLKn+TQylIxvX8Olmavhy9njBuIW4qf9ZGBX6p4qnj0Y+Lhj
	h4ZCZ7PTY2N7lQsF05fhrdLsD0jnD9/M11ShMyxUDuXe2fxsQ2vh
X-Google-Smtp-Source: AGHT+IFvNBxDQEa0XGqcHuykNEC8Z3ZPUOEa6O9cnvLrigfOqfS4ak9C4O+mvE6nDpNsQphiBcRekQ==
X-Received: by 2002:a17:90b:4f8a:b0:2d3:bd6f:a31e with SMTP id 98e67ed59e1d1-2e1e636f8d4mr20800603a91.28.1728397452418;
        Tue, 08 Oct 2024 07:24:12 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f68a8sm7675987a91.36.2024.10.08.07.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:24:12 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v6 02/12] net: tunnel: add pskb_inet_may_pull_reason() helper
Date: Tue,  8 Oct 2024 22:22:50 +0800
Message-Id: <20241008142300.236781-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241008142300.236781-1-dongml2@chinatelecom.cn>
References: <20241008142300.236781-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function pskb_inet_may_pull_reason() and make
pskb_inet_may_pull a simple inline call to it. The drop reasons of it just
come from pskb_may_pull_reason().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 include/net/ip_tunnels.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 6194fbb564c6..7fc2f7bf837a 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -439,7 +439,8 @@ int ip_tunnel_encap_del_ops(const struct ip_tunnel_encap_ops *op,
 int ip_tunnel_encap_setup(struct ip_tunnel *t,
 			  struct ip_tunnel_encap *ipencap);
 
-static inline bool pskb_inet_may_pull(struct sk_buff *skb)
+static inline enum skb_drop_reason
+pskb_inet_may_pull_reason(struct sk_buff *skb)
 {
 	int nhlen;
 
@@ -456,7 +457,12 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
 		nhlen = 0;
 	}
 
-	return pskb_network_may_pull(skb, nhlen);
+	return pskb_network_may_pull_reason(skb, nhlen);
+}
+
+static inline bool pskb_inet_may_pull(struct sk_buff *skb)
+{
+	return pskb_inet_may_pull_reason(skb) == SKB_NOT_DROPPED_YET;
 }
 
 /* Variant of pskb_inet_may_pull().
-- 
2.39.5


