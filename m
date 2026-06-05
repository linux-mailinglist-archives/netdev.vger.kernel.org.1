Return-Path: <netdev+bounces-295968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kJKsGK4vI2phjwEAu9opvQ
	(envelope-from <netdev+bounces-295968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 22:21:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E0F64B217
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 22:21:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Nn1OleIf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295968-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295968-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B8B13021E6B
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 20:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A748837F8D9;
	Fri,  5 Jun 2026 20:20:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648D2330B14
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 20:20:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690859; cv=none; b=B4D+JrFc5RD/Upqxwu8axA4TFataLSvWcaHgYehc+/mwPGVr3ELAzS/iyvElkBgA2832ewZFQqM/7mC7NWbRlVLp2LVRMMrOBHk+BbbONVRUWPqN2+Brd67AQHSSDRV3d4QzBSXrAZ5y94c6+2hcowGcxo9tVP6PGF2WTSAbRIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690859; c=relaxed/simple;
	bh=IF3bLlVAYEJNXlOm/4+Rlrx92Z6NYnEGpeWPNJ04zhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j5kHb6pcx0LIFuDQBAunUF4NdQG3H+nPawZci+y2VGniWRwlMEQPRXqCA/7VkMZYbzO0KE5wXUfS8y0uadeZr1NuHICGB1k6HBUSg4R87l2wsSwWefgEUthrW5aWIyg0JOjs5Jr1EGkXrfi4Baed71BJ3hs3zlkvq1ccIcMg0n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn1OleIf; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0c35980fdso23429055ad.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 13:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780690858; x=1781295658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1Y2tNa2HZ1zwUJNN0kQs2FqAhqUWf2d0UQ2wElOB1c=;
        b=Nn1OleIf+dmbxSryGxG44NyiFO0nwxtB5zr386IYXNzByQHhB0LQzbtGZCglmE+odd
         N+A3/qGtPs8BxglaimoGX+43hW0aJDDMSb2dlUamkbQA1WBiYB9Sw8EufQO6CP0ac269
         FY+ZVMcrt4ZpT91x0DuRhd6elpWKoF/a2IaOzfobTx+zn0LIF2V3M9iBhMPaQC81vaM6
         GQ44xQcb713zbelJQmeBAbZ5Q7mKzv/SGV0UgnujkxKhz60dCixvFSG01wOQGWAOgj66
         aGVcZo0nBIeqA+ZxR7W9TEWhnurc8q8h/Pu/w0/eYfOCYgBf7KAhAbpbK8HNkU2DGXHo
         KDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780690858; x=1781295658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1Y2tNa2HZ1zwUJNN0kQs2FqAhqUWf2d0UQ2wElOB1c=;
        b=XvbLY0GSAkumcBpgjFdj6Lo+Bm3FdNOCHO3sBPDOKaekCgh2LGiXDHOns5XQwVhef6
         lDkyvgZmMq0WBDMYtZ+hXa27hMgL0WmlFFi+nbsRAv8fcpYL/RJpAzX6HHt2ab/hmVcc
         tc2ole0yHKQocU2o3yKfZeJrRXAoPAA8roHOUx1+t5GB0mRXWuu4Uw2Dl3MrokZwgHL2
         szlGl+6Os7sFyx+v3pr3BD/ktF1a+Mv+vw41u60UAIK3PuuFXVh5f0HwgmzFeADPdNrx
         cHVEeLApMO06Rbtn4ZE5YjBzRISVqK3j3hTc1pChgOBy2CjSgxPOP3wyxxmT6fwRvM9D
         vLsw==
X-Gm-Message-State: AOJu0YzirZpU7VhGsscMslAMPCIhmPZLGNzzsuuAgx3qMSP1Irhix0qX
	905pbQDdfFu/4KcS5WansPihen/2VwUjVoIcUmevml/OJwzOjHrwsAv1KmAOEA==
X-Gm-Gg: Acq92OHGZMbkgeyGKQWlBqSCmSjCpECuh4thUfEENf0cSlbDcFwqmCiCBW/8XrGJtck
	EfCHpESzMiupvS8X2GnOtvPFmMeF59/iQdVCkvhLkXGG0Mezf1mCrku68ncsZCb5qjL3Z7Yo2A1
	Oh/P0IfZFjelP95g3o4sYZ0fHGS+j2PM54lczjT7/pj8Qm52pbs5bRhzdz1HffjtbprDm0QZmgg
	u6iBupxrPTUj+iktf3l2v+P9IDC61Jo0yzZ3DLm/0prbswyMxTBNtRsa4A0PHUyCVOrLvqtWUza
	5JRQzxwAfWZ/gMcdUDau+xLZbTgqVhG89LGDSmnjGsaFti8M2zi+6tJ5Ut9SqiA/haLd+5EqPtM
	2CyL+ahQq0CfpbxaZvrcn0dCts3dg+XFlhqHyzJxk4RD97DdlhkCFU7EA9T3pFE1JJjTtkRdFuA
	KpXDWxHHEiFSf2alMeCqC8TVQ=
X-Received: by 2002:a17:903:15c7:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2c1e78acf24mr58595315ad.0.1780690857586;
        Fri, 05 Jun 2026 13:20:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664a67b0sm101155435ad.80.2026.06.05.13.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:20:57 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 0/5] Object relationship tracking refactor followup
Date: Fri,  5 Jun 2026 13:20:51 -0700
Message-ID: <20260605202056.1780352-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295968-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4E0F64B217

Hi,

The main patchset refactoring object relationship tracking in the
verifier has landed and this is a followup that addresses the remaining
feedback in v6 [0].

[0] https://lore.kernel.org/bpf/20260529014936.2811085-1-ameryhung@gmail.com/

v2 -> v3
  - Fix cleanup in patch 2 (AI bots)

v1 -> v2
  - Add patch 2 fixing silent failure when acquiring reference for
    struct_ops argument
  - Add patch 4 removing WARN_ON_ONCE in check_ids()
  - Add fix tags

Amery Hung (5):
  bpf: Fix dead error check on acquire_reference() in check_kfunc_call
  bpf: Check acquire_reference() error for "__ref" struct_ops arguments
  bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
  bpf: Remove WARN_ON_ONCE in check_ids()
  selftests/bpf: Use bpf_dynptr_slice() to read file dynptr in leak test

 kernel/bpf/states.c                                 | 11 +++++++++--
 kernel/bpf/verifier.c                               | 13 +++++++++----
 .../testing/selftests/bpf/progs/file_reader_fail.c  |  8 ++++----
 3 files changed, 22 insertions(+), 10 deletions(-)

-- 
2.53.0-Meta


