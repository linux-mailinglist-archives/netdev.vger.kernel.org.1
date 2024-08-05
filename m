Return-Path: <netdev+bounces-115677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0B59477CD
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 11:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBD29B20AA7
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 09:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AC71514E1;
	Mon,  5 Aug 2024 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaYJTBYA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D631514DA
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848305; cv=none; b=gVrm1/ZECnt8slMUmbc4/9uPRJ7ZS4xNylFWctetftmeXlRdKgFkqcCglvqygYQ49Wq3tdxi6oq+4EvrMN+iqubKjXK9p8iyEnMvgleiTW9QwfDgNSaXKa58gPbhOzZFLyiRqfLcUou6Iea/GWNq6yvDYqz6HY/VfGEHoTi8v9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848305; c=relaxed/simple;
	bh=EOtMhBGe4zDybAWzBAaC+OjORVJ+E9Wd5wLlM6WJNwI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aCn8CkSnJ0RyTAYnAgNq3vOs6gStYki1y4iOE1KlpCB9CmvbD1fPT7OLj1TSb9nX6KiBMRJqVb5RPUIHDw+/rbVqw9Hp5c1rPoFP0kC/eoVAMHyzEuYRVsPMgtEtA2bJiiT6MvfIN1kNYT4Z0x+TkoM35EB7a8BAF1HzD10Gaq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IaYJTBYA; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b7922ed63so15268039276.0
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 01:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722848303; x=1723453103; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CsHW4k0e3zT9MBWbBKI8L62qPb1qmcR1MYe/7rji8gQ=;
        b=IaYJTBYAUNgzaFDeLa2q29zYXhYF36vaotDyqNLIx5mm+NVLCTpVXCZ/f9diYQxMXI
         uQd2XlmHL/nrz8RZzY0Zsi4EKxny90U9kAS0fRFpttgI95nkLSFAhMHczvpzyri1jX5R
         8Sa275AHhNDJcmiRdhoBurbKFYP7nZgDM1R0IgSf4QmZJqlT2KwJT8OpghNVNxTQBmYk
         +jZS913CXthzndOldWO244VnQaoBzozANnGnVXXTjRwO8A2wNcasbslSuFrCNHhPqV7H
         eOnWYK67JCttIh0uWjOXGDIWpgGyL2tpVhc/t3Rp5/WspIx3Oaf/HFjnW6naaidDjCqC
         ELwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722848303; x=1723453103;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CsHW4k0e3zT9MBWbBKI8L62qPb1qmcR1MYe/7rji8gQ=;
        b=lx2L8D95ux7frXTj7p0dLfrJ44ldQkKBTOtFqulcinEJnHxxAGffqt3KYPKmwpJHCY
         2BSldKQJFonwI7UlAMMfQC0cGlxiTxkLsDY4Z8pM/M+nkD+c5a5NqTeCVgPj+rtVSm83
         IdWcN/vRh/3AmVeFIzT6Ce3zV+DgT7HAoORZUNLpkJqRtpUv9gaHeIGp2tbCEMglazpC
         NsIUqZOpaDHSzxGLyC17SOmMnrs3HD6V/q3tDBg+MTIIWUwG+CTSUbSREUXHMXbe4B3Y
         ptLRy+w2oyrZtGEbak0eMdsnKdgDYSsddIvilhqw6B3uxG9rdM82rg1ZVrmvt5A128GK
         IY4A==
X-Gm-Message-State: AOJu0Yw1g2OOHlHhz+oK/nOWU693eWugWkQA3CnOrZPPxWy63cWqjOX1
	EERlsrIru4OCsdzOFXzi725gGxZoGhcawVI2lkS5qd8Z4tmMRLPqK4ywjJot/4d5YfuNTiXrs8T
	GTXXstKy6OA==
X-Google-Smtp-Source: AGHT+IEDNbsMk+dSnXsX9LR1zT3zG8cu9oqrRpOURB5it7LYkItnrbdWnPA+lyagOQDH/tZM9DhmTXn6mkga0A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2b8b:b0:e05:eb99:5f84 with SMTP
 id 3f1490d57ef6-e0bde3656a2mr19557276.4.1722848303346; Mon, 05 Aug 2024
 01:58:23 -0700 (PDT)
Date: Mon,  5 Aug 2024 08:58:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805085821.1616528-1-edumazet@google.com>
Subject: [PATCH net] net: linkwatch: use system_unbound_wq
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

linkwatch_event() grabs possibly very contended RTNL mutex.

system_wq is not suitable for such work.

Inspired by many noisy syzbot reports.

3 locks held by kworker/0:7/5266:
 #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90003f6fd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 , at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fa6f208 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276

Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/link_watch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index 8ec35194bfcb8574f53a9fd28f0cb2ebfe9a3f2e..ab150641142aa1545c71fc5d3b11db33c70cf437 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -148,9 +148,9 @@ static void linkwatch_schedule_work(int urgent)
 	 * override the existing timer.
 	 */
 	if (test_bit(LW_URGENT, &linkwatch_flags))
-		mod_delayed_work(system_wq, &linkwatch_work, 0);
+		mod_delayed_work(system_unbound_wq, &linkwatch_work, 0);
 	else
-		schedule_delayed_work(&linkwatch_work, delay);
+		queue_delayed_work(system_unbound_wq, &linkwatch_work, delay);
 }
 
 
-- 
2.46.0.rc2.264.g509ed76dc8-goog


