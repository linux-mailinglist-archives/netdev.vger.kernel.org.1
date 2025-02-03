Return-Path: <netdev+bounces-162111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3B9A25D3E
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8F83A9D79
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD6620E315;
	Mon,  3 Feb 2025 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NqKFCO0s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF520E03B
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593058; cv=none; b=Z/Cty6KkvERTdYTFaTgqxMy9YjNtAJO9h+31MCWX44prdvcAu3KrDDdUthbFWaPqSedwKFxl5Fb1HCUJ4TbrLHq/BdTPni/+tmq0TclDBb6hrFe11aom+Xa03uJZUacNWICoaltNxcOCgLKgGN1PV2CB6wTD+ukVZRyeyO/4DOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593058; c=relaxed/simple;
	bh=Y9lnsb8QeKEZFqBhSW8yGtosBM6Zj3i856YbOAw6C2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dqvcj8TzlubH1w9oHEW04AHIN6ZYGTJgthGpKlxQn5UM2IFgmcC13i4Oz+NioymMnxS6BHNOao5d615N2UgMDnTqytxZHXQJwLSeuwWV79aP/I8inXzAXP6QTIAWBrxqKT5Cjx0HhiZ6HqUY+FM1DSizFI/o+STQSfyK3d9mEVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NqKFCO0s; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-467bb8aad28so46818811cf.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 06:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593055; x=1739197855; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YaNwdpwj0e4SW/9x+BMfHLkop9sD36jHDjUBDn3qdiI=;
        b=NqKFCO0sjiAh0H47g6Ns16HTUFRUcugsfYA0FYAc7l8QrlmEDw/73k3SAH5R8K+s59
         RAOc8TSls1Kfuc2tQAT5C8OvkGwWN7Xi2WmGs3Y3cubpdTyzTiihFSbqmuAY1+Xs2owh
         05x45Dp8vuPoaLrrSnKtMcjokHoDeLBDd9u+bZlsS+zGhPdsMDoZNQuj+gdtdSdyip0m
         CopTghXFA05uZzgEBeEfAmEZofDZVqsv9bObTDLPsmKaBdCvA6R9aVMeziyMefo3++Hh
         +EGCONpudcPhDp28m6GB02mLTS9565XiOxlYxF265fxp+Cy30lBI15HpmzIsY3Ui0+4b
         TgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593055; x=1739197855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaNwdpwj0e4SW/9x+BMfHLkop9sD36jHDjUBDn3qdiI=;
        b=VhmlJKgwOTrN4ktYgQVEwLbyWOpvCzRO2bDZe6g4uaYSRt1dBXgjjULzwxxykwc+/o
         NF8dze+fmcBKRxBX7lIPLv5nJmZdeCWZYZV5t3VUsN76u/FoCtoGRE0VZfMWCZ4AOH9T
         iTSlZo1afJft81HN8gtq48+UtJt2Btyu8HWo6vDmDPStzECsMO3HHu30Y2Rq5/2kghfB
         3ycNc5Nc717S/tdLzhIrutrWN0YUwCTaSDt3Bv+SpK/TaWZukbRytHPT2nSPX70uedxK
         Mo00D9lThC0FuFuCesFGMetKb+3rq+Eyayp+12lkGgCWjaMW7gjK4KWr4cmiPuG0j7Lf
         2LCQ==
X-Gm-Message-State: AOJu0YxP6XwRLkf5uFBeiB8FiLVmOVr/k8Q3Bmqh3FnjgwIwx8RyRZ7h
	0x8DP+e4r38wvaLRdPw4gFvOdyCDpE5QOcBJcH9JvhHh+LFZMseX6QFhRVeRUSzcoKIcY+aIdyU
	avXO6fBvt8Q==
X-Google-Smtp-Source: AGHT+IEmBA6uy6sB/rbIMfbv+7lcIPwmKa0t5mGZC0SdBk+3OOjtdyKJJv4t2fbCxSC+F/ZH0g9y+OdbXPUnRg==
X-Received: from qtbfz8.prod.google.com ([2002:a05:622a:5a88:b0:467:6227:451b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:584e:0:b0:467:79eb:4a16 with SMTP id d75a77b69052e-46fd0a114abmr336560961cf.4.1738593055664;
 Mon, 03 Feb 2025 06:30:55 -0800 (PST)
Date: Mon,  3 Feb 2025 14:30:35 +0000
In-Reply-To: <20250203143046.3029343-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203143046.3029343-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203143046.3029343-6-edumazet@google.com>
Subject: [PATCH v2 net 05/16] ipv4: use RCU protection in rt_is_expired()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

rt_is_expired() must use RCU protection to make
sure the net structure it reads does not disappear.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/route.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 74c074f45758be5ae78a87edb31837481cc40278..e959327c0ba8979ce5c7ca8c46ae41068824edc6 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -390,7 +390,13 @@ static inline int ip_rt_proc_init(void)
 
 static inline bool rt_is_expired(const struct rtable *rth)
 {
-	return rth->rt_genid != rt_genid_ipv4(dev_net(rth->dst.dev));
+	bool res;
+
+	rcu_read_lock();
+	res = rth->rt_genid != rt_genid_ipv4(dev_net_rcu(rth->dst.dev));
+	rcu_read_unlock();
+
+	return res;
 }
 
 void rt_cache_flush(struct net *net)
-- 
2.48.1.362.g079036d154-goog


