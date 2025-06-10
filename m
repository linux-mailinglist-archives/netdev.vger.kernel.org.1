Return-Path: <netdev+bounces-196236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4916EAD401B
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 19:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C27F1897347
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976F7243946;
	Tue, 10 Jun 2025 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWJLJnbz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00204244661
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575487; cv=none; b=AMz4GKlA25eKrb0XI+VZIuJRNXgCR21o3eTMJO5rpqTSIK9Xtx6UsCqkUjDfnOjUiIoA9aPhtN/9HBRN3JWbokERg7aglcVQfRlsig9SWQYEMOSpwshszpZ4mnF7RJLpUwoPNJyrIYyVfSVBk++O+GC/9e1xR/PtEFKivGMheg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575487; c=relaxed/simple;
	bh=DTVoRO+8SjeTZ7TYNPJWbc84jr+8xVtoY4inX4zcTMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txuN7/SvHGI/f7XJZeD6KUUpDJQCUYIqeAB8yKrl+14RoLbMjHuQm4es1IPREb8Ob9jtFa/Z/K2gc85RsYGIo89T4zVJcuGteaxtAFLBeNIkmlc4In3z1yiKy4pH3p9FCBA+7W/n5FfkaD4Mi6u8ZgkNcsAA9xZnhcwoOf1mnx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWJLJnbz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so4320341f8f.2
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749575484; x=1750180284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jGG2/+z+aGE5XZ+w/ZDZar7LUCtROV7irbVaL8D9ow=;
        b=RWJLJnbzkpAdoVEbQUYB+phbsB7bFwLuzfXswj3rlazWIbH3yYEHLlTZd02pFriWih
         eurR3MKM66wdDN18luWBzYOAcxwqSKH6E2OY2JeDxq0mqLooO4+cjBsfdOAYyu8NcYlU
         CoE78KEsvTEUc46juGw0xmbWiGL36s0fbqOESfBlHzw0m8/LChlHgnDtGBDbb9WqUt9M
         R7o6hwZESMqzcQPitBy7M7nz97Gc8rrIkAT7RfuTWPC4uh/URySqO/uN6at1hKEneqjb
         UEc5jIpT9ai9KlTPQKRpU2cKIuoJ0GQGxqb6c8QG504ESO3cHEnxKrDCmXgGbxeOxhqc
         NRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749575484; x=1750180284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jGG2/+z+aGE5XZ+w/ZDZar7LUCtROV7irbVaL8D9ow=;
        b=BWGelceWnpKUZZ5AZlE7XEvAlLI/nXhQ+T5LlE1PtuNg014akHez6GPKhb5A2oj/Nn
         XCJUGPZP5VGNpbh5PZ4eHvqK/aF6B6ulInkPEDo80AihpXVwSpMNVrvmf5x18wljJR0w
         XbLrxYJw3A91sTFWdxie8tH6srH9wdqO5cJUamtDs3kH2rzyYObNTKL0Syk42fLOR2WK
         3WpErZOE/FJLHIFNZx4+z72z0hwgaqS9awLWZaDGlACxhryHMgkj3Zzga35X+aqp7VvA
         D6YjJzjTUumKT36z5ArBOvcH7MyLDeiMMEasJyFb3wWNN2u6EhDYtLU+g4DG5o2gkIU5
         H8FA==
X-Gm-Message-State: AOJu0YyQT/y93IVogcRZhCBMpOluCref63hWBtJEHunO9DHt//WTXMQU
	iu/2hVWN1WM5SEdBjjA7aC8ru+Ey0l1kuRc5QIRuxxyQTtajDUyytpbvQ2pVwJ1j
X-Gm-Gg: ASbGnctV0pt8utA1dYNTnn7PNKnds/QUgs4iuksgFwBcGteyqIKFBi2viGGG/uJGxUB
	/UGs952D+4NqzfMWEzX4DNlqH/f/S6WDN3v7Pkwf2DuOXx4h7XNTjiBB28Sr3FRmk1K/rn08DK+
	uONjtb20AXYUD9q4Mk25W8u01f64AJkNF9xRkLDDn1WMat2ij7wEVMYyMkT0hO8EG1buYajFyQx
	W4OlHIGhgfIDyXX1e1Izh5QOqOcgZWrd10qRuAJJFwZ5g9uxcPYc/7qZbow2yawYr5Emq00FgpS
	ICmDLlAIZm3ySHakZZhjGGR7sUFqndoCn5F58Te463O269znR8ytq1oWzqIWvHdUivdKbw4=
X-Google-Smtp-Source: AGHT+IGFsXYYWT4SOhzJMHIabwj1c37v5ioEju4P6YGo8Eq9IRjWmQHCv+tjekGAp+n44Jb9+gmGvA==
X-Received: by 2002:a05:6000:2dc5:b0:3a5:2f23:376f with SMTP id ffacd0b85a97d-3a5318823d2mr13739606f8f.13.1749575483836;
        Tue, 10 Jun 2025 10:11:23 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:5c::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53229e0dcsm13157488f8f.15.2025.06.10.10.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:11:23 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mohsin.bashr@gmail.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	sanman.p211993@gmail.com,
	jacob.e.keller@intel.com,
	lee@trager.us,
	suhui@nfschina.com
Subject: [PATCH net-next 1/2] eth: Update rmon hist range
Date: Tue, 10 Jun 2025 10:11:08 -0700
Message-ID: <20250610171109.1481229-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250610171109.1481229-1-mohsin.bashr@gmail.com>
References: <20250610171109.1481229-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fbnic driver reports up-to 11 ranges resulting in the drop of the
last range. This patch increment the value of ETHTOOL_RMON_HIST_MAX to
address this limitation.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 include/linux/ethtool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 5e0dd333ad1f..90da1aee6e56 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -536,7 +536,7 @@ struct ethtool_rmon_hist_range {
 	u16 high;
 };
 
-#define ETHTOOL_RMON_HIST_MAX	10
+#define ETHTOOL_RMON_HIST_MAX	11
 
 /**
  * struct ethtool_rmon_stats - selected RMON (RFC 2819) statistics
-- 
2.47.1


