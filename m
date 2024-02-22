Return-Path: <netdev+bounces-74015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745C185FA18
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36378289B58
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C326135A67;
	Thu, 22 Feb 2024 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="D5FIH6wk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31FE12FB02
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609438; cv=none; b=nx9iX5ZUN4gGiAYEV5nYnZ17Dmv99WuHmuNJO0opbCHu08gPsMegw5J3VTPseLyuO235CwdHyA9k3faeo7sFmE0uS4rBBsePe2Bx43gzjLr3bU1NVb8OWp2Z+vEQRnsPKGR0GwP+QneJj5ebIkEYm41x/pafAdofFRM/cGkuUJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609438; c=relaxed/simple;
	bh=A4OYpK+eG/eAJG+2hchb1OA3Sv1dNtGrm9AyFtEpSSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jh31ZZhBpVNRJK/wl8rNyQo55eduP5xF07efYFbZ4JPZ1twcxT0UwomLqfsK7F+ECq9ReVa6ux5St1S0QWqZrVeJ86IcJz6YPB7v7gp0zNXyVqPRk9e4x3Nu0X8khyiCOQOoGv6bBa6J5RhmH4mTUExwHjJ6Xd9HzUI8Dt+d+BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=D5FIH6wk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d01faf711so5114100f8f.1
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 05:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708609435; x=1709214235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qUdJ4md6vPCvQUMnBcR0t3fXzWbsP5pBGc3JT8+Enao=;
        b=D5FIH6wksHaJmSu6O+y0B0OnjbA51KuSfuvOD2ykq5d/Vx4s4/lZctoK7JrEdcTLK/
         vaLN+BLptzLeSR16EyT0abd2U0N8vmlD+LrGqJCNqJgh8NUt96wA3Fq2EW/ONBv8pzGl
         6J32L+CG5S39jajQ4NSOpJrQRrPg3GOGxglQSDH9QrWQ29NDns8r0Rvirjt6L5jsfQwW
         xvth3iZRJiz75sQTKT+WCaYoWZ66ujkCr05ChR5f2uPfZCB9iruz5YlCBUrvHQ0mPKaN
         b08SsZZqJ9duXkXGvAO6YszEazcuNC54IxKNAkH2ZnrxhL2TooB5FqUhNxpIjW8X6RzB
         7Xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708609435; x=1709214235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUdJ4md6vPCvQUMnBcR0t3fXzWbsP5pBGc3JT8+Enao=;
        b=NkqR3Uo1nFfRraes+YNdhKxCyYeQryyUTSBAvSG/+bioG89OPGSa+iZUFIVnfBJ9lE
         NOEPca7Zr/wDD02TZksbCRjED5aieZsbxPEIRx5QKII2z64H4aJw5I35Frtm9Tqh8E8u
         tOy81QBS0VVqeZzmZQQBEjiPk1eK8GNl9xOCvv2dKwFUI9mYRI9KA32EpgPgVzp13jnx
         pt5j+2lTDx76c+yOny9DK6ABnkHLAL1hp8Iz7XlMkPogBk65qdeYQYJJQavEhDz38Wh5
         eFeZKL4HolKRru2TaB86KzjIspEavuyVJ5E5l4WjwB3MswnuMHbjcV4UQcwTlksSinw+
         9Unw==
X-Gm-Message-State: AOJu0YxVbOnqZPODOKXtDPmYwey7IkpkcHFK2AHlkJ9MmN+wj/0yFwY6
	te8P5Ocu2vjkEmHVXgj9jt6N0sbcxgc6YmUX210M9vubrtZxT0W0Am9+ewnbQ39+P9XCgDo7MJz
	/
X-Google-Smtp-Source: AGHT+IHKEW3VnDAwvpmQhdkCb3CWOWOKcxv1G0wJxdSC6Lsmm1tBKMV0+e3FBGAZxnrFFZ4kn9EJsA==
X-Received: by 2002:a5d:5f4f:0:b0:33d:2154:960f with SMTP id cm15-20020a5d5f4f000000b0033d2154960fmr17787036wrb.23.1708609434745;
        Thu, 22 Feb 2024 05:43:54 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d420e000000b0033d282c7537sm17828396wrq.23.2024.02.22.05.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:43:54 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	lorenzo@kernel.org,
	alessandromarcolini99@gmail.com
Subject: [patch net-next v3 0/3] tools: ynl: couple of cmdline enhancements
Date: Thu, 22 Feb 2024 14:43:48 +0100
Message-ID: <20240222134351.224704-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

This is part of the original "netlink: specs: devlink: add the rest of
missing attribute definitions" set which was rejected [1]. These three
patches enhances the cmdline user comfort, allowing to pass flag
attribute with bool values and enum names instead of scalars.

[1] https://lore.kernel.org/all/20240220181004.639af931@kernel.org/

---
v2->v3:
- see changelog of individual patches (1,3)
v1->v2:
- only first 3 patches left, the rest it cut out
- see changelog of individual patches

Jiri Pirko (3):
  tools: ynl: allow user to specify flag attr with bool values
  tools: ynl: process all scalar types encoding in single elif statement
  tools: ynl: allow user to pass enum string instead of scalar value

 tools/net/ynl/lib/ynl.py | 43 +++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

-- 
2.43.2


