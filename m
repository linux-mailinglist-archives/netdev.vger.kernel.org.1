Return-Path: <netdev+bounces-286727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM+gL777AWomnAEAu9opvQ
	(envelope-from <netdev+bounces-286727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:54:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 68531511A2F
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4583230058DF
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96E2402435;
	Mon, 11 May 2026 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU0LErS0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0392882B7
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514743; cv=none; b=UKbWHfsVGLtfPryQBGLu2sXgvaBZRszd7rPSNppAKo2/EsbWCxUYYlzKX8ALGiEnE5gGNuYp98emhpe1lh9z2QtxCGPHSXjyDYz5/GUJUul8YWcC/HPe/HxYr50Di79HS/xBEhahHRMu4TllHjCUGj6AvtnTSsPVlZJu+iAY0zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514743; c=relaxed/simple;
	bh=PWnlaH/VHoTBHOyKr1PYCeLDcl360MRWwN1yVqXU1DA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q74hRRtnASMuQKH0iFWouUuO2RuJUyE/6QAM58hTeJY0OL9utIOY8SN2gaivbwPm9o8NllYxo3JwPLIn9tklph9GHWO2/rB/qsfhDTq0ekURFgiHPbXRbCziWJToaUna9a5W2oSV1MnxM/fSQGrYnlai9txJ35tGqmgNz57AsTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DU0LErS0; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2b788a98557so33252485ad.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 08:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778514742; x=1779119542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iw6QRvTV/LMuhQQo1Dz7cJ7TZ9rzFIru8u2Y0e3Fkk8=;
        b=DU0LErS02UtFOz1CvdprQDo35r//v/63Q0MukmppoF8KpLUXsXCXSt/4snMFe+sC0F
         SBNfGh1gbwrTLMfNotbO4A6N2M5cJ34hE1xC2//3mrBzlDc2aHY+ku9rz5136W/KiYER
         Q/ZyLpO9Fj6SlLPHaEQ3B/zeLMJXXGpS+bOBt25A5YPNmsfG+UkZMvtC1U1zc5HBXvl0
         4RxbBJ24i/hhgGTNo+QleD2jD9QervabuJMAg92s+cRw0eif9ffroQAVeqT/szrqlOfK
         PppDdwVVgSM+QSkw7Q1iQschiJzf6vro29h0k60jZafDD/zTG27hunFHDvTEMCTbxIc7
         Ndgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514742; x=1779119542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iw6QRvTV/LMuhQQo1Dz7cJ7TZ9rzFIru8u2Y0e3Fkk8=;
        b=eoMFTY01cVH42H9DqXFFy5LckE5tHmN5GTDXtyV9AM8WvtDnxln4z3P9xAqLMDgPqv
         iX3gzflHFGdOX8DcozQc7OcsqQ/9yRf7IWGrDZy2M6cxKxISjkHbzHm2nyojyTYGhoQg
         eXW559JnKew1FRS3EHoE1w3StguHHZ2k2/2xISl+jNV7XWYYXq3coDNQxUep7UFNxz/3
         VnWoHDvtD/GKWUSh1ryxeTqyxfpXSydJqRQY6W+D5b1Es9NPARtKG/Tz3iqRSkGyxz7D
         L6pgVmqWMfVVIiTjOqBdaTsXHq98qf4F2ngRnl2uuu4AmsP07aBoxFnn6xq4Sk3ssmtf
         fXqA==
X-Forwarded-Encrypted: i=1; AFNElJ/m2FkLVAzgX6/tiLAQrtR+DUPeQ2eMUhYmKSIkb2EU7TnE0l0bWh0NgC7HFfjOqj1H1MTmGn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzto5oQPygRnj9snzWoC7ZwF6KMvIMJVdt1MPLikZz3Ko3lKyjx
	yDt3Fzwsmum0A8lAT2UHKACgM7oYMqTx5woQklcuQoEnsJWy1IQRV5qD
X-Gm-Gg: Acq92OGwkJYB5RDcquN6ul5bdjWGVb6mAW6JGLdNAJ48ewxgvTBa+rSK8K2PDPJ+e2U
	9wjsd1y6WGEWuHkzQTGwc5f21XPJ4z41g4DAEv3QCYjtbZFsGhgf5X3/b2ckV5VK6hzpymDTCs6
	qQUWheDJwE2GYz3qkWs7ogaLafawzdKmKD/WPX9MfkmYmfwFGlQGPudD6OrVST2ufEp4zcVI+cG
	PY2jmYbcAA5q01fXDAAxesqkEza9FznHlF0llm5Lr1w5i2Bli+bk/rN/7483/ASxvll1jT9dSDj
	pOcA/V7JJSw+kO80Bte29lLyy2vl42maYOXHqJ6jO1hVZkre2O8xUrLpeQFPt4qhJCLGPc3Q6rc
	hCbsXTGfQ5NHi+eV2PBYZPQhZN+vXEIwJfhMX9fp7fw97Pgb+ONv8iP1tolufAm66a3tPfILETc
	9PJBdBbdI92PHxLf4cSOXahfXnCDUEErEuyHo=
X-Received: by 2002:a17:902:f70b:b0:2ba:5e44:ce8f with SMTP id d9443c01a7336-2baf0bd5421mr152532675ad.0.1778514741911;
        Mon, 11 May 2026 08:52:21 -0700 (PDT)
Received: from fedora.localdomain ([222.20.193.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e78c6csm112117885ad.60.2026.05.11.08.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:52:21 -0700 (PDT)
From: Xingwang Xiang <v3rdant.xiang@gmail.com>
To: john.fastabend@gmail.com
Cc: kuba@kernel.org,
	jakub@cloudflare.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	mrpre@163.com,
	Xingwang Xiang <v3rdant.xiang@gmail.com>
Subject: [PATCH net v4 0/2] net/tls: fix UAF when TLS_RX is set on sockmap socket
Date: Tue, 12 May 2026 00:52:07 +0900
Message-ID: <20260511155210.32926-1-v3rdant.xiang@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 68531511A2F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286727-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,cloudflare.com,queasysnail.net,davemloft.net,redhat.com,vger.kernel.org,163.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[v3rdantxiang@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This series fixes a use-after-free triggered by configuring TLS RX on a
socket that is already inserted into a sockmap (the reverse of the order
that is already guarded against by tcp_bpf_check_ulp).

Patch 1 adds the symmetric check to do_tls_setsockopt_conf: if a psock
is already attached when TLS_RX is requested, return -EBUSY before any
strparser state is touched.

Patch 2 adds a regression test to the KTLS selftest suite that drives
the vulnerable setup and verifies the kernel either rejects the
combination or handles it correctly end-to-end.

Xingwang Xiang (2):
  net/tls: reject TLS_RX setsockopt on psock-owned sockets
  selftests: bpf: add test for KTLS+sockmap reverse-order UAF

 net/tls/tls_main.c                            |   9 ++
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 109 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_ktls.c   |  21 ++++
 3 files changed, 139 insertions(+)

-- 
2.54.0


