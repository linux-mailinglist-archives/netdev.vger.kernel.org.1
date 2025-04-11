Return-Path: <netdev+bounces-181714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A73AA863EB
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D5D97A1B19
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B103221FA7;
	Fri, 11 Apr 2025 17:01:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82C5230BEF;
	Fri, 11 Apr 2025 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390886; cv=none; b=kqb7iaHS8usDglZ2RhOhtI/1pgNl5nyXNqpMtktzp9hvEtNILGPZv8ZUvdzRMPkVAzkSAqxjg/+3Ag1bZK9CJdThdxTo75CficSZ9usNQhj59XFhOgruqu2JoiWw5KSUfDgPF05GqorAor9c+lCCD6+g8m9SHZJc6+5O1KJs7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390886; c=relaxed/simple;
	bh=U/T93QwYmW4LdhpItUWeHJopZMmWtikVPIoipOrWDR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ubTxtrwmQ8lUpKBS8HOvxR3kJ/+zYo4itKjs/igAWMnbj1MH0G3v2vWdXPeQ+3eyjojMBWL/luEksnINHqJAvgwbshsiskZV9DpfipFbi5lLSr071KPRzHPtJzRquW6P/rc/J3UDpTkpGk/d3m1+ArDqpCMB9F1yQmOtY48t5t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-acacb8743a7so236008566b.1;
        Fri, 11 Apr 2025 10:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744390883; x=1744995683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfYr4DJDfNlnUipi8sf/XlvXzSj0Sgr2GuiXsiInMmQ=;
        b=n3vWRk8WH5a6Yt/yA+cb2JhOXnoSZXqojWNjzjAmGBuTe18CfXB2/RXpL+nlt/kABu
         BkpcZX1NiZGUYxSGEIhFnUcE1gmWVnwJKoCJmj21EFV+sy6ezIE2ucw3ItucH/R8uMyt
         lLhnNdS8WG8pQ0/8wkyNLTAi+/g/GEBSaOivFvh21O1w7BMwE80G7WyIYLZWbIUWNP85
         L31DfkxAtXSis1Gm+ixRC0jUuK8t6G3AhXDhE2vRRJ6SOdUmNK6D2cXJuSyud65j+BWl
         dTLeYrOX+F74JdgQsFpdgbLlX0zLljLxAwZGf0VbKD45DBEbYrFnhUs7AyUsHSqmDQI5
         BQBw==
X-Forwarded-Encrypted: i=1; AJvYcCWf2cEtvKEWg2/u3YyAKSC4e13l9B9e4gRH4Uwuon8h/oVVfDGxyqW+xjL2gr+h6sp9jQI3mr7bg1TnNQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx42joIXM8GlQjS4aYuWvaXSZ6P0CDn/kO213XkPyyu35IELm3K
	q7OwJeE3iSluKs6orFu1tQ3cV8Yzg3aGU1OjZp8pGTHXCZ9WQCke
X-Gm-Gg: ASbGncsueLc41ytHGf6jhR1VACDTZoLuIcXybaoYUgHuP47gn+wHhKlfqFX/6Z1I1WF
	HZqn8c2/ITMnCdqobECazrWSgw12WUEOfAXx+8UGFJqaOVh7mI5oonrOCGc+81GztKgV8sDmiXi
	TKFWcxGr4wTzvmUyEXqsUS0JzAvpcYZvG14ru/XU3QAm54Ztg/q1zZZz31yeUGEq5cQNxhcg/jH
	8MZs5XYZg9vTRfmQRIqbc/JOXEj796tmTXEY7jVGBAwmot9tAlXrFO1RlUbE8DswJiDzNetl0FO
	bO0+nLHpCEm935s1RwsEj5MI/J1XgwG7i70lXZ40sA==
X-Google-Smtp-Source: AGHT+IEoKziYC92Gi2BJj12QlXJ5l/czgRr6F/9lwZAA8RfFO8aTiEgMIPWN1bPcO4o+icV1MxftaA==
X-Received: by 2002:a17:907:da6:b0:ac2:4f30:5033 with SMTP id a640c23a62f3a-acad16a0e48mr351376866b.15.1744390881569;
        Fri, 11 Apr 2025 10:01:21 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb3c64sm467685566b.119.2025.04.11.10.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:01:21 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Apr 2025 10:00:54 -0700
Subject: [PATCH net-next 7/9] ipv6: Use nlmsg_payload in
 inet6_rtm_valid_getaddr_req
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-nlmsg-v1-7-ddd4e065cb15@debian.org>
References: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
In-Reply-To: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=leitao@debian.org;
 h=from:subject:message-id; bh=U/T93QwYmW4LdhpItUWeHJopZMmWtikVPIoipOrWDR0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn+UrUoHm11VmkP5Ez29RSOqNOg4ctvXATXOid5
 4m1dXxYVxSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/lK1AAKCRA1o5Of/Hh3
 bbsiD/47LCVVA5ZkLVFSq9k3+a659MYGxmYdmGmkkV0lMeBW5uKU3bcbG/cfykpIHZJPzN2JYS0
 g4UjXPpJWLQqgvb/NlPti6beyQUoGQyJfJgsMCj6PqH5ya2y10YfV8VLhR9csG3czhtVXcb8xep
 5fOSEKW5iAw5XlKi8QCNWtRzq5Ruh61TF0Y8OyMLLR5zAYLJ9AUpkqdimqSpkQFx0J1HvfEAFGu
 BlRgPkN5oygJy+CjfNO97wc/tNdQ9iLH9XdxSJwbeECl89gxMXBtEvs1IrmiiPc+DwMONEUngIt
 oi2MhJH3iSyGcoMvjONLk6fT3Nj98tTaoZTfDYkepIJl58gAjiwrUs7ocH7bGSsLH6V+7T/Ayjm
 VQQds2llXMIFnzbq+IfKQP+2FfXgbwxCCCM0T+3/DY8T37tSZyi3PdAX2rBKbI5CLpXyZkVMpOV
 5Jh1M0YlGOGmRP+83EG56a28DEE+vs0WJTnz1IKy/2w2ATwzYJ2JAD8QgGE+K/VCv2E4ycyzPNg
 Y4pSOFqEv7KlvyQ6uX1J4xlGJUvzCgfxa3KIXbP5zWSYEPs5Ju8zMKJQrhdnz1XJVKcEhS52tml
 hQsUHp9xo9rOIh152X0OJO1bLzG7iBifx2/gqnZLYo7t0stjMsv12nDFwgXIMY4VIHEuiXY1eUR
 DPeNw4flNLqdZbA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/addrconf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index a9aeb949d9c8e..4af2761795428 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5484,7 +5484,8 @@ static int inet6_rtm_valid_getaddr_req(struct sk_buff *skb,
 	struct ifaddrmsg *ifm;
 	int i, err;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*ifm))) {
+	ifm = nlmsg_payload(nlh, sizeof(*ifm));
+	if (!ifm) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid header for get address request");
 		return -EINVAL;
 	}
@@ -5493,7 +5494,6 @@ static int inet6_rtm_valid_getaddr_req(struct sk_buff *skb,
 		return nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFA_MAX,
 					      ifa_ipv6_policy, extack);
 
-	ifm = nlmsg_data(nlh);
 	if (ifm->ifa_prefixlen || ifm->ifa_flags || ifm->ifa_scope) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid values in header for get address request");
 		return -EINVAL;

-- 
2.47.1


