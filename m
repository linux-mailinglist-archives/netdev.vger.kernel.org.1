Return-Path: <netdev+bounces-214918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DBBB2BD8D
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 11:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE8A165BF4
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 09:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C655131196A;
	Tue, 19 Aug 2025 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIm+LO1W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDB81DEFD2;
	Tue, 19 Aug 2025 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596289; cv=none; b=mhF77ioSEwURb6oTL5kukKPjjUbVrZGJbbXt78PmWbF6/cRVyV1QVPU/xXT/PDMrtlBKEQP3pMDIBjLI6Ae4ApN5H3n4rzF3YQwwjsm6jmDni3sstpSqIdYyMTzi0Wp+6sFvjuwxkVIOQ8cyNxdJ7JueMm9NQBlrOZ1vGlcRQMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596289; c=relaxed/simple;
	bh=9/p6Ph7D9wRm4wFXuSsFualdeGE9AmmM7b95PcN6uso=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bry3DJzLZ98eh57RNofgp+5ROpL2ozzTq1Um6UtHreW32gGjYcqIdfK7h4m6FmMC/qLdpE1alGZmTBnjqxnQDyAcRiq5R/jPiGESmVwpgPqDY1yIOLaFRFAkIbnSG3iiuAmz8vY+OqyFARJCyGNmIMZlN1y2CGcd/AU442zuMy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIm+LO1W; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-244582738b5so40114635ad.3;
        Tue, 19 Aug 2025 02:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755596287; x=1756201087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tNybECEbPP0960WKw8piGUA2zgUspqPhQILVyjqP/xE=;
        b=bIm+LO1W4kJGE9uIz4hEa1Zn3ekpoXZIIWG3zDZRSoGpDTS02QU0AfNsguIpXRROmI
         XR2I9kGE/Qprq1lLCNolWKM0ETNTIc6+TFSzQ2XhszWtu6Q5eIOEs4hNN05vjjq+KYdY
         4BthS0FFq3WXBuJgZpQvO74sJ9PZbPnmh8hlQk6F905E6e79vm1nhWQ0KyV/zBrSib2U
         +U44o3A1qca5ePerDJ6JtSt9iNklpIx7eKkIltKQu14PZzirjFIRnqMkFkjqJobMujHO
         VXqCGhwCcagC+hpq9MxOBKkyZI74D03wvKuRlBSXAR1OUsTG61P26ZXitco/A9w51wrz
         uRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596287; x=1756201087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNybECEbPP0960WKw8piGUA2zgUspqPhQILVyjqP/xE=;
        b=vSpu0LNk3umyjPXPUUOZxO8j2tVeZ1TzruTsMhk4sNBwxA3FFEGT0PyNoekHipkYX0
         NwkrGZtPRbkdxWNHqafKlFt+5gr7isoERDA0C0yrn/+422FP8SM/UEs1kw9RCCXvCVVA
         EoYxWUkGHNPRVVn9XPkIratcfFuvzezNF123BeDO8hodM7K1YoSkDr6ZoJDRYrUmS22+
         GGaoA4GJ8CGsZ6ObFHpayiaGCcCTXHDqEHd26fNicKkNsZ5a8KoV2XvsFtBJQ6TsrSQI
         T0OO1HByMgFVErz41kGwqVToPLNz3lgKn574t/FOn+f5qcwmOxJ7nz6b41PlUehEUWHF
         GapQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMlTsOIJS2Rz8K9P+ETqfn0vqChipu9QylKgGWOfRYeCPcCe9g38t0AJVsJx0qfpSLjSq/AlwefYaxHWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXPDjAktoq1X81OfsdEJFA7rDoh9rRLV99jnATOcrcB4hlCR5v
	YDnh2EmFFeX4dpVDl1Zbmnkui7XPKFSCwPvu/USga2GLPNrpnEoDoMkIw8rpgwSlRqc=
