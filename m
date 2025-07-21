Return-Path: <netdev+bounces-208605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD23BB0C4B5
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5CC1AA5798
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021642D9EF1;
	Mon, 21 Jul 2025 13:02:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D502D9EC6;
	Mon, 21 Jul 2025 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102937; cv=none; b=uG9gV23p0ZNXmhLKCp+5218aGSBgQpPnNVDkFh5FPACBkl1uH6/HEVs4P8ZUoUrj1lkoV8JYoclR9wqUNETavy7q0uR0bUrF4+gq/x3c8tEqwyZkrh0x/b7OizkV2ee8h3H5u//73oG2yXwu12ay+DTrcuJX08vQj3g08zlbLVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102937; c=relaxed/simple;
	bh=ddVQfgG6jubvKWA/Gm9jg4YSEtAfkTXic2WiYLRyy/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ag6rSe37KB/UPmv7gNODBfHRTnrrjuZq+JjAiolBstdJj4/ixl9hXm86jvCkPp+sNdhgT49YFolP645B1IzCidOTnRaw0ZPm1agU8Uneyz2Vg1cDkjqJoX9YxL0v+Y8nCPy6SZNBfFTkxx6/LeT3AI1anNQ5RDO4Aq/Ds2+jBuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso751884866b.0;
        Mon, 21 Jul 2025 06:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102934; x=1753707734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jI6UB5SRdkYNp4YBnhrLXfnFpi9zUC7GGo6Zqqmjnhs=;
        b=QoQ2KMi/heHHExvwgjl3epvV2mU0v9dYwW7Miqg6FlonsNUHjCUv/EEEfQMB4DYvaV
         5Ix9m+Jc76N6UUCChrWvCkIR6PpqJsilnCgytnOgPoAOzYqKoc8hXW71t4pqbpKjpOeP
         3kF1n7F8rL94xpYuJuYUTG+3ancuWeCqXYw0Py40nqtihZsO4+2esOG3g0DWZ7xxzuHF
         S7TmdiW3WnB969+7zVEVANkoMGO1kPAHSLPkCKdzttyEwvCtS1kj0F/1IC9mGmDbNNxH
         8JQitgydstOchAFKFeW/4Ek7whUEmAWUy23XkUuiD1u1kGuxbj+K2SAsH5FxMRwiao85
         bEHw==
X-Forwarded-Encrypted: i=1; AJvYcCVUNFh4MOwwGXo3SnK2XN6CuqUGupbvX/QVPqC/Csz9lJS7V/XV7X/Cg//OgCAsGC2gYWYhwmPlHADWnvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw43keIQGSlG5orl7e5xvhxR02UhpUVZg+ofbyrH7sdyaGHb7Fp
	nZB0NNJy4kL8yxOty2CsXfKEo0eHG8kNXnd2Bf4LhiYy/UhrZAMpqy2EmnadRg==
X-Gm-Gg: ASbGnct1MXbXY/TV+Bv0clJC+GdOxoqRE6Stn6YBg975g8qr9OmQD3SfP0UnoQDZwO4
	2DDY91Y/7xEBF8dH8gHWuOVtEhO7A02o/wI7Sgx6hlyf0aV42DDtqDhg/LrMk+y5wyaMiE6+JgJ
	8SQ/n0+UyI9FoFdO680xQcEAnRsRzmlBEVucf+vvpEVUIbVZDcoBB6OLVGkgreWUSmcE+tjsWFL
	roxh5XXraHxzBqY7N6R62vOeKlsxAFO7uZRJ1/CpsJSDzCx+C16tzK2kqzue13AdY7Nur6K/wSi
	2SBCrQGT4yxV67nB5uxIsR3h+bGBU2gYxmuEgasubC3YKO1HVsM0u3PNtWKMnIx1BKm5EbZO/ZQ
	W0OgzTCLRcOPV
X-Google-Smtp-Source: AGHT+IF0Q/cK7OUcWuJa1iIS3qApwr3++BY5hSSWSGwSVb0NXNlY1SluXDlxWtP1XllATFCcFQxe7g==
X-Received: by 2002:a17:907:6e8b:b0:ae8:476c:3b85 with SMTP id a640c23a62f3a-aec6a49331amr1115894966b.8.1753102933657;
        Mon, 21 Jul 2025 06:02:13 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca5a029sm675031766b.75.2025.07.21.06.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:02:13 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 21 Jul 2025 06:02:03 -0700
