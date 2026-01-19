Return-Path: <netdev+bounces-251024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 305C9D3A2A3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 263D930146F3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485A9354AFC;
	Mon, 19 Jan 2026 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+8dSBwM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2283502A1
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814196; cv=none; b=fIC1/sPXT886fif8YLcoLpLmbe7mUaVEtkBw0/Tdkd3PHNQk8rvS/1ofDnfyLWQQlCsaYIbRQnEGQ2zTsL8rsSk3NH24FH0FYp1KKb2YsGmhZKL1Ujbff5JkEhRxm4030Kf+HMWdnzKMZIdcOBP1655q4PFvPpuXyfZRnDGDqVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814196; c=relaxed/simple;
	bh=q23gHidx8498gkMO0yerRKpzSoSAJw6ifeIuU1lw1IA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NnwggKJuU0v6vjH7eHzSjm/m7A1drQo4RYoLdC81Ikwz4DzQzRif+WdxvlhVcNQfp/wcA8+jH3vKuL3gbcagLqiUbvbFIopR//o+tyMbIKV/QQWDgXNPwquk/hgwCHd358QKCtg3PRRMS6ysIDBpWqgTnIj3Zc5nFcTCtWtwXx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+8dSBwM; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1233bb90317so3152639c88.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768814194; x=1769418994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uIo8Sy0N2c9CqC2cXQ6iQPPYdQiGFGtp7sbsHVq8k5c=;
        b=P+8dSBwM1TRHVF4dPEWQ1x2i9wRqLgau5eb8doAJRcbFaANnLVUowArPtN+t5cnxFT
         Zca2U6Ru3UkCLqrrcbQXCSQU+SJeYH47y70IRTMFtBbcMVyRoDvMN5aL1HXoK/UwZb21
         icc1jgLRtNeZYQDonilf036vPc2bHLV6VlildpPUn/65r6TLqRWCEZjJaqvRI2sXjibP
         AqYjrCbLRMcAH5q1Im65ywRv63On0sgIpnKkTC8f5BNb3sJY+gX4e6XERZDkIsgXWZGe
         nCF4De1DRtU2RVTsVz4j/8l4p+HoiObklic0pmgR7aCbSPosNVaKHcHBE/ysM8iSdhpl
         x9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768814194; x=1769418994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIo8Sy0N2c9CqC2cXQ6iQPPYdQiGFGtp7sbsHVq8k5c=;
        b=CpL3zmNYU4stD543R7P4+Wv0V/ri9f+a4rtmqghEOuX6yiJy3Zq6IywnjA83uFBMHn
         +esolVlXHHn8M8vJY2txOMu5BV/aVTfu6rXMSUpXgBM24WZYuSAj0M70DQyK+OfsL5Oi
         s0AMBpIGRe0pb811clJy9eeV7mWTAUcxx+bI2U/sygj/mrtTAk+ipalmD/w8KR4z/Ajc
         93LVopEl6R1jGX9ltaiyGMuStMmAhhFFnM63/tDHoqPRE+hbUsciBgQePNnN/CsX/3di
         +CicVCAKxmMf4wGVAY9DEb+AeUopiByYnMeXBaqH1s+Nh+Ws/Cw07Kx30DFkzT3696Hu
         d63A==
X-Forwarded-Encrypted: i=1; AJvYcCWy4yhoi3BbEoQXqYMM+DyUJCjNNSyAxF4qdOgQgs/F51oK37dww1X5YeSt3SWTZG5AvZ44/jI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg2WKgx2wGHun2roMnYnxE1gnZY2ql8Ynp/+kBqjIEr/BDxdBG
	Q014h3gDn9ukCc7NcaLe/9PCPwGYun41Zy/Jyh1bcdGBUotljkP15hsI
X-Gm-Gg: AY/fxX4AM6VXJbjsWFOyEisvzdgnHg5NY63/a9hGCYiisJm+B3mYBf0X4S9yRiVcUVn
	CF2xB55H0f1Kv9acLGG3lV6bfSY+x2lJ50BoIuL6en/4SrNETQp6HBmsAxByHuNR3lMbgKZsDuZ
	Gdvb8sFSCH2sMGg9DRRyBkhj9cGNjhCGJ8SSBRksBTDKj1y/j+BWl+2P19b6y4LTlRmT2wY4+d6
	xuyhCU+kKCmwLXo290aK5X0h2K6Ry9H66tqzOJO5/XDju3Wme5iiFc57prwnf2LcfbTX2ZUg1Nr
	RDd/0hw0s1W8S6+u1ACyZKd8PEJOFWS/SMBj2v2c+m834MIetIXY2Shhlq67nbuj0aRhZErNUgZ
	veff4xpvA72i+OxfS6Lw8OPI2t3NaNSO+J/7KLI6p3GwBYIfSV4r6VMniFvAz+gfR+R+JfvjhfZ
	6uMlMIjDnJqrEBAKr+Dp4v8mKs98+heAqKVJez1riDQk7iIHjoUDacqjIrW3Isy4PJZzVCbIOk9
	NQz3Nqvsg==
X-Received: by 2002:a05:7022:e98d:b0:11b:3eb7:f9d7 with SMTP id a92af1059eb24-1233d0adc11mr11817904c88.14.1768814193959;
        Mon, 19 Jan 2026 01:16:33 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefa7c5sm15578577c88.10.2026.01.19.01.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:16:33 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: fw@strlen.de
Cc: pablo@netfilter.org,
	phil@nwl.cc,
	daniel@iogearbox.net,
	ast@kernel.org,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH] netfilter: nf_flow_table_bpf: add prototype for bpf_xdp_flow_lookup()
Date: Mon, 19 Jan 2026 17:16:15 +0800
Message-ID: <20260119091615.1880992-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sparse reports:

  netfilter/nf_flow_table_bpf.c:58:45:
    symbol 'bpf_xdp_flow_lookup' was not declared. Should it be static?

bpf_xdp_flow_lookup() is exported as a __bpf_kfunc and must remain
non-static. Add a forward declaration to provide an explicit prototype
, only to silence the sparse warning.

No functional change intended.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 net/netfilter/nf_flow_table_bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_flow_table_bpf.c b/net/netfilter/nf_flow_table_bpf.c
index 4a5f5195f2d2..a129e0ee5e81 100644
--- a/net/netfilter/nf_flow_table_bpf.c
+++ b/net/netfilter/nf_flow_table_bpf.c
@@ -31,6 +31,9 @@ __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in nf_flow_table BTF");
 
 __bpf_kfunc_start_defs();
+__bpf_kfunc struct flow_offload_tuple_rhash *
+bpf_xdp_flow_lookup(struct xdp_md *ctx, struct bpf_fib_lookup *fib_tuple,
+		    struct bpf_flowtable_opts *opts, u32 opts_len);
 
 static struct flow_offload_tuple_rhash *
 bpf_xdp_flow_tuple_lookup(struct net_device *dev,
-- 
2.43.0


