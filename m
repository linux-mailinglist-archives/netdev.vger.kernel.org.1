Return-Path: <netdev+bounces-187416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8CBAA70B9
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 13:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C1F1BA6455
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 11:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C8523816B;
	Fri,  2 May 2025 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tHRhZuTn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEFB1BEF77
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746185908; cv=none; b=hOSEciUfoL0M0BjLPbsL2/3UDyfKLDkg9PsHQFq04dJFaOn1OrTFEuDWZ0mIzpoOrT0mETspl+jX+RWBoW8q9oQVzC36liPZZYTdvR/nucBLq7NZ+MtAkcbEkDM5R4bPZhIbt2ewd7jxbAmARoPSRT7QG7VvwaB4CSpG43FBDis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746185908; c=relaxed/simple;
	bh=JYO7ycHIMGtM6E/Xw0TZYjvHwWOdJKhaUw+RNvvlUF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4AyjxQOIyWJ9zMe9L+W+uWdhkamqHNsLS6ST7MQ7PRkOw07wz6/ITSLks4v9bf4YwDmft4B/YmGqFNN6FAknbw3m0m5uykB8VPZgt2RInhfKs3wQx62q48jNItvY4f0sKwBoXp0wxHXOego/u6/VsQojO23SzfZybaMs5utT1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=tHRhZuTn; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3995ff6b066so805868f8f.3
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 04:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746185905; x=1746790705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1AWRP88f0d3OEpjKD4xnrQlbJ8BVFwWOzX/6YKBiEUc=;
        b=tHRhZuTnF7C8ld/ZDsNvmjh+LR8zwH7jibByqi7qVv78GyLdRqimixx+ASoFIhPLD7
         NDXq9DcYacgMHV3HNTtWtb8AkAIYV85bga373d0wxOOAq0KiPFxrulwFlVv8JkxCjV3m
         28IxHy3yobJIrgqgE/aqWkk2SIzxarp7On/lTcCISp28O7WJBGT+kOU+5YTryPH5s+Dj
         x95hpWjTbcMmsF74ehb177FTOH8a7lFRmnXbgGjvUjZFljYQJDJkfLnbKvDJ6p5+s4L5
         uLfF+Dr/RnKdxgUpxadgVGbdEQdeDJa04DSMslFD9Ahp9Mj7wXvSaPnKPttWzMJduqwD
         osvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746185905; x=1746790705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AWRP88f0d3OEpjKD4xnrQlbJ8BVFwWOzX/6YKBiEUc=;
        b=BACy2S3kwJ+omlqZNFXCIFSdBWx8ScAl9HA54KS0YWHg9sFKaQkzBISw0H2o9+fYH9
         Tn8RwhQaerupJiqn34DNFyDEwhx6w47mVKqWoPVcK8IsUgF/u+WMecwGIQu1ONMAzE2q
         BTuoq/sh5nWWB6pFf8reuKDD0O2i1t/GON4IQPtbOkvn8Y7kr99+pa7sZ1sFGai5JGl/
         OQL6UQIMFEERL3RIXIDYAtNQuSwBMoXUGSpIwQT9QnUQgQmbGhOo556ziOPJfqG+/SKI
         etX53U8k5jFupQDQ6YP4NVoqs4ve/Qu3pg/jyctaRKVbUDBwmv9ETZhVnEc9xTFHpOVs
         PF5Q==
X-Gm-Message-State: AOJu0YyKFNpjS//RyNLJRplZjE6lt2PO/ES7uU3+/t/DR+MgCGqGqrf/
	qVV9If0a1O54x3XwanXJzjYPtZEZX6ASUOLmOG94SU4Z47HKkJDzez900shlSmeNTav8zIyRNI/
	Kfus=
X-Gm-Gg: ASbGnctkgi49gT5OfYvGllxxFyHj0xQM9spyXBSsIFqAwPqltJ0zHc60NlPRbPcKEMf
	0mD6hRAcZu2EA7EAMsO5rKp5BA5s4b4kOgqjnQj2e/DfhdTS44Ter2z8x9Qa6oQt1VgkYtueiEo
	D0aLzkb6veS8m8YEjQpy/fIQVpaOD0LZmG0fSuG+AizD17xwV3bawodDM0SV18B2RGKyKczG8ul
	0Ba3huHVpFq4CkmcagmqokZqgvtG75Mfq5NBX+BgLlxTA4ewOQ1OzxtSZTYT5PkL4IE75fu4Cj+
	VgBGZnPGyMG5APr+178PpSq9cqWcIRSV35e/881ETv9b
X-Google-Smtp-Source: AGHT+IGjlu7VAFOiORbW7nWfsPzio2gmoYK8wXYaHWykWrS3U3Hq9JhCcX2BoFqlAOt8jzDVtKJt+A==
X-Received: by 2002:a5d:47c5:0:b0:390:e5c6:920 with SMTP id ffacd0b85a97d-3a099ad2a2cmr1959996f8f.3.1746185905088;
        Fri, 02 May 2025 04:38:25 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0d2csm1896333f8f.2.2025.05.02.04.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 04:38:24 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	horms@kernel.org,
	donald.hunter@gmail.com
Subject: [PATCH net-next 0/5] devlink: sanitize variable typed attributes
Date: Fri,  2 May 2025 13:38:16 +0200
Message-ID: <20250502113821.889-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

This is continuation based on first two patches
of https://lore.kernel.org/netdev/20250425214808.507732-1-saeed@kernel.org/

Better to take it as a separate patchset, as the rest of the original
patchset is probably settled.

This patchset is taking care of incorrect usage of internal NLA_* values
in uapi, introduces new enum (in patch #3) that shadows NLA_* values and
makes that part of UAPI.

The last two patches removes unnecessary translations with maintaining
clear devlink param driver api. I hope this might be acceptable.

Please check and merge to get this over with :)

Jiri Pirko (5):
  tools: ynl-gen: extend block_start/end by noind arg
  tools: ynl-gen: allow noncontiguous enums
  devlink: define enum for attr types of dynamic attributes
  devlink: avoid param type value translations
  devlink: use DEVLINK_VAR_ATTR_TYPE_* instead of NLA_* in fmsg

 Documentation/netlink/specs/devlink.yaml | 24 +++++++++++
 include/net/devlink.h                    | 10 ++---
 include/uapi/linux/devlink.h             | 17 ++++++++
 net/devlink/health.c                     | 52 +++++++++-------------
 net/devlink/netlink_gen.c                | 21 ++++++++-
 net/devlink/param.c                      | 46 +-------------------
 tools/net/ynl/pyynl/ynl_gen_c.py         | 55 +++++++++++++++++++++---
 7 files changed, 137 insertions(+), 88 deletions(-)

-- 
2.49.0