X-Gm-Gg: ASbGncuWA1SSlq3PkKlXxoANVWMKwnFH0IuoOqC5qAPO3rk6EAhB+/tmqlwr+NurBp9
	GIdc7L5YZlANs8eXOnUOOstICyAOok2vNFewskrfCA+/aIQIHUFxTVuf4ZE2zubsoN1zbL0lWpB
	GQP7QA+UMVxok4CXvwmaNTuMtLLqXQxFQd00DuLvkIPIBhHb5lxNX3dpo5GUSwcIJW49nYX40Md
	9A36CW5xjN4x3oy/DqyBl3mXX65cyMxGqeipk4wnxqGdtXhEUZOhvtiOFNlhEHLG0OqfongPBvt
	8buG4k+Whm+sfnRUuYYSqJErONFOYBOGA7FGObKosuAJSWCSz1lBWO7fD2FQ4Slgnv4VZwOXS2y
	oysNJwH8xx5zinE6diNDqoMN4TXh1JzEK+TnbarU5zUV1j8ew
X-Google-Smtp-Source: AGHT+IEreXefgyyHRID4p6tJds7QDe4CGkc4O7Iw3V0/AzlwnNoUeApSDP0kaYcqddbR4UEutkJ/dg==
X-Received: by 2002:a17:903:1112:b0:244:99aa:54a8 with SMTP id d9443c01a7336-245e0470481mr21682935ad.28.1755596287371;
        Tue, 19 Aug 2025 02:38:07 -0700 (PDT)
Received: from localhost.localdomain ([223.104.211.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446c2f441asm103777465ad.0.2025.08.19.02.38.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Aug 2025 02:38:06 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Thomas Graf <tgraf@suug.ch>
Subject: [PATCH] net/cls_cgroup: Fix task_get_classid() during qdisc run
Date: Tue, 19 Aug 2025 17:37:37 +0800
Message-Id: <20250819093737.60688-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During recent testing with the netem qdisc to inject delays into TCP
traffic, we observed that our CLS BPF program failed to function correctly
due to incorrect classid retrieval from task_get_classid(). The issue
manifests in the following call stack:

        bpf_get_cgroup_classid+5
        cls_bpf_classify+507
        __tcf_classify+90
        tcf_classify+217
        __dev_queue_xmit+798
        bond_dev_queue_xmit+43
        __bond_start_xmit+211
        bond_start_xmit+70
        dev_hard_start_xmit+142
        sch_direct_xmit+161
        __qdisc_run+102             <<<<< Issue location
        __dev_xmit_skb+1015
        __dev_queue_xmit+637
        neigh_hh_output+159
        ip_finish_output2+461
        __ip_finish_output+183
        ip_finish_output+41
        ip_output+120
        ip_local_out+94
        __ip_queue_xmit+394
        ip_queue_xmit+21
        __tcp_transmit_skb+2169
        tcp_write_xmit+959
        __tcp_push_pending_frames+55
        tcp_push+264
        tcp_sendmsg_locked+661
        tcp_sendmsg+45
        inet_sendmsg+67
        sock_sendmsg+98
        sock_write_iter+147
        vfs_write+786
        ksys_write+181
        __x64_sys_write+25
        do_syscall_64+56
        entry_SYSCALL_64_after_hwframe+100

The problem occurs when multiple tasks share a single qdisc. In such cases,
__qdisc_run() may transmit skbs created by different tasks. Consequently,
task_get_classid() retrieves an incorrect classid since it references the
current task's context rather than the skb's originating task.

Given that dev_queue_xmit() always executes with bh disabled, we can safely
use in_softirq() instead of in_serving_softirq() to properly identify the
softirq context and obtain the correct classid.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Thomas Graf <tgraf@suug.ch>
---
 include/net/cls_cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cls_cgroup.h b/include/net/cls_cgroup.h
index 7e78e7d6f015..fc9e0617a73c 100644
--- a/include/net/cls_cgroup.h
+++ b/include/net/cls_cgroup.h
@@ -63,7 +63,7 @@ static inline u32 task_get_classid(const struct sk_buff *skb)
 	 * calls by looking at the number of nested bh disable calls because
 	 * softirqs always disables bh.
 	 */
-	if (in_serving_softirq()) {
+	if (in_softirq()) {
 		struct sock *sk = skb_to_full_sk(skb);
 
 		/* If there is an sock_cgroup_classid we'll use that. */
-- 
2.43.5


