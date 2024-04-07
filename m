Return-Path: <netdev+bounces-85540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C65FB89B323
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 18:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818D8282700
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 16:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B980834CDE;
	Sun,  7 Apr 2024 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYunhSJv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A1744C81
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712508004; cv=none; b=GpdOwCClT+xawZ6dR02Bf+5qz3P5LvJNXaat09yVoiqZcsvM2pcX9nBwHGsgHqYMsU4qJHpkv99SFJvZ+F+Vfr2WsxX4Whs0H8YWAYOHuxAcVWxOlwHZokq91veh2pQlrUHMRgSjOVTVH86JDOxmNNsDBYN6GHHs70pyiRoOlg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712508004; c=relaxed/simple;
	bh=Z3pz38jwqZkRChQKVMMZHTUD7p+LO3kdwTPhPXO/6b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJxCwGP/gcRNmisGF1RaSpSeo2lDBORJdlGlkALRbJnat7OVNRPX7FBg0mN829gI2dFzzSLg0kOxtYGRvcGE5hcwAu1GHIoLsJzNi761Mf5TfX1xNfejusPh3SKYIrlgih/o2AMfg9XcSrPEylEj9MaKd1r2lz1iGAfhQbHa1Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYunhSJv; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d6898bebso2148831e87.3
        for <netdev@vger.kernel.org>; Sun, 07 Apr 2024 09:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712508001; x=1713112801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3pz38jwqZkRChQKVMMZHTUD7p+LO3kdwTPhPXO/6b0=;
        b=EYunhSJvgwanJhn3pa1GqS5ZS80dXHmKqkWgt5ryigBVouZhErctoIxBQpK17mPjNy
         Q2kTo/M74v7JTVgWN7B1AL66O9/V2DmT8feLYb7GnATh54hTbvGVgPdftKFjx9p4V6G/
         a26LWNdvlswK9Y34HzlcKSKONdLFBzkv16YtRFRk5gcwOyyP3LtgR9Z4AreeQkBWKMCb
         CNqhckkTylM/tYVLJ8HbVv1vU+4FOyTmlqkzHYmITRMJH05ct6NG5jfPnAzDDkY484DA
         RfYP9XZNZ3HrpG/XdcCSyiITbXyisFGgLnKMU+rSiAwsqjcrxy5zWn5YKK83ccMpfnpd
         X+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712508001; x=1713112801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3pz38jwqZkRChQKVMMZHTUD7p+LO3kdwTPhPXO/6b0=;
        b=oD12EEvg4ZZcieMu2aRuyqPjYI7vW6f41vB1zrx/8tymJI2e2cOgEQ9nefjnin3tGA
         lD7rtBzGLp9p38iuPc4wKvMe17C7uvw4LwWps4u3fcOiMqqkrvCY+ymNd1HcQIAWAwW2
         WYf2RCjyAV/xJU3z6TWnmuFz/od1pEZrZDgy2bXfM0U83cnUnEGQ2FmIh9PnYY8xbgOD
         Baubw6SoazDoRCrvKQLPyDBEfk/OJxyiRLIVjOPRFlYjE2FCtRytjJNg3elB92W9F05e
         x7nwnLNcv0DiXODozXPCYr5YKeyBvByPA8Qc9ZmxzJHzZXc7qJEjWdfWkODbY3xukG08
         uqEw==
X-Gm-Message-State: AOJu0YyZlGDvfWikTmJuYwRb0XKQa350q78I2DRFNIWKVWps1R4+4B0z
	HUuHsod5fDA811jiTjodQUrFljFoWqR+uyeIFN5fpJn/01jhCOBf
X-Google-Smtp-Source: AGHT+IFI7/XLCUf8TcOA3D7qZjFd3NWN0xJ21xUOJwgz/t3BWsgZ4V2nl/aKfou7xkmWv+A/5DG2eg==
X-Received: by 2002:a05:6512:60f:b0:513:e17d:cf37 with SMTP id b15-20020a056512060f00b00513e17dcf37mr4293016lfe.19.1712508000829;
        Sun, 07 Apr 2024 09:40:00 -0700 (PDT)
Received: from rlozko-msi-laptop.arnhem.chello.nl (2001-1c08-0706-eb00-36b5-e2de-e148-7d13.cable.dynamic.v6.ziggo.nl. [2001:1c08:706:eb00:36b5:e2de:e148:7d13])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709064a8400b00a4663450fa9sm3304701eju.188.2024.04.07.09.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 09:39:59 -0700 (PDT)
From: vient <lozko.roma@gmail.com>
To: lukas@wunner.de
Cc: netdev@vger.kernel.org,
	hkallweit1@gmail.com
Subject: Re: Deadlock in pciehp on dock disconnect
Date: Sun,  7 Apr 2024 18:39:56 +0200
Message-ID: <20240407163956.8101-1-lozko.roma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZhBN9p1yOyciXkzw@wunner.de>
References: <ZhBN9p1yOyciXkzw@wunner.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Did not notice second version until testing the first one.
First one worked, no more hangups.


