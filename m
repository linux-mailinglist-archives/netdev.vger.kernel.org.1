Return-Path: <netdev+bounces-174289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD4BA5E2B2
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E36D1898D23
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181CE258CC2;
	Wed, 12 Mar 2025 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="troX6rnO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5722580F0
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800081; cv=none; b=qyfoMUQbDFimYTnkPEBegDiPeC4LgQZDofM2XQO73JHHtXFxx8Df+7yqR2KeN7rBh1MLoCr9ZCPxgjFBj/lYWWaeoIuaQOqVX3rHar1y1QPzK+Aq+rHgfqYd3/Ldhlf5ogozpVz28EmHYzUEOLv4UXBn/Zc2pZYPJ/fCwT2YZgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800081; c=relaxed/simple;
	bh=wjnq/u21AuKdRgrNZm75J0lF8ufWmfGo4o4NzXDo8ds=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cI5m7mssFIg59mJaESQvBpGLG8h0TfMNQCyzXGsdXJ30H+Vu7ddFPOdUhIVNqHHfYQbtUYuXHkR2wI/ShOd7Rg3lECPZINdNnHlkqgV59LPIuhanK1hoIjl8dU8eANV032xv5PXXhhgr4hQBl2JX4uKDx6BOQYHoxd7FIzrisfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=troX6rnO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39130ee05b0so78517f8f.3
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 10:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741800077; x=1742404877; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HB9xS8FxfigF4WYPPRbbcyxASGClaI6fGW/tpj8nUVs=;
        b=troX6rnO482hE4d2rEQdQiinHkcPuf3jS4eVdVQqoSyMj84BMwyxpA8uIxZF9E9ic2
         Qk/dvynGMlLj16cBYY70WyHusatcx2/362aLln3GnrnYlvdWRxckWs53pMKIcdYFH435
         l4qJT7p6ytgpdWwlN+CcU8VFUHHl935bxRlbJos2BRmL4jPdqLZylrk0VoSNwCbUiAFo
         03N4zhciH9p+DB9oRUXcSKtsu0t+7iIPWsW7YE+zrg1+JYsczy6JUaUrbsL6FY3ip3q3
         OxY7FtYamqGi8HmskmjwY8lK/Nm+A+Ylrb6d217HixvV3OCYCZjyfJsb93IF7vtN+MiP
         INvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741800077; x=1742404877;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HB9xS8FxfigF4WYPPRbbcyxASGClaI6fGW/tpj8nUVs=;
        b=o/XIwdObiE7kehBrT8jwv5ak3a8sPiaupfEVYBnlLJLQja1s5cfiKPfhVp55z5Mo8Z
         YKIhvNJYNHI7DBBJN3fj/041jycOPkm4N8tjP0O6TVygtLcgqA9DMPwDwZoalDBOAlhi
         5pFwbMXQ77SVU+m6W0ABP4px6jWthBK2ksb7wa8AtCq3SUeAPeKH4P+YTBertOOkhUQd
         z1sH4lwdFHDN3RuIrM0Lp9Vr5GDCtwtemueDJhblDAdbjDN4Y4UIJMb05oN0jvyAtWSB
         adj/zU4Jgpk31GhQTrU1Ob2Yr+f8ARQhLTOLhld4+2y8ppyoeSxLb2c/hYIuUGSyoW4I
         Q4tA==
X-Forwarded-Encrypted: i=1; AJvYcCU3c03e3gXlL5UX1WylAaOU/MenDN0W0fY8BmDVLG5LymS1+Bhc3ilvKhEGqk2HEAsyT19QPtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMSMtxyFqymKawMak0I6bQy+cG94o8iMaSj1SvUyeRzcRHR7TR
	irxLtI1PKIwp3yJnZjmS9HpG053ahrxkp48Ca3EHk0KEs0jh//ibAIKp0ikYRqw=
X-Gm-Gg: ASbGnctBu4EVIJ2ces1G+c+FelCSIfhBZEE9YLSfNWBXiNVL3fYXHD+0/2ix4hecps6
	CGex6Kvh+5LSo+J3rMVYrTWK4eAMXpXIvoEOxh46z9deOcG6wQgvWinnO9bpz1brXg2/iLkuhmG
	nBT3myKzCg5qoO7XlBaHR4ErcA5eF4P3TRimeG0uCNO9fwyT7cEhafLksmRR4wMcWgBX+wWZfeu
	1cm36Q0UyhXCR/PdUFZfKQ3m3fdxpYcAf1+eIOWCcwc/bA/6I1YoiQnH6msMP9jr/FoDjmjp3sK
	1va2GHfJ1wFHqgh9zcljGswyZyp2wA65KFEjgPexUZHs7A4SLg==
X-Google-Smtp-Source: AGHT+IHj/Sj6ykxoYXb50k6xZbXFvzcbHYh/wf0blrf/4M8wSJId+CUZ1HfJtS6QVZFmpy/JDyUI5Q==
X-Received: by 2002:a05:6000:1448:b0:391:487f:280b with SMTP id ffacd0b85a97d-391487f29camr12619009f8f.10.1741800077411;
        Wed, 12 Mar 2025 10:21:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c0e2bb7sm21940643f8f.63.2025.03.12.10.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 10:21:17 -0700 (PDT)
Date: Wed, 12 Mar 2025 20:21:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] xfrm: Remove unnecessary NULL check in
 xfrm_lookup_with_ifid()
Message-ID: <2eebea1e-5258-4bcb-9127-ca4d7c59e0e2@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This NULL check is unnecessary and can be removed.  It confuses
Smatch static analysis tool because it makes Smatch think that
xfrm_lookup_with_ifid() can return a mix of NULL pointers and errors so
it creates a lot of false positives.  Remove it.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
I have wanted to remove this NULL check for a long time.  Someone
said it could be done safely.  But please, please, review this
carefully.

 net/xfrm/xfrm_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6551e588fe52..30970d40a454 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3294,7 +3294,7 @@ struct dst_entry *xfrm_lookup_with_ifid(struct net *net,
 
 ok:
 	xfrm_pols_put(pols, drop_pols);
-	if (dst && dst->xfrm &&
+	if (dst->xfrm &&
 	    (dst->xfrm->props.mode == XFRM_MODE_TUNNEL ||
 	     dst->xfrm->props.mode == XFRM_MODE_IPTFS))
 		dst->flags |= DST_XFRM_TUNNEL;
-- 
2.47.2


