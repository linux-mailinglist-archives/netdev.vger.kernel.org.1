Return-Path: <netdev+bounces-172946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D51F7A56934
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 250277AA368
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAD121ABA6;
	Fri,  7 Mar 2025 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oQim2+LC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5C221A447
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355050; cv=none; b=LbYd9EsJk1hFDdjwpsAZa39g8LldFz+tyLe1s7OPryxoAJ/z2h7AYlhgpcB2+hPA5GBcdcRwz05O3YsD/y0IbZezT5t/hZ7kvK/qX1UuUYTXwEfsNqo8+UCm0arB6oOwKSziVHndzXZnXLROJx8QZs3Ggfn+y5LHF4vSEd1xIes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355050; c=relaxed/simple;
	bh=gCKy6Z6IWQUo4NVubERjekOLQ8tO2OPPYqCEFVEa+7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kpPchmeoCHIStj9Hi7kLi0Rda6sYh+NQof6XIQCCQJ6U8kUjJeG55Q/fDc94qptexlIULDV3cxsdaxn4POKAm3WjqE0ZFgqv2O6llUysEEmNR9La7pje0wPDI86QVhQ2XRKJenhNtVH6SlFe7YZktob6E+ZEotcv9hVqzhDwzFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oQim2+LC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bdc607c3fso11432545e9.3
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 05:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741355047; x=1741959847; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKa+tQTLZjzXmIzy+CrH4sUBisOXOqgtBvJQGN22yDs=;
        b=oQim2+LCLRfTmtd6zEOlGS6EGN4zQu2iGCQ4ks5rZT6WQBb4rO6CkM+0XC+16PUpAB
         iTfImXdnBmzmyDQkmllG4mIOBNPNeApdB5OyZNeN9RU9WDGBMdnT7gb5BKHsNQn4yg8r
         fq3MdkB7DVq8GPgvndZMKVNJU3EEmB0npichZlDvAqvs02EI6p+Xx7KUhlM57tI2iXsi
         WhtpmomlbstYWS+R3V+42MrUl0GUq+BK1nCxqUDXv3UEAct56aEVGC1yaIXLXTIMll+T
         cg/rxV5bha2T1F/YkPZu/tZLzri2FP+6JCl7ywPcwqsiCyDNf4b5e3OSkOZP4X8nnBC8
         Kf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741355047; x=1741959847;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKa+tQTLZjzXmIzy+CrH4sUBisOXOqgtBvJQGN22yDs=;
        b=XoK0HXhyWKLkN6AJ3QkXGZ4hrk8zukficZoSuTSNZ2L3hEXIZCrvmcPTtmsD1lV0iX
         UxLZYj8xFDUdTbR6zuTcRaetF3yf+xcjwAODX1CrQHHO1vP1n7lctQEYqQe4AOHeGacX
         G9h8enNP4omS4bsJPPlCjkTvmdOj/sN4A2suF3o6xroYEb4V+nFZGG8S7rCBxiNQ5rSS
         ai7eMa/eRDEGQJ+88W6fzUt9PU4qntf8XP+7cvWXxdTIYEMxP0nO72R0gJEgxfdIxVSD
         6yfoP44MsuLPtf2JpnShNmUArjX/aPemMchdNzhaaoVhyBvyiIETxuJ77rt2eSx0SzW5
         YBWw==
X-Forwarded-Encrypted: i=1; AJvYcCUURPu86If2du2a9Ac9anVZSkEfC8lcqpIK+JXPa4IttDzcGQeNvBUj1EJ5i+Sr6JLiBYcc+5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP5hGhJ1HeVJS6FuJ+XBtlGhjSix/YRQ5io5IRDRi9ax/F4bzL
	YFcrSsvwfmNkfPR272syPtS3y1jmIWXgIK6dYuus334KAgdOtinl+sZQpBCoSH0=
X-Gm-Gg: ASbGnctVT2qeLHe5IlUYNVlkgiua/ef1q6LD6QZf6qa4eRR1r1shENmTFROkWzp9v3q
	sfr/b8VVaich5pAg5EMssexlYu13/IZeB8koFruTnHgwq7yB0oEgsm0HnSr4q9lJoyJx2ejh1l5
	/ovSMTEBPAeJeGcdOiETWuzo70zjZnw6nVt2eSQ7j9JDfWf6SL04Q91l62M6V8xKjQYgNL9sqUq
	oiOKHYRMQNouQ7KathQpiRs/sUf2SUMLCVRW7QEoxNgFupKend0ToziYiqcfkzC1M4vzL5qTtta
	sKS+uCNvCJdDpXxQWNBhqivNexr7UWIog/Fe4tf37xP+Q3ZHeA==
X-Google-Smtp-Source: AGHT+IFsPIR6Knj/ewMaXqXh6YdH08dtxvFyv6VA9rK7sxf3+pKbD8o9J6/llsPPYAyuvcsP8pwyQw==
X-Received: by 2002:a05:600c:1c10:b0:43b:cb96:3cda with SMTP id 5b1f17b1804b1-43c68703f84mr21047775e9.28.1741355047048;
        Fri, 07 Mar 2025 05:44:07 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd41c7cc7sm86543445e9.0.2025.03.07.05.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:44:06 -0800 (PST)
Date: Fri, 7 Mar 2025 16:44:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] ipvs: prevent integer overflow in do_ip_vs_get_ctl()
Message-ID: <6dddcc45-78db-4659-80a2-3a2758f491a6@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The get->num_services variable is an unsigned int which is controlled by
the user.  The struct_size() function ensures that the size calculation
does not overflow an unsigned long, however, we are saving the result to
an int so the calculation can overflow.

Save the result from struct_size() type size_t to fix this integer
overflow bug.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 7d13110ce188..801d65fd8a81 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -3091,12 +3091,12 @@ do_ip_vs_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
 	case IP_VS_SO_GET_SERVICES:
 	{
 		struct ip_vs_get_services *get;
-		int size;
+		size_t size;
 
 		get = (struct ip_vs_get_services *)arg;
 		size = struct_size(get, entrytable, get->num_services);
 		if (*len != size) {
-			pr_err("length: %u != %u\n", *len, size);
+			pr_err("length: %u != %lu\n", *len, size);
 			ret = -EINVAL;
 			goto out;
 		}
@@ -3132,12 +3132,12 @@ do_ip_vs_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
 	case IP_VS_SO_GET_DESTS:
 	{
 		struct ip_vs_get_dests *get;
-		int size;
+		size_t size;
 
 		get = (struct ip_vs_get_dests *)arg;
 		size = struct_size(get, entrytable, get->num_dests);
 		if (*len != size) {
-			pr_err("length: %u != %u\n", *len, size);
+			pr_err("length: %u != %lu\n", *len, size);
 			ret = -EINVAL;
 			goto out;
 		}
-- 
2.47.2


