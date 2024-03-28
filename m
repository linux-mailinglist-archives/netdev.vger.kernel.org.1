Return-Path: <netdev+bounces-83030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C6D89073F
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 18:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A0CB2520E
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 17:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9B751C39;
	Thu, 28 Mar 2024 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQmwTYkT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDD73C08E
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647291; cv=none; b=LMSLoB/ceRlJshATX7wAXZmrrUy+B6WXdLRPbOW+8uarPRoxTTvQRr1GdvHbkWPHh4zfOyCGeUOx4YZYGW4uIFWJnq1SJfGvS6eI98cJzMyz5zpM2FNuG9hwvWUcm+xkSur6M6Unk3bs6eXQz6Dshtwy9rlyrHL2kBheb0bRHwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647291; c=relaxed/simple;
	bh=I3ZU2yqwI/YvqJCx/TX+lT/0rIK/qrtkBTyyXvchVSY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Dsr49mxqprTQh6v4gIxB5itteoXvgaogT6gRzCj86cWhZVWSJJ8oq2rj184zKmvabW2wj1sVbjMHlyxn3JiRtV130fDUgG+sCH+cIuVtbMm85QC6syykrxSfS7q4kB8GoiBM0DSRVFkcZLDWeazpHA4ogUxK2paJfCov8ziitRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uQmwTYkT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so1465179276.2
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711647289; x=1712252089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HMgzWJuJemuL4TdfQRKReMyrU6QtT+kfxpLAfOdF9EE=;
        b=uQmwTYkTH8B7bHMLs7LrnYYQ+6DP4R64yWFCYbFqACEqS4ufyScECBYqB2/cuq0wN/
         7LfaJgIzfoRvZv5A0GZnh6p1RjF0CnMLjl0ztLIRG4X2fqtdx0F4NU3gYp31c+S00oDw
         BYRkIBxjeV/ZJFOEYP91+3dfCjXzUpFaBWoqt4V7C64oW0DkE+07m5or52+9Jl7H1iH2
         nJ/j5ijug8ybtXyMoECO3ZFxD+QAeSlgkv11XDABi88WOzH1kKHpHZIK3iC9y7XSSpCb
         QGueKTtTPmOYV/2dMXVJ6AVwYasn3fZhzSe8Et8DPY/R7wx3GJx+sY0eEX0yfRKYFHeC
         NPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711647289; x=1712252089;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMgzWJuJemuL4TdfQRKReMyrU6QtT+kfxpLAfOdF9EE=;
        b=u0MnzaSAxJcT/o7Nh3rPhubbvS0E1rEWBEgXbSc2uUfecNXVjSlHHhy4LKlqLyEHcX
         FiD7LIkP3b72MIAPQcOvqeFhVK1nYkrTKz7koKGPKloALkE8kLQcKQaNn4DZeaeYYxfF
         Gbukd5guzdpHr/e1NMKTC0LIp4QCPgyB5ZcPmNngzEJ8VGdOO21JSGZaSFhxC+jIfrK0
         vOJxkKqNSKn9VgLAiK7zx7Kx/2iwzCwf9m39hNJvmokor/YLvDZmnWywjlz6sj/k9uXJ
         L8Ky2NVKm9v+0BUw8lBNmS2BmgqlFkZogPPnxDsy6cUs5GuwzhahGmFt0N18MeMrQyFo
         c/WQ==
X-Gm-Message-State: AOJu0Ywrc1tDzeUBNfP5hP6bh0y7gPMCVFG2KREGkBQzRwLRKdfYpoNr
	OpABipocyGqH9Qsvms4QY2fKB9/mzMSu3N19yutlTNZvrawDa4MBb914YqslwYyuiyqLXcXXfF2
	5rTHOjNsFmQ==
X-Google-Smtp-Source: AGHT+IFI4ZIJwYlIxPViS+JkBAc0IVKnMKpdhnG+jsRT7m6BnA/C7FH9CtVGgP8kKvv7r79mxO7pt81KaRiGWw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:228c:b0:dda:c565:1025 with SMTP
 id dn12-20020a056902228c00b00ddac5651025mr70ybb.2.1711647289442; Thu, 28 Mar
 2024 10:34:49 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:34:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240328173448.2262593-1-edumazet@google.com>
Subject: [PATCH net] net: do not consume a cacheline for system_page_pool
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There is no reason to consume a full cacheline to store system_page_pool.

We can eventually move it to softnet_data later for full locality control.

Fixes: 2b0cfa6e4956 ("net: add generic percpu page_pool allocator")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9a67003e49db87f3f92b6c6296b3e7a5ca9d9171..984ff8b9d0e1aa5646a7237a8cf=
0b0a21c2aa559 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -429,7 +429,7 @@ EXPORT_PER_CPU_SYMBOL(softnet_data);
  * PP consumers must pay attention to run APIs in the appropriate context
  * (e.g. NAPI context).
  */
-static DEFINE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);
+static DEFINE_PER_CPU(struct page_pool *, system_page_pool);
=20
 #ifdef CONFIG_LOCKDEP
 /*
--=20
2.44.0.478.gd926399ef9-goog


