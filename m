Return-Path: <netdev+bounces-209430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6565B0F8ED
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18CD75686B5
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CAF2264A1;
	Wed, 23 Jul 2025 17:21:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEC42222CA;
	Wed, 23 Jul 2025 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291264; cv=none; b=UDQVZ1SY1yKKikb4tKSuOzzCTs3x2vu12+XsiO/Y7vCob3Mf3jAKZR3GVR3LHJRYmrzHP7n/0eQwAG3AECtDcsyV503WVlwAhFCNRDWmSS0gKCTgcEHyPUmVqZD0t3D2JvwRXTpp6EK3MRdszOeO2ASh3B8IE2QLwftgziyuJx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291264; c=relaxed/simple;
	bh=vndjOcu4adrFYip9Xim5uGcPC95/UkUzZbOGN6kmh7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QWACQrKhzWqyGyXA/IXkY4RqjjaghvFAOsEX9ePPgLFwB+247oXJjKb+vDKN1mqqI5onWCGcBlBYkdWkEZkKPJnAiwhMlCagubjF5Y8GCnPCAfNTZukYKkZeeFcs4olaU95haQaKycrTZplW46gb+Y8mCnjMPEp7TgibuS7OiHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae6f8d3bcd4so13104066b.1;
        Wed, 23 Jul 2025 10:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753291261; x=1753896061;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdQWbHQRGyM4Yw1ur1LVGk/Ciq9lP8JnJJ4DCCYMcWM=;
        b=RFSm8KNIlI5D8hrQ7s/mmKEDJ7sps930ZSAnd9osWNNdrWjsAvdorqZulzeCZt/iET
         ybe072uWolYwILDA5SH7NeGNV8sz5FBbM3h8f4r8Y5A3pwyNK3Yp5Ad4JGcuVUtSRhEF
         81QDVwXXWZew9GL3GUa2uoqzNm5Fwr+93PUTT7jrhaij+5/c7CMw/LdI32nxrSpOyQRV
         lgAB+L1OZFpM7NvC8eWvQnahYw5oxVMXWc0BxbIoSeuFel6RUaaLj72/7SSQ5zy2uWEN
         gTUzf0SxK6F6+vwbSJID1WJHTTXDI4BEtY67BaTS4EvphXE9jQ2L2HEvZvMp3/Ryb/cK
         O3GA==
X-Forwarded-Encrypted: i=1; AJvYcCX5gu/UPooXugw6DdHbAuif8zYPOjA2HVmMJbclFp5AK/PH4Uej8JVeHQZ6LgLjaxPBNRqCj+4saQE0+MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLAMs2xSXfYPVx9inmuCc2dPxUgoTfKI0Vxd2V2MxNsNZeiMcs
	p4k9ppjrffUGYKcBd/1H6tCd5HwfR+3nce9vES8NNVrEy1lC25l3HQo5
X-Gm-Gg: ASbGncsKQRAKqY+YycYhyQIJHyEoXXDhBi5LfibK5eDRunl5arRSYD7heObXG8MVVpG
	Re2RshoB/TEJtkXGMIhEXR41rmLyuqA+K+EK0wWNQVfb9aWDqpdlm1n78QW0VKlJi8RNWzDWYsz
	U9AN1B64AqcYUI+loW/YM1+c2tGu3xAjab1ncsboULFYjfP2OGFo9QM3+SzuYv8WQG8aJSA4JWl
	5VGGJQOsJS8jPjbyfQZrLImYm7nPz/yctBIV7EuXGW6TE5rTn/+EzRWXCQYMedYP/orsKwyVqix
	8c8zGUmQrS8hwD4YPp9RdMpQfndSQ3kx0CgyDJF8SuYecyCrWu81C7zP4cgBqKfZ3Qm8FRQVzGC
	pQg8MDIu95sNL
X-Google-Smtp-Source: AGHT+IHK0kDY6xp1rYbRbEGibfSqaAzPKJiupbMocm8yHu99g0PO1zFPtJbzt5ooB9tF03lhPZYIyA==
X-Received: by 2002:a17:907:60cc:b0:ae0:b3cd:b7f8 with SMTP id a640c23a62f3a-af2f8c54db0mr401571266b.40.1753291260916;
        Wed, 23 Jul 2025 10:21:00 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79d6c6sm1082545966b.32.2025.07.23.10.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:21:00 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 23 Jul 2025 10:20:31 -0700
Subject: [PATCH net-next v3 3/5] netconsole: add support for strings with
 new line in netpoll_parse_ip_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-netconsole_ref-v3-3-8be9b24e4a99@debian.org>
References: <20250723-netconsole_ref-v3-0-8be9b24e4a99@debian.org>
In-Reply-To: <20250723-netconsole_ref-v3-0-8be9b24e4a99@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=leitao@debian.org;
 h=from:subject:message-id; bh=vndjOcu4adrFYip9Xim5uGcPC95/UkUzZbOGN6kmh7o=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBogRn3vbT6Id/9UPC5YdZ9Y8MYCnkTyWevYQWHr
 c/Cl7Lyg6CJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaIEZ9wAKCRA1o5Of/Hh3
 bWfOD/9F//4EapQpC4tbnTZhMi5ClQRfY53DiTkkDrFBDE5+lxmpfDBlthsCsvGJVqPXwo0wPbJ
 HCKKTTeVBgRiUC5rfPMsXLfDG7frs2DMrvQI7iR9AAnNNMougUXBQUmFffNP0ohq2e/NRRFl6Mm
 IDZJOfQ248RVAAvflgCiCa+3yk7TLiokdLWjYo0Dyi8S7M4Xq4hVoX6jfyug3OqOyVLeQE6mn29
 f6lX+yGPgM5iMruHwDQYhjCsUuvtD/trxUO5E7oZB0ZDdYMfPQ8z/YCAOFJcy8VaxpWBIam/v39
 xAuG/LFC87oRzHNFOkcFidhdWzoGm5MTMkpHvOIBs4+5b6Ctt0LdCRWLXvSVV/W+Iba5lbg/QgS
 M6mmRBpxwGjANXEBpMNi98KkdTSYh7dy99lDqwPBKrfyGciUW0VOow7fV/AWsV7otYsvRHhw+EY
 28NRMenGZqzLakq35oW4dFIs+MXSCVzlmWZkdmJy9DF6BWU9E3Qra1oHHbaOOaR7wsWYn8+LyHu
 FKNv6sepqXr45Hm+PwHmbsDkbnZkS0ZHpl5SbWYlXSRkMfZonnNfzH9RJtOibes/T9WyXITAFCe
 pvC/8XK9LsXPtUitrz0iGKZwMnd8cbtmPKTEUzniX9ZuJYfV9x+KdUj+rwYj+sBFXU+hpxL0igO
 LDN4ECLVqN4WQcQ==
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 8d1b93264e0fd..3188cc180a934 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -303,20 +303,20 @@ static void netconsole_print_banner(struct netpoll *np)
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
-#endif
-	}
+
+	if (str[len - 1] == '\n')
+		len -= 1;
+
+	if (in4_pton(str, len, (void *)addr, -1, &end) > 0)
+		return 0;
+	if (IS_ENABLED(CONFIG_IPV6) &&
+	    in6_pton(str, len, addr->in6.s6_addr, -1, &end) > 0)
+		return 1;
 	return -1;
 }
 

-- 
2.47.1


