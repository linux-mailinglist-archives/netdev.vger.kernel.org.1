Return-Path: <netdev+bounces-147734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B32F49DB761
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 13:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08DA3B23753
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 12:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1826319C560;
	Thu, 28 Nov 2024 12:16:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3382D19B5A9;
	Thu, 28 Nov 2024 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796196; cv=none; b=gPlNCtmx1gbg8t0oOWyTHQ0LQMccfq/3TwuGNx/TqVfEaUw4WO2/Yyn4IKaHNVPiKY7WdE7nOx6UlLPw4DSyqZmxtklYCjr+PUxBzjRHJe6BhVVVoKD/FuEXWnjLqeCZ3sr/g8ucGJV7zx8UGUwhLJM5J8t/++Y+HPhPmmatY5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796196; c=relaxed/simple;
	bh=Bwr9ZrPViGoDhpDsCaHjTym0hlxFTLbYs6+kxkidXYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Sv9tkXEvTRuFUZGwbp8xuo9v8ASrpHXZ2uyIkyF5zQ97Nf4Uw9Gfd4iUKK7IunTp9FZAtDCR27vvT9o9/GfdrsrA7oLa3jeEv0CFIcuZdCaGUsPMPqkBrEHSNyXdnlPattF2lM7brTy5dEGMtcUuvAPK21kHH21N3mdTU9JJ974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so3247034a12.1;
        Thu, 28 Nov 2024 04:16:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732796191; x=1733400991;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3kvf3OXj33X+g+46pipOXl0SZdSrOn/Cxnccx7DlvA=;
        b=I7p1Q/PE45kVYtmUplMNQ2tqh46catlKqCdFP6kK+1pLLpzThRbfF2GqzO517luRUg
         ZX4+pK67ictULygzeB4bgLOZPgwfAj9OqvsNiK2q2IPq59oVWeUPMKYXK+WTjHYurE2H
         R28ge2XyXdRNPP3rQSbIHn5FzFW/puoTGAApSc2K1fjKnM2s9OHpEcxqXqB0wRksC+Ok
         50J6ymbS5Bly/TyzA7kqI3pemgoAWYe4DC1GmQvaU19CXN/jfq7m0tbH016AjSTR8nwD
         DWGSS8lD75LoJBwiHUX6xWaNhY+FVSIAwANGxvqHNGkRGbdqrIE3/K3IHTXiyYAsg33a
         V68A==
X-Forwarded-Encrypted: i=1; AJvYcCWGYDwxF+GnIB2V00VaXOkRowh0RLeY+RJNqVsx7EZvLJL4SYo9iJvNBKDC+WJ1jGcTG560y+a0lfrx9H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDmEuFXvIi7zqEwUXgC09chjwU6M7m5DYPc0TX6yjWZnSzmopm
	lvmsHgh7LwMQD3HPZdVSc+wf7eNDjJQj/e6vL/VRvkAOGeJwmHWs
X-Gm-Gg: ASbGncv66jxcZgZxWfojUKHX1cwhfZKnuFfs9HfHJVgUws3mEOUcGAzH23JcIPk/umy
	JNG2Y1yD5vUYW2HGLgcPIOeLkrnm9nbxBCTlN8jAkgpFuQNYmo06WP156ExSMtCI2NIYOoMNAQj
	BeyFEDm4MfeimHRQR/WRF0vJxmA6Zv0hpjG948eNtHow2WYTtzZLNMJall39UR9pR33svThzwFu
	/Rhn0eJud+kyUq5qMGZLwrvrh/2gnlrbi4a5LLK/qu/EFi2BraZ2FvlAbfVsxUlj0wnC0KcHoLC
	Doc=
X-Google-Smtp-Source: AGHT+IEtzPhIRVlNfUfrAiV+urnJPeUlNoyUOrecAB6qkfjryGM8GXg9sBZP5QsYZIjX2Kq5h9FRCQ==
X-Received: by 2002:a17:906:2189:b0:aa5:3663:64c5 with SMTP id a640c23a62f3a-aa5946690damr270156466b.22.1732796191243;
        Thu, 28 Nov 2024 04:16:31 -0800 (PST)
