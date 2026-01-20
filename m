Return-Path: <netdev+bounces-251361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D5ED3C055
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 08:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC838508FDD
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 07:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCFC36C599;
	Tue, 20 Jan 2026 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlcVGwHN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E8736999B
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892779; cv=none; b=fOtxbD3n1hcYyX3k1fLFF8Zy1SKrcUU1XfGWt2P6V3cwtu13NzzDj1Rv8zUYG2+RF+JXJiBhK2QVK6EJ/FNte15R7nwadqx3rKSrrQMNoX+X4lMQdaE7RDCdMA2560BGm3ZlP95ZVlvQLSYWzJeA9J50gkE3JdkaDzgGzoSn3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892779; c=relaxed/simple;
	bh=1TZK5fhyrxC/WB5sP/wiLMfRj4jIbse4KsMa+ws3+jU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c0vqp7TJmLbQ4qSndMw0+q6MNjLFjrL3E7YVAj+2sdhEVQcd2aQpTR3NXNfji+Ldk9mWu7MHgylifkRywrG2/7kzEq5ecDeFPU4SewMuzBjXR3pxvnGXEUB/wieaJof8PpQCsphiudxbaf1Dq04+KdjjiigTCR4/1N6RoN+YkXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlcVGwHN; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a0833b5aeeso51399335ad.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 23:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768892769; x=1769497569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6k2o46vNuTzPIheaA8GctSKLua8DVfbF5bh98uIEOBs=;
        b=LlcVGwHNAccCKm5daWRmSKFd/90GJ8vdq79Xalve6JxGkUwZ/P4bqRzUe2Shbunc/6
         NOS5ZtKgpK5HA/4+urzzf5Yv7fSA82/ZPS4/akj+/IPCmPqDgQs0MAHEnECseFL/zror
         /L4s8QPx5FcvfSaA2EHnwRW0GaSJZyUyFh5KT50DLnJn28xXhJfG0hME/WKnwjupAvGb
         VKov0RBEGAT9A9VEojAgO6PdygkcPz2pOnacR+b38+vq9hVUfGyb+exbBYUoB7nZVg0C
         aopMM5qR0zMGPNjmSRyDU2GmkcypGj7s0hhpuH+j2kD12te983jiLFHlLx5Q37/wr79b
         OYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768892769; x=1769497569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k2o46vNuTzPIheaA8GctSKLua8DVfbF5bh98uIEOBs=;
        b=EYTsjR3jtCUys0t2s4pKYsHfDHvtgGtvjhK0cJDY/fKP8SIFxgScrFTX7+fC5zyWi5
         qmViT6MFZOjzjgLHvrx6Pv/V8qOwfLLmBzdkM1b/FPKElQ0kVmvqZj3HOpFRrSzRed2x
         Ij8uZrJSjqHyoxN0StbZFezD+xqQUT5cfE6Tx9yIdbE+cvuF72RY3XuRtRgpRsSwDABI
         qgMlVudDqVuEmXlz2pSf3hpy6ss0PNTbbjo+CIb0UHP5VByRlssgPBZHJlPRq63P8D6c
         Hhkb2P41086ZsOQqNrOpaUAqAGP4Z/x229lPTJOZmHSAiaTm8XZ/ObpfxKJ7moMFABJf
         bwqw==
X-Forwarded-Encrypted: i=1; AJvYcCX6yIMLniW130AHewSUrp/Xh9J1NKBfRdrWSZBYsSsrGZT6BsiNMcSM1Fq2eWOGxm4ypPn9O7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcVBxvl31zsGi1lq3MzUUcBtvIN5frnIIKezEbMNV/onrmubg9
	eXxHAUNL10Yd31uGZW+4RuNDXL1uAUWHHWo1Z0WK4ng9/3r4Iknt0KHJ
X-Gm-Gg: AZuq6aI8VNMZcv6j+nHH/YxlJgRooo6+Djg5sONFy6jiYljA2Os7I110UibQf5kUfYG
	nsFjJmiuxUAUnAM8EeXAwG5+z0Fbk0dkYFhnjOBBxYI57h3/3NZp0pSKnOMTeQMQXLvOiH+0urm
	J6PiRpgixSY/8IpoDnAoZZhDnG/27z4Mp/7iOh1vu+xZwyZVc9ziaNAoXrTombIQCkmgoo+sLNg
	dnxc96okOwYaUw9KamAfaQeUD0oFx+wbsKb7tiHG0UtTviBY1sBBDW/Z36YZbhrH9O/68vvOstt
	/QZ7UAKMgzY2vNB9BIwh/WaY2J/FjS8MGwZulhILfVT6TOlkvB29mv/0o3FN6pA6aUR9C8zRFWG
	u5BzVTVRicEebfqsjN/1jp7PoqRnCWj6ycfy/eYLiB+3HUc18xjkSVE3Qi6dgI0eJJmeO9OiaTG
	jz9u0CZX7r
X-Received: by 2002:a17:903:17c3:b0:2a0:ed13:398e with SMTP id d9443c01a7336-2a71892193cmr102832235ad.49.1768892769464;
        Mon, 19 Jan 2026 23:06:09 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce534sm111695665ad.27.2026.01.19.23.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:06:09 -0800 (PST)
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
Subject: [PATCH bpf-next v6 0/2] bpf, x86: inline bpf_get_current_task() for x86_64
Date: Tue, 20 Jan 2026 15:05:53 +0800
Message-ID: <20260120070555.233486-1-dongml2@chinatelecom.cn>
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

Changes since v5:
* remove unnecessary 'ifdef' and __description in the selftests
* v5: https://lore.kernel.org/bpf/20260119070246.249499-1-dongml2@chinatelecom.cn/

Changes since v4:
* don't support the !CONFIG_SMP case
* v4: https://lore.kernel.org/bpf/20260112104529.224645-1-dongml2@chinatelecom.cn/

Changes since v3:
* handle the !CONFIG_SMP case
* ignore the !CONFIG_SMP case in the testcase, as we enable CONFIG_SMP
  for x86_64 in the selftests

Changes since v2:
* implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of in
  x86_64 JIT (Alexei).

Changes since v1:
* add the testcase
* remove the usage of const_current_task

Menglong Dong (2):
  bpf, x86: inline bpf_get_current_task() for x86_64
  selftests/bpf: test the jited inline of bpf_get_current_task

 kernel/bpf/verifier.c                         | 22 +++++++++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_jit_inline.c | 20 +++++++++++++++++
 3 files changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jit_inline.c

-- 
2.52.0


