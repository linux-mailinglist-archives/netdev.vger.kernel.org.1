Return-Path: <netdev+bounces-212314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2CCB1F287
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 08:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7BF565C9C
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 06:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC67E1DE4EC;
	Sat,  9 Aug 2025 06:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8UC3STb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765DFAD5A
	for <netdev@vger.kernel.org>; Sat,  9 Aug 2025 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754720420; cv=none; b=cgmj2Dq47x/dD/HgzrYXbXsArA1dv8NCx4yn87L0fp5FMBn3U9qPCUFLtMgV/o0fOskoZet9wjINUL95p/4FgMqs4fYGjo3vGLbqqUmVAtSIxfl2MAfLApZ4rLRaBDw//1bF0Hcr4mprneVzoqkDqXA+m4hL6AC+wIsc1rq6bZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754720420; c=relaxed/simple;
	bh=Vsi4bvt3i+4MCaiXSH90HhxJh3VZvI/UVulnMlqMVIY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nPGoXVhhEUtQdJCvI0jtxJAr22rwAfmQ5lWdxP+LrWdiFMlK/zcm3siQWaNByWfsYNdPWmgRiIvJ+znp7mWJ7vgweaFx4OPb1q3kzYWgVUV+l3nDgpCUfSWTcNVcv75Hwk9W/OxRx7/Dz5it15DTQ2GUZDzQ/mUfA1aF/SJjUFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k8UC3STb; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b42a097bbb1so1405423a12.2
        for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 23:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754720419; x=1755325219; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QZ+FYSIf313DQiqdHJ8DSGaBKM3x0ZwAaKOEdduY9g8=;
        b=k8UC3STb/zwvhpkFm5jYbO+Tv0pV57gkxGT1VMVuY5/muQ9E8z1ibvzTp8N7f3OeTC
         6CnXsSEJehPHiLEbtwqepqJ89ECxL8wiu/Pyuar89N/Xa17d5pde2gH3k2Hbqja15E72
         qNx44vbECxy7SDcQt89qFN/NJql1NfdWRiDgfY0P9FVcTho8oggd0hNAtYZvPV9qMeYM
         Nm7TNWb7/HwwLLU6JyAIVKR3ftSWHsbw5G2L1K6NL3jSJHn8psBCCTjoW98uPzYeclDw
         l5GO3aj4c7Xee63UI3Tv0/vk7XCXy+WtjGZdqYKjd+yvHS3nhMmmLJH7dbUH6EYb8QO8
         uqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754720419; x=1755325219;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QZ+FYSIf313DQiqdHJ8DSGaBKM3x0ZwAaKOEdduY9g8=;
        b=Suu4hjkiOw1HS6hoCv9fwdguKscdNlsurasZxd8r1Oi1P149gxWZfsMyo3GpAXEE/h
         0LqgBv+orbz/9ItihaE5pvErMLRAafZJPz0LDTHHzV9vVhjguMa6JTiT8eiRPfiN8AHF
         MfiZ0EB9qiBoodkJaaT2cMUq72Mvv59ledhQNKt5tMpekISVkBIP36Qn9q15KpjdR1YX
         JF74VYYlewncblGKCznqzf1Xi0fAEtXHJhP3CWG1wGjsvGmQT+CEuKjrz/ZxB3DU7ruO
         x+FQWn5iD4J8Q4S/ayrC7R9S6+xAzkJkmXdFr1wDdnmnA8C86k50ROh+JtxLkut1oNBI
         gUnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYvmP8urvCkAYLMppKHSbcer4HRsCaVmUGdoH4Xgh67wq8PQpxzVC1CGs/BSfN+gXM75pWj40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQXn8OdTHkaL38oyRahBbnzq9nC/aRfRW6oKJmx/InwKNaDfds
	Y9yl6d77PQUTo5/PLWY++uAgw6EA2e7wEHF7+2PgKSUhYCZpeaRLhji5Ifa2m03D4MR6DULBwcv
	uAw==
X-Google-Smtp-Source: AGHT+IFp9mOjKmTbOVKDY9cjbMKEgm8xFNc/WIg9McOlmcwo7mRCu5csxBYCyKRXT/VavkWSZ41LJUaxiw==
X-Received: from pgx12.prod.google.com ([2002:a63:174c:0:b0:b43:f9b:89d2])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a124:b0:230:3710:9aa9
 with SMTP id adf61e73a8af0-2405500e326mr9508565637.4.1754720418731; Fri, 08
 Aug 2025 23:20:18 -0700 (PDT)
Date: Sat,  9 Aug 2025 14:20:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250809062013.2407822-1-wakel@google.com>
Subject: [PATCH v2] selftests/net: Ensure assert() triggers in psock_tpacket.c
From: Wake Liu <wakel@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="UTF-8"

The get_next_frame() function in psock_tpacket.c was missing a return
statement in its default switch case, leading to a compiler warning.

This was caused by a `bug_on(1)` call, which is defined as an
`assert()`, being compiled out because NDEBUG is defined during the
build.

Instead of adding a `return NULL;` which would silently hide the error
and could lead to crashes later, this change restores the original
author's intent. By adding `#undef NDEBUG` before including <assert.h>,
we ensure the assertion is active and will cause the test to abort if
this unreachable code is ever executed.

Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/net/psock_tpacket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/psock_tpacket.c b/tools/testing/selftests/net/psock_tpacket.c
index 0dd909e325d9..2938045c5cf9 100644
--- a/tools/testing/selftests/net/psock_tpacket.c
+++ b/tools/testing/selftests/net/psock_tpacket.c
@@ -22,6 +22,7 @@
  *   - TPACKET_V3: RX_RING
  */
 
+#undef NDEBUG
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/types.h>
-- 
2.50.1.703.g449372360f-goog


