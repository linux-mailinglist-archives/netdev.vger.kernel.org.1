Return-Path: <netdev+bounces-73749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 359A585E204
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6210A1C244A4
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90CF811FF;
	Wed, 21 Feb 2024 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="A9XUZnpi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C2E8121A
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530869; cv=none; b=C3Kt6+XQG5ZRHMb3bjGWN/8KNMTUnwFqwiCU37Tp2BSTpsvO83YugPXeM+AKNqb0NIGv7lBJ+fu9LBVnrabRY3vj+ptcYNegbZuCt6j9Dzbd4ZLAgJVV5LrQss67PRM5ZR4aODurFSzoxY7WKJBwjNx9i0wEdR4vegBy6IDCMrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530869; c=relaxed/simple;
	bh=O+aq8a5ceJTd/FaDjAHD7wHhU59iT5y1rwcLzh2IAvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6P0vq2gxv+p8jrgDASBUR9OjdFy9UbkVhLaN7p7HSSiicNDFAnQGztCVnUqrAFTsrWhPbkEt1BAGwuSV6bylHKkLLwx85SzUIp9SIhDI8pdC1VyuOiZ/cX4p49JVhW8IuYScqsgOT1g4giEmur49bAWESW/b6V5uBDPJtVP9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=A9XUZnpi; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d26da3e15so2972609f8f.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 07:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708530858; x=1709135658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qpZY8+ihvYkY3PuoF5Mv6rfPsZc34NG30IyNAi4E5mw=;
        b=A9XUZnpijBMeNrUwkEvjokn7nZ47fYb5uwfSnBpx4MzLUQ4X3g0YU4KWIwondgV0Tz
         ZquWCqJHRql3nsA2T/ya5YqBTDw9xKh7rABv8lZMgtBTuPfX1JOcRgiRDdv28JAmqQ+z
         FdA0pEcZycrzHNO3doq0WjdoHE1crRzvO3/sdUX8lm2c/3bXpBvCIM3lrxEUHnQfOAcT
         KsKPoKFxCOmWQ6luyWjNe80ULEOCJpJ9sENK0/7ikXu49t6QYtca5CErJayROgHUtgQt
         tdfIKYF1xqbU80nzUG3r2iqfCe7rEx3XO83Mw5fO+wEIWKwSNLsjfmzyJOsuYf/dmDeJ
         b7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530858; x=1709135658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpZY8+ihvYkY3PuoF5Mv6rfPsZc34NG30IyNAi4E5mw=;
        b=NcZ1bA+OhtEtIKgbT940d40cHTv9EO4DiFWx2qoE2as08RYyFDJ67O8DGhtSHNY3v4
         3BhYebPdE577QZvelLSFIvO7U/j5qRluA3FW9Ll8E8TrzDM6byknbw+aYaaW47Rr8KPv
         NCfAvHyZAbHRGWlj6JtweJHgD42KLynjr7oi+ramWs9blJs17YA+zISaR3PzwWsfNPIc
         hDBhzGrTssyRmxKgQABd1UZp2cfEXYoQuLRfiRXY4TSiNKwHnIGI2NJ1gP6+XEUnM72f
         M43gVpDSXZtXEjjDqHHMHKCvinS/O0Qk7X/cR+l1TwJJrUhgLhihDwKpP1KAccLxnMWI
         YprA==
X-Gm-Message-State: AOJu0Ywd2Uang3k/qCKblFZQ96Dg+FA4J1FfSwdhy8yUmgoIFRft+YxV
	zkoR/TbiHSIcY4H4AfJzuA7eXxvBGKb9TBcFKH6TLTCcXSbMdSVy3Auq83hMGXkkJx+6lLCbIuv
	5
X-Google-Smtp-Source: AGHT+IGZqHucnecGfNo85ED8mJXjBKB4/STjY3Woyq0Cs92WKpt3s6qiPFQT2lMqBJqR+lsoaNE9Eg==
X-Received: by 2002:adf:e508:0:b0:33d:61c7:9b2c with SMTP id j8-20020adfe508000000b0033d61c79b2cmr6109570wrm.34.1708530858230;
        Wed, 21 Feb 2024 07:54:18 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id d2-20020adfef82000000b0033b75b39aebsm17318127wro.11.2024.02.21.07.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:54:17 -0800 (PST)
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
Subject: [patch net-next v2 0/3] tools: ynl: couple of cmdline enhancements
Date: Wed, 21 Feb 2024 16:54:12 +0100
Message-ID: <20240221155415.158174-1-jiri@resnulli.us>
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
v1->v2:
- only first 3 patches left, the rest it cut out
- see changelog of individual patches

Jiri Pirko (3):
  tools: ynl: allow user to specify flag attr with bool values
  tools: ynl: process all scalar types encoding in single elif statement
  tools: ynl: allow user to pass enum string instead of scalar value

 tools/net/ynl/lib/ynl.py | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

-- 
2.43.2


