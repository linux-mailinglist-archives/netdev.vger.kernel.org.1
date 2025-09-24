Return-Path: <netdev+bounces-225771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBB0B980CA
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 04:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B787B5D55
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A92C22A1D4;
	Wed, 24 Sep 2025 02:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7Jazw+L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8748F221F00
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 02:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758679608; cv=none; b=uicnL6zxNPAyHNF1HJwzUGNW2dzgfyMm+SvY9wF4eMJGmTghJjTxZK3Rr9RXsWVV8/iedVz0gZfyVXPAA7BqwyR1BpWjF2izs1g6JplaWJYX6E/nF1HPSZpIttWhHaBUm05IE25crPoi4MIhLrvOJAqwoqlCKu8DS12H3OkTIVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758679608; c=relaxed/simple;
	bh=j06FhP+kipsBirdtsi9W5187JT9Z+wgVUcWg7BEI980=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHwSj7+gPNOdxpwN8xkSW91vItIlrFjAUQBWnJv2e+hI3Bwcs++w/ybHq65i08V1P6Qg8dkqiAwVu/Crubwg8/2iKMbj3/3ItxuoaSCo+0jMovRS9H31eRgZkTD2p2I8BNef91ZtwQqox993eT2/yRyxBheFri8l/yD7ZhCh0J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7Jazw+L; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so20196075ad.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 19:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758679606; x=1759284406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciePfvdtL+5lomPQDb47RhbqHcSVWA9My3xn0Ig9A5Q=;
        b=R7Jazw+LXRn1WbtlLQ3N796B3IM10r4Ax4YUW46Y7XMbxPAXFV7f99BfxwbxGqQaQe
         qcNfpKr56urf18dYNl3cIVirTaVyAq7e9Looe/K8WosrYZN4Bx1PqSXSLccabWsouKpQ
         /OWbU2+cob28iHOEGt7B/yDOqDoO/hlzno06n7XieYuMrjbrm0cuMwawnEqzYLQGU7fM
         qT4StRCtVlJbsdAn9BnLn1wZHxjVasgrdn4lQG3EHPlPy+2XINh/7HyE9VFhxK1Pf1+O
         alv/iN0O2lLSRzY9ad+2y+Ga0GM1eXW14p1+Bl8wjxUQZUbVQDIBiJSZeTOBXO4ClQfC
         ynFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758679606; x=1759284406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciePfvdtL+5lomPQDb47RhbqHcSVWA9My3xn0Ig9A5Q=;
        b=d4PPpjkboCwhntI+Z0qGcF3RYIoJq32WztNLGZebLMj4zv7sO4BKe0mQE7nW52Fl0d
         rqeo/FpYl4nba6U9ZixA3+DUTDDwAjCeRc2Zq2w5IMWl23eb7SAOPCl9qZRP52OjggsP
         COup50ab7jt9bPhSeOBH0j/gXD6i4Lojng/6EKCW7J0tlrJbQUahFgUr7JDRvRGtQOjn
         X42Qwb2HK+2w3CxGV0hsJuIqXPtJWg8nB5JNsykL5G9RWxMr4zh70n4rBrlm8BzZfUTd
         6hxbh6PUrAdocVvyEiYAKvJGrZP1eXwNLajExb/Mfq7UJRiZJ/TOd+JglSoop3KLjsgq
         OiNw==
X-Forwarded-Encrypted: i=1; AJvYcCWk2qGJqnXqTfL2w9+KsoTTxXjcfhztAFGgT7ex5wwlwMieX94Fg9VtqK5pwbuz6n72jJuUi+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2eSBUGbc+yqijMzEvcFnNX7HQv+bAB0MYfkVe0vYYG0egUus5
	Cq3KZEkCoeRzlGYwZnk7wjFw7dryihN3afa3qfO5Dd8U6gPxE4QyGVO2
X-Gm-Gg: ASbGncuYxjO2nkqj5t2ur/cRaeNrYvQFbP8c3+RYOBUZloELjaXo7n9s02jQAWyZhU5
	RTVv3RzpuoHjD5Bb3kyW9dq01dkNCvMryvxVCaJf/OIlYYUXzdPD+ds/ho5445mrWwTGZk0DvYy
	NCY7E06wlxVFG2MNvCVDltoms7MvSH28bojna1JbeThBYKpBPEs5TZSBOpwoBDfw5L04JzHMIX2
	w3NZhws4sSyhB7uiNrKdG3ddw5UxDWbFc/PHwwrCfp0frrAhHM7V1t+DHnU1iXXGoY4xSXAiDCd
	Q94l/FiAfyxdxRYZeNI7DX9ZjHnYp4zCGsb1bMLJryBoFOGyorQNpLTUjCUFF5FBi0kcWaBxQFt
	sjvIV+503/al4H0GYo5aFqeUJZ4MggVi7
