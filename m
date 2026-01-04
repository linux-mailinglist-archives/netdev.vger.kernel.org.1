Return-Path: <netdev+bounces-246758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA42CF0FAC
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 14:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD025300E027
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 13:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5462E3016EE;
	Sun,  4 Jan 2026 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bf9kh3Y/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4F8301015
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767532616; cv=none; b=R3zaZIBs100QSn5yKPwZ6Db9SUUSbOJnRnWA5J5kMyDZwatC3Myc8ZR6c9HunbEqEkIL6+eChsfXVE2bqsIMPhb2e00rvLfw7DnYKYJkUUCPYF6+sbSlAGZVYqJVOZ5VJN1Y6K6+WLsiwZqVAK5nXr1Q5HTtK3U8Znm9+eqUj/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767532616; c=relaxed/simple;
	bh=m1Wr3OPL8/Qr5zlyB2IePNJAo/TwXbcuTLfdufW0ZsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZcsgNPV980iobji1B/ziHa8jAOOCxMtklFYQTJyhz5TTW0S0KsXJq/MVqIREBSnoaoQynQn1VuNMqgPfedo7etzz6iNePVywBvsn6FU8FrfEeveot59IWKownFG9ug+3cFbOmWAlNCg1j+2kF6J4yFywEZkTJBP1InHpz03Y3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bf9kh3Y/; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-34c84ec3b6eso16927074a91.3
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 05:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767532613; x=1768137413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kY1VizcfhsnSYv6g6C9J7o/m18cVK0abRI2+TAwroyU=;
        b=bf9kh3Y/RDgl8ZQZA2m4G0GvwUune41foelNoSpY8r+t+kuChL33j56F76Uim9lLgn
         b0AY5XfUhGp8icxxd5ZSosDVuwwqw2H5rI0iL7DlZPaLSeHeke0+1UTYjtDxl0DRGqqO
         j5jWOVw3jyxpkzXKOMwYeki+pPDpStwugDdQdu+jFCOM2GAedPjWjBVuN7tZmKsTy7+u
         JxgEMuDZZBxcgXg+dORoVEpWeJMqJLOW/gZneqCCmMB3Pf+piTr279sQuboy6jRGhby7
         lrzOFE7K1AQB45XMMlVa92mzxIMscDxbsU3NKKtydet724RgkgKSTDUw7+f7BdQluefU
         Ns+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767532613; x=1768137413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kY1VizcfhsnSYv6g6C9J7o/m18cVK0abRI2+TAwroyU=;
        b=aSaxkDY7UsUdAGcNkyzsKINnaCtTEy1mq/dtUNN1mFzpKzOJ5Pb/0Avi7SdcHGXnKl
         LUCfbegGQaiDRS/tCDs7g1ZmzVdwh++8FYxBc78fO2fGZAS3XW82LJqA1guWCqeajgO2
         YeofgjNXNyfKflWcebA1TrAUB6ssLhyOOsI7n3zKVHv12cxOS1UMVfkXARN78qgZjntH
         ILTcUdf4pWIdmTRrmP3qQL/JYqJkUYypFLjC5vRezQilhmng5FFmBa7Mw0iEHBmntqTe
         dxM8BNyxzyKYds+V9wvg4WdDg/3AKA5trUB9/mcrwNmI+GOLJ+XwLM2O5GvjpuJ3jVFu
         7Dyg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ3W/4wFQ1qPWdqu0BeNJlA4qAzVtz2eC2D4BEYTWfdgivb3S99m4ccpggsA599z3LVZqNpZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBftZ4idC2nXti38/oO9/qwVX3DMeGHGPhSEerhous0A67tBHd
	+cZ4tHR7ZLT/Xrq4AI3qUwoT7vV3yR9QJkGrUcIjGDWSUmWAqb1dymYW
X-Gm-Gg: AY/fxX5QFlPHBFY7yqCpPB138ydzh2piXTHfbgj7NSjo4kv/wH0EPmfsnMzFCttIxd1
	hS5lG2TQYXr7KzKM16Vf3YM1TVZr9YsTjC11g7lVrz27Itec+mTDRBXFL4Z4m2pOBCo1/qNqhX0
	N+AiRwSiYz//KGZBMNlYZguCxzS+S3xLUGknMt8u1Q7eswRtCfSLEjXjj1UTeutH7jFUgdVC2NI
	QPW3WbPBjaYiuv+Se2KKOm+ds1qxGJCu+etRgP0TvEYRbr0fAVnkox3SIpSsBsONfQsJIVaP/9j
	zHpdLUcpoIUUgLSPrQ7H4+uIJtm7Dm9rrikgn9ZAoaiwx3WkvXMyYX3kFmyLhtsjhVbjeXUbEi7
	DIeQvG9ScDU9p9r7gCbFEkrPEwUMgg9YQCDYXnq6V3tPDOo1zIaTxh/QESTKrGGpaFVTPAe0zTY
	Fu8/2Q2OY=
X-Google-Smtp-Source: AGHT+IGgT1Wfsjj+Cb7xUcXjdG87p7VIhwzfAmHmsHRk10MVlBAltbjJbksbRxZWurNRKRVj1ChHEg==
X-Received: by 2002:a17:90b:1810:b0:34a:b8fc:f1d8 with SMTP id 98e67ed59e1d1-34e921ec5c8mr42434214a91.37.1767532612854;
        Sun, 04 Jan 2026 05:16:52 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f4777b765sm3701582a91.17.2026.01.04.05.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 05:16:52 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	eddyz87@gmail.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] bpf, x86: inline bpf_get_current_task() for x86_64
Date: Sun,  4 Jan 2026 21:16:33 +0800
Message-ID: <20260104131635.27621-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
to obtain better performance, and add the testcase for it.

Changes since v1:
- add the testcase
- remove the usage of const_current_task

Menglong Dong (2):
  bpf, x86: inline bpf_get_current_task() for x86_64
  selftests/bpf: test the jited inline of bpf_get_current_task

 arch/x86/net/bpf_jit_comp.c                   | 34 ++++++++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_jit_inline.c | 35 +++++++++++++++++++
 3 files changed, 71 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jit_inline.c

-- 
2.52.0


