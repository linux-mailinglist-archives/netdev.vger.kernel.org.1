Return-Path: <netdev+bounces-295432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lx3SBiP4IWpzRAEAu9opvQ
	(envelope-from <netdev+bounces-295432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:11:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C6E643BE0
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:11:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dOtP1aR8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295432-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295432-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0B52304FA54
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CE230D3F8;
	Thu,  4 Jun 2026 22:09:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206DB30D3E8
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:09:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780610948; cv=none; b=R6mpl2C/3/Z01uFX8q1WiaFWRIrhP2WcydKNav2LTOI3a8ggZKISwQsy4SMeQWzhhHAOBKnb1fT78hbrWV+IdsaPfjteXDBh6BDHy4WCPEkkdP0ZnivpS5cYiFajf6hGsEUVbNRpR7+ITBORgnSXlc/DiK/rGntDjS5wrGU8RQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780610948; c=relaxed/simple;
	bh=wl1EgPZ73oLh2FZKrzVhNcIqNN4ssianfunB+skD6i0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sjLJGXrOtC3y7Cm8Lb4uXLqfJaDmU2R1KY5Yrv39UB2O12zgqlLVrtXm8YOLYgnt1B9snwLRUHRYq3AEWTXDX/ukfkRCltq7YvX/jfF/fHugaQ7vOiJxZrHOH6U5dFNj2v0z8eJ+iNFV0mmApRqgPi6xnrgV/GJPbV7G1nKwRnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOtP1aR8; arc=none smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8423f420455so556066b3a.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780610946; x=1781215746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xe4pjIvCbIVOQdn6bIkFT1c3V4LzfoAMSIQAWXY6Goc=;
        b=dOtP1aR8Bu/77/mCettqYp5d1dcU0M5IgKZyI8793+Mg9sIDzisA2ql/x/zNDpArAn
         8xAt+Jn/+YJSAjQ/oUqy85JtA8cPDSa/gmdpNAm6lcXm5OOrtUH3jnBMBnJF18lV/9so
         okihSpOxOpH92Ws51O3tofR8fxwdkUGXeznj5qRtW+em5o6Srbw9u/pCWrnITttygjNw
         j2s1mpr8yIj9w4FRKzypiuGSP+cFm2/3PMGXlk06ef6x/2qf4G0gLIa1GcQ9zIpu+/9E
         IF05NBTqSLspeGo58pLYTzs6clyplnEX2GWdGABaIcWXAKFl38KCkzygtdLwcYL7xkK6
         7cHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780610946; x=1781215746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xe4pjIvCbIVOQdn6bIkFT1c3V4LzfoAMSIQAWXY6Goc=;
        b=OEX2B2PU7+TUMOX1c4K8ioxaksWe/MHyAAJK5/8gwB3u9wUeKReQhEOyp2WE3QKozk
         vQJCJboomLtbGBQaFJ0tcKPWrYj9IqB+hNO5BHMxMiHCah8yGYs1t35Nk3EPd68rTAet
         +/uGBShJ+ACIRw3Gku9a8wiRKom2z35IbveixWWDoyrENz2/aQcgiLW2g/RY0W8bPedv
         rh19UmizCZ7DHJmiem855B7gC0mfi2cGSr/HIDOApF2MD/DxizMvIBoQcS/YzSvrXkyi
         bv8tZ5cAnlXNkqxnqTEXaj5VuALMfM4xR5oyDvZOvUoMbsr2SjrLRXgRXfLYFSJ8wRtN
         qh+A==
X-Gm-Message-State: AOJu0Yxm3zP2fPQ7kMEAgcZUdJMnfu+4F3WZchWr8dYwcAImtWEAkCXw
	DF8y44KGHOzOZHeWb1y1OHumPpj9hcOR7ezuekxKlGwXJFpCmkBCXXX3
X-Gm-Gg: Acq92OGoxDJ2L5TlttH7/qRR92T7jToRoW6jpA0eluonuhhdGG5nzQA/6TZBVMDDaak
	I3oONP6EgTOwOQjtIC5ulwwciEMBKy9o3yHtJBY6sLDuhAKT9SF0KNOSXrRUBoqCGSEst6oT09n
	ZO/1IY/HheYA55Z3zuWI4Q29jSnhipJ1RH22ymYFzfjJpDGvJN6Qvl+Pn8IptS6vsvhLRsReb0u
	5ZNJuci7pjQL+JlGjSShJBI0UcPYBxaC7qNHF+AoTMw9+z29jexjxJ+XJK6ylYfdCek3It2eyte
	nkf8uJBeWCVlzXdgWAte76+1O+7N5eVUepEqUJpT/AmvOKIL1vllIzhtGduU1U5GXJAfp9KxpHQ
	YiV8vneAiyHCI3FMgIVgT5agb0UeNtjldom5nR9iLlx4bR/bVdlgOZJM3NyFe2qCUgIW0FZSnO1
	vSwRrt+gjyKpJdIZOuhdUchIsaxzhZzgq+V7M=
X-Received: by 2002:a05:6a00:808f:b0:838:127d:a167 with SMTP id d2e1a72fcca58-842b0e6bb0bmr501247b3a.16.1780610946246;
        Thu, 04 Jun 2026 15:09:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282221059sm6693426b3a.7.2026.06.04.15.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 15:09:05 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 0/3] Object relationship refactor followup
Date: Thu,  4 Jun 2026 15:09:01 -0700
Message-ID: <20260604220904.1032145-1-ameryhung@gmail.com>
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
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295432-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80C6E643BE0

Hi,

The main patchset refactoring object relationship tracking in the
verifier has landed and this is a followup that addresses the remaining
feedback in v6 [0].

[0] https://lore.kernel.org/bpf/20260529014936.2811085-1-ameryhung@gmail.com/


Amery Hung (3):
  bpf: Fix dead error check on acquire_reference() in check_kfunc_call
  bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
  selftests/bpf: Use bpf_dynptr_slice() to read file dynptr in leak test

 kernel/bpf/states.c                                  | 3 +++
 kernel/bpf/verifier.c                                | 3 ++-
 tools/testing/selftests/bpf/progs/file_reader_fail.c | 8 ++++----
 3 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.53.0-Meta


