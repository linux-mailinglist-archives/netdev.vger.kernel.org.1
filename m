Return-Path: <netdev+bounces-140795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 265269B814F
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 18:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1231F2581F
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 17:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7539E1BF7FC;
	Thu, 31 Oct 2024 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mv95/J2U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2961BE852;
	Thu, 31 Oct 2024 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730396021; cv=none; b=CzGUp+LVFMOrC03Jsktfa36EdmrN1GjrjTqrlpGnlNRnARK2egaUSFM1YIsyUP+Tx33QYLDGXfg+w4DIZd8fo47ybjZQCBDtOr15SS7sZmSTYwsbRpY8fsnvXzT8qcAU4ieBTjssv+BntjT5MvV5IY3fiPNttCqmu2Zlaz5mHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730396021; c=relaxed/simple;
	bh=Vbdsc32eBqxITXVogf5U5CY/g1QXmPCoJar1KLiagic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4STJMe30+zELjV3ZwAr7RwHti40rYBXdP2+QZ5iz/uM+TGB4/6s7mSrSfHfKui50ar1l+tyoG1ZgYzO0M7H9ar7+vj0lv8rxseB8kMgS1A4RHB4AtdIfWhwEG17aBG2voC2NV1e3EZF7Vm8psA+eLuhJImFGD6yaa6eY9nJCns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mv95/J2U; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso11478605ad.2;
        Thu, 31 Oct 2024 10:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730396018; x=1731000818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dooei+hGMSIXrRTRlmIrE2a4OrlveyYhxXQpGK2hesE=;
        b=mv95/J2Uu8QuD/WwXtnzJmuRAeBh1nL0lHHaiTsMnVQe3QtCl5NdEYVW/mgZeL2v1F
         vSTodQ7iYIst5DrH2YMeOF8zjfij4HPvIJwWK/Z4XHAXfe/HnyCkKEJZws9B+I9semoD
         ++3IodbY5T+i4qBi5iWtIxr1izNRoT2K+AF7b51/b59j10VUY/Te3vStRNW2gapnTyvb
         0zWsnH1sFX9hTpGjaL4+BOlxws8a/8fqxXDv1TtfO4dIfmHVUp7/YZO5Fj101hI/ywm0
         8IUQkgbNj0ryEVz4fXyf/rHXPjPdfsQotIA9Ens6E3KAjrLuVCKC6p54LSGktjoigZC0
         X6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730396018; x=1731000818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dooei+hGMSIXrRTRlmIrE2a4OrlveyYhxXQpGK2hesE=;
        b=EqVRIC9DvrIRIULPwrjoNFyHrLB7tfc719pm8Mr1kybHqjdYCxDzjdgv49RhL1+U5r
         UyKe3as+xBBfLHUfZmmVnWLawrmO7r7uHqRtTwZQAG1cY3m7RMACHYkKL7wZ2MiXDwHV
         +qQcLPQt8IAJ2fgQYrh3xATTKbqr4nW0prepTOiKDcmIaicy3Laru69x2FrERZqlLLg2
         8JuliTDvVsklow4R9PZvcHYokoBSaXOLTOp5/ubaFmVYBCpNhfXkd9kXVxg6OfkthyBY
         rmidRz2idQe/o1YrFXYtgpz98SQS5SQlqPR4WWO9LqEs1NmURHpuk9fyrPOn2E2PSqdj
         Gh6g==
X-Forwarded-Encrypted: i=1; AJvYcCWWnctZgdY3G/myLC034ppJgkeQu6TG+0qN9jXPmSuKZDBoxA4MzWyhVDctcPBt1Lvzquofim6S+M26XI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYWQCOA1MZcMSehkyTCB5efeDtXvOWbOls9l5rcwV0u1WHHrWQ
	LR10aM+tBWFhRYoBrGnglqdXJqqfQkcIw927IzcievMQ8FZzQEUMHIVimw==
X-Google-Smtp-Source: AGHT+IHY2s86obO7paaXBVSJ3UsVQxUlMW+Tw2cHQxG/WIGb2eBSJGgB2phmWjClRUA7DK6j8AAQ6g==
X-Received: by 2002:a17:903:2a90:b0:20c:79f1:feba with SMTP id d9443c01a7336-210c68784femr249600915ad.2.1730396017971;
        Thu, 31 Oct 2024 10:33:37 -0700 (PDT)
Received: from eldorado.. (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a7522sm10987315ad.156.2024.10.31.10.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 10:33:37 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Yosry Ahmed <yosryahmed@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] MAINTAINERS: Remove self from DSA entry
Date: Thu, 31 Oct 2024 10:33:29 -0700
Message-ID: <20241031173332.3858162-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- add self to CREDITS

 CREDITS     | 4 ++++
 MAINTAINERS | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 63f53feefa0a..96660c63f5b9 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1204,6 +1204,10 @@ S: Dreisbachstrasse 24
 S: D-57250 Netphen
 S: Germany
 
+N: Florian Fainelli
+E: f.fainelli@gmail.com
+D: DSA
+
 N: Rik Faith
 E: faith@acm.org
 D: Future Domain TMC-16x0 SCSI driver (author)
diff --git a/MAINTAINERS b/MAINTAINERS
index 6880a8fac74c..b59ee664f6d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16024,7 +16024,6 @@ F:	drivers/net/wireless/
 
 NETWORKING [DSA]
 M:	Andrew Lunn <andrew@lunn.ch>
-M:	Florian Fainelli <f.fainelli@gmail.com>
 M:	Vladimir Oltean <olteanv@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/
-- 
2.43.0


