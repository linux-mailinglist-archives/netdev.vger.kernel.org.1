Return-Path: <netdev+bounces-76144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E5386C830
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 12:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111F81F26114
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 11:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3017C6CD;
	Thu, 29 Feb 2024 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3M9PoHcW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0B67C0AF
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206823; cv=none; b=SRWWwVK0Ox4uTp39mCqIo6BTteT011tYBHg66hQtsdgr/A6ZFOd6FzYi9zFPUUtorqbxZDbWeNjcrcKq/UM95x2Sn5yeDncQSxcy0okIMrApP/2p4oMrByAG7X+1Hs8TaR1vOIK0kGDJJi+Is91yONU97v4GP1bqt1QWDvEaWe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206823; c=relaxed/simple;
	bh=cVyyoC8uRMiNRa3QRFMIsF1AmOsna8lSTCGY6/0I67o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kQohmNOv//XNp3I9YYEv23LQ+CxEkqtfg6w/Vp1aKCxnDpHfGxn3gi7EmezIPaID1cMHlGt9pXVELYoS8S8WlcdmJiZSFC5Sm7sJeppovKzt5AwVaBV9q8bLtnusR9RIeMzvBQ2Oc0UYUfET1SgkCag+GhxLm1xp6cxSGflOUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3M9PoHcW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60904453110so10153477b3.2
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 03:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709206820; x=1709811620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hGkMaRngnW9wJm+sPsEK9bpLE7Z7kQJwZ6Bj2PHOdBE=;
        b=3M9PoHcWoPZxXjzO5+DhMMA98i8KYNuugQJnoCAmn+PVtGJUsLRxwfzrEIv7pVxm5k
         jzKjbN/IxPNbldWDqGWydGdIet1EDjEiFgXwhJiBDVscX/v+9NGkkGLtPOLnfmlbmNC/
         RI09/YT7RAMlPYZvPNXNu7W+PHM+AsQ2P7bN9qV0OEFVUJYvqaZQEPn8Qo9kaEbif086
         kfZvGMNp5yAulvsWA48voWq5n6WfibQQSrG8QEhF/aP8j+SqB3WHHpgCm7r1dfyz1LAE
         zxwZWf1+KaPC1TV/qYw/gumAKMJEJ/YmNhCsMuYVnQZ1n43DAw/hg4+xEd7icBkLMwi5
         LcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709206820; x=1709811620;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGkMaRngnW9wJm+sPsEK9bpLE7Z7kQJwZ6Bj2PHOdBE=;
        b=QyBQ3FhswdrrE8ASorsyUhvS0OOLo5+e9jaMWZVhcSm9q8n25ZFwU96kdRX7UXc/Qc
         i06b4sGh97tQpTZJNilYzc1b/l1ZArHKEMeP3Znoz6b5jNbne1QDfbcyZIFwuB0WmKom
         /PPwOl/w7sga7INgdAFjEkrR/R1CAiK5oFqt/6FtteyhpJdvqjaRO7M5ZnBPyBwnjTQc
         Sw4Dge8XdVrhLw18ADwI/tKKrAs1mT5y44gT0VkzHosET8Qwvq0wUIkhEc9qrx+Rj212
         yz7KKE/3GoZQRHP2bIQwbxW/hZ+fHApYXAgQHLlape/dNeQkOI7epxlPfvE+uJHWJiLn
         uAJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjP70LguWVk4m0/5mUYbtipHwUHyIy3PV6moXyLY8nL5D1ZXCQgMMwJVZf8L/UhSjlMh7zZevzSS8vkkgIM+r23o14mMtd
X-Gm-Message-State: AOJu0Yy8nXy7XjMI4RwVqNneofLF+DU8AVLcQHCp+3vDvvWEM06cFc2N
	KwbkY7uyLeiKR1cFfZfvbSjGd/YdWnDEG0QMtSO13rc70L899S8aMEbaJgXvE+7uYZKvpOtJl4q
	GQJsBFGjImw==
X-Google-Smtp-Source: AGHT+IHGUPWZeZfbfmghHKLFz20FXGw5V1Rq9nRs6cQHIAqXEzdiZo93bD4NwqlZq9Vz4HX1UJIZ17yZ7JF7tA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:c0d:b0:609:3834:e0f4 with SMTP
 id cl13-20020a05690c0c0d00b006093834e0f4mr455681ywb.7.1709206820342; Thu, 29
 Feb 2024 03:40:20 -0800 (PST)
Date: Thu, 29 Feb 2024 11:40:11 +0000
In-Reply-To: <20240229114016.2995906-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229114016.2995906-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240229114016.2995906-2-edumazet@google.com>
Subject: [PATCH net-next 1/6] inet: annotate data-races around ifa->ifa_tstamp
 and ifa->ifa_cstamp
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@nvidia.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ifa->ifa_tstamp can be read locklessly.

