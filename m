Return-Path: <netdev+bounces-69986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 337C584D2CA
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB50281118
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B01126F01;
	Wed,  7 Feb 2024 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkAFHBwH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89031126F00
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337199; cv=none; b=l9jzcC4cRwzzmQdCGMuxUrRtBY7ImlLFk65xqM+UF/dF+mEbzMTKwHkKxmcUetyxQTXD3CsDR7jnRioq2+Q797lOJ2HRB7xd4fZG8BNvBstOm4DO7I3id+IfgrNeGVWboeDBxm4ZGqkeHQ4WJEbJWZZmydqIGll+q5w8OjoH+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337199; c=relaxed/simple;
	bh=2ImmVy5A/Q4xHBYUvUXpHKnC5HP8CFZQ1weQ/v7zbVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hyitjHPL1owl5qlZjMUJsvepc5ayGBL4iZ60neewuMVlTGZPtdNNjb319x+MXnRxaifii0rN4On5Ktq6UgZVL17X/XaNUqIVMxJVSVHFP11MRvxC41dpjm61r4M4qSrM8VGVWMNxL4FAcI6JPjWEJVeb3jI2yKvQMYGWQtS0iZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkAFHBwH; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51124e08565so1634500e87.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 12:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707337195; x=1707941995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kozUwEImhusiQUKKwhyVCeDesgqaCxVuwdCkmOFA1C4=;
        b=RkAFHBwHiqt+CInBvBujOSwhxLqNNBCf3vA2dafdhwBrVwoPH7glChAV6cskPf2/Mc
         jkyGnwtqMBJkFFMySSQBIfmh3a3zlWNMI3869HHr/tdW3iNlOlTu8Y2ac5gUjFEUAkt2
         azRL1eI1hOPn4Kk0sbM8tf9Xhq1spyV4bem4A/tGPaSTSJ713PunF6aS5o/vEDfbsRet
         OV5mb/hIlYbYwlFUR0XGHfYHXFW76WsoizysqkbgFUtmrdZTSJzODmXYx7oZBc0xAU/d
         I/I9t1MdaN4P9Ukdhnz1WPzUbMu3+LZCIycLHzDhrL/JsN5URmvNWLF80FOlkPak3SAZ
         hbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707337195; x=1707941995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kozUwEImhusiQUKKwhyVCeDesgqaCxVuwdCkmOFA1C4=;
        b=bg0MmB5rwhAn/XB4Og3qrLd3Ewqa2LhLDNq5JsTxWTU6WMlraH8WnTCcbW89QHNyKk
         VEgSexqmBvV/rv/vZ9ZDpeEcgSyMnXCFwY2NMso8Z4dnbyj685CqR4jMf0EwNSnQQmSj
         2paqn1GuQy2A5amROaN+fHoYYueqmPoaAVT0CPiZUaKcqyq2RBj9WyF2WL8sr++e6KyP
         eOR4aIIdvhizQDP/vtYniNgAqA/JG/MkOST4sI83DkMeqqUFdyba+leRHtuymzAY7T65
         u+YOegQQk8JFo/yZqWlxjV/RtRtww97z8Y1BgN1WbjmoiIOxTwPt5OqvBOESbFHgMJwj
         3Cuw==
X-Gm-Message-State: AOJu0YzVqsbBCpLyCPPqvnuozj7Vj4MhlIziMQs/Rvh7N6//g4I0mg/a
	ppOxmpkdLx25uSmW+SeTNPpFxqSkZZz0Usl3FZxIvJ3WcL5NRNmr
X-Google-Smtp-Source: AGHT+IGST8us3KX7vTyyMJghhpmC0h0uxf9L9ASRQAln2iG41Koivs3CF5cL+ETZRm+mDQANsr9qkA==
X-Received: by 2002:a05:6512:209:b0:511:3b77:6972 with SMTP id a9-20020a056512020900b005113b776972mr5700172lfo.41.1707337195446;
        Wed, 07 Feb 2024 12:19:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV12tU9sOG2QW3SJLquk+NsUl/WLc81+9HdJ1hwOfmXpOBnVIQ2pAAkG/Y5tC0Z5dFNUKFq2rGFWO5RHBoGba15bYbpNaLQ
Received: from mishin.sarov.local (95-37-3-243.dynamic.mts-nn.ru. [95.37.3.243])
        by smtp.gmail.com with ESMTPSA id z16-20020a056512309000b0051157349af3sm306108lfd.47.2024.02.07.12.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 12:19:55 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] iprule: Fix descriptor leak in flush_rule()
Date: Wed,  7 Feb 2024 23:19:00 +0300
Message-Id: <20240207201900.8813-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added closure of file descriptor `rth2` when returning from function.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 ip/iprule.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ip/iprule.c b/ip/iprule.c
index e503e5c6..ce40726a 100644
--- a/ip/iprule.c
+++ b/ip/iprule.c
@@ -534,8 +534,10 @@ static int flush_rule(struct nlmsghdr *n, void *arg)
 		n->nlmsg_type = RTM_DELRULE;
 		n->nlmsg_flags = NLM_F_REQUEST;
 
-		if (rtnl_open(&rth2, 0) < 0)
+		if (rtnl_open(&rth2, 0) < 0) {
+			rtnl_close(&rth2);
 			return -1;
+		}
 
 		if (rtnl_talk(&rth2, n, NULL) < 0)
 			return -2;
-- 
2.30.2


