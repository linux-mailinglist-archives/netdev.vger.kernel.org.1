Return-Path: <netdev+bounces-172104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C868A503BE
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B627A155E
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 15:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE792505B2;
	Wed,  5 Mar 2025 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw1451Bx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E34D205511
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189507; cv=none; b=rBKPdQXLXsoykQCNpUXfdYLWPRjFVG3ijnn1WWgKd8vxbIgpLf9oZkLVP29f/PCZDmKdjSacFTpo2Ky0yMiy38hkTVPhx0q8bwBPfK8OEzgWm87R3fpWrRMaFjTw+y6l2ehPAIOFynix1H+cGv83au6f5T7ygvRbYl/DkVa6GYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189507; c=relaxed/simple;
	bh=n7Mn7LdR8aLxIWoXU8Q9sRE51Hqcu4+5rlJiv1g4rmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GK4YcUT0OhbMNQ0QXVy6/y05HiucLDms3nGLlfig5fDeTkxfAHX7usAV61swrn7KR+iXfNoNJee+wFKT3/wBmyjTtLcQXrBwtGd/FyJqavBQ7zOIu459cuDWhAF0PJHVXK3huhVVhciaK2lZ/j9SqIcV3Fv8LtyJMHmwvSiPQvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hw1451Bx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223cc017ef5so54084835ad.0
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 07:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741189505; x=1741794305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJ2jvRHq/+6p9zqriBxmQzPPAbm+CGLsfUo9A1q3kxQ=;
        b=Hw1451Bxsf9fVW1JIgb8qlxXh1nIdDgNjP1P3bHQNeVTgOu/Fq1RNQj08q3YuinrWw
         TjQq/EvFhIcO0sHgjiaURi8EeLVpax2qpjp1tOO+wZzm5KXXRx2/GDWq2IqVgKs5/lAO
         R1L8fsmzpryiH/7SpBD4XsU6Fz0xFhpwiyUWk5OdpW7Nebt1kH/LrLnAcgoucAEtaElI
         33LhqhXj/pGuMG50WWv8wU0Ul6/NabQkhRAyPQcW0WxUTDbIoNPrxKWVAltmhNiWN4HR
         dn7Re6QWM+t0JiRVq8jJjFvzAajZAmUmGJoaoEiyss2kFRfra55hXn3E6GlvBxFP6kJi
         OuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741189505; x=1741794305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJ2jvRHq/+6p9zqriBxmQzPPAbm+CGLsfUo9A1q3kxQ=;
        b=JHhdZoglEkYt/Vca41vPwzPb7IUYsLh3wExT1DhyPs5M/TqOyfa/2nPWxbbTJ5yolM
         m9dJLos3dLdpXqF6BdhAud9TMitZnlkDauXDrmOd7GVtHUgnsRD/DpHIvl7dQ4K+JoLq
         PeE6bbYAYQ5vMEPRDG+/SlHlXNOFpcAL3UA4UBxxh6iiKgfyhOk9wsNq7MM6J/QcbGAo
         JVF7M5x29CIltWwqP8iDz1LeZ3c2gDHSotgNvLgXm3A7oU/JQ+LuwgrGI6Jj+i+92epr
         oEDo1RtMtAJOTElWTcLg29yHqlEaVJmBKwNmQZROn/NtYKZ/4Fa/z+jBntR5Ud5NUxs9
         1Cig==
X-Forwarded-Encrypted: i=1; AJvYcCVEsfvYESsr4FgcWW515cMkeb2L4PKtUHS3b91+t5YvqqsZHAoDyuO2ammkXkJVXX0n+42IMo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCVTB9TU2txLLew8SNWQG96+PqrKhKKn6zUBkiEIiTBl/+uOlv
	WqgVmYC9PlI7fW1dvSrNpTZRp93ei5zuHq40J0rSZyYNBLoWFQdnBMzTOBBU2fCu4RKcd1k=
X-Gm-Gg: ASbGncvWO9JmJ6IwSJbFRRlEa3pbwVFtLB0FtjWc1Kbs0D4+UAqRKD6a1V+rKNHr7Od
	7AYT/TQFssJKZGXKdHjh1yaTvRFEECGC8lxiMP8I0mvId6NNmUC/AqQeQp+TqQwKHudaFl8DDvj
	6Y3XxmpvwS2PbJz+RRAdGnyKzmqljGqO4WjsX9L2OxpCqsKpdlyCQnDgwJc1vHm/jkg0SvpGOEf
	i/owyXAKBPN+P2gviCDiwKDD24c1XW+Uy86MLHxtYaCKrTqfB6wkK7ZKsbZazRgHBqumhoI1t6w
	OiwjBaQD69gheC56W+0jtYGXCh7CKLvZ1EEJFqN3QiYQ1MBmPQYg4QEW
X-Google-Smtp-Source: AGHT+IHJB/OcO5/aFk74DdNqcWXgtzGYuSpD/8cqZJIK73WDBwWJOkxoC8ixK1VqkcLckMyGwGJ/lg==
X-Received: by 2002:a05:6a00:4f87:b0:736:4d44:8b77 with SMTP id d2e1a72fcca58-73682b737b8mr5164142b3a.8.1741189505179;
        Wed, 05 Mar 2025 07:45:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:6ea0:c807:0:fa79:f8bc:7c1:855])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73637081ba7sm8860799b3a.112.2025.03.05.07.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:45:04 -0800 (PST)
From: Jun Yang <juny24602@gmail.com>
To: xiyou.wangcong@gmail.com
Cc: juny24602@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH] sched: address a potential NULL pointer dereference in the GRED scheduler.
Date: Wed,  5 Mar 2025 23:44:10 +0800
Message-ID: <20250305154410.3505642-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <Z8ddDSvJZSLtHCGi@pop-os.localdomain>
References: <Z8ddDSvJZSLtHCGi@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If kzalloc in gred_init returns a NULL pointer, the code follows the
error handling path, invoking gred_destroy. This, in turn, calls
gred_offload, where memset could receive a NULL pointer as input,
potentially leading to a kernel crash.

Signed-off-by: Jun Yang <juny24602@gmail.com>
---
 net/sched/sch_gred.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index ab6234b4fcd5..532fde548b88 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -913,7 +913,8 @@ static void gred_destroy(struct Qdisc *sch)
 	for (i = 0; i < table->DPs; i++)
 		gred_destroy_vq(table->tab[i]);
 
-	gred_offload(sch, TC_GRED_DESTROY);
+	if (table->opt)
+		gred_offload(sch, TC_GRED_DESTROY);
 	kfree(table->opt);
 }
 
-- 
2.48.1


