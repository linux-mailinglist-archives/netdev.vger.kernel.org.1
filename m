Return-Path: <netdev+bounces-63143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2EF82B56A
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 20:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71ED2883A5
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 19:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F935675B;
	Thu, 11 Jan 2024 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0lz4mOo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7463E5674B
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9c7932b3so8995940276.2
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 11:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705002562; x=1705607362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/3nmf4pbsUMM09wAe/krCGQYXObdTgyzb7ivYc/GaQ=;
        b=f0lz4mOoezkMSMKxlUDU/IZbVfMy6QzbMQPZSxr9zHNdVhwTVbKP4gRqXmLHrCHVrk
         QfsyRXHLXEnVvvusEv0m8aYQXqY4yHzS6HOeqX4ip87UNbrYIfF7SVzCPARDoXv4/2fV
         m/S06rl0Tz98LiHFYxFtC/kIdy0no0Fr0HOgFteXRT2626E0nS1GiopbCoxdQrEyrNAn
         pi0tzE6+UFF63g3AjLBvGm5OxA2RCWVQM1a7B5o9Y5n9pNrBIsjCHJ/canChuA9PzEyh
         lpAj2+tBZyEh7AmbEpxrRWNXBOKHOSUESwmCLW83VwKBHvMEhkpgnP7dkFFRoPdWtKTB
         AMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705002562; x=1705607362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/3nmf4pbsUMM09wAe/krCGQYXObdTgyzb7ivYc/GaQ=;
        b=Pyzf2k4+SwoWqGmSfcQPYVqEJwFu7IksW9n2ppFwnCSjPxJDaW1co2ZMJOytDVL6HL
         onRdT4Pdy4bzaLXEUmtp3gCx06Yhj8O4b5ZI8L59tnapZHx+ShTaN2MArUgrETDWe+I0
         WW0Bky1nc/1p4lkYaZBNn+38YM91f2ffacbGGxCtVIAbf3qgM6CibTgCD/PkqkcQTnLs
         KmK4K24HqkLGa4yQ1aGY4nkTsSIVL1CuWaKe2BdpHSdgZAyDk9jP+vUhZFkE6/AtSI82
         06xPmRUgcbHup+0V5fX/RvODxRJsOTbooQ03P99/LAH1mSCkLxQcZR+gMnPaSut1xox/
         d69g==
X-Gm-Message-State: AOJu0Yz2Jc82zKvlzufUhbh68D7RIs76EWWJBt7CFUBPKQCAiDDcv4vL
	W1LccDDSBEE66T26+9gU0Zj1eFaldWGTAAdoLUC8
X-Google-Smtp-Source: AGHT+IFrZL9oqMhRXigmbBT5by1KTfYIfxjW/kc7i3uo9W0dshtLpnQtrtOmnH4i/o+xPC0URFqKser+OCvp9A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1026:b0:dbd:f0c7:8926 with SMTP
 id x6-20020a056902102600b00dbdf0c78926mr42653ybt.7.1705002562562; Thu, 11 Jan
 2024 11:49:22 -0800 (PST)
Date: Thu, 11 Jan 2024 19:49:14 +0000
In-Reply-To: <20240111194917.4044654-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240111194917.4044654-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111194917.4044654-3-edumazet@google.com>
Subject: [PATCH net 2/5] mptcp: strict validation before using mp_opt->hmac
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang.tang@linux.dev>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Peter Krystad <peter.krystad@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

mp_opt->hmac contains uninitialized data unless OPTION_MPTCP_MPJ_ACK
was set in mptcp_parse_option().

We must refine the condition before we call subflow_hmac_valid().

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
index 3eacd04e7099e6de1a161c176a74959722445286..bb05477006a6ea111b7fc79645099dfa924e4135 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -788,7 +788,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 	} else if (subflow_req->mp_join) {
 		mptcp_get_options(skb, &mp_opt);
-		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ) ||
+		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK) ||
 		    !subflow_hmac_valid(req, &mp_opt) ||
 		    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
-- 
2.43.0.275.g3460e3d667-goog


