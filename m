Return-Path: <netdev+bounces-88179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA168A62E4
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 07:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B137283D8E
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 05:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0BD39ADB;
	Tue, 16 Apr 2024 05:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="xmSLJ01V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BE71CD06
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 05:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713244537; cv=none; b=u8hb6ZMdp12cXXguf76GWE1pNbA5R6IW9/BNWjW0KzLOGllA6lDlHqyBBfvrBaeyfVt8nmoF71od/PN1oicTud+lYaT+JIcFerk4sj6qKy0gv0DAcchZAIBfj7gg4nuU1/hzxCPT8/yITcET42Neriqwz5k3TYr7TAmrbfZMszw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713244537; c=relaxed/simple;
	bh=2cvfxopkrYEneBgQEiymkJRtScCSGQY/O5tU6ZASMpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eW+RRCeavJ6DUxiFKf70iLVDxn/+cRzGOaRnHhJPZlJWkWAK9rW/Lt3HHomrAxOkewUAwlKjfDVnwRPqXpRYzUQywzO4FQWw8VAXJV18V1pdaMn3eEDwgCixvSvJQ1lZxd1/asvbdthap+0jZ0/z6GnyycMNWViqEYut2URU47w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=xmSLJ01V; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso2565168a12.0
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 22:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1713244536; x=1713849336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GqdAbLR0vxsZOamUL3FQrTQtvI/2Reh1qLUiccoK6wg=;
        b=xmSLJ01VjMHtAPICe/YsR8V6/PZRzaSiPO3zxMvsC1qixs9fMhA2ZpVZXtqq7YTJfE
         mLuFyZEfU2FX1QVmvgXWefTeAk/OGbkdbNjypdY8bHgbOAhieokrd0YCjv16Vkk+iX4X
         pwwMbcuCzwIT82HmDkMEcRuFHA0qFd6ylp7GI/608fmGeBp4uzkVr8ffhxKHB/dVhXJQ
         d7vFhgkvGDzGWWld+OmCBaNeWbiNld6yk2oRD2hlNnTkgThRpxBOMk39w/ivdzI2o5E2
         x/qmo7GoPMNJA1Ga5pUYrDrxK6+T9hlaCHjys1BHGrsnxBDwRrVSrsFjxqGkO0F5fk2u
         JvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713244536; x=1713849336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqdAbLR0vxsZOamUL3FQrTQtvI/2Reh1qLUiccoK6wg=;
        b=nazejTNurglhTdqpDlHR653P6VdM/naqq+1oBYPFeBPFuVx/oxFkiU23ZX6adVuDNU
         JWMlE5HpIf9bAMRS/dCkDeKk3VU13S993Z4AF25gLMFoFpKMXCZ1BtPHPs8fj9e0YIAk
         IerpmtAgCbY1OK+5P/ZrvSNpKVuUw/sudR1NPAsnhV9ysIlsGA/y9z90/EXt+bWKm766
         zcijPfDSrC3TztO4w5GGApi587a5dmSAeQ6WtorVeCsj+GDiushmWq+acXoTH5rySmKs
         98i0ifyngENgfZFF6bVugrtb4TpK1a+x7lXvAbnJt/v1eHkU5vR5LMdOLz199uCN0Uk5
         uAtA==
X-Gm-Message-State: AOJu0YzKLM1mvm5ioOWXDm5BtLZ44UWF/yoqsyodGHQGO0gOphK3A+g+
	W0Fx+0gK2HqJdrDctbgSGQsCO68ezSDcmHAouilfR4DH+VzwYGNTLwwhn1gXa5isBiiYgAheE2d
	Z
X-Google-Smtp-Source: AGHT+IHePWNce7D161fBiYVak4o3SGEosIxKAsVgeI2lwShQs+t6AIGUGZSJ0B68Q+DGwtENRHju3w==
X-Received: by 2002:a05:6a20:748b:b0:1a9:a011:cdcd with SMTP id p11-20020a056a20748b00b001a9a011cdcdmr15953037pzd.18.1713244535660;
        Mon, 15 Apr 2024 22:15:35 -0700 (PDT)
Received: from localhost (fwdproxy-prn-120.fbsv.net. [2a03:2880:ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902d49100b001e0d6cd042bsm8802043plg.303.2024.04.15.22.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 22:15:35 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v1 0/2] netdevsim: add NAPI support
Date: Mon, 15 Apr 2024 22:15:25 -0700
Message-ID: <20240416051527.1657233-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NAPI support to netdevsim and register its Rx queues with NAPI
instances. Then add a selftest using the new netdev Python selftest
infra to exercise the existing Netdev Netlink API, specifically the
queue-get API.

This expands test coverage and further fleshes out netdevsim as a test
device. It's still my goal to make it useful for testing things like
flow steering and ZC Rx.

David Wei (2):
  netdevsim: add NAPI support
  net: selftest: add test for netdev netlink queue-get API

 drivers/net/netdevsim/netdev.c                | 227 +++++++++++++++++-
 drivers/net/netdevsim/netdevsim.h             |   7 +
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 .../selftests/drivers/net/lib/py/env.py       |  10 +-
 tools/testing/selftests/drivers/net/queues.py |  67 ++++++
 tools/testing/selftests/net/lib/py/nsim.py    |   4 +-
 6 files changed, 301 insertions(+), 15 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/queues.py

-- 
2.43.0


