Return-Path: <netdev+bounces-51657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C724C7FB9B8
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 12:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50661C2118F
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716F24F88D;
	Tue, 28 Nov 2023 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rLNYPgYr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214CDD5B
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 03:52:59 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a06e59384b6so684114666b.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 03:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701172377; x=1701777177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LJrWe358mK58kVo7CaN547zoZT1GFXJuf0FS9nGOahA=;
        b=rLNYPgYrE9/JL4f6SV+nLiu1RnD7FQQPyYNsTMhYHk7LtvGAWsztLM2u3+ysP4Ds/J
         ic3EFqdQPgTqosW7MPwtZ4ljJt5N5kCUHi050ZsgxY7C2aDwN505tP8jH4snYCZwo6sV
         XJqivctpmsv3LzF/Zonq62zw33h9CwA4KxSBmj92/IBL26txmGX50hscrxQtyqmdpFmo
         CjbSDJFucIxzJ3HJmwc+l9RJ14a+bHD7iDxgwEMIgfYvhjA4pGveIeBzbdY1M/psGMlV
         S16Z6WghujdYzQ5odKBOZmt2KtbYjGsMKtc/8Z+DCS9qGi9elrsmqXGHdDR4vTOdE+G0
         1bIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701172377; x=1701777177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJrWe358mK58kVo7CaN547zoZT1GFXJuf0FS9nGOahA=;
        b=imkj0G4fZs/6EtzHkFPy5uMEYItF1RQCbc39ZIw4KOqqKxowQhVK19GXMED5YXtREV
         nidY4kMAJNSauM3zbAF+GKzyYJgQe14I51x0L8QYTYlXinv4HBxKxxoHPY7oTjJP9gwo
         GpEiBBv+erDcN3voDxByHOyLFchTg3IdPTswXjvwa7UKl07NMatTG7ydba5dfIhfMQ4e
         5cU2FD99+RCOzzUFGHeObmfwNBrbzHckQ82yw135JY7HBBz7Q5q2Pt6ITDGoyrMMYqBx
         am09lcukc6Ii9UXG5WsqxYzaRX6GB7KQCHa+g6kMGCqnThkEAzgOxm1+FeC6W46PKxOn
         2NFQ==
X-Gm-Message-State: AOJu0YzKVqjfiXzoJXr3+Z6ILj2ceuT4NNRnwMIK1TmFKalHED/ApDNH
	iqLtWebSF+OxeiLZZ+/NI/0HMQv/X9xO9x13sRBJAg==
X-Google-Smtp-Source: AGHT+IE4SH2Duwa1v85wArd5yshIjNW1kNpYIzZluIkzU+5rkuhbpjGh7YdOCS1hhCh0o5ZF5AnQtA==
X-Received: by 2002:a17:907:1608:b0:a10:9722:97d3 with SMTP id cw8-20020a170907160800b00a10972297d3mr3909629ejd.0.1701172377473;
        Tue, 28 Nov 2023 03:52:57 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id hz19-20020a1709072cf300b009a168ab6ee2sm6682784ejc.164.2023.11.28.03.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 03:52:56 -0800 (PST)
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
Subject: [patch net-next 0/2] devlink: warn about existing entities during reload-reinit
Date: Tue, 28 Nov 2023 12:52:53 +0100
Message-ID: <20231128115255.773377-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Recently there has been a couple of attempts from drivers to block
devlink reload in certain situations. Turned out, the drivers do not
properly tear down ports and related netdevs during reload.

To address this, add couple of checks to be done during devlink reload
reinit action. Also, extend documentation to be more explicit.

Jiri Pirko (2):
  Documentation: devlink: extend reload-reinit description
  devlink: warn about existing entities during reload-reinit

 .../networking/devlink/devlink-reload.rst        | 13 +++++++++++--
 net/devlink/dev.c                                | 16 +++++++++++++++-
 2 files changed, 26 insertions(+), 3 deletions(-)

-- 
2.41.0


