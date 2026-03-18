Return-Path: <netdev+bounces-268841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDv7Ijv6uWlfQAIAu9opvQ
	(envelope-from <netdev+bounces-268841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:04:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD852B4D31
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFC8830ACEFE
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1104A22B584;
	Wed, 18 Mar 2026 01:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G7g7KjGb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E341EB5C2
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 01:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773795884; cv=none; b=jvmzfylCnlWGFz1guWn9YSv5j/eSuP6C6KKFc7t25Hqu5gvt0yLCvlnfCTGVm7M3vbbaGGH8VbygRaR0+mteGXjzfvVUESNlMJOrgNXdS2B0lPO8ORdw3rwiM+BJvBDG/b7Zi+F9Kgc7Fi0LEVi0BL8CDIY1/90/3gHARyVzcVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773795884; c=relaxed/simple;
	bh=THzzDNF8GpfxxtI/EItqwopxBXguI9PXFA2AmDPRreE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Acvb16A+EbQbBW7rexElUc61F5IpL3oYbUN5CC3c9aGfEZcEhIrGi+45VfM1B/Hn/gCRs8BP2DDOIc1yON03Il0qLe6aVIzDRXMf6liyTg36qE2nyy3BgQUnrThHtiaxOCCWXvpr3y1Lnm5R0UkOJgO6VJ+tN34eNDU3BK2Gkr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--treapking.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G7g7KjGb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--treapking.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aec784479cso380987705ad.3
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 18:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773795881; x=1774400681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=citUlJS1cTHKzG0Mc8HWnWcaRo8SkwkYhwdVqJdujW0=;
        b=G7g7KjGbnWH43vL/CqCumIps8DTjJ8i0bJoLJXIZP+Nw2ZmjqL3uVMTMCRB/jjVPhU
         Uc/LQ9SkVGGWCva7G3lT04onzH7SQOHDOiXRBgHkj5yVMARE5sP2PfLK7gfYi14EC0aR
         xDZb5PJle2hB+LgzU9D7q9Mt14JAysnZA+Gec4JTIDsn1/QmYWU1PN9GU0lcvtTVQ1UJ
         GgM9AFxIK3BGXHAlVO7NUQeSY8nK4fE4OAdoesCF+9kXUuwZ5IE7oEKeqQfwbYqRllSi
         AssF/SbpKI58x4ld6luoRhRzT4z4+lT+FjDUI4LP+fURzk94QnzbzmGNfehT6rYru10Z
         pXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773795881; x=1774400681;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=citUlJS1cTHKzG0Mc8HWnWcaRo8SkwkYhwdVqJdujW0=;
        b=hEc5+x8UIPSPdxbCZk/pZHwkMcj1/d5XOEFJfoPtZ6C4ERIBtWkv/OqxGhtBeP9DKL
         20TXHdxzUOcuLKxqm8O7Rx2KiaUGvDn/PXgPS1CxEh8eTS8Ldb73nDrN2mU1fUt8dQg9
         lc1S+tzmXCP5QAzTlSQdkpTKe6PC4ybTfaqssfYiddyZlaEoK43qLbX47Q0Q8U8DcvAh
         u1GA5kCM1h5Sjxism/zAyVMASeL8AUgbRNjGO2+91GeJJjdrFu0NxrGgb4zNQnjoqhni
         ZSuWBAU+GgoAM5YzaPnRu4pNlGWe02jTxlE7DJ+BVUhfpnZSdv+fveiNf0NQk1rBMVV4
         J0NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ+tXhaUELIJlp03MiNw4n1beXPbEX8NkPZrYiPCIKMLhcowCbdd6WqWy+bDEd2tn9NjsfYvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCUDe5zvm36dc28EsXRSH71rFigr9gWwaOWhVhIIVnhbFC0btP
	1T7pObgJGJegBLzjJR1EAEXpE/t7TDhKtUYymteKA8/MRrPIbKyBZ0r/geCnzpH7qEuJLHN9gG4
	FDdsdutxs+BCqES44sg==
X-Received: from plhb12.prod.google.com ([2002:a17:903:228c:b0:2ae:4f41:cd11])
 (user=treapking job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e751:b0:2ae:cefd:18d6 with SMTP id d9443c01a7336-2b06e3244e9mr14740125ad.2.1773795880882;
 Tue, 17 Mar 2026 18:04:40 -0700 (PDT)
Date: Tue, 17 Mar 2026 18:01:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260318010325.2003395-1-treapking@google.com>
Subject: [PATCH net] selftests: drv-net: ping: Wait for carrier after toggling offloads
From: Pin-yen Lin <treapking@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Taehee Yoo <ap420073@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268841-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[treapking@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ping.py:url]
X-Rspamd-Queue-Id: ECD852B4D31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Toggling checksum offload (or HW-GRO via feature dependencies) can cause
certain physical interfaces to undergo a reset or a temporary link-down
state. In the ping.py test, this leads to immediate test failures if the
ping is attempted before the carrier is restored.

This is observed when running the test with GVE driver when HW-GRO is
enabled. When checksum offload is toggled, HW-GRO is toggled as well
because of the feature dependency. This leads to an interface reset,
causing the subsequent ping to fail.

Add a sleep period after changing these features to allow the link to
stabilize.

Fixes: 75cc19c8ff89 ("selftests: drv-net: add xdp cases for ping.py")
Signed-off-by: Pin-yen Lin <treapking@google.com>

---

 tools/testing/selftests/drivers/net/ping.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index da3623c5e8a9..951cd99136c3 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -64,7 +64,10 @@ def _set_offload_checksum(cfg, netnl, on) -> None:
     try:
         ethtool(f" -K {cfg.ifname} rx {on} tx {on} ")
     except:
-        return
+        pass
+
+    if no_sleep != True:
+        time.sleep(10)
 
 def _set_xdp_generic_sb_on(cfg) -> None:
     prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
-- 
2.53.0.851.ga537e3e6e9-goog

base-commit: 64dcbde7f8f870a4f2d9daf24ffb06f9748b5dd3
branch: net-upstream

