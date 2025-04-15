Return-Path: <netdev+bounces-182978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38A9A8A800
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2283BF2BB
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F411A2505A7;
	Tue, 15 Apr 2025 19:29:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E124C090;
	Tue, 15 Apr 2025 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745359; cv=none; b=GHzm6YZGcDUbWIpUFzX1gFYgFjzfwdw+enR1x1ZeK79fJ2xtvSrGC5NxToSdxpxCayNYV2YptGpCWg6lapUxShPAlVdqIdw5W6l6a0TN3vXR4UtVgEsEifaaMJiJ8ggSqiqswpFg1dKn4nF+SEiIZFzFB83SCeNP5+Pg+a8SYT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745359; c=relaxed/simple;
	bh=09yM9J35GfgWV0AIfeBBnAq/ohKxlMOU9G3h6LAb0tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DnUTXYUC13TiJ8mIOVc2kxf1Ap42Sgg/7GL41/40WUfWazRDPF9RVPBrGb6MrGQhMDIcftP1xO62Jiz0HqZkQhfyfbpJLKBi0aDB4+21t3imPBdhLsG4DilYFOp//1ipdKcWgNOr9AfzfazHoUU22fYlxJmufaGKylt96yB1xR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac3b12e8518so992015666b.0;
        Tue, 15 Apr 2025 12:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744745356; x=1745350156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35YdohwXnzbdVQmtCJdyFZZ/ZWY/+ILI+5o54QUi/DU=;
        b=ZmoR8aFEyMyoFTo2/s0yvBvZ5IZwhjTLlgiE3GDjWPKgmIcop7ZK6ZEEuxsjs8aYL8
         zYJqU0PJTGg6lG1rMxoD3EWvuzSm8BjNVaYR39+HPjft3I6ZqC7PVni0Fgt5cA/X772m
         NtbOXt3h9FweMimRgB2jUdVC17ZZhDe58Cp6DNoI0/GGoBnJ0bnHpsika6NknpFsRqde
         jdyjQcTjU/A9pQNPZKK/1bWyWBwZR8HvQKtK5Hr++okurBlMdunlZwPgiZTkAY2/Y3Fq
         I2PFLTSKfiBqNIlDgtqVg4QzQtk1qa/qh/ZDrz3TK4MimDZtipvwWGPJ2gYxcLeEClau
         ms0A==
X-Forwarded-Encrypted: i=1; AJvYcCVtvdi/8xU6XO0Sr6zJfw/z8LBSlPUEWOCeB538FH46Fl7iTHgsQBZ3WNu7c4bPVeBHTOas8JXjTO/EWRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHsVRrNNgm4jX1g93FgMWu6lHs1BrQCcVvcpGixFAS/lVdxD4m
	drRRKa3SsieYDXvVwaCdeFtUvO5s++BfuCb2ttxHJXb70tmpFHOro8UKFA==
X-Gm-Gg: ASbGnct+I7uX6i9RBsGeknlQybnKnIxgyKYtjUpDHDOjt2mQSTt+/5RDF5RD08wMRYU
	XgYA4ARQdCiyfBvzksGcOQPas1mvB26TbFKv6MXbE/BC7r3WZ0ogRCLJgC1Amf4Z3vP8NbFqhqL
	2EPI4Ngwrb5o8xVzIEyb5UsRUP1UseIEuIE9ZYd0/xrrQISfUWIU8ljRWSuKDFClWb0BirXE/gz
	WSzk5F28xsleVC5t5tYvcOu0EMsxEWHvATUaV8FXsj76MCn0sNlDCmJMsj6uhmihe2m5JXiQtob
	pmxA8VX+93DGrgkqDO72iWOXLTPmSEc=
