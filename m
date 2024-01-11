Return-Path: <netdev+bounces-63142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B05082B568
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 20:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2801F23F1B
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 19:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB945674A;
	Thu, 11 Jan 2024 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apeHcQxC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CF155E57
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f8ec09e595so84127557b3.3
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 11:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705002561; x=1705607361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jHsphYBZAbQ1xLmXhNXHejzgZqkmdL/R2W5jPkZRfU=;
        b=apeHcQxC5nKiyB2N7peWWKxckxyGfDabXiEEoSbjNDlfrfu6I/i+IYa1ADTyajZAZV
         itaauB5iNTPj6MLbhcKlaabkgcsX16L2PmoWx+/xM18Z4OHXEMKwCJa6dY8sWDRjpe/Y
         PkovQT27AhQuMFIHNOj1sT6WTH/As4/7vLuMXIpOjrKu5sHI8lRMqAXNdoIfJiLbirPf
         XLdv5rjhPWUwzhLc5CMFPzkviybEkpj3LNvGSUGTKdBiwz/4jjWjKPjh8D040RQ8RXe+
         f5n92KFi2C3Js/55P1HZJoyofU8/7VwDRVMpCMUEK5cdch39pN/I9r3mMY6pqvG9ync1
         Hs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705002561; x=1705607361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jHsphYBZAbQ1xLmXhNXHejzgZqkmdL/R2W5jPkZRfU=;
        b=BPUmvPaQPXWZ60ee5jfLUWKhwv+ewGLS5PMqvZyY0OUoTU7PJOTVLlqNdXTFvS4/7X
         1Ce7n9QbbqU9T66YKNux7yjwnoaW+xJpWxE3aoYLiuawPQxUR7zrnwqAak9+WqNvdHHV
         MkMTIgcfNdGBZ718g7YCyqV2XbImjPmb6o1njhcWkQfybNuseeDvpLNu0/pM1448HiAB
         RUFsBg/9DZ1FmuLX+sMHhhEf1DrSY1++iyRFdD5Ne0Y9h7vhHLQk6XCca3kumi3CfqMp
         k8Y4Xe3Fgm+NHAtQIoofUTFhzJLVVd9CSg0txu7cYwnVsXk4DWYcl7kplld1rBBXYqs1
         AlRg==
X-Gm-Message-State: AOJu0YwzNWvbn3MU42mSvsMM9nCd3deh8AH3YP/iKkDyG+V5aspRcs0J
	pW3Cmc0jEzHhFkekA9ylb2TAy0RTi9+RInfNR76o
X-Google-Smtp-Source: AGHT+IFnCQHDHLPmlqAGMJ4kbYVGie0OSHM3mRnCfX94t6WMmSnWe5rCjFOFtU8sSCDeSNtFBT6Rfyr1uRAdZQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a5b:c12:0:b0:dbe:a26d:a302 with SMTP id
 f18-20020a5b0c12000000b00dbea26da302mr56050ybq.8.1705002561058; Thu, 11 Jan
 2024 11:49:21 -0800 (PST)
Date: Thu, 11 Jan 2024 19:49:13 +0000
In-Reply-To: <20240111194917.4044654-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240111194917.4044654-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111194917.4044654-2-edumazet@google.com>
Subject: [PATCH net 1/5] mptcp: mptcp_parse_option() fix for MPTCPOPT_MP_JOIN
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang.tang@linux.dev>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Peter Krystad <peter.krystad@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

mptcp_parse_option() currently sets OPTIONS_MPTCP_MPJ, for the three
possible cases handled for MPTCPOPT_MP_JOIN option.

OPTIONS_MPTCP_MPJ is the combination of three flags:
- OPTION_MPTCP_MPJ_SYN
- OPTION_MPTCP_MPJ_SYNACK
- OPTION_MPTCP_MPJ_ACK

This is a problem, because backup, join_id, token, nonce and/or hmac fields
could be left uninitialized in some cases.

Distinguish the three cases, as following patches will need this step.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>
Cc: Peter Krystad <peter.krystad@linux.intel.com>
Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c53914012d01d38c2dc0a3578bf3651595956e72..d2527d189a799319c068a5b76a5816cc7a905861 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -123,8 +123,8 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_MP_JOIN:
-		mp_opt->suboptions |= OPTIONS_MPTCP_MPJ;
 		if (opsize == TCPOLEN_MPTCP_MPJ_SYN) {
+			mp_opt->suboptions |= OPTION_MPTCP_MPJ_SYN;
 			mp_opt->backup = *ptr++ & MPTCPOPT_BACKUP;
 			mp_opt->join_id = *ptr++;
 			mp_opt->token = get_unaligned_be32(ptr);
@@ -135,6 +135,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				 mp_opt->backup, mp_opt->join_id,
 				 mp_opt->token, mp_opt->nonce);
 		} else if (opsize == TCPOLEN_MPTCP_MPJ_SYNACK) {
+			mp_opt->suboptions |= OPTION_MPTCP_MPJ_SYNACK;
 			mp_opt->backup = *ptr++ & MPTCPOPT_BACKUP;
 			mp_opt->join_id = *ptr++;
 			mp_opt->thmac = get_unaligned_be64(ptr);
@@ -145,11 +146,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				 mp_opt->backup, mp_opt->join_id,
 				 mp_opt->thmac, mp_opt->nonce);
 		} else if (opsize == TCPOLEN_MPTCP_MPJ_ACK) {
+			mp_opt->suboptions |= OPTION_MPTCP_MPJ_ACK;
 			ptr += 2;
 			memcpy(mp_opt->hmac, ptr, MPTCPOPT_HMAC_LEN);
 			pr_debug("MP_JOIN hmac");
-		} else {
-			mp_opt->suboptions &= ~OPTIONS_MPTCP_MPJ;
 		}
 		break;
 
-- 
2.43.0.275.g3460e3d667-goog


