Return-Path: <netdev+bounces-295942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pNpeIqQZI2rEiQEAu9opvQ
	(envelope-from <netdev+bounces-295942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:47:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFE264ABAA
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:46:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WnGh0KpA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295942-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295942-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05323302F27E
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 18:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BCE3FADF6;
	Fri,  5 Jun 2026 18:35:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671C53F9F2F
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 18:35:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684554; cv=none; b=cnbA3D2ct0XD+ljHDsG5Xh3GXpqqT1Il9ije8yHwJIr8DZvOBhp3baMD1Wpw5aU/2YuazUhMJVnvi0oTpUK1gkxiCOR1MN3EOWbv6iaV5oCqnnitqxOzm+Xd7H4qqnaYyw1KwqjZhLQ7FhzKYw/Relwb2njxroKDRQr+QV+8RJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684554; c=relaxed/simple;
	bh=wnRAvTrjaOxj81+/1ME5NxHLKUPB4bRXifWPbuOO70I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zg/c0EJqxY1fgB/paYFSasf8b5pjlq8OJyY8u4NX1tl3OusKqcl9mLbmCin3unRCxCzoRl6AV5Kc48jiyGBFEPq/yK9vT2MFmcgjY/+s3oi/ICIsBBI9kBgbmXbKILiaSUKDB4TyIKmAIuK7k3pb67gECrAewHqSxR7L1bFPfiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnGh0KpA; arc=none smtp.client-ip=209.85.215.175
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c8584e80bd3so1034058a12.3
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 11:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780684553; x=1781289353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6NRQH/3Ow1XDrj5HT1DoF/ebJqBD1PjIhN5lXfVsE0s=;
        b=WnGh0KpAMUe3f/NV+0xsJeNbhfWPwuQ2m9tw2xPGx33i8kgzvgE3NvWlo2AnfN8CsE
         K+Jwm5fHFiKrXT4ec/kpntzHzQUJ8giSx+uFjj54kgstszjVpRmbgBjTpLTA+70H0MRq
         5i6rltUTjNk+l/dg/5H631Fe1XIzwmjLPKchRKBzU1CXmFd0Ok+hPyvN/mXL19HtqsLz
         gz70T7PkZZSsy/LIF8wDQckFJoZF4dUNzFzqmGpdXK9Y+cdH3sjgC3KXuP/4LCqf6RY1
         JG+i4uLuk3mFjavCyl8OSG8PGcNNF3kZJvmQDxVo3jsxpSPle1I4b/7hs4ZuDoQjo8Es
         y10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684553; x=1781289353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NRQH/3Ow1XDrj5HT1DoF/ebJqBD1PjIhN5lXfVsE0s=;
        b=BPEwN5FZftf0ppVbZ4M1qTeOodLs87NI/zIqyiApMbXdX92cH1+svDe+u70PQ39fan
         C+aaTQX92/iRGmcPPHWdwQgEdjgZQ7nspa3wVEvDt3MZTWBBiZXQZYtqFCD6h4ASNSXk
         4hfHe/t6cOYHQTZ60Z6geIVkpOi5DiwN3k5XXF5FrkABuc26LcKvGrf97wYH8rAWbGFZ
         AaiEBHOQrIO8vorGzKNo0Zj7c4nopKEWgQTD6fHvmLufuJZIX91aVE21pXv1chzu+viD
         ph2PQ0a93qv+xNNOIRJGStMugdbd+rYEd833pDVsP5KcYMMSLIK35LzXBLnes7wPO1/b
         DYvw==
X-Gm-Message-State: AOJu0Yxp+ltAbExi9woKjUf+9nsRrTA3rru7CgfRi8wtasROb2fm+q9H
	43futTnGomG/42+nnyLmlI1puT5knl+oOoGMfeFKA29nZqiWVyPe8Rq4
X-Gm-Gg: Acq92OHm6Bf715PmDnhzW658QjQjg3rXLCmO4EwTQK8CYfhQfPwavCEBHbqEDbgo2NH
	xEcWx1BEDM2DPDvZxw6GIIKWfcI2c13t/KgXC6jSrR6CwQ/NnO4yvWpctzJwmwBkSz9Bz/X10ke
	eGV9NfBfsDpc6MbRXPSZd+4mCZxU6zXBXRul4nN41U+HVkT9aLZ3ZVrEXmxFXM4Bb7hRf1mSUGa
	pxM1vAOJAizN+QzpIuthGn7Fj69XMHBs2du6GpOKA2JgNWl6I6PtvLn6/7PouUSvErDS//TRgD+
	S5FrEdwZEEVBhx7uFyD0ahK0I9fnrbHlxluswOEa7y+JlM7MOz+Hp5AlcHmTPS5gGKigGggrPbf
	61pmpXp90qhRVtu9amWGW9KgT8vf0bYTB4+vDSm+creOJTiFQFcISjaJUA7CWNaOMA95BLqktmO
	x2Zgq8nfHgiAsrvcOvH1aBT0Fa
X-Received: by 2002:a05:6a21:4cc3:b0:3b3:be1f:c89b with SMTP id adf61e73a8af0-3b4ccf8e5ecmr6270997637.22.1780684552651;
        Fri, 05 Jun 2026 11:35:52 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a624fsm8496978a12.18.2026.06.05.11.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:35:51 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/5] Object relationship tracking refactor followup
Date: Fri,  5 Jun 2026 11:35:46 -0700
Message-ID: <20260605183551.969144-1-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-295942-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: DAFE264ABAA

Hi,

The main patchset refactoring object relationship tracking in the
verifier has landed and this is a followup that addresses the remaining
feedback in v6 [0].

[0]
https://lore.kernel.org/bpf/20260529014936.2811085-1-ameryhung@gmail.com/

Amery Hung (5):
  bpf: Fix dead error check on acquire_reference() in check_kfunc_call
  bpf: Check acquire_reference() error for "__ref" struct_ops arguments
  bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
  bpf: Remove WARN_ON_ONCE in check_ids()
  selftests/bpf: Use bpf_dynptr_slice() to read file dynptr in leak test

 kernel/bpf/states.c                               | 11 +++++++++--
 kernel/bpf/verifier.c                             | 15 +++++++++++----
 .../selftests/bpf/progs/file_reader_fail.c        |  8 ++++----
 3 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.53.0-Meta


