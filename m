Return-Path: <netdev+bounces-70634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D662384FDAC
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8462B296AC
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9369863B9;
	Fri,  9 Feb 2024 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x9cvQeEe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0137163A9
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510902; cv=none; b=jgYt1sWX9xJClGNclWdT1VBUoAbVBb4QsvQNogiy0JCxGTMGGsinHMnLjl4Z9P2oftiAuEfap32m5lsjed1uNxcg3W+7EOee2sI3d9WuGj6sdH+Bw45FqzJKlqbgIprD4XEpMGR7BVLI52jN4ZxQwu1qVdKRRC6n8nxCUGZaLn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510902; c=relaxed/simple;
	bh=YTEyg/1+GiY/W0+VDC/b3Qq8cChEbXx1vVFGD44gPcg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gf1Xu7UsghupDOtYAp6Uz4YmIyA6CY5lV0eqTO2jMdOa/2rP1mFaffZ7lv6k/PrhP+OQnb6SAIzu9t1l0gZpeRgfXiTYNlq4Ai5ikBRlOlHxilylM07eggbPDfO4NmKrEy0Yz4JVl9Y0u04Z1yvJsI1jlqc4d9crWyLiv1njUuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x9cvQeEe; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047a047f4cso36206907b3.3
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 12:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707510900; x=1708115700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HK2l2I8QxbGjQxSZecBtZ6duDYVxBVdYd1H4ObV5H/U=;
        b=x9cvQeEe52P7sJ6YPyNrhwYjgGBHb78CDBEd91jd+UsUr+5BzYh8fcBOefUENsRfJK
         JxOPyrAlGwuhq0dnlz5cr/70ldRoPSFqdEoiU/jbBQUs3PbjAZy5SNKz1GPf+L8dAs+9
         Mne2/JdYlHHHsQUKV7sb0v2v3SEm+Gy3CMp04MTvIjYW7uPAgaH6yfd9b7FXUf5gESBQ
         aNb47UJdUqDf+fWQ0LJFN0qqeILmDVEVQgl+UUm/bmLQLn3hcsk32mJOm1V06SOOXqFn
         9TdctfBqMaqobh5hjd2Un8xxChilywVffJHVEfUTIuGwN3P5gUd4I5DFFnVChnZx2kwA
         ZzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510900; x=1708115700;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HK2l2I8QxbGjQxSZecBtZ6duDYVxBVdYd1H4ObV5H/U=;
        b=d8SWBQU+nFCR1kjEfI/9Ud7dZ6hLxF6yr8Yk1exTSP+aTgSB5Tl2EJf2GBR1fbOr5R
         zHlyvmK1gUZTzDvuswha7cyRvrY/gQe4YoFvR4OxHod4Ts9qhb0+GUXtJO/y4CP4ZrmB
         YqunzR5PyW3M93GDt/ZbNSVpHogvFlFsotObtDs9YP8UDEs/m40jnuzNg6EN3oAe108x
         AzEBkxh271QZVOgaY14y7WCmwcEi9M/2guMF9LXklmnME2k9S608N15LdOckHjFLm+nA
         +aS29n4/iN+9VomwFAzLDoUx2ssbjeVrt2cVWdevPqP3UqtSuzBVAxcFzzjV+Nn3IJE/
         G0lg==
X-Gm-Message-State: AOJu0Yyw2Xs75+OxVzIFJi66zGUoeUwgTNRJZfl8P2OWVEN1lNlAbWeC
	wCd8E1AWoP7jGJIJJnfPKFkKltKIrX2qCdnxTSVaCj+a6wMCdiIyA1QTBmE/qanopyHoQPs2GbV
	V+EELjTbJdw==
X-Google-Smtp-Source: AGHT+IF1iXZ7lQwIB5Ku58xM/3W2tQpQ/IuL8ZEz8UhaX47hIXGBEcj/T01XyS6rl2HS1oXUSWFuVsVefPcbRQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:908:b0:5fc:d439:4936 with SMTP
 id cb8-20020a05690c090800b005fcd4394936mr78572ywb.8.1707510900017; Fri, 09
 Feb 2024 12:35:00 -0800 (PST)
Date: Fri,  9 Feb 2024 20:34:18 +0000
In-Reply-To: <20240209203428.307351-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209203428.307351-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209203428.307351-4-edumazet@google.com>
Subject: [PATCH v3 net-next 03/13] dev: annotate accesses to dev->link
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Following patch will read dev->link locklessly,
annotate the write from do_setlink().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 31f433950c8dc953bcb65cc0469f7df962314b87..8d95e0863534f80cecceb2dd4a7b2a16f7f4bca3 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2974,7 +2974,7 @@ static int do_setlink(const struct sk_buff *skb,
 		write_lock(&dev_base_lock);
 		if (dev->link_mode ^ value)
 			status |= DO_SETLINK_NOTIFY;
-		dev->link_mode = value;
+		WRITE_ONCE(dev->link_mode, value);
 		write_unlock(&dev_base_lock);
 	}
 
-- 
2.43.0.687.g38aa6559b0-goog


