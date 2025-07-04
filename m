Return-Path: <netdev+bounces-204176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C926CAF95FB
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F5B16E253
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46EF170826;
	Fri,  4 Jul 2025 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/9uOqXw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E062143748
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751640555; cv=none; b=BjmA4BjxnjIJk73sKuyJhNrOPHPcUEPGPjyQVmOXR9FFHdsj3N+J+JLbEg0AwN2OA1fflVSeJeGqlX8CQNWIWtByi6IITAcEY83PzcUh6ABqzWxmdqkHUbXJtBGk306ZopLOQX1QQUSImmss0EAVI9Fok1AnHKpgpf0fFiJkGDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751640555; c=relaxed/simple;
	bh=R5E8wTGdQ3sxDBRjpdP9NkbzfuGHyP+JILn7Fo1sKlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o+ZQH5ovO8z4ipuDAfxjpyS7VkLK1n7HmGjLDwct7Iqs3k4dCjqhmAGag0JimPNE/qWG/ror+YrHmv7yGzyUZOUEqmX6CR0XA372To5MDssx1p32cq6NVJBGTkbm9apmt+vlZ0LgmUNRf7MRJvBpSvCxV3NqKtL3DLc0Tb8lzXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/9uOqXw; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7481adb0b90so190492b3a.1
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751640553; x=1752245353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AYtFrRGbnpvTJ9oR8iI0W9hPYDL0J/lxSxnYCw/BDto=;
        b=A/9uOqXw/f8ZtYiLKApxHgKnVoUCIT8rfoDu1ybJZcLeFovfLFDujc+3fJ4hIIeYtm
         h3/ulsOjnLxTdQwP137e6TK4Dap8KqomGYmdC8dv8QYooqGSz0O8HWu9XJfTawvlboFT
         1vwmongEk2hbZTsCAei9YGp6WKdofWMf5KglePOmBlnCoKg4kot6Pj5XqTHFDOqznN7P
         1f82DQVgUjXuZad4Nph9YJvDRvjWumavkNvo8cr8qOnc/whnKrAvjJqEJy/GQAv4g2LM
         eP1jjvVD7k3ThGRyp/8SgkGitTw2RFj7cxwv/r1nQbmvnwlKDaxgeDbfJdvalFy3oQcF
         Hi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751640553; x=1752245353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYtFrRGbnpvTJ9oR8iI0W9hPYDL0J/lxSxnYCw/BDto=;
        b=dpLEvCuV2GkxnBPQTN+nz8D6FeBPc3VNYVV3PF+vD/RxboNlONSEC3BC2cb7+yA/rC
         e4HLKLrsjxwsrCxnBn6Ev/42Ec361fZWk+rQfZ6+jcg1BeHTWmfeTOJyjYXSiHGKXjAP
         JIohBStHUxTeCH767J4B2qUN0DRU36x+AoWwTlfU42q+M9mxS2dnsx82ZSCXW2EtejRZ
         /SHrmaeAC1oud4Sq7E6e95G8rA+0QNukHD9tlGQ6w/77ijTSm/q6gb2AM33dkrZXwoXH
         y6qI7XqDb4kibaq1uoXgb1F5N6OUNYMafn8SUC6lT1e81vGmlPy0c7LUMEITjTTkI1aV
         o9Uw==
X-Gm-Message-State: AOJu0Yxj3EYpVKqr9+fYX1asdt2/P4FO5raHKoi6iZnGtbLB8qlsjKRn
	UksQirQPmdcIBHgdlxbYbXAbmAfnA4cjNGmoQ6rdTQeT5u8VUK8Hp6I=
X-Gm-Gg: ASbGnct8PNUu30YJKbfTGQGpcBcyJShCdNP+ZJTmLwNDOn/o1Ai592kmjBZUL82+PW4
	8k9UIcynpfrzH0gdwFvY7FBaw/v3Micmpzt6/1M10AfnwfyAsAFvYaAdg89GMStxJX1pa1/OxYm
	PxROITgmf+jeWSCZTn6F9wA7j/ZdgLF+2rlHpgMOkfbdoV65el+sJajZB8xDWsoyL6krIkCPWRo
	Zkx8oUqAlrUe2MeCdNNmr1OP2SqU+1uw/vfsVby0YpGnvt+7IBiQhyDNFabFJ/tKogEQU2oR7TA
	XzCwUeEXFOAEU4c3e4c4l6kXq4GmG9W2t7VdQqesjxSwmUTW73Nqk6PFlPL3BFi+Lfq5V+TRXOW
	ZCw==
X-Google-Smtp-Source: AGHT+IEOmZJhGDUjH5KPDEetLZBpqjE0dmiz7wprdzTdLaepwEFtM5z0lLsiXlhwd1rkQdPYyQHbvg==
X-Received: by 2002:a05:6a00:4396:b0:748:6a1f:70a6 with SMTP id d2e1a72fcca58-74ce857259cmr1471653b3a.0.1751640553342;
        Fri, 04 Jul 2025 07:49:13 -0700 (PDT)
Received: from jiaoziyan-Precision-5510.. ([23.163.8.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce429a0b1sm2357279b3a.115.2025.07.04.07.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 07:49:13 -0700 (PDT)
From: "xin.guo" <guoxin0309@gmail.com>
To: ncardwell@google.com,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	"xin.guo" <guoxin0309@gmail.com>
Subject: [PATCH net-next] tcp: update the comment for tcp_process_tlp_ack()
Date: Fri,  4 Jul 2025 22:48:30 +0800
Message-ID: <20250704144830.246159-1-guoxin0309@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As ACK-TLP was published as a standards-track RFC8985,
so the comment for tcp_process_tlp_ack() is outdated.

Signed-off-by: xin.guo <guoxin0309@gmail.com>
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 79e3bfb0108f..e9e654f09180 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3714,7 +3714,7 @@ static int tcp_replace_ts_recent(struct tcp_sock *tp, u32 seq)
 }
 
 /* This routine deals with acks during a TLP episode and ends an episode by
- * resetting tlp_high_seq. Ref: TLP algorithm in draft-ietf-tcpm-rack
+ * resetting tlp_high_seq. Ref: TLP algorithm in RFC8985
  */
 static void tcp_process_tlp_ack(struct sock *sk, u32 ack, int flag)
 {
-- 
2.43.0