Received: from localhost (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d410dsm61051266b.66.2024.11.28.04.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 04:16:30 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 28 Nov 2024 04:16:25 -0800
Subject: [PATCH] rhashtable: Fix potential deadlock by moving schedule_work
 outside lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
X-B4-Tracking: v=1; b=H4sIABhfSGcC/x3MWwqAIBAF0K0M9zsh7e1WIiJ0qqGoUAgh2nvQW
 cB5EDkIR1h6EPiWKOcBSzojuHU6FlbiYQkmN6XWplXRpXE/3eb5UsU8tU1VFXXeeWSEK/As6d/
 64X0/Kf5ZPl0AAAA=
X-Change-ID: 20241128-scx_lockdep-3fa87553609d
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Tejun Heo <tj@kernel.org>, 
 Hao Luo <haoluo@google.com>, Josh Don <joshdon@google.com>, 
 Barret Rhoden <brho@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932; i=leitao@debian.org;
 h=from:subject:message-id; bh=Bwr9ZrPViGoDhpDsCaHjTym0hlxFTLbYs6+kxkidXYA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnSF8dXMIbxvjLvyUTU+nbt5QcGvKSbX9TIK29q
 f4HW/YIYRmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ0hfHQAKCRA1o5Of/Hh3
 bejED/9Plc4ODkhczg4Rx0iDPQNxoBroBVsaHCbGh3jtjc9uD1DBRIJOsSunqeIaTfQ8wHudXEB
 UcvXbxFSOJk+U5owluDuQWm2f6C0YKtndYfuxuGMgnt2P9kiOjxtZtqg2SoL93PaTOsJONrOiAx
 ANlFCGwbZ6fhK5Kejw76JYTJKnIUg6xNmPCmDiREfFkkAhs5F52LpuHRBzTYKNnf8s/rG7El0t9
 M4CCl0IsAXNYM+KS/6X8eweP7P/Yr9D1uugMXpPKeA35guyKC/39+3fI6jAhOu4j0zo7EOaGJsj
 rCOBtd7TrUn36o+ZLttVcTxW7dymiXYe4WSKumDAf5jKI9oM+GTyzKCALJXUZsZfg/rlEBjbA5r
 I3PZsRWm6wC8tpIEAW3NUmOPC0DNmVvrvOHjlvsFpDmqbBMq/8sSAaMv7go29EB1pQlXbGBZu9R
 HWE+zj8iyaNK9hPmDoaJB2kWPqOR8LglCmsz3ZBH+6sbk5ETaj/2IMm7tK6+rxWz6XT/BOppYVW
 oKiTm5l/hGUMPvhiy/hzsXdaifpkH/bX16u3K4HBuqXtd9iWV/e6gmVQpkJC1PGkpK+xRlU+k7y
 dlVcGPXc4KLYqqDFFPV+sONS2I0GadxkLxvUL2C2//9ahnk59T0eMdwIktamJCIXZoSDKgDZxdJ
 scY9bBifGrvJJWQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Move the hash table growth check and work scheduling outside the
rht lock to prevent a possible circular locking dependency.

The original implementation could trigger a lockdep warning due to
a potential deadlock scenario involving nested locks between
rhashtable bucket, rq lock, and dsq lock. By relocating the
growth check and work scheduling after releasing the rth lock, we break
this potential deadlock chain.

This change expands the flexibility of rhashtable by removing
restrictive locking that previously limited its use in scheduler
and workqueue contexts.

Import to say that this calls rht_grow_above_75(), which reads from
struct rhashtable without holding the lock, if this is a problem, we can
move the check to the lock, and schedule the workqueue after the lock.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 lib/rhashtable.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 6c902639728b767cc3ee42c61256d2e9618e6ce7..5a27ccd72db9a25d92d1ed2f8d519afcfc672afe 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -585,9 +585,6 @@ static struct bucket_table *rhashtable_insert_one(
 	rht_assign_locked(bkt, obj);
 
 	atomic_inc(&ht->nelems);
-	if (rht_grow_above_75(ht, tbl))
-		schedule_work(&ht->run_work);
-
 	return NULL;
 }
 
@@ -624,6 +621,9 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 				data = ERR_CAST(new_tbl);
 
 			rht_unlock(tbl, bkt, flags);
+			if (rht_grow_above_75(ht, tbl))
+				schedule_work(&ht->run_work);
+
 		}
 	} while (!IS_ERR_OR_NULL(new_tbl));
 

---
base-commit: 0a31ca318eea4da46e5f495c79ccc4442c92f4dc
change-id: 20241128-scx_lockdep-3fa87553609d

Best regards,
-- 
Breno Leitao <leitao@debian.org>


