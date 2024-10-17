Return-Path: <netdev+bounces-136548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417ED9A20C4
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B26FEB22CE3
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97D11D958E;
	Thu, 17 Oct 2024 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfRjnLix"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C191CEE90;
	Thu, 17 Oct 2024 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163771; cv=none; b=DVta+IiN45j8IQxLMU5pTn+C1XFylezuBn7VfInjA49LY7soq5vwOE30UgadLzkk0Ja/ViD7ZYZIXTkyVuKjKzEvGYHIXscjtoHDTVtfCKMkA4ivDkkbNBKcwSdVxunI2L2ytsEOQsfZoMxcHYc60jcBYK7Y5rmcjWGBK/6+B3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163771; c=relaxed/simple;
	bh=UYWPzydg2E8UcOHWEc6lOrN1ND+VRK/cDeoluSIgwD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lW5EkM54mv0TBa9mX6WmumQoWie2/+XosEXQKC2RzTRvLRvaSeULhwNcoWRL1sr+Qxa93xaEDI6MfqucIBa/u75STq54T+1GBiqrxogVWvDkZ20w45giC1005h4VtAIOARGpuCuP0QdfJy1/TEclG6VaZO1MB6S2uRxd4bStz2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfRjnLix; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-207115e3056so6262385ad.2;
        Thu, 17 Oct 2024 04:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729163769; x=1729768569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RVUL7dQ6PzateBMGk+EEDOg6w+vM1+RFUuL+tHlvvhk=;
        b=kfRjnLixSrBqfLEe/nDd8fc5mtwg65m4VULrn3L+LrWrEbItOIy/MLb4QvOEXKYaSh
         cKuu0mWYJq+IGpNmhWU/X5OoPAF12vuJU7cPIwn2cSHDK9Iujk9B/vykmu0jyFqTmlt7
         i/WqjO/p4rAirCgg+5AsUGvjXHscPwi6X3e2De6qlHoPy7g29uKNY+FmlqklIu7E8lxm
         hzVaG3TxUaUO3Gzc0eIvcY7ct4fk4tcZg4RLWoz76NWTeZr76D2p5Dspo7CZFQ9lZaww
         s3szgf7NwIrUMXwfWe0uWxQujf2pjLievuh0qjkC1zi1JpnfcyqknvDIhgrtvZApRtwE
         aM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729163769; x=1729768569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVUL7dQ6PzateBMGk+EEDOg6w+vM1+RFUuL+tHlvvhk=;
        b=vKwbPYnk6ql8w2OA4u0wRWLp1O0s8Pjlho8ow+I9OdD7j1i6fFpTSes1WV1MqcBCSX
         KadWmB29Zly3JnStjVRU94dOgZWK8kdlBMZKJ6jh1OPQyyNWuNjMuR9rRs/6+/1E0cjp
         m4+0oVXlC71mrUxO3sEuWTpHcfvYVI+8P7TSivnSZwNHllHiyYjc3l5X3iYciysf5Sbm
         jOeC1t6DeuoZOcPBZWKvYNM6mEfOKKH/ar2nsaNZGa7UBvfYWfLnB3zfr0xPZbsopxrp
         0SnJ9wi6ku1CXe2DTuyVveuWnvnX9OEK94ipEdidv12GPMo81X/EoBpNLUGEjpdqILB0
         VMHg==
X-Forwarded-Encrypted: i=1; AJvYcCVSiYchoma1RjqI+Ep9fck55rTLeSf9gpakhU4e3wAFUqC+QmbnkQ5e2TbvkTH/jb1VOsYVb6y1V+dydfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEJss36BKWAHmYzh3aCPjOx2IRm/hJgnH5yVXXwyIbAl4jYq9q
	hbP9RChOQ7XLpZEa7F0+1yma3xQHcg3omB3TnqgHBrYwWTmo0lRZc2oFDTqVI7o=
X-Google-Smtp-Source: AGHT+IGEktGisaDPut7+7iNdWQ/ySD2tN6A4+16NGoS6XkRcEsxLZ3yZBsALiI0Z3fNmrXfFKJBSEQ==
X-Received: by 2002:a17:902:dacc:b0:20b:c1e4:2d6c with SMTP id d9443c01a7336-20d27f30a2cmr81371595ad.57.1729163769288;
        Thu, 17 Oct 2024 04:16:09 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d180614e6sm42111555ad.289.2024.10.17.04.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 04:16:09 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kevin Hao <haokexin@gmail.com>,
	Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Antoine Tenart <atenart@kernel.org>
Subject: [PATCH net-next] MAINTAINERS: add samples/pktgen to NETWORKING [GENERAL]
Date: Thu, 17 Oct 2024 11:16:01 +0000
Message-ID: <20241017111601.9292-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

samples/pktgen is missing in the MAINTAINERS file.

Suggested-by: Antoine Tenart <atenart@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44d599651690..3b11a2aa2861 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16202,6 +16202,7 @@ F:	lib/random32.c
 F:	net/
 F:	tools/net/
 F:	tools/testing/selftests/net/
+F:	samples/pktgen/
 X:	Documentation/networking/mac80211-injection.rst
 X:	Documentation/networking/mac80211_hwsim/
 X:	Documentation/networking/regulatory.rst
-- 
2.46.0


