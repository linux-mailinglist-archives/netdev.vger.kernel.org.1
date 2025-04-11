Return-Path: <netdev+bounces-181716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1732AA863FA
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222741BA6148
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552A4233150;
	Fri, 11 Apr 2025 17:01:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951D9231C87;
	Fri, 11 Apr 2025 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390889; cv=none; b=eXt2l1sRskrdcBnExo+yVwZN9w2AfcTXpTPUyoeBF7Gv6G3CKryc8YTTghJYWXJ8KpiyNibZn+UlC1Ccq68UyK0C05pVj4A8ZBczyPqrhZrI/sD8sff1oPQVEeyukUIVL96kGM3H9yNiWrMSUnsny4kIEGMqqtIyvKDPVq+x8k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390889; c=relaxed/simple;
	bh=EiG73+aTQE7S/MDqcWls3yhcJw/iCgj/TzJM8CJcM5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hUhvu6k+zAev77C1Fhy7thWl0sxeIFWeMLEKVegyCg8s0/4aSGq8holIozosb8Bkc9E4+QQXPfHyVR9NpEu3jSMDfzvkIkHIGJ8xct14k2xybe3oS/9e+tUOHjRUjw1PMy6JlMvKzDDd1aKxHbNmcyhGP13Nh5TyRJ0zI/D2OZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso373542466b.1;
        Fri, 11 Apr 2025 10:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744390886; x=1744995686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UI7p33S7vZdXBZmDGML1UutPV6e0+OcpwTD0JMF0uw=;
        b=QSYqenM0x0PWIwiX9/cDV5U2AoWJlXspTf9JAFke/VnwLddOr4suQg9t65+qKR4wmj
         pds+4/XZ5ZUqR35ZkilCc8DDbQhbYrXm5llAuWJoTEoh/FtiS+JCQ13wkrBUSSo+IcPF
         SNEYRgo9RROJFrvdjYhIbWjuakz88U+2hEOLKE8bxaKEmTYj3cuNmwpBgekSyt8DUYkH
         ta0Cw2aWf7eq1yPWiFFrGyjrXBQr5863P/m5dP5V+x/zrWFDY+RFz9ZiWLrJPZuLO9sF
         1UTm9SYEaCYTNfBENpWnmU3ovBedaqX66z40Ob4G4N9p8WTuw62XSIxeK20qq2M/5Y6y
         qcnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmpil+a6lEK9uuQcxAtdbSw7KjipfwYg/8rkbfa/9ekokPB1N61suAtgNnv2wm09H63eTCb3ws0ONTD9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxihQif93so6+Z6XHKiA5F6fpI3LDXbMGwabo17f+kqDK+hpwyq
	vu5ZHi0f20a14I1CNU1UqS8Dw1CWnOaj11GLT/Ti5rhrbPactBds
X-Gm-Gg: ASbGnctYADIjhrTbz9g92sTy5s5uN2NIR3c8FGT1uejzmGQhDXSOi40QNL0PtZE8VDY
	df6JcLtEXYZz5jP1bDjACpR15Ws0ZhQsYAKCoYkM5546oJjockOVueF5N3pUk5VaiBYiThfolQR
	pJ6hT3GbgdH3tY8rhq5xqd/tUZQq/nlHTK4sy5Q3iH763WnL++9PcwQRxfEwErpKpm73gPH3lGm
	GGsr9MDCvqVOj2bprorebpaqDYa8TMZ8atF2hg30kNvqbajIanLTO0x+WCA/cJkxza3MT/hT+TZ
	lGURMxfsJeLW9uriOTod/4UD5+/3sml4
X-Google-Smtp-Source: AGHT+IGFheNQw47GZmDm459hLRHGPHNCsO7bexNsum73b3cU4B0dDNZU7rLTWcahTtB8zM02x4etvw==
X-Received: by 2002:a17:907:3d12:b0:ac3:17b6:737 with SMTP id a640c23a62f3a-acad36a465cmr327371066b.45.1744390885717;
        Fri, 11 Apr 2025 10:01:25 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be913asm461984166b.47.2025.04.11.10.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:01:25 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Apr 2025 10:00:56 -0700
Subject: [PATCH net-next 9/9] net: fib_rules: Use nlmsg_payload in
 fib_valid_dumprule_req
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-nlmsg-v1-9-ddd4e065cb15@debian.org>
References: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
In-Reply-To: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=939; i=leitao@debian.org;
 h=from:subject:message-id; bh=EiG73+aTQE7S/MDqcWls3yhcJw/iCgj/TzJM8CJcM5U=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn+UrUuX8oOq/T1XMwMZLWcMYmbmdzdJ4+MYY/N
 cdSv+7ju6KJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/lK1AAKCRA1o5Of/Hh3
 bRwuEACroZ9Go2FzGXLuZooufe1Uq/n8S479BFqm9VqpmNoqvqqwK5doxtKL7FuhF+j4qg6IV0P
 pTIy1RCICqocTLMII08Ttn4/zDIdfx7k6JdZaNystX4ekjHXSncbdb2ZmfqFTztsaOcgfm3idDC
 UvMF6CYXFRLlwho62gH5z39YRdjn7R4bG1OC9c300t6TdkzCmZc7CXGzWhlM1TPJYDD8cFQJEFv
 X4graiELXoWB6qaVPwjpg6wS+zPQKcWhVzCBETVkxxDVmIqWDPppcgUhX/UDmXtfvC8hEHkQ8gq
 5Ej+CENeLMk3ETjTzYvb8U+007G2NeUI7L0fR75fuj8EzW+fvjYOQG6/ILp/TK1O/ZIOyDjuL4x
 C4bHX4R4sXghvMVbVWHbHjbPpgM+t6TxYHdZzqFyicQ3xTXGYMZsHK02kPsBncHqH0D4ZmbEf4P
 PPcVr+WV3BZZ1p2rKnfbuk5dfJ3MFRuOViDhZ5o1MdlB+7otNhPt8Bz3SI6Wy4li6JY6SKFmABO
 XEWnPF2q2OmhjuBw9U0KNGAGCmQNW+aqjxxLxfyjsAli6p4k2Zawp+26XW8aFVPmf44JdjGP0wq
 K7yX3lE68x3FtXtoLiyfS4s5LyEjCQU5CtEFAei09BiZPJXP5PACbna7eDDBeNhWURvTBp8oq0f
 0tbZn8+uE0D7swA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/fib_rules.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 4bc64d912a1c0..6a7a28bf631c2 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -1238,12 +1238,12 @@ static int fib_valid_dumprule_req(const struct nlmsghdr *nlh,
 {
 	struct fib_rule_hdr *frh;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*frh))) {
+	frh = nlmsg_payload(nlh, sizeof(*frh));
+	if (!frh) {
 		NL_SET_ERR_MSG(extack, "Invalid header for fib rule dump request");
 		return -EINVAL;
 	}
 
-	frh = nlmsg_data(nlh);
 	if (frh->dst_len || frh->src_len || frh->tos || frh->table ||
 	    frh->res1 || frh->res2 || frh->action || frh->flags) {
 		NL_SET_ERR_MSG(extack,

-- 
2.47.1


