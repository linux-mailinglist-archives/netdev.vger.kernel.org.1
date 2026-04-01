Return-Path: <netdev+bounces-273879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFr0AKiczGkaUgYAu9opvQ
	(envelope-from <netdev+bounces-273879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 06:18:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ED53749A8
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 06:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E89AF30306CA
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 04:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470322D061C;
	Wed,  1 Apr 2026 04:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hixdK2/n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23031B4F1F
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 04:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775017124; cv=none; b=IdUp1Dc/L0eSdU/HD5eukaTHcnMnC/SpCYgF+ZT/NIzzwfpnp3XX1zmFiquT67kcgkXX2WGsx7twVRIYgzi2tD0OHYNyC27mjU5kiJiSLljbN0ggosf9wCxCMnWuStRHuvxWErG0+x3CPmZG7lusSk3GhAuwqH6JzfiyESY+ImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775017124; c=relaxed/simple;
	bh=acXAuzX23qeLxDhUDfzHQME8Xoq1UVBejWspbllF3Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RPh0V1pC7lNpJKK6Ym8t8YlpijciAYagJ/EAs5tMnJahci1MpIYLTSzDPZc4ZfFiM0qk6jDDgoqXhs3eBolvWx8oCcC5ObmcaPCTOrYMOk2lOYHMGR9bZHChZgc3WbZJiKWrcQd814ECMDWBgzjTS3J0nXC9T20O5I2RnIIwVD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hixdK2/n; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so2577336a12.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 21:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775017121; x=1775621921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=apmMiJDnFUeVM6e3K+nerLgWWso8fmcaDEUHElGftZI=;
        b=hixdK2/nobQUTw+Wr6OKplotNucQOYExJGWXtJUWW+KEfxTt6kkdBKVK7JeqEtSvQ3
         3t/GfYu6lL6pKD9F9fClYD5HPnSFuH+YvsazPXhoOznkLWGBq+bweUWhTYoJQE9LbcVs
         /9YJ6+F0SQfTSnWBlBgPpir14+UcSYTBcq/m0pPYzIUXCFpLPtcBkuXVrDwMqVXCHyWd
         s6xPAYAIPwkECgRdo3f7IRWP4e/P01kpO2FO5quzHuaOZ80AojQfg6M9WK7KTM02BKo4
         nkUhse10MQKENxyr8JmwIU97p+FfN/bVgzyeTBcJ6PNJYHQQ2QsC6i7fqHdcfskmQyr8
         sjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775017121; x=1775621921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apmMiJDnFUeVM6e3K+nerLgWWso8fmcaDEUHElGftZI=;
        b=Rdh7gvMaUgbjRtkRmod0f5+GO3BVJy3k9cfUZxWGLKIuDApbedsvqTDXsZwi58QBOW
         wlMbpyDy4FZYZ5YfVzomvupQBVid5ORNRBA4chzg1ELLetkysDGyJe7K8JpwZf2ZR4k/
         BxxVK/kWjSl2cUz1E+pvumtYnoWB4Q+t7XcFrbkRe+w5QrbB7CwjSGUrUnA4Lh1ExJ2I
         cT7JR5rdE5fASbcpglajgRsSOyQaRv3nVey9+rJygMlZh/ee/g1fULK4smgCYWbno+Nd
         2alLaAiwwTvrSrKyWOwPLILs9DMOAJyN4lxCfWC1u5IuuiFRSMZuobpm1in1tSzrLBx3
         i/dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzA/bp8jAkmHwQNSPi/NJkIgLHSSii1HMoaUISY5IwXFTqlLNehRYF0ikoeL7Zr6LrA/9tm0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS5mvp7aDCDS+2gpAGMmpRFy9TDdfS0etIFEpNYsar0rVS4A2w
	WjW4Fbn8sGufEh+g2UWilQdhtPW3fb3/BhQ+Nj8U1XB08rzMJRSfx3Mr
X-Gm-Gg: ATEYQzyi78QWO/W9wTWMQe6LoeYKoSQmChGfgXcL8M0EP4azaWsFGXRzi4lEK3SC/qj
	Gvdn3qrEsKeS+GEmpEBfybnEq3Qt41pRssCHmZhCWOU++jkFf8AuSkCnvBWLjbwfgfoKo7Vsbes
	8knjmhD0ThSis483v+EDfyb1kfTcNYDFPsX6Vz5QxYSVY58sAxUu9+f5sien68VIP2FPKqLZk6+
	Fh/wH4EY+6OZsd85qFQMkWKefLV/VBFa0CB+MNtFKuEXGrZOhwFuUXwRKhlsAsadRFKt2MGSV1n
	XUDDf0w47r21980K0B2I2q4g+fXHJ9aMZU21vIsMTnjLHro5xeoY1W5mt5xQett7BB6RVNi6JVV
	OWZAwFeCrzsBQchf7ew2jjiklSn49RYvzFa3deaek5V9d2Fwm7bvFoz0JkkATzxuyttKKmAP7t6
	Jv1QEiYYl4M6hTO917gLZl0vQsfycI2sbLluzdDnzqftCMV/1GPhQ0YGk09GvDpJKx21J3A1vRs
	SbfYUs2uZ4o
X-Received: by 2002:a05:6a00:3697:b0:82c:215d:5e9d with SMTP id d2e1a72fcca58-82ce8b09852mr2056850b3a.32.1775017121195;
        Tue, 31 Mar 2026 21:18:41 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82caa8be173sm10963672b3a.55.2026.03.31.21.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 21:18:40 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Phil Sutter <phil@nwl.cc>,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] ipvs: fix NULL deref in ip_vs_add_service error path
