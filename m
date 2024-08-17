Return-Path: <netdev+bounces-119384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBFC9555E8
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 08:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704251C21326
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 06:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB994136E01;
	Sat, 17 Aug 2024 06:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hy4ZgiM/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018E512F38B
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 06:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877574; cv=none; b=LN9gbAqPFtsc5Wb6smueBgO71lv9/x8qXfcjnk+UQhArNTjqBKJX0Ts/w7rJHwafbUYiZ+r7dxOAvv9TO4S/mVJjq+FW48qBnjjSupRQ8Vb/dEKrh0o7Zgl6+T+u1dUzNRgyaTdgcxj1bsJpCFRM/iuwyPBjrrK6fr6pL3rTF1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877574; c=relaxed/simple;
	bh=CzHStjjH4V8sPZdoqAFqWMk+oxPdeCbL03cvp8dl/zc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GEDaiuownivrOHf1oFzUwi+8sz6x8u+OD+wBFTIk7+Sjx96CetkHmJqk7vniVVceZzb2g6bC3BojkXpMCn8OnNQM36cxQ9wpLpgvVUuKV4piE+wN29Vv8JBBYxa06ej04Q8nV59by5Yri/CwhGvZ8J4w0+b2q8z6eicVDolSZl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hy4ZgiM/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso27168465e9.3
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 23:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723877571; x=1724482371; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iayHuQdCGfrgLfhcreNqaNDx16C6Jh397QJm/SbJkWE=;
        b=hy4ZgiM/2D0kvCmQzX7EY6f74I182NKLsECGGQJxHlvdy/DiTjhAY1BYU9CXOFTQfB
         YRvoRp6b2wWvjIVI1hsZ/sRefkQO9Vk6TisKbMMf6XwMSq1blf26mkVDyF3KSUcDB865
         JMFhJQZ6+Yofnr50vk1SgeMlK7+LtixjxtNWLAbYaIxeXvxRAKiUnfUDb85b022Kaba4
         p9fpSO2gT1yKwuKeYnqiV+zGR0ZMSb7bPUjZ4k7a7K2ZxiDrPeOhD5zG6+shEi+bygJM
         LhWhSILjTvc797JrZh8yvQ0FrwPmEJXnWAqHbzROMPI15BhPG+8ldIXqKk93Q7Djv8qb
         yGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723877571; x=1724482371;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iayHuQdCGfrgLfhcreNqaNDx16C6Jh397QJm/SbJkWE=;
        b=U2/TJ0DgfZ+VpEK8sWcU/w5psnllRl7MCtVV3A6wqjF5A2V1u6fQSbsRdKqhb+FFS0
         Gqhd366mg2cEXknOZY6uUiq2Hv/61mJOCoQZkRBzc+Qi1bXXVeGePPulKq56WUWAxJQp
         UFqHOZpDWOfe8RNQBVF+WsaN88U/781eFptPAnjDdXfYDLVAl86UE2GORFpbxjsVO3bB
         2RKX69/cBKtCE3FeXg8TE6788jIxFEit2k2QGRogvYon7wmyR82szfaMwau+0IO/TqNw
         FbFH3kaNAoNj+33nfJsSw32z6xDaHi0BLNVBvKRcfUvh5bXDzDR7HREQozE9g9mXScMI
         7JzA==
X-Forwarded-Encrypted: i=1; AJvYcCVOXAN/jAXvvWzRXs+fPaNj51i/mJUA9i+qMss6O/5PT8+ussXYyx9EwxvdYFDyt6ZALAyqmzI4CsuKgy8Kb4skmw4ARkqJ
X-Gm-Message-State: AOJu0YzNNdnHzBneUjmQpMMUvlYBXJKAcPjgpuYFiIPqEuehWUZMNwYd
	mPP6QjiRIgJFwhGltY9JDfHaHE46vM9nkYA11umH1u4kPKZz/nVG/+XOUqxmtB8=
X-Google-Smtp-Source: AGHT+IFNIXj9oV9+Ox0dNnq+TrIQ0ML3idpxQu8xxGwKVDp40dG1KGsNY1LaeHzxO7S57gOvqrDEzQ==
X-Received: by 2002:a5d:5545:0:b0:366:ee01:30d6 with SMTP id ffacd0b85a97d-3719469ff15mr3757080f8f.49.1723877571207;
        Fri, 16 Aug 2024 23:52:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898ab855sm5141246f8f.105.2024.08.16.23.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 23:52:50 -0700 (PDT)
Date: Sat, 17 Aug 2024 09:52:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] dpaa2-switch: Fix error checking in
 dpaa2_switch_seed_bp()
Message-ID: <eec27f30-b43f-42b6-b8ee-04a6f83423b6@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The dpaa2_switch_add_bufs() function returns the number of bufs that it
was able to add.  It returns BUFS_PER_CMD (7) for complete success or a
smaller number if there are not enough pages available.  However, the
error checking is looking at the total number of bufs instead of the
number which were added on this iteration.  Thus the error checking
only works correctly for the first iteration through the loop and
subsequent iterations are always counted as a success.

Fix this by checking only the bufs added in the current iteration.

Fixes: 0b1b71370458 ("staging: dpaa2-switch: handle Rx path on control interface")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From reviewing the code.  Not tested.
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index a71f848adc05..a293b08f36d4 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2638,13 +2638,14 @@ static int dpaa2_switch_refill_bp(struct ethsw_core *ethsw)
 
 static int dpaa2_switch_seed_bp(struct ethsw_core *ethsw)
 {
-	int *count, i;
+	int *count, ret, i;
 
 	for (i = 0; i < DPAA2_ETHSW_NUM_BUFS; i += BUFS_PER_CMD) {
+		ret = dpaa2_switch_add_bufs(ethsw, ethsw->bpid);
 		count = &ethsw->buf_count;
-		*count += dpaa2_switch_add_bufs(ethsw, ethsw->bpid);
+		*count += ret;
 
-		if (unlikely(*count < BUFS_PER_CMD))
+		if (unlikely(ret < BUFS_PER_CMD))
 			return -ENOMEM;
 	}
 
-- 
2.43.0


