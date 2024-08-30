Return-Path: <netdev+bounces-123553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E579654FA
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886B21C22589
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B062184E1C;
	Fri, 30 Aug 2024 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5V2nW6E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363DB82481;
	Fri, 30 Aug 2024 02:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983362; cv=none; b=a6IG4sM35AIL/J8ewYJSYbx8CpZnqMcXMjpaSFqkKESnpiAHscpxVfRWDZtJuiIFSLTCZ9CUe0EezKeHO7EVftBwuAJgLemK0DS4UwP0WDowTO3WPaQbzozJ+Fsxw5/e2YYbK4qTKtbu22z6Z1T4OtB38pVuO5ekno8f7hLa0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983362; c=relaxed/simple;
	bh=/4tYqzlI0k4OL2sr+CkSR4OEplhZSoi5mzkyfIT1S7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sabjaho5NXxTTCho//yUrZUqPty7N264jbXqE25v3eBdSspEEDEorfbNimGJeo9+v8ZgzRrTHC3TeVc5NauEOLjPRHbphUICS0Lfie7xAdycOP2AyfRqLzIpmc8GcgxZ7rTCW6XCnbHfwtlrEu8KHhaYZvZmL8CRUZiuZ6lHONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5V2nW6E; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-714302e7285so1156378b3a.2;
        Thu, 29 Aug 2024 19:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724983360; x=1725588160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aA9owP7+Y0gC+y2zV5nnvicSUsa9DffbmtMLeqm5GkQ=;
        b=Y5V2nW6ENB5J2wfzU94wyWxK8hSOWjvpi/rtCwbKjzjZZly+6fftGxENgPHHaINtKt
         7+F67IxUqZITZOTK5FLGQJXVsOhQ9F7n284vvgnlmhsQLY7Tr8dZneTk5na1j4vcK/Up
         dbYWfbQl/3dkN54uIgIJ2dPZ62z7YuA23IfCj5u9vk4UwLPPZxW3SQHYCOHsBPm0WBxJ
         6jtvZFUFgmnxSAxwKIyGs02XguKggYCUSJ5QXJ9Ia/QoGg1UouPXp+xoR2n3q2xdZJmB
         n4S/r1M+EcX7SvJo0Wx0yf74tE3UONX348sJGQ6LaRTYXf9OBbaSmOJb2Jwl1pip3UD7
         Aqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983360; x=1725588160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aA9owP7+Y0gC+y2zV5nnvicSUsa9DffbmtMLeqm5GkQ=;
        b=gsQlZdTQ/kfCV2YkxekT0vA/u3vrzV3/Sy1A4LuvHIiYELnjpbI/QJTT6PeaMYu/aw
         TpfqFSF9CYimLcvvn2sh3NadZw46MGsjRdj1pL2SnFUeQl8jocMrolOykA5MSYFOPl+k
         jE+pGsqiRaGdyM90roU0Vo4CIq7/mSMAgC56KWVgvL2ccMTd+mV99QDtZmIUxS5zJw9A
         xkWebK4wpJBpnC6Yp+dWKnxZqruh7e0jH01JupetBSPpbmSfa+pXatjHPgi72+TVLv0W
         8WOx9xzC75mcxhVkl6zeUgaY7DpcSOQpyiP9ZLyjmN2YeqBtt0pVm8seWxdwfhh3XpNZ
         idEg==
X-Forwarded-Encrypted: i=1; AJvYcCU5ybyBcHH1WUrw7A1eSZ3uu2vniCC3LYTGkRCICK8LP73O5EQEALcsBhzbX3Y3bDbUdJfFT2Yf@vger.kernel.org, AJvYcCW/+rRRBOPnggxw+Nnq56ooolHerrvFbQW0BZVn1K0Ery7ArX5rIX1MRlPrM032PeynP/gnmRwqOIgN50s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvwsSWCc0HruIdoPAOzW6kRk7sV3TsVOP0igrqv6RfEynYr1Hm
	paGnAtFCO/HFgtE7Hg2qpcu1jAQfvTRjJf8lsYMbcUJcL30tjru0
X-Google-Smtp-Source: AGHT+IHd2TIKcKnwWdOXnb5BGaCutJq3T3Ami4HHCR7A0v3kN9CLnnSb/ED3bb5WQgenQ6c9JHhP4g==
X-Received: by 2002:a05:6a00:2e96:b0:714:25ee:df58 with SMTP id d2e1a72fcca58-715dfc50607mr5898452b3a.18.1724983360303;
        Thu, 29 Aug 2024 19:02:40 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a6b60sm1764221b3a.87.2024.08.29.19.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 19:02:39 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org
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
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 05/12] net: vxlan: make vxlan_remcsum() return drop reasons
Date: Fri, 30 Aug 2024 09:59:54 +0800
Message-Id: <20240830020001.79377-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240830020001.79377-1-dongml2@chinatelecom.cn>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make vxlan_remcsum() support skb drop reasons by changing the return
value type of it from bool to enum skb_drop_reason.

The only drop reason in vxlan_remcsum() comes from pskb_may_pull_reason(),
so we just return it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/vxlan_core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index fcd224a1d0c0..76b217d166ef 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1551,9 +1551,11 @@ static void vxlan_sock_release(struct vxlan_dev *vxlan)
 #endif
 }
 
-static bool vxlan_remcsum(struct vxlanhdr *unparsed,
-			  struct sk_buff *skb, u32 vxflags)
+static enum skb_drop_reason vxlan_remcsum(struct vxlanhdr *unparsed,
+					  struct sk_buff *skb,
+					  u32 vxflags)
 {
+	enum skb_drop_reason reason;
 	size_t start, offset;
 
 	if (!(unparsed->vx_flags & VXLAN_HF_RCO) || skb->remcsum_offload)
@@ -1562,15 +1564,16 @@ static bool vxlan_remcsum(struct vxlanhdr *unparsed,
 	start = vxlan_rco_start(unparsed->vx_vni);
 	offset = start + vxlan_rco_offset(unparsed->vx_vni);
 
-	if (!pskb_may_pull(skb, offset + sizeof(u16)))
-		return false;
+	reason = pskb_may_pull_reason(skb, offset + sizeof(u16));
+	if (reason)
+		return reason;
 
 	skb_remcsum_process(skb, (void *)(vxlan_hdr(skb) + 1), start, offset,
 			    !!(vxflags & VXLAN_F_REMCSUM_NOPARTIAL));
 out:
 	unparsed->vx_flags &= ~VXLAN_HF_RCO;
 	unparsed->vx_vni &= VXLAN_VNI_MASK;
-	return true;
+	return SKB_NOT_DROPPED_YET;
 }
 
 static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
-- 
2.39.2


