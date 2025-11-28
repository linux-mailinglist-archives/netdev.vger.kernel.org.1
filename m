Return-Path: <netdev+bounces-242609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 083B2C92D00
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 18:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631853AA78F
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 17:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AB433344F;
	Fri, 28 Nov 2025 17:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFcoUDTj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BFF1FC8
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764351540; cv=none; b=uYbvyNvu41DNnNHOi9sh12cfr15455Pqx1JW2NV2Akzol5MuimGyvTJPOA8NjRwR4FRI3kQYQrYeaafL53dMBZtUf4vNxPPs/0OmCoVzeFWoz5GJeVdpCnJNdYGE/pkzJqXG9yDRCbiBiI/Su3/xB+iU4KUE6KaNoTVUHrA3QlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764351540; c=relaxed/simple;
	bh=QUnXh9qGetYUOjtOOcXn3XHKSE/rNqBL6HF7oEFfcz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=el3Y0PfUPpr20XE8kkkI3fLMNUKU4hFesqcxzp0i9UV1DmzR2FfzUrCv5yljR5g2fxoqgrp0eVz2jGBf1O73coNOa5OvDqVGTdQVTGRSl4Gj9g9tyH5VUQvTjijPlosL9vWXQsXT7D2bid1WVhFMfVKibkSEUCv0iAskFWVvFL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFcoUDTj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477563e28a3so14695455e9.1
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 09:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764351536; x=1764956336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xjEu74j7ESkiTPga1dBh7HPK92+GF0ak6Eb0e4LqHbI=;
        b=OFcoUDTjIavuLVQ3rwAh/RgglkZdsUkZEV5lWeMzidvVC6ESKxeN9IX1O/Lo6j2nLu
         euUFL1uen2TxGDuMm2xS8GcFsBXo1Dh0BHoEzEIFvtAUwbXSCTchW87ynCm7JTaqBOr9
         RFQq/qlEvZKwHAeSKccSPGQYzM8Cgg4aRNUy9Imuu9jzyjDyNiWGnNhtPJ5VjueTYPyI
         oq15K4ZSznkyY+w972xnxGm3mytai1bRfL94lJv2F1Y6+3gyNX9NMh2+nYv8spYgrXlr
         KHYAPE0sjps54HKpYoJ8CElSxxQ0MuUmNN7u+0h8VxJR3P/5Fx7tM85Xh+6LolFXhTRP
         EJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764351536; x=1764956336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjEu74j7ESkiTPga1dBh7HPK92+GF0ak6Eb0e4LqHbI=;
        b=E9r9AjlH6iTBk0M5ceRByrEebOy8g8ACNSTLrlmcbLT/UsSRuZ1+ZJx4eGK8SZlSbS
         kJOsgfirKgqfPNlXcXmvRVKc4YJO3peXF+WXqlDkvW29GH6262IhZ2xW4AG1JYmBOENI
         feJdR/mlXrWsptdimWOgd9rWcDU9ouaKmEdpYdf2BdpgYXfbbsnifSgcA1IeDUyqWk8K
         fPdCfquRb7lv0A06qAGqaXjO+9sk3ekXxQ4rCK/9kUdTRiS4DtE5czsGaH1L6ki6MgW/
         E3WGG0zZWK46quRYW+NSOkxacLqJ5rhNJi7juT/j9dwDqhJbzoOdBo9/IuWhO00zxSfY
         Bo7g==
X-Forwarded-Encrypted: i=1; AJvYcCWDIFu8wIrvZz23QUfWHHVpAEApi+L5KGptvpDVFdwqXx83wkFAzrYwyeu7aSYUwyUarBGLSg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6hxJi7zSrNbNE5W9SXCYP4l4ThvsfTzteLRR32a/ebGbUFalD
	GRYVgxCjz1GjW/6erwYkvkHDb0TaM6+gW8DUqwQE8wNMB9K7mm1EPPtc
X-Gm-Gg: ASbGncvwM34gLovNZXn7+Md0xb4V73DQWpABBhst0WA/EgqS2FilRLwTEt5hhIH0AVS
	5dsAZOLFV5vk/BEVFF1RmxNtIeeQmywdhZ3hZpH5ooAeS310H5YtKU6dO58qiIavcBQqA8eE6dq
	eb96wZLZhBW02LLVzf4qWnrVvsuV0r8Gu3ApP5p64zxPtwDwT1Qm/I4vlXS240ZJaqxYNWedeb5
	LJmjWWw9iFAnag8TBo87L1M8h/7ouOprGZWSege87js/6rNF3pXLIWPujzR54jeMHYYLCmNk+1n
	aIMraLIZ7aReCK5zkpGcnauRso5NxXlqfNtKrXlLQhMJQHl5W8bix3IlKPQv6mhXkMtdY2yL1y2
	NXEBoumNjARJ48oXdVZPJUbpgcLSkQ19bPym+muNktUFjxtNge9G4Co6UuO9gn5m4kNLyCF8ynl
	8ouSK+STg210+XL4GO0Fn2
X-Google-Smtp-Source: AGHT+IFfI8+LhNUchm6lNdP3OTNYYfpmwebmq+D8mt8pAS1EWBIP+ZRllpr/kZ9Vk7Z8yD9n85j8lg==
X-Received: by 2002:a05:600d:17:b0:477:9cec:c83e with SMTP id 5b1f17b1804b1-477b9ea35b6mr255404735e9.1.1764351536093;
        Fri, 28 Nov 2025 09:38:56 -0800 (PST)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4791163e3dasm96851735e9.11.2025.11.28.09.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 09:38:55 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ynl: samples: Fix spelling mistake "failedq" -> "failed"
Date: Fri, 28 Nov 2025 17:38:02 +0000
Message-ID: <20251128173802.318520-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in an error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/net/ynl/samples/tc-filter-add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/samples/tc-filter-add.c b/tools/net/ynl/samples/tc-filter-add.c
index 1f9cd3f62df6..97871e9e9edc 100644
--- a/tools/net/ynl/samples/tc-filter-add.c
+++ b/tools/net/ynl/samples/tc-filter-add.c
@@ -207,7 +207,7 @@ static int tc_filter_del(struct ynl_sock *ys, int ifi)
 
 	req = tc_deltfilter_req_alloc();
 	if (!req) {
-		fprintf(stderr, "tc_deltfilter_req_alloc failedq\n");
+		fprintf(stderr, "tc_deltfilter_req_alloc failed\n");
 		return -1;
 	}
 	memset(req, 0, sizeof(*req));
-- 
2.51.0


