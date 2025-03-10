Return-Path: <netdev+bounces-173436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5BEA58D38
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 08:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F0777A482B
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 07:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569BB221DB2;
	Mon, 10 Mar 2025 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mL2jBZ37"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329B71BBBE5
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592763; cv=none; b=VDf659gIguT3kH61iJ5pb225CpbcXDxO7AMYZAB/h7DwoU+kBSQapyI4y89/fgcYjhBJ5xg3pX8XHnWvLal58nqzRUqQ/iHKAs7hRH8Ne6HjZRcf1yhNN/4xiQs9rEifVvr2A/D+6qaXGCjieCSF8+d7U6oUvAucSsOHaYgQ780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592763; c=relaxed/simple;
	bh=uq+RBhP/h+FMIgzluEf1PCwXpWJaNJhq0COCDp/8quw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OuEl8UIVWSn5P7HlPEkoBZ4cF236IdyrizAA09lWDnLO97NOjzEC30PkVddYJgKYojbXBRmFqO1xEZJMkzdl8Zkeq07tVg113FZtoemRseSm4wbgy5amt3QOgIPsjkADwKnp3cmD00WSriUF221y6c4gxKQGfSGeZa0CVWrMsEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mL2jBZ37; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so3194455e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 00:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741592758; x=1742197558; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C3lkkkSZ9lA1P1K2ofoRJBLyFssjT+8CRdim7VJKkTI=;
        b=mL2jBZ37oD5j/AF2V1poC5kgShmm5YJx3Jk9qB/QJIe6MxRD9MzNzyea8s1WEkF5Ed
         nEqK9//wwUHsXtzB24I5mHUq6VEtIA+1/YulMlH99xE7jfuZqTxubFr627dwfPZ14lcq
         ZyCYvY8srm7X+uD4L+/Y3ZkYCRS2g4yJB3PGN9oZjCF3phoX9PbJuiLTLekB74OApGW/
         CbGPcJZOMS4OHJCoK2aGDxQWJJdg4ljnebRfzWFGOc0eGd8RLIJoFz+GuHzHGCgoE+48
         16aBO6ShtWg4V5l1vj4dubCmKh6FJZIxJmev8aY3sJnFKxBPNrnZD0vjag4LnmbzAbPf
         VHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741592758; x=1742197558;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3lkkkSZ9lA1P1K2ofoRJBLyFssjT+8CRdim7VJKkTI=;
        b=ubj1mDWTOtEipFMDn8xRzEfM+jRJiy+qjVdM6glo1QXIuR4EbaQ9YuP/WxtKcyaAry
         JHycafrjFx3p+qCK4eDZaK/WG1tUU0ZIE27SSx7BxjEWgoogCnYHuaA46S3VNgN07Vi7
         ryk8QPYkzUWNpql5DMYPuP/NO/9FjgY6DqQnVzEPHP7zFjTeCG0EwPiH8tRGHD3eY/SV
         ZS9+ZrmEowIHDSjZnXAhThM5W9O4aqEe0PqKBiyuRofdv2k5yWhs1MO/EwRP/04rjr3p
         MpDgEtYvm4nvIjVeWJ9YywmZ9wyt5GbySMoSUCi/hNNYJT955BbnaIyeSqk3XVQgMf1H
         yAqg==
X-Forwarded-Encrypted: i=1; AJvYcCXe0FDQqdwTz7ZqrcX9pqLrafShF/1I6Qzp+fZNabWgwXo/znBzB/rIHaCdvRmIaRZruxzr1uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwgnW0o2YCHOHRVrmJDuItGLUfkYYAAsH0XmG3POzWHlYwgBsB
	bPqasi5uVBGj4Hpkfe13uABk0xPAiGBjrAZoqPlCWhCVAoYI9uK3CNaE0y34kTA=
X-Gm-Gg: ASbGncshiDMjiD7hCH64qvcx9k3tnjFqUd3WAAsDKTRbVqfD23zxhXLtqzIjlYLrNQs
	BhIn3jZ8xHihIZgKYl2HGdSiOsJ8yltmfoDcCVvEySWG18awutWX7s5Zl3GMYdk+VmeCW9QqxtB
	X6dwXAkFJsbFcrBUgV393U6ewYCkM+G1jVVLFkId0ZumYvwX2clxaWWGXTxbqutcI7a5rkPvwt2
	tlp7/W2/L5j3N+ntDqk6wPZPHQzgjlB//HA9pGDXI9suTiWKAFdIdEMD3Z3btgqj7cNl/YJEhBv
	DDLcyj2Szgpf8n+XRdEhpJRK5CmHFeURLlA1d7v6A14X1sXhLA==
X-Google-Smtp-Source: AGHT+IH9Yu6cknGNfARy5AEaDBTYbcDuPmtRPvAATa0mAJpjpaU3fuTzU/G9tc7si//DtoCJEsSoqw==
X-Received: by 2002:a05:600c:1d1c:b0:43c:efed:732d with SMTP id 5b1f17b1804b1-43cefed7916mr30709585e9.16.1741592758516;
        Mon, 10 Mar 2025 00:45:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43cf7c8249bsm27791115e9.7.2025.03.10.00.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 00:45:57 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:45:53 +0300
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
Subject: [PATCH v2 net] ipvs: prevent integer overflow in do_ip_vs_get_ctl()
Message-ID: <1304e396-7249-4fb3-8337-0c2f88472693@stanley.mountain>
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

Both "len" and "get->num_services" come from the user.  This check is
just a sanity check to help the user and ensure they are using the API
correctly.  An integer overflow here is not a big deal.  This has no
security impact.

Save the result from struct_size() type size_t to fix this integer
overflow bug.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: fix %lu vs %zu in the printk().  It breaks the build on 32bit
    systems.
    Remove the CC stable.

 net/netfilter/ipvs/ip_vs_ctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 7d13110ce188..0633276d96bf 100644
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
+			pr_err("length: %u != %zu\n", *len, size);
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
+			pr_err("length: %u != %zu\n", *len, size);
 			ret = -EINVAL;
 			goto out;
 		}
-- 
2.47.2


