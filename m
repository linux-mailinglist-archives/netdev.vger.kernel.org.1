Return-Path: <netdev+bounces-222688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 361A5B5571B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF71567F7E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244C1280338;
	Fri, 12 Sep 2025 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0Ul7iC5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724AA26E70D
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706833; cv=none; b=P3Yx7t8mzauOmVwrOfNtLsuCx5JTaS7FLJxCs0SQPf+uoSMHH+u0TFbjb/EwreAypaQU55d/mX/cAZj/5sfE6+BHYLUSoNbcEzLOBxu4N/tfJBFlfqMevUp0+3Y5urj/0WMhjVTc1ghxesDK2DTIERvAkOsvMJggiJatb/OHLjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706833; c=relaxed/simple;
	bh=fCUTGtNGsGZ5r8jfbbLtppKMsWLoWvtOButsYG55zPw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HbmGPJT4gE2mFzAJVCFJ0Vq2QLHewFafZZ0qAz//3s9vwOPsqgqXQI6nlmgM8/+OLX4mlJ0X7Z3QQCP4LP9wmlIrNPWtqbuuWgQerJnU7mPG0Rba0Q7yAhbzhCitGYn4nbR4l6BVNQQ2hg3KwtGhVQTTAZc6NgSsP5yL6yKXiJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0Ul7iC5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so20910925e9.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706830; x=1758311630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=im9Lq21+8J5Mf+5Q2uEKKjoiHcxVE9gd6Lc8gRvhOVI=;
        b=b0Ul7iC5cmeUD9YWfGGZMaMMp9dX9sudglDagj4vH5odmnPhHpNkaN1EcBjFKpufv1
         qj9JezF/sWIU26+/pITBMK+mZpQRWpQ512u7Km0gV0xWvHrwGRHydzYp+GL1vh3rCzn9
         kR4lrIaVP3N7rv8Qz/SnPTV/qu5HbdOtu//Y8wU56A8f9Kb3JbbX4i0Fc5RJJHMbJM7l
         dYw4VcpALWDt91paTZijXjcffn9tIuJbXxO1gEUHVvya8BIHKrnepwB4dkFr6A9pJng4
         89DlwVHweCiIO/w4jT9FguOyHnCemkuHVW7hMKt8HlOquUhqeuUartXixzFPsQDdqRIN
         uzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706830; x=1758311630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=im9Lq21+8J5Mf+5Q2uEKKjoiHcxVE9gd6Lc8gRvhOVI=;
        b=CXf4hCooZPuGrPs0NGGdsyt6T6x5KLC0Rn5Z5FTqXcy/M3oXpDGfafTIKj4Ij7Qqe5
         XFgtpQiyntDOj7z8wTw8N7M65qLaRXKcDyPU3hHsAOoVbHwQGq7I2X51aYd8hP1M0HiS
         w8NyZjPKvDxXErroN4BSZaQ8AL9nVmgoBBtI3GShZpDHzfLn/9GCcmLj+MoYWHpcJKmm
         M5JN+JpK3OHPnFXM4jP5w+vCCXMVsfmK0XuBkarv1qdkf+XTuttEgobvXLTuumHFub36
         IXDUVIrBlNeFSkAUYWMbVUSS4U2USC5pWsCthLZAra02aTrgxMEmAKyhJ0DXPcqHPCVk
         v9Mg==
X-Forwarded-Encrypted: i=1; AJvYcCX598+jwhtdTgfGXcktmzMgRd0N3NM3zFgf+WVcK/7pgbtyI2YpXUonUnBg+gfm2zsdbKudHp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGQUtx4hE3hLGipisFHTRP2rZUO5re/uD6hZ5lot5NoGmCUsFf
	CdRSByypWyAWO2RDTlfDgx0I4e6hsmHhp4Mvn8iJk80YpKTvDrLZhR5Y
X-Gm-Gg: ASbGncsw8t7zThueIiN8+BusjNRYNf6v6o5E6sLYX7Q2xCg8YiWME4n3+2oqD2+FnZp
	k8Fo4xs4Jq3X03edzXxmuPT2dPPH0ZA3tz+RsRMlVkoSuK0S7dEYf+Jj6jv/niN4Mnko50kUXYI
	kxlTRlzuXEa+p/xuHnhUNDlnixl2BtX7KLbRi83x7Tet5SXCKQBW0ZsgPQl/jpcZZO1tWxIKgfQ
	wMsNttayJwaLAImSQeeUZjDzBC09glSwfuJaS0Y6xjbq+Xj1QKVqg1mKltG4fgXgEU9pyKnyJNT
	yzADjYUCtmWUXD6AKOFhhtoC/FhTWZnbYTCDbYxqjK+N7ELxgLQER028OjCAjkiOrrjKd2/YDoe
	fyEt66DrkG6HcaIkUYVfCsiDGF9VRhe9V/SEoA1gisrBkC1aksg5rN+cYHji14w==
X-Google-Smtp-Source: AGHT+IG9aZcd6e5qxsZVmaWzgC1SbVThJULp4P95JK54XvdW/IaMNxg/kygFEwGzo4IyxjxCygpjwA==
X-Received: by 2002:a05:600c:898:b0:45f:21e6:3ef7 with SMTP id 5b1f17b1804b1-45f21e6403bmr28589515e9.17.1757706829510;
        Fri, 12 Sep 2025 12:53:49 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:53:49 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 00/15] genetlink: Test Netlink subsystem of Linux v6.1
Date: Fri, 12 Sep 2025 22:53:23 +0300
Message-Id: <20250912195339.20635-1-yana2bsh@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds comprehensive testing infrastructure for Netlink
and Generic Netlink

The implementation includes both kernel module and userspace tests to
verify correct Generic Netlink and Netlink behaviors under
various conditions.

Yana Bashlykova (15):
  genetlink: add sysfs test module for Generic Netlink
  genetlink: add TEST_GENL family for netlink testing
  genetlink: add PARALLEL_GENL test family
  genetlink: add test case for duplicate genl family registration
  genetlink: add test case for family with invalid ops
  genetlink: add netlink notifier support
  genetlink: add THIRD_GENL family
  genetlink: verify unregister fails for non-registered family
  genetlink: add LARGE_GENL stress test family
  selftests: net: genetlink: add packet capture test infrastructure
  selftests: net: genetlink: add /proc/net/netlink test
  selftests: net: genetlink: add Generic Netlink controller tests
  selftests: net: genetlink: add large family ID resolution test
  selftests: net: genetlink: add Netlink and Generic Netlink test suite
  selftests: net: genetlink: fix expectation for large family resolution

 drivers/net/Kconfig                           |    2 +
 drivers/net/Makefile                          |    2 +
 drivers/net/genetlink/Kconfig                 |    8 +
 drivers/net/genetlink/Makefile                |    3 +
 .../net-pf-16-proto-16-family-PARALLEL_GENL.c | 1921 ++++++
 tools/testing/selftests/net/Makefile          |    6 +
 tools/testing/selftests/net/genetlink.c       | 5152 +++++++++++++++++
 7 files changed, 7094 insertions(+)
 create mode 100644 drivers/net/genetlink/Kconfig
 create mode 100644 drivers/net/genetlink/Makefile
 create mode 100644 drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
 create mode 100644 tools/testing/selftests/net/genetlink.c

-- 
2.34.1


