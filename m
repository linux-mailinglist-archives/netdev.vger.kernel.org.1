Return-Path: <netdev+bounces-132524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A75992038
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 20:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114C31C20DC8
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 18:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97D318991B;
	Sun,  6 Oct 2024 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7joE24l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AECA932;
	Sun,  6 Oct 2024 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728237737; cv=none; b=EajWV1uZ2KBNlYrPUdJuNsJw9thnfJP8C30AP44nHRvpcTEXxSKkp/P61quGVn5sXafGvqwNbeln/XgoDdEzbH+5R6HBa+qHYsI8f6rBjqWc7QSJuzdymckJ2G4GZBusDqZnO7SYslIIWDAxbvbFpFXh3Hd3tMg80OkX2KoT0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728237737; c=relaxed/simple;
	bh=zFvZCvwUthMEAibP76MZ6GZeepNT+cGFhpvVb0NH7uU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Twdmq9oF1E23MyXYyegF8oJ8OrR5wnD/kSnqpxnIXVjMA58CsZxCJFq7IiVTxTfzIlddOBpiEMuRY9xru8KmbaxHecPe1Sp1fyJYCS3bfpYwoKFVskc/iKR5UFaURtA4FBUkS6a5aHweiphzwZOmbS1bQgxnsQxK8qxX0DpSu7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7joE24l; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2facf481587so30571591fa.1;
        Sun, 06 Oct 2024 11:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728237734; x=1728842534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Jm4RJK33Gdj8GX5GhyOqFYSLmt1bihSli6+Qvr+0Ec=;
        b=D7joE24lMyqd7KeCor6MAtUK07mmO/lXlFuxE4QxxEuLHvFP0+pvnafJZGVO7zwM3p
         PoebrtNiXVQp0USxjuvedZUKEFbGAqoSotqlcUijn6ISnU0gqO4gtkjzDSDQitd8kQr6
         7N8ZYy3OyayQUiloJosfOAqsQJv4w4PC2LCIJNrvyaMJAKr03+bnBVyNovz4iOsYXoKc
         xLMH1RYJolATFPgs4ss32TIFw1dgPCrypeSPRq3VtT5HWOXcBuUZzig/VoCHVYvaEf5S
         Xw88ciDJLk7AMXrnl0GXI7c/9RI0yW1n59Shiphe3zAkDkKRKfqoieWYOZ72dobIGQQE
         WQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728237734; x=1728842534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Jm4RJK33Gdj8GX5GhyOqFYSLmt1bihSli6+Qvr+0Ec=;
        b=gAD7ypGnAFD4D9oYth+XDG8sU1ZV7w1pTrwFV6sETK9g2Q0xqll2SjzCvDdgvG0Kto
         Si6EElVuAswKo4q2cwgJEIm4zrhZ2/B1ULaR2xyYU2NeV0NdgoQLrf2IPCjPrNF2Zjt6
         7/fe5dPUFDfH1Y1qTGz0a3XeK/WRRcu+xea/d2rL4ykwRaRlFHj9W2K4PAJXpEIwAVq0
         VvpTz846uWOEio0iu2TD18cRcS762f6tsucTaf/GtRmN/ylynUFzFViYw0q1JGTre6SH
         wh/EkV331erpzDAcyUrd5GWwQLFUDuT6wrramckJZVB35BYZ+C0e+c/ZS7uQ6Bzc847s
         gPVw==
X-Forwarded-Encrypted: i=1; AJvYcCWPINdnw9hYvGy/7kwGuzPoit8bNCMULUBaFNM8GiRc9VyvBibPVGZBXXLM1Gm8KjnszUfnvobmPBeN2hQ=@vger.kernel.org, AJvYcCXY2vEfn9XbOCxdBJJttwAGVy7Hy1Jhl4BU2c0ujBysNhDd1vGQzvPq4wBuHeG69J6XCpoSgVpb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx81NPomGq/+Q0L8aBmZkgWi+uEMXfi2BW6LH95wGA7IMQ+k9uo
	/3a9YpXepg84bkJR6qyOt9tFv9pQUL6oH3kkRl0zNhcGzWwT4cDR
X-Google-Smtp-Source: AGHT+IGh+096uUAJMMMS7PPM0GIcauqYcdGdcxRBpAGB9TkZt9zUZnY+xcBc+96ncP41rIGMQ/1tGw==
X-Received: by 2002:a05:6512:114f:b0:539:9d24:9ea with SMTP id 2adb3069b0e04-539ab88ad6emr3793537e87.34.1728237733905;
        Sun, 06 Oct 2024 11:02:13 -0700 (PDT)
Received: from alpha ([31.134.187.205])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec8590sm583440e87.94.2024.10.06.11.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 11:02:13 -0700 (PDT)
Received: (nullmailer pid 18001 invoked by uid 1000);
	Sun, 06 Oct 2024 18:02:03 -0000
From: Ivan Safonov <insafonov@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH v2] net: fix register_netdev description
Date: Sun,  6 Oct 2024 20:57:20 +0300
Message-ID: <20241006175718.17889-3-insafonov@gmail.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

register_netdev() does not expands the device name.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
v2: Remove excessive blank line

 net/core/dev.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index cd479f5f22f6..861dbd6e46e8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10611,9 +10611,8 @@ EXPORT_SYMBOL_GPL(init_dummy_netdev);
  *	chain. 0 is returned on success. A negative errno code is returned
  *	on a failure to set up the device, or if the name is a duplicate.
  *
- *	This is a wrapper around register_netdevice that takes the rtnl semaphore
- *	and expands the device name if you passed a format string to
- *	alloc_netdev.
+ *	This is a wrapper around register_netdevice that takes
+ *	the rtnl semaphore.
  */
 int register_netdev(struct net_device *dev)
 {
-- 
2.44.2


