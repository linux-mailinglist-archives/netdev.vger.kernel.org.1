Return-Path: <netdev+bounces-234921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D85C0C29D48
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 02:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 614564EE88A
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 01:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E782877F2;
	Mon,  3 Nov 2025 01:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lES07R3Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2828507E
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134672; cv=none; b=HbdYLehEiA7HOGSpMFWoqeOSAJVWSPv4nCEljXt/k8AS3bqePAqBdB7Lrd1p9KIYmx3k7zGKt8a63lGe3TWW31aqU9mMfIeKC2VKY9KviSP2WvRXGt3m2/qaA48zloTZTiwXai1vEYJneKkhQe2+088E+t9wpKM06gphD8QCluo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134672; c=relaxed/simple;
	bh=sfgU5y2QPjvrAXbG+U0LiiWgUg/Fuf6oZn2j1UBM6ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HM9TvfQJ+HDUpPQxWdRNmQFkD1JoUEf4ay6min8ZJDUMD8445yEbJlMP5oHDgRs0ZG650dEOTO6xR4gKE7ftGghQB+MoZyqd3dqTitSrKKG+2AhO3YWpOYKYUbL2mBuJHF2MV334jEdpJ+XrsjCZWbYcP/qMG2DuGBj2rMiQ4W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lES07R3Y; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2947d345949so33443205ad.3
        for <netdev@vger.kernel.org>; Sun, 02 Nov 2025 17:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134670; x=1762739470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0sO15jizAVsKQGPETfERnCJBpOXGRp0v1lRQCXQwiw=;
        b=lES07R3YbE8ojmo+4SEozXLt2VsYvvanu32C1uE5lWszukD4GmT9gbkr4XHUGTTB+q
         oTHYwj0IYh3UglEzdTrMq3L0aKtGZoRhnlhDnJZ+jogu6GZzIUTCdTUNn2Tc9iN0P4vN
         +EskWGSSTJr+HUYkAu7b0HJlmV63schH2kUfn0bO+mJo0dGtc6lZWhd3N5NsqPQcn/XH
         mhTOOGdKiE2BqxCuRcs3t3U3r9jkSGiQGS6evh3/cav4cGfd2ieTK5I+xqMhvm55z7JV
         deM4VuvjWLGzTzR6WLaXul0hOkl804lXBhy+K/tYE3dtosvn6pZJ+NNg2T34i9HKaylm
         tvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134670; x=1762739470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0sO15jizAVsKQGPETfERnCJBpOXGRp0v1lRQCXQwiw=;
        b=rmgXk7tL5egGWX0gWUBtLlk8mTMeadlfCARMlmmJCyPqspt6M17k2AZKKf8nAIO54r
         qtLL60CKvWVOHZH/8lsiqzbgVETyEPMJA4u4mMq6ZAvDErKS/9M37/9+kGBL7DP11lNg
         PskhTL+o82/PsyLHSOnzpPelOOeHXswczZEb0vCXbiw1XtvyiAAs9tX+B5Cd/1EaSY63
         U+nkU6UkSrZux1V0l6D4UA/eBspvgTuZGY66philgf8eRNOTLPzUpKZKDgJF2hCs5QFA
         n4UiKjM2f7Oxp08yu7ix2veEjF6X2Z/3YIttxUEH09EWFcu/Y4WtSavmKAAPHD3s0OCW
         YvJA==
X-Forwarded-Encrypted: i=1; AJvYcCWrQTl8dXtOzFpLb8jc1IFjhLIFWTsMmkYTFylBLggc8G4rlNRCTZjDwYJOJH1B51KcrzNw54M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgwKFqcnDZ5cKpc/eKzFmy7Hd3RxdQnDgBnLgxwZNXY3qEogcK
	aMNaOIJnYDsnAuflLUzRMqBftXslv/poaNG1nupAACMyEYMbZJE/uZeK
X-Gm-Gg: ASbGncv+iewCaBHycDoynxU1INq7DGln/Xs7TBJUe2SskAjmF2jT+ehzYsk38hylFCD
	OEHxM1p7jU1CIsY8HNjqZS15HNlJXOjXwLj3o+x50S3s7zNKti1fUBmHL4iJQ+Sf9HnPrZ0ocwP
	CKpB9DeQyat+lOFNdQtWYaGdOS8YE/UABWJGr60RWcLwgavegGdS9VikVrT5aec7UIiSNdCoAX9
	p6BnVL4ssvMXxS3klTPDhA46kXT+EE4hTXyycoQ0LGElJnCfV92mDiDWp+Q4oh3cdSntoSVhDfG
	6YW3u+co/DofX3kAkXOY0WpyIO6JzpTN9mQB7xa7gvh4nS3fdG+mGHFRNyCrV7ypjSvfzx196Am
	HxtSVpuzZXZ23epW8WxJLpsiW6dwT/rP0h3gfDh83ih7YBIfvAds3sSfCuOvTb6rLKuZx8CKED5
	M1WK6asJClSjXQg0syyud2Pw==
X-Google-Smtp-Source: AGHT+IGnO7VQHFBrQJzosLohIa8HzbwgIqW4t6VCicsh6dui2sLEi2qdtR2544cc3QnT7CIjAJoUOA==
X-Received: by 2002:a17:902:d492:b0:295:b490:94bb with SMTP id d9443c01a7336-295b49094fdmr18206025ad.50.1762134669825;
        Sun, 02 Nov 2025 17:51:09 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b8aa2a7bsm8311062a12.12.2025.11.02.17.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 17:51:05 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 45B99426D9CE; Mon, 03 Nov 2025 08:50:59 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net-next v3 6/9] Documentation: xfrm_sysctl: Trim trailing colon in section heading
Date: Mon,  3 Nov 2025 08:50:27 +0700
Message-ID: <20251103015029.17018-8-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251103015029.17018-2-bagasdotme@gmail.com>
References: <20251103015029.17018-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=908; i=bagasdotme@gmail.com; h=from:subject; bh=sfgU5y2QPjvrAXbG+U0LiiWgUg/Fuf6oZn2j1UBM6ow=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkcnJUHzKNE3jJLCJxdMFPJ4sHmd2mL7svNrNyrf9eyr zapjkG/o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABP5VsbI8E3ba7Huh0sHTE+U 9LpIdE589K2XoXLy342sni8WCen7NjH8L6qftth175q1P6Zbr+gLEWg/3clvWCgurPhy6pyeigX X2AE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

The sole section heading ("/proc/sys/net/core/xfrm_* Variables") has
trailing colon. Trim it.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_sysctl.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/xfrm_sysctl.rst b/Documentation/networking/xfrm_sysctl.rst
index 47b9bbdd017977..7d0c4b17c0bdf1 100644
--- a/Documentation/networking/xfrm_sysctl.rst
+++ b/Documentation/networking/xfrm_sysctl.rst
@@ -4,8 +4,8 @@
 XFRM Syscall
 ============
 
-/proc/sys/net/core/xfrm_* Variables:
-====================================
+/proc/sys/net/core/xfrm_* Variables
+===================================
 
 xfrm_acq_expires - INTEGER
 	default 30 - hard timeout in seconds for acquire requests
-- 
An old man doll... just what I always wanted! - Clara


