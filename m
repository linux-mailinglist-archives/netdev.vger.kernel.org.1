Return-Path: <netdev+bounces-73965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFA585F7DD
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0361C2214F
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A4545BF6;
	Thu, 22 Feb 2024 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OeYHqHWF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C4D2BAEB
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604270; cv=none; b=bEeHpArbNw5+r7r47FCNvDMezZShrj80rwOoowTaENH39qjtfqSuuOxlZFHf7a5VEqT8mMD/+a+oVsqsQQMKYUu4+x64wDvHmiP5Bk+PBxaQwDlp8xgRYF+IZwBCozaXT+4FAV2RWIV+LLuaufnZFKsTkBeVKy3uTyH5N5hQPZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604270; c=relaxed/simple;
	bh=UHcy0y+mEFY8c93GDhh/CijGg83CZRWr1fwMjrmqZQk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EIKZ24YL8OmqlObX5K0vxreHvqAgr6ffnGVMumpS8UIVLpoNnn07iu953QIL1GGz/TbmC/IF64n5ESOK3P93onjD6IbF7HcixyT5XOiFEOA8zePBlinaepNB35tvmkgfv43WWxsyzHCuc6p3j8Tdvpo/Gg1uoBwVdu18Lg3B5ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OeYHqHWF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6082ad43ca1so72251847b3.2
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 04:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708604268; x=1709209068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a0mMK9mRalBoqZ6q/GNoAuebZSyQVqKEYYNjWXoFduc=;
        b=OeYHqHWFxaiBiAsyKSdrm51B73w03pGTTnrmgHH0b3fEmV5dDYbOLPxbRZpGOBjAJ0
         Y4qQhH+pl54YCHHqjQ8ZAp78zcW2VBWBv8O/Ws5cz9SDSQ4Zq6ZQvQ1qUelSCCQaDUMn
         NTblRIGyWAC9n8wYZ7IT0HOV7fx2PsAkP9pUXP2o0QLsCSWUIIkBszZLgXB3tQ178ayC
         kAafV2Dc9ZSP5RFpI5teKmPddkcfn5qsfp5sAVbJ6em4TDO36WAkFiu6PPeT8ijf4vLw
         vdGRcRrhm6/EW8mguHzyXf+/LRdUSIcFKcuYTrcNn08hUjE8OkPbhYRdP05dG9Hut12c
         Gn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708604268; x=1709209068;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a0mMK9mRalBoqZ6q/GNoAuebZSyQVqKEYYNjWXoFduc=;
        b=nr7vtqlznFlm2dwICitlzwyXnAAvB8GQYUMeCO3N62msAMW/ZapR/r5icTECW+LA2y
         Em8QbWA80UguSItJVmQDJjC72QmbF5n5DbOWopTXmBtJ2DuAQnMbJ1jVpVFb7mZWJmFY
         fVgYaWug4V1EftBZWSsJIUYOYdcLk8aQZuPMo67w6scD+F8zphUrlIjk1oWazAZta0fd
         9go3e+qv8WoPNh1s5kGZHBppIroyNX1U9sqDk7vHXhL2sWqficxyJbo/YmT+UINY+SUe
         M7KyRso5/IaIgsonh6RpyGUu9d3yu5SSj2FqFBk+YZmf8nH+6lp1Wa25tYWhWTOS2I6v
         vrOg==
X-Gm-Message-State: AOJu0YwuPe2p80QQq+WeUbApv8q3czPyJYZ6zy4tEPcSrZepI3cKdwWi
	4G2jq9rBeEImx4d3ShDDtmGtVmS5Ls5W8UirNYowiwSv/3Gtw8ZsYi/ldxY3ldmjRAnfrmzu64h
	/AIFgbz1Iwg==
X-Google-Smtp-Source: AGHT+IHbqZZpdwbkQj7uwzzwwjVr7eVGK9Njq0dFs/YzJ2xTD3O1bLAxd3WNUIErXnzotUDYHipqPVF2EJMewA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:70d:b0:dc6:e647:3fae with SMTP
 id k13-20020a056902070d00b00dc6e6473faemr87589ybt.2.1708604268392; Thu, 22
 Feb 2024 04:17:48 -0800 (PST)
Date: Thu, 22 Feb 2024 12:17:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222121747.2193246-1-edumazet@google.com>
Subject: [PATCH net] ipv6: fix potential "struct net" leak in inet6_rtm_getaddr()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Christian Brauner <brauner@kernel.org>, 
	David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"

It seems that if userspace provides a correct IFA_TARGET_NETNSID value
but no IFA_ADDRESS and IFA_LOCAL attributes, inet6_rtm_getaddr()
returns -EINVAL with an elevated "struct net" refcount.

Fixes: 6ecf4c37eb3e ("ipv6: enable IFA_TARGET_NETNSID for RTM_GETADDR")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Ahern <dsahern@kernel.org>
---
 net/ipv6/addrconf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5a839c5fb1a5aa55e5c7f2ad8081e401a76d5a93..055230b669cf21d87738a4371543c599c3476f98 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5509,9 +5509,10 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	}
 
 	addr = extract_addr(tb[IFA_ADDRESS], tb[IFA_LOCAL], &peer);
-	if (!addr)
-		return -EINVAL;
-
+	if (!addr) {
+		err = -EINVAL;
+		goto errout;
+	}
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifa_index)
 		dev = dev_get_by_index(tgt_net, ifm->ifa_index);
-- 
2.44.0.rc1.240.g4c46232300-goog


