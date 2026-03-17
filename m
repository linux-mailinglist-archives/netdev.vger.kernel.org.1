Return-Path: <netdev+bounces-268754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDuQFVvRuWnMOAIAu9opvQ
	(envelope-from <netdev+bounces-268754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:10:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0262B2F62
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94E5B30403B4
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1098B370D51;
	Tue, 17 Mar 2026 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThwnO0+Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA6C3630A2
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773785387; cv=none; b=lyemyLb5tQrunS5WJmuX3c9dGZJ9f197cHjZKjIa35f5sTDAdzX4KDjBNRkWsRrsySqJIrY6pMAYZEoA2d8O7e2IarmI2AOjtx/FYrN+h7vSbesAcn5fce5zAbts0b2jk9cv8HH4NFu3oJEkQfc2PClFpZ0s2BbIyRyD6at+HpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773785387; c=relaxed/simple;
	bh=b+CHW6D+Tes3tWuDt2z0es3oTuQs3Fq7ETrR7tgvf/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y6UUowqdf27EHVueNO0g2OD+A7US+OI/Gd7o23FeQd+wsQgG0GbOwxJQBPh4JAdbX3zBilul/WKrJD7BfgGo7LNCrspRZnQNsXliyS9vL+1dimvVrtJM85FeVhf3lHDG0cyOII0z6CsMD8JCr+cZkA79XWaPLivb0UosejtWvJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThwnO0+Q; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-794719afcd4so57582777b3.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 15:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773785384; x=1774390184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpW8gynkMYuHb0nRn7cLLL0m7fiOcOBnsG4vYKWVvhU=;
        b=ThwnO0+Q1lO3HCL59UulCoQuYvAvR5chFdDDMd+m7rkQZhVRwD5SukQIbvaZLssAkw
         tbnS7h/k7WqDSq5cNv43Cm/JFZfmRjizxMYSIQpIRgBU99RQVX0q7v8+Vzc9S5WiYej+
         oXeV/p83OZ6D5+x1o2ONH32ZS5Ng3F8ABVF5aa8XCHY8agqs1AFKrd2YaGsKhDLSAhUd
         wBwBosrR/uD2Z9VlUkYy9OEM8AbXbQfPIGbm27dVO6EUWhAHcsr7p2wyzuO7EOaUorF9
         o4DyiKHxjz//2ivg0S2OUOeYlLzWsw/yvv5QEOnzvODt/nEilZHG7AFDwKBA31uoPzwI
         WHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773785384; x=1774390184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vpW8gynkMYuHb0nRn7cLLL0m7fiOcOBnsG4vYKWVvhU=;
        b=htRcKNwwJp4xw7BHeTyaWpAdQUZFkKwRnnQy2/q3HS0Ju2A1IWERvI0rw1TePlGuSn
         B6lOcYZeWPykeyU1vMPQPzcSMD9gKRX9v+YRY+1vUFr2LisDC7xUGGF+virw1XSk59RU
         uMnT5u4yhrGyjelUiFNvcf4KOYyG/2XnhE7ocAN72tUBK3O5fgOIE09shPDcXd2vz4l2
         EJ7GIxmhtmV6PsP3/bWIP2HBlx1NT0wc5zft0cQgifYZsZ2bboD3GXlWcqa5462Krl/c
         YjNbrybDw08kYf7ZziXoyHQ7CFKC443tMDFSikZlK1W/G+wjLETRhWD3JELB9umOIg3m
         iiEg==
X-Forwarded-Encrypted: i=1; AJvYcCUdAy69LNA3TDVdEBpftBICRcwHe/qOZjYO7uQZh6Dtb3gBvh3HxTx8g6C6a2/qvbuIDmV9Z+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUdyJ/jQBgxuAOa+LfarIoO9D+OyFu/xu021HKrJMePNLts09e
	ub+IFY87rwGUahFERyQavLOvKEvSIumISrQOmqArrLtPOUrMXjYKcYxA
X-Gm-Gg: ATEYQzwQvmBIHIo+rI07vQDG/zEeOhc9/EhN7uQYA++zDRT3A1EhWG9BJDvF8o+UrL3
	rTk0XqnNIoRDeEN48AVhhx8sx+57e9NhW+cK0+3LvexXeGaLQRRN70aWC73/AkTKEabKwkuP2ex
	FLlZU1OOOL0odsWk7eEz9DKuEehjScX2YokRFHU78qK/thocuOmWVwkVjF5X7ETP7+m3Jch6Tl0
	xE2Qq1H6t/0pOkp6QP7BP8V8mUkeE4g6C87bVQtk4a4g3ShGI7RUSFxxK7pSUjcsF2H+ZsjEhYK
	3KBCIdWPiAOmwmGQIigqm5TMFSB73s9BZHxsK9bFeGONB5dBCuhOtJoX5jXXcuwnHuItiO6Ukad
	Y2piPf0Y9dUl6uPgmKSfoaLzJupczsRY+IHm7X++WMNVjl2T9Hto6HbqMJ+9v7a2HiQQ/bzjzp8
	zHc7Tiyw2ImXMHp3pvHT2wSg==
X-Received: by 2002:a05:690c:c50d:b0:79a:5164:bb08 with SMTP id 00721157ae682-79a7181bd39mr11782367b3.8.1773785384400;
        Tue, 17 Mar 2026 15:09:44 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a713f31b8sm6186507b3.18.2026.03.17.15.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 15:09:44 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 17 Mar 2026 15:09:35 -0700
Subject: [PATCH net-next v2 1/2] selftests/vsock: fix vmtest.sh for
 read-only nested VM runners
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-vsock-vmtest-nested-fixes-v2-1-0b3f53b80a0f@meta.com>
References: <20260317-vsock-vmtest-nested-fixes-v2-0-0b3f53b80a0f@meta.com>
In-Reply-To: <20260317-vsock-vmtest-nested-fixes-v2-0-0b3f53b80a0f@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268754-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,meta.com:email,meta.com:mid]
X-Rspamd-Queue-Id: 5B0262B2F62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bobby Eshleman <bobbyeshleman@meta.com>

