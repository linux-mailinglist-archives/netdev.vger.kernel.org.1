Return-Path: <netdev+bounces-167050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEBAA38906
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 17:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80BD57A161E
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 16:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5D7224AFB;
	Mon, 17 Feb 2025 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+LwvEJz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6D029408
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809338; cv=none; b=Ow5Op/vTHuWk/wyYodDtEBYP/M9XCzyYNZRDYVFsVnZq3XmDqCosZcIvvBs/8UmbpOR5LcWA8gGp+yF3TaMhdE1UODv5tA+SpXZhzwzTKg7K/zIQO//Ro+b5trmBsz6EI2hamJTG/msGCalgs8r2a3rnf62vE+477FDdyi06uwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809338; c=relaxed/simple;
	bh=4Pbfy4+yqCDX7T7kfRkuFt/gJ+39MYWLzJmzIk9vFA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kw/FWq/+JPreoLzB6VD+MyZZIPJuV/ytv1bsXHmLAZTYPXVRPOPt7BSIb3RnvivQ0KQtzAReOqc3k9uvWjQpuNYIDp3aihDWnerYgG930L20ZKO5rdbQnunfklQnxaMU3oH/o4kH0RmJP/Yg5U+TPy9Y497qL0eCyOLP40/Ufr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+LwvEJz; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3076262bfc6so47989041fa.3
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 08:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739809335; x=1740414135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F4cG9wttqtAzp4zopvxi5x287IcNrzRDBTI8aw3YRow=;
        b=X+LwvEJzhqblZtZkPIcv4j0q6q3cuhsJJoLwZoAlpVSe9A4DY6rkR70Sp508BG8Lm3
         cJAeP6f4DfzXV8ROzHqb+Ewna027f8SyaNV0SfIMIWdxTNxxmdvOMuV8AaiU2UAuVPEg
         xDfmNRLUIdkt9oelusB3xVdXY+ergqwdIa6YAiZMEmEzAEDByq9wnhFFbN7DsYNZVhbi
         //TLvT86kS4mbOBV2qFueJGqJQhwW+wNHsmYAS+9pLTxn8pPyfj10y2fUzcCcE86icy1
         Yk4DtVf0b7E0Pq8Ht6ArNUnE+ZggbUySlkhAOKxYy+pHW8+Q9XaB7y+y8NZwyVnbp/st
         6hEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739809335; x=1740414135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4cG9wttqtAzp4zopvxi5x287IcNrzRDBTI8aw3YRow=;
        b=qjKA7fx1oJf41usruyv4BQt2/SoFUhBF4YcNiCfzgEYwSXK7zdBSn0/CWvEHbofRPJ
         iZqJRjNuWGFUYWgs5iex4bf/w/ku/eWSeNO5k3f85qPKlPHUYghr92sFv6o2OK0QGB9f
         jDI/0HWB6Did5ssWzGtDM0OKsOPl4DhNpGCpqOHKlJJGM1kB6H5r9AnGggCosP1Dulcu
         U5rTqF5WucshPyXmr3cMZlxFGE3sl4NUXEgMv1+49vx5e6IXBmVdNrYc3fipJk71jD8s
         L8H9KQGNvZoA3x92BgZpLtsyj8TjLcawwcJlfhmtQiJfRsLlUq0CRzTYlmHwOwYVmqmd
         Jjxw==
X-Gm-Message-State: AOJu0YyEh9uN7aOrkV18urKNRhbDWcWcL5vToft1dW1NtsuG7EsC5OsU
	Gaez/gszC5OXO4334TJRBLFHIUT9bsmiI63536MmM6RWL35EMSGmZ7yVhiBdPZ0Abg==
X-Gm-Gg: ASbGncsEcVzMQwF/Gj8p2LpmVQLV/aHe+ePBqEldfTfw+ZxcWcjGMlREfHT6UlO6Hjy
	xipijLMQoq7uKuBM0m2PPBEzsWoWFv777GEFlRb6mofKPjwGvBXhOewcEu/fBS3I57hTX0ADzs4
	r4QG0JCi9v5gJVCkV7RL4welM4Ol7C3wImvz4C9T4DF/Dt/WrRWgzkLGJ8yKZcLJP0nHIOserPm
	meL1PdxGi+wjxicNQjxWiwWygx7wLVL6uqobU8FP5VaILca+0hsB5RpRN50tSZeyQ39WdtIt74e
	pTPt0y0Xypv/XBHq526D+YaMeF2fGxzzXHgHHYoOCp9BX+/6txj9kqRIRJCMKC0P+J6SxVhk
X-Google-Smtp-Source: AGHT+IGVQilcEDvojw/5+3A0SqWnguWqxJ9kxGxFnAqPyVnvt2EgtbeCMrnXV81xIsGzCF7VNPwyzA==
X-Received: by 2002:a05:6512:2214:b0:545:2474:2c98 with SMTP id 2adb3069b0e04-5452fe5be3emr3008894e87.23.1739809334324;
        Mon, 17 Feb 2025 08:22:14 -0800 (PST)
Received: from astra-student.rasu.local (109-252-121-101.nat.spd-mgts.ru. [109.252.121.101])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2794fcf2sm6817331fa.51.2025.02.17.08.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:22:13 -0800 (PST)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: netdev@vger.kernel.org
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH iproute2-next] ip: check return value of iproute_flush_cache() in irpoute.c
Date: Mon, 17 Feb 2025 19:21:50 +0300
Message-Id: <20250217162153.838113-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static analyzer reported:
Return value of function 'iproute_flush_cache', called at iproute.c:1732, 
is not checked. The return value is obtained from function 'open64' and possibly contains an error code.

Corrections explained:
The function iproute_flush_cache() may return an error code, which was
previously ignored. This could lead to unexpected behavior if the cache
flush fails. Added error handling to ensure the function fails gracefully
when iproute_flush_cache() returns an error.

Triggers found by static analyzer Svace.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 ip/iproute.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ip/iproute.c b/ip/iproute.c
index e1fe26ce..64e7d77e 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -1729,7 +1729,10 @@ static int iproute_flush(int family, rtnl_filter_t filter_fn)
 
 	if (filter.cloned) {
 		if (family != AF_INET6) {
-			iproute_flush_cache();
+			ret = iproute_flush_cache();
+			if(ret < 0)
+				return ret;
+				
 			if (show_stats)
 				printf("*** IPv4 routing cache is flushed.\n");
 		}
-- 
2.30.2


