Return-Path: <netdev+bounces-252095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDJEO2FQcWkvCAAAu9opvQ
	(envelope-from <netdev+bounces-252095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:17:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEE25EA6F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52CF05C30C0
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8380144CF3F;
	Wed, 21 Jan 2026 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ac6xwi25"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5011410D0E
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033536; cv=none; b=RzDMNzy81MlF4lB6zB7AEnYseCisN4kzfHO6KrleJmT0I+0VAOYG5CT+72zavJ1d+qFKZ17QFBgIkPCG7H7iDdhuzpDzto00a962tCUCTXz+u/yBrsKBVFnz4rSty4np4om9Okxli0NXAtdAp3iRDbs4rnpSrZQdS+ydV+tjemg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033536; c=relaxed/simple;
	bh=Uqeotcna4sKhnpsKpqu9ZIU7Rje31wAi6t7AlhVdLKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CbDF1yMJq2n22ELd2xTkfMzCXjAelO5WCgXXoCTareZ5CDKnoHctocJ4p6Y3nVBGeRTosOKhrJLXlVLWUXRheX5I5U3ydGVsvWKEqlohKMhiv2PT5Xk6E1uVMQ4pOosTwtZ0dOTcQ+NGUAK+yn/PhXaUd9dAdrrQltUiB7Z7iJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ac6xwi25; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79419542b12so2167237b3.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 14:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769033525; x=1769638325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUBBU245D9tnMf9A+ObhwqUmHTyrgT+5VJLzKaof8o4=;
        b=ac6xwi25Y8Wq776eJFc2RatKWt5zUDZ8UQLbtrqJJEmnxuq1B7TcvHdRc5XKylq+px
         0bTYmaMcTCuje1cog0N4/smSuX80+iQ5O2+JSfSQrEx3ywQUxf0RW1BydYtla/Yh3jd6
         dqxZYBZgPz7EBGH/npCeBteSUymHeqv5A14FcIvl/RCNhBfon4f1KF7H6VVqQLVrz4l8
         HOFRWqptsKonbICt248uahT2ap/Rj1aGhkNpv5NvAPqIqn8uOetowbg3eW6TaMBOqm1c
         PZwXY1KfICxR0m7+qtFD08TrBQZ6Lz2MrA441ADNoJsGN2AvwxEzFDQwnT73CqJxDECt
         paaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033525; x=1769638325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dUBBU245D9tnMf9A+ObhwqUmHTyrgT+5VJLzKaof8o4=;
        b=LFkdmZrDY1iKbxCNblBu4l6Sd4D9WyYPljvbsvO/1WuqHA552GMXEA4HbHAUdnrxCV
         /crDjAXk+/t1PoDO6d4/nJcJlKJs4noG1/rApFQ+8VcxY82LKX+DvACqX5LsUiHCuV+k
         i7G9mdGaJIAbV+Hup4kqYtppe9y7xZDynYtrLAPbcuLK2OHeUg3RP7469zmThLfRHsKn
         +XHNdBF9KYT5WfMObPfXfot2yVqpKa4WPJnKGPncn99LZMuaI1meOjb+mOuP9OgInv3K
         eCXuhZjAowsMNUOo07sp1voUQcZxKtSoIG9PRS0FR/cLDo4O4dKyakzz/xUCW3kmlep2
         8PgA==
X-Forwarded-Encrypted: i=1; AJvYcCUdUsXwYIfFLi/TyHeqL0dnfyE1wzgzyJ5C1HQDtzyhM6uRGWtkVHsHxWWonOg/pukFTR67kIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm19tpW3wFulrIcnelWWejE/bCrBSjnE5EwVXFc2Qbrg03sSeY
	UrZLZEVQcBrLi7YHVEEDQokJxIzIzLFpjjX6IIChuKyzGgOBWvV6sCfH
X-Gm-Gg: AZuq6aJ7EID4zcyBtj6BBN9DCGVrb6DscWUasvdqOn0z0CwOlTZUe0C0ZICAg+MAiNb
	OWvpH8vRS+qEYZeqjhemynO8bfc7qcPErxiXDlF3uuAodxAgaGl/8mD/Pw1ChlW7idwBOnfYFRk
	QneUrOoHTEyt08kdEN3vu3kgko2YKi23ssPIUmal+ZS5bx84LZjNtLkmqOjKp+B+S69/H9dtp0s
	fnaaxKDEk7SJZO9F3h1ZwPoL/63Yd5SOVl9mdoaVLwhT7GdT9+rGRO7C1gXNJTLLvBhuN/GFmcG
	qxLwR6N8ZMpe3nyDDjoMysmnFNIyYe1IHjUMNQc2x2h5ilV6H82F3nuez1t4wpXUuXGARv0PSmA
	gi+oUK+zXSNGUm7BvxhbhS4kuuDfgpEd2uUD1/Tq/qSM0Su4xlRORgpwm1QxHJcNz+4yc1YAVMM
	eqT0Sb7tsKOtd/k6ZqeHNk
X-Received: by 2002:a05:690c:d1b:b0:786:6179:1a47 with SMTP id 00721157ae682-793c6803c15mr130911767b3.44.1769033525375;
        Wed, 21 Jan 2026 14:12:05 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66c729fsm71255977b3.12.2026.01.21.14.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:12:04 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 21 Jan 2026 14:11:47 -0800
Subject: [PATCH net-next v16 07/12] selftests/vsock: add
 vm_dmesg_{warn,oops}_count() helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-vsock-vmtest-v16-7-2859a7512097@meta.com>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
In-Reply-To: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,sargun.me,gmail.com,meta.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252095-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DBEE25EA6F
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

These functions are reused by the VM tests to collect and compare dmesg
warnings and oops counts. The future VM-specific tests use them heavily.
This patches relies on vm_ssh() already supporting namespaces.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- break these out into an earlier patch so that they can be used
  directly in new patches (instead of causing churn by adding this
  later)
---
 tools/testing/selftests/vsock/vmtest.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index c4d73dd0a4cf..4b5929ffc9eb 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -380,6 +380,17 @@ host_wait_for_listener() {
 	fi
 }
 
+vm_dmesg_oops_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg 2>/dev/null | grep -c -i 'Oops'
+}
+
+vm_dmesg_warn_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg --level=warn 2>/dev/null | grep -c -i 'vsock'
+}
 
 vm_vsock_test() {
 	local ns=$1
@@ -587,8 +598,8 @@ run_shared_vm_test() {
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
 	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
-	vm_oops_cnt_before=$(vm_ssh "init_ns" -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh "init_ns" -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_oops_cnt_before=$(vm_dmesg_oops_count "init_ns")
+	vm_warn_cnt_before=$(vm_dmesg_warn_count "init_ns")
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -606,13 +617,13 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_oops_cnt_after=$(vm_ssh "init_ns" -- dmesg | grep -i 'Oops' | wc -l)
+	vm_oops_cnt_after=$(vm_dmesg_oops_count "init_ns")
 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
 		echo "FAIL: kernel oops detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh "init_ns" -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_warn_cnt_after=$(vm_dmesg_warn_count "init_ns")
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL

-- 
2.47.3


