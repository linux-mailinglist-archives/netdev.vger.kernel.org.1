Return-Path: <netdev+bounces-93348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9038BB3D9
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 21:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EB2BB22EBA
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 19:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A38158207;
	Fri,  3 May 2024 19:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1nz/n6w/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF7F158D78
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764073; cv=none; b=jDR9Pihxa/+WBYQGn3qmbk7xqpZbS4VEGfhxVkJxE7SsGa6ZJU6uFGNZx7FH4Q/YzppTHITa1GJQLV8xFMN9d2MrNqyxJK8XXH6MoPYmM8b62O/GU4wqaQpgFALHXHylFrrdrM+Ym3BY8SGCi+DhwSGidK4j6KBS4k10EAhqQCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764073; c=relaxed/simple;
	bh=VNH8X+mNursyIytidxBfk4zTvCG/6MbN9TDD/UEIU3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oES7vfYFcjECDMVOyvbC7Od5v64rq4IkTzKw2fBa5cf/r81PWy+z4Tid789M2m5SAn/ZHFgcOTddRsnsphtU40mbv38XNFynHPS2TBFmBi2RO4mC4TypDQwXOKXayh5G8UNYJUjoLXSSii4uzBih3rCJn5odyg6KHBnD54L/BAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1nz/n6w/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ceade361so111017276.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 12:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714764071; x=1715368871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NlLV9C8iwKrRlhE5CROAsvA0PyY8Z7OdesQFV96MNlM=;
        b=1nz/n6w/0DB1F4UoZpH0YVSwuqvqIn1qV/XyQOptRCwuG4N5Xm3A6T15e3+4y8A/RJ
         CSpXiNz4MLqkKeUQgyxE5vhQJubgZm6RQShv0kB0bOJuY2sD3JTmg87QT/3PZAQWaFAB
         WW6ps84XjSgDG++h4Ov58fVXtdOdn8q5Xn+C5qGpTltdcBbV1Bssvm1KtaysizEwv7c3
         DxsN+IWaFo1QGDsNUEdF3n9un6cKE3iyJXdRroY903+1RUVifNvot8mR8qlvoy/Zyxcq
         o4pgchekf8DE2uGk4PEIvDE2hyvej0TFlaH1PMHpoe13PLRwPUGtNPoa0Sph5IyJg+Bw
         mZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764071; x=1715368871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlLV9C8iwKrRlhE5CROAsvA0PyY8Z7OdesQFV96MNlM=;
        b=wAKbosHP/53PZ0TzA9D55O8wdOEViPxyxJ/8w53yZIKnZe3B8IzWzZpUlqkbRYkqVo
         TF1LZnVQgOmdQVLOgmr2fIGTTHQiaeb0aODLtaDrf2EX5sbb1d+Atr5I531HL6rWn2kN
         2YogXw7aKoTaMXxkdXYaAYECpKETihtqvWDdCcOmYZZSyNAS7MT5GqDXmGhmDHt3S9Dj
         C4CnB4k2CRFYC0ipK0oW7AuU+sCL3KZDZznvcIsqb71ztYkkw8wDTltlvwUi5ypdSGgT
         AUMBBlRYlBpS5EGg22nUxpe6RPyYumgXJ100vPFQ7/U1ZwPHVP7zM+5EwczRrr9dhexa
         jWUw==
X-Gm-Message-State: AOJu0Yzof9OsLZ9Brpiy9NRMyo8ScL6wlTq9Lg4C4J9MSiYO9GSeXA2x
	RqG+cZBhQ5A9MeMrharGzjxkej8McfBL4DnTuHBEdz7OTiYdD+OclZ87gEH4a9stTTksAyJyYa+
	KwJgzu6Gp0Q==
X-Google-Smtp-Source: AGHT+IGLPPg7j+diEojT83ezz8AofHKrsdleln61wy1V3x3Ny1PrxcrCmIIps+hkNf1tVUcEn1FJVBkryn4cRg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:701:b0:dc2:398d:a671 with SMTP
 id k1-20020a056902070100b00dc2398da671mr1068931ybt.10.1714764071377; Fri, 03
 May 2024 12:21:11 -0700 (PDT)
Date: Fri,  3 May 2024 19:20:58 +0000
In-Reply-To: <20240503192059.3884225-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503192059.3884225-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240503192059.3884225-8-edumazet@google.com>
Subject: [PATCH net-next 7/8] rtnetlink: do not depend on RTNL in rtnl_xdp_prog_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev->xdp_prog is protected by RCU, we can lift RTNL requirement
from rtnl_xdp_prog_skb().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 6af7f00503b43d4989d0aaafc8b968216a6e77f5..66e5be7b92686deb03f58ee43c9707470b8c70d6 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1477,13 +1477,15 @@ static int rtnl_fill_link_ifmap(struct sk_buff *skb,
 static u32 rtnl_xdp_prog_skb(struct net_device *dev)
 {
 	const struct bpf_prog *generic_xdp_prog;
+	u32 res = 0;
 
-	ASSERT_RTNL();
+	rcu_read_lock();
+	generic_xdp_prog = rcu_dereference(dev->xdp_prog);
+	if (generic_xdp_prog)
+		res = generic_xdp_prog->aux->id;
+	rcu_read_unlock();
 
-	generic_xdp_prog = rtnl_dereference(dev->xdp_prog);
-	if (!generic_xdp_prog)
-		return 0;
-	return generic_xdp_prog->aux->id;
+	return res;
 }
 
 static u32 rtnl_xdp_prog_drv(struct net_device *dev)
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


