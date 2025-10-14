Return-Path: <netdev+bounces-229185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 726A9BD902D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1030C4FA330
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A627430594D;
	Tue, 14 Oct 2025 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeKEGhA/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6B8305063
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441212; cv=none; b=TTurbGabv5aVPOXyVCfO657IJF8RUDHVOd67AebF9nAOcHGoY6lxLuUHsMV9qBjQhXNvGsBRwzOctA4ldaYFDd1mpu1u6a6fd65G23MmSqVyaCbTTDmRHPI8hFB25o/Q3pg2S4Tzcrx9VsMNmcvZvwJJQUtD0wHPhUy9cpp/bF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441212; c=relaxed/simple;
	bh=sNtAJxFaO1bpsJ7T3EFg6MpOu/5KWOLXMsJW6BF7Sqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nZPOh28LuaDr3bqBIjE+L5Fnrapm4zpNnr1LJ8ylA8EtbPbH3MQ0laT6vQxpkhcr2E0HkVCD3DcYyDSzmWh7pHe+RgWP5vFFeRcx7r8sIfW/eDharMOKU9abjX00vWcTLlMr0SUafKV9npbia06rN9XPVGVtKBwxfc1d38lhJms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeKEGhA/; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b554bb615dcso3584195a12.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 04:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441210; x=1761046010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQ2ZoM9E45cLB86EfukwjzrhhG8TE+RmWdJSk8qEjw0=;
        b=PeKEGhA/IfX5/RkTE/OapFrsy8wQfceTGaJBlFW9uHP5+NIWQH182VSX1mEJChC28h
         asK1BcEd662cPcTjp8tM7/fDQYfCaUf5B3NU0lELJw1GKMarMwJg1APbcmVvqfeBNbgd
         AJjBOEnt2ggE4f+nEvY4jqeS5AHtPLK67lxyw4rJ3+MOqz5kdXPoI5vg2TCfvpHB7MB9
         DovhyPxnp0XhSiqTepKh2UGA6PLlywTJdYKC3iznVasexvsGfLfW+nfM571vJ7oLhIKR
         OTiWGSgf4XXJcc67FVnLBog2vJ/MARka/IfdvlNYsg0XtDznLInZb2rg6fFwoNtcDfMx
         HNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441210; x=1761046010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQ2ZoM9E45cLB86EfukwjzrhhG8TE+RmWdJSk8qEjw0=;
        b=sejw4kL6ZyKWdqryBkhtYcp0byC3LX9CFnkho3dNhipvbUMv9tU8d/lw+aLY1Yd3b6
         PndMfJZHWNpqVLOho5FsHH7kezrdbp8mzCL2jh5wsiQi8Pbjwtq+DG9NIMJ3l35HX3l8
         M+/KuqPLMgdH36Rj8d9NHq+sG0vftoAUqvFRPUtmpwiZCHaSOMyVYF9b2iB1D6GIZfsK
         Q2kJqz9iL4LBXAxhiuG9Ot+VprsJr2YrjMM3Y1jBpPyaw9dnBbyMl6grKGTS9fRHRsEQ
         CSteTQ7ht0T/lQlqEgoh5NXZQ+uwKdzCJfQ7QyWo95OIkcBCdFacw5l9ovdG05/FB1h1
         Q9lw==
X-Forwarded-Encrypted: i=1; AJvYcCWANrrvyXPOHG7+CSdSczepLtNMc5+r1/DGX967VT5p+RXLFeM5UN0AQKgGaOuNsU9/3zf6F7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym0yLfCIE2clCXvX8mZeghRiRrp4vgSrl02rpZuh/0ivQ11VjW
	vdHk2SVVQpjhMI/GDaEBePPd+IIFnwKCEiLlXAyTXXvX2GNGoX4Fp6j7
X-Gm-Gg: ASbGncs2OCvLArj0EDi0XqvrSO2kawgoh+EwRrtaEZw4ngOon8UPbNfcQWL6uIQJeyH
	AxIYJrzG2qICPfQO5b0KikMnCkkCk9fs46T8UwsYG18xQvmKGCOZT01GuxSJGtn9D3umVS6Rp/c
	srtNb6+sfPKNJCUmsdcotDiuUtybQkYqJtAcNezKIBcK4BoX/Y14OgoFreo9bYDBko9If9Pa1Zp
	6U8mi3VUxoKTkp0yAZX+5JgZGsLZGANg99JXiOoVEEeXLYmL6RSlHJH9/cP/A7a9Q+WrQ3UdFb/
	GyBZs88GwFReE3S3qFaorUJ1gmK/EXQhWOjeUBFzbZwZX51Vndl5Rc16Cs3of9ktWCsJx+v5pnz
	YclK4aAI6XnCHNdJIS1JRXZc7pz3gGMsFS9mjHgbiLg==
X-Google-Smtp-Source: AGHT+IEI2EG3hXVYjqyv3KTySouxEuLylIu1QpAbH6omychwoEa9DKSUCImhv1e9qQ23Bulue/Ky9g==
X-Received: by 2002:a17:903:1510:b0:27e:ec72:f62 with SMTP id d9443c01a7336-2902728b8a2mr307225925ad.6.1760441210407;
        Tue, 14 Oct 2025 04:26:50 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e2062fsm161807285ad.48.2025.10.14.04.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:26:50 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	paulmck@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jakub@cloudflare.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 0/4] bpf: add and use migrate_enable_rcu
Date: Tue, 14 Oct 2025 19:26:36 +0800
Message-ID: <20251014112640.261770-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, we can use rcu_read_lock_dont_migrate() for the case that call
both rcu_read_lock() and migrate_disable(). However, sometimes they can be
called separately.

Therefore, we factor out migrate_enable_rcu and migrate_disable_rcu from
rcu_read_lock_dont_migrate and rcu_read_unlock_migrate.

And we introduce the function bpf_prog_run_pin_on_cpu_rcu(), which is
similar to bpf_prog_run_pin_on_cpu() but use
migrate_disable_rcu/migrate_enable_rcu instead.

The function bpf_prog_run_pin_on_cpu_rcu() is used in following functions:

  sk_psock_msg_verdict
  sk_psock_tls_strp_read
  sk_psock_strp_read
  sk_psock_strp_parse
  sk_psock_verdict_recv
  bpf_prog_run_clear_cb

Menglong Dong (4):
  rcu: factor out migrate_enable_rcu and migrate_disable_rcu
  bpf: introduce bpf_prog_run_pin_on_cpu_rcu()
  bpf: use bpf_prog_run_pin_on_cpu_rcu() in skmsg.c
  bpf: use bpf_prog_run_pin_on_cpu_rcu() in bpf_prog_run_clear_cb

 include/linux/filter.h   | 16 +++++++++++++++-
 include/linux/rcupdate.h | 18 +++++++++++++++---
 net/core/skmsg.c         | 10 +++++-----
 3 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.51.0


