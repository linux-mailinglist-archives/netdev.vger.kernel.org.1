Return-Path: <netdev+bounces-240267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65434C71FE1
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 04:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 1C2A12B560
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 03:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC47301027;
	Thu, 20 Nov 2025 03:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="AINODSv1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689AC2FFDF5
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609429; cv=none; b=AcedVSlG9dCF1Mrs6eAClvQhU0FiIYai+7CIY6oEouKtbVK7t07ycqC4UI/2vinsxX2Nwst+PWLBcAD6iaKEYadJkXs7fJYohcdI0XNaPgeuqOc/RJNVksAjihr3EVYcG0dwNoDNkk4jngTlK8VDNYNoY63APffUJf6C2xqYtHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609429; c=relaxed/simple;
	bh=skzqejGjT8GBIo6sRj1raxwLJbrJktcjew8Fj9AgyHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0pAlo4KLyZxDw9hjv2SrVXBca6JoonbduZmp9ReQdALdGxMidY6SRq+yzG20DR459lY/kTis8G06Duj4JdPiqiiMrzJH2ITylekuxL0eIa1MFzYO+zE2Ez/SUKN8npGI9LWsqc9q73/wz0hcS6EmA17iAEBEOL16eWbcW+3MB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=AINODSv1; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3e37ad3d95aso213324fac.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763609427; x=1764214227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkJsGkbmG5wukxAxoFHneooDiZqTCaYDKjLXMjnX+CY=;
        b=AINODSv1Rhu2i6FH3PcLKXCnqquQhbwfv8mbx5ORTBd/hQ/BEu5IKFafjJgbx0Y+vo
         59/ZmtAveID/J49D8zGSmNdIeREbigN9cKGrwZ9qJatdrtPy/wnbEH8CUj7qrdIkzIEH
         PN+KSnjZuwHKh7Qx7QQam9cWOAigQeSCrmw0kz7SQV51DrhOd8OWI0abfHmum5U8pTBL
         G20IFyc2G0+1R1d374HY2tZOEmvZwBEOeeB3pV8wCTcp+uBsZ/pywK6/1bwarLpyR2Ow
         QsWKEXWdunv0UNhlz6HQixRPJXKnqadzc04IeQBhyLm4Rkir+IZbrTEJmG7VeMXcz/Qc
         JvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763609427; x=1764214227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WkJsGkbmG5wukxAxoFHneooDiZqTCaYDKjLXMjnX+CY=;
        b=sduxZ1qZBP0wfLtO9OQ9jRUcpKXimLlt3hP07HnnVqVJV18Vk0v637wAnxEKY9dyg2
         Hx+s74U5WpQs2rCQbA/p8lEOcLiZRn7Ij4i+tN7P7Xn+/Dp0V+rb7Z7l5mkfd2NAqE9v
         /yl3xEE/pedb7JQfy5xGCP+MNxjX/1xhb1gFJz9TDAsx4nee/Y8n0oCcd1NM79m4NxQ9
         KMsFvV1r3Eoj4AfVg9UdeHCdZFtXi87R1V1/sJjAWZ/8m3VDnukoCifO5my2dtid5vCA
         VCHKI/4SBp324sqcQTCyu4JeWwIN8JoSkTDpPZbr1T/SDenj4rk+Wn/WjhAaRuTEZCcZ
         tvEA==
X-Gm-Message-State: AOJu0Yz1QdefKW1JfH5/adOyNWZPkgoLTxPRdpFCkwptDiYpM8kJt57j
	D/zRMZogt7CTogqyuzJbswsF0iSGGyyb+hZ9H8kVDx1b3O7crEOgBBnNNQottWGTgj2zjW9oBWk
	7DFxn
X-Gm-Gg: ASbGncsygN0Kqf8tvxMfY0DpqT3INxZQhHRh6UgBQx3cywhMBPfYJh8NQuf+Piwm2tJ
	StLvKJvz27Uy88POpgseVW3C6DNKiWP2eHxjdMlHG+PaSsLLfmsoTdrz54ziMSZra7Ni90bDas6
	7zEVfHlPhs4IviqSxqYpWjeVHHubDRzUYThoW3Ds4ixIeKN3UlrIXoz78VvDi9KVcf9nIbUQDwA
	TKBSP4Ch8Axe41/j9kJ1Ij1LOnAL1sSWkmcqcwZzrVIFj/bsJx/MQaaqIW0c+Xq1C5AEvtWIMpB
	nq4hYV0LIMl61HI3FoVoVt9bq9T/zbINsuYmtADREmByztYn+hyRUP244ugEo8x/m0UpHU3qhpZ
	+KqgJbr2vBZR4U4DhZRtmX0JbVtMuN7zBmvA7gmkWbgsX0m22hQxp74V+bmnpvS9tru1g25/yA2
	YMAIUXNn0vBrp8udOf2NjD07PLc7WIyOqm4lPmrQsTov5C0XUI1TQ=
