Return-Path: <netdev+bounces-118831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7B5952E79
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B660B285BF3
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509BD19D885;
	Thu, 15 Aug 2024 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOTTKMSz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BDF19F49B;
	Thu, 15 Aug 2024 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725965; cv=none; b=kAUhAZknmA0Q9wpA3uyqRd+kF6qOWTHBuZ6dazc1N4pXmt17PIH1NtNu+N+0Fj+20cjrGjjDU8V0BfrXwBe5Ov1+/idkVrOD0BtInnA/PnxtWe1sD8MhrJo7zCezfIFZFKC9TDTruRZ9oIAc6aIPffGRt1I7aPIqLbXf43mbrfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725965; c=relaxed/simple;
	bh=al8FeJDNANmBeWYeB5orKViRkkRdMcv1FPWSbriMh1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=siopsPY42kXRN6t36G0C36bCwH0y4H9pAGcGcwnmDP8a4xwpiPd2hVr2najFFG/f+AQqIMg2lgLW1NHbzgnXY6AnABndDohwNjfOcB9JjEX5FIqXRc9S3AkFcspRq8rylw3F4VcEqLnePPtttpP3KurUFRlCS6tj52pp+sfGEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOTTKMSz; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7163489149eso717496a12.1;
        Thu, 15 Aug 2024 05:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723725962; x=1724330762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAYPfmQdBURVtmFJo/kNdkK9wo4RhP92Q0e8N3nnuIg=;
        b=YOTTKMSzTVg/E2Y7REQQdWg9FoMc3Ye/QrpMG3rEKS1NXCVvlcBPPV5igb7Yq2vQgI
         76w6v81PFvRGaCzvDhPeVC30OGaH/HYX2fSUKNHaNG2R7TN95bhOQdfARyjqdG5lrkRt
         B0sMdBCSfn1SSIAAS+yz6r+dbiVeWpFjLTDIyHN13TDTQYVDWv52dfhMPnk5hV38Gvjx
         wOOvcSGlw0oOqgacYJJYoF/TWef7w+SpF+rbrl5/Wap4SH/EZXbJbac9rqosJSuk63fW
         K8uVzU0r9ru4Xf/2K98b189GGUu/pLcDtsBUmUwX/n3C/FT0Oa9nWesm+QLwe/uAD61C
         Scng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725962; x=1724330762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAYPfmQdBURVtmFJo/kNdkK9wo4RhP92Q0e8N3nnuIg=;
        b=OVH2VlZSKFPLSYyZycJvCnGQ2yROErv2fjnsASLzIbjkXBiG6z1QJp8n9YjaIDFjW1
         aIp8sdgLF+1XfvFNd2XXjHbAIeG2wltmR7f5fcN/d2+G5nxj+/C60gEaGWFBOoAQoJj9
         xkR+jMPTVmqebSqf2Uwr9eegD2jfhcHGa8a6vSYMUuCblGCb2ijwi71nQI9ph5zTBJ4f
         LElHdt4Kk4H4hHdve3XwUBpqPmGZgWBzHPPrXFi2MEJ+Ig9DYjs9ykR/NT3qKwapb9Dj
         kg+1S5+PAoyADfdhSoJuquZOTb6PeE2gvLzlvn5BO7nuq/18RLKG7pdyWvQKtsn8GP0o
         IhLg==
X-Forwarded-Encrypted: i=1; AJvYcCUdJKxLsGWi05ZsO0M/A2mmaBdEqvi73iSgUZRay+6Ox16Y6yeGZdM5g0dLAsqJntigaFS8RsWgEKLwsv0=@vger.kernel.org, AJvYcCUo1N26kdbMIj+0g0VsuPCVlSNTjasc7V5jdK2rl2f9GNONK9BH5FDLJVYAyzMWqrG/mnEuNADm@vger.kernel.org
X-Gm-Message-State: AOJu0YwpAKlcMpiQIq2cTSGAywHoH+70+DFzYizHewHBIh+BUD60djQs
	CFmh809Tw0s9KqhRXN5xY41qRIGgG92rd0wGrYUKclWSCg2Heil4iZ1ajEGL
X-Google-Smtp-Source: AGHT+IHsnR0ieo0N7TBiEGpR5o2UiXO9Njg/AGFXhLg6fbxKtIkB9LaI39JJnqzTgOQn6Y1tVbVbTw==
X-Received: by 2002:a05:6a20:d70b:b0:1c4:8bba:76e4 with SMTP id adf61e73a8af0-1c8eb046c44mr7587095637.50.1723725961651;
        Thu, 15 Aug 2024 05:46:01 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af2b942sm923605b3a.183.2024.08.15.05.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:46:01 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 04/10] net: ip: introduce pskb_inet_may_pull_reason()
Date: Thu, 15 Aug 2024 20:42:56 +0800
Message-Id: <20240815124302.982711-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815124302.982711-1-dongml2@chinatelecom.cn>
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function pskb_inet_may_pull_reason() and make
pskb_inet_may_pull a simple inline call to it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/ip_tunnels.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 1db2417b8ff5..12992aa792fc 100644
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
2.39.2


