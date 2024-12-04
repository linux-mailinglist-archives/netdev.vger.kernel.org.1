Return-Path: <netdev+bounces-148768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2799E3174
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE1A163637
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 02:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA79347C7;
	Wed,  4 Dec 2024 02:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXZZCc1R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A94A1A;
	Wed,  4 Dec 2024 02:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733279780; cv=none; b=CV8COPxDohP9fE1R+0+Sz+8CzCjiqJMMxNp7p9Q4XpzwYEnz31dZNRwz1LL+Ni4K5jkeSrvOg69VpkCmPHBcgJtrRqH7qCpeWoHBBy/Nj3iIq1Df7SHt/ojFZRITk0LMPQid+TKrpw1CnWC4dYridKUo3ka01ktD9jPJpFohfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733279780; c=relaxed/simple;
	bh=CQK1K1NsuApwciszee6cjtjouem6DZe8OyIZ4d7WoUI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=mlnzgLg0t0L9vvFOW7l7RWz/BClLn4tN41aov6bDLDBvfoU/OpPEUnE2F3aWHSNlj6Fxvp3JgxPTjUxskEPjOGvDTHZO+0N4Civ2cXXqrWcOQsiER9hIH+whUWWaeZ+iMtMdv8rtRJNfU2abXQ98QCpgzqZC0JzaSjh+zjZaaeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXZZCc1R; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2155157c58cso31121615ad.0;
        Tue, 03 Dec 2024 18:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733279777; x=1733884577; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3Ia9OqIpEzhftMHDJMG8JUQ6xSxqlZ96Db6J9QfoV8=;
        b=CXZZCc1RLTkWOouczMgLyK9mbElBILU9j9xO7I2eD2rvMcgmBKmDcsb4zJOm3skANb
         1NIxxIqH9mYdRMJg8Q93J8hJE8ssvvwXhnRrg1dMFH4NDWrOcx0hD1LLl0igmPqKJqMH
         TZ11S6YqD3k3whRd/88TQwIADwWvZx3LDVTqUVUhoCw0oIqtf6khn8QxPWfnmz8VJsND
         7SclBmAWHW2HELMpC+afAPU94ta/2MGyRc2drgK/wnE8WN/Wqwxb38WQy7TgCVu3ozB1
         jnv/Z0QBNPLAxwdNtLAizYIxxG615F+kyWQbLagKh3gMObWyN9LzqyV/mJURqBpQLYTF
         K7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733279777; x=1733884577;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3Ia9OqIpEzhftMHDJMG8JUQ6xSxqlZ96Db6J9QfoV8=;
        b=ecCXD2yR1BH7LNNq/1ldm6SNP7vS9fDPJsRkafLiLuYsVA/R617QZ6gPvdtvkFTV8D
         tPHmphs0RRQIf8cGbkuqyQCWHyoOXMQFERD/GrxSkSxYmQRU8dmkoyHcWQU5dpC99gWM
         0wB5xZBbIlF3GasO2sP4Vyzmce/n2krSBiOt4DUAnsi9mpojID2flnlJjI72etsEeRKw
         K4ibzGGD9bqRALqX8eOm6q55Hwx/43nFMlV9jM6dN+YCknzjyFD0aIZJA125JjPcd5vb
         agh7NhWYrkluvEDP7tGNaCDIOmBnmeeHh2+ZDEcd0Jso8EW9HTaDVOq/rgyAqnzGv/0X
         pWLw==
X-Forwarded-Encrypted: i=1; AJvYcCWdGRVcRv4dh+sYowzvpwO/IExvLXX4bjrZEZ/rVfU5wHv1FQ6xfWHUOBzAsXxQ2qTIN7VE3Ayt@vger.kernel.org, AJvYcCXnBJk7i0JONMynmq+dTjU4h5SW1rdmcb80CBekC7r/ENBpHkRrSKx79stNecdDLY9QWWG8qnVcMg91d14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxoAl0/aOoAAS5RKjo8NIKgxTnUASzioyMa7E7bzSCa9JGDOV7
	aq9+MxLke/0hiS+jH61po0vcscDFC5+bW2w3ePpwMs9CYhsEWmxF
X-Gm-Gg: ASbGnctmyavfoBNESXAWtZS7jwO96Blhu+tQ2zw0uqZB0Bhv61pCdtyd9cDmaVB1W0U
	1sGY3CkaqHapgXBDxbxmqqS3xyYOyKDr6loKci0rOxS/AUMpQE6/TjnnAYwI5QI7+KF7jgMuDTl
	/mt8CI/ynCKOwiSwD9ajCaQb7f/tE+tolVE18Pusj6+VZt60ajM5RS3Hjc0ugqr3yTtPDPE45Uh
	VLjzVq0RXd9fWt+HR/F4fhQRqK76TduU1ZdVpDUZOGuazsjArO7B8yRzQc=
X-Google-Smtp-Source: AGHT+IG/DHBjoiMM1TZQryxX8y2/sjwBmz3QjwGX/DjAsEoQUiD3apAJ1v4bCc1Gy0SriIoN79Dv3A==
X-Received: by 2002:a17:902:e88d:b0:212:37e:3fcd with SMTP id d9443c01a7336-215bd1926ccmr60148545ad.56.1733279776630;
        Tue, 03 Dec 2024 18:36:16 -0800 (PST)
Received: from localhost.localdomain ([43.153.70.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215b5c76540sm23071805ad.247.2024.12.03.18.36.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2024 18:36:16 -0800 (PST)
From: mengensun88@gmail.com
X-Google-Original-From: mengensun@tencent.com
To: edumazet@google.com
Cc: dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuehongwu@tencent.com,
	MengEn Sun <mengensun@tencent.com>
Subject: [PATCH] tcp: replace head->tstamp with head->skb_mstamp_ns in tcp_tso_should_defer()
Date: Wed,  4 Dec 2024 10:36:13 +0800
Message-Id: <1733279773-32536-1-git-send-email-mengensun@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: MengEn Sun <mengensun@tencent.com>

The tstamp field of sk_buff is intended to implement SO_TIMESTAMP*.
However, the skb in the RTX queue does not have this field set.
Using this field in tcp_tso_should_defer() can confuse readers of
the code.

Therefore, in this function, we replace tstamp with skb_mstamp_ns
to obtain the timestamp of when a packet is sent.

Reviewed-by: YueHong Wu <yuehongwu@tencent.com>
Signed-off-by: MengEn Sun <mengensun@tencent.com>
---
 net/ipv4/tcp_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 68804fd01daf..d1d167c93a4f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2274,7 +2274,7 @@ static bool tcp_tso_should_defer(struct sock *sk, struct sk_buff *skb,
 	head = tcp_rtx_queue_head(sk);
 	if (!head)
 		goto send_now;
-	delta = tp->tcp_clock_cache - head->tstamp;
+	delta = tp->tcp_clock_cache - head->skb_mstamp_ns;
 	/* If next ACK is likely to come too late (half srtt), do not defer */
 	if ((s64)(delta - (u64)NSEC_PER_USEC * (tp->srtt_us >> 4)) < 0)
 		goto send_now;
-- 
2.43.5