X-Google-Smtp-Source: AGHT+IEFKc5KqrWMbYiYxIaQplHGnhA5gcT4BXb0naKVnfTKEX0emPYsfqaOej56U3gD4Sys6WoswQ==
X-Received: by 2002:a05:6808:14d6:b0:44f:7562:1a73 with SMTP id 5614622812f47-450ff387ad4mr1001735b6e.35.1763609427432;
        Wed, 19 Nov 2025 19:30:27 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:5::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-450fff8d592sm379745b6e.12.2025.11.19.19.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 19:30:27 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next v1 7/7] selftests/net: add a netkit netns ping test
Date: Wed, 19 Nov 2025 19:30:16 -0800
Message-ID: <20251120033016.3809474-8-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120033016.3809474-1-dw@davidwei.uk>
References: <20251120033016.3809474-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set up a netkit pair, with one end in a netns. Use LOCAL_PREFIX_V6 and
nk_forward bpf prog to ping from a remote host to the netkit in netns.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../selftests/drivers/net/hw/nk_netns.py      | 89 +++++++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 855363bc8d48..dfca39d1b99f 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -16,6 +16,7 @@ TEST_PROGS = \
 	irq.py \
 	loopback.sh \
 	nic_timestamp.py \
+	nk_netns.py \
 	pp_alloc_fail.py \
 	rss_api.py \
 	rss_ctx.py \
diff --git a/tools/testing/selftests/drivers/net/hw/nk_netns.py b/tools/testing/selftests/drivers/net/hw/nk_netns.py
new file mode 100755
index 000000000000..43b520ac5757
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_netns.py
@@ -0,0 +1,89 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import subprocess
+import time
+from os import path
+from lib.py import ksft_run, ksft_exit, KsftSkipEx, KsftFailEx
+from lib.py import NetNS, MemPrvEnv
+from lib.py import cmd, defer, ip, rand_ifname
+
+
+def attach(bin, netif_ifindex, nk_host_ifindex, ipv6_prefix):
+    cmd = [
+        bin,
+        "-n", str(nk_host_ifindex),
+        "-e", str(netif_ifindex),
+        "-i", ipv6_prefix
+    ]
+    try:
+        proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
+        time.sleep(0.5)
+        if proc.poll() is not None:
+            _, stderr = proc.communicate()
+            raise KsftFailEx(f"Failed to attach nk_forward BPF program: {stderr}")
+        return proc
+    except Exception as e:
+        raise KsftFailEx(f"Failed to attach nk_forward BPF program: {e}")
+
+
+def detach(proc):
+    if proc and proc.poll() is None:
+        try:
+            proc.terminate()
+            proc.wait(timeout=5)
+        except subprocess.TimeoutExpired:
+            proc.kill()
+            proc.wait()
+
+
+def test_netkit_ping(cfg) -> None:
+    cfg.require_ipver("6")
+
+    local_prefix = cfg.env.get("LOCAL_PREFIX_V6")
+    if not local_prefix:
+        raise KsftSkipEx("LOCAL_PREFIX_V6 required")
+
+    local_prefix = local_prefix.rstrip("/64").rstrip("::").rstrip(":")
+    ipv6_prefix = f"{local_prefix}::"
+
+    nk_host_ifname = rand_ifname()
+    nk_guest_ifname = rand_ifname()
+
+    ip(f"link add {nk_host_ifname} type netkit mode l2 forward peer forward {nk_guest_ifname}")
+    nk_host_info = ip(f"-d link show dev {nk_host_ifname}", json=True)[0]
+    nk_host_ifindex = nk_host_info["ifindex"]
+    nk_guest_info = ip(f"-d link show dev {nk_guest_ifname}", json=True)[0]
+    nk_guest_ifindex = nk_guest_info["ifindex"]
+
+    bpf_proc = attach(cfg.nk_forward_bin, cfg.ifindex, nk_host_ifindex, ipv6_prefix)
+    defer(detach, bpf_proc)
+
+    guest_ipv6 = f"{local_prefix}::2:1"
+    ip(f"link set dev {nk_host_ifname} up")
+    ip(f"-6 addr add fe80::1/64 dev {nk_host_ifname} nodad")
+    ip(f"-6 route add {guest_ipv6}/128 via fe80::2 dev {nk_host_ifname}")
+
+    with NetNS() as netns:
+        ip(f"link set dev {nk_guest_ifname} netns {netns.name}")
+
+        ip("link set lo up", ns=netns)
+        ip(f"link set dev {nk_guest_ifname} up", ns=netns)
+        ip(f"-6 addr add fe80::2 dev {nk_guest_ifname}", ns=netns)
+        ip(f"-6 addr add {guest_ipv6} dev {nk_guest_ifname} nodad", ns=netns)
+
+        ip(f"-6 route add default via fe80::1 dev {nk_guest_ifname}", ns=netns)
+
+        cmd(f"ping -c 1 -W5 {guest_ipv6}")
+        cmd(f"ping -c 1 -W5 {cfg.remote_addr_v['6']}", ns=netns)
+
+
+def main() -> None:
+    with MemPrvEnv(__file__) as cfg:
+        cfg.nk_forward_bin = path.abspath(path.dirname(__file__) + "/nk_forward")
+        ksft_run([test_netkit_ping], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.47.3


