Return-Path: <netdev+bounces-99170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3098D3EA7
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 20:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3FC51C224A3
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C031C2300;
	Wed, 29 May 2024 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIuu8zE4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698E71B949;
	Wed, 29 May 2024 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717009017; cv=none; b=nAg4OA0rRO2zO63yrt8pPkVGI9ypW0QCu/HpRUFKbGn/XuZes+9Gv0+qln/6dDKYyumvx1QxoEqOnAfFit+yai4KzPtAm71RdzTBiGKSmoWYfr/LO3Diyi+dJjG06jsiJu+eOs1yYGgawgtSyVL/jLnIMkHHiWQZSaa2FF8LbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717009017; c=relaxed/simple;
	bh=PIYentr3AYVYWFEq+kWi7qT0a2j16KL2+aWErt0ZUQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SG8r8/c6UQ8E71++iYbFaPzOB3IuWdTozX6cRTnWtwk1Cn/NJNFefwHmzUJVI1gBIG0ynoxC5HH8qCaztPPwDtzReuzT5oxJqmqaiUkHicJUhFUc9nDZ/xcS21AEDLJyBCDuoK3YpFQJzTvclvaMEUTDPYRPowAOtdnybjnDfOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIuu8zE4; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7948b7e4e5dso8868485a.1;
        Wed, 29 May 2024 11:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717009015; x=1717613815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7uhrzRqGxcnEpl8c7lrMtI5+aKBA2FG4lV27CS2WdU=;
        b=cIuu8zE46lqskDjmKOK/jkjkWVHU/ZEAeKS6JhE7jGM0x+6pRYW+Zap5Fo2cPsL22z
         WJV6zvbY9SBilTgTU/ov/lE88FEHPApU5cWcoTuKXJ111hO40S+nSL7Aqg7becLKXkuU
         0Uyfu7jXNXpWpe/fSbcUe+3ffgsauLWcUKRU8yP2wsC9d1ZHRVvec0c1H/SrZWobXk4F
         cqpwo+bpoy6fsFQ++G4779loKr2z/gHJBqR1FDHlxvvchsVY/gmPs7EEp8Rl5rboatW3
         1MJxE6CoEMYTd5ge4aLRICmqAiw+mg0pBeZ6pnmos3BhNlYqTd8EQcDxAeiERpSqFHQ5
         f+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717009015; x=1717613815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7uhrzRqGxcnEpl8c7lrMtI5+aKBA2FG4lV27CS2WdU=;
        b=Y5jxo0rEPIaHIq0imn5T/LgpywWfA2H99pOlka19BUoSrNFXXhuq4uuI9EI+6fnerI
         k29S4nEhZnW/m/oSSAv51PbX6uilk1ht9q3ob8zYoXxvIJ/qAjCkqJ4o7YRa4RnzkTbB
         5oE8eWQ4kEERLObMlsi3DNEg6+5vZjSnFhB6YD7ABHvXIgfc1ajdWKJd9QwB6fiVxhT5
         5YQv5ES9XFrapJCoAzF63kkQ+C+47orEnH7kafp7px1nvCyznGeUZBuVUG+HBno6sE8j
         FJIgKSjYRYs2+0I1P5ZpnjkU+hpJalENtJYC5aytqtHNBUzF+t3wKYzNCEtJ5AFGek3Q
         I7hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqp2g5lgJIJPep6BtGOUzzI4fzmWPX6DbMQ5DO1sQ8ZLuGVZtryJdLNSA+XCiDV6SYO2PFcCQd+w9UiVSodyMAQUSWXxr2y/IeSxnJG/8erw5WadDI+SsKnZqIF+LEmL8XraTL
X-Gm-Message-State: AOJu0Yz+REmpadFuWD0TXjHPFHfKOPHDuYdn3rQK9JDKReC9zElrpX6b
	gAeSglc+dmSiYp09fq+TLHzMnSBJ7o+46H8UU7Owu7b1G+7j5Ea7
X-Google-Smtp-Source: AGHT+IEP6HMiV0lu8zTmAZFDiGPziCzoHTO7N2gHovVYr5bOiqwiTz6YsRRzdf+/7gYrQIBInB6WvQ==
X-Received: by 2002:a05:620a:8121:b0:78d:5e64:4d5a with SMTP id af79cd13be357-794e9dbe0ddmr5138085a.38.1717009015003;
        Wed, 29 May 2024 11:56:55 -0700 (PDT)
Received: from master-x64.sparksnet ([204.111.227.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb18af446sm56601731cf.75.2024.05.29.11.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 11:56:54 -0700 (PDT)
From: Peter Geis <pgwipeout@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Frank <Frank.Sae@motor-comm.com>
Cc: Peter Geis <pgwipeout@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: remove Peter Geis
Date: Wed, 29 May 2024 14:56:35 -0400
Message-Id: <20240529185635.538072-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Motorcomm PHY driver is now maintained by the OEM. The driver has
expanded far beyond my original purpose, and I do not have the hardware
to test against the new portions of it. Therefore I am removing myself as
a maintainer of the driver.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..ae2075d7498e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15238,7 +15238,6 @@ F:	drivers/staging/most/
 F:	include/linux/most.h
 
 MOTORCOMM PHY DRIVER
-M:	Peter Geis <pgwipeout@gmail.com>
 M:	Frank <Frank.Sae@motor-comm.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.34.1


