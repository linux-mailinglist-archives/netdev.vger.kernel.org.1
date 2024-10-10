Return-Path: <netdev+bounces-134218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E022399871B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51E0CB21F90
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3652E1C7B83;
	Thu, 10 Oct 2024 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jKCxrhXS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AF229AF
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565614; cv=none; b=rPWWdgJQAWEWFqOJxrSiveOOHUPA/zki+ekIm1/V6bSTnFzjrutZPk3X9YLThTs9MzTtPM9Uil/owAlEUvFbJgsynDSIgkV0qxmWvheICHvZ+DYdH/joCrekKsdgfUQMy3vwQzUEr946M3cS59CTZGHb3WbPwjztsVAiNGjQt/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565614; c=relaxed/simple;
	bh=d5INnUKcgUn0dwvTkX/dqEX9RfcVNVspj4eCPFMh3n0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sM5JFS9tUBYmhfblEh8rB0DmKVQPcG3BFA2hHs6umyMu7uwJ6EkI3dsv3kwaZpPopaJ92cKvnoI1GroD66C2z8PnZwkBlpmy8kQHwySYzDgwkS4Z62Bz/v7vmLI621Nk1rtRZojdpWqgp/9gLqR5iRsQaXIkyAkgGhveGVvb5kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=jKCxrhXS; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9953bdc341so34344166b.2
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 06:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728565609; x=1729170409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T0d2PXqEa5F2DY6FLexbSxdeQb5ZxkE1hppbJXLmK8s=;
        b=jKCxrhXSNB+RekVwPWcooctowmxSuH5DQCE49UYL5hfBoNuY38rTknmpCZZbo2CMgD
         QkSxbvmLwDuihE7kpDVhtdYnVsnNLWP4XUpqMjUUSZ0CXxsRiZZQIH9/r1yNNC6vL9JW
         DpkqJBaxS32MFBtmKW2O/t4Lo66z16Qr9hIDcEGkeg/c3sVdiY5BeniM2JBgYFQ+TLWN
         2udj/Vei68Eii6sWkwL3SMHYhXWZW8890fvEt9KLTCuo95OywqeC9yGRZH4V2rZIdrDY
         sJGHG3Pt3J+gOpWz9KmI5UP0BKKKjHzVcOgxwXp8S5cqWTAubdAI30UNCSKBGfdRKy6T
         RT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565609; x=1729170409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0d2PXqEa5F2DY6FLexbSxdeQb5ZxkE1hppbJXLmK8s=;
        b=xVTCAchSNHXiWlgrRUosw4MOMkl3FsnN4pBgKTyXPpC1r/Si8ze2zWrRnT8qR7By+a
         d6IhMyubh2oLABMSgsVuk9QhOFcl76OItDu65T93ruNl4oNd7Q5fYTM8jqbA+f4v2fOh
         t3bNfCNUJCGfG1eKWHowpA8vRVHVeRgMtbLOGCKu19ix9cIiZb3aId62d/j7QvMj/ulu
         5kcKUzZwhUjIwD796e0vKdY0r/X9ORUpi+Q7Im1H1Aimgnj9exKEqNAv/Bmwin5+MEAV
         rYVM/M9mqZYDh69AHbLDQWSwxBB/F62w4r34uQG1NDgtCrSJaL6G9+5sA42eLweFQLqk
         hLhg==
X-Gm-Message-State: AOJu0Yyg3PL+ZxSkUnfE8FYanGcqCREb7zkdpqEzho5Jx50QDqRRLwrh
	dqSzk6Lx+1nifGpqDEUMtxpgTEaOViTymLzepF6fbWkmtf1VxN9wOMFumBvoeuKGLlkj6DJfkLj
	FDoejRg==
X-Google-Smtp-Source: AGHT+IGqVj1sAXBoKXfwTCDqcLD8FDo5ypilIMX6rnjEPBcYAoEA55hMOyYPSFS2kNXH8n/jwXliZw==
X-Received: by 2002:a17:907:6e92:b0:a99:529d:81ae with SMTP id a640c23a62f3a-a998d348518mr471037766b.55.1728565609279;
        Thu, 10 Oct 2024 06:06:49 -0700 (PDT)
Received: from localhost ([37.48.49.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dc700sm86334466b.158.2024.10.10.06.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:06:48 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com
Subject: [PATCH net-next v2 0/2] dpll: expose clock quality level
Date: Thu, 10 Oct 2024 15:06:44 +0200
Message-ID: <20241010130646.399365-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Some device driver might know the quality of the clock it is running.
In order to expose the information to the user, introduce new netlink
attribute and dpll device op. Implement the op in mlx5 driver.

Example:
$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml --dump device-get
[{'clock-id': 540663412652420550,
  'clock-quality-level': 'itu-eeec',      <<<<<<<<<<<<<<<<<<<<<<<<<<
  'id': 0,
  'lock-status': 'unlocked',
  'lock-status-error': 'none',
  'mode': 'manual',
  'mode-supported': ['manual'],
  'module-name': 'mlx5_dpll',
  'type': 'eec'}]

---
v1->v2:
- extended quality enum documentation
- added "itu" prefix to the enum values

Jiri Pirko (2):
  dpll: add clock quality level attribute and op
  net/mlx5: DPLL, Add clock quality level op implementation

 Documentation/netlink/specs/dpll.yaml         | 32 ++++++++
 drivers/dpll/dpll_netlink.c                   | 22 +++++
 .../net/ethernet/mellanox/mlx5/core/dpll.c    | 82 +++++++++++++++++++
 include/linux/dpll.h                          |  4 +
 include/uapi/linux/dpll.h                     | 23 ++++++
 5 files changed, 163 insertions(+)

-- 
2.46.1


