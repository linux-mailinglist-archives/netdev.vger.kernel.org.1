Return-Path: <netdev+bounces-68036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F521845AF9
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEEE1F28132
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5215F496;
	Thu,  1 Feb 2024 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh6usSp8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184435F495
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800338; cv=none; b=hyzmkwlCIsVUuGF45dz+JbDj5bPeGmN7SjBFfbEur4o3/vXrvjhdspf8S0BLx9P3bI7L9nBlTJJTD8k1qnABtbIM7z5B89a6Kv0LR+qF1UVbyjTbFkos1TsMwHcN5vhlRzYNEqGGgcUqWqBcEiC9/k2j0nnV1HKbTxya82nrh9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800338; c=relaxed/simple;
	bh=p3jfvRGlFS+dbp54hUnnxFCndt6tVAXoNZMKKJOkk6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NEaaBkhGZHDFNc4Sy5GdhY7YaXsSgVwmYzq1cCs7T6rcx0SNDXAxRPFFoZE2F9jyPUlgdQTI1cggKwmHTLh9EpGsREaKue30AURHxh3k0IFFIffR05n/Io0tpYnepfKYi30KgF/lbN7umXvyI1HdzFx+8v2zSHy0kkQTME6Mzqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lh6usSp8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e8d3b29f2so8803145e9.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 07:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706800335; x=1707405135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HMKyavPLpguY8bm68xOBjbqczW3mS4GZRrLEKmKUlTs=;
        b=Lh6usSp8JmWVUM/BUeIkeRLwGOK6uKz7O0w89csi6DRU4jgwer8TWiNdV/6MDcfIKg
         xPKmFIkekVGxDfj1B1pMv2tkwmx3okoPnG1ztFgRMS0A5LAhN/lNwnU1hIp0uOmcH20S
         9BdfE7yArwcTQptRkU0tP6pyBDhXasO8TwVXLrHUoWJvXB0H2ChvWdNL+9p4CBT2gHKT
         Hv4pY1jiJ91X/f0e8cggf3t2C/PNuILK6DnH+3pm/FVvr6SPfF8zWkV1VV87yEuZPIRs
         Xi1pYUdgn+ScGZnsf19lFPBdXWBCfxsTYlqxkMw+m5GfToXLW8uoG4s15Z6sncTwoXCi
         EwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800335; x=1707405135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMKyavPLpguY8bm68xOBjbqczW3mS4GZRrLEKmKUlTs=;
        b=bSEt1fPkH5b7Ko/7hRg2IunfhZefseJAlOKkNzMulzKVp/yF7hL7Vm5nyLJzJUJytm
         HSQkTykFs3UoHqeu/U9CWbezjaI97ngcKOaq3I9fU/FhdpdZgY5i5lXWkzTKBOP7gsFV
         6jJ4tTFNZU1aA053lSpUJ2QwB6Xweq3gYfVnlhOilobmshUoDDq+2IHRDctzJ7/4tONX
         TCJV8xDV0BeYut6d9sjNGId7AK6SVDpz74rtRcDeHITXUgnDbU0IIEhidWXmWSqIrq1P
         uo492BKQUZoBCnn2qSlG+i65JT+eCaZc5iFgKjZqC8rqNv5ngM6Q0XS6nS8TAPXqiWFy
         5N8g==
X-Gm-Message-State: AOJu0YwhhRJqFCufRkV1dtqyD9/WbzQZMffV096q5tJpfY8juIqCXd9A
	Oj9TecvdtIm2poP3ObrcipanhHCSMw2Ogsv7Mm6HqAG7tIBFmHmW
X-Google-Smtp-Source: AGHT+IHRFyR4mpw142y0NBIgqEQf5/ODaBnQQA6xOWefz8ibPee0IesSqLsvbwdqm9CPg96xI4yFAA==
X-Received: by 2002:a05:600c:4f02:b0:40f:b0bf:6abf with SMTP id l2-20020a05600c4f0200b0040fb0bf6abfmr1828952wmq.17.1706800334944;
        Thu, 01 Feb 2024 07:12:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUpQpvX4QWCX991ZX4xYsvZcGOcwVT3/O4noM7EG7olv533Im7mtMPSBbfkfAStfBL8rpmTgQLsGQ6Ir0RHeeHrS7j4m5aSjFHGfybqrN4TLMaYGXcrFSaYFVwhY4uxxKwg0Z1UmZwIkrbBShiIStpBo7prjXvcnOyvuVH5/2dFGAbM0CcxM+1k7wUjEbkuUdUi6kpoVwPQwkBxjPomJX5t5u/01UsKDgCZlNb/vI1u73ZBsHHj3gXvRo7jVCWiU5985DQe30IGJVj9ke8P9zDieSvZZzLpEBxe7t1gFOeI7hkWvEIItVqWjAjW2BRWOSpTTSYDBkqKis1sWSjrTe4SAuAi2E7N1T23
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c4fc700b0040fb44a9288sm4753672wmq.48.2024.02.01.07.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:12:14 -0800 (PST)
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	chuck.lever@oracle.com,
	lorenzo@kernel.org,
	jacob.e.keller@intel.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Subject: [PATCH v2 net-next 0/3] Add support for encoding multi-attr to ynl
Date: Thu,  1 Feb 2024 16:12:48 +0100
Message-ID: <cover.1706800192.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset add the support for encoding multi-attr attributes, making
it possible to use ynl with qdisc which have this kind of attributes
(e.g: taprio, ets).

Patch 1 corrects two docstrings in nlspec.py
Patch 2 adds the multi-attr attribute to taprio entry
Patch 3 adds the support for encoding multi-attr

v1 --> v2:
- Use SearchAttrs instead of ChainMap

Alessandro Marcolini (3):
  tools: ynl: correct typo and docstring
  doc: netlink: specs: tc: add multi-attr to tc-taprio-sched-entry
  tools: ynl: add support for encoding multi-attr

 Documentation/netlink/specs/tc.yaml |  1 +
 tools/net/ynl/lib/nlspec.py         |  7 +++----
 tools/net/ynl/lib/ynl.py            | 17 +++++++++++++----
 3 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.43.0


