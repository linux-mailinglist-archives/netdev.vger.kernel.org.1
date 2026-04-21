Return-Path: <netdev+bounces-280266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL60H7v252kVDgIAu9opvQ
	(envelope-from <netdev+bounces-280266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:14:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6D04400B4
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D90D302AB57
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038E43A4F4F;
	Tue, 21 Apr 2026 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLZ2B8CO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1943A3833
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809429; cv=none; b=VmDtei/rDhJXaaCJFHPPo4uzgmuTM6d0YN+G+qk8F4hiWUJeZ0uPhGBMdNbux/hX2/D9hr8gHeUF+/o1CTuHa/ojQtNX0xSKF4YHmI7VDaOPQj8eKResoNkyiZV4XGW0ixlbfPNGuXJ1PJzQbJiVhoMYoOsMmPTmTbebOT8GwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809429; c=relaxed/simple;
	bh=qgyW8WY0XnATsZRNwyTPQb4+G+CpRs5HnNycoGTypIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRwd8NMBe8GtJIuy+TPCIz2sRzVli1fouf0xfTn7L0hWWx0lan4iwk/xeEMuRleFWQv/Qy6+0CPgVpPDXG6s9f1oqjTDSHnJU0xqizI5kXEhfQzpjQtZo925SuywS8Pq2LTft7ikS46F/59woaCVhaR2VSQs45heD7L+WDzUP/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLZ2B8CO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-358ed696623so2164225a91.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776809428; x=1777414228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLYhdfRJ97sDAX8UXbcRXQEaC5RqfPxWPylGwBsbNL4=;
        b=jLZ2B8COMLlEIzPQ6C7nLJGbaj4CUgF/GoO8A+dDx2FVNz2txo/2HVMMfFBFP3diJb
         ++tcDStgUKIjj4kCoMMD/JaIjao6f6ESyeHabpz/vCrRdpzOy1jfy4nFcrpTBz/dVqo2
         nu/LDvvKxoJK6PXyr1fVvPVTkeOJcEdUT6I6Sgou/cSOjmiHNtSxXlmGTjBexBuwisMT
         fIr0BeE22ygz/3OTK1zwumKNaoKM6OLXNb6KqhBU2q1l+PwfA4yM1o3KtYqhy4rMkGff
         08emXkvE82tTQhC6MX4MBKCsKz57mltGl4dDPMyOxsYSV7Qw3mC+yS4/JNb814UDHIam
         wsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809428; x=1777414228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jLYhdfRJ97sDAX8UXbcRXQEaC5RqfPxWPylGwBsbNL4=;
        b=jNfEN8vZMwlIz1j5KaMqkfUkpIr61lIw2HNNIAaCxq/FDa9kizz2zewUnOwKajRuAU
         lzBCrmZLEVkBrR/FaoAycl4NjCPfICRXXoJdLeL+mNz6LErS86FjpHDntukwA6dKplXq
         GkRQRBFVOdbijy4TzbUhMiVZ2bJnXD5767JcvhpEdHhKrqyIkl4LxkYfAVItYO1kH8fg
         9Zh44hGDwL78Fkd+UUVB7cR8EK0DxC+bz+Z62bnJ6WU829WU7mYvjKzQYLk9M41tXh7D
         2WtO03cReBUVRiRf2+kR14Chxevfe7SDFSlydCTiBaiy4+bJDQP1OpwLPt0HeC0QZRsR
         ZL6Q==
X-Gm-Message-State: AOJu0Ywz0pjPuFR3G0PKSEUwkT9D+Rhu3R8xsnn7OhSIopsG6nXadji+
	icBP3IXq8k30LHbKfFNqKMf40HXFWLwEKPoo4dXG0sm4JmxSSMZISusAFHlbIA==
X-Gm-Gg: AeBDieu80uxoFBm2oOEgA5g+zphFudTXIl4CZR0AOoGvP+UcyQ1w+XQ9MRKFrfWNEe/
	9Zl+Nq8/wyKNFHLv4MTP64g4sODQYCvTSQNb0xtznW3FXtgZJsnnJ3a+bdMZvctxkHC7yN+XXYM
	zgnVJVAcBd+8jFKcek/bUsOxvcEhugiQMfnQl4fySbSSsAvG6L0PMIS8TouYqGX87b8NTuXxrWP
	/z1hWkBwrptXuVKjsFDlIRg5sYrCTtbSAeB6ZpizY9Y2v0gMFcWw8gzL4Gbp3MGfLOgi6Qtr5ZU
	sTBm1ONQVmLQT8PwSrGpumu4bO9E3XqMD0lU2TZGbUulv9HR5wahYC3Y0Mx8yj0+KLFgGXxgh0W
	f1SVv8TkiWWmsNARMEtWprKB3lwkz6bnN8yGGDFus4tCcW4jmAl5+HQHbn/LOtPJ9gNrna+Va/J
	Pzl1kTD0rmBq9WrhhVbgOPYzDU
X-Received: by 2002:a17:90b:528c:b0:359:f2e1:5906 with SMTP id 98e67ed59e1d1-361403bdcb1mr19409754a91.4.1776809427817;
        Tue, 21 Apr 2026 15:10:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361417748aesm14497885a91.0.2026.04.21.15.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:10:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 9/9] selftests/bpf: Test using file dynptr after the reference on file is dropped
Date: Tue, 21 Apr 2026 15:10:16 -0700
Message-ID: <20260421221016.2967924-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421221016.2967924-1-ameryhung@gmail.com>
References: <20260421221016.2967924-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280266-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC6D04400B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

File dynptr and slice should be invalidated when the parent file's
reference is dropped in the program. Without the verifier tracking
dyntpr's parent referenced object, the dynptr would continute to be
incorrectly used even if the underlying file is being tear down or gone.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/file_reader_fail.c    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
index 32fe28ed2439..a7102737abfe 100644
--- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
+++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
@@ -50,3 +50,63 @@ int xdp_no_dynptr_type(struct xdp_md *xdp)
 	bpf_dynptr_file_discard(&dynptr);
 	return 0;
 }
+
+SEC("lsm/file_open")
+__failure
+__msg("Expected an initialized dynptr as arg #2")
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
+	bpf_put_file(file);
+
+	/* this should fail - dynptr is invalid after file ref is dropped */
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
+__msg("invalid mem access 'scalar'")
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
+	bpf_put_file(file);
+
+	/* this should fail - data slice is invalid after file ref is dropped */
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


