Return-Path: <netdev+bounces-306308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JgiGOw3JT2pmoQIAu9opvQ
	(envelope-from <netdev+bounces-306308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 18:15:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6525C733597
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 18:15:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Tphj0uzG;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306308-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306308-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B009300DD5B
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 16:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B76431E46;
	Thu,  9 Jul 2026 16:08:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91A84307BB
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 16:08:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613298; cv=none; b=dws3R57Ahj+1YJ65cmkeHoT/s6nTLNvkfBOUC2d5oQ1ezAzJ+cUf/EYyg/YzReubji7rucF0zsV1h3mypu8ngnxLrrQxW6Kn0L5cmc9GHda6r+Jku5cTBJof9m2yi6ByWvwf55FrXbYokJm2ny04hAsZaSrwoXIJmkAm4hoEnbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613298; c=relaxed/simple;
	bh=roYk69iMq6nB9nkznQVm0tE4qPdmgYL5OzMoK1GJxnA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=H5NAZFO05pbo0uYJoo1innIdjHpUU1l8kul1hoS5G//xHjppjrvMccK92cppXHO5tUapMWBBdGlGjIfOcK0fZRNyaVkujSRbkPj9BftJF9mIGCjfUQDFqO1dm63kocNESFIUQxQZOxlfr428O+3Rt+eRj62mwwxBAkiewslqyyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tphj0uzG; arc=none smtp.client-ip=209.85.217.74
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-737bcdb48d2so2377137.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 09:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783613292; x=1784218092; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gJNcw7M2sNVblZ4y7vGqfJIKNb5SV5gkezFVrk+oIbM=;
        b=Tphj0uzGYGkINP65VBq4QfP4eenVWzss64bQk7EWwq1N7oN53LpXJc4AisJOmfoMLl
         XH+sn8xEe34xKNA68BfhZzsHsJRr+fE3bwegO5+wK8IW7XW3OPgBP8blwrk1Lj9D63Qs
         uNvqYAX6du85SXagkCisMdbqafCPMqpWL2zJ5/CmMgHTJ2FfL9KSU6+JBQCwUoR6LJuO
         Mh8f6ZmoL6LhYy5VtiTKWB3SkuRQgCGZTaXmbCLM8bEyjuvFev3/kjaD3nlHXtNvmCcX
         14R9/ppHLSuB4W4IhaWQaTbRJHGryhUj/AF82tn/CVfraEdbkR1x3rPkXVJp3/nhLJ+4
         4Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783613292; x=1784218092;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gJNcw7M2sNVblZ4y7vGqfJIKNb5SV5gkezFVrk+oIbM=;
        b=bkzgBWx60kxK9nduQiIaOI+4P9XLDsSKVcW2sHDW6jNfl33yYHU2Xq/f7toWUqq2Ht
         VGrE6UytUrfYDh32OqW1Seu3cq1wpf7LLshsoR2NpO7IU2b+iBEw+aAm0AbMVvfx4xMv
         6v9gfLSlK4VcII5YT0EVUE+kdp/BTUtl3QiO0qZETgt0ygZ5dXtHMNTuZWFKK8Iqmfqe
         IMZrqX8BkPPTDYgqx6OSAQAQkVDLTJ4MG82ZPPktOX7nT8aTEANQtw4pDfPwkNKxrKd2
         e4EiwkMWdCRKfhmp+4DXpvrjaHLw4aKzrVxKP+zeybmTVN+pQ1I7ADErcJC6BPrNFAa7
         vDNw==
X-Forwarded-Encrypted: i=1; AHgh+RpeCj/79VJG2u5tuFXF3rCa5eiYQgeUHiNm5VjE6wmlOJTu23Ca946sMaFrGMHhosgZXqZNFwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx68pBc9e2PWgNoK8UYZcEM7GtGGKU6g2nXfELuYj3vCwOVwudz
	x7K5r4GMjPdlVTFFVrIjcBug+QbMrmbjUCmbfcbWWBE93iUHefTqq55ppLCThMoe7xin2/E4kGT
	WQEWJ8lL5mScz9BdoQD7xEH7x3Q==
X-Received: from uaap17-n1.prod.google.com ([2002:a05:6130:8291:10b0:969:2d14:ca9c])
 (user=thaisonphan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:162b:b0:73e:751a:167c with SMTP id ada2fe7eead31-744e008f257mr4655084137.17.1783613291828;
 Thu, 09 Jul 2026 09:08:11 -0700 (PDT)
Date: Thu,  9 Jul 2026 16:08:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709160807.23650-1-thaisonphan@google.com>
Subject: [PATCH net-next] selftests: net: update wait mechanism for relocating
 netdevsim to a new ns
From: Thaison Phan <thaisonphan@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Fengyuan Gong <gfengyuan@google.com>, Stan Iliev <stani@google.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, Petr Machata <petrm@nvidia.com>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thaison Phan <thaisonphan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:gfengyuan@google.com,m:stani@google.com,m:horms@kernel.org,m:willemb@google.com,m:petrm@nvidia.com,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thaisonphan@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[thaisonphan@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306308-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thaisonphan@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ns.name:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6525C733597

When netdevsim devices are reloaded into a non-default network namespace
via 'devlink dev reload', the host's udev daemon does not receive the
subsequent device creation events since it is generally associated to the
default network namespace, so the host udevd queue never officially clears.
As a result, running 'udevadm settle' blocks indefinitely and eventually
times out.

Fixed this by bypassing 'udevadm settle' when a namespace ('ns') is
provided by utilizing the namespace-aware 'self.wait_for_netdevs()'
helper to poll the namespace's sysfs until the interfaces are visible.
For host-only configurations (where 'ns' is None), preserve the original
'udevadm settle' behavior to ensure udev renaming rules are completed.

Also fixed minor bug in wait_for_devs() where wrong exception was caught
from if get_ifnames() failed. Now the if get_ifnames() results in a
command failure exception, wait_for_devs() will catch the exception and
set an empty list for the interface names rather than the exception
propogating upward.

Tested that tools/testing/selftests/drivers/net/ping.py and
tools/testing/selftests/drivers/net/psp.py still pass when using
software network devices in a QEMU x86_64 environment.

Signed-off-by: Thaison Phan <thaisonphan@google.com>
---
 tools/testing/selftests/net/lib/py/nsim.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/nsim.py b/tools/testing/selftests/net/lib/py/nsim.py
index 7c640ed64c0b..a01491c2d1b6 100644
--- a/tools/testing/selftests/net/lib/py/nsim.py
+++ b/tools/testing/selftests/net/lib/py/nsim.py
@@ -6,7 +6,7 @@ import os
 import random
 import re
 import time
-from .utils import cmd, ip
+from .utils import cmd, ip, CmdExitFailure
 
 
 class NetdevSim:
@@ -76,8 +76,11 @@ class NetdevSimDev:
         if ns:
             cmd(f"devlink dev reload netdevsim/netdevsim{addr} netns {ns.name}")
             self.ns = ns
-
-        cmd("udevadm settle", ns=self.ns)
+            # udev daemon is not guaranteed to get notified of netdevs being created
+            # when in a new netns, so poll until we see the netdevs appear.
+            self.wait_for_netdevs(port_count)
+        else:
+            cmd("udevadm settle", ns=self.ns)
         ifnames = self.get_ifnames()
 
         self.dfs_dir = "/sys/kernel/debug/netdevsim/netdevsim%u/" % addr
@@ -116,7 +119,7 @@ class NetdevSimDev:
         while True:
             try:
                 ifnames = self.get_ifnames()
-            except FileNotFoundError as e:
+            except CmdExitFailure:
                 ifnames = []
             if len(ifnames) == port_count:
                 break
-- 
2.55.0.795.g602f6c329a-goog


