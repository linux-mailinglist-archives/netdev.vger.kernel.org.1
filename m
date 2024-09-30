Return-Path: <netdev+bounces-130485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD23398AAEA
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984481F22460
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC97195805;
	Mon, 30 Sep 2024 17:17:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454B618E354
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716678; cv=none; b=LrCPpo814+iyKuTasquwnRtui6l7vFiRbzt/HLS01fAwfQS7FuSc01FL+B1koonivla/oroXRIvLJcublkVMg634cwvdZZu7MQLrzZWI46qaIOliLoatmvOHdM53J85T3Jz0ti+Q7zaN0RMaJF9cR/oS8KId4Qyvdb/S3rFfWN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716678; c=relaxed/simple;
	bh=PVUQqPEjedGwTaHZvcSqy1vxK5Nzm14rtlklLrshyJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BJPARoVsjzGU5A7KSxU4DCi/A6deCMbo8RHOBVsgkP4+m1+d219qTO/cYNw/G5Z2UK7UZTNuYelE5X5Q1qjkVzxGSgwwS2wTMIEMKeLRlnJ2+rJ+ZzFYZj/ZvQQ00xKOWkUBPxl14DDUrsAC902VQ88jZrGJPuixrEiKFgHPe/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2068bee21d8so50124455ad.2
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716675; x=1728321475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUGeoPCqygcu7Rm8jDila/vW6FuIH+aoFcgGE8ir/X4=;
        b=YB6cH9YmHbCVdYL/wKYRZ9q3M6naSRhJEFsc0Mz+KutJpzRGbw38a80p2oJWIv/qYg
         ptpCzc71N5mVYWNdehy9qhKr8TEFkAdZRzXjoOvBN5wpiKQ3bAhneoLHnuobX9C/bkXc
         bPI+uCXaXx5K3YbmfUQnBeHmnNdaa1OQKKGbY/uyyZCeAbZXk0/P+0iltD/bZKeQ0ecE
         6Q/bKcc4AGDTFRcVmVTwRDXsHtISRy7NF1kUGtPqORUU3JtQV5wLTpRn3NpDpo19/NDX
         RCwN5hxcDXXfGCVmmmbm8UBJ3kwQ4/hBuBZ7jwi1rQN5xSge13rmqA12B/qYdKhkYKXh
         C6XA==
X-Gm-Message-State: AOJu0YwoOzCUgFfp+4e3+fvxjOw91O286GDtZWkJ9dJY6C9W8SkQIKI0
	PNDYO477whubUA+tZeBEKh7cUgQNkIyMbi3FdDvwixXilQcFdrHKUse8
X-Google-Smtp-Source: AGHT+IHoOEJTKPum+ncOByKEA+k0ChBG2fczCPF6fRlwdKLi8trn63GN5a9U4Z2U4BnyLgCvgW0xPw==
X-Received: by 2002:a17:902:ec85:b0:20b:8a93:eeff with SMTP id d9443c01a7336-20b8a93f3e6mr43975825ad.37.1727716675346;
        Mon, 30 Sep 2024 10:17:55 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e5169csm56841155ad.238.2024.09.30.10.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:17:54 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v2 00/12] selftests: ncdevmem: Add ncdevmem to ksft
Date: Mon, 30 Sep 2024 10:17:41 -0700
Message-ID: <20240930171753.2572922-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal of the series is to simplify and make it possible to use
ncdevmem in an automated way from the ksft python wrapper.

ncdevmem is slowly mutated into a state where it uses stdout
to print the payload and the python wrapper is added to
make sure the arrived payload matches the expected one.

v2:
- don't remove validation (Mina)
- keep 5-tuple flow steering but use it only when -c is provided (Mina)
- remove separate flag for probing (Mina)
- move ncdevmem under drivers/net/hw, not drivers/net (Jakub)

Cc: Mina Almasry <almasrymina@google.com>

Stanislav Fomichev (12):
  selftests: ncdevmem: Redirect all non-payload output to stderr
  selftests: ncdevmem: Separate out dmabuf provider
  selftests: ncdevmem: Unify error handling
  selftests: ncdevmem: Make client_ip optional
  selftests: ncdevmem: Remove default arguments
  selftests: ncdevmem: Switch to AF_INET6
  selftests: ncdevmem: Properly reset flow steering
  selftests: ncdevmem: Use YNL to enable TCP header split
  selftests: ncdevmem: Remove hard-coded queue numbers
  selftests: ncdevmem: Run selftest when none of the -s or -c has been
    provided
  selftests: ncdevmem: Move ncdevmem under drivers/net/hw
  selftests: ncdevmem: Add automated test

 .../selftests/drivers/net/hw/.gitignore       |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |  10 +
 .../selftests/drivers/net/hw/devmem.py        |  46 ++
 .../selftests/drivers/net/hw/ncdevmem.c       | 734 ++++++++++++++++++
 tools/testing/selftests/net/.gitignore        |   1 -
 tools/testing/selftests/net/Makefile          |   9 -
 tools/testing/selftests/net/ncdevmem.c        | 570 --------------
 7 files changed, 791 insertions(+), 580 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/.gitignore
 create mode 100755 tools/testing/selftests/drivers/net/hw/devmem.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/ncdevmem.c
 delete mode 100644 tools/testing/selftests/net/ncdevmem.c

-- 
2.46.0


