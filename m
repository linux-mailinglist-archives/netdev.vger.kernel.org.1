Return-Path: <netdev+bounces-284885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC56Fs1Q+2mSZQMAu9opvQ
	(envelope-from <netdev+bounces-284885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:31:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E13414DC3C3
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C97613048287
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FC7481A84;
	Wed,  6 May 2026 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTAbnybn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B24481FB6
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077660; cv=none; b=r6kpcXnI+2UhR9kM9ORfVb5zIiVna4FaBry46bWhxdVlwSf17MVakr0rWIhcHC+u00mFHSV3unpASN+fPInXwHnXPh9qSSRIknrtzYS9uZS0w/Q/1NfBVcXoN5epkto/qNcxtNsj7zSTYdG7H27WSHMO+c0ftpM74fUsLDUmLnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077660; c=relaxed/simple;
	bh=1Ps2Uvl/LPepHMBDlUY4AENnqrCBZ/NnJ3wO3wlwrJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p51po2g8T9hbv8Q2KmH6QWSfnO+fvZR0QzPpvt7+M9Ym7Bl8Dfcp5LPCPDPcGicsR3ro8/UK5bu457Y+4H3PgBqbEVaDNgh6XtcaFrYOpu/vDARMGe1iIl5z4lcxobpja1r5kuuNHnj0vIpgd8XnlO2YwykzjXil4yCDUAE38rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTAbnybn; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b3d6b215cfso103958446d6.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 07:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778077652; x=1778682452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rJWz1pDbyoadWp6yHfOeNQO0FWEwox+z1MU3VR8Pqg=;
        b=WTAbnybn/LrcxfqTiSrW6OpRXTGN5588k34bvZtuiUVAK7xLCDfvdr9L1V8L8o+wSC
         PzNwdZVJnX5TFHlbi/iMI7rCM2lf19hNY5abPmfR71FZBqpDFTR19mQW9hXN1k1yesyG
         p8vR6mrk8MjEPpzsncOpIRyh6YP8hlApDLA+4m8f/KeYks+3QSkMJ8PXeAqF1gc83ZkI
         WJD4BC1aYNM3O6XTkWgSd0zFHgQ3WK2HzbeRHAgUJxsDHRGVM6y9t3AQrbZF7WE99rCt
         Vw+nOhADWiN7XiHPOYS83kNyhacLNak2qVcHH8v42DfZYQNhBk0mBajIgqyrQbyx+jZB
         svBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077652; x=1778682452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5rJWz1pDbyoadWp6yHfOeNQO0FWEwox+z1MU3VR8Pqg=;
        b=UNWyoKYWpLhOmbVd+zct7AKg9vjwATaDzFea/mSNxc1IQ6+SmWQ/+XjxI18MWhMUbn
         VfrSJNeMm9uwv7d5s0R2LlgPPX5mxDUzGRVQQ2FOhd5y58QApBViNLbHeZh6SOJ2VyYT
         TvzKdteKdXkwNS5RavPfmyCBFgltg9NCNpSf6u4E4yC5s88TQiRCaU/S8rshy3yQM5fV
         0JuyYC2+s6NAUmBLgm60vHSOXV9Ylgx9goHf/nPoYrGO0T9glCVPrk2Tg1AkrlKXSq5h
         WcYW/Rdjez70t6ksu6EF8MXjRgRCHhexJbSGxqyEioSeQcQ5wU1aGp+cCUKg1qf8LhVA
         4pSw==
X-Gm-Message-State: AOJu0Yz7Gf3NYf/hiouXdha9PvgoWYas8nl9xEl1WqryNqT1pOMZUJCc
	LqxINXVILdf3jAXor50t+JVilCKSZ9qP2d6oWahMUYaKWeqYe2wloPzK
X-Gm-Gg: AeBDievp5TIIIOuosso4zIBGVya1eb0/BDTVJkZ6GttRUfgBVTbEXPedRPWpeGnWx+V
	90HlgsYsoqqiPXFxZZACKXL+ceRJyxFr0SBR7dRlQnLVOtHQcV8X6wkj1va7qBtpyT4Lj/3ysmp
	zR4Pw0o0aMtGfT8upd1VCHoeGyhBimlu4D/JSGOwd8QKQ9q0ADKnbDMTWkb5S/hmOuT0dX3mKyq
	RNku0X/w4WbwgdsshsTylpgOwM+sZdCxuGn34n1JBn47lk6pIkvtORaO06FFUcSmbgkYJk+6uaT
	iwz+Y9fFYVt4ahIbnn5HnntLDrVcU9xKc0MklZ9L1/gvyYRaw9XrYO4dy3JwFZPINj4oZxuAhPl
	gOnBZQK9jnijoeyKM6Ym+VioTKgrdNxhDtGfImCLkXttrVw6qSWOX1z0D2Qfmeei19vPEbdayDl
	kMvOoka9FM664Vote3lTJ/URya+RKbhddzLcU=
X-Received: by 2002:a05:6214:4c87:b0:89a:629:2203 with SMTP id 6a1803df08f44-8bc429754fdmr44284996d6.11.1778077651996;
        Wed, 06 May 2026 07:27:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c0e7ebdsm201474186d6.29.2026.05.06.07.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:27:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 12/12] selftests/bpf: Test using file dynptr after the reference on file is dropped
Date: Wed,  6 May 2026 07:27:08 -0700
Message-ID: <20260506142709.2298255-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260506142709.2298255-1-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E13414DC3C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284885-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

File dynptr and slice should be invalidated when the parent file's
reference is dropped in the program. Without the verifier tracking
dyntpr's parent referenced object, the dynptr would continute to be
incorrectly used even if the underlying file is being tear down or gone.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/file_reader_fail.c    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
index 0739620dea8a..d5fae5e4cf9a 100644
--- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
+++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
@@ -50,3 +50,63 @@ int xdp_no_dynptr_type(struct xdp_md *xdp)
 	bpf_dynptr_file_discard(&dynptr);
 	return 0;
 }
+
+SEC("lsm/file_open")
+__failure
+__msg("Leaking reference id={{[0-9]+}} alloc_insn={{[0-9]+}}. Release it first.")
+int use_file_dynptr_after_put_file(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	struct bpf_dynptr dynptr;
+	char buf[64];
+
+	if (!file)
+		return 0;
+
+	if (bpf_dynptr_from_file(file, 0, &dynptr))
+		goto out;
+
+	/* this should fail - file dynptr should be discarded first to prevent resource leak */
+	bpf_put_file(file);
+
+	bpf_dynptr_read(buf, sizeof(buf), &dynptr, 0, 0);
+	return 0;
+
+out:
+	bpf_dynptr_file_discard(&dynptr);
+	bpf_put_file(file);
+	return 0;
+}
+
+SEC("lsm/file_open")
+__failure
+__msg("Leaking reference id={{[0-9]+}} alloc_insn={{[0-9]+}}. Release it first.")
+int use_file_dynptr_slice_after_put_file(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	struct bpf_dynptr dynptr;
+	char *data;
+
+	if (!file)
+		return 0;
+
+	if (bpf_dynptr_from_file(file, 0, &dynptr))
+		goto out;
+
+	data = bpf_dynptr_data(&dynptr, 0, 1);
+	if (!data)
+		goto out;
+
+	/* this should fail - file dynptr should be discarded first to prevent resource leak */
+	bpf_put_file(file);
+
+	*data = 'x';
+	return 0;
+
+out:
+	bpf_dynptr_file_discard(&dynptr);
+	bpf_put_file(file);
+	return 0;
+}
-- 
2.52.0


