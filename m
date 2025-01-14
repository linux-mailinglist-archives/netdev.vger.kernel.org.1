Return-Path: <netdev+bounces-158226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7AFA1128C
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37FB13A0524
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E45A207643;
	Tue, 14 Jan 2025 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJO+tqDY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A9D8493
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736888136; cv=none; b=rbQ0/Qx/dXuPsYBXYoRRak7i0BkawjOXlBXzeC9pIB9HqHaFWCBCqxHBc5FnWqL1JmgEfcI9QuaCxpJc2FtlQwMnqhmO6MJNuYlIquzzGzmcC6mDLf0NoRb34jw0Pd1m69WcrcdTydoSlsFZXQKeKVg1tl+XX4eRr9c6ksSdbVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736888136; c=relaxed/simple;
	bh=KX3NtLSoeOmqoU8HSnDC/LBmYDxM5bH0yG8ECMwyuNA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SyzbqISrJth0Dj3l2t6q4fqX+syNMZyQikcSumYGf5zRwuhUB/EqcHl8aNvF6ZbDsA8Jb4uVqUGRGrE1MqhetFfMiDs48v4AC8ocVmVDeMTGmCdBNEZeXh5led+BkNUjcN8X2Umi4J7XIK7v6orlTt8uKV430LYVnl/ATOZW2i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GJO+tqDY; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b6e1b036e9so574410285a.1
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 12:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736888133; x=1737492933; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PIcaoj1b/M8RTWFI+8LrXUSw6foRHqsYs1+F+EdLI/w=;
        b=GJO+tqDYOtwczSOM7UOhe83yukfDwLP4uS7BawbD6jFkXvlKclwpsyDEGQ3BIqpWxG
         E0sFrGD2ECCamwyv3UY197NDpQWlf4k0c18aP0VCTZTEUZU6QSYzdw2H/mS3UBvTR6lO
         gaRw+N+uD3SVEzieLrgOblPZJUNasMFdv8YuoMzMli0SV9VY11YyTgczW8Y3aD63qs/i
         FeA80c+yl2DGjBMFE4K6mFwTqNtPMF4qIIiqsgsnK8Uq9twPcxHpL7k8kQfYbyqfiZXl
         aN5tT2nYj9QLpMG16ZUXolSJvjn7cQ/Mi1piWUNPRJCE3/8O+bGEs4Qrc3vvvgw+uzWn
         xGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736888133; x=1737492933;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PIcaoj1b/M8RTWFI+8LrXUSw6foRHqsYs1+F+EdLI/w=;
        b=UQ3z3HI/x3x281+lF/XeUWbs0MMjt0Hg8epncdmt44RVLKFpt4SwLyVovAp3mKYVAv
         facFAlnRZ5ptUDglQDhV1bGYsL1Pcm4ZHwbWfQS7wAbB+SD5sgqosCJABMT8I+yyoKAy
         maxkR/GrEaf7cPPixViqmXoVfoGXF6/gCPDk8GQGK86X3b22dXSqay9TAIz2JfPpPbh5
         qP8CZIAaXcMRQfb89Q5Guk96gGc7e95Oe4C9SUzl0bbVw7Kzj88rE6T5G++abis+40W2
         hVBEyN5d84wdAOgiYhP78PRg42mp2WozFcbSpvq0XnOYDfA0uK2BAvTnbXiqJKIohI73
         wrhw==
X-Gm-Message-State: AOJu0YwpnZQUQlFWcvVaFJxOvRTgV1mvVJUFNXZA94Aiu86pDfk+5qy6
	ZZidQq2ERaswbT33LRvmuEyBpwNQmZCylPBpbiDydCPeRrbUa5fegyf0yuFvGBgSVa4A6NTFNeW
	PPib8lHUl4A==
X-Google-Smtp-Source: AGHT+IG/iobBx6KARzmXuTrLdOMNN5/KcgJ6DJXwZOjsX54hrIC5WZFQ0yzykimimG/xncEr7dZbKV/KtlZPZA==
X-Received: from qknyf6.prod.google.com ([2002:a05:620a:3bc6:b0:7be:3b14:3089])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3723:b0:7b1:549b:b992 with SMTP id af79cd13be357-7bcd970aa94mr4208688685a.23.1736888133412;
 Tue, 14 Jan 2025 12:55:33 -0800 (PST)
Date: Tue, 14 Jan 2025 20:55:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250114205531.967841-1-edumazet@google.com>
Subject: [PATCH v3 net-next 0/5] net: reduce RTNL pressure in unregister_netdevice()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

One major source of RTNL contention resides in unregister_netdevice()

Due to RCU protection of various network structures, and
unregister_netdevice() being a synchronous function,
it is calling potentially slow functions while holding RTNL.

I think we can release RTNL in two points, so that three
slow functions are called while RTNL can be used
by other threads.

v3: Deal with CONFIG_NET_NS=n
    Use net_todo_list_for_cleanup_net in third patch.
    Split the last patch in two parts for future bisections.

v2: Only temporarily release RTNL from cleanup_net()

v1: https://lore.kernel.org/netdev/20250107130906.098fc8d6@kernel.org/T/#m398c95f5778e1ff70938e079d3c4c43c050ad2a6



Eric Dumazet (5):
  net: expedite synchronize_net() for cleanup_net()
  net: no longer assume RTNL is held in flush_all_backlogs()
  net: no longer hold RTNL while calling flush_all_backlogs()
  net: reduce RTNL hold duration in unregister_netdevice_many_notify()
    (part 1)
  net: reduce RTNL hold duration in unregister_netdevice_many_notify()
    (part 2)

 include/net/net_namespace.h |  2 +
 net/core/dev.c              | 97 ++++++++++++++++++++++++++++---------
 net/core/net_namespace.c    |  5 ++
 3 files changed, 82 insertions(+), 22 deletions(-)

-- 
2.48.0.rc2.279.g1de40edade-goog


