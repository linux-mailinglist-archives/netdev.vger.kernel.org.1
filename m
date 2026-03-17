Return-Path: <netdev+bounces-268368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LFZFj2nuGkthAEAu9opvQ
	(envelope-from <netdev+bounces-268368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:58:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A122A263D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 769AD3055815
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21B5242D84;
	Tue, 17 Mar 2026 00:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUHyUdss"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1CC1ADC97
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 00:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773708995; cv=none; b=n/ZgN+uMRLXf0Z8gl/HYfyipiqgCFmpZv2mh1Ey4pI8gzgqYW9kz4RqZWS6unnbDFk9reH1/WHWCwTFp73pBNZvDG/bbrUadqiXcd68zWUUX2lOfV2L3mVvAME4lCgU4efq6I2TL85ZobWRShtHASTEdeBbO+0a9AE/cwk47CBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773708995; c=relaxed/simple;
	bh=E+Hkdk1Kp8RLA9oT2ob9i9NCZmTcydZQUzHPrJghpSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BppvJkk8nVqLknUC63FCZ36+Yd6ID+SQEFNxkajIUpqTKlgTTRYW1C50xpN94TOAS2vCLzNYX2oerKXHpe9isGy7VgU31rnF3WxewIPpB+e8XkIPKodIi6A8N1dOcD1GyhY3BqvyqT/REcbUc5yX7ClPTHoqFUrW46Ii+Sqn+K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUHyUdss; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a50948018so16254447b3.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 17:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773708992; x=1774313792; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gH1hPDl0XJ4BmlVqeBDzahDvtQK5lSZzA+ixw3hKdOo=;
        b=iUHyUdssOTkyWIq/FbZGRhiA1FtiqvmM0kA7kSB4tUaog5csC3pJp6VbggNyKcmo0L
         u9tKJylVYw8cz6CUQhX0FDvywN3pCKOGOiagtbKBSX3+15MMc8BWfVwbaYgi2qHzbEvl
         zacKKPlFD5yv13pLXYbUjEB2tw+mwKKTl3D11YxlfxX9jgwdZPFOvxt3539ZUGyQugz2
         NqA4TqPi0Wov3SujmVpCFK9WEEZHcfW7dLJnPjxByFGl5y1//eFhshDkFN9W096x6dsi
         H/vKeChON+AvkyhHO1OccfryCGg7cNmDWh7lf3J+QK/q56C2KqgafaT0kzCLAKGZtdN8
         5kSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773708992; x=1774313792;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gH1hPDl0XJ4BmlVqeBDzahDvtQK5lSZzA+ixw3hKdOo=;
        b=Tz7iyF+TpBoYa06OSMrgmu1pv1cqW1uDOxr9KeIHINTI3suSwFckQ7IwRhcRx9PUV+
         Yks5BewLNhOIb0z9PYBkOBqtsEbSJ1ldoueQ+Z87ucp+JmpPP1zs4AQT9Fzd6La7PVJo
         44hy9UANLHTfyPBz+gXVHi+3RDRcCPfZCgFsZ3vimB+rOkMGowsX37qYnea5dnoOvKiY
         rFAstoddjpcW1igm8/Xo5FxkuVxXRoXwI9Qw1Ahi5I1TFQY9BujHMLQdWBgBhszOdY/J
         EOi4HguwdeUcR0ESMWHgLE3wUs422nF4ZFfYHUSnIgGFhJ4xHpqUS6ZS0yv+XPC5E21Q
         WmhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnWALR3fsA3+ZvwbfOPH3NRugMMfDXvk1/wrRNFkZSnN+M4byuZ4be96yF63hJwSdYF0cYHQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLzSiB0ireQK/EIT1z72P9Sq8oCIh02LK2mYZeVA+umh6LRfES
	0IhYVwNspcV45/eievPU7jLeavveyrnYPhK5FGqlRPCqUMIFjL+hRC2G
X-Gm-Gg: ATEYQzxuNksj+UORPOgVRBQ8UxuHcAP5/DxU6cQF4c3219z3jm+UINZ6qR5QTgUXcBy
	0ClS8eNTzjaZJxxLu+68RSdjCGnhZQql/n9eJewREWoPv8hxcAXsSsbNTbx1kp7YDImI/GK+jqJ
	a+PezhzcFxWfgad1zMghjAgFek+clNtqTIsL5xNyTS/O+1sNOKE4A/z8jK2zguB0x7OV8hCU7xV
	BaomKJvDGH/HFiHmjY7ZZrEYDwbYgqlpbnlo3oiNiRxe8YBNq9MSiJUFzteKCRlbzYcgExLIf7H
	RP9zhX5HRvPk0KnO8A4WAXNa5LT5MeM/8dh5pCf33onOhtRblJrw0Jar1a+zhJ/CHptvOKPgUfi
	dm6MiAL4v4unU8HlzEnrrlG4GW6zWyRjiHVX+Oo2bU4ph80tvYBfbHs3h572BPegHES8A42gjAW
	pJqB0vRMi/8zo+Fvae6Ol5kQ==
X-Received: by 2002:a05:690c:6d83:b0:799:1f23:6e46 with SMTP id 00721157ae682-79a1c1888efmr154062187b3.33.1773708992420;
        Mon, 16 Mar 2026 17:56:32 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm94638557b3.10.2026.03.16.17.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:56:31 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Mar 2026 17:56:15 -0700
Subject: [PATCH net-next v2] selftests/vsock: auto-detect kernel for guest
 VMs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-vsock-vmtest-autodetect-kernel-v2-1-5eec7b4831f8@meta.com>
X-B4-Tracking: v=1; b=H4sIAK+muGkC/43NSwqDMBAA0KuEWTslH1TqqvcoLtJkrMGalGQaL
 OLdC56g67d4OxTKgQoMYodMNZSQIgxCNwLcbOOTMHgYBGipO2mUwVqSW7CuTIXRfjh5YnKMC+V
 IL/S+u7bkje2VhEbAO9MUtjO4QyTGSBvD2AiYQ+GUv+dc1en/JlWhwl62zrQP7/qJbiuxvbi0w
 ngcxw9OGLB41QAAAA==
X-Change-ID: 20260313-vsock-vmtest-autodetect-kernel-dd695ed3a710
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268368-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,meta.com:mid,vmtest.sh:url]
X-Rspamd-Queue-Id: B1A122A263D
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

