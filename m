Return-Path: <netdev+bounces-216691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19EFB34F59
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0DF5E5FA9
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A9C2C3265;
	Mon, 25 Aug 2025 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVb2Fx8S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363232C1597
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162576; cv=none; b=DqmhdMjdHT4n8hmFDUNhuc4/jtnYoi2yYntR/OasXELCB0hfHFIytvHUBygkSijXLtNMRPuGJclDBWhkHpl7gybGP75lPMwAUXpFl0S/5RdArnFo2lIz2tDKrBqI8yvomg/P9Fwej0f3k2moIYEvpRmLzj7Rr0o4ocnnRyiVH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162576; c=relaxed/simple;
	bh=ao39ujTjRp8E+UnTI818WiBbzoKddU2oJQ8XZ9ojc2E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dx6gUiJZ3sQCtOxug7TJIwGSWKkViiqxHrj1q9eqLEr4MqsDF1kWjZcT729ByS9njHN1vC7VIaMSM2YiefoaxWWBw2wggAOCuU3je2/XZAX4xoM8ez53fas2CQnLjDmvTbGQOOX622V4WKFjm6n3ZNZdJXnjfsxdwnqkmjqOyLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVb2Fx8S; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24680b19109so19977145ad.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 15:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756162574; x=1756767374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M5wPgCPN1d4ojZKjXi6PwIUY1My/JNKEs+TWhOW313o=;
        b=JVb2Fx8SDMvz59LwjuZOtkWawv1h2wc1MOFMUQ1hO0mjx1uUhYpwcakJBYGx+EWjgg
         knMMLsJoFq69hr4uE7kJmsDx2SFDpemNVf3yu+M9vmTjJM4596kdPK0yEAdfKOyhLWW6
         KFeP26xIhccx32Rp2h6f19t/gjwxrhwT7DwfsS7NgjzgmXEteJqDGz78rl8QRp6i/UJ9
         9xzvcnIZlZJO6vSuk+iJAUsq/oD+TE3HyMudEcRna4qmvrwx3bq56U8+nt36SdKXhnS9
         2gSQyKR8kF3P5DEr80uE6+hhSNm45juPzZVP6td4GEa4Qzjn2fXehiOoFp6VhDZYNPpE
         jP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756162574; x=1756767374;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M5wPgCPN1d4ojZKjXi6PwIUY1My/JNKEs+TWhOW313o=;
        b=arRefUN8rcaxGshu6lQT0MR3VZOk+U1ZsIvrGDtCM3GcbsY//IAP+G3/OIkz7xYbUN
         RmaxkjPDzAPzXAyxhMj4AiudfEJ1Qdc8r9gRWZq3tHqnow6hPu/cbz7SkgQdRTTbHxnb
         ECvqT5amrfuiz0+dbbgfXkzUkVrS1xsmxyk1uFm7vV3y5PBMKHM9PJub+R7vD2JsUoIE
         o5+wW1ufW+UmQgSrrB0euWLIIwyMWznlzHQNZTpjW/y3eTVROFrABGG6pk02j3LqG1hu
         GBc77JgDozIJn5VabWyTNeV5yi1lFrvnYEJy7G/I+CcClt9uu6EFFX7XjUjqOI03k6FS
         01Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVhjLswpRk9h7qdToCh5qCjiyGfv5niFdzncjc8oiwt//huEaFkX5caldq3J09NYihtzToJp1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZT4uAeth8HouCVfTdzMGIySRYxhkmA6qguuawGG78/D155p3y
	fOh9FQ8lZoHEGrcEi8r9475zdIge0Cn4aMqEd3sz6wBF3cQ7AOPYaNCJ
