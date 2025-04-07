Return-Path: <netdev+bounces-179971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8D0A7F000
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869343A8327
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF096221727;
	Mon,  7 Apr 2025 21:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="eh9ot0F3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6DC199235
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 21:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744063026; cv=none; b=UvUVVtu24zsh9z2X6wDazick+AHq2imY/XI6Kt6Ki9hjtY+pP92Oa0AdF7JapZWjgYWs0GBM9pem50rRPv/nnUx84cqlef5a3Y8V9T9V4VfWXH77muYbvq/MbleyRpPNsNY9AjQ2dIH2uGd0POGDUzO6fS1Mg6Wilatu+5py/I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744063026; c=relaxed/simple;
	bh=AtkF0ZBc+Z05dbI8kojFijCH1tuLsLtL+wuYx+B6p7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tzdPQ/yU7Dmpu1arZC0v83lSYb6B+VqKNb1+/jPejI57JCnVOB6fPG2a63ISNkdxoRc7nvvewL0i4+9ETeYUfxGfQq3IZGARSG6rfM1tHfHdCGObeyDWPk4FQiJkHifAuvAB5mwIvyzd/Nl34MmLRkxDwv0132GkhHuYTq6uKss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=eh9ot0F3; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7399838db7fso4297104b3a.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 14:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744063024; x=1744667824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OjONuyVEBabQma13n193abZmpu8eJbu2Vov0N/Hvhgk=;
        b=eh9ot0F3jiq8LhMaZ6ne8MoT+yarneDrai1k/0P/nhKsF+rhPTQBfJQZaVLGm+HL8g
         xysK7datB6tVZsQtYjYZkh10/E8UqASto0uwq/ZR+jhwhgmsf7doks/QfS1c0ObX9b2s
         1YlKVlBDcFkUwAKOLtVbj3y5og4nFr90UX+x3+oT+wu6yx1Mg7qIxx/7u3MHiZqrvGPy
         2amQQKE6/YA/6PucttDhz2cs2MA8XSOY9BKgb89hW9e/GsPJzAOaARvjvRE9QUnFkRwr
         KEXQFkMWS1H7GKor7FA9RIbiGm3Gnx0/jSpwezycUeQs9vr8XUR9aZTptdlpY7VUxZoY
         kcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744063024; x=1744667824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjONuyVEBabQma13n193abZmpu8eJbu2Vov0N/Hvhgk=;
        b=HBGfUoruo2HtGYqdQ+pX3S5dWHDTgTYXzfB2YsE+fzSXqgX0ppTBxUgGFUaXub9TS0
         JnIU5YJiFywrZeHyIZ+KjV2Eb9gJxsFyEHUpfFjRTnCb9zNZUkFhhFc7YfD7FxkAmU8b
         LPKyose98dainxaoQR1DDgzjT401iXYHnC9T13H7/KqMPs4UJ7vbs2kwSbDTrYBo2E/Q
         hKH9vb5TUU2CoLDQQcHXDWeGb+EXESfIkmoc3aX5uhPcbYpsIGVbKEoM+pwWZOUjFWGs
         1o96N36z9Vc57a0CJtzIjLIuOULfZUAxexG+Vfvfy2WX1VLtPKEWRrIFSxan9++m9di2
         6GoQ==
X-Gm-Message-State: AOJu0Yz9C8XkD1nOS7rHS3qMr9389lsmr4ErEwF0hTeV06ofmQU1sEEi
	MPdrl22geVRvQ6YaGVJCi0PVX2f5OQSA94ojqacdPp3tGZKWo5TYpQOoWrEmVZsyzeXLYNYGxZw
	=
X-Gm-Gg: ASbGnctvAGYT1DRHfzTdKlRHShhtfOPECvdO4sgqxa+Bz8ODHxAYAQzRXBnKTm+cxxR
	fo5kWy5WRWcXbygku4Kc/510jk/Qsi0N3kjugc9VZFlnOV/vGBcoEesVKkuDqopQfjOeDK+kBEb
	5bFG1r/DPKrTfhDMX0dY1CEqd1EluCffJb7l7xenBrZV0rH+nfst0jcaIEoWw1vjDc5Jb+nBJqt
	JgIIHIomXD8egPsjyD8Ie3gfVuCM6iWE+XrgQBxwKR6JZb2v9Jg5JQKYzDAn1co2OjOr2uy/ext
	/Qt2R3kNfeGcS3aD8TCv92fs3/DQEE/+AzwH9jakI7L0+rnwfm43/PR+/MLahmGtIWzS7ej3pad
	Bwrw=
X-Google-Smtp-Source: AGHT+IG5lEHLJyzIz19sfe8HcprikkgM32nxxTCAttYwDTJ3p2LAnqTiHsS4v+jrL5vhkcABNLAkmg==
X-Received: by 2002:a05:6a00:949c:b0:736:5813:8c46 with SMTP id d2e1a72fcca58-73b9d3d3187mr1735267b3a.8.1744063023748;
        Mon, 07 Apr 2025 14:57:03 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c3:b109:bcd7:b61f:e265:af16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d19b9sm9016047b3a.23.2025.04.07.14.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:57:03 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	pctammela@mojatatu.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: tc-testing: Pre-load IFE action and its submodules
Date: Mon,  7 Apr 2025 18:56:56 -0300
Message-ID: <20250407215656.2535990-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently we had some issues in parallel TDC where some of IFE tests are
failing due to some of IFE's submodules (like act_meta_skbtcindex and
act_meta_skbprio) taking too long to load [1]. To avoid that issue,
pre-load IFE and all its submodules before running any of the tests in
tdc.sh

[1] https://lore.kernel.org/netdev/e909b2a0-244e-4141-9fa9-1b7d96ab7d71@mojatatu.com/T/#u

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 tools/testing/selftests/tc-testing/tdc.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tdc.sh b/tools/testing/selftests/tc-testing/tdc.sh
index cddff1772e10..589b18ed758a 100755
--- a/tools/testing/selftests/tc-testing/tdc.sh
+++ b/tools/testing/selftests/tc-testing/tdc.sh
@@ -31,6 +31,10 @@ try_modprobe act_skbedit
 try_modprobe act_skbmod
 try_modprobe act_tunnel_key
 try_modprobe act_vlan
+try_modprobe act_ife
+try_modprobe act_meta_mark
+try_modprobe act_meta_skbtcindex
+try_modprobe act_meta_skbprio
 try_modprobe cls_basic
 try_modprobe cls_bpf
 try_modprobe cls_cgroup
-- 
2.49.0


