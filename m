Return-Path: <netdev+bounces-81963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D163A88BF0E
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E73F1C26F63
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 10:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8FC6BB39;
	Tue, 26 Mar 2024 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="OI0YJRPs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D8D53809
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448142; cv=none; b=pCj7S03Ywml9r0gWqQxEd2bGRg5QiiYmziJ7gglTHt54Ccyme5SNOrJjoaw9ys3KGvGgIndWnY+X6wKJeJXsmKr3Jvyto1jeIf7V/fmghJcl/MPBR70YYTROie9Fh56H41I78fF/sqCqxIOK6SuBhtwjySk26CvpYCOxCf+HAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448142; c=relaxed/simple;
	bh=7+mqmXyrm8ZiHWxLSR7rOTaFaKIiiJcR4K90araaf+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hMjL1t+zxOjINKTibeMgBH3ReCX5YWqaOiPE1nJR9D7PZszU1Xm9A56sSEmc8FmjvKhcURcC6C/J44z+JyeEkqe1XAr8sPPIb9elNP6S6gTlmIU8+yuA86TJWtUWQSomHnZQgaChVtoEz7VA/bn2uS+urJCI49OW+CyfKe7iN+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=OI0YJRPs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41488f9708fso13242835e9.3
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 03:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1711448139; x=1712052939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=plleFd+hWhFGCW0SOk5h9dgOugSIHt2+U0BKCdjy7iU=;
        b=OI0YJRPsXdIuXTvvFM8HVsTJv4j2L9B1RIKbtteW2BPVfwHYuBKVbLF6I5GzyXf1wp
         f3Zd9hcsloJQWy3JVHy70aTN9zn1SExcWxWSrlkzsjO7fYLSkkT4LSqh8uYTzdU9OdmU
         XdhiIy67+fK1I2qNGbXALnPLMeDmVeMOpYNPzn2Eb8JV1i+66BGxuTIJpVLo5Wrl/PAl
         LFob3sFxdBsNhs2ZHdQzmnrZrfHacJDVqAMAQVovOF+9epywToT6edtBMsGH92MJT/hf
         bX+Zg5NbkYPWfAHi/UF2VRRoPjjuxnJQ7X8jHc0UCliBhev1ZAHi3vgTtlmr39WGgRF+
         mm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711448139; x=1712052939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plleFd+hWhFGCW0SOk5h9dgOugSIHt2+U0BKCdjy7iU=;
        b=sUmBuU78NCYr976mpdKdjhubJzEuMDx6D/6MFPlTX7Y0wAU5i430VrD+EgmMoaaZPb
         f9vC1dUCu4eoVX7FzI0aTlh1K/FeOZ16lLNe2lZ1KxKPs5WpS4yZnsLAxNpupKly1dqW
         nuIitUkb6UkUTpU5w2AG/zNyKBT2V28COPOtwv7K1guipBjyzCA3t2kQ3qFm4vWSPDuQ
         PZDqexyuXYLvC9P1hilT9g3lRdkhXXZ7TlKY/M7dyqFFt48jtcY18H7a0wLpnz1evOpB
         RIAFpFHBmf6ZVF53Akey8PD5WbnnYRsSKMQko1PqZWqI6DXqu+8y6iwsj9I3McwxT+37
         O3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWaASX/emmtEXOl9DcgcayBHeYFrXm7NSmWOvdUH1N5CT6FnNfVKmIWJv83qKQzy5Feu7yc/nkpAt1VQcmZaNldUFRnHKmQ
X-Gm-Message-State: AOJu0YzaOrOV1v59z4zmJKDSZJ4BqtKhi9S5bfTAREADmE926bY+Xum+
	n5NVJK76OA1tSKUZkaG15t9VAcfz0vV/P2abWX6OblKBe2zXKXEMKdZBgbvTNUE=
X-Google-Smtp-Source: AGHT+IH4FKMSWkJBfl7q9FZWSOwicPOQtTNBWj7obzTBtwMoDBGBJ9clSdtUb1kSdZ8dOWf3Zksd5g==
X-Received: by 2002:a5d:6149:0:b0:341:bd9f:4d4e with SMTP id y9-20020a5d6149000000b00341bd9f4d4emr6306455wrt.60.1711448138706;
        Tue, 26 Mar 2024 03:15:38 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id co20-20020a0560000a1400b00341d4722a9asm1891743wrb.21.2024.03.26.03.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:15:38 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Rumen Telbizov <rumen.telbizov@menlosecurity.com>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v2 bpf-next 0/3] BPF: support mark in bpf_fib_lookup
Date: Tue, 26 Mar 2024 10:17:39 +0000
Message-Id: <20240326101742.17421-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds policy routing support in bpf_fib_lookup.
This is a useful functionality which was missing for a long time,
as without it some networking setups can't be implemented in BPF.
One example can be found here [1].

A while ago there was an attempt to add this functionality [2] by
Rumen Telbizov and David Ahern. I've completely refactored the code,
except that the changes to the struct bpf_fib_lookup were copy-pasted
from the original patch.

The first patch implements the functionality, the second patch adds
a few selftests, the third patch adds a build time check of the size
of the struct bpf_fib_lookup.

  [1] https://github.com/cilium/cilium/pull/12770
  [2] https://lore.kernel.org/all/20210629185537.78008-2-rumen.telbizov@menlosecurity.com/

v1 -> v2:
  - simplify the selftests (Martin)
  - add a static check for sizeof(struct bpf_fib_lookup) (David)

Anton Protopopov (3):
  bpf: add support for passing mark with bpf_fib_lookup
  selftests/bpf: Add BPF_FIB_LOOKUP_MARK tests
  bpf: add a check for struct bpf_fib_lookup size

 include/uapi/linux/bpf.h                      |  20 ++-
 net/core/filter.c                             |  15 +-
 tools/include/uapi/linux/bpf.h                |  20 ++-
 .../selftests/bpf/prog_tests/fib_lookup.c     | 134 ++++++++++++++----
 4 files changed, 153 insertions(+), 36 deletions(-)

-- 
2.34.1


