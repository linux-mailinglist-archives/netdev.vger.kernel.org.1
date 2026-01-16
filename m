Return-Path: <netdev+bounces-250657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61962D38858
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 22:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66D4C3018835
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D130B309DAF;
	Fri, 16 Jan 2026 21:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Osn+NoiR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59712EDD57
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598951; cv=none; b=aJucFgdDBBvwefUWJ0L2sRudd/frQJoh83/K5J37TgEBrR99OazSlt9Gtm8zGT3FwEAhq2/giKQ6Y3LZC9o8So/MVxtPCk9+YOGhlCqAd7a1rx20gXOJxUFGfYExXVRNmyFbwbU2XM5RGH8oN1Mwichyo/oYFkuiim92iSaCSF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598951; c=relaxed/simple;
	bh=FRcd1avd4PB9PmO5dQgmUicVEjm2xp4QOwjVLS7lcRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cftSK3NVAyFdBJb2MoSXm6kzd8Cqcadm8eR5GeGQPjSxc6c19IjnyRYxbxTBkOH/lJz/fyNM3mvQJc5FLMfhAhURlMrYko1zqNVvwk3/7H11+2GMMwvAV8j6upQg745ZAxpj5WWCHog+gNM2F0h1/SeqvxgFJ6aaxI0QgPhYcsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Osn+NoiR; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78fb7704cb4so21846377b3.3
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 13:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598947; x=1769203747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I07oD5ozWqHJLvu76IbvCT33HoDsgDmgjc920I58eyc=;
        b=Osn+NoiRUJBgwuOv7pxlurjOBPbLXJUuE+lcy93gFLwXujgUYLZWhSR829JhVurRYi
         65SnBwiPcePiJ6/Q1GeCz3WyhdqZid6C0LpwAaBVs8cvBPIBPRVWCL06lr4JJrYdhlaN
         +Bmi196Hn1wxBgayhyEe/RFnhlfaks0dd3uq8cDCiHRQUlVGWaTb6HdvJ6JUU8BYyBlP
         aWotOM535PYs9+rDG3Ug/Y6Nf/RIXdWfZeHaSKJ4Iki9UF6PM/TWLfHGSLi3/GJEXQTi
         g5u9/eN1topAcLapSF1R0sEA26rFoFKgEyx2G9ThwN351Nuag8oZ75WAD28NBlAFqS0K
         e9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598947; x=1769203747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I07oD5ozWqHJLvu76IbvCT33HoDsgDmgjc920I58eyc=;
        b=pn22tQSXVvj5mfTmyzIVieJotB5hC8WcVePz3ORM7KBTxu94JQPJlqrNOsefirVvEG
         FLgazgeBzmzl7wehxYm1wRyyd3X5I8YrckRmyHo2rZ7vNZjF2xEtVFkkodaDbsEIcRXa
         /JcUPccvKC+t8h2HFvClyc/CnUuqOVsrtCf2x6upolwBTY7I6pnRPgFhz0FW/IPMEmxo
         RqNhZAFdR4u5/Ncc/OOfGynv0EWTJAJffY9HmKM3jHsQx8R3NE7bIVOIshDqky3QoRQK
         H8M7hnKE2aTbnWCZD+CuZ8yPSCzNePpylyRsIBTpRAEkpa+N062HKNG5xQke7rIjkcYc
         lfrg==
X-Forwarded-Encrypted: i=1; AJvYcCXI+z8ibuuI8RYnXDnJAAMZtPujMeFWxPTmgTOYqSbDlupGqJWwWr+nbcoPCGM9NptvQ8FaoYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLt7VaFySvElSd9tWBs7bvJxHmTrvFNaKhwuT55rnflrQ3QVrZ
	EfbmaaN4vNqORA1B5PyJELzenIGonRVTMtR2zUB9ftHZ7LXhj4uWFqoC
X-Gm-Gg: AY/fxX4/p14aMLz3YMAJuGzqREpxXTErdhDPEsk3t1hU8S4e4TaeRAIs8qhFa4NrzWT
	HDgG6u26fsWAxErA9taRnUTS2IIyaFAtLMlmjb/efMyeeDtNU1Gzs2uAxrhkoXDFsn/2qd+E2c2
	HG23roRd/Nmbr7wwlUvmbk9JB/O3CsXtUevCk8pzs9U2xaDgUS7SS9HSMzvhz1MCOD2ZLuMdeLY
	emx2OJ2l53Gea+YoBPmoAtb1GUwoF1TGMVRxSWgsQvcwNQKXm0bPOaUB/TT/q/ddNw/fspXladC
	+xNqms32ymIqX+wFtiibKpHwHPuLdndbGA4xYyGdoWVezzYw98XhIZQ9HfffYzGasS+bVycxdq2
	x9JHOZKev93/JM1lJ+oHgtDShOo5HflbDWsEshsQ/MiAmL0kB0hN1bS2/+37Pgo2qxHhXt0UV/X
	upIqqKGtGYYQ==
X-Received: by 2002:a05:690c:b15:b0:792:6c16:110c with SMTP id 00721157ae682-793c6878c95mr28874267b3.61.1768598947252;
        Fri, 16 Jan 2026 13:29:07 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66f3284sm13566387b3.17.2026.01.16.13.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:06 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 16 Jan 2026 13:28:45 -0800
Subject: [PATCH net-next v15 05/12] selftests/vsock: add namespace helpers
 to vmtest.sh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock-vmtest-v15-5-bbfd1a668548@meta.com>
References: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
In-Reply-To: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
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

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add functions for initializing namespaces with the different vsock NS
modes. Callers can use add_namespaces() and del_namespaces() to create
namespaces global0, global1, local0, and local1.

The add_namespaces() function initializes global0, local0, etc... with
their respective vsock NS mode by toggling child_ns_mode before creating
the namespace.

Remove namespaces upon exiting the program in cleanup(). This is
unlikely to be needed for a healthy run, but it is useful for tests that
are manually killed mid-test.

This patch is in preparation for later namespace tests.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v13:
- intialize namespaces to use the child_ns_mode mechanism
- remove setting modes from init_namespaces() function (this function
  only sets up the lo device now)
- remove ns_set_mode(ns) because ns_mode is no longer mutable
---
 tools/testing/selftests/vsock/vmtest.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index c7b270dd77a9..c2bdc293b94c 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -49,6 +49,7 @@ readonly TEST_DESCS=(
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly NS_MODES=("local" "global")
 
 VERBOSE=0
 
@@ -103,6 +104,36 @@ check_result() {
 	fi
 }
 
+add_namespaces() {
+	local orig_mode
+	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
+
+	for mode in "${NS_MODES[@]}"; do
+		echo "${mode}" > /proc/sys/net/vsock/child_ns_mode
+		ip netns add "${mode}0" 2>/dev/null
+		ip netns add "${mode}1" 2>/dev/null
+	done
+
+	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
+}
+
+init_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
+		# we need lo for qemu port forwarding
+		ip netns exec "${mode}0" ip link set dev lo up
+		ip netns exec "${mode}1" ip link set dev lo up
+	done
+}
+
+del_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
+		ip netns del "${mode}0" &>/dev/null
+		ip netns del "${mode}1" &>/dev/null
+		log_host "removed ns ${mode}0"
+		log_host "removed ns ${mode}1"
+	done
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -110,6 +141,7 @@ vm_ssh() {
 
 cleanup() {
 	terminate_pidfiles "${!PIDFILES[@]}"
+	del_namespaces
 }
 
 check_args() {

-- 
2.47.3


