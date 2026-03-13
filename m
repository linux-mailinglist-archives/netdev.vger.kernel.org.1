Return-Path: <netdev+bounces-267619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF7CKZ+MtGnBpgAAu9opvQ
	(envelope-from <netdev+bounces-267619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:15:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5485428A4E7
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE0C230A6902
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D76385500;
	Fri, 13 Mar 2026 22:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JN4LYzaE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D6134D909
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 22:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773440157; cv=none; b=G1jhmMVXhH9aEjRym7JLqLfhcgoEkMtSq7IoJ9KuhHdnjp5hcsY7kyq8YKuADQHhCjSoOOSD6Rvi+o2Nqe18mzd8um63+3ET0KAZutbz1AxNNzn0HJ5ctbO82Pe9uYh580eeqDsE7Gzm43eG4lo2poYc+jNwdsLdf3cShp9HHC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773440157; c=relaxed/simple;
	bh=rBRKXwPprM37HUegKVwfVcNsabxW+lLVWS1raaRWpgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s1rZEVEPOktEECDfqpLJW2qM2b2BahnAPBoqrGdnbpuwtBoKX6UKFY5gLdK3xmvT/iHnXiQJhywcCH0A9s/BXYPxq7ol1pz/gHJ5ey4kN1q8YTmBPefkJMbf9t4Hfwt64iJqXoBZdHCLJ1Fy57JobnGItOlSS2H2Lj1Vt2DS33k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JN4LYzaE; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-649278a69c5so2528654d50.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773440154; x=1774044954; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DXzMG7YyZwcIs9g8M/AdNb6aJuadGUAGleE1leZ+rzM=;
        b=JN4LYzaE2FORMA3UEmj/YKCmhZmxtr+W5epGwRa2siA4j1kJiwOBeR5fyaxkGjRUjJ
         q1qw6BpdiBtFbRGZ718WHS0y27TipQk+WwR6q6j7CV0Dtus9QawMfweMVWThxt5RDbG0
         8NzNFNvKWwBLEDGW/y7pMl67DUwH45cya3gLwnHSfKnyOilTNqS3TpTxWenCwPaD0otH
         nqjAIEgH8UMaG9zyqpGJSMk5LCD5mPzQDklZjFMI+wbAiTXo92OES94r96NEDRvqxtfZ
         rH82+LENQIlMZHEQH9v5ZlRb/7RSw67UiJQ9jLaFFKMTOi/2HuFkAez1x2NMAp2It+Qt
         xKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773440154; x=1774044954;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXzMG7YyZwcIs9g8M/AdNb6aJuadGUAGleE1leZ+rzM=;
        b=jfUEej7KSovw/6F5LbXoPl8kSmQxnk82pZg1m0sbnL1AajHVnrHQ1pJ2LAUVRU8EFJ
         1oEwfOQbadf/iXwNmiogfGVSKyHruoqAC1HFDkz2B7a3iUlxe1pYdOBpJU0FaDJar3Vr
         5bcTf9bTI1k9jSmW1N3NTBSloXnSQ66ePe2XrdVO/xbJ8BDbCBQLFt05h0kOhyKqr9vU
         H7F5t92f85fAzHWO9/HliVAf9Qg2DiHC5Alnk7GKi76y7pWKEIHs/Pcpg1v/xVjAcgDz
         VsWj9RT+uOEKNHDYdLBiAoTEGzfM9EF7yIN9Anz373agZgfMiIyb2mTujMoNedXZbnkQ
         /Dqg==
X-Forwarded-Encrypted: i=1; AJvYcCV5P70FvmF+N2nonRdVjqSM3ft/5aGBNh2FFklRkM9ReCHzPEqP3WrlnBDdeowAXzA4GTnmDUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY6E7sg+QRbnB2m5/bcjWRF/2ppKBT3mE8nhgy4qxJ/iugt6BY
	rQxVePWPtK5/g6Vsx4AdBjh3Xgy5GL82R1X4tSs2MIMuVlq92WCxBpecZ4a6mQ==
X-Gm-Gg: ATEYQzyL0P+3CqXRcqYI/6pXmiJIxzgEQ/gOS8L86tgvS4V1tg15JCSpPWqOdk4sj8H
	Eg1F+73Wd4Gks2PxpV5O7lgxld4rWfl9iCDeAHsrnpomHS5YgHP9xsWciP3uEdWEJxYWGVFjBVj
	1gSA4MqNMjx2VXUnvQyUPChc/PyCmTHGQz57CLpVebtLRRU300oeBu6KYTzqc+Og9m62fE6Ag3X
	NBfCnjXJJ+LNo/FL9mAYJvTD6EffF4AcDbGk0ADyGMJl52176OcFsxm934ovC8Yg52KJvzKFwuU
	rTmBGldJQRBFSiY/AqDOirc1P6vcj/Ye9Ei8IXhqkMmbZDRkcN4msPBz1Vj6kuqafckGNVlw0YY
	NvbM/5u8H33LD/Ovtv8Bq/FijPkvs4c4WVmQ7jiVK973gnSmR+pKDlOx6GeDivewgcrUSkmNPHF
	g0Mww9ZY8OL1rPAXI/XwCM0A==
X-Received: by 2002:a05:690e:446:b0:64d:6658:3445 with SMTP id 956f58d0204a3-64e6304494bmr3950749d50.48.1773440153963;
        Fri, 13 Mar 2026 15:15:53 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e65b39917sm1796322d50.13.2026.03.13.15.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:15:53 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 13 Mar 2026 15:15:47 -0700
Subject: [PATCH net-next] selftests/vsock: auto-detect kernel for guest VMs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-vsock-vmtest-autodetect-kernel-v1-1-705c35bdc7fe@meta.com>
X-B4-Tracking: v=1; b=H4sIAJOMtGkC/x3NUQoCIRAG4KvIPO+ArrSRV4keRP9q2NLQSRaWv
 XvQd4Fvp44m6BTMTg1DutRCwbjJUHrG8gBLpmBotvNivfM8ek0rj7eiK8ev1gxFUl7RCl6c83I
 5Ift4dpYmQ5+Gu2z/4EoFygWb0u04fprCRWJ6AAAA
X-Change-ID: 20260313-vsock-vmtest-autodetect-kernel-dd695ed3a710
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267619-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5485428A4E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bobby Eshleman <bobbyeshleman@meta.com>

When running vmtest.sh inside a nested VM the running kernel may not be
installed on the filesystem at the standard /boot/ or /usr/lib/modules/
paths.

Previously, this would cause vng to fail with "does not exist" since it
could not find the kernel image. Instead, this patch uses --dry-run to
detect if the kernel is available. If not, then we fall back to the
kernel in the kernel source tree. If that fails, then we die.

This way runners, like NIPA, can use vng --run arch/x86/boot/bzImage to
setup an outer VM, and vmtest.sh will still do the right thing setting
up the inner VM.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 86e338886b33..7247ac99cf33 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -441,6 +441,12 @@ vm_start() {
 
 	if [[ "${BUILD}" -eq 1 ]]; then
 		kernel_opt="${KERNEL_CHECKOUT}"
+	elif vng --run --dry-run &>/dev/null; then
+		kernel_opt=""
+	elif vng --run "${KERNEL_CHECKOUT}" --dry-run &>/dev/null; then
+		kernel_opt="${KERNEL_CHECKOUT}"
+	else
+		die "No suitable kernel found"
 	fi
 
 	if [[ "${ns}" != "init_ns" ]]; then

---
base-commit: 8f921f61005450589c0bc1a941a5ddde21d9aed9
change-id: 20260313-vsock-vmtest-autodetect-kernel-dd695ed3a710

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


