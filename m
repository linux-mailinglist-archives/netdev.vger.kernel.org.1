Return-Path: <netdev+bounces-225780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DDDB9839F
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 06:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A94F4C13A7
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 04:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6841F541E;
	Wed, 24 Sep 2025 04:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mWnIgdqP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F31EE019
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 04:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758688908; cv=none; b=TOllZSd61lQlcz0cqreMSu++sHg/x+Wie9sYXyO04yXMyPNqwZ4rj1K2+lQvb2fe5Y/QQhj4lO2MooYdsLG85og1cS+YjCnCAeCUhB6yvXq7+JS1YRxIeWgzwfmw85EdxULQkugu/Eill8qE9k1W9qpYNsgwxFLdvzj4LJvdlqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758688908; c=relaxed/simple;
	bh=VkN8VdwJf6liSsFMc51tLMa9eVqIny+v9e0ELBq7zGo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EIHr+MFGmYSXL+pVvKLtE+qplE9M2pPvfZIvyoKPVlBjqDG5d/oIgTcebcpVnW5NtCgmNIvfgCUlCLH0T5yu0SyZ2WS/pSFLaQvDSjDeqYnkoiFuy/hhyABNqrPHvxcvPDJjsqTJrkiobCC0z4vef3PC58xK5GzY0MkYHzu8mBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mWnIgdqP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2699ebc0319so66904345ad.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 21:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758688906; x=1759293706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EE4vZbGIJvGo3igNi0/c9KzOBwiHc7y3M43t0PHBKt4=;
        b=mWnIgdqPllmdmEo1TRbYeqSo1qr64q902tyiXqgICLgjjj4tTQwcSB1dZEg5P20uTq
         PnE11BwUyKx6VgJdcP1OpL4dhVTzU3e3liX8RAA1WoY7QfUAx3oCOR7VQXpvuJcbmETr
         7e/Bty9ijyhJmfa3lle3FXU66Ijv0j2yWTqlBBwHkYBPJblWe4C8GKvFBpY9ffCQaryS
         ZvLqpsSj+7WHeHxEMM47Xm1pwnEMzeM3m/d34KYw2fiLHqkOePbhOF8iKMp8H+3W2lh4
         SOpy03yVZTjvUeXqvHUTty323aKPrlcOwuRcUnNGQ59VQKVpudPNvAPhdN2KeETNWjIY
         cXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758688906; x=1759293706;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EE4vZbGIJvGo3igNi0/c9KzOBwiHc7y3M43t0PHBKt4=;
        b=n2ho0y16kSWZIHeAs6RgUOvFSebCxPZs46I/zXMa0veMNOuCmx/OuRwuX27VE2qTqQ
         NaNlKsW6R5PghgI6JjHbrMlypcAQzpejWrLDxuALcyZxmPl1zIdUTBq8bp0L8DeIdUlf
         sWFeCayttWoIMR3WaLrWmD9SoAk1g4FKbw6N/jRXi38WWuXG3NHXUCUFc7yKlhjxmsrq
         xcUEEeeAyZDNB4tv3KU885O0SpwQ4cBsYX+vx/XnqPp4+snR+/VLte9HQOjjFv7Jdps+
         cptmLKo//5fWx06ko373l+xbcjBHib/QIWD1WCMiBWAd3O04eVMepiIcuAOybGqIu2Fo
         An1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPMK9vWr0CMn+PNatch/2e+dfN2ku9uNd4hF6q46O7TMgV5xKKMc4r8pViNbmmt0qcViMQM+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwASJlUBI+m1dATtL93i+T4zrz+uc07kh1Iqgt+kHxR9ND8ORtt
	Y2HeFkE3/PWgsbNrKRz4eZG+/U6qxyJ+3hjS7ybnVVHXbRhicwc4FsFjKoq8YHdOcJTIQYx3LUP
	AsQ==
X-Google-Smtp-Source: AGHT+IFcIXMb7tZZIi7ut6xW8tfCbz5S5n6NQszs9NFINm8xgD7Ql5FeEdZB6xxblrlnYdA/SzP9uVQoDA==
X-Received: from plbmv15.prod.google.com ([2002:a17:903:b8f:b0:267:fa7d:b637])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f609:b0:248:e3fb:4dc8
 with SMTP id d9443c01a7336-27cc7bb9ce9mr59498475ad.39.1758688906448; Tue, 23
 Sep 2025 21:41:46 -0700 (PDT)
Date: Wed, 24 Sep 2025 12:41:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924044142.540162-1-wakel@google.com>
Subject: [PATCH] Net: psock_tpacket: Fix null argument warning in walk_tx
From: Wake Liu <wakel@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="UTF-8"

The sendto() call in walk_tx() was passing NULL as the buffer argument,
which can trigger a -Wnonnull warning with some compilers.

Although the size is 0 and no data is actually sent, passing a null
pointer is technically incorrect.

This commit changes NULL to an empty string literal ("") to satisfy the
non-null argument requirement and fix the compiler warning.

Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/net/psock_tpacket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/psock_tpacket.c b/tools/testing/selftests/net/psock_tpacket.c
index 221270cee3ea..0c24adbb292e 100644
--- a/tools/testing/selftests/net/psock_tpacket.c
+++ b/tools/testing/selftests/net/psock_tpacket.c
@@ -470,7 +470,7 @@ static void walk_tx(int sock, struct ring *ring)
 
 	bug_on(total_packets != 0);
 
-	ret = sendto(sock, NULL, 0, 0, NULL, 0);
+	ret = sendto(sock, "", 0, 0, NULL, 0);
 	if (ret == -1) {
 		perror("sendto");
 		exit(1);
-- 
2.51.0.534.gc79095c0ca-goog


