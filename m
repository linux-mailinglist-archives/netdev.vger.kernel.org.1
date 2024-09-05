Return-Path: <netdev+bounces-125524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D25796D858
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6EEDB22105
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1AF1A00EE;
	Thu,  5 Sep 2024 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlseN/c2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01A619F404;
	Thu,  5 Sep 2024 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538843; cv=none; b=jcX2RquCilD0DgXM34qvYulPNOE5a9RUFVDI1FiBy3oUUMSUmM/+/hPAheDxZ6nta6CYwBn6KgJygBTqKAJe3wg8jGyIvFdtyMDq2+sXwYdJkwl1x8lcdz9I7OREMeAFs0XObml+xUtYbHJXfxwiS+MdjShlQzw/1WU9OeHwdgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538843; c=relaxed/simple;
	bh=1WPNrH7MIg6nPqzcTONiN60aqZQzKn6XZDgzP15UyPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqFPdEx4Gj86k90eCeyyJNsvzT8Nu6elqQ2lNoI20OzEAjBC4bA5Ymz/7z4n3vf6ihbo/+RyJbzdyLCSYzh0ZJXLpOWdGzMVrxOJcW0tCWw2Qp+mWL/gO/rIO0MNJkLYNF+cd5yqIv7GaR3zyFG+rEBk3+kEq/uhna7dUbn0QbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlseN/c2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42c7bc97423so7277875e9.0;
        Thu, 05 Sep 2024 05:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538840; x=1726143640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uKqVutEytS68y9quKuA8oZ9AWLRXiVRK4dLthQdVgU=;
        b=YlseN/c2oiR3pUBMCZ3Lw2WMjh8eSCd2FCJKFmcPegz1OnXSEz97TnX7oUMQSrW1sO
         iPBQt5fTlYKrRd8neq9+9yRZozsniNT2xdhpUexN/xwmwMZHKAlkgMhRTYQbTH08FGyq
         ZXcDKPevxQ1dycBtC9O4C7Ii0fW7CQnjPoXMCKZdQHhqoYvDtWvBGwI9e5mZUR0Z+O/h
         EnKWGxIZT6raP3RXbdPcF7j123UVqg7TODrixchXbNFNm5GogOvJ7nrlZms2r9WXrE7d
         8W+rh9uPbRMZXNuxLkrj139hYRrUPrvb8DGiEMaPhPnBz7Fnf6ktuKwUs4a4XT2iqt+T
         mcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538840; x=1726143640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uKqVutEytS68y9quKuA8oZ9AWLRXiVRK4dLthQdVgU=;
        b=SfGbP7jXFacrNf7OIqzocFZbduPApr+iHAO/7CQDNINVkizwBesrt8/i84p1eZDM8t
         FXkDHZ0YsQ3jKvfnsqmYRSa+iX3ZTnI11pOEY30XqDK7NY4JVlISAih/SqK8/v+2FVPm
         yIv3CYsm5x0KD75qbbinnAvJPog0XpCIXGhtRl0nTdjaDIMaY3w5Aur04w72yvKOhVzR
         5FRAy2W9kr19fH8bNW2hl2aNxKbvmczcdrgithrnowDm6XMpogD45/Kt6n1cGkVOzpH4
         B4SW7RnON7Y2e0JgV8pwhj/Lwu9fx3P+C4ACqmZ5TKzn1gA104qeFbKjB/0TxlPzSSAo
         er1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkd+XBT2KOqdOUP/hqjmd6/B4v65aetzry1gdPMYdirLKUKkzOnp2A3W33sdkX32+nAHBtuqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YynCixu81wLEgVsB8CB8UkU2KWCYh6pCw36zly8ZskObTz9GgZ4
	gwgfY4j+nFhoi2zpnoJ0ua2/cvGLRc0NbT2n9JVOq/jDi52C3hrv58A+Q+x56Jo=
X-Google-Smtp-Source: AGHT+IEOKn0KgBnBzHvt06ZjvD7i33x85kBR8d6T3GFgqKBVw9jPqK4PR1m+hESZeyZg9As9t+NRpQ==
X-Received: by 2002:a05:600c:a0b:b0:42a:a6b8:f09f with SMTP id 5b1f17b1804b1-42c9a38b296mr21564015e9.23.1725538839669;
        Thu, 05 Sep 2024 05:20:39 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e27364sm230390515e9.34.2024.09.05.05.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:20:38 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH 11/18] random32: Include <linux/prandom.h> instead of <linux/random.h>
Date: Thu,  5 Sep 2024 14:17:19 +0200
Message-ID: <20240905122020.872466-12-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905122020.872466-1-ubizjak@gmail.com>
References: <20240905122020.872466-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usage of pseudo-random functions requires inclusion of
<linux/prandom.h> header instead of <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
 lib/random32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/random32.c b/lib/random32.c
index 32060b852668..31fc2ca68856 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -36,7 +36,7 @@
 #include <linux/percpu.h>
 #include <linux/export.h>
 #include <linux/jiffies.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/sched.h>
 #include <linux/bitops.h>
 #include <linux/slab.h>
-- 
2.46.0


