Return-Path: <netdev+bounces-224316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2403B83BBE
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA32F1C21E56
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6803009F7;
	Thu, 18 Sep 2025 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQor4PqF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74676301025
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186975; cv=none; b=abC2ajrwPSKPTXhBdMMN0TSpTZ28bZCTwzDhFg8cszxKr8GnpHQN8fhGw1bWnU2jEmCcjP311afFqm6HvUqElWuIfUE9jlSj3vweF1otJDjkWiPp0VaGipwNNClixnksm8cu5LIttCMqenrCMBZkcAG5tN3jUmDA7i17dx+cSYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186975; c=relaxed/simple;
	bh=98ttZ9eR6hr3IbsV5simrsu42v4AubUjHgHeWfeLngI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UazXBXn+ELA3G9sZ/Fzc/yrmdqJpWUiMLeFd96OpH8RxbZFRi32NDvQpSVFQM/QHNtgzENwxcuOfxPTh4sxcMB5ki0rt6B3X9xQYPSKEZ7eCcFUiOdMaWguSA+AqzmY9t4U0nYXRb1qmz7UVWEDD6gTCVh4iHOXlC/wL32FEvfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQor4PqF; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-570d0c280e4so891776e87.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 02:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758186971; x=1758791771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VIlkc3NgcPLT5S0ahC7Hvw1WQpOkC1g6Xkj1YjAKs/k=;
        b=mQor4PqFw0M+qI+QzJmoH8xTPZsM42HXVEpu3SKN+MxsvfV9A+Mm5oq7qhS679SXSl
         M+qz8DUOZ0lSUk04BbLm7zUK+wVVmFnYc64sLSrOW9uMJ8VPgEQOFTKNK9URHF7LsxtO
         J6kh+hgeVQfXvV78ctPWZnaoRdv8aNx4V98EBlRW3QQHq1sVZw4busXV7PnepLlm4n91
         EKOd4EeL2kIaNZQAWdmJZT+Lc5qv+6K7nMWiF1CUIiv3cpj0I11lqrvTctytrPUYlAl9
         cc9ON/mTQoo2zazV75QG514rO8EcwcFrsRdSzy0sBGHIcc/kM4XDKMsHj2d1HRBMwZ7L
         3mPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758186971; x=1758791771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIlkc3NgcPLT5S0ahC7Hvw1WQpOkC1g6Xkj1YjAKs/k=;
        b=m/PInVBCuXp4aFiL9Q0p9wGlHOV/n+iBmvn7VEmrKNLGJNV9sUzQBz6uNGSGK6yie9
         TX0h9FF2am4Cg5vHalIf6j34HOuORvX8kkX7gEOy7SizRwiWK7Aic45zwMElZwGvieQy
         KzIT8ZO7T6f3tg65oERIQnDtirdCkjlpgvJHGcPd4YXX+VD+g74oqO2SY15STf+jGe1b
         ih4Eki2D08uCYI+ZzTukqzd1e878UUUrTLw1uxd20g1fvmjeVXYYvdJ//iI/QpfpXDh7
         BzYpkL+jMpdRWipzHSdOkpqSnGJHi6hipGB50C8cPL93bJXzZN34eEaq/MoR2tSVLC7M
         l1lw==
X-Gm-Message-State: AOJu0YzOCSa1u5IvMIhhG6YKL8y0NAI8hy4+g3bqIqLSsDgZIXJC2yIK
	bteCP6Srcl7OnyHyckV82oBNpuexbeXeonDzxCZaS634ovVIeYrS50Vk6k5SWW2Q
X-Gm-Gg: ASbGnctaNj57PpBXf/o4JCGLTosr//e3esgyBiua53oFBUKwKPZ2hIG4NQAXB27FaV2
	NOIDo79sXO9hWC5oYYmu3hW8fHzit0+hwTooQfQF3quG40I84wD8Z740icX96WHxWnNdkrUqwJr
	IWXsAZCQw+PGdGBcem8WNaE7FbNuwoecJ9qdx92RqCmg5u4T4I/wyGZtKKZmZx4ekAuM6aVLpPh
	VpNhHzbHmu5FYzjmMGncuLbll0MxiKmWrSTgI9rZTe+Vb5YZNJfNnOomTDEvkjZaptY1z7TVtPv
	u7+aV0cqSH4jXk8biNdm/K50au3XFBhTZxGtBssHarchN9PkgRf136ZQrJNVk01HtvQnfpNW02q
	RDciIStLTrywtLl2NFvvvh/WcAr5YiEDZtIrt7MGxROmo9f+PROuLfVLxXsgoITsBN/LpTUHobw
	==
X-Google-Smtp-Source: AGHT+IHJv7z9kXEmV1yxyHzlOQKZQwKv5LmhZV0vksquca82KneC8BfNOeaB8qm7yBwCzEoLIevJYA==
X-Received: by 2002:a05:6512:6090:b0:55f:4b01:30ab with SMTP id 2adb3069b0e04-577943b9964mr1578614e87.0.1758186970808;
        Thu, 18 Sep 2025 02:16:10 -0700 (PDT)
Received: from X220-Tablet.. ([176.106.253.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a65070c4sm522846e87.34.2025.09.18.02.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:16:09 -0700 (PDT)
From: Denis Kirjanov <kirjanov@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	dsterba@suse.cz,
	Denis Kirjanov <kirjanov@gmail.com>
Subject: [PATCH] MAINTAINERS: update sundance entry
Date: Thu, 18 Sep 2025 12:15:56 +0300
Message-ID: <20250918091556.11800-1-kirjanov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6bbe4b4f8ec0..5e975d90480c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24259,7 +24259,7 @@ F:	Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
 F:	drivers/input/keyboard/sun4i-lradc-keys.c
 
 SUNDANCE NETWORK DRIVER
-M:	Denis Kirjanov <dkirjanov@suse.de>
+M:	Denis Kirjanov <kirjanov@gmail.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
-- 
2.43.0


