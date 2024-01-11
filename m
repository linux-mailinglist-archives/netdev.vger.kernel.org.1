Return-Path: <netdev+bounces-63146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B73E482B56D
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 20:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71231C23016
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 19:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D495256B67;
	Thu, 11 Jan 2024 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ARQd3Hra"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1FA5677F
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f6f51cd7e8so81574637b3.1
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 11:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705002567; x=1705607367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IPffbaTQeiScmhZdf7GWlu53R9SRyOOzwHb/Jph0b8Y=;
        b=ARQd3HrajwEntaQb01lneYI6yieKbOMj5dfihL+szHONfx31r3gQpFj6cPuHe6MNAR
         /EHxtGPS+EPB9RjbVM60eRq7/MUda4UNawwYCYSmKHZpGP9dg/Fk0WEEb2o7iZ4qpFl4
         kZ9qzQbeGxdQ68v4/QSqX8rOcPX4UF+FfEoKnDYeR7dcOIXN8H35cxtPcrKx68YwKsBa
         9PLw/g+hEXwvUObQh6iSPIP0XBGW9KEbfsusFnF9ew074IOQFTIAs7k7y6HWZiFPGxhu
         /RXQ5wEuVdlG6/Iyh2/LIUCIIXphKfTn6FuOwGA/wv+1zl3cLcdWra93U+7vFuRLtW7+
         1TBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705002567; x=1705607367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPffbaTQeiScmhZdf7GWlu53R9SRyOOzwHb/Jph0b8Y=;
        b=kMeHIIE3/My3U42Op7AWUV/voXy8HJF6ZR/T1PJQr+LFjrib15V/70Jps4s4IBr5tS
         /8ZJZntApkrPwvN+dNv98kK5+7IBOX0f5lr3fYSVg4Sb3ZJ2nS/ip3DXRsJ14mNqXx+0
         9P2iZhe6RORHC5VP+ZUMVpE3g1vJOhvFr5GT6YX/DHkDCxPjk5Zrv4j6pyScIc0rm6Y+
         CyCg/f6fqJmWhViqseC2LumS5ik3y5o1IXUInd7GcBU37COJD7x0CESfAKJpdMMUy0BX
         1uQlj5ukdCdQpCTFTyLecC/c01mKOn254ziMG7WrVBXuzPas+Nfk9+/CAKu9BzEQj21v
         /0Aw==
X-Gm-Message-State: AOJu0YzwOpYR1E8mDhSjeI76s3WgFCRQWGDkxbp2eacf/eE5Xt67z7L4
	h0QUAAaHSN+UYfNwwNeAKtjFX3povtLB/EwvwWwi
X-Google-Smtp-Source: AGHT+IGoOG3n/cPCgDfEtOkWALyRrb3WW5ZJsglOoLF4AvaXOutoE47aYdTpmfqm80qNghACALNyzn0XTGyerA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:f602:0:b0:5f8:e803:4b0d with SMTP id
 g2-20020a0df602000000b005f8e8034b0dmr120886ywf.2.1705002567547; Thu, 11 Jan
 2024 11:49:27 -0800 (PST)
Date: Thu, 11 Jan 2024 19:49:17 +0000
In-Reply-To: <20240111194917.4044654-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240111194917.4044654-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111194917.4044654-6-edumazet@google.com>
Subject: [PATCH net 5/5] mptcp: refine opt_mp_capable determination
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang.tang@linux.dev>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

OPTIONS_MPTCP_MPC is a combination of three flags.

It would be better to be strict about testing what
flag is expected, at least for code readability.

mptcp_parse_option() already makes the distinction.

- subflow_check_req() should use OPTION_MPTCP_MPC_SYN.

- mptcp_subflow_init_cookie_req() should use OPTION_MPTCP_MPC_ACK.

- subflow_finish_connect() should use OPTION_MPTCP_MPC_SYNACK

- subflow_syn_recv_sock should use OPTION_MPTCP_MPC_ACK

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/mptcp/subflow.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 13039ac8d1ab641fb9b22b621ac011e6a7bc9e37..1117d1e84274a5ea1ede990566f67c0073fd86a0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -157,7 +157,7 @@ static int subflow_check_req(struct request_sock *req,
 
 	mptcp_get_options(skb, &mp_opt);
 
-	opt_mp_capable = !!(mp_opt.suboptions & OPTIONS_MPTCP_MPC);
+	opt_mp_capable = !!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYN);
 	opt_mp_join = !!(mp_opt.suboptions & OPTION_MPTCP_MPJ_SYN);
 	if (opt_mp_capable) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVE);
@@ -254,7 +254,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 	subflow_init_req(req, sk_listener);
 	mptcp_get_options(skb, &mp_opt);
 
-	opt_mp_capable = !!(mp_opt.suboptions & OPTIONS_MPTCP_MPC);
+	opt_mp_capable = !!(mp_opt.suboptions & OPTION_MPTCP_MPC_ACK);
 	opt_mp_join = !!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK);
 	if (opt_mp_capable && opt_mp_join)
 		return -EINVAL;
@@ -486,7 +486,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 
 	mptcp_get_options(skb, &mp_opt);
 	if (subflow->request_mptcp) {
-		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPC)) {
+		if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYNACK)) {
 			MPTCP_INC_STATS(sock_net(sk),
 					MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
 			mptcp_do_fallback(sk);
@@ -783,7 +783,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		 * options.
 		 */
 		mptcp_get_options(skb, &mp_opt);
-		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPC))
+		if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_ACK))
 			fallback = true;
 
 	} else if (subflow_req->mp_join) {
-- 
2.43.0.275.g3460e3d667-goog


