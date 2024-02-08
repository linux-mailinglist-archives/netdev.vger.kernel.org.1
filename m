Return-Path: <netdev+bounces-70179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D94F84DF8A
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 12:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0873E1F28113
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4D26F093;
	Thu,  8 Feb 2024 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKGtToXj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B576F098
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391017; cv=none; b=mMw3RxIlDKs5aBElvvbu2500eluhBMHskQO8EXGuB7jY+U9m2hUmTnvd7+rZz9Nrx1nBSUdsIYStd7X8eujRPbFjPaBx1KNn3ztmd6BtTY/swl01bc7nbgR4Eplq9TKpAE2yinbxDtiG2uMRdnvlcvLuCyA9NkULkNkiNel9FXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391017; c=relaxed/simple;
	bh=/3ile9WIt0dmfqHoIsphjClQ0qXXs68F2dYdRh3eV1M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fF62RAA9wPH/mZlEeJu8GrG5MwB6jCN4/k6tcdaA6K/eTfHmt9ttr7G3isaXlkJFvAEMJAoVrpo850zFH8MkyXJps2a3iZWFQ95c8WVp+Kf3YIL0xhGyN0iRGKXHoRuGAibcKoHhl9IOg06u0bfF11JYqRfwXw0XJThXQSKIdJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MKGtToXj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5fc6463b0edso31594927b3.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 03:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707391015; x=1707995815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ng8UKvTPF/Wm8z4LvHUKLMWB0woQ3y9NZ3MydoTfnlw=;
        b=MKGtToXjHlpU3NRiv40OjfbE60XW7biRv6S1JisYY2nEccz03m0iQzqvOrQeQEKKNk
         eWra09sHGDB8iyKaWebswcGUfViyCxSEPeEdNVd5kuYK+HSuf0v057oNPUjN1UQ9whPl
         QpXsGXBkREr/2q5d5nAVw11OXbpLtZcrYUKZSI41fxy2Y1c4jv9zEtRnWpL/bKQgcOvq
         FfyVAMc8WMaEG1Op5a/saPF7Om4nDBNXj4VQIMYNwI6rlJ9ChwN8mME3clwuGnPO0NlG
         C/+NLIlNj/0zmGE8IYeJANIB5V2TF00fnGSWwrSZDmPkLLX/xz5dQEt9QHRrbyFp9Emt
         VpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707391015; x=1707995815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ng8UKvTPF/Wm8z4LvHUKLMWB0woQ3y9NZ3MydoTfnlw=;
        b=h3PnkkKn6PQPv+xHRbmZHFZ6m1Y+BQNHi1d+8s9LB5xj43dnwKnjvXay4nZSKKurJC
         sRlqHYzdykYyBwePVFtnTpDfXCW7Em7VzV/a6cpskTuOkwBiegTWoJce+ybepwh3n0KN
         3oxqkDs1hxZNJMYcmWBzSCX9IjXl47AyDdMsY1+4H9unw5/h73VYwv24F7vOn+GV3wem
         Bd95FLkXinwKSkhbWKiBqG2bFY/Rlq79H9qLVSVQBK2q6gI63KAlIzUDHl0VrzeTEZe2
         yzAv5c+Js76M5BOjEVrSq3yUr2bbh3sxiGYuX9tcSCS/bBn/YLcviGSdHl46mKUZXGNB
         rJLQ==
X-Gm-Message-State: AOJu0YyoF/AP+i/ioDq/8v4SyhjMhdPiKj5Oe0YeTDKskOGbohCOQhxL
	Pq/JL1Y0wt+VTOFsLt0EAZMf1KQjD72ygTC/HUTXokThvukBEjAziVEpJojavs3c7WuvEkqlscf
	Y95CqGU44hw==
X-Google-Smtp-Source: AGHT+IHs5Zcp8NnhyNsJ6vua57t5DnUHqXM6b968U6lhaNKbyi0k9ClVFEHolviCeb3A21rLwcDnN0cgTrPbaA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:240d:b0:dc6:e20f:80cb with SMTP
 id dr13-20020a056902240d00b00dc6e20f80cbmr326070ybb.3.1707391014827; Thu, 08
 Feb 2024 03:16:54 -0800 (PST)
Date: Thu,  8 Feb 2024 11:16:46 +0000
In-Reply-To: <20240208111646.535705-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208111646.535705-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208111646.535705-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] ipv4: fib: use exit_batch_rtnl method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Using exit_batch_rtnl method instead of exit_batch avoids
one rtnl_lock()/rtnl_unlock() pair in netns dismantle.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/fib_frontend.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 390f4be7f7bec20f33aa80e9bf12d5e2f3760562..b5f52639aeda382ac959d3207a18d0d088bcb297 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1631,21 +1631,19 @@ static void __net_exit fib_net_exit(struct net *net)
 	nl_fib_lookup_exit(net);
 }
 
-static void __net_exit fib_net_exit_batch(struct list_head *net_list)
+static void __net_exit fib_net_exit_batch_rtnl(struct list_head *net_list,
+					       struct list_head *dev_to_kill)
 {
 	struct net *net;
 
-	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list)
 		ip_fib_net_exit(net);
-
-	rtnl_unlock();
 }
 
 static struct pernet_operations fib_net_ops = {
 	.init = fib_net_init,
 	.exit = fib_net_exit,
-	.exit_batch = fib_net_exit_batch,
+	.exit_batch_rtnl = fib_net_exit_batch_rtnl,
 };
 
 void __init ip_fib_init(void)
-- 
2.43.0.594.gd9cf4e227d-goog


