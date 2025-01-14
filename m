Return-Path: <netdev+bounces-157922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5B0A0F55E
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 01:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BB5164498
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 00:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37FC46B8;
	Tue, 14 Jan 2025 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB5O6oPR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7E51C01;
	Tue, 14 Jan 2025 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736813229; cv=none; b=JesnlvezDAFGbNrMkdawSsC5630RTtWzyT36kjBhicFWAlQVKrtmmBgFUH9uZKbV00/TXINmnuxlnVTpQUlrDsCQPlVibRfXcS/ZKZVnt8lsAiOpFqwdiNiMSchbZJa2S8NuW+Zgq4QFUG/WmMicf95gDRT1oKcxAYV7VyNtZZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736813229; c=relaxed/simple;
	bh=NQ+8DRtiyyq2CQ4DSIvmBSfGnbyi+Hnp8OBhHM7xuXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U7BTb+/vK7HgunHP2XpUyUo+38CyCz9ntbgpejebgnou09ig4R4L8t0gTcs0xORKJP8AJbEjmReHpwWQ4X1Aby7l7MW6XQN3vwnOg6dv8BebdIHsy9z9ICwNwNN91kvsMtbjpVWLTEdut66/IfzLSVDQMnArHyDJcwBBrBuLp0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IB5O6oPR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21631789fcdso74486765ad.1;
        Mon, 13 Jan 2025 16:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736813226; x=1737418026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ImyW9GEO4TLqoyiL4yNNlcnjnBG615AP7taZqEjFzEc=;
        b=IB5O6oPRKUYfDKRcVl7JGNfecw5oChTss+3zXhxDLwRHluQMYuYeDiTrQuvkKFhDUI
         BiVpMtRSet66MAJ4PKBk97pThWNlGtfQsLP4f8tzUG+Pg8bZIf3uPaa6WTELxXclmfnp
         LGeeL8UWe1+4Q6Nr7vTz9CE7DimMAW6llLQgmeg2OmNIXu13/ZYhwaxmUJXn9SnouVGs
         fXPFYm4EdiJ+StUWSE/zsqVI/TUL+ivJIop8ulqHNyAjxnA1U6e99mxnfOUZRMR5uLgp
         XSQXu2C3waKOlJsCiSozZJE0GnmUfLMlImrjk7Th/BgrdzgpaLPZmmyQIQvzEddCEGfN
         A+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736813226; x=1737418026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImyW9GEO4TLqoyiL4yNNlcnjnBG615AP7taZqEjFzEc=;
        b=rcqWOmy9dEvpsRk9f65s0O3RBJjh18JJvXfvj1oMuMa7HuvgQNptCi/LQt24peDdru
         hWBD9dr8Nw7z7K9itvnoiSc4676eeeyvulol+GtlSt9sPjDaK0BkWV+zXdYqSBHdBzuW
         Q+m9+T+om0so+uVndr8489NWdXqczY8Pq7ARDKdI1ywlVPuEegCs8kAqZDt5++YIdIyo
         hYAH4SmJTAZsh7QVYZ6xaABv0F0x1dz/BKOz46u0TmFBqvS6hlszFvuvlTxfZAtlRKkq
         Rf4TiH64BmqyVTL14PsBiShni+HaZm9F6U1o6gW4lPt5aixHK9v3Booi0VlWArs1+eOp
         HmOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRLAehJEmAu67AlLf5hexfumIL+TKY0kso7RAeY5BBm7fCJ+6Z5VxXf0uiYQ2BdNA7EgeevcoJhZEo66YB@vger.kernel.org, AJvYcCXvVBLt7zXJoDcelyLENR0zWrJwi5A1iZqkZqF+93VTkZlLBbjt3gkWGUEWdctgGeRm4YrkNqkG8xZ9NA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBR2u36ihHIASxXAwSq6rzKPvrICCWizI2/aL0Fn7XnKSDI5jH
	U0XRJtBHk03mnAcgTxNDmouLBcq0M7+mbz8SaD2JMguOI0R0gS/k5qw2kNX1InY=
X-Gm-Gg: ASbGncv5+sgBIbqhIDMGXi1GlWi55LPUzsyuVVMADmGoC7WXdxvWlzIjFfGtM5/Q7IU
	xZfa0UI68z9IPB421kG2SrL7wauo1Zd/S0tTHh0RRESXkf/ByUsRT/2WDlyH+o7jFiIDS1Fy5zO
	4f9O0WfFr1Sc5q7MMRNveDRZxz1s7yWp7oacy0+zFxi93gBX/ife0j8mNSF80GwoBpQDvdwj6nL
	vx6BmXkOmAvERh+KPvOQlFrH7qHiMfXsNsYhbVT/V0LjEjcjzuQlZM=
X-Google-Smtp-Source: AGHT+IGWc7Z2AAsRONkqLBa0Ng1MSRzuG9BJPo4NBLRGnsrLF3Fh0nJ/wDanFL+vpKld+SYgOFm5Yg==
X-Received: by 2002:a05:6a00:392a:b0:725:d64c:f122 with SMTP id d2e1a72fcca58-72d30303802mr27864997b3a.2.1736813226468;
        Mon, 13 Jan 2025 16:07:06 -0800 (PST)
Received: from localhost ([2a03:2880:ff:11::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405493acsm6382475b3a.28.2025.01.13.16.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 16:07:06 -0800 (PST)
From: Sanman Pradhan <sanman.p211993@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	kernel-team@meta.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kalesh-anakkur.purayil@broadcom.com,
	linux@roeck-us.net,
	mohsin.bashr@gmail.com,
	jdelvare@suse.com,
	horms@kernel.org,
	suhui@nfschina.com,
	linux-kernel@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	linux-hwmon@vger.kernel.org,
	sanmanpradhan@meta.com,
	sanman.p211993@gmail.com
Subject: [PATCH net-next 0/3] eth: fbnic: Add hardware monitoring support
Date: Mon, 13 Jan 2025 16:07:02 -0800
Message-ID: <20250114000705.2081288-1-sanman.p211993@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds hardware monitoring support to the fbnic driver.
It implements support for reading temperature and voltage sensors via
firmware requests, and exposes this data through the HWMON interface.

The series is structured as follows:

Patch 1: Adds completion infrastructure for firmware requests
Patch 2: Implements TSENE sensor message handling
Patch 3: Adds HWMON interface support

Output:
$ ls -l /sys/class/hwmon/hwmon1/
total 0
lrwxrwxrwx 1 root root    0 Sep 10 00:00 device -> ../../../0000:01:00.0
-r--r--r-- 1 root root 4096 Sep 10 00:00 in0_input
-r--r--r-- 1 root root 4096 Sep 10 00:00 name
lrwxrwxrwx 1 root root    0 Sep 10 00:00 subsystem -> ../../../../../../class/hwmon
-r--r--r-- 1 root root 4096 Sep 10 00:00 temp1_input
-rw-r--r-- 1 root root 4096 Sep 10 00:00 uevent
$ cat /sys/class/hwmon/hwmon1/temp1_input
40480
$ cat /sys/class/hwmon/hwmon1/in0_input
750

Sanman Pradhan (3):
  eth: fbnic: hwmon: Add completion infrastructure for firmware requests
  eth: fbnic: hwmon: Add support for reading temperature and voltage
    sensors
  eth: fbnic: Add hardware monitoring support via HWMON interface

 drivers/net/ethernet/meta/fbnic/Makefile      |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   5 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 154 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  28 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c |  80 +++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  72 ++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |   7 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   3 +
 8 files changed, 350 insertions(+)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c

--
2.43.5

