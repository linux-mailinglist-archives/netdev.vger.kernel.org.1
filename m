Return-Path: <netdev+bounces-182212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9011A881D6
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE8A3B84E1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743E02472BC;
	Mon, 14 Apr 2025 13:24:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A962624728E;
	Mon, 14 Apr 2025 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637086; cv=none; b=bAjtDCFIQ5Z2HPH6gserjpQMluChPRNp8Km56y3r3vFMn40GjbTFONjzO8muUqkgbxJtrq+yawKN0aB+Kb40Lwywxl4V69L91icPnSRtz7XdSsMrxNE5YwPyf9YmIaVPrJVCV7/6kv+6UlUP4s/WyrEyQd4rHfR8bQTDOnEC1zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637086; c=relaxed/simple;
	bh=Pi7dAziMSlR3ymqB9s+k3fs1KGbdD8zdHAEwvBXg3ZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RaodBBoAly2KSAlSRZcJB6+v4pl8gtBEYVioZyQg7mMPccqk7TScJ0vjRxVKQXOXsT7sfkePo+zSHWV2SEA5I/Qaz8nM/O7f/j25lyKOyWEe/hKcwD3BDfKOBoYrgBoseI48vpnDoNjKCADp61czkjBNjABrwWWpBgGoqg3mWu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so7467792a12.0;
        Mon, 14 Apr 2025 06:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744637083; x=1745241883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSlWr+LCRENelw1f6mytuxXdWnM6i/hVASYqyjr5v94=;
        b=XF97ORakxrrPyyLrsTacsazVJh0iLNWP0c4W7lbY7NyJO7POCESnWMmBMlnYCjk6jU
         7AvJO1KsbyC9FRgNopLakaqrbp06vXu9qQs2XQshos2iTuZf4wR4zBjgkN6D0tVi/Mkg
         uSs3Ij8WROdmNxoaC5cfb9ZJWiFNZH1gK7FjYOduTieU3maqENfqVzA3DYW70PMSO64A
         b0Rz4OGlCrS0HftM53QC21WEcbLIb1wxn6hzc6bbfb9cQJNlJFKO20WSJ+8sYYFxUHSV
         GXaNNX41921JrZLpOrCfeSDtiVYlVLFqTDVz4RCtb38XB3qhjCOff4E16X8PjTForvvl
         8W2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsSk1kK6aOCYI+awUuV0cBuBal4emOjjmYzF4DKUuvhz/bEMITKSrE8MvnMYkVmVdS63vdB+Se2X8IsJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0KRKhgzzad3CGOMUWwGdY707oTgMiZYfFaOdl/U/IOHPNAJJx
	NqVMF6o8SlmVnNDSgruminDcZzS8Me0kVItOrVMkHY/vjQM31UFB
X-Gm-Gg: ASbGncsUJgF/vyPkwmCTCwewABH5LIzMY2pL4C5v0bzKSzzkbl4M5mbcNGuIrY94RPz
	h3FbgkAEF2oWx9Muc5KEg3Uhn87Ce7wJb8RLdtLg/OyDPz0AKMiacvdoEVhPjhugsNoJUNshMP4
	xWEXqPOf2PKE/z6xPLGGmZKazPShdi9GxoKP7k/aWv5+O0ufzA4udt25QXxX0LzGjDWYgaJZu2M
	419yGQBW/kbbM7D5XAFSevt7Hj3jNXoxPpldP/XG2MazRGGbZQnaKeLcDA0R3Zp9ZQPn4VJFj5N
	VjmE8qeXx4oVAPSjvdF3XcV//LK//Ks=
X-Google-Smtp-Source: AGHT+IGH/bFChpxan8KnZ04VF6vTDjyMXi4Rg+e8qLEHcNs8Xf8UJmWLgWJuTsUABLUOO0fe09LNbg==
X-Received: by 2002:a05:6402:3487:b0:5e6:1352:c53d with SMTP id 4fb4d7f45d1cf-5f370292bcemr10499004a12.28.1744637082778;
        Mon, 14 Apr 2025 06:24:42 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f5056b9sm4834761a12.51.2025.04.14.06.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 06:24:42 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 14 Apr 2025 06:24:13 -0700
Subject: [PATCH net-next v2 07/10] ipv6: Use nlmsg_payload in
 inet6_rtm_valid_getaddr_req
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-nlmsg-v2-7-3d90cb42c6af@debian.org>
References: <20250414-nlmsg-v2-0-3d90cb42c6af@debian.org>
In-Reply-To: <20250414-nlmsg-v2-0-3d90cb42c6af@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=leitao@debian.org;
 h=from:subject:message-id; bh=Pi7dAziMSlR3ymqB9s+k3fs1KGbdD8zdHAEwvBXg3ZY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/QyO3Xje36ECT19iFNC4PH++wWurTGneO4Uuo
 w4fLFZ/CIiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/0MjgAKCRA1o5Of/Hh3
 beCqD/9YfKQ5OyO3mMLqQv796HMbQAdoEvDosywTXtGq9aenF2dMTeOUbF2IsE+6hoDTPscDxrx
 6nM6e4fCUIfnZ3iz/hwg4qJvYSpKMcctxrj/kpqxEf00xqyRdNf/wH50aGMQNKEGm6RF8TV++L7
 bCZh2f3e5+O1u1QFTA0rRxJhiX3MhElhA1B7fKI/MmHZf9KMNq4sKhdxJdT4V+eAiy7/ybBWmq8
 Zg4lh8MAOTh6pfm9F2Fbqd6szlqPjBMNDbXiBqhKudLLVCo0+SOPCuz6Itfpi6JeFRrIXr0agRT
 QrfLIrUNtOeK6LJjs5X55U0U5xGlEaNhenaDWOU8/X2UnShnueEaPF71VYyutFtfwzCYsyohKZl
 qVsYsz3i+gbST5fyQcW08fDkaTrASB4hMQHU/GK/JRkgRraDCXP0U1Sp+sDmlSqctF0b4QUSYjc
 He8D0aWaLtKbh1uYiK/jVf8FUgmkhvCSI6aKrU+xcwYNvCqf6lwNAvUtJQdPkpBPpPZxGXwYFu1
 ZI9g5Xiva9tlyQTzTPhhpCsKZq3Pwy8hpneZNyYgFwGSiSMgFDyxs1x8+hiZezsm7mUS0Ol60Zs
 h+rLjc6JqG0EG3nKX24esEZkCquXl29BHZqUiCXqDtW71KxF2I8LIKHRZ9VPDvK5hTV3XgZY8J1
 ReOPE7M6wY1WRsg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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


