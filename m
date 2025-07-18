Return-Path: <netdev+bounces-208139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFF8B0A375
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 13:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303CE16A849
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 11:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889E22D877C;
	Fri, 18 Jul 2025 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdBh/jtf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E54929993E;
	Fri, 18 Jul 2025 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839408; cv=none; b=fzSZSMTk10JUf2EcnH5hSCEkC7uF4uUB1AZbaboaB+QuC/zy9DFeqpTjsSqaU/nuDGyYwzfrtBBv7liWeFjI/+z+RzTmTK5NvdAdLnpeMmNk+zfnMOzIcpUEP0uUUZo/tbETFHc84atR8ZxQB7TGO7pefmd7XppJ4xsBWP88Uvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839408; c=relaxed/simple;
	bh=QE5IVSFdwUGWOvpdFShq/N4OikapuxZYIHT2X3vGy/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VF+UijBtQqPmgPVSkQJ8tLSnE0UaignG65sxXI/6Wx2ODOT2UTEuiVv3mpOlKrw2cs6CuNlwqDQE+GLPTIYEoSQWE3CpYGHy4tczdCdl7K1H0bNH24gtTAYhwyu1ZLZGXxF+lQQ43G7hw0dfKCIdI2S4DIKkSpYBCfQHCVBddm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdBh/jtf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23694cec0feso19193275ad.2;
        Fri, 18 Jul 2025 04:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752839406; x=1753444206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eO/klyFkBhvTIq8n1w/tCZWfnrQWc9IQCdEVGWfYBCA=;
        b=UdBh/jtfrXX/Z1c5xZq8vEegAsA2tkthupWjICDquTkcj6F/s4bYt2CNNeypZp5cje
         wZyobh3+2i08KpRVZaHjnUaGxZu60FMHsWYAO6YVRRy26Eu936fVf87BxITGyJoqkpja
         gDvYV2n6I0PLQaOx96wF/pdxmtRGobkaWm4uL28Sk66pzCYoScSiV9aVdHOwSzDz5tC3
         h7xFm7dJqX4PVPm3ExFwXlNGpYuz7vhv5rSflPVIxjhjlJYOJPaaMWYwp+CArtLYTraz
         17vJBz0QtJmTWV/kBJN/01SI3AI9wgNeIv5TguV5UPyMjIyz17//6TzVrjrGT0tI+LqS
         92MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752839406; x=1753444206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eO/klyFkBhvTIq8n1w/tCZWfnrQWc9IQCdEVGWfYBCA=;
        b=PH+Yryg06mmf7LjCluB8A80aehZ0VGkjNdiCMPGxh14xGhXtX1+yONWAXAhWyO9WLH
         50vso/RhbX2RHEOHcjQxV/Fv2y4J4Ep1jTzU1Ws/AY0CQ5GZ6vuXaDvnQgv4XaQMnMEq
         Oovo5OfZRueZ1OtzRByF2CGDuay5TvsxS64KYvSWNxk/Am7JsE/scex6paC13WHU9/8S
         VClvrfRO7oVs9BPotmNTKxvNs+0JntwsfMSPE8vAIzExeoxc6W2OrUHguJ97aC+86yRh
         6AMoQwjB7ux+IkX8YjBoAt9h/KxC89cKpdfgP0J3rQ1vN1hVFSqsh8+1bHV9wJSU6lB7
         SjBA==
X-Forwarded-Encrypted: i=1; AJvYcCXEA0hhyd39UKyZV4YOnBmCdmuFPannnqzxMIWKM4c1XmK0nGwc6lFh+HmLqis2Y5nE6asVcYbqN5I38EU=@vger.kernel.org, AJvYcCXxvTY6xKQmqx7RfgHVAHtq6FoyFOv8VfJEhc38y6LBZcnMm22phtrIhGIvnt8wo/y/2t49IKkt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq0mo1wAZpSzGX6VaxvG55sQKTL23wKUmPxfHgKrg8LHQfLOUY
	rQO0TU9DvJbLwD33AArGIY725uziy4FOLlghxqEe690YluG9DIJzLXNk
X-Gm-Gg: ASbGncsXcLgq+egVmwAJEJr5CM4H9p64CcGM9uRw30Wt3PSTXGV6ioxP6/I6IMGU4Lv
	GnialayVCzLf/2KYe2NEsUc6rTdOEUHOOJHXA58A16cbEL+GoaxHvK65MVi1M+DOsb8nTG+RxrU
	Z+PYLOYHIb0RMXwnvKLsiqvkO94PsSkZ/zlWCafrepBOYXJiGZmcVxTArUbU/rDIL9iw4yYiFjO
	VDegS/JjJX88VqC9hQZVCwbaluHyzpWW9YrXGyC94UNrbz7osJNrJhMnjQeguXqJN+5Sjwfvd/U
	3IRD6LaGVtk5vVDH3EaqSuwWQypAHW2Nb37Joxg4Eg8iJFdFotiBfBYKa7VL+wgVLHZbhrORc/k
	mKr+VUjn2DxNsL+GW1RMCT38hQXTJEvFKYrlu8TcAfP3F+7nxkw==
X-Google-Smtp-Source: AGHT+IHDfnkUErxhP2Jruyl9EbUIMi6bx1KgbflwVufW7rXdBDJmQxHRn72xSOyW1cNvBCuZLq2jsg==
X-Received: by 2002:a17:902:d50e:b0:234:d7c5:a0ea with SMTP id d9443c01a7336-23e24f4aec0mr185931325ad.24.1752839406098;
        Fri, 18 Jul 2025 04:50:06 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b611f85sm11905295ad.64.2025.07.18.04.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 04:50:05 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: richardcochran@gmail.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yangbo.lu@nxp.com,
	vladimir.oltean@nxp.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net v2] ptp: prevent possible ABBA deadlock in ptp_clock_freerun()
Date: Fri, 18 Jul 2025 20:49:58 +0900
Message-Id: <20250718114958.1473199-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ABBA deadlock occurs in the following scenario:

       CPU0                           CPU1
       ----                           ----
  n_vclocks_store()
    lock(&ptp->n_vclocks_mux) [1]
                                     pc_clock_adjtime()
                                       lock(&clk->rwsem) [2]
                                       ...
                                       ptp_clock_freerun()
                                         ptp_vclock_in_use()
                                           lock(&ptp->n_vclocks_mux) [3]
    ptp_clock_unregister()
      posix_clock_unregister()
        lock(&clk->rwsem) [4]

To solve this with minimal patches, we should change ptp_clock_freerun()
to briefly release the read lock before calling ptp_vclock_in_use() and
then re-lock it when we're done.

Reported-by: syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7cfb66a237c4a5fb22ad
Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
v2: Add CC Vladimir
- Link to v1: https://lore.kernel.org/all/20250705145031.140571-1-aha310510@gmail.com/
---
 drivers/ptp/ptp_private.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index a6aad743c282..e2c37e968c88 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -124,10 +124,16 @@ static inline bool ptp_vclock_in_use(struct ptp_clock *ptp)
 /* Check if ptp clock shall be free running */
 static inline bool ptp_clock_freerun(struct ptp_clock *ptp)
 {
+	bool ret = false;
+
 	if (ptp->has_cycles)
-		return false;
+		return ret;
+
+	up_read(&ptp->clock.rwsem);
+	ret = ptp_vclock_in_use(ptp);
+	down_read(&ptp->clock.rwsem);
 
-	return ptp_vclock_in_use(ptp);
+	return ret;
 }
 
 extern const struct class ptp_class;
--

