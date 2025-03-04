Return-Path: <netdev+bounces-171505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A4EA4D433
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 08:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 032C47A83F2
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 07:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21D01F5435;
	Tue,  4 Mar 2025 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kFLca5Hb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF72C1C8633
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741071672; cv=none; b=QzZdJzXQouDvMcGtnSIfiPmYeBUa35ieyPq19uNXrmJ165mVsm6mPfVThBjyiWS3FDCTJD36dynjrZDg5+CEMcibYF1pbcnpuKaRFB2317xjCQYUIovkmQRL3aAJhtL1v1MVRYX4fB9hgq2zGX3X/sxFH27+u9dHUradLd2axpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741071672; c=relaxed/simple;
	bh=WeoK4O4lNVf1jf3RL4kog/vPaezBLPVB+yX+IBUebZs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WFwW5PnxnTnoMwCWxM+yX7pAWdmAPVgD5NINHzM272khDsVdfYVAc/T7CIiGd6Up+M24uT2jDSSPAtV9TlePnX9SBJf1Zhjxlc8EroofPPX0KApvaJ4992smR+GnKmHnlpVtzUldVgv6beYzkgGFzcq2ofqj16+GGDMNx0myCTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kFLca5Hb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac1f5157c90so66236066b.0
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 23:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741071668; x=1741676468; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YSdQFiVMCrS5O9/EkwHKFfamzvbURyk8m93xw+1w4DU=;
        b=kFLca5Hb30n3UWwFIlGhDXf1JnSJVCgZRapyX4U4p6xFm5XzpGBl29g+frv7oCXOc7
         ta2gpOe2KP5V1EPggK0a+7F6kmNbqFylwINo3CSM0bPka3+YDtOUO+/H7ASDh5Ybusva
         DRkowRgqE58lU/5kZWOCYTUARzc/hnwuvLuAWNhZa2TQ0RbiaT7++XaR7u/yEIMih9py
         rscFulH1qYeIpkY5Un8kYCytSCezAOBYT5W6m2l4pHgKAvG76nlSBLOOvsXoR5he7Cw5
         TSut2iecizCnAQton7W/GtOT/Qz0RwdHps1q0CJ5IPjmsxc4YFn5EeOKdrGEvKVD6C3O
         suvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741071668; x=1741676468;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSdQFiVMCrS5O9/EkwHKFfamzvbURyk8m93xw+1w4DU=;
        b=uNij0342FQFrCbWaxWi8e2Ki+dhX7UdbGPrI0WLuec8tIsdldhz5Jbq2XYTBibO6Rt
         v0R0Z0EOsac2iyzodjMZtcWEWLq7ygs+8fP3KB+uw1qctb568IqdBfXMwiByIxEtnHKx
         eGdIshMmbTSWV6xmzeVlkOHXF4twjDaSG0Fkg2kYCLTLQHsFbrVcyLm30o/A7+4yXcxf
         z7lILAyd8UV7/pntzVDEHWSlkxZqkdYrBQgTfs2XLcO3eKWyoqP9xPuBE9s/Vt7lo0o9
         qMLowAHgcK1ZFmvlvkTm3RvLvA6WKjZ52nroCRy+FmPanmSi1m/GOzKOkUWjOqiWVi9N
         68LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqFCVFq/cGGy0/eIBfrrK1WHT+Ags0TTJYLHQfKnXYCyL2LBvmfwZmklGazbVlgqXgXdZiiuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZqzNMd7EopRgf6GamxqgCsNWQ1n7QGdFlvC+JratmF6dPuDSQ
	yRRH3utwkT5CR9ZOi4N/Ivaq4E0SGqU8FDyooccWp+A6Shev0ZVxBrifliuqLNc=
X-Gm-Gg: ASbGncv1Ry11XngbMrNHsLgZTOF5i+2jMNnZc2gEajhR5RMITISe+HMtER4avUSZT/w
	Dovx+XlNN6ng+37kgSG+TcW8M9/WtwAwfRhcTkvSwURoLwYOZJwZPrdNz859GUu5ckqxB578JW9
	DuGPzC0yd91WEwK87i/A4Ltr/A3v/EHBrgwrwcm7eZwrZIv+5rz4ekAvE8JXgksdXqo3UbYgzOW
	yaS9fiNohdoJa1dj5F+/nsMvysiyxlHbawFEZl8DEl+6oUMmcJBv3Z5NwfOEQ/nIcqTgthiA76y
	aOX45hQooHGany+SCKJnrcwTebGMEogWHQidT1YbTi8VfENj/w==
X-Google-Smtp-Source: AGHT+IGxyBW63fSgEIDkdKmUigp27y49JS7UkTA+NZOY+d9+or8SnPNDX/CPFO1XI+oWKppLDaoD5Q==
X-Received: by 2002:a17:907:86a9:b0:abf:6424:79fa with SMTP id a640c23a62f3a-abf6424d073mr1083370966b.28.1741071668220;
        Mon, 03 Mar 2025 23:01:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf7981482csm286996066b.122.2025.03.03.23.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:01:07 -0800 (PST)
Date: Tue, 4 Mar 2025 10:01:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2 net-next] net: Silence use after free static checker
 warning
Message-ID: <Z8alMHz89jH3uPJ9@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The cpu_rmap_put() will call kfree() when the last reference is dropped.

Fortunately, this is not the the last reference so it won't free it
here.  Unfortunately, static checkers are not clever enough and they
still warn that this could lead to a use after free on the next line.
Flip these two statements around to silence the static checker false
positve.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9189c4a048d7..c102349e04ee 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7072,8 +7072,8 @@ void netif_napi_set_irq_locked(struct napi_struct *napi, int irq)
 put_rmap:
 #ifdef CONFIG_RFS_ACCEL
 	if (napi->dev->rx_cpu_rmap_auto) {
-		cpu_rmap_put(napi->dev->rx_cpu_rmap);
 		napi->dev->rx_cpu_rmap->obj[napi->napi_rmap_idx] = NULL;
+		cpu_rmap_put(napi->dev->rx_cpu_rmap);
 		napi->napi_rmap_idx = -1;
 	}
 #endif
-- 
2.47.2