X-Google-Smtp-Source: AGHT+IGOg6vFWo5UC4mbvo1msbl/MOqcUGSOPdhiIHhmYncFpj5be1F9lexrCoDGvQar9VbrAedjdQ==
X-Received: by 2002:a17:903:1983:b0:24c:da3b:7376 with SMTP id d9443c01a7336-27cc2d8ef77mr57448685ad.26.1758679605713;
        Tue, 23 Sep 2025 19:06:45 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698005309bsm176147885ad.27.2025.09.23.19.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 19:06:41 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 946E441A2ED7; Wed, 24 Sep 2025 09:06:39 +0700 (WIB)
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
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next v2 2/3] net: dns_resolver: Move dns_query() explanation out of code block
Date: Wed, 24 Sep 2025 09:06:24 +0700
Message-ID: <20250924020626.17073-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924020626.17073-1-bagasdotme@gmail.com>
References: <20250924020626.17073-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3856; i=bagasdotme@gmail.com; h=from:subject; bh=j06FhP+kipsBirdtsi9W5187JT9Z+wgVUcWg7BEI980=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmXA9OOXTp/TVZggteMNY/Oa01e/27b9L2FPKx3uK5xf Ji/2Ey2oKOUhUGMi0FWTJFlUiJf0+ldRiIX2tc6wsxhZQIZwsDFKQAT2RDG8E+R1bZB23d92C+5 Y85HdBU2Meew+X9ZW2101S+x31FYOIPhf2D7967Exc7akpP6dJn3Fq2Qyn097cG+jsNFU4O+O6y eyQYA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Documentation for dns_query() is placed in the function's literal code
block snippet instead. Move it out of there.

Fixes: 9dfe1361261b ("docs: networking: convert dns_resolver.txt to ReST")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/dns_resolver.rst | 44 +++++++++++------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/Documentation/networking/dns_resolver.rst b/Documentation/networking/dns_resolver.rst
index 5cec37bedf9950..fbbd2c4635cbd5 100644
--- a/Documentation/networking/dns_resolver.rst
+++ b/Documentation/networking/dns_resolver.rst
@@ -64,44 +64,42 @@ before the more general line given above as the first match is the one taken::
 Usage
 =====
 
-To make use of this facility, one of the following functions that are
-implemented in the module can be called after doing::
+To make use of this facility, first ``dns_resolver.h`` must be included::
 
 	#include <linux/dns_resolver.h>
 
-     ::
+Then queries may be made by calling::
 
 	int dns_query(const char *type, const char *name, size_t namelen,
 		     const char *options, char **_result, time_t *_expiry);
 
-     This is the basic access function.  It looks for a cached DNS query and if
-     it doesn't find it, it upcalls to userspace to make a new DNS query, which
-     may then be cached.  The key description is constructed as a string of the
-     form::
+This is the basic access function.  It looks for a cached DNS query and if
+it doesn't find it, it upcalls to userspace to make a new DNS query, which
+may then be cached.  The key description is constructed as a string of the
+form::
 
 		[<type>:]<name>
 
-     where <type> optionally specifies the particular upcall program to invoke,
-     and thus the type of query to do, and <name> specifies the string to be
-     looked up.  The default query type is a straight hostname to IP address
-     set lookup.
+where <type> optionally specifies the particular upcall program to invoke,
+and thus the type of query, and <name> specifies the string to be looked up.
+The default query type is a straight hostname to IP address set lookup.
 
-     The name parameter is not required to be a NUL-terminated string, and its
-     length should be given by the namelen argument.
+The name parameter is not required to be a NUL-terminated string, and its
+length should be given by the namelen argument.
 
-     The options parameter may be NULL or it may be a set of options
-     appropriate to the query type.
+The options parameter may be NULL or it may be a set of options
+appropriate to the query type.
 
-     The return value is a string appropriate to the query type.  For instance,
-     for the default query type it is just a list of comma-separated IPv4 and
-     IPv6 addresses.  The caller must free the result.
+The return value is a string appropriate to the query type.  For instance,
+for the default query type it is just a list of comma-separated IPv4 and
+IPv6 addresses.  The caller must free the result.
 
-     The length of the result string is returned on success, and a negative
-     error code is returned otherwise.  -EKEYREJECTED will be returned if the
-     DNS lookup failed.
+The length of the result string is returned on success, and a negative
+error code is returned otherwise.  -EKEYREJECTED will be returned if the
+DNS lookup failed.
 
-     If _expiry is non-NULL, the expiry time (TTL) of the result will be
-     returned also.
+If _expiry is non-NULL, the expiry time (TTL) of the result will be
+returned also.
 
 The kernel maintains an internal keyring in which it caches looked up keys.
 This can be cleared by any process that has the CAP_SYS_ADMIN capability by
-- 
An old man doll... just what I always wanted! - Clara