X-Google-Smtp-Source: AGHT+IGfZjFEc7/v21LrsVqoLPArkKth20mKlNHBTPmKgiTUhPE6g60tqQFY+zX/bMyO1TBNWf0PkQ==
X-Received: by 2002:a17:907:2da1:b0:ac7:9712:d11a with SMTP id a640c23a62f3a-acb383209b4mr24799766b.32.1744745356243;
        Tue, 15 Apr 2025 12:29:16 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccc0desm1131759766b.124.2025.04.15.12.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:29:15 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 15 Apr 2025 12:28:57 -0700
Subject: [PATCH net-next 6/8] ipv4: Use nlmsg_payload in route file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-nlmsg_v2-v1-6-a1c75d493fd7@debian.org>
References: <20250415-nlmsg_v2-v1-0-a1c75d493fd7@debian.org>
In-Reply-To: <20250415-nlmsg_v2-v1-0-a1c75d493fd7@debian.org>
To: kuniyu@amazon.com, "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118; i=leitao@debian.org;
 h=from:subject:message-id; bh=09yM9J35GfgWV0AIfeBBnAq/ohKxlMOU9G3h6LAb0tc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/rOCYjDVQHohl8ke3E/Z2RnlpMz8+44bJsLMa
 Ar4Dl9qj2qJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/6zggAKCRA1o5Of/Hh3
 bcZsD/9p9LTtA19A2Tbx36wi1j5D8k1cujJiqUC8s++2zKUBZHzlPnpVLQuYCU8CclEe6w3oyYp
 gDgc9adRtIXGcGYUN/Fb42l19nFBDvyOxW7cDNJ1H0O2xNR+OIjsP8IFXYKhHo8ZvesukJkyFA5
 6/N5TXZsZQ43mnQr3XWV36lTedbzMC38Oq+kOwVnvz7DK+u2KMvQfpA/9Eog2Bas06FvpUVLGCA
 F2aTRlAuccHQWSoJYyfqQc5uBtWt07/IPGNKaFfEkW7BqqhuHEzMBi4HVF+1+kEKyt1qEDg6JHA
 dsuxwDkN0Ez6YZjp/r0itQY0NiGN3FLy+ItOy4UuR4ze1JlNmEEhxF4kzI8F8bh5ukcGHnD3RrD
 Sno1VrG4j014RFLwJsT6qnEtXfU1jr5J3dKWT0r9j5iNyCuG0NhNwbJ5HIwxlcD1vn/J4tZ5NdH
 5gjHiYNscTFQ968sLswNgoPA2j+7O6MaB1mniVXpv9f0JO2VPRfbFfKoIvGaWD4dikkGO3AECWN
 lVgpVobDRMv/71PvPJh5NLV+tE5hhqdLx9jBZALmy4rHlDQoWrpBnmSWRA9ocjYc54SIRdh2F+v
 x0w8KonV3eWJtfSKCIGZT45nN8wfjIaXEeP/JImSGKuuuI7hj/ub+auePuN7avwWe7tAcroxFjD
 5+VniyQ6kXTamQA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv4/route.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 22dfc971aab4b..49cffbe838029 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3205,7 +3205,8 @@ static int inet_rtm_valid_getroute_req(struct sk_buff *skb,
 	struct rtmsg *rtm;
 	int i, err;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*rtm))) {
+	rtm = nlmsg_payload(nlh, sizeof(*rtm));
+	if (!rtm) {
 		NL_SET_ERR_MSG(extack,
 			       "ipv4: Invalid header for route get request");
 		return -EINVAL;
@@ -3215,7 +3216,6 @@ static int inet_rtm_valid_getroute_req(struct sk_buff *skb,
 		return nlmsg_parse_deprecated(nlh, sizeof(*rtm), tb, RTA_MAX,
 					      rtm_ipv4_policy, extack);
 
-	rtm = nlmsg_data(nlh);
 	if ((rtm->rtm_src_len && rtm->rtm_src_len != 32) ||
 	    (rtm->rtm_dst_len && rtm->rtm_dst_len != 32) ||
 	    rtm->rtm_table || rtm->rtm_protocol ||

-- 
2.47.1


