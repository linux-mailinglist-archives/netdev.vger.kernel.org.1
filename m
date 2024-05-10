Return-Path: <netdev+bounces-95211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C278C1AF2
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237471C23563
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7444A135416;
	Fri, 10 May 2024 00:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cVgXBzW6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB6135A56
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299841; cv=none; b=lunzHaR+E6+QqH4gV3QNKEswi8B6VHHL1I7FVsWQHFDgJRfZbNiwiOWbw8UfZT7NRmgrwHQO/sFXokO69c325+SMhNQsk0rYY4Y5qu4WR8ANk3w6k70RjfVapLPipFU4GHDSu0PMFUSV6lBHI0OOKipjS02ehBGuuWPRLc5ETgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299841; c=relaxed/simple;
	bh=EZsEhYoF/Nu0QGVgoNXSBfJXGSlIe/SAEA83mlUTcYI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=otDXyJpbh1gEBIgi5e+ltb6lRV5inGlVkT+R20IAZcE9priHLXHvbn1aNz2hivuiusXG7Kp8XeloBhoCzAcVxcGgPPCwhxEsejJlIXPNPDqbcmE4Z9s+kz8CAp61yFH4eoNS7WKYceuWop+7zEs8B6VKJ4o2ZfXqoL+xZLRrLHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cVgXBzW6; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f386362640so1458971b3a.2
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299839; x=1715904639; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zv9hDsECpk9yhgUK8qXtrMx/MNHEvKj5YS1pAX1XIVQ=;
        b=cVgXBzW6osNho1dtP48E7xj5p2gIzytz0eolHT42zXiMQsPhvSkeLu+OOFeDj2+JRj
         frZkVmMCD8lFHqSupT7YrM5dvUcmI5wynPNaiO3XbtWUbVYJHKKgOLwfafpwrzaA9Nw8
         iSItiJN2UhGjy/QlUpZ4xZ3RohO2uECP+kJpVHPIEyOBC52kQgjMpaudMOM+QHvFnPAe
         MXiYPRvFiaQH79oj+SJcUJd4SmaU3+HFf0xoIqfDX4jYn/MJdnCizt6iKCWoQoBEKjT/
         3HvvBVQNhswAxTCNId4VV7202c4t8KtNT232RJpuyWBzVxApnIRsKrbFdV1mtJVj5h76
         L6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299839; x=1715904639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zv9hDsECpk9yhgUK8qXtrMx/MNHEvKj5YS1pAX1XIVQ=;
        b=TsopH66FZOb71y5/XhQ6AiqiKV5zI5ZKwK/EZiixpov/WagbfrEqAxxGY4Pl33IWc+
         /g0O+LjtH3wqWpV+PRQ5XrCVr7SZwxs8sZJj5du8CFPPnO3pAozeXngTrh5Jc619Vd7x
         afikMdRJ+GwsrGbsY7x5GyjXNvqV94zy3fsVl3b/pqURqMYsbsQkgyVoBivDN0D/S02v
         zTnNHpdO4ha/SIXme9wTdbvWajlL0EL/o1PtYYOthNVniH935yzak1t1/MdHpTTZ0KdS
         z74nc24jF4biMl/0Fo4VISawuTEaNw7mLTgzlLxVUvciL2q9TJjmM5sXAh+PhOby35ch
         2ggA==
X-Forwarded-Encrypted: i=1; AJvYcCViIj+QdXNS3cnDerX1HjwlmFBNqpyY4BBXFbi73cunXSlBxAl3H3h7SFzWU4bu/rrOqdy58L7FmH729qrOlVXxk+3/rvY3
X-Gm-Message-State: AOJu0YwcyfUi/1+At3PfOLY7l7wTD8sIrlrc//Il7fmZC8AuzFN5TLhq
	cUwjXyHaeCWDhQUqXa8OAz5gDqxjTGBjo9QGcVMKI26SyV8JBDlTbOeoXcmhId5VTI05P3idD7B
	0sg==
X-Google-Smtp-Source: AGHT+IGonivkS2R1HvP1jmkZSFsjyubb1aG00OxxdbDNweBSdZoLp+FL6tawzI/d9bKsCP21+ImOsTIDeB4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:928f:b0:6f3:f062:c145 with SMTP id
 d2e1a72fcca58-6f4e03a31e6mr55150b3a.4.1715299839273; Thu, 09 May 2024
 17:10:39 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:51 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-35-edliaw@google.com>
Subject: [PATCH v4 34/66] selftests/mqueue: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mqueue/mq_perf_tests.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
index fb898850867c..43630ee0b63d 100644
--- a/tools/testing/selftests/mqueue/mq_perf_tests.c
+++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
@@ -20,7 +20,6 @@
  *   performance.
  *
  */
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-- 
2.45.0.118.g7fe29c98d7-goog


