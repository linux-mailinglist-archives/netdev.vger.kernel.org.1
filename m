Return-Path: <netdev+bounces-143287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B399C1D1A
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 13:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6AC28288A
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 12:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906651E47D9;
	Fri,  8 Nov 2024 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0FzW17C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58D8322E
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069508; cv=none; b=W3J+H6rQ8Z+YShZETkBnV5qMTK+PlLocZtPdg+hr5fYidLiYzZBKdIb4LwhVlXjucv9znrrm4hm7jPkg4BXvAV6Fs8ES88OyWuczBJWR07Ookv2R6jBEvtqDhHM9aLyuYlUdvVBWmVn147u52fwkmQOudTX23mmWU5lr+AMvE6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069508; c=relaxed/simple;
	bh=6wNOGXghybHRjd5Urfpl+TJMg6I0IjAKfX3B8lHzhZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oCdwkeoIzFSVClumrJSw1xNTRGg+pnTIgzK2Q1NtCxw8N13fBrXQF54wofFfeYOje3/YR4Bkgyi6GUpKtkJnMBxeLqk2PmdkNzVD6fIjpA9BszgHn/gQkiLUfi6NxUQj8kZWhduVIIWCZhd846HEPNan9VS9I9pd7f5NmGhwfvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0FzW17C; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so19339805e9.1
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 04:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731069503; x=1731674303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K3H5aaqvvUtm0M7z9v4ikRrSREN7F8COBwVfgaYY7Yk=;
        b=b0FzW17Ch6p3WmhQvtrxBvACyUWobqh7bt4e8VH0yzfjcA8d0yfZPUSMpgpan+Th86
         JkCgM3ruzLOCWCttVeyiaCP5GSEOxxX/SX/XlmBbix9mLTxzjasXGOiNUGW4b0gtnNZi
         y3Kod8WPQsDjGWFnvIdFxuE6s/p2pdi++hX7IQHnJPOzV2vw9b3OLME7G5IfG3IrfX6y
         7C/+FUJk287I8hSeROZiqskqHnqgSTBkVUbQrDSJy9M6RfHqA7pYhcYtGCuTWlYGcG2a
         DbE6CCX1RPMNtlgt9S/D1YVsUgKaq8w9N2Vy8bnGTmffwScFpEg30kmK5elO0dIQclkr
         LyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731069503; x=1731674303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3H5aaqvvUtm0M7z9v4ikRrSREN7F8COBwVfgaYY7Yk=;
        b=J1MkvDmIlfBJscvtNMwaoFfOugO6/XYAC1xYqLbYTWGJ3Co6R4jYIae3GPwSCufJ1R
         hrxUS6YRNcPXQYqpPtgxVrtlAIWOVFwpDwg/L+uGExZq3/N5l7fcCVL6IIsQJ21X8RAI
         YoUP2wv1Iwn34VJWNdXy/7t9OdLjHkeC7soxHlAY2Qazjv74dxvkIL1P6k7L7Ay3AsSQ
         oXJ+ftflTa38I27TtkeIt84QHdEiFf0upMlzMGxqQKpCAXErHOQ4UO9CD3pKyXrOBmY8
         ALY5TzErKt+ZGahKXCctT7ti4MsYJVUjgCL5Nq0HaWYSoGvSZG759FcP9Es2FVGnQHSI
         d/bg==
X-Gm-Message-State: AOJu0Yx82p+TYbiOKe+HnVqG9vB3yczh18fH0sZTANzwnPqLSii192up
	CkVU48ID+cjdtNqUrBBaIqJNd3cSsiaKiEPrnNaZr37j3TNRJ+TzZfnvlvBm
X-Google-Smtp-Source: AGHT+IEJX5AqCpocuAEqrMyt8+XO5QnDsVSDbTHg40d9EF5RI6XpKnhQvPSNmgvHSXABYarE3LcHTw==
X-Received: by 2002:a05:600c:35cc:b0:430:5356:ac8e with SMTP id 5b1f17b1804b1-432b74fcb49mr20560775e9.5.1731069503083;
        Fri, 08 Nov 2024 04:38:23 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:68e2:1bff:d8bf:7339])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c1f56sm62991365e9.34.2024.11.08.04.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 04:38:22 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Xiao Liang <shaw.leon@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 0/2] tools/net/ynl: rework async notification handling
Date: Fri,  8 Nov 2024 12:38:14 +0000
Message-ID: <20241108123816.59521-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revert patch 1bf70e6c3a53 which modified check_ntf() and instead add a
new poll_ntf() with async notification semantics.

See patch 2 for the description.

Donald Hunter (2):
  Revert "tools/net/ynl: improve async notification handling"
  tools/net/ynl: add async notification handling

 tools/net/ynl/cli.py     | 16 +++++----------
 tools/net/ynl/lib/ynl.py | 43 +++++++++++++++++++++++-----------------
 2 files changed, 30 insertions(+), 29 deletions(-)

-- 
2.47.0


