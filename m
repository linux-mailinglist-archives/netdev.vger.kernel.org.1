Return-Path: <netdev+bounces-89522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48328AA903
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 09:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BD41C20E1E
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 07:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0E23EA68;
	Fri, 19 Apr 2024 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/iOvteq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D3BBE4B
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 07:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713511186; cv=none; b=oqFC5rLXzanBWPNxLBROHdKx1zS9A9unzP6QYCAEC/qD2V6+BVTV1eAryJMjUg61KT1LoJAL1LFFDOVJORSjpQt+m5VObmFvKnqkktifz8O7aS785S8BIVqpW1O1wUsoN4rXMuWn1lkkei8qDWNmobR2M8oHeP7ebwF1K8jSJ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713511186; c=relaxed/simple;
	bh=xU2SIfqXDt7t+LwxTX3IUStiCyIroEdiGUzQyIo12E0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YnBBc8r8u5r+h/vQfcPu/2rhY+8WURfHs94avgzqy8ZRJRROnBOZE9Oiz0EF7m0xkBkZYMqPsFPeoiDw5zeaFftKGorMNT+8MalHdnlOZbYS6zg2EGR1NOHkkby31DqFKJi99uILdR61Y5hRdBLRpgHvrigLKxDQR/XZMVA2OGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j/iOvteq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so2606087276.2
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 00:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713511184; x=1714115984; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KXy4hPr42hV09hmMZGa2r5snSV6xWNwd6x2FG7DfRTU=;
        b=j/iOvteqQ0g0BWjHQuxy5FAOVLAuM0vFJe35JFNLSJq1p99N+nOCcNgza/lNZZ890z
         Sb/aXHXiVIOj2rUGIEh2utBrGqCrBfDZwyT37qTcrqglAPYI8vzM2i7A7apZbnQ1Hg3Y
         nGjVoIN5xyqdEattKrS1c9Tgid+0vfeUv1+ACEfEG6hSttgQBQ3UlNnFqvQyCFZ+rDv/
         JGTlD4iASvfQ6jEm3I+avXhJOaROaiih/TZDkuOXJfH7wakQ2b5PIyZ3H+I/Yl/8g78O
         ju1DCURr9y3X94JySQVbUg/Vv9Iddr8geu4BARrLSNmB1qBxG1xVL2pO08VFzgx+oyIv
         E5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713511184; x=1714115984;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KXy4hPr42hV09hmMZGa2r5snSV6xWNwd6x2FG7DfRTU=;
        b=UVuVg6NxxVU2vbopLrWskY698MyrY8mNbv2TiyR4TMCA04kBmbSI6n5Xn+sdwS8TUQ
         Yp6L6QUma2kDIWdHf4HxojzvfV09c1Yz66shD+ICkmIHCi0Ps6nxch2HpC+y24QJ2gEH
         rC5150Xj5nVvVzhvBjH7n7Hj3pF/FbdYdhuv4hq7L3zKehIUtlQu9zqYYhuC0yICcGZ/
         hAXLVlriZoxs27Uz7W/FqdH5/mCntH8wTO0At2AvYsii9rEdBhz4ONCsgBRRmYnLmklC
         NTlT+o/GqHc2bnOBzrxCJ1TeXCUHG8xtkT0vdEKrsAfbZrUjbSodu9r9LmLMLGOb7XQF
         RuoQ==
X-Gm-Message-State: AOJu0YxfUfT6pNyduKLHClMCAnQI6z9QeXavsiBUVG5dKCwiwhZsU3ZP
	N0zYGVCRlmHn6wt4j7Hh//YsKZDzJsYm7pTt6F4LwmRR82cWXYUHSC6OA7ODg5E4Lft0zUUJqNI
	xLa8PjNzwFQ==
X-Google-Smtp-Source: AGHT+IE6hDo6g2v8GQspIa1Ut9rzWJae544b/9mB0RORYOPaB1I+Iy944rPWCVNYG7q1rm8lgWAbkliYhWTFKw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:c06:b0:dc2:5273:53f9 with SMTP
 id fs6-20020a0569020c0600b00dc2527353f9mr85331ybb.1.1713511184320; Fri, 19
 Apr 2024 00:19:44 -0700 (PDT)
Date: Fri, 19 Apr 2024 07:19:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419071942.1870058-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: do not export tcp_twsk_purge()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"

After commit 1eeb50435739 ("tcp/dccp: do not care about
families in inet_twsk_purge()") tcp_twsk_purge() is
no longer potentially called from a module.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_minisocks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index f53c7ada2ace4219917e75f806f39a00d5ab0123..146c061145b4602082d149e65f8e6bbcf4bd311b 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -403,7 +403,6 @@ void tcp_twsk_purge(struct list_head *net_exit_list)
 		}
 	}
 }
-EXPORT_SYMBOL_GPL(tcp_twsk_purge);
 
 /* Warning : This function is called without sk_listener being locked.
  * Be sure to read socket fields once, as their value could change under us.
-- 
2.44.0.769.g3c40516874-goog


