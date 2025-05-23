Return-Path: <netdev+bounces-193182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC286AC2C01
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 01:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C24E1BA7CB4
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 23:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83E821FF40;
	Fri, 23 May 2025 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfgZa8iZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C4F21ADB5
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748041537; cv=none; b=eNuaiv6t/vJAA97kefoJZUlq56EzSZvJQDIbGW4O0+Rjq8wSbELkHsAoQ6V8L5yySwnEM8CMUilE97VR4PPhC/mE2GH8l+Udf7KR9/Aux0GDKir4EY+1xPZfDR3mTyRdynmhwSsxq0BT9UaKc8A/NDiZS+avBM8VkgL3eW/UqNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748041537; c=relaxed/simple;
	bh=fIlnjHiVt66jMZHOXCtcWJq9iDhh9E2OfaIuTmFUKBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D8gshP5sauc2EUqMjvEjQvmgFU4IeVEMoOOT9dS+PRBuvJ8nS5QB5Fdi2POgUtzMjdmII2fhedrgYGFqQedVmGpKbI6g5AvZeJAf+W8AKwo9Ip7v/MuXefbbkeGb+os8CldFtBSr/5G4kYE638jk1sNLhz6jkGCPpdI+SpIg+f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vfgZa8iZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2322a7b0735so3493825ad.3
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 16:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748041535; x=1748646335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8sdft2buoZW74We3vtEkvC8v0SQ5B0W9UWiowkjja8=;
        b=vfgZa8iZcpw1VyNThOV6kro0eOHzte7hM6MvCpV0y5ua3l7Oq0zeCnx8XW2eTlJyZW
         WcAqy0CuTKLE5ZK91l01NtRd3IO7CujKfR2Jx43XgCy7xYRxhQOuzzXL7dIGbnTLGAtN
         7t8D3tHgcOI7g5ADAthwTqd91JY/B0QZNIVCHgrTPbBy6tNuavzeEiyyPD99ylulG7rU
         SqmdSEJ0nggzjLongXQ+3PdP6Y8a9kjd3EGphFFF8ZlbHULykEnfd/yegy38rmR82lcn
         j6rT1WF426ba5sIL/5XJ6RejziwlbnwgeCJ1VxDtlEooxPAu6E1v/v3l5TCUFZQ70pCk
         9BBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748041535; x=1748646335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8sdft2buoZW74We3vtEkvC8v0SQ5B0W9UWiowkjja8=;
        b=cnHrPFOFx+S8ToJAieuCRicZSVgAXx+q6TmATq8F3Jn2+QA2QoJUPdXdDbh5AuKhg1
         KoPUkoeksV5exFaG4X6QTxodzird3sVhwbEHoXQvdDsmlqRAjfkDPdU99W1sOVhV0vd9
         WOTVIHNIU2A2buOqHTAWKMNHHO1o/oYdNFqUSnOV9lzTKwbePdwPbLxgTWVqW37DTncQ
         lC+QWCfjdl66BgPtvMRUwMzDbgL5Cv3NtAMFb25qI6RZXqv61bIgAOidp7Eb6A9X7yoJ
         LQGeUtauy8ZkQDgNPvKx8Z3evQW0RaZ0Na7J96Cy6daZGlJDnCLNZZ44B3TFnrgm9FrS
         xmXA==
X-Gm-Message-State: AOJu0YzmdmNkdsCDS+EpG60YOg1fdVMxSm5T+jY2soe98+GRajEf3bp0
	Qgfkd+PdCwvuAdiejRR4E8oytqMjyEFopj57qafyWf1NK0HIz8OreD6Dbz7uyS3yllPPI+Z8105
	BSox437Jul2vtODGsAjy/WC6lyEeJWT47s8Uvh6YQajUCwazjIoqbzU9wEOxAvxm+9mxmgjcvuZ
	hIF6eFcXy1uX75gZm2DQhn8rn0LPKvhEwPudxVJ19ymwwLbPB2IN3klgvHErjR5dM=
X-Google-Smtp-Source: AGHT+IFJs+ZhchzXRGJVcyEK6P/BPOUVSXu7jFxFlu1YtOZP4EdE+NQsj52iCebn4YmWRq4ge9eEJOy4WdeS3R2Oeg==
X-Received: from pldt12.prod.google.com ([2002:a17:903:40cc:b0:220:d668:ff81])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:acf:b0:22f:9f6a:7cf with SMTP id d9443c01a7336-2341500d143mr15462135ad.52.1748041535501;
 Fri, 23 May 2025 16:05:35 -0700 (PDT)
Date: Fri, 23 May 2025 23:05:20 +0000
In-Reply-To: <20250523230524.1107879-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523230524.1107879-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523230524.1107879-5-almasrymina@google.com>
Subject: [PATCH net-next v2 4/8] net: devmem: ksft: add ipv4 support
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"

ncdevmem supports both ipv4 and ipv6, but the ksft is currently
ipv6-only. Propagate the ipv4 support to the ksft, so that folks that
are limited to these networks can also test.

Signed-off-by: Mina Almasry <almasrymina@google.com>


---

v2:
- Use cfg.addr and cfg.remote_addr instead of doing ipv4 and ipv6
  special handling (Jakub)
---
 tools/testing/selftests/drivers/net/hw/devmem.py | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 7fc686cf47a2..9b3e2c78f457 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -21,30 +21,28 @@ def require_devmem(cfg):
 
 @ksft_disruptive
 def check_rx(cfg) -> None:
-    cfg.require_ipver("6")
     require_devmem(cfg)
 
     port = rand_port()
-    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port}"
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port}"
 
-    with bkg(listen_cmd) as socat:
+    with bkg(listen_cmd) as ncdevmem:
         wait_port_listen(port)
-        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:[{cfg.addr_v['6']}]:{port}", host=cfg.remote, shell=True)
+        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP{cfg.addr_ipver}:{cfg.addr}:{port}", host=cfg.remote, shell=True)
 
-    ksft_eq(socat.stdout.strip(), "hello\nworld")
+    ksft_eq(ncdevmem.stdout.strip(), "hello\nworld")
 
 
 @ksft_disruptive
 def check_tx(cfg) -> None:
-    cfg.require_ipver("6")
     require_devmem(cfg)
 
     port = rand_port()
-    listen_cmd = f"socat -U - TCP6-LISTEN:{port}"
+    listen_cmd = f"socat -U - TCP{cfg.addr_ipver}-LISTEN:{port}"
 
-    with bkg(listen_cmd, exit_wait=True) as socat:
+    with bkg(listen_cmd) as socat:
         wait_port_listen(port)
-        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port}", host=cfg.remote, shell=True)
+        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr} -p {port}", host=cfg.remote, shell=True)
 
     ksft_eq(socat.stdout.strip(), "hello\nworld")
 
-- 
2.49.0.1151.ga128411c76-goog


