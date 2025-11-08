Return-Path: <netdev+bounces-237009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F05C43217
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 18:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9FC84E1280
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 17:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4E1239E6C;
	Sat,  8 Nov 2025 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="XlZcqYdJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE734D395
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762623351; cv=none; b=rfwPDdPmoSBvjkyyH1xzdeeVGFD21Bj9cxxWhGAfBjM94A+VOKCcNipd4YlYCnbHgAHTd25mwP5+sJCWACZEOyHFmRKitV5b7UMXXaTtxaXrRSfvtrClOpoJurILngXvM0POba1VyQjL7kg5sp2s6BUBIdoQRV7RY9noncqwnjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762623351; c=relaxed/simple;
	bh=AVfRufsBy1zGLG3Ybk9J5YXqHNE2ZgDpQvsbUWeAjRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HirWjpd0QAflMNDnbAQiTXtNRnNElAVTTiL2il6SeSUWPcCj80Zc2lF0YzmxH8IvAwFt/Q4s1/dZLs6dDZilkhQ4kxWBzuwp28Ess5ZDq1cp78BDaDnUCZmBaY0ouDWLe6L28As1Cf0WQRJ6NrQormAifFAhgB26YRs0rR4nfb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=XlZcqYdJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47117f92e32so14311585e9.1
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 09:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762623346; x=1763228146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BLaQ6AXjkW7CDVrWIrRktAfa0T9Ox496TUA4Te5axmY=;
        b=XlZcqYdJocTDhpqRIxWQs9qHPEffJiOvwR+pZmyA0mwZCiEIq5J8wiPKGSZ4xjq0Rd
         j3g5FV3fWHQDbGPMbk4cly3pMumve02d/vo92UY9DwECli1P9siATebw4EjvULHhSbzu
         3XcO1RM9TFWSD1llY6jgzVrfeB/lb8I68HXdgXFat6+BpP8vzdVVaHWuDrTw5FvZrRqJ
         SB1jUR44Jd9KauEyK2tUuNaJ4qwQCVR+ibp7dCa9VtbAZwXqJf2PS4ltNAKHF9Hz+IB9
         uWwzf5Tc37gnfaJSsolGlgg6OcrCyKcCpoYSByA8LmwUQNyrfAP/t96gCqpk3wAYyiJ5
         2r0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762623346; x=1763228146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLaQ6AXjkW7CDVrWIrRktAfa0T9Ox496TUA4Te5axmY=;
        b=LBmXpdw5Znh8o1tC0m5X77m3tLW4wKT1W1pQjJECcJeCYlMgljNJFq8LIRb3anphfz
         Bxq4FLB6JAcpD1Gg4FqQfyWtWTMcjWydohU53i+MsFh20coc7cuv9F7xXBuVycT4mb89
         NoD9NZB+E+Yjw8pR7iL8FiDYO2v0fSDLKS2jypVdwFpMSZpK/GWBZUajOqeqlWkUryvp
         b1GERej7WJ8jlysUuLFmep6QO17vDdbWuPcuVzxROYXTAYBr0/BjQFTsBAjnQRweEheW
         HA6ku0DvY80VsOCZ19ZWAfvYWZsDrSi27vuM5M8zy3OFGToU91NlokeWp7pzACFzpmw6
         qMVg==
X-Gm-Message-State: AOJu0Yx4GHdE8Arlrjf6ZsdhexDZ/i3JAzFqpYWu5rkJWZoh3yzN+gqr
	m8N5nxB9xgkn7c+191rR+O3j1evin7W/CzsPVnOfcIFq0JwNE8TrwpQMZiGLGG6BhAV8bC8xQYN
	prOduqwQ=
