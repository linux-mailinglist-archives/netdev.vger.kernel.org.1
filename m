Return-Path: <netdev+bounces-51658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1E37FB9B9
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 12:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9B71C21429
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2494F893;
	Tue, 28 Nov 2023 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="AWwnA3sv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0952D59
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 03:53:00 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54b7ef7f4d5so2348529a12.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 03:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701172379; x=1701777179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw+m6CFKiuP2LUdst29B2QrGUSKYe0PfmKWYdtVxuZI=;
        b=AWwnA3sv5kMbRt+do9FmPRyMCMnYQremLEyvgQNNIrCau3E5srBDYTj7CocNb8Pqlj
         YB1UyAIi9fS+wmz4X9Ha/eLifMsQwYY/YPrTsquAh8XxkGLXCxSH+VOSxZwOK0V1RP6l
         5XG2ESZADXDEMpvKr8RpmmYVEeGVBFsV6UcYVA9cAWrMKZmI4N2la5GXS30gbG19eCKT
         518Em8znyvfteuik3Do/wnNzb7s+dCSpEm5N89wqAlu0qU3SlPL1M1h5bb2MK6UwhFX3
         H2eTVQaqdE46WEy9nn7tOSwhC8Vj3kJSUx0n3W33zZZ0/5sBQ3CYASuJ85g+DqLu04ZI
         Jyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701172379; x=1701777179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qw+m6CFKiuP2LUdst29B2QrGUSKYe0PfmKWYdtVxuZI=;
        b=NxsYvLfZGzoFu1LaFWHO8tadnlAFUR4eqXB+ZnkxtfDQdOqChVuiOsLcxHpgWfPAB5
         4wdrqhumAfLahkpec6FkYK72otghBSWvSRAq1SvvnGp1gzO67egBekDvUjHlq0kFLByT
         VlUGzHYZd85wDeSTPWlkCM3i2nOzOJO0n4pE8Db7d7pWqIQRjbW/00tzcu825c+hqb+P
         9CbPl5dX3JcZOhFQdtkBRME3qhph6jsqAkHabeaVadPAzBGRtvuO8K5kttPlfgFmvAC4
         aGRQH9PIRzyfJzn7UUMAFQFT1TnfRfm92nlzgrmCZJL9aYPYC5rC2szo2eiGIOhzNwOJ
         V4KQ==
X-Gm-Message-State: AOJu0Yx+Ak/dlUfhGsH4tqgf4eQls+Xq32LE7ihCzRrgoGegiP0Pwqg5
	dey/FLbsmVyRuVhPbScmokUtA/xNnQBF6tTCtmyz7g==
X-Google-Smtp-Source: AGHT+IFzlVdU3T4UMtg9tMWkCt8o8bpI+xqIeawq8azmYeVdyrdDyiyZmUzGbRkFRK6r5mau+ZcleA==
X-Received: by 2002:a17:906:5299:b0:a00:8706:c82e with SMTP id c25-20020a170906529900b00a008706c82emr11714351ejm.18.1701172379066;
        Tue, 28 Nov 2023 03:52:59 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j24-20020a170906411800b009a193a5acffsm6743485ejk.121.2023.11.28.03.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 03:52:58 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	corbet@lwn.net,
	sachin.bahadur@intel.com,
	przemyslaw.kitszel@intel.com
Subject: [patch net-next 1/2] Documentation: devlink: extend reload-reinit description
Date: Tue, 28 Nov 2023 12:52:54 +0100
Message-ID: <20231128115255.773377-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128115255.773377-1-jiri@resnulli.us>
References: <20231128115255.773377-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Be more explicit about devlink entities that may stay and that have to
be removed during reload reinit action.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/networking/devlink/devlink-reload.rst | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/devlink/devlink-reload.rst b/Documentation/networking/devlink/devlink-reload.rst
index 505d22da027d..2fb0269b2054 100644
--- a/Documentation/networking/devlink/devlink-reload.rst
+++ b/Documentation/networking/devlink/devlink-reload.rst
@@ -22,8 +22,17 @@ By default ``driver_reinit`` action is selected.
    * - ``driver-reinit``
      - Devlink driver entities re-initialization, including applying
        new values to devlink entities which are used during driver
-       load such as ``devlink-params`` in configuration mode
-       ``driverinit`` or ``devlink-resources``
+       load which are:
+
+       * ``devlink-params`` in configuration mode ``driverinit``
+       * ``devlink-resources``
+
+       Other devlink entities may stay over the re-initialization:
+
+       * ``devlink-health-reporter``
+       * ``devlink-region``
+
+       The rest of the devlink entities have to be removed and readded.
    * - ``fw_activate``
      - Firmware activate. Activates new firmware if such image is stored and
        pending activation. If no limitation specified this action may involve
-- 
2.41.0


