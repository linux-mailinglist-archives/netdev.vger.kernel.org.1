Return-Path: <netdev+bounces-63144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC37182B56B
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 20:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C7B28A3F2
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 19:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0A65676E;
	Thu, 11 Jan 2024 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVQIg5OJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EBB56761
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso7571752276.1
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 11:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705002564; x=1705607364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xb7UNJ6rd2Cl/nQqOUeJZnzCb1xr9tRl9dyUgaFph0U=;
        b=kVQIg5OJqIcEddY/S3l68xeNy4RS3hmvehzXl9Kx3CvG+4BPGy9u3yirQF7T8HifwM
         CJU/WGboxMW+qULzcRMGGhyqGpYftAKHuXlw2q7Jhq82gxvW4tSskOAyyA2St45Ad6Xv
         HHIOVT26pJAYwhT3yMTk9XomNereyAoKZQBQT3Ep9UuJ9q2HJiL0Q0Rr65x2eQoRqVQX
         DIpCqzOxd5LCTb+vXYJb3gxVbDKptV0letUT7X2ptCWLGIRYSnMrHpb+zThjI5tP1tum
         U0XdoFdOukN1OZzUnPaTQU0r/nh7mhcQhZuCUCSvVwJeiS6V81neerKdsEzLLm/G4Iky
         SsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705002564; x=1705607364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xb7UNJ6rd2Cl/nQqOUeJZnzCb1xr9tRl9dyUgaFph0U=;
        b=C+N+OFObFAVuH59D3P1xYZlh4teHeK3rN5q23GfsoVtdHm7NoJdyBTnAanJqHRUh7I
         YL8s5HE7liKJVpBkBVM9w2jgOV0yAW+1CKMLqk8u7uIlbgs46JvMUXypMHl/gZmzQ041
         7Ry9gjdS5x0akNcU4ucaxldZSv1czKQi9W41/HlqYoYdWgD2m4BHxInTAe7A0aKPcLN6
         KXUgYRqh6VCRaQMFG8ut+sQ6Id7/D/7MNrxhnJi+VyQErdxZ7f7EKH+6WmXmmHD54ACz
         xZ+lzCE17X86Wz76cZ/1eH+qO15aX3zc9I4kccw1xLNtEtMuKj3bHBEjULkfekJfg1Hg
         JZnQ==
X-Gm-Message-State: AOJu0YzPVjnvBeq1cbn/gCi4sdlKmnQndpG8pXCf09Aj7V+4htEOIA6U
	2X+7JfaXsTszrgjUtzoMUpMeeywQpY/Zhms/Xnd/
X-Google-Smtp-Source: AGHT+IFROqtQpB8Ec0mSlTNQJ53OSDZ7lAYdSIEYcAHb3oTTHNEig/qCH+w8FbNZPQcawh6byx9mr4X2G5Bknw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:9f8f:0:b0:dbe:4c97:5511 with SMTP id
 u15-20020a259f8f000000b00dbe4c975511mr55854ybq.13.1705002564045; Thu, 11 Jan
 2024 11:49:24 -0800 (PST)
Date: Thu, 11 Jan 2024 19:49:15 +0000
In-Reply-To: <20240111194917.4044654-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240111194917.4044654-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111194917.4044654-4-edumazet@google.com>
Subject: [PATCH net 3/5] mptcp: use OPTION_MPTCP_MPJ_SYNACK in subflow_finish_connect()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang.tang@linux.dev>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Peter Krystad <peter.krystad@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

subflow_finish_connect() uses four fields (backup, join_id, thmac, none)
that may contain garbage unless OPTION_MPTCP_MPJ_SYNACK has been set
in mptcp_parse_option()

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>
Cc: Peter Krystad <peter.krystad@linux.intel.com>
Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bb05477006a6ea111b7fc79645099dfa924e4135..103ff5471993a8490c4e1e77f404ec7df4e2c6e3 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -506,7 +506,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	} else if (subflow->request_join) {
 		u8 hmac[SHA256_DIGEST_SIZE];
 
-		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ)) {
+		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_SYNACK)) {
 			subflow->reset_reason = MPTCP_RST_EMPTCP;
 			goto do_reset;
 		}
-- 
2.43.0.275.g3460e3d667-goog