Add appropriate READ_ONCE()/WRITE_ONCE() annotations.

Do the same for ifa->ifa_cstamp to prepare upcoming changes.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/devinet.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index af741af61830aeb695e7e75608515547dade8f39..1316046d5f28955376091d9e02ab4594e19fbd09 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -713,13 +713,14 @@ static void check_lifetime(struct work_struct *work)
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(ifa, &inet_addr_lst[i], hash) {
-			unsigned long age;
+			unsigned long age, tstamp;
 
 			if (ifa->ifa_flags & IFA_F_PERMANENT)
 				continue;
 
+			tstamp = READ_ONCE(ifa->ifa_tstamp);
 			/* We try to batch several events at once. */
-			age = (now - ifa->ifa_tstamp +
+			age = (now - tstamp +
 			       ADDRCONF_TIMER_FUZZ_MINUS) / HZ;
 
 			if (ifa->ifa_valid_lft != INFINITY_LIFE_TIME &&
@@ -729,17 +730,17 @@ static void check_lifetime(struct work_struct *work)
 				   INFINITY_LIFE_TIME) {
 				continue;
 			} else if (age >= ifa->ifa_preferred_lft) {
-				if (time_before(ifa->ifa_tstamp +
+				if (time_before(tstamp +
 						ifa->ifa_valid_lft * HZ, next))
-					next = ifa->ifa_tstamp +
+					next = tstamp +
 					       ifa->ifa_valid_lft * HZ;
 
 				if (!(ifa->ifa_flags & IFA_F_DEPRECATED))
 					change_needed = true;
-			} else if (time_before(ifa->ifa_tstamp +
+			} else if (time_before(tstamp +
 					       ifa->ifa_preferred_lft * HZ,
 					       next)) {
-				next = ifa->ifa_tstamp +
+				next = tstamp +
 				       ifa->ifa_preferred_lft * HZ;
 			}
 		}
@@ -819,9 +820,9 @@ static void set_ifa_lifetime(struct in_ifaddr *ifa, __u32 valid_lft,
 			ifa->ifa_flags |= IFA_F_DEPRECATED;
 		ifa->ifa_preferred_lft = timeout;
 	}
-	ifa->ifa_tstamp = jiffies;
+	WRITE_ONCE(ifa->ifa_tstamp, jiffies);
 	if (!ifa->ifa_cstamp)
-		ifa->ifa_cstamp = ifa->ifa_tstamp;
+		WRITE_ONCE(ifa->ifa_cstamp, ifa->ifa_tstamp);
 }
 
 static struct in_ifaddr *rtm_to_ifaddr(struct net *net, struct nlmsghdr *nlh,
@@ -1676,6 +1677,7 @@ static int inet_fill_ifaddr(struct sk_buff *skb, struct in_ifaddr *ifa,
 {
 	struct ifaddrmsg *ifm;
 	struct nlmsghdr  *nlh;
+	unsigned long tstamp;
 	u32 preferred, valid;
 
 	nlh = nlmsg_put(skb, args->portid, args->seq, args->event, sizeof(*ifm),
@@ -1694,11 +1696,12 @@ static int inet_fill_ifaddr(struct sk_buff *skb, struct in_ifaddr *ifa,
 	    nla_put_s32(skb, IFA_TARGET_NETNSID, args->netnsid))
 		goto nla_put_failure;
 
+	tstamp = READ_ONCE(ifa->ifa_tstamp);
 	if (!(ifm->ifa_flags & IFA_F_PERMANENT)) {
 		preferred = ifa->ifa_preferred_lft;
 		valid = ifa->ifa_valid_lft;
 		if (preferred != INFINITY_LIFE_TIME) {
-			long tval = (jiffies - ifa->ifa_tstamp) / HZ;
+			long tval = (jiffies - tstamp) / HZ;
 
 			if (preferred > tval)
 				preferred -= tval;
@@ -1728,7 +1731,7 @@ static int inet_fill_ifaddr(struct sk_buff *skb, struct in_ifaddr *ifa,
 	    nla_put_u32(skb, IFA_FLAGS, ifa->ifa_flags) ||
 	    (ifa->ifa_rt_priority &&
 	     nla_put_u32(skb, IFA_RT_PRIORITY, ifa->ifa_rt_priority)) ||
-	    put_cacheinfo(skb, ifa->ifa_cstamp, ifa->ifa_tstamp,
+	    put_cacheinfo(skb, READ_ONCE(ifa->ifa_cstamp), tstamp,
 			  preferred, valid))
 		goto nla_put_failure;
 
-- 
2.44.0.278.ge034bb2e1d-goog


