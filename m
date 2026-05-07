Return-Path: <netdev+bounces-285340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI1VJuiY/Gn4RgAAu9opvQ
	(envelope-from <netdev+bounces-285340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:51:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F594E9A2D
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD003306BB10
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 13:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3003FB7E2;
	Thu,  7 May 2026 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e9nQMaB4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4853F54B3
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161710; cv=none; b=h79vZqzGsLL+vuhW9wb06wpMmz14QbVs+ks77oHI8DXD1kDoNfQv0Xtz1i5JsZrNbm4f0tRa25MsKBuDjHDustROjgCCahhCf90dDk9qXns7Zts8DsvvByrNL2IUlfoaouLkgArCUW+q0WVwNynwuV78vUsbFof+Eh6Ew/O5nZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161710; c=relaxed/simple;
	bh=VFRgu2cJwqXZgxOEu/B3E6yAKtvNoFeFdDZSZ+K47YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AEZ7bntM5w72nV6/53D5VdN96LQTTxMmAAhzdjXnY1OgaAYZSONjr7J6XZfE2p+nxf97jPifFMQDXMWPDDFKRDb7rRyx/EI77WCJhaxDMDduBXlI5NqtNyPku7yaiLrRVXTlCdACU3uI0u2JfsyieIegpLVXubTgqB7z5Q4cFHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e9nQMaB4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48909558b3aso10513735e9.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778161706; x=1778766506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WoAsiMhHn+IE4y5ZbpU36N8ZnmK7jeWLatv0EXI80UA=;
        b=e9nQMaB44daTLZCWnL82eyU/KYb+q4R1mYmCydnhTyLoGihDmXpS58CVAVlvLsZLIp
         38VvcOkFbRgFz9sr9AbQnsiYfBtyAYfsFSe14vuK93jCEffY9AHVxvdNM0Bwi6Cd4UHJ
         G35ZVmaRbFxZOYWvGErZXRCjca0QLXkM7JG/f3DZF4GzkIUsCLPBdAYFPqsc+9bCEvvJ
         0BC7KeWdIMY3bNFdYj5cKMgdB5unjliI82WY+zPH4g10aNoosEn1xeOUMXweEoV8uB+0
         1dHYLixWx3I6OlhAWOb0z9UOmv36B8zUUxlKK6zUiI6OKYYiJkB6MifmeZpMOpUUA5Ei
         PhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778161706; x=1778766506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoAsiMhHn+IE4y5ZbpU36N8ZnmK7jeWLatv0EXI80UA=;
        b=FLPB9u5wfjUmgnv84hVVfkRZKxSgu99sRw9kwoAl6kS5DHqkLuFvAwu6nMf4d2MYPZ
         qCoAfx326ztramCC/K0+Op2vRvhwnMpg/Uv+An+No1BypC9y2QcsHw1//0N8/SXuec7S
         c3a26Ai2tvRTxvdIqomKRpY3otWrlnc3ItsZydkasM1Vrz8gBoS+fYYpEuu/2ImCvzxa
         V7iE2dJXUf4s/Nhp2OwzuZCuN4G01aAz4N+qIs6T2pgsRlIm0herNSXnvPkzkqOI6BkV
         PhCZxB2bwwzlg1caw9X0TPMWFV91mEBt9/6yP7I6JAQbq7gtn0hnAlkibQGM3gMJl8Jy
         blkA==
X-Forwarded-Encrypted: i=1; AFNElJ/S+8OH5E+1ZSkbMupmK8xAmPZUmEfaIQA5BUT52Z/6WxPOb9Sl4H2z8NKjan+vfRdYc4UmroU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQOaewjvm4fzVHw/7hKYsB+54wPqm+GjiL3srudEpA4WnHgt8g
	Hl+QEWZtcee6cEdfKPJUiC+WDdiWM5oP8dki+U69mdFzxcRRhLR7nUue3otgs34RBjs=
X-Gm-Gg: AeBDievBebM67uVk16U0z0aYT21WpekyzkjhkAAfNZOdvIW5daHdM8Hoh5FTXJkSsTn
	8/yOxOsegFgDPRtrs/g8f7RGzRCcO1Vb5Vz0fBppg36cmg0ZhFBa6nfcRSY+uZFywVakf2B0NPC
	qyuWwPxVL3sg0Hm93mXi3qeY1nIgHsxZm5qqYWwKdkKaHSZcHr9ZjzWtzYcmCJGzB01Zy6Io0Ee
	YjGx4K/6pHQ3kuovc7/ejn3uPJ2NcirXrt3RwSughBRoEEyOdXZkvHeGWEyU5UWsH4Jb41VYgwN
	wARQ2XOCjqM2yHsbgsR1aFwcfL2svnsJ6kNFh5oBvqG8BvSkOLbnN9JIBqq6gGcG5NccPOdMQRb
	Gka311hJgQCq4sh6mSR6XQ30hfXHCXETAUINNCfdDBCrCs63Qz/JKvKBxQ0ILtLepUzHaELtnUV
	e891CfkuxDCtdIO9dS7xSBakU9cQjdpDCEkk3mzlAzqfZVV0cQRAtBIJagOQ==
X-Received: by 2002:a05:600c:c494:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-48e51f32c35mr127316915e9.13.1778161705907;
        Thu, 07 May 2026 06:48:25 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e52f5c1cfsm82872855e9.0.2026.05.07.06.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 06:48:25 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Simon Horman <horms@verge.net.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [RFC PATCH net-next] net: bridge: Move long delayed work on system_dfl_long_wq
Date: Thu,  7 May 2026 15:48:15 +0200
Message-ID: <20260507134815.295588-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 12F594E9A2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,verge.net.au,davemloft.net,google.com,redhat.com,nvidia.com,blackwall.org];
	TAGGED_FROM(0.00)[bounces-285340-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,suse.com:mid,suse.com:dkim]