X-Gm-Gg: ASbGncu+6KUohyJPYTmyZ+aLlcP3RQ5U79q5sSQxVDOplFUl1vIZ3b5ryC9N6nMMv3U
	R9A5PJv2QsgbvkS/3NzCahNv2hDnw2y/2bj3BZg1WKuZ/nm2fUMDcCk8/EkHnsPwCwYB6J/kCj+
	CBqoG9lNEE+ZohoT4we0awCzEFZZVBBYdnDQGJy7pPVELtbCgKDyIMgj+8qFA0obHATn9JQTsoL
	Vy0ImzacOP/2GpGPGWU790RsblkvnXeBnkiAGtSV2yCwVyM/9r50IpucEnovMYUAegdrfQnQbmg
	GmIDbfCbuIlenyqBHt12iH3BJm5NQ6JAlnbV0DG8utR0lPXFRN2/dyC7acbZN5NZefzyNkoTZ0s
	MKJZwDTluzXuj02E2vRy4CMmEEtJjWFAV4QCdwEAMHjp0UWj12O0=
X-Google-Smtp-Source: AGHT+IH1F3KjiQwYaS1uA1+ZATxoFQZOWZqpA6TkqmBHXPyeICa1xFlOCy8AGfOLg/d3F04ctDnTLw==
X-Received: by 2002:a17:903:1af0:b0:240:3ef:e17d with SMTP id d9443c01a7336-2462ef584edmr161531245ad.40.1756162574482;
        Mon, 25 Aug 2025 15:56:14 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.40.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687a662dsm78488605ad.49.2025.08.25.15.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 15:56:14 -0700 (PDT)
Subject: [net PATCH 2/2] fbnic: Move phylink resume out of service_task and
 into open/close
From: Alexander Duyck <alexander.duyck@gmail.com>
To: AlexanderDuyck@gmail.com, netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 pabeni@redhat.com, davem@davemloft.net
Date: Mon, 25 Aug 2025 15:56:13 -0700
Message-ID: 
 <175616257316.1963577.12238158800417771119.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <175616242563.1963577.7257712519613275567.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <175616242563.1963577.7257712519613275567.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The fbnic driver was presenting with the following locking assert coming
