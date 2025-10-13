Return-Path: <netdev+bounces-228951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD6BBD6568
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 23:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5664A3A6A6F
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 21:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147382EACF9;
	Mon, 13 Oct 2025 21:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/+G99qZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896AC2DF144
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760390097; cv=none; b=jBwQJmHV9JCZ3lj2SFUPAR2b0/vu1TmzcBSmo2KgOdFgavexOiZWWl6cAB7PyFk+5CVH6sjEE2l9e/ylZpWO41CRI6uWg6FnOsLt0eJHUBfeHjwESgKSTx2vRkLqdi/I0vcpOB2ofImXdTxLKCVZCj5Uiyfmk1kjfh9yomryru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760390097; c=relaxed/simple;
	bh=I1AlkCMSPcd6QsGLGMY4OhQv5y3GApXtoxL4rrFTY1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPwk1grJU6GIcwIV3zkfv7JPvzlkuhIjAI4uACx82EtYvPPcYH1QUgMzLhV2RFGhyMVggSdrxiRywl04a6CDCqJbeOxL53RwWmHRSW7NnxZZ1lXMsJgT+LkkoMGi+cglcnnmcQbYqd8EHxD2AeeNnC4Xh7qgKP67RF2ivvP15HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/+G99qZ; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7b7325d8fb5so3167014a34.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760390094; x=1760994894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EET3On04/X440jLtrVWK9FlWFxWzeiWWQFMJiADkVQ=;
        b=f/+G99qZMEvuD39s+Ou3v5Iaz/liPAZ4OC4HpzuXupev8nnXltGSeIRHEezJJhPKXV
         TOSJUSiqz/k3LZB/NiALXvtY4Ep6CmtVKk9HugKy4OKKMUhv8kzn0ce3NYAQLU3VpZpI
         Q7fwi6Zi1nYO+F+2W7FGyiSJoVw+zL96Tp1GMz8NW7E5xO6D4hYtYPE/VUSWcqZx7Mrg
         AWW/JHhATEahUGfojp2YolN8UPY5BoxeKQr3bOi3xKRjQtR1SuVdDNKtDwwlEyEyc4hl
         VY38phYym8zSy4/QchVDw7Md3SLh0cN2jF3ZIU5ySTY7LQyOlCFkKFilEAJOuszziyKY
         w9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760390094; x=1760994894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EET3On04/X440jLtrVWK9FlWFxWzeiWWQFMJiADkVQ=;
        b=ARBcUrsS/w+AwF/aNoTGzJstD1oBI915OhqXIPB5sYM6gWuD0N4zGqcqF+0daj0Jgt
         dRcOydDmzzcDIuv2/jNIkmUc6IwjVmRiZRmKjzBlTRv01VULcQjsU8al45RRGCDfHpY6
         YAAfrJNicLxVrlIPeW3xhrShdPN39PDW+lwTlJm8th4TuN4H1M+Fps+/5u0W9OhJ1qSo
         AtQJ94YsDNWSQUE4mrQ2+AsXqPRsxJ6hvv4DiCb7jirgOqD2DiAV/uwjOIXBHvSQs+6y
         UBuZ8j23k83i4HaWxiKcTjLwN8BwZhZqhqc//vQWd/RRWFLAMf2Rla9ktjhsyGe2QCr4
         EPZw==
X-Forwarded-Encrypted: i=1; AJvYcCXIfzruXpCY4ryY8B5bTmZaOC9qqvu583CpEahMyO9G3UBEjjGDAAHNHWPnOFoBKDqvgODOlgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6kVB1P2r0Hk9xFaC90oL9uT/s5F1a7eAvQDWKHfG+HKUutn5j
	X7omV7H15p6uTmItz1mHbeRPBR54Fhk3/dd4AdCTOjbqSYTJ9Y0vWtBn
X-Gm-Gg: ASbGncspWMwzy4Sc4cVsgPNIAGEMnqHywnL98B3pQHaGT2FIm+JcW5RgxbeuDmzRj0T
	V/z0WJqQOcrAAwGdP2XgsGcU3bfStoAWFB7gWSbTuhLmTtGq2etkKHz2orJUs11ZxU1jRbYtk6K
	t8lKiO9OliALw22A6cU1tllpPNUMQKMIdmgAk6NkQojlHOKdmfXEIZjxSQ7lWNIj7j3xoYlKEPG
	j8cEXrggyz9wBexARU5dlsGwHMZnSexOmXbcQ+lTeHXdENEdkntmC/CsIGCcL4Db3nxwu4e3PHi
	u+CcMU7wknV5uauxA9XiIYx6VpOVVnvzIWDDN//mLUnLzEHgKfLWRMhQpu9XI9k2SwfhAkHNPaB
	cosNFkvQCmntiTGPOzBinHXMIvbuworaq3JwE8s/BIrybn9l/s/IelqYvN1E=
X-Google-Smtp-Source: AGHT+IGlV9QreRk7sl+y9midcquqXDhVtVvLUtKMfpYsZPkxOe1iAVWvBSXmw4UlNTr2SUToUZi/TQ==
X-Received: by 2002:a05:6830:601a:b0:7b4:1768:ff31 with SMTP id 46e09a7af769-7c0df7a739fmr12217234a34.25.1760390094642;
        Mon, 13 Oct 2025 14:14:54 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:72::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f911a389sm3833082a34.25.2025.10.13.14.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:14:53 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/2] net: fbnic: Allow builds for all 64 bit architectures
Date: Mon, 13 Oct 2025 14:14:49 -0700
Message-ID: <20251013211449.1377054-3-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251013211449.1377054-1-dimitri.daskalakis1@gmail.com>
References: <20251013211449.1377054-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This enables aarch64 testing, but there's no reason we cannot support other
architectures.

Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
index 3ba527514f1e..dff51f23d295 100644
--- a/drivers/net/ethernet/meta/Kconfig
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -19,7 +19,7 @@ if NET_VENDOR_META
 
 config FBNIC
 	tristate "Meta Platforms Host Network Interface"
-	depends on X86_64 || COMPILE_TEST
+	depends on 64BIT || COMPILE_TEST
 	depends on !S390
 	depends on MAX_SKB_FRAGS < 22
 	depends on PCI_MSI
-- 
2.47.3