Due to job control issues in vng, a workaround is used to prevent 'make
kselftest TARGETS=vsock' from hanging until test timeout. A PR has been
placed upstream to solve the issue in vng:

https://github.com/arighi/virtme-ng/pull/453

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- add setsid workaround for make kselftest TARGETS=vsock
- Link to v1: https://lore.kernel.org/r/20260313-vsock-vmtest-autodetect-kernel-v1-1-705c35bdc7fe@meta.com
---
 tools/testing/selftests/vsock/vmtest.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 86e338886b33..9eacb753238a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -415,6 +415,19 @@ terminate_pids() {
 	done
 }
 
+vng_dry_run() {
+	# WORKAROUND: use setsid to work around a virtme-ng bug where vng hangs
+	# when called from a background process group (e.g., under make
+	# kselftest). vng save/restores terminal settings using tcsetattr(),
+	# which is not allowed for background process groups because the
+	# controlling terminal is owned by the foreground process group. vng is
+	# stopped with SIGTTOU and hangs until kselftest's timer expires.
+	# setsid works around this by launching vng in a new session that has
+	# no controlling terminal, so tcsetattr() succeeds.
+
+	setsid -w vng --run "$@" --dry-run &>/dev/null
+}
+
 vm_start() {
 	local pidfile=$1
 	local ns=$2
@@ -441,6 +454,12 @@ vm_start() {
 
 	if [[ "${BUILD}" -eq 1 ]]; then
 		kernel_opt="${KERNEL_CHECKOUT}"
+	elif vng_dry_run; then
+		kernel_opt=""
+	elif vng_dry_run "${KERNEL_CHECKOUT}"; then
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


