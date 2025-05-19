Return-Path: <netdev+bounces-191373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BCEABB352
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 04:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7039B174841
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 02:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B986D209F46;
	Mon, 19 May 2025 02:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQUVFN4K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7121F8750
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747622134; cv=none; b=mn0oFoNiMk1r3lAYETOITzTHyF6nUBS1SKD9o8hfbs72ESc1fHp7TsLdOs9TRCGrFkXMlQ0QUbNAbjH9y8SeFxaJA9FIcxMfyZrwhTUAmG0aybaokTeYJjEf1D7n8q7H6GZH0VG3n9leWcqiUtX06UUrz2tcN1SlUJiAtjaDKOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747622134; c=relaxed/simple;
	bh=lXhPuDqZ8lFiqJJEDrc+fi8w2H175fq+dRDihzDr1bM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dxlDz5++Hnh26JQs9+sQqrP9rQhOTCcdYaqVKFW0ajRF4cc74VcLn6b1MkMx2yZkwCbdgRT6+MdriO9Gjf4AhCQR+cTj9gmMJtKAs/c5mF0CjexY5i+sQBA3X/o4P+H9WiaPy6QF+vVdQJ1ZTpjljMhDc9tGsDrzDqVE1Uo2Mr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YQUVFN4K; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742b8c0eaf0so694918b3a.2
        for <netdev@vger.kernel.org>; Sun, 18 May 2025 19:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747622132; x=1748226932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6AvReAJLKB2KWx4p7QNdhXPE+oF5Pp4I3dIzKrTOjY=;
        b=YQUVFN4K9FtwrdqaVkZcfeEOuiXBuM8F3imqbqDtx6xkpeHDfDr3CbRkD+m9Lu/y3Z
         yyXJZYGfrgroFEyHREsXvcOfkuFkHRlSUHCLnzAUVBmX8L+BMBrCiEK5YC3Uv3BthgUu
         zx2HMwhnKdkWWJsJ/XQ07ZnwOkGLZ8XzmZCnZ6zRZgIJGllxedrmRxB9XSvuGp/R1nBn
         FREGOqoLlKGDBDwjVIjXuGqcxvpGrmEkMr7uLKAze0ImSRmh2E2BHjUJjp4lp3NqQMcC
         emaL7hdJ/qGQVzsTBO/8rhaW1PdSE7ybKgaogD3We8LgRSPWzSY61Q4b65p55CuDZDp7
         uNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747622132; x=1748226932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6AvReAJLKB2KWx4p7QNdhXPE+oF5Pp4I3dIzKrTOjY=;
        b=XKaBh5YgnVcdIkYA07eOy96a3QyC9IHwnSYJ1yKkwGUus1FKSKQQrdMJPkk3JlmDf+
         kp4LoDzKhESudLxA74IpDObdOZstKcYc17Fz9wLSJcwxQ25tNZW/XnFrDRhmz9kXP0Jo
         9zU6GJWqTMe/hr0JCJbhl6r6QkELcmuUAKXuUtUHHTmIRPrVbYT3CWYH6LpozMnQewK+
         w+a5kp6+SIDlfYM0o9T83p9jGFbkdMHSxuabAkl9TavHRTd4lLuNy8KoQUC18Hk/Khee
         k+Dok9dVN5wMrOH5eXPkMMvVrMWWo52dZtuZeYeqBcl0L52he9Im/OP6JRs9FSwiM7bI
         ebUQ==
X-Gm-Message-State: AOJu0YyXT0aK88dpk8afsSjExW3BAQdkRC+MnC6AkDeoD0Ztet+d4cph
	7IGgahFwhQjvcXP7s1TqC4sy3YL8Dp1YOMowVMYlZ8UJ4+diB6rUUJghyn0rNxpL74lamNbS9Yd
	hJFEBXmPlrvqp7Qi4GEXH3/EWbBu75RrfoFuHaiuD3cewfTwz7cZzvCDs/t9iA0qMNh2p5krvNc
	z/fSomg1BImYsW9N0H5JGqMcqxlJfNZTJWQVYwRimgOVglsJVLDVNSn8tMkOJ6gSE=
X-Google-Smtp-Source: AGHT+IHeYzRMmOkX7+lsgG9BfNqeH5NnQHkDsXjIYRGrh345Z62LvP2j6VviMlp6xHOXPHOb4h2WAzbno9NKL1vt+Q==
X-Received: from pfblw5.prod.google.com ([2002:a05:6a00:7505:b0:732:2279:bc82])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9186:b0:742:4770:bfbb with SMTP id d2e1a72fcca58-742a98a3213mr15212907b3a.18.1747622132372;
 Sun, 18 May 2025 19:35:32 -0700 (PDT)
Date: Mon, 19 May 2025 02:35:15 +0000
In-Reply-To: <20250519023517.4062941-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519023517.4062941-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519023517.4062941-8-almasrymina@google.com>
Subject: [PATCH net-next v1 7/9] net: devmem: ksft: add 5 tuple FS support
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

ncdevmem supports drivers that are limited to either 3-tuple or 5-tuple
FS support, but the ksft is currently 3-tuple only. Support drivers that
have 5-tuple FS supported by adding a ksft arg.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 .../testing/selftests/drivers/net/hw/devmem.py  | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 39b5241463aa..40fe5b525d51 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -21,14 +21,27 @@ def require_devmem(cfg):
 def check_rx(cfg, ipver) -> None:
     require_devmem(cfg)
 
+    fs_5_tuple = False
+    if "FLOW_STEERING_5_TUPLE" in cfg.env:
+        fs_5_tuple = cfg.env["FLOW_STEERING_5_TUPLE"]
+
     addr = cfg.addr_v[ipver]
+    remote_addr = cfg.remote_addr_v[ipver]
+    port = rand_port()
+
     if ipver == "6":
         addr = "[" + addr + "]"
+        remote_addr = "[" + remote_addr + "]"
 
     socat = f"socat -u - TCP{ipver}:{addr}:{port}"
 
-    port = rand_port()
-    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port}"
+    if fs_5_tuple:
+        socat += f",bind={remote_addr}:{port}"
+
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {addr} -p {port}"
+
+    if fs_5_tuple:
+        listen_cmd += f" -c {remote_addr}"
 
     with bkg(listen_cmd, exit_wait=True) as ncdevmem:
         wait_port_listen(port)
-- 
2.49.0.1101.gccaa498523-goog


