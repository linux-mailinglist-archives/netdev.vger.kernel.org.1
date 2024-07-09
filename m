Return-Path: <netdev+bounces-110436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0537392C665
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 01:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3972836FE
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 23:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAECF1420A8;
	Tue,  9 Jul 2024 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smEcR++M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365FD1FA3
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566499; cv=none; b=qdAWRzmeXUAW6n69orXCnqoE1P/Qyyc9Dp8vv8TdTBmEs6JOM5gGJDrDkLjXbbLkAo9cw/eyQQCXid83zEj8V1Rf3d8lG8zJmb9n90z51xA00sfXeCrM84nFhinrc+4R7GOf7UdQy+OZw4e62AMOYNlHfEqsk12txgNs1WVApaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566499; c=relaxed/simple;
	bh=hgdPofEdoHAflWfm4WSlRgDQyArhpO9o/lYqCSP2Jas=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lxZ0y0JiqbNMhSc9w4Ozz0u31q5C2acMTeBzXLSfPogerUhymGwaC/wD2TGuPfW/nIERN4i3nFYbDc5b5KvVBdBeKXfzY/187L5oaXDI/3Xs1PlpmT5cpOLh8Jj8TOtevmfjs/q+JtIGTa+tsP+/km2y5CZWapGhUZaHGZW0wIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smEcR++M; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-654d96c2bb5so56083717b3.2
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 16:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720566497; x=1721171297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kVOK31G7VWH7piOOs0JNGXZAr4edRstd8XTkw55aTZI=;
        b=smEcR++MxUqJLQg0No5tvgdhz7mRyJlX9PkndyQ0S2LWKi+6suoRY2lPprgb4W6hRB
         d1uKWlbaaIPgkNK9IG+U4/q518OsYrGc29WlU184hX8T5fBJ43i/AjSIA4c60Gzsxxth
         6l/KZfejQWtCHydISg+n84vaEK94euuhR+jYjz5wmqtJxMivybASsvizmDx9RyZz8maM
         si73aDXXOS0mQnxczCUHZT4DjcHxXSDAUPo+qcz/zHxFGcd/3oVW+Tf9YS1ktAUjw5Vj
         GduM1kODbgkQifakNopyX4XXsYscJvuQXkJxow7KxBv0ArHbdR7hAD0lHGRiddBI6aIr
         +Yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720566497; x=1721171297;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kVOK31G7VWH7piOOs0JNGXZAr4edRstd8XTkw55aTZI=;
        b=Cigg7i41yQSyL+zbBXNV5ZFYkuLaXuzQ27pGQaMu/RPwvJfQyJUNyN7uDw2jeVNioq
         VzsTn36RamjMHTlSpLaPNliEGn2EokFFjdWY8D0DjxAY0PJin1hFLGhDXbxl7g+cy2wD
         MPv+s+dIgi0s8rszNq2McEqUMjNsV7zAwOagErMzPz3RcYBI+bhbDztHnyrUn3vTJrT6
         Ms7UZ4WvqvdfLa05OeulHAPo3MtdJs2kQEnmVhZsUeBv0XLNmZePkUoADVGsbUHjID7w
         pdz7mt1ifhgzW1fbBQ6qO25OMVRqWS3hDE3K1gojoB/SrYGEBw14M2LsndcZfUCp2f3H
         A3nQ==
X-Gm-Message-State: AOJu0Yyb8a+9aFmO+tXVKtZ023rejqam2bVX/23IrnX4m+sUhnAHFww8
	54nEpSxInIAbIoPbheHK3DXlR5zDnem7z7pTm0/tA22YO6sTT+CaIN2Qll9Ng55Dv85cS7T/EIm
	asRik7WjF5g==
X-Google-Smtp-Source: AGHT+IH9mEPCNwVdb3sTr3eF4k+2AjRpOPPusryrnrIMn+iwKf8LoSltOMxFKVx2WNJh2JaDfVkIgKL4vsDOmw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2012:b0:e03:62ce:ce87 with SMTP
 id 3f1490d57ef6-e041b135395mr6871276.9.1720566497115; Tue, 09 Jul 2024
 16:08:17 -0700 (PDT)
Date: Tue,  9 Jul 2024 23:08:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240709230815.2717872-1-edumazet@google.com>
Subject: [PATCH net-next] net: do not inline rtnl_calcit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

IFLA_MAX is increasing slowly but surely.

Use noinline_for_stack attribute to not inline rtnl_calcit()
in its unique caller (rtnetlink_rcv_msg()) to save stack space.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index eabfc8290f5e29f2ef3e5c1481715ae9056ea689..842d315675d5c749a0a1b62fd67afdc1d8046812 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3969,7 +3969,8 @@ static int rtnl_dellinkprop(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return rtnl_linkprop(RTM_DELLINKPROP, skb, nlh, extack);
 }
 
-static u32 rtnl_calcit(struct sk_buff *skb, struct nlmsghdr *nlh)
+static noinline_for_stack u32 rtnl_calcit(struct sk_buff *skb,
+					  struct nlmsghdr *nlh)
 {
 	struct net *net = sock_net(skb->sk);
 	size_t min_ifinfo_dump_size = 0;
-- 
2.45.2.993.g49e7a77208-goog


