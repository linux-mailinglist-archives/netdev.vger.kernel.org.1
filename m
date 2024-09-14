Return-Path: <netdev+bounces-128323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08363978FAC
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 11:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7FA01F21101
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 09:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CC31CE6F6;
	Sat, 14 Sep 2024 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8cWZ7F+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF9343149
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726307819; cv=none; b=JI2fbUpbSYXkJ001iNk7tHsJmzN+BZDQ9GIKhh74Me981ZOwLcJvr9MgAtR8pnBmzSNBFw6DnGtjUeOTBmPAnKpgbInED48xDtaqxL4wasMveKxk8+GjoyZG9bBPS5Xr0rkR768zARCST5VRZzp2rpoLYrbP12Dp7UdggkdRuJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726307819; c=relaxed/simple;
	bh=5/7xNgVMM5znzPlTwRdQPzrcGDt5NrLxOnLVL5Ox/kE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rQS4CazSs+ySWvqKEdhTU/JqDWN4FrRaMKaU/ZpfZAuG5LoB7p65jDUbp27y1mKZGr+ky7RQh95LgUnHufn+CW1pCdvW2tcDTNjo6Oro4FCCKPuLtiTmLbJLQ9ETnm3RxsJUBzgL6JLCqTgr+w7yq6b/0ueSvPPsL1Mb5hFicRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R8cWZ7F+; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c260b19f71so3249350a12.1
        for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 02:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726307816; x=1726912616; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZkttiUwbZSAhIQr2HB1QpBV3Ynk91TOIcc4nZQ4D7J4=;
        b=R8cWZ7F+VkvG5LxQGnbvRBxjNNGZwgSTiNCot7EAtRn3NT/CSfYnsNtRFDVthzLLXN
         yL7OCrKefDQJUmXORQqDJjhS/v4pPiKFNQ6neWpCVfDa1eOPTMilUtPMGJi8EzWyMMpN
         lkm355sn2DXTtYM0eTOcFraoP6Pw0a9597NreMz4Ea1B5qPqkHJzrLCW0Jb14ehbWeOO
         LDG8l2sZtlyWPpqGVw9JhLdjzVug944wE6EywV1Uc4Jjxv/FdaBDt5Yin+Bh1damXJcV
         AZ0cb22/ssFmhWTx018g1ByrGaaFYWcXm2SKRUOC6dwayKqrNVnhlsetb9k8b4PDZJUR
         iU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726307816; x=1726912616;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkttiUwbZSAhIQr2HB1QpBV3Ynk91TOIcc4nZQ4D7J4=;
        b=VJzRzKkuV0CShGOPKp7pih8+afzs3ZoJGAA+keiEHVkMl1lKEZpZ1vK5JRcExORVEv
         5bLpBHOeHIlL5RUQfBxFyUezPGP3a8SXiy9+j5qhm79ECE/fyQfJhIsrsBWyLOnMTcx7
         VXrxXO0h9jn3mkha1tRLZUYK/Sh0IrMP9JvLXp75lgRxsIIz3t/lySwZ8/Sx/2DIBDXE
         tDsOz4/13+hE3eKTP1QuO0Zm0/Qe9FZJvT7YlSKfL7hhwRomKsePzMeZvF9cagvQKpct
         0UF+zk6CdRnYDka+boUdcWv+Lp/wGtP0VknWc6enWdTrva/UZcGTmNkDTVKzQqfsLQTn
         wlzw==
X-Forwarded-Encrypted: i=1; AJvYcCXC5LHBsdy+mgpOVhpTx/ut9JzEmSbBveaRpY0f7DOw0mdS+SwRulCFdph0W11hlfEfiVESwx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQUumLnggOQsQZGijdU8gR4KuitrJbKGYa78MkNKf3Zo7flsSy
	6J7+t4lVBSGn5E6P8leI4G6z2K64iFINqgG3K7otlVjDpbJC+BT4ofY2lNlmlRU=
X-Google-Smtp-Source: AGHT+IHW72oX7a7JyqQYEvWLyhwpREGh2KNn57UUT6JYrRYTabD7lJwM/On03q66LCo0gYCNv4awyg==
X-Received: by 2002:a05:6402:5108:b0:5c3:2440:856f with SMTP id 4fb4d7f45d1cf-5c413e4bd3fmr6660928a12.27.1726307815533;
        Sat, 14 Sep 2024 02:56:55 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bc88d82sm497729a12.81.2024.09.14.02.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 02:56:54 -0700 (PDT)
Date: Sat, 14 Sep 2024 12:56:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] netfilter: nft_socket: Fix a NULL vs IS_ERR() bug in
 nft_socket_cgroup_subtree_level()
Message-ID: <bbc0c4e0-05cc-4f44-8797-2f4b3920a820@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The cgroup_get_from_path() function never returns NULL, it returns error
pointers.  Update the error handling to match.

Fixes: 7f3287db6543 ("netfilter: nft_socket: make cgroupsv2 matching work with namespaces")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/netfilter/nft_socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index ac3c9e9cf0f3..f5da0c1775f2 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -61,8 +61,8 @@ static noinline int nft_socket_cgroup_subtree_level(void)
 	struct cgroup *cgrp = cgroup_get_from_path("/");
 	int level;
 
-	if (!cgrp)
-		return -ENOENT;
+	if (IS_ERR(cgrp))
+		return PTR_ERR(cgrp);
 
 	level = cgrp->level;
 
-- 
2.45.2


