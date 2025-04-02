Return-Path: <netdev+bounces-178864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5A7A793C2
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 19:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84007170CCB
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2111519DF5F;
	Wed,  2 Apr 2025 17:23:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA52C17E8E2;
	Wed,  2 Apr 2025 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743614590; cv=none; b=ceaeEkSOCC0wwF7NUIJSXAMWwDHqX5VHo/MV1uTrY3ttZSR3AcnybLXNXPPSB1J/Lp2iEl9TpR3rujIf0bEMGkcGr5HtKBndG7ZbjSHH2HUW49BESFduRc5iaMnByJJcIkjA3U/LQEaH94fXn6PjdOabaRTBsD+b85qK1lPTFH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743614590; c=relaxed/simple;
	bh=qboEJB0XC7UZ659Q1hFuWPZyl+9SCB/g3TXKGXISjc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g3/m9mboRZI7USxb3enub7WAZuQAGep1H7X6+WqdVhourRMYJI1L8mk9TO+UCOeR1IjRYh8jqr4iEmk0Kx6Gqu2/7M7dXidxgyfvEC0UjQ/YW+yOXN7w6bA8yNnAiYTg4WgEvL1RcF9i2RP+FzaPXzKPuWn9UgJmP9iBuFKfJ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224019ad9edso1236385ad.1;
        Wed, 02 Apr 2025 10:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743614587; x=1744219387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXBH6g4YVJFY05wco5KXKAXgGb2YFN2mifz9zT0B8qE=;
        b=P3TKRrI4nsfSgricjPAA/CIhfHpNKR1bZZj/3r1kY1ElRr2R+2CQp2JVXIpCBQQdGx
         9vznYN8ogQEJTesgNAn2ZNJNpwRK03RlrPZq9WHt1FeEd29hg9RgOcw3PbS/VcZlq2Yh
         mMKNRs8031kS3Tv8r0raRfXM6cHfr/E/iTVEOLQ78l6dh2UuduK5BUQ2I4IDC8giIY4C
         tgdU4cG3vk8XrMMmGDVzRDXl0fhIyaRFiao5N2ip61uzbptCsSaoOkCZjAKhj5D87W98
         pGgZ0T03MZdr/YB1u9rjTysoMoLZ5HliDsXdGzrVp05IL0NplSb9Jmw+zq4PfYvZuOYA
         PdxA==
X-Forwarded-Encrypted: i=1; AJvYcCWNXzW/Rh3DcA/T3yne4QDod32dWLBHgfOPUyXLZ9TbFKe1CNtNEIioO2pAJbMSh52+AibBhjeLh6Ec9KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRIqp+GzUZvK3h6KvuM8usAEtmG+1ct3hIgCQpeSrN3I+3wdd3
	XZ3xvhGy9xFPehI8Xk+6KhvPojksmBI0MEssMhq7xz5gYVZU95milPQrUzw=
X-Gm-Gg: ASbGncu1LcNtgrQDLswcpXQ4dHmAwGKNSDVV1gx5Pr5XPw/9Z1SAld5trvRHMxJ0oWy
	jwGAG0H8C+gTNSCQagAZN+HknDfi1ON/vvQZDIw03TvUbMxet0DT+7ShXJTTxTdJGMAReJxX+s6
	X+RjHlFo+oB5lILWQ6la1N7wF4aIh2QMN3FoQzE1s0g3xxv5Oyd5Imi7lNjlAa6emqCDQQmqIkb
	6K5gUkXXH/GYAyt5t5IUkSAgpM5/SVaVXgjrcuWlRKpnIzIVysAcU+wajS4P+BPDeo+HokMBRNB
	LSeWvFyTTvDU6uZTF7EELvrQMrzCIK6vaamJom7T0lWk
X-Google-Smtp-Source: AGHT+IHTvxvtH54nZoT1e/ZxWt9uP8S6VD+PvawC5K+Ig+rYK453902DT32t2dZrn9IoU/bGsw4U9g==
X-Received: by 2002:a17:902:e892:b0:220:cd9a:a167 with SMTP id d9443c01a7336-2296c603980mr38329705ad.4.1743614586408;
        Wed, 02 Apr 2025 10:23:06 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3056f80e9basm1919014a91.6.2025.04.02.10.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 10:23:05 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	paulmck@kernel.org,
	joel@joelfernandes.org,
	steven.price@arm.com,
	akpm@linux-foundation.org,
	matttbe@kernel.org,
	anshuman.khandual@arm.com,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] configs/debug: run and debug PREEMPT
Date: Wed,  2 Apr 2025 10:23:05 -0700
Message-ID: <20250402172305.1775226-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent change [0] resulted in a "BUG: using __this_cpu_read() in
preemptible" splat [1]. PREEMPT kernels have additional requirements
on what can and can not run with/without preemption enabled.
Expose those constrains in the debug kernels.

0: https://lore.kernel.org/netdev/20250314120048.12569-2-justin.iurman@uliege.be/
1: https://lore.kernel.org/netdev/20250402094458.006ba2a7@kernel.org/T/#mbf72641e9d7d274daee9003ef5edf6833201f1bc

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 kernel/configs/debug.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
index 8aafd050b754..e81327d2cd63 100644
--- a/kernel/configs/debug.config
+++ b/kernel/configs/debug.config
@@ -112,3 +112,8 @@ CONFIG_BRANCH_PROFILE_NONE=y
 CONFIG_DYNAMIC_FTRACE=y
 CONFIG_FTRACE=y
 CONFIG_FUNCTION_TRACER=y
+#
+# Preemption
+#
+CONFIG_DEBUG_PREEMPT=y
+CONFIG_PREEMPT=y
-- 
2.49.0