Date: Wed,  1 Apr 2026 12:16:12 +0800
Message-ID: <20260401041611.3302189-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[nwl.cc,vger.kernel.org,netfilter.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-273879-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: 99ED53749A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When ip_vs_bind_scheduler() succeeds in ip_vs_add_service(), the local
variable sched is set to NULL.  If ip_vs_start_estimator() subsequently
fails, the out_err cleanup calls ip_vs_unbind_scheduler(svc, sched)
with sched == NULL.  ip_vs_unbind_scheduler() passes the cur_sched NULL
check (because svc->scheduler was set by the successful bind) but then
dereferences the NULL sched parameter at sched->done_service, causing a
kernel panic at offset 0x30 from NULL.

 Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
 RIP: 0010:ip_vs_unbind_scheduler (net/netfilter/ipvs/ip_vs_sched.c:69)
 Call Trace:
  <TASK>
  ip_vs_add_service.isra.0 (net/netfilter/ipvs/ip_vs_ctl.c:1500)
  do_ip_vs_set_ctl (net/netfilter/ipvs/ip_vs_ctl.c:2809)
  nf_setsockopt (net/netfilter/nf_sockopt.c:102)
  ip_setsockopt (net/ipv4/ip_sockglue.c:1427)
  raw_setsockopt (net/ipv4/raw.c:850)
  do_sock_setsockopt (net/socket.c:2322)
  __sys_setsockopt (net/socket.c:2339)
  __x64_sys_setsockopt (net/socket.c:2350)
  do_syscall_64 (arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
  </TASK>

Fix by recovering the scheduler pointer from svc->scheduler before
cleanup when the local sched variable has been cleared.  This also
prevents a latent module refcount leak: without the recovery,
ip_vs_scheduler_put(sched) receives NULL and skips the module_put(),
so the scheduler module could never be unloaded if the kernel survived
past the dereference.

Fixes: 05f00505a89a ("ipvs: fix crash if scheduler is changed")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 35642de2a0fee..e0c978def9749 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1497,6 +1497,8 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 	if (ret_hooks >= 0)
 		ip_vs_unregister_hooks(ipvs, u->af);
 	if (svc != NULL) {
+		if (!sched)
+			sched = rcu_dereference_protected(svc->scheduler, 1);
 		ip_vs_unbind_scheduler(svc, sched);
 		ip_vs_service_free(svc);
 	}
-- 
2.43.0


