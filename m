Return-Path: <netdev+bounces-182977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DC5A8A7FC
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77B83BE347
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9178024EF8B;
	Tue, 15 Apr 2025 19:29:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C244824EAA4;
	Tue, 15 Apr 2025 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745358; cv=none; b=l3jS2TP3Ko8VWw1YNqL8zWroOaJamc4U20YF0gZtvQi/YwZOtJNuCk3N3XnRPC6EprDa9xFMmAy9kp5HMJ4P0/NdFuEY7ErK0obmfHCm+dL6LFVonQmyatZ7QU1xAIuHUiW/GBnWXeGzCHtmWgmO11Pw58HUqbIXu1IT1VBAEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745358; c=relaxed/simple;
	bh=uN3ogHRpI9nLK6q6EkD3At2EWCIYjks6iGYMbyhg2yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ABF5PVeGeWJHQqzudP99LVP1K9rTTDyVb57vcONgw8pmVS/WyQ54kSTEtBZusMz5f3GP5bdHOZSdtnEDO4difNE8aRPuLiEBNBDfZ4NQXpOttdL6bOh/o7mwNXI2ad8BTAXPJcKydJXAhBxlyKp0Kx4uyeJRBY2mq3xGzSqwv7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso1112356566b.3;
        Tue, 15 Apr 2025 12:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744745355; x=1745350155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAwU5RndzmNZ5o/+QpbFf0rYkVKNiHj4MbrXWCGbp+4=;
        b=vA1BzuD6qQn3CwEs+/pGzj/AwgB7oCnq2Bw380EBSET5XiuESeFbqEZ5lmT8ehhdNr
         SpWO6gRszc6QSiiV8O5NxSXxGNQb1qcjRyYBeWaP9U7mTSBg34hqteFYoZajoLD32KZk
         DD+6YrwkpJgm4BQPfg7F7SkD76faKs2apbZlUEi1TxW8Yhn2auIcRZ/xSQp2ejppqP6i
         pLE6zQHzvb093rrgZo3oO0Uns4jqmTMqY5mFsangdEHn4HOtVkObqHxx1glBKpjt5iqT
         rN8R582gWD4vBks5vF+AT1TEAK6cFgW6VoNjKCfnA5ERt43R/v7Wh1/VNcK8Q7uA4L3q
         mDWA==
X-Forwarded-Encrypted: i=1; AJvYcCXq/58bv7b27+P3EFvxxRxqvhekg3AKLCGm8h9r0OGfbOvSfYwxwBqajJTD/evbBAupA5cwXWUu0EVjCx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQBUtMuvdY8elXbkn2g8v55whZcnrlxCP3HPT8ZaCkLC9O7Qu7
	O5fwpdtShWlSXj9oXm4wNr/1yoD0Nq5CCtzv7yZdJgsiQdnSIYiM
X-Gm-Gg: ASbGncu7QlshSJcPYItRwLmxU1Ur4lec12rQzo8LZwKSl4DQS1y5s2kNN426vUgZezD
	QjvxGWUuxPl24FxeGKhryBItgSVg1dDg4UfQyEvj0QVqzd3QenPQ9Ov+Pcl1Wr8+YLA9JlMxAv1
	Ae9/orj30UTYmtNzabFluQNWMJJorSqX1Ie1jAeWVTmH9zVUXidSqkEyxOOxfh+raoBmCt7F0FY
	n9ys1W9yVcFTRqSz8exnnUPNBaf9AIOLQn1pG9KZcg51WhxgPnrg60a676T5OrSgfLyTKog0ibB
	wvI6tBCMAWj3g9d1HEzZXkCrcGXIsps=
X-Google-Smtp-Source: AGHT+IEX6QPFnjemB4tceukGjpLsQs2uSFso0ea/I1W0FqBrFdKoIzaJdShQgcYAkiJbcTTB/mdPFQ==
X-Received: by 2002:a17:907:7e8f:b0:ac7:805f:9056 with SMTP id a640c23a62f3a-acb382c3c88mr26683866b.32.1744745354859;
        Tue, 15 Apr 2025 12:29:14 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3159sm1150473866b.37.2025.04.15.12.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:29:14 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 15 Apr 2025 12:28:56 -0700
Subject: [PATCH net-next 5/8] ipv4: Use nlmsg_payload in fib_frontend file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-nlmsg_v2-v1-5-a1c75d493fd7@debian.org>
References: <20250415-nlmsg_v2-v1-0-a1c75d493fd7@debian.org>
In-Reply-To: <20250415-nlmsg_v2-v1-0-a1c75d493fd7@debian.org>
To: kuniyu@amazon.com, "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=leitao@debian.org;
 h=from:subject:message-id; bh=uN3ogHRpI9nLK6q6EkD3At2EWCIYjks6iGYMbyhg2yw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/rOB00iv3g9B+6aRBKlvLwjykIzUEmbzgswoE
 kgx747lkxKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/6zgQAKCRA1o5Of/Hh3
 beXnD/4zur89K9N6WDypS5kLqu/FjzTP1vJJGquJ58bLdlIn+bv3+HmaBSQqd36enqIza8J3lOB
 T9zzuwLbtn7lo2xauNWsmddcgg4ZuZ61afYb9QwtAIHaBNRm/pI1tSBb+dISqcMDRjqPJW3c27E
 XjrAzxmJh4zSlwmDUniL+fqHGzqc3FE3wJM1eT3GKRV6WyNn4eWjxcM/ammEVUWpteCFbhr836O
 Te++5fxheSI19XC4GIqp6Z6WyeKvj+th6RdO67Mv9mQvVCKAspAsI6lj3yH9vJefP5TyW8LEXIz
 m2QGgq1Y9zNG0epiRUVxWkA3nVm3zxKg7umW9Zg1pkx3l9I5+C8yQmmqZsF4y882luIyelMSO4D
 6bTP5TfwqxOZcIHJCs9ezAzq5CO2LOM3QLjRPyxuHsjeSXKIG6LoevodwuD6tAtAsLfBXmL3uYQ
 dcDcxY0BKszQTAblHMTmqailksegvWNts/rfc5ibgqEeR8sb6yMDoXNhpt0pl4nOVl2Z/TBvB1+
 fxd5jCb/DyMEkxesCZ37+uhyIS/Ihird+dXvpVFaR1zoOSAT8ujW4nwhASGLJ/gLPOzrFiZz67a
 IdQEaaFzES2swJSE5TiDJSYAjiGXALlJ0UGmAIqSX4gvQz+8jUkqV9zTJwIfApSdozQHLCb51am
 hWBJ+B4uYCBMnlQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv4/fib_frontend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 3f4e629998fab..57f088e5540e2 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -948,12 +948,12 @@ int ip_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
 	if (filter->rtnl_held)
 		ASSERT_RTNL();
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*rtm))) {
+	rtm = nlmsg_payload(nlh, sizeof(*rtm));
+	if (!rtm) {
 		NL_SET_ERR_MSG(extack, "Invalid header for FIB dump request");
 		return -EINVAL;
 	}
 
-	rtm = nlmsg_data(nlh);
 	if (rtm->rtm_dst_len || rtm->rtm_src_len  || rtm->rtm_tos   ||
 	    rtm->rtm_scope) {
 		NL_SET_ERR_MSG(extack, "Invalid values in header for FIB dump request");

-- 
2.47.1