out of a PM resume:
[   42.208116][  T164] RTNL: assertion failed at drivers/net/phy/phylink.c (2611)
[   42.208492][  T164] WARNING: CPU: 1 PID: 164 at drivers/net/phy/phylink.c:2611 phylink_resume+0x190/0x1e0
[   42.208872][  T164] Modules linked in:
[   42.209140][  T164] CPU: 1 UID: 0 PID: 164 Comm: bash Not tainted 6.17.0-rc2-virtme #134 PREEMPT(full)
[   42.209496][  T164] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-5.fc42 04/01/2014
[   42.209861][  T164] RIP: 0010:phylink_resume+0x190/0x1e0
[   42.210057][  T164] Code: 83 e5 01 0f 85 b0 fe ff ff c6 05 1c cd 3e 02 01 90 ba 33 0a 00 00 48 c7 c6 20 3a 1d a5 48 c7 c7 e0 3e 1d a5 e8 21 b8 90 fe 90 <0f> 0b 90 90 e9 86 fe ff ff e8 42 ea 1f ff e9 e2 fe ff ff 48 89 ef
[   42.210708][  T164] RSP: 0018:ffffc90000affbd8 EFLAGS: 00010296
[   42.210983][  T164] RAX: 0000000000000000 RBX: ffff8880078d8400 RCX: 0000000000000000
[   42.211235][  T164] RDX: 0000000000000000 RSI: 1ffffffff4f10938 RDI: 0000000000000001
[   42.211466][  T164] RBP: 0000000000000000 R08: ffffffffa2ae79ea R09: fffffbfff4b3eb84
[   42.211707][  T164] R10: 0000000000000003 R11: 0000000000000000 R12: ffff888007ad8000
[   42.211997][  T164] R13: 0000000000000002 R14: ffff888006a18800 R15: ffffffffa34c59e0
[   42.212234][  T164] FS:  00007f0dc8e39740(0000) GS:ffff88808f51f000(0000) knlGS:0000000000000000
[   42.212505][  T164] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.212704][  T164] CR2: 00007f0dc8e9fe10 CR3: 000000000b56d003 CR4: 0000000000772ef0
[   42.213227][  T164] PKRU: 55555554
[   42.213366][  T164] Call Trace:
[   42.213483][  T164]  <TASK>
[   42.213565][  T164]  __fbnic_pm_attach.isra.0+0x8e/0xa0
[   42.213725][  T164]  pci_reset_function+0x116/0x1d0
[   42.213895][  T164]  reset_store+0xa0/0x100
[   42.214025][  T164]  ? pci_dev_reset_attr_is_visible+0x50/0x50
[   42.214221][  T164]  ? sysfs_file_kobj+0xc1/0x1e0
[   42.214374][  T164]  ? sysfs_kf_write+0x65/0x160
[   42.214526][  T164]  kernfs_fop_write_iter+0x2f8/0x4c0
[   42.214677][  T164]  ? kernfs_vma_page_mkwrite+0x1f0/0x1f0
[   42.214836][  T164]  new_sync_write+0x308/0x6f0
[   42.214987][  T164]  ? __lock_acquire+0x34c/0x740
[   42.215135][  T164]  ? new_sync_read+0x6f0/0x6f0
[   42.215288][  T164]  ? lock_acquire.part.0+0xbc/0x260
[   42.215440][  T164]  ? ksys_write+0xff/0x200
[   42.215590][  T164]  ? perf_trace_sched_switch+0x6d0/0x6d0
[   42.215742][  T164]  vfs_write+0x65e/0xbb0
[   42.215876][  T164]  ksys_write+0xff/0x200
[   42.215994][  T164]  ? __ia32_sys_read+0xc0/0xc0
[   42.216141][  T164]  ? do_user_addr_fault+0x269/0x9f0
[   42.216292][  T164]  ? rcu_is_watching+0x15/0xd0
[   42.216442][  T164]  do_syscall_64+0xbb/0x360
[   42.216591][  T164]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   42.216784][  T164] RIP: 0033:0x7f0dc8ea9986

A bit of digging showed that we were invoking the phylink_resume as a part
of the fbnic_up path when we were enabling the service task while not
holding the RTNL lock. We should be enabling this sooner as a part of the
ndo_open path and then just letting the service task come online later.
This will help to enforce the correct locking and brings the phylink
interface online at the same time as the network interface, instead of at a
later time.

I tested this on QEMU to verify this was working by putting the system to
sleep using "echo mem > /sys/power/state" to put the system to sleep in the
guest and then using the command "system_wakeup" in the QEMU monitor.

Fixes: 69684376eed5 ("eth: fbnic: Add link detection")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |    4 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c    |    2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index e67e99487a27..40581550da1a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -52,6 +52,8 @@ int __fbnic_open(struct fbnic_net *fbn)
 	fbnic_bmc_rpc_init(fbd);
 	fbnic_rss_reinit(fbd, fbn);
 
+	phylink_resume(fbn->phylink);
+
 	return 0;
 time_stop:
 	fbnic_time_stop(fbn);
@@ -84,6 +86,8 @@ static int fbnic_stop(struct net_device *netdev)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
 
+	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbn->fbd));
+
 	fbnic_down(fbn);
 	fbnic_pcs_free_irq(fbn->fbd);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index a7784deea88f..28e23e3ffca8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -118,14 +118,12 @@ static void fbnic_service_task_start(struct fbnic_net *fbn)
 	struct fbnic_dev *fbd = fbn->fbd;
 
 	schedule_delayed_work(&fbd->service_task, HZ);
-	phylink_resume(fbn->phylink);
 }
 
 static void fbnic_service_task_stop(struct fbnic_net *fbn)
 {
 	struct fbnic_dev *fbd = fbn->fbd;
 
-	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbd));
 	cancel_delayed_work(&fbd->service_task);
 }
 



