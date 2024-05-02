Return-Path: <netdev+bounces-93064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8808B9E54
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 18:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95824B21841
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 16:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6830215E1EE;
	Thu,  2 May 2024 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KWsYxXck"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E174C15D5A6
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666625; cv=none; b=fAJZNCYRDFLyMEGX9XDd/fkiYmJ8ms5PdmD9BAq3T12eHA05ZNptqpUjgbHRiTS57nrbNGC06+UAMvD+uPwe8kfckr6JvtVQZ9vZ1wT1MESbi7cZY/1PfxMRzkde7usjAV/e1yNAbbPO0Lil03MBeq/YNRKrR3SY9OaiVQKjxOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666625; c=relaxed/simple;
	bh=9WHaz8tznBm6Sv/0HCKnFJccpP/PDl/GmcqUmqwFArk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m7jkl3R3KDhonMpjAdE1/nTeqTETrpBnixH9ZjT84aSZGxLGjJzzlpy+zvjcKYvsoZ/GfZa2QXLJCnw2JlG+lGW8PW4F19M58ZVxN3ih8d+YAtIZ7t3sEIocmuOmBAzm1v/w446TNCI5Mg6nmdXUbE0gT+2ivcjz0t8BjWgkwO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KWsYxXck; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be621bd84so61924377b3.1
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 09:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714666622; x=1715271422; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7XS4gfFNx0zq9mSxejnBcFNohvsKc351mrULljlczJQ=;
        b=KWsYxXckfk/xrEoFFAML2qydvwSC7874u1wB2SNCG8oiHMGpQM4WDVVyoL1k0fmfpV
         yb4h+AJy8XHgnTQQTNsHpIp1qKYJl00se/fYO5iO6HYyWvocj5H4N6PO66VLZ92SD1Ps
         fcX0wLarfdhfJWVcG+jNp6aLUGqeEt9kV01w+Wm8pF7cVGdnz6vUIdM0eLmpGLR1JvST
         KKRSAzV9KLba4ROLzFz+DS/12qD//1thAfKR974m2cpadSQR59TjlVScU976B5D35t2P
         rVvYuw9jhVponQ2sgIHsSTpsILA+3Qw1wmQ/6dJePUBERdgMy9qLTD/PP/jGH/CWwcqL
         v/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714666622; x=1715271422;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7XS4gfFNx0zq9mSxejnBcFNohvsKc351mrULljlczJQ=;
        b=Mual1PPmEW7GvzkAVooQTHZQeldifs2O24Nza/gFHbGYJVydstZiFzTBEVGM2gKoAZ
         LYYexfxrfWspOsHSbVsqdIPCx1CfHCL49EAn3bmXTYxHr4BmQ9MFH+yORdInqBYAtgBR
         MyXQzjnzpD2xuSI+t3fca4Ry41aZXrqAug1irU1ZdURVtKl8p/ton2mkcuz7HRbx4gfl
         leq/XRft0tPK+FSTimyD1DCxid71KB0cZ3hcg1DV9/d8pz7oHLhZBTylXIXhCZ6j3Xv3
         rf0KNX0QXZoYRdeIgKdLL5jJd1jFgu+PTmfFV/jpvGuBJOHLz9NZiUnRplp+gGiTCJAS
         51Uw==
X-Gm-Message-State: AOJu0Yz5IlkTMwUekmf4z6hJQdK82dLegYv2Ocqfo1ZGQw4DU6eEFw04
	b76JrMJMINifoZ7fux6e3nd9vZJ4yac7lwqIF+eHj8MchbJOGB0+Rt/PDCT3brcsByx2gbIwfAe
	0g7pw1xE0Bg==
X-Google-Smtp-Source: AGHT+IHvTZ/tV+fkVOrQgEi6oHF0C6HPKll9YHV6QEelSuae5IwO61mRV+ohRLGZILcC2WKsq1xR8aYwJSQpKw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2603:b0:dcd:2f3e:4d18 with SMTP
 id dw3-20020a056902260300b00dcd2f3e4d18mr29702ybb.12.1714666621961; Thu, 02
 May 2024 09:17:01 -0700 (PDT)
Date: Thu,  2 May 2024 16:17:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240502161700.1804476-1-edumazet@google.com>
Subject: [PATCH net] phonet: fix rtm_phonet_notify() skb allocation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Remi Denis-Courmont <courmisch@gmail.com>
Content-Type: text/plain; charset="UTF-8"

fill_route() stores three components in the skb:

- struct rtmsg
- RTA_DST (u8)
- RTA_OIF (u32)

Therefore, rtm_phonet_notify() should use

NLMSG_ALIGN(sizeof(struct rtmsg)) +
nla_total_size(1) +
nla_total_size(4)

Fixes: f062f41d0657 ("Phonet: routing table Netlink interface")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Remi Denis-Courmont <courmisch@gmail.com>
---
 net/phonet/pn_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index 59aebe29689077bfa77d37516aea4617fe3b8a50..dd4c7e9a634fbe29645107de04a90688cdfb1a01 100644
--- a/net/phonet/pn_netlink.c
+++ b/net/phonet/pn_netlink.c
@@ -193,7 +193,7 @@ void rtm_phonet_notify(int event, struct net_device *dev, u8 dst)
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	skb = nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
+	skb = nlmsg_new(NLMSG_ALIGN(sizeof(struct rtmsg)) +
 			nla_total_size(1) + nla_total_size(4), GFP_KERNEL);
 	if (skb == NULL)
 		goto errout;
-- 
2.45.0.rc0.197.gbae5840b3b-goog