X-Rspamd-Action: no action

Currently the code enqueue work items using {queue|mod}_delayed_work(),
using system_long_wq. This workqueue should be used when long works are
expected and it is a per-cpu workqueue.

The function(s) end up calling __queue_delayed_work(), which set a global
timer that could fire anywhere, enqueuing the work where the timer fired.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Long work shouldn't stick to a single
CPU.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change
system_long_wq with system_dfl_long_wq so that the work may benefit from
scheduler task placement.

Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 net/bridge/br_fdb.c    | 2 +-
 net/bridge/br_stp.c    | 2 +-
 net/bridge/br_stp_if.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index ac81e58d5f70..14c7943d59a1 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -583,7 +583,7 @@ void br_fdb_cleanup(struct work_struct *work)
 
 	/* Cleanup minimum 10 milliseconds apart */
 	work_delay = max_t(unsigned long, work_delay, msecs_to_jiffies(10));
-	mod_delayed_work(system_long_wq, &br->gc_work, work_delay);
+	mod_delayed_work(system_dfl_long_wq, &br->gc_work, work_delay);
 }
 
 static void br_fdb_delete_locals_per_vlan_port(struct net_bridge *br,
diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index 024210f95468..426e1c76ef6e 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -640,7 +640,7 @@ int br_set_ageing_time(struct net_bridge *br, clock_t ageing_time)
 	br->ageing_time = t;
 	spin_unlock_bh(&br->lock);
 
-	mod_delayed_work(system_long_wq, &br->gc_work, 0);
+	mod_delayed_work(system_dfl_long_wq, &br->gc_work, 0);
 
 	return 0;
 }
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 28c1d3f7e22f..7a5f4747e1a1 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -53,7 +53,7 @@ void br_stp_enable_bridge(struct net_bridge *br)
 	spin_lock_bh(&br->lock);
 	if (br->stp_enabled == BR_KERNEL_STP)
 		mod_timer(&br->hello_timer, jiffies + br->hello_time);
-	mod_delayed_work(system_long_wq, &br->gc_work, HZ / 10);
+	mod_delayed_work(system_dfl_long_wq, &br->gc_work, HZ / 10);
 
 	br_config_bpdu_generation(br);
 
-- 
2.53.0


