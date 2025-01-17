Return-Path: <netdev+bounces-159202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4D4A14C3F
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 10:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F2B7A1F30
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 09:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C791FA826;
	Fri, 17 Jan 2025 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uQIicy/X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2239A1F9AAD
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737106581; cv=none; b=tVBaYz+5kmwJRmgqd9UbszKWr2VanDnqO0vLI7JlEDOi2bQAbPWLbShtBEXvLhgu42ZtFF7CsSuYk0c7PrwcV7kjAqXO8hdLDOOxy5iN5hbiOKxu+GJjK72HfE55yNmOYsukut2+SkKFPlNfmCO4tYSKYwRX6c55C56iIg89BNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737106581; c=relaxed/simple;
	bh=H+FhnTGuFT5UOXr7qIHtnGqAh1+qkO7Xh2Yqjl00IFg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VNmRSKtbE3jBSj/Q9Byn7CJgIaT7hlcHL22wyj+/08eVJYcBKHcbRB0y1m/DA1M/Q+uFUULO2oJY5FV8sOFBbnQX7a69TZO0KBeTZ4bXjgvFXyEYenvMW/5NFAQ8KXHcVVyxCkYq4gqPgPY37xEFxEC8G0itvReer5VYp0a/BJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uQIicy/X; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4362f61757fso17809385e9.2
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 01:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737106577; x=1737711377; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dirbEAQ7TpkYOTZ9TBmIZ+8lIOorFd5YMgxh1YmdvBI=;
        b=uQIicy/XGx1/GD+z8/EdsiMlrsn4Ta/gkJhjUNkDZM1mBWK45nSVUMz80CvyTrQGvU
         vN4edeyWeCV6BujLJn3q82RqSMDPpNdRVd1wUsKJkI9ADcm59S8IuKmjDtZXLDKN9rAI
         vaxbR0ivrgasOfR88GHZnMZxrib/GNZ4kU8Gdiz7xmzud00RbLYVIyD7UuTvKiVBC4/W
         KMPmTQl+BeIG50c1cFdjDmcpo6eNTcQciF/Q2iVC2SOemyLAzQCxE82DP2tiPYYmCvPs
         xGYfosblCD0TS28CpLAEWH3Bkx9ZNU4vK3pUU8Z4uTaxEXF2o+84PidW4Oh3HQ0+IIkp
         V+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737106577; x=1737711377;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dirbEAQ7TpkYOTZ9TBmIZ+8lIOorFd5YMgxh1YmdvBI=;
        b=TsdXLIcKj4UGinU0bw8xLIyYkcFs/tWK9Kq1yYeeKxeihNxdhWUbTIvCs+sUtANyIi
         KsyhTvUzJpUpgAgvRo0qqTTP3Uc4XXC7QW4+LXriOwIChYpleDAm7adIsfASMouQpGfk
         OosaddycaLBGKElTBjCzy3u/r88z3GiZDHbSmAArXBVS/1ciNnxChG7CxsSBiUO7iGFm
         fGPVDZ56q4N7Qo9kBRLtBTySQ7+GlNROOajuBg2+SlYj/HipNnBw0oO0OLfj2uI3dOvH
         37JPxUtextO8NTM5sL2dNzU60jO36fBcJfoyX3CnOWExqD1+nSWT6La1WRQZNAQbERMM
         keWg==
X-Forwarded-Encrypted: i=1; AJvYcCXyFpYVKzgeBBSl08X7bHvrkTk4oTjyrdI6aYnFJ6td+qBtFuv0iRN8wD9ZBW7w8ctLd8uWq7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6dcaL85Ce2hJk4xNcI1x5L5znP+FjGjEuxhdQ8GzEu9MNmNf0
	N2Vh/kDoaZZ/N/Yw/do+zwhavfxMVbKM/j4n6lRxk4ti7gp9fdKkH+DERzcd3Ck=
X-Gm-Gg: ASbGncuIjQIP/n9FX0OIjonOmBzGi5OFa2JcBohtN1jFk3nMAee5hYIPDJO9nLAgk0M
	GNs2K34UCJpl5+yHk0ynmwOTWgNpCyluV7qDcDHT3aDHFcJ1sB5PeUST3WgH2UY+1NY5zBvE5Tt
	WQbLXC3XKlyrYoj7KOYJJFaN5SgP1r9Nc09bB2DI6NpgvfCtYm813E2GS29QU/RqoA98hMnTGQg
	s75jkjlICuslO/RwK8Ni2Be2GYBASAVnZTjKrHrgqd3gMnjrlwKbB2fbdNk9Q==
X-Google-Smtp-Source: AGHT+IHBC8ZKB6uvv0nxI6PfIPl0cg315iXRGrXvLFhaitipFvwZL0qXSwpAFvCqWeg/C7bXlU5hmQ==
X-Received: by 2002:a05:600c:a01:b0:436:ed38:5c7f with SMTP id 5b1f17b1804b1-438913db8b0mr17966025e9.12.1737106577494;
        Fri, 17 Jan 2025 01:36:17 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74995f6sm88940665e9.1.2025.01.17.01.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:36:16 -0800 (PST)
Date: Fri, 17 Jan 2025 12:36:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jon Maloy <jmaloy@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] tipc: re-order conditions in tipc_crypto_key_rcv()
Message-ID: <88aa0d3a-ce5d-4ad2-bd16-324ee1aedba6@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

On a 32bit system the "keylen + sizeof(struct tipc_aead_key)" math could
have an integer wrapping issue.  It doesn't matter because the "keylen"
is checked on the next line, but just to make life easier for static
analysis tools, let's re-order these conditions and avoid the integer
overflow.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/tipc/crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 43c3f1c971b8..c524421ec652 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -2293,8 +2293,8 @@ static bool tipc_crypto_key_rcv(struct tipc_crypto *rx, struct tipc_msg *hdr)
 	keylen = ntohl(*((__be32 *)(data + TIPC_AEAD_ALG_NAME)));
 
 	/* Verify the supplied size values */
-	if (unlikely(size != keylen + sizeof(struct tipc_aead_key) ||
-		     keylen > TIPC_AEAD_KEY_SIZE_MAX)) {
+	if (unlikely(keylen > TIPC_AEAD_KEY_SIZE_MAX ||
+		     size != keylen + sizeof(struct tipc_aead_key))) {
 		pr_debug("%s: invalid MSG_CRYPTO key size\n", rx->name);
 		goto exit;
 	}
-- 
2.45.2