When running vmtest.sh inside a nested VM, there occurs a problem
with stacking two sets of virtiofs/overlay layers (the first set from
the outer VM and the second set from the inner VM). The virtme init
scripts (sshd, udhcpd, etc...) fail to execute basic programs (e.g.,
/bin/cat) and load library dependencies (e.g., libpam) due to ESTALE.
This only occurs when both layers (outer and inner) use virtiofs. Work
around this by using 9p in the inner VM via --force-9p.

Additionally, when the outer VM is read-only, the inner VM's attempt at
populating SSH keys to the root filesystem fails:

virtme-ng-init: mkdir: cannot create directory '/root/.cache': Read-only file system

Work around this by creating a temporary home directory with generated
SSH keys and passing it through to the guest as /root via --rwdir.
Disable strict host key checking in vm_ssh() since the VM will be seen
as a new host each run.

The --rw arg had to be removed to prevent a vng complaint about overlay
(in combination with the other parameters). The guest doesn't really
need write access anyway, so this was probably overly permissive to
begin with.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 86e338886b33..a4b56322ce9b 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -42,6 +42,8 @@ readonly KERNEL_CMDLINE="\
 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
 "
 readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
+readonly TEST_HOME="$(mktemp -d /tmp/vmtest_home_XXXX)"
+readonly SSH_KEY_PATH="${TEST_HOME}"/.ssh/id_ed25519
 
 # Namespace tests must use the ns_ prefix. This is checked in check_netns() and
 # is used to determine if a test needs namespace setup before test execution.
@@ -257,7 +259,12 @@ vm_ssh() {
 
 	shift
 
-	${ns_exec} ssh -q -o UserKnownHostsFile=/dev/null -p "${SSH_HOST_PORT}" localhost "$@"
+	${ns_exec} ssh -q \
+		-i "${SSH_KEY_PATH}" \
+		-o UserKnownHostsFile=/dev/null \
+		-o StrictHostKeyChecking=no \
+		-p "${SSH_HOST_PORT}" \
+		localhost "$@"
 
 	return $?
 }
@@ -265,6 +272,7 @@ vm_ssh() {
 cleanup() {
 	terminate_pidfiles "${!PIDFILES[@]}"
 	del_namespaces
+	rm -rf "${TEST_HOME}"
 }
 
 check_args() {
@@ -382,6 +390,11 @@ handle_build() {
 	popd &>/dev/null
 }
 
+setup_home() {
+	mkdir -p "$(dirname "${SSH_KEY_PATH}")"
+	ssh-keygen -t ed25519 -f "${SSH_KEY_PATH}" -N "" -q
+}
+
 create_pidfile() {
 	local pidfile
 
@@ -451,11 +464,14 @@ vm_start() {
 		--run \
 		${kernel_opt} \
 		${verbose_opt} \
+		--rwdir=/root="${TEST_HOME}" \
+		--force-9p \
+		--cwd /root \
 		--qemu-opts="${qemu_opts}" \
 		--qemu="${qemu}" \
 		--user root \
 		--append "${KERNEL_CMDLINE}" \
-		--rw  &> ${logfile} &
+		&> ${logfile} &
 
 	timeout "${WAIT_QEMU}" \
 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
@@ -1532,6 +1548,7 @@ check_deps
 check_vng
 check_socat
 handle_build
+setup_home
 
 echo "1..${#ARGS[@]}"
 

-- 
2.52.0


