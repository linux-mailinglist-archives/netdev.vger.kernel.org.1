Return-Path: <netdev+bounces-140285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1DB9B5D69
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 09:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2161C20A94
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 08:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638031DE8B9;
	Wed, 30 Oct 2024 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gsovIrdx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877FF1990B3
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730275927; cv=none; b=dWgPtiUYCNZ/cxuSWvlZUN2cYrThL1CCk68SnOWQP97J1HQ/cX17Gx9DhjomcwM5ccyWl90aAAlvabiiOWx4iM6v/53LvSTda5SLTE9AIfGkIg5tQF1Ef4VEKfJqErruMY/oJFhLaQ52nwndBnrUdJaxBWzAbNGcrat2JM02Me4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730275927; c=relaxed/simple;
	bh=bhYYpNIHp/3ESkMMj8yoB+Jyi/GOqbq4Qvp5F9L5EiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qLzIslluYqY7nmIKZY4eTS0XxQOiJ8QL9b8KVwto3GJ3ydRnuIA+4ifvgI44OKYRhRDkz0AClvER3/LOchrqWRX+Gr/sQwDJWS55Tg+hV68IUhm1Iff32YpFsy+QtUyI1ZlJnSRNImvXkQPN48HeP0b5zYf3zkm3s3TacZBGUhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=gsovIrdx; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53b34ed38easo3621856e87.0
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 01:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1730275922; x=1730880722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LV9jZW2S20xHJSWCJNTnjqD0DUEnUB3XkIMV/CaHdK4=;
        b=gsovIrdx8aLsoExLQt8yBTKwT79jgeqHvv/iA5MgixPbhnYIK2rWgjXI2bG2BoMIJo
         OryYVnCOx/viEHcZEXykRfu4JeSpDPJ5MYS6YQmW/2Klzq2C3/aaPsxsG7qSi+y691nU
         rlI6R1jpNEs03Wal+HkB3iF81nxlL9mYmB0eNa0CdU2OnXhGwzdsBgwF2xNCou9yB1/Z
         pJ1LNb47R0fJGxSAESdVmyyhpmgcHYOEhGYks4tAR4013rLPRHFEo34rJ33TqlzF89cy
         G4uRM4fH5crx3wDk3GHGa0DYIJJC5wti9ve1oJx0/PsWG4mZOK7rVesUKykaYLFWvXWE
         LwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730275922; x=1730880722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LV9jZW2S20xHJSWCJNTnjqD0DUEnUB3XkIMV/CaHdK4=;
        b=CBPkcsblSHWL05036awcFCDnLrFjfjHKVcU/5G/O/3EiT8iJq2HbQQkT3LIny3yMrz
         yDkt34eTgoq+14hYXX+rxwnBO1UNJ4KQINrZl+zAjr1hG1dF28WgaOu4OL8jxpyeMrTz
         wwrNydNgk+L3Nz7V08hzZxSWWJJh7KYocfhv/uhjbfHfTMLwma9ScmEJXjQDIQLzN3eY
         fXLAF433akxIqVhxAHdwybHbHX0IjAsaOCVysPUKdrKi1GfHs7+blmUDlsk+38SX2PbP
         04NYOvTdXhl6P/kvVvJ8yHUMcR/EDg1dfCNVsRqBM2hef7a9Lm+cHEsXUhAEF7Em9kEf
         vEuQ==
X-Gm-Message-State: AOJu0YzKcZb5aKkmAOc7tSeDFq4pEKEVnfNXkHP3qKauQ0pDR8gqIMMu
	jaUIXVKiTLLFBcRtHoemZRUpYyJPjyVaTHFsysODYmbwHqCSg20Is5Fd1NyjRWT46h7wANm324Z
	K5LU=
X-Google-Smtp-Source: AGHT+IGKdv44pVclz2fJK8G5v7Nlxt/THmrTRByND7JQ4NzEE8bRyzH9PXhgk86BmSv8GJNWoqDrwA==
X-Received: by 2002:a05:6512:1114:b0:539:e279:b3da with SMTP id 2adb3069b0e04-53b348cb11bmr6834185e87.18.1730275922218;
        Wed, 30 Oct 2024 01:12:02 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b4806fsm14611245f8f.56.2024.10.30.01.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 01:12:01 -0700 (PDT)
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
	tariqt@nvidia.com,
	maciejm@nvidia.com
Subject: [PATCH net-next v4 0/2] dpll: expose clock quality level
Date: Wed, 30 Oct 2024 09:11:55 +0100
Message-ID: <20241030081157.966604-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.47.0
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
[{'clock-id': 13316852727532664826,
  'clock-quality-level': ['itu-opt1-eeec'],    <<<<<<<<<<<<<<<<<
  'id': 0,
  'lock-status': 'unlocked',
  'lock-status-error': 'none',
  'mode': 'manual',
  'mode-supported': ['manual'],
  'module-name': 'mlx5_dpll',
  'type': 'eec'}]

---
v3->v4:
- changed clock-quality-level enum documentation to clearly talk about
  holdover status.
- added documentation of clock-quality-level attribute to explain when
  it can be put multiple times
v2->v3:
- changed "itu" prefix to "itu-opt1"
- changed driver op to pass bitmap to allow to set multiple qualities
  and pass it to user over multiple attrs
- enhanced the documentation a bit
v1->v2:
- extended quality enum documentation
- added "itu" prefix to the enum values

Jiri Pirko (2):
  dpll: add clock quality level attribute and op
  net/mlx5: DPLL, Add clock quality level op implementation

 Documentation/netlink/specs/dpll.yaml         | 41 ++++++++++
 drivers/dpll/dpll_netlink.c                   | 24 ++++++
 .../net/ethernet/mellanox/mlx5/core/dpll.c    | 81 +++++++++++++++++++
 include/linux/dpll.h                          |  4 +
 include/uapi/linux/dpll.h                     | 24 ++++++
 5 files changed, 174 insertions(+)

-- 
2.47.0


