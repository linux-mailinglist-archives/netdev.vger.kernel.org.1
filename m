Return-Path: <netdev+bounces-171244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2770EA4C211
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 14:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F591894DB0
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2042C211A01;
	Mon,  3 Mar 2025 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hOVzupQt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF3B211491
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008732; cv=none; b=H3DsaldvHLrKbwmqzM5qaVeLZLXP7/l+kFdFY2F6xU39sjqh1+fMcThMuazwl0lw5xyomQ+O/rt3LyxVYqyh3P/kzDDUmT03NVFAkDXS0DrrjrceIRPbc8/I6TUCpvsFqh3+EwH2p5ZmsYZao32CvSmxZ8Z/rBfxpMnrM0cmRWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008732; c=relaxed/simple;
	bh=f4KgbabNGjONHwG30Wm13XBFWuB0JIZbPNxYH+LA8x8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lN7KIY0+tY8FrPfuNgoK6CVdS9yCcopsAwa4hwLnzQGxnTEOZ6u77QszVgWpRRUe95h7R13Pc397dRv7PWFXx9fI4a2dTrKYz4YKy9isAWflcD49kauKLXUM64186mLPDncZ20e2odHsgkR4bpn0jloFrwuvJHc+8Dj8T/RltOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=hOVzupQt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso28137945e9.3
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 05:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741008728; x=1741613528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WH+w/1iCTIf8vLffwkm/FsumvuklpQmEB01Cn2pDW1I=;
        b=hOVzupQthk+mphoQM4nVklhJ91eQDpadbTuNulnt8B/ZD1iAmNzKbE7Ri6/D4DcbSb
         avht7TVuisugbgbH+6/ZwOE52Rid+3j3GP1xJYocITcVFz/0gQ46VbKw6XKGUfDY+0BZ
         tQzlXgYUeAmSJLZzofRXFoMcqGi++0iFnsKSRt59046qzGJxz4Ky9jm6nZvHNddOWoo0
         UgfcxPb4lcSRX6p1fJYesI17Y8xbq1kkPucGUqORW248OeNcZaNEXUGo4m8mB3oFYudA
         AXQUlM92dY8ILOkiSPfY1deKmqQNcBqJjGhsJh96yfw7uzvkoIfc2MzYqIgVQ8FxqVaQ
         0qqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741008728; x=1741613528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WH+w/1iCTIf8vLffwkm/FsumvuklpQmEB01Cn2pDW1I=;
        b=pxTMZsr3VBRd7xCIHXF5vwSe7jy9zTZh0+6Kai4DKb767tnoToeh+lEC2/0K0YZC3Q
         YOq/VLAIi4o4PlguUrVQLqMJ8wswFcTXl7B4Cz1WJSm28HyUxA3ZfGyeH2xewpUKKT/G
         44thmwb/yHPR829rOx10x4DaWqn+f7fjDgF4nTfgfZ4kKfypPZ2YdmTjus5Cx3aZZMLO
         x0vIJkL8GlWpPCGIpXHhIXe5rfesL16qNeVHunlcqHe/puIeCfz1e9kAKIHxmkAKVhQC
         jB6wlaNsAyFVHdvZYcEIg/srLNf7XCGtWRAsSMCHTrk4W/4ejmx6+oyPCcgrK4cRpywO
         G+0Q==
X-Gm-Message-State: AOJu0YxjoVqX/744Knkr4tASJghw9iZFS6c64lNCw00zTiHOdRRxvnis
	n6sk/oGw24rWhJ1XYw09wQiU08KRQYeCqxfsiRtbz2P5GMHJ7L+wyKn9MA8Yywq5r5hM4W/n0Fb
	w
X-Gm-Gg: ASbGncsnLgwdrhAFaIaT7am8dLGYM7T34eme8rguisybUfA9bVZVeV7Q0ucz0XLuNQS
	ucmAHZh07bG1pZ6FRn1vUCBofjy7F7cfo5s4ELf8Dqko/hk9MTRP8c9bCMcD7CVhRA6lDrSVdh1
	sRJaAp/MOFx2XcSuCB0GnHyBqLQ8iDWy14oU1ZuZCu4cLJkVYZ4UA5MvzL1pVdosrrDpLY6BY5i
	Ib5oxBUgfPE+6yx3iKJBigzG33eZK8tiY4gqFiH9CFBKZ5ca2+jPAKX1oW1ncqwjtYozeLr3Xsr
	ZSySrmhzwjDvtJN9u1gWYdkxbbu15Ql0Ctg5Jf4=
X-Google-Smtp-Source: AGHT+IGIOD3MhIhuLqeDw05pYJAP/cSfl0SLTgWIv/TVjoRpzgP0UsNXqT8dBsqWJRosJMPudWrmhw==
X-Received: by 2002:a05:600c:1c93:b0:439:8a8c:d3ca with SMTP id 5b1f17b1804b1-43ba675afd9mr115322575e9.29.1741008727600;
        Mon, 03 Mar 2025 05:32:07 -0800 (PST)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7370372dsm157836365e9.11.2025.03.03.05.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:32:07 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch
Subject: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
Date: Mon,  3 Mar 2025 14:32:00 +0100
Message-ID: <20250303133200.1505-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Firmware version query is supported on the PFs. Due to this
following kernel warning log is observed:

[  188.590344] mlx5_core 0000:08:00.2: mlx5_fw_version_query:816:(pid 1453): fw query isn't supported by the FW

Fix it by restricting the query and devlink info to the PF.

Fixes: 8338d9378895 ("net/mlx5: Added devlink info callback")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 98d4306929f3..a2cf3e79693d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -46,6 +46,9 @@ mlx5_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 	u32 running_fw, stored_fw;
 	int err;
 
+	if (!mlx5_core_is_pf(dev))
+		return 0;
+
 	err = devlink_info_version_fixed_put(req, "fw.psid", dev->board_id);
 	if (err)
 		return err;
-- 
2.48.1