Subject: [PATCH net-next v2 3/5] netconsole: add support for strings with
 new line in netpoll_parse_ip_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-netconsole_ref-v2-3-b42f1833565a@debian.org>
References: <20250721-netconsole_ref-v2-0-b42f1833565a@debian.org>
In-Reply-To: <20250721-netconsole_ref-v2-0-b42f1833565a@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=leitao@debian.org;
 h=from:subject:message-id; bh=ddVQfgG6jubvKWA/Gm9jg4YSEtAfkTXic2WiYLRyy/I=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBofjpOQd/a/5MsAilGdZo161sFuWI+5oGOBKAGl
 dGLV3tgLj2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaH46TgAKCRA1o5Of/Hh3
 bYvaD/9WT79Kh+LUxaZR7TuMaI6MLYaZsNem941W61FsHcPGLKdPyVnwZ2YCo5lG20fcwqlLtrK
 7btyGtrfv2wKzOn7cfXQLUJVo9c/vMIqmxUH4SDufNP2Vod3VinHw6BupuvdUqq1ntiznwkvgvU
 6Bnvz+u8oexGzc229RuhpXP+H9stYLj1WTfuYliSfJESqkNNfRFHIbqAzptszgcLVTwVAs5lPyr
 jnoXF9fKDACcW86ErYBHD9WBHuRGxfYCTeCdhkFbMnx3Np0BOn3IzJCc1//rgtNnVjlqWkbljh5
 KQXn4zRT9w3vIztGgUG06ooZXBrYq2K3UIDJrWNMJxBy56Tp8eTs3SrJOZNqcfkDcTaEc7tkJS3
 c/pMc4O1noLDU9JGMLgV5WxJyKlvMK82ic0iNnij3Z8Dl1T3RYAxa/PARwdSkDjFqsIyvpsMIM3
 5akDUEiGCO/u1pg9G0EoYnBg17wCCZwSLCr9ThU4oTU8npG4DXvN34x5sNHdYLxXeAGodF4mCw/
 YwxX5p4DRmR5IUY4HQlRiCHyArxYRoabfxuF4j0dU9EuPlq0oWmvE7zyJx8lHX69t2+zSLn9vDe
 cPHbVJ40DWS8YClJlDOGm1mjXr7ZWmVTIy0hhsLiHciV+conehGloctde/eA3hvZgPlQSXVVSxN
 JoH7R1Mc7OhLL7A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The current IP address parsing logic fails when the input string
contains a trailing newline character. This can occur when IP
addresses are provided through configfs, which contains newlines in
a const buffer.

Teach netpoll_parse_ip_addr() how to ignore newlines at the end of the
IPs. Also, simplify the code by:

 * No need to check for separators. Try to parse ipv4, if it fails try
   ipv6 similarly to ceph_pton()
 * If ipv6 is not supported, don't call in6_pton() at all.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 8d1b93264e0fd..f2c2b8852c603 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -303,20 +303,21 @@ static void netconsole_print_banner(struct netpoll *np)
 static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
 {
 	const char *end;
+	int len;
 
-	if (!strchr(str, ':') &&
-	    in4_pton(str, -1, (void *)addr, -1, &end) > 0) {
-		if (!*end)
-			return 0;
-	}
-	if (in6_pton(str, -1, addr->in6.s6_addr, -1, &end) > 0) {
-#if IS_ENABLED(CONFIG_IPV6)
-		if (!*end)
-			return 1;
-#else
+	len = strlen(str);
+	if (!len)
 		return -1;
+
+	if (str[len - 1] == '\n')
+		len -= 1;
+
+	if (in4_pton(str, len, (void *)addr, -1, &end) > 0)
+		return 0;
+#if IS_ENABLED(CONFIG_IPV6)
+	if (in6_pton(str, len, addr->in6.s6_addr, -1, &end) > 0)
+		return 1;
 #endif
-	}
 	return -1;
 }
 

-- 
2.47.1