X-Gm-Gg: ASbGncskv3oPiga92zHz46y6Y6XrncwcBjWrNyxaS+6EBuqPPLhCilfk41vwSJfNQPH
	VaR34HMeFSP4izf5jdY9YXkA7x2AO/k5y3agm/kqg00wKZyjwGp31/6YTRYR1Duj+X0xNXI/Ngt
	srkBApQkQmSRA/a4LgNqtU7pBmf+W76hTkvabulScSKRSor/fsODt/gIKdpm7RAyiBWy4BBHJqd
	3r+K6h/YyAL4M5ytySuDuxAkxUW908vqrrw0R5Y81U6uIfr5isKUB11RxSdotATkf9LBzRkJF87
	S5dcsCQxwQkUjSqlBeb+TnxBuwKcUx2z43b5T+fNcfLsk37WtbXRGFGYP2uBLsdOt8mCXu9WB4B
	jimHvD5Cd1ElGAH+QjYgNJ9vKDRPEL4Mg4u4MMyU0BQYRTsjKxU+OsvGYl1bZCkMk9da7LnC0dV
	Q7UHuMzlVUZaOhR5RQ4WjS66fBV0kqwBQEgW8oyXE9oSuTHBLLDg==
X-Google-Smtp-Source: AGHT+IHGLEYYDQAZ7uc4ZLEeSHgjt73zWGLxBfUYFj3dzWvQX8ZkpbGSnA72GR03PFGVtAUM0IQtDg==
X-Received: by 2002:a05:600c:a05:b0:477:54cd:202e with SMTP id 5b1f17b1804b1-4777322eeb2mr26791325e9.2.1762623345245;
        Sat, 08 Nov 2025 09:35:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bccd41bsm111163325e9.2.2025.11.08.09.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 09:35:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	ernis@linux.microsoft.com
Subject: [PATCH iproute2] netshaper: remove unused variable
Date: Sat,  8 Nov 2025 09:35:26 -0800
Message-ID: <20251108173540.21503-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang complains that the variable 'n' used for nlmsghdr is passed
uninitiailized. Remove it because it is never used.

Fixes: 6f7779ad4ef6 ("netshaper: Add netshaper command")
Cc: ernis@linux.microsoft.com

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 netshaper/netshaper.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index edd964c1..47fb805e 100644
--- a/netshaper/netshaper.c
+++ b/netshaper/netshaper.c
@@ -98,7 +98,7 @@ static void print_netshaper_attrs(struct nlmsghdr *answer)
 	}
 }
 
-static int do_cmd(int argc, char **argv, struct nlmsghdr *n, int cmd)
+static int do_cmd(int argc, char **argv, int cmd)
 {
 	GENL_REQUEST(req, 1024, genl_family, 0, NET_SHAPER_FAMILY_VERSION, cmd,
 		     NLM_F_REQUEST | NLM_F_ACK);
@@ -220,7 +220,6 @@ static int do_cmd(int argc, char **argv, struct nlmsghdr *n, int cmd)
 
 int main(int argc, char **argv)
 {
-	struct nlmsghdr *n;
 	int color = default_color_opt();
 
 	while (argc > 1) {
@@ -258,11 +257,11 @@ int main(int argc, char **argv)
 		argv++;
 
 		if (strcmp(*argv, "set") == 0)
-			return do_cmd(argc - 1, argv + 1, n, NET_SHAPER_CMD_SET);
+			return do_cmd(argc - 1, argv + 1, NET_SHAPER_CMD_SET);
 		if (strcmp(*argv, "delete") == 0)
-			return do_cmd(argc - 1, argv + 1, n, NET_SHAPER_CMD_DELETE);
+			return do_cmd(argc - 1, argv + 1, NET_SHAPER_CMD_DELETE);
 		if (strcmp(*argv, "show") == 0)
-			return do_cmd(argc - 1, argv + 1, n, NET_SHAPER_CMD_GET);
+			return do_cmd(argc - 1, argv + 1, NET_SHAPER_CMD_GET);
 		if (strcmp(*argv, "help") == 0) {
 			usage();
 			return 0;
-- 
2.51.0


