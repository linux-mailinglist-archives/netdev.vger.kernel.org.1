Return-Path: <netdev+bounces-295433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aplsFzD4IWp0RAEAu9opvQ
	(envelope-from <netdev+bounces-295433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:12:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEF8643BE5
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:11:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aUbEIVSH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295433-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295433-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F6F03055DED
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080D430D414;
	Thu,  4 Jun 2026 22:09:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E7030D3EF
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:09:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780610948; cv=none; b=IqN6xpcfCDVQ0pz2FOD/GtiqTxMyUJKloJ2ms2IEXH5tMLbDbVW2f3PBfL/I/0V0Ybag8qw0pwA3A99NEeueExe2GRi61VR3prA4C2Lr0a423NsxbrvWxhMyF/5sYR/Yg70lPq+TQsx3FTobZOXNGcyB2PsT7/fnznnOhpfFiTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780610948; c=relaxed/simple;
	bh=6v/aIgeg/cCjORMO77cTrI87aAwG6H3vcqGwhTc3UQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rODGuVcs4peFEXYjwoGmC0MSjaB9Pz7pPUg7lIWCBVtwbtbfeK8BgCfa59dFzKmeaCFaTGkDvHoUrO2SRJL3N9daxqx31F34Y6/0ZahNdSed2XzGFDPU2UwIRkFNZ6SgHXWikVmBPXiqd2GjEP5hbDVbAiqYJ7jwmZGa2XZi4cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUbEIVSH; arc=none smtp.client-ip=209.85.215.173
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c858d69bde9so596718a12.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780610947; x=1781215747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/L4DIvq3OTXOgiCt1psuEKnggjX/25MwpcePnkwj24=;
        b=aUbEIVSHpWvEY0uvle2riXMSXgyoZprTB7UmY4dzkACO/PtNM1YZ3g4Quzhn/fcXYj
         8M6lEboqTCZHe21CwJICzJan8BD0bE/Z07HBbvcsJ49Qwep9Ol/BzTQDIS8GsinoXINY
         ve8Xz1eIKVOI4n7xI2SOPTdcVU9dgBiQUZTEh8Ed0b+u5rf9XUNIXAWzTZcz1rAb0b14
         wv26cNsSsy1Dy9ZYFS91NvWbKibD3cAUVKNl45PBtlYTu4vJTsqYoBw1mClPTHv+13gA
         L+5IcrUqLdbEuRd3gAWcs2s/2mVGVu6+Smy3U2EkJ77DlJH75fGxQGC6VXpRCimp62GV
         Ii3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780610947; x=1781215747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M/L4DIvq3OTXOgiCt1psuEKnggjX/25MwpcePnkwj24=;
        b=nETwGB2kozwTtB9hp07OPRgE3G/u0Dfl8hCYx0xElMubepofyUNBZKiyEQBd96QwJX
         hEK93b7zeXVIw6UnZJeAWqpJ1gdMkpvXHBm8CNWGQZUA+cuIr5f/kccSQ5QYib+HSw80
         yeD+ovM0peEs2KFrbjvtgsQOznlmUpCsj4M5jXUkRk0K0cmjii+1AGKu/EdfwqAJP4Ir
         nyGPDtp66j4pb7vyjXTC78soUCs0F+IeP6da8Ra181a7tyiuRSQSRAgM2DLGRFHL66UN
         ngmyP2g9LXQ3MfOervKPeCko+ZeF4L9D7/TRHrzHY6skJfC/DZZnC9lLOdP1830w6txt
         4iIQ==
X-Gm-Message-State: AOJu0YzBLfwpr8C5lMeVQW8u/D6E3NM63nTxZ/Z1iKeEBPAaN34T7bSp
	2XG0SgZ+GLEoOUIr/pwW/KHOpB10QO8x/E8lIYyi7sgXtnfdjx+9DoiT
X-Gm-Gg: Acq92OHxaodc0QMzsmopsaRbRN4ZDIBM4v7flXC77oRzhKc3KxWN/xcsoekhotfd8x5
	dkw+STJTnkoC4Tj5Pvd48vaLjD9x70iU5gyrBZek6lpveFVa90JOM7tDQXSujD2LD6Vy4M/sP9q
	q19NxdYgesukzrUfRO4/PRbUXrhA6GiU5PSPilXlSmSoK6rMt1rMMASIilJ6SlZboiakzkmW8cg
	POoMfww9u9HYPuqtQIMgYZs2qafbDC44vQu2Fju9Tw4S0X/fvrpW6nSsQF7Ba51Eq3D7Hi6fxVF
	Paruz0jVe8ksqpk5nRQE8wpGX9JccCXhpJk5oSQx9272wzV82CYPZ8mSp0N4Z/4XQdhsOvkgoEq
	pei0hKqyEB/M0J/YLUh94offfO6k3ddmUUzr11WjQVoXtXJVhie1c6B4Jxu6GJ3oLPs4p4uWbG3
	IKMFboNS3ntuteIn1PjAJrmdKX7cX0YQjagso=
X-Received: by 2002:a05:6a20:1c8f:b0:3b4:6f7e:d0f4 with SMTP id adf61e73a8af0-3b4ccd5ffafmr989568637.15.1780610947191;
        Thu, 04 Jun 2026 15:09:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:58::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428325d9a3sm7075507b3a.34.2026.06.04.15.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 15:09:06 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 1/3] bpf: Fix dead error check on acquire_reference() in check_kfunc_call
Date: Thu,  4 Jun 2026 15:09:02 -0700
Message-ID: <20260604220904.1032145-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604220904.1032145-1-ameryhung@gmail.com>
References: <20260604220904.1032145-1-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295433-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: BAEF8643BE5

acquire_reference() returns a signed int that may be a negative errno
but was converted to unsigned, which makes the subsequent error check
deadcode. Fix it by declaring 'id' as int so the error path is taken
correctly.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8ed484cb1a8a..6446db9628ae 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12817,9 +12817,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct bpf_kfunc_call_arg_meta meta;
 	struct bpf_insn_aux_data *insn_aux;
 	int err, insn_idx = *insn_idx_p;
-	u32 i, nargs, ptr_type_id, id;
 	const struct btf_param *args;
+	u32 i, nargs, ptr_type_id;
 	struct btf *desc_btf;
+	int id;
 
 	/* skip for now, but return error when we find this in fixup_kfunc_call */
 	if (!insn->imm)
-- 
2.53.0-Meta


