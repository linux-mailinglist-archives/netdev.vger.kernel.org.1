Return-Path: <netdev+bounces-66983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE48C841AB3
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 04:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4E81F26287
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 03:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53638376F1;
	Tue, 30 Jan 2024 03:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WMwvuKG7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C35374FB
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 03:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706586723; cv=none; b=Y/KNVfGJIAS/kUpogH1DZ7KJftCisoQcFuqv4vP27ysAYd3NSZrlZXitgplOr9iI6lnxoyim88s/IwRA7v7p3r+iE/0f/+XYloBdXaePuy7CSKOIURIBfNPIEX32hbY5qUkTMhKSHdYzIMaxWxm1nDvPtV8JucTArJFGorRA3c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706586723; c=relaxed/simple;
	bh=mrSUsYr40vZLSd08HCa9ghUj2kZmeOFNxhdsAlHKBFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RK04/f3pc/+tRN16yoxohk7EVlHPBhXwWy3fgQ+ZDvZTV/r5ViSN+aPsMHnVU31NKnRyD2oWvmWBID0rLKilcY+7cbSChk+wO1J4XO3i7iwMLxTFW4xQkwIgF/9hNedDFub5ykSR6axN66bjUXYkAXyYHLThnfIzPQyCPOk8/Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=WMwvuKG7; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33929364bdaso2440263f8f.2
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 19:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1706586719; x=1707191519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3IAAtpYMk4Ivb7jeyKnDj3sOOnhVdi6sq/asAwlVHv0=;
        b=WMwvuKG7/TZq0DtcrOUKeNIi/YzL8SAR6/eYBRfInMYk35qTUihSVGabsN2y8Yqw82
         NdteorllG884xr66l8dkAf7qE/tu/rsBga+UiSlwDNGYQeTXJaPzPaicO1AbdCFu3j/A
         G5MnoTCR+AlsHVal7nK4jOa46AqfEJNvOc0Zzn1BRPzU96Pxk0DXH+aq7ynH1wbtHqCX
         VUuRuNyZsp0a23q4hZ9h5NriLK/OTFPo/f936MvWbxZojeTX47Rq3Z3rRDWnEnbdMna3
         Dvtx+NKuJAed/WsZunwNuZImE6YV9WwU++lhlM+Hn4JOuOqtGfbTThuQr839DC/wHQfi
         Ohuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706586719; x=1707191519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IAAtpYMk4Ivb7jeyKnDj3sOOnhVdi6sq/asAwlVHv0=;
        b=ElmDLF2wfaqgsM8LkQu0Bn5wJBinat1QVODfNZvmPTKxiM9e6TePvKGEr2tG33XUwu
         d2LysTzx7UP9qOiu6jndSwE6zJfCNBIc6L300fo6H1gusdd8YNBv9/QvimCDaMpCB/1d
         YbO5IyUhyN7Kq7bCJbIdNSoPZSbkUTMKrTT0Wn/BevaszCRnIiRbvm2OJN8HiZqMGTzy
         QieynEBxncgHOwhVUHSV47IOz8haucr3kaDt5ldQ0EXWpEOvrSwofcXgfANtVyumpnGU
         msxW/9/RmNhD65GnXUEIHSc4bCLjSRsS0tU88pdBHjMk1DjLYwrSYKSDI6MGfEu3Dw+2
         qMeg==
X-Gm-Message-State: AOJu0YxLAq5WN4eRL1qAPOAhlKxz1dbVOi6m55rfQpghOtake7Wv0VRc
	ekQjQj2xAY/PsxOPrI0RzHQ+X/BtnLN5sc3mA01IUhpcch9v/nV9pQ641JrFZg==
X-Google-Smtp-Source: AGHT+IFgxB0xmRcPBgUyJL72I2YQDnGZRrMzC2LF6+dllvtCE0U8JpF0s4du7/8eXY30bDYq8rdv/A==
X-Received: by 2002:a05:6000:2c8:b0:33a:f521:7062 with SMTP id o8-20020a05600002c800b0033af5217062mr1762641wry.3.1706586719581;
        Mon, 29 Jan 2024 19:51:59 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id ay13-20020a5d6f0d000000b00337d6aa3912sm9513207wrb.10.2024.01.29.19.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 19:51:58 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Mohammad Nassiri <mnassiri@ciena.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] selftests/net: A couple of typos fixes in key-management/rst tests
Date: Tue, 30 Jan 2024 03:51:51 +0000
Message-ID: <20240130-tcp-ao-test-key-mgmt-v2-0-d190430a6c60@arista.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706586711; l=1089; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=mrSUsYr40vZLSd08HCa9ghUj2kZmeOFNxhdsAlHKBFc=; b=neGs9rbOA+EqGzLfMqyu3VFWcABDrXh0tWgdIRGzuXY3D1GWlihFguJm9kCKBjjMSM9vWnxAZ xt7XFjrr9fKA0St+JyMBuYUlSkQFRgyc0lvx0z3G+8M10EKps+dqft3
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Changes in v2:
- Dropped "selftests/net: Clean-up double assignment", going to send it
  to net-next with other changes (Simon)
- Added a patch to rectify RST selftests.
- Link to v1: https://lore.kernel.org/r/20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com

Two typo fixes, noticed by Mohammad's review.
And a fix for an issue that got uncovered.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
Dmitry Safonov (2):
      selftests/net: Rectify key counters checks
      selftests/net: Repair RST passive reset selftest

Mohammad Nassiri (1):
      selftests/net: Argument value mismatch when calling verify_counters()

 .../testing/selftests/net/tcp_ao/key-management.c  |  46 ++++---
 tools/testing/selftests/net/tcp_ao/lib/sock.c      |  12 +-
 tools/testing/selftests/net/tcp_ao/rst.c           | 138 ++++++++++++++-------
 3 files changed, 124 insertions(+), 72 deletions(-)
---
base-commit: ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
change-id: 20240118-tcp-ao-test-key-mgmt-bb51a5fe15a2

Best regards,
-- 
Dmitry Safonov <dima@arista.com>


