Return-Path: <netdev+bounces-92236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF42B8B6132
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 20:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1749FB21275
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 18:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA40F12A146;
	Mon, 29 Apr 2024 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMH/AINQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A2E8592B
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415806; cv=none; b=vDQujew91u/bb54dmNgtLWetEIguKoY+mER8W/x4nv6jLDatlKccZGntKIhdc+ZEznub9Hx3mDltsrXrNFnNU6R4hG5b/jabkqrVYm697HkUn4izfT2BgQYn/Xf9+Y71fy2koVYBnwxmxM1JKk1LxeP3yRxlwnNaEMPDyg4ycu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415806; c=relaxed/simple;
	bh=/9yF00uPTY45eY+mtMWXUdod+TyzSQg4k6Wsi0nYkig=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jEG1KjW+znKTQD5mPsvjJzbG0f39+UAhG/dpWI2A1+U5QSGrAzGp7NE1klYoZT/67mUcp7R0IxmiVRDhJLDiMLCd2fja+ucBC7LBbJdKkJ8OZVjd9mcJFPJzvqW+2x7/ia1xr3nad+siKu1T4ig0hyXbYw1ckvPCkqn1uyhjr48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMH/AINQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-618891b439eso74886807b3.3
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 11:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714415804; x=1715020604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WKIA6swcPY3s1b77BB4hvTzuXbmWGFcpA5AbXMeeSRw=;
        b=SMH/AINQegX8dPbPNdDPI4GPwdrOzsFCf/N6OCT4Xnb+fa+8Ho5eR6+HsAMKqvDy+4
         rd+/EejmivV6wsX/+ko1jG4gZ4c6o1uBhmJ3uHGAzAOT+m+nF+eOLYJXXXy0ynkpa4G/
         1n8IjuD3b917u47Wq+M9NcmizyElWbfx4t/k1HTASlUtybfa1/N/yo98sF6lF3ewzaAM
         j6/PYDFafckXiXtW2P5krxYGrcmNEZpBLpvBxbLa74KjLqcy3FBf5DhNgW1rDPhbaizi
         P4Z0PNP0/gxx7OMmzSME6HfvFwU8cZUqroZ8J41UKcQTj1mrY5rQ3gh2JHY9bUqtBIgD
         CxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714415804; x=1715020604;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WKIA6swcPY3s1b77BB4hvTzuXbmWGFcpA5AbXMeeSRw=;
        b=PaZNvp0oQXg9be2KjMY3ic+QGO/BdlJjJH4mAse0Dfo/ElDZ6fquNGcXDg5i8McFEa
         bdJ5k4qTPhLtidAqF5/85q1aYwS52gLnNszqR3LG0pjuNwR7iNq0o1dTa3AQbJzxxFwX
         gfJnrEV/6z9qnd780VDEDYTbHCrAQtF0JeXVNWnQSqtXyQml8Lm1A/SNlH97sAhkdCgn
         5P4x8ewEZkPFtgPKg4ZpT8DIS84Cf3O657E/Il185OeOxEAWb9ekPm5Mkcb51YD9UMgG
         v8OOa4JD/g6eH6P0AuTGZw0NviW+HFZshMrQzj6Ko10eamQsaobOvItSdUiFLKFI8ZA9
         kkog==
X-Forwarded-Encrypted: i=1; AJvYcCXlalrb9vLIY+znjIavGV+i4R7qCRb4D33mHXorkV56qTv69fsaJ8WT6NvDU8AGyXKIpO83b3ZrdWsH5FaEOAnVZG8UuH/W
X-Gm-Message-State: AOJu0YyHcOf8pqRfvdf50VgPtgAg69TOjI4MBHGNwk1e7HOOUQa5GuDP
	fxm/UvxyRdIAhgiLfuGQe4c5PPPVOHQO2rgN24gwpeUgG1pK62l9U4UTDRlWYNUH+1m+E+w+kWP
	MYvydWVANlg==
X-Google-Smtp-Source: AGHT+IG51emMWBAb5be69d9MQl1/V5hFaTMj9Bqf3VwMtQQzMWHTK2uBy6JPz3aO5GNa/xiOHOh5NwP/mFOm/Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:f88:b0:de5:2ce1:b62d with SMTP
 id ft8-20020a0569020f8800b00de52ce1b62dmr1196548ybb.10.1714415804319; Mon, 29
 Apr 2024 11:36:44 -0700 (PDT)
Date: Mon, 29 Apr 2024 18:36:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429183643.2029108-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: anycast: use call_rcu_hurry() in aca_put()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a followup of commit b5327b9a300e ("ipv6: use
call_rcu_hurry() in fib6_info_release()").

I had another pmtu.sh failure, and found another lazy
call_rcu() causing this failure.

aca_free_rcu() calls fib6_info_release() which releases
devices references.

We must not delay it too much or risk unregister_netdevice/ref_tracker
traces because references to netdev are not released in time.

This should speedup device/netns dismantles when CONFIG_RCU_LAZY=y

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/anycast.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index 0f2506e3535925468dcc5fa6cc30ae0952a67ea7..0627c4c18d1a5067a668da778ad444855194cbeb 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -252,9 +252,8 @@ static void aca_free_rcu(struct rcu_head *h)
 
 static void aca_put(struct ifacaddr6 *ac)
 {
-	if (refcount_dec_and_test(&ac->aca_refcnt)) {
-		call_rcu(&ac->rcu, aca_free_rcu);
-	}
+	if (refcount_dec_and_test(&ac->aca_refcnt))
+		call_rcu_hurry(&ac->rcu, aca_free_rcu);
 }
 
 static struct ifacaddr6 *aca_alloc(struct fib6_info *f6i,
-- 
2.44.0.769.g3c40516874-goog


