Return-Path: <netdev+bounces-90040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99678AC911
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED111F214EB
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B82F5644B;
	Mon, 22 Apr 2024 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="GveJs/Gf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52E14285
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778776; cv=none; b=SWZh3aZIsprFYe0QrSIPr7Cldep8v3J6OUAO9XCVy4MmRkB56cYkXxfAu6rTD3+PfMlzNyvanshSEwn5Q+nqiPVS10sR1tB4wuwspH8YA7uVw9X9pjE4hsG4TqgqARBteinlpQVVn8/mxciisWRi3vS+AW3CVQD4ohHhsUwPOsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778776; c=relaxed/simple;
	bh=rgy4hIAl8v0hVoEMeUH9ZId/faRW4F2EnFDtWWgVPiw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=efU/YVJB96cG+oMnxbZ4cwZbUufscOzzTqU2GXL8hwSMz2RHOnSh4V8hbeRtcmZtNCHSk3jgOfEVXYNkcXg5wVXCJ7l2il0uk5iI3e7IhIcCz8w9HEeQiY4PQEea+fRzVXO3DeRJH1MYXB/PPSJRvSIPR+DorgdxWmP81BdVbXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=GveJs/Gf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f00f24f761so3434340b3a.3
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 02:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1713778774; x=1714383574; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IDItpqL0UDIlKD5/NBmiAMYCQdIF/bw4O4ygkqJXmjY=;
        b=GveJs/GfBSlYo0M+3FH+bI3IdZ7+ZARzYbtUcqslthouQfiRz3r+PpXA4+CXPN5bso
         UlJh7M2dNCxkM+uVQJw7Udf9g6xiF4iXNJqZmSRyPqIa8kU4hzPd/+mgHTGp1s+0mb7M
         jUyWE9n0GhVuACMuYUcfFBMuFh9M46+rKA1is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713778774; x=1714383574;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IDItpqL0UDIlKD5/NBmiAMYCQdIF/bw4O4ygkqJXmjY=;
        b=E5JQsYJWSTTUYEXOjfqHFIRmDbLQzPJXwk3p/b8R+MXB7yXdVzmGy1DUupGiEzdZj8
         D6/JvXdkMTHheivFnXapXqIA5PM9RRvd4mnbdhd4LRA7mNgIcv8W6ZlM6Nj9ipHEtYP5
         nzg9rUuVQMgK1uRc3MzcTsW1oqrOHGNaoQg0UhYqfVGb9gYgZ20axerp35qhrq26t7wz
         ywNYBnz5MZJxw2o+4pVrR3XRBFxg6teSUafljsJpN6mp/3FOiYdiG0juf5Y4a4M8jCYa
         NWgWYgMLpCuRjwIYHPY7/KUXpEC7DyaQ7287G/YlVhgaeDuFG8DlCkqHUECuMRVXSyHc
         C4TQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9X37iXCG7YlTm6KXMk3fwE1S7fTMEWYqLEDWOO6wApk/AkRqkpA9igWmCSiHdgGoojpv2C9qNc52Uja0FKzTn7vE4GnoO
X-Gm-Message-State: AOJu0YxF2dmMDY3rEeFEF8Pfi/O/nfhGS33ePqm/2MT+RhRA58XPkMwK
	o65cYzHXKv+m0z0D+Dcdx/HgYeffsJic+uhrJ9Pbfaeyd5uMubbbtCi55MTB6G0=
X-Google-Smtp-Source: AGHT+IGqmA4pgTf4XEHQuFXf9Fek3k9UzdSqdUkolwrxtvxbsjeva+yKtotIOB57F6CPjW390MtT+Q==
X-Received: by 2002:a05:6a00:ad3:b0:6ed:6b11:4076 with SMTP id c19-20020a056a000ad300b006ed6b114076mr8878481pfl.12.1713778774168;
        Mon, 22 Apr 2024 02:39:34 -0700 (PDT)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id ka1-20020a056a00938100b006ecfb733248sm7667162pfb.13.2024.04.22.02.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 02:39:33 -0700 (PDT)
Date: Mon, 22 Apr 2024 05:39:30 -0400
From: Hyunwoo Kim <v4bel@theori.io>
To: pablo@netfilter.or, edumazet@google.com, laforge@gnumonks.org
Cc: v4bel@theori.io, imv4bel@gmail.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com,
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org
Subject: [PATCH] net: gtp: Fix Use-After-Free in gtp_dellink
Message-ID: <ZiYwUnZU+50fH0SN@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since call_rcu, which is called in the hlist_for_each_entry_rcu traversal
of gtp_dellink, is not part of the RCU read critical section, it
is possible that the RCU grace period will pass during the traversal and
the key will be free.

To prevent this, it should be changed to hlist_for_each_entry_safe.

Fixes: 94dc550a5062 ("gtp: fix an use-after-free in ipv4_pdp_find()")
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
---
 drivers/net/gtp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index ba4704c2c640..e62d6cbdf9bc 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1098,11 +1098,12 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
 static void gtp_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct gtp_dev *gtp = netdev_priv(dev);
+	struct hlist_node *next;
 	struct pdp_ctx *pctx;
 	int i;
 
 	for (i = 0; i < gtp->hash_size; i++)
-		hlist_for_each_entry_rcu(pctx, &gtp->tid_hash[i], hlist_tid)
+		hlist_for_each_entry_safe(pctx, next, &gtp->tid_hash[i], hlist_tid)
 			pdp_context_delete(pctx);
 
 	list_del_rcu(&gtp->list);
-- 
2.34.1


