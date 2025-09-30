Return-Path: <netdev+bounces-227298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FF2BAC142
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 10:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C102320B39
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 08:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CA727A468;
	Tue, 30 Sep 2025 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgIjzV4c"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AA124501B
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221486; cv=none; b=e6p7jYTabIkICzYKhbKR/2a0yuMGzBTai9GuBShaxYXsl4igGEMf2dhLhl8mkoMvq43YkcHOgbHfKxh3Y57C6zktFmu63yNiyB+QQy3QkUpe4zUGG2QwDaCRCChhfGDE8Z7G2VaMd8jhStqeFhFuXIp/ZzLIFzsTjy4M8LM/oM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221486; c=relaxed/simple;
	bh=xnpiQCURkOhfQrdwgPHiUaP8a9tkI+p9FQwCHjcwcds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjEvHQixPc0nqgwxfTHvZ8TbxKQLG72hQChk46XnWzybcflxhi1BjHGfc4xScEBVmQOuEOtzdPAN1pzIfh0cyCoqcj3gPtPZ/veUBzXgVNWtA/g28pKytRFE/EF6oDE1ZnFBTAzq1IHT3W6E0foCbm4VbwoaC7ABYUeHGISgpGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SgIjzV4c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759221483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VccAC6xB6U34Xf9cLOXrFM7PAx88aOBuUi8cY9wyl/8=;
	b=SgIjzV4c09zNmsgfZdbvvbhMIu75o+2m6kCuIc+TKbaH0+dBJ0gGwPh7h1s47SEXLjpELW
	VPuf5Od1Q2e+GmGuINcBz8NroVgU5clSSuC1A8//DFjsBovBhSFIV/lQNDz7Lq2CMZ0iHP
	tkiDGpTpXbArt/WGo6D0FH2ki1T43zw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-rVkimHIgMiyBwqhr8guzBQ-1; Tue, 30 Sep 2025 04:38:01 -0400
X-MC-Unique: rVkimHIgMiyBwqhr8guzBQ-1
X-Mimecast-MFC-AGG-ID: rVkimHIgMiyBwqhr8guzBQ_1759221480
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e41c32209so23232185e9.0
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759221480; x=1759826280;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VccAC6xB6U34Xf9cLOXrFM7PAx88aOBuUi8cY9wyl/8=;
        b=qy5HnxA0wWYagjfj3naBJnzilsJmqzVc6mMs+Ge93UhRvSNSuTQbuD2PHtTd9s3Y7Y
         WBZ9pecVfVz5wpEuo+wViaau8naOHtCboyjwxSjpzNPC7jYf+19IzwoA4NRPIwCYL0wQ
         ML2LdqXh4TZMfj44hmrbBuqVvU1pKkRUd6cW5rDUCpHGhk8ujwBJ9Xvkj9Gp/jwDlhcy
         GQSAFSv3DdnTwNcMvwD1/v+Bnr524wpR5SxECGpVRvvHtwX4D/EP+oFlzVcwfm4j/WvL
         ZREpE9TdIQJwdp71eBzOPk+po6nsJzR46NL+fJm+Fv0MqP7naAsCayDf5FspgCFFxnYz
         6DIA==
X-Forwarded-Encrypted: i=1; AJvYcCWbSPNwBw1mO0Q698zNie72THHR5NpWwr5aL5bswrsh0BboA/qac4apZCeCb+vEgjJhmUfTEZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySwCA6HD2rU9ykQMpkRYfcVyPDeXHXtG+PzlS+nHmkpiCIQ8cs
	LnwwDOjxAeEgRg0a7cvurMSllbZChKtRqhASx+MX2Ho39bbaFiBBDlaRttWhpLH1zbe0yv34T+0
	f2Bx9fmbHOW9jEoMjR5Zyc6oyQ0ES28tfAPNstec9vUJqm/zTnes+qaBFEQ==
X-Gm-Gg: ASbGnctopzAlZpcZOtJBHw/98PWOKXCkqVE/2HbMZaTnEPEGYL18yfUa1SjPBbFGqvs
	mFXqsxkNS0Sg+QXxn/kjzcFrbB1sm0K9/cuPL07vmzgoDo4tupBQExQ8EpjOBObF+oayTrXZmKV
	uptuFvc8O1XcbWxqXiWhKiwSmxCvTTzAs9FublfuQHjeE/AolKvEqCa1mEi9swWIelZNl2fauOZ
	t8CFQVxT9U05bnQxvnGXFauAglfPEkL1nWfInLVUq3uj7O5kTH2FnMafXT9DHJIlj9pZcsE9hKJ
	eLfmravqlA+sye1paZULHynTqjzuRkOsKJ3PWT9GSxPQodi9AgRpU88IJe9sYazoiFu9qpFGKZc
	qB1mcH2sAc0NeTepReV8Vpg==
X-Received: by 2002:a05:600c:1f86:b0:46e:3d41:5fed with SMTP id 5b1f17b1804b1-46e5da8bd67mr7433085e9.11.1759221479623;
        Tue, 30 Sep 2025 01:37:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO1GaSyS8oGmkfg/b3GKSfbgVAIueIpwgEMFL2DPKaUi87iq81o8rzQl9AgYDOFKU8/6wPPw==
X-Received: by 2002:a05:600c:1f86:b0:46e:3d41:5fed with SMTP id 5b1f17b1804b1-46e5da8bd67mr7432535e9.11.1759221479106;
        Tue, 30 Sep 2025 01:37:59 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b577c87sm10285805e9.0.2025.09.30.01.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 01:37:58 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:37:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 8/9] selftests/vsock: invoke vsock_test
 through helpers
Message-ID: <2a2qhhyui2by6cw3nqepwgfxxrknyjx5rgaybt4dvqowflom2r@i55r2csxbmb4>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
 <20250916-vsock-vmtest-v6-8-064d2eb0c89d@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916-vsock-vmtest-v6-8-064d2eb0c89d@meta.com>

On Tue, Sep 16, 2025 at 04:43:52PM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add helper calls vm_vsock_test() and host_vsock_test() to invoke the
>vsock_test binary. This encapsulates several items of repeat logic, such
>as waiting for the server to reach listening state and
>enabling/disabling the bash option pipefail to avoid pipe-style logging
>from hiding failures.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 120 ++++++++++++++++++++++++++++----
> 1 file changed, 108 insertions(+), 12 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 183647a86c8a..5e36d1068f6f 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -248,6 +248,7 @@ wait_for_listener()
> 	local port=$1
> 	local interval=$2
> 	local max_intervals=$3
>+	local old_pipefail
> 	local protocol=tcp
> 	local pattern
> 	local i
>@@ -256,6 +257,13 @@ wait_for_listener()
>
> 	# for tcp protocol additionally check the socket state
> 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
>+
>+	# 'grep -q' exits on match, sending SIGPIPE to 'awk', which exits with
>+	# an error, causing the if-condition to fail when pipefail is set.
>+	# Instead, temporarily disable pipefail and restore it later.
>+	old_pipefail=$(set -o | awk '/^pipefail[[:space:]]+(on|off)$/{print $2}')
>+	set +o pipefail
>+
> 	for i in $(seq "${max_intervals}"); do
> 		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
> 		   grep -q "${pattern}"; then
>@@ -263,6 +271,10 @@ wait_for_listener()
> 		fi
> 		sleep "${interval}"
> 	done
>+
>+	if [[ "${old_pipefail}" == on ]]; then
>+		set -o pipefail
>+	fi
> }
>
> vm_wait_for_listener() {
>@@ -314,28 +326,112 @@ log_guest() {
> 	LOG_PREFIX=guest log $@
> }
>
>+vm_vsock_test() {
>+	local ns=$1
>+	local mode=$2
>+	local rc
>+
>+	set -o pipefail
>+	if [[ "${mode}" == client ]]; then
>+		local host=$3

I don't really like having the number and type of parameters of a 
function depend on others, maintaining it could become a mess.

Can we avoid “mode” altogether and use “host” to discriminate between 
server and client?

e.g. if “host” == server then we launch the server, otherwise we 
interpret it as IP, or something else.

>+		local cid=$4
>+		local port=$5
>+
>+		# log output and use pipefail to respect vsock_test errors
>+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
>+			--mode=client \
>+			--control-host="${host}" \
>+			--peer-cid="${cid}" \
>+			--control-port="${port}" \
>+			2>&1 | log_guest
>+		rc=$?
>+	else
>+		local cid=$3
>+		local port=$4
>+
>+		# log output and use pipefail to respect vsock_test errors
>+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
>+			--mode=server \
>+			--peer-cid="${cid}" \
>+			--control-port="${port}" \
>+			2>&1 | log_guest &
>+		rc=$?
>+
>+		if [[ $rc -ne 0 ]]; then
>+			set +o pipefail
>+			return $rc
>+		fi
>+
>+		vm_wait_for_listener "${ns}" "${port}"
>+		rc=$?
>+	fi
>+	set +o pipefail
>+
>+	return $rc
> }
>
>+host_vsock_test() {
>+	local ns=$1
>+	local mode=$2
>+	local cmd
>+
>+	if [[ "${ns}" == none ]]; then
>+		cmd="${VSOCK_TEST}"
>+	else
>+		cmd="ip netns exec ${ns} ${VSOCK_TEST}"
>+	fi
>+
>+	# log output and use pipefail to respect vsock_test errors
>+	set -o pipefail
>+	if [[ "${mode}" == client ]]; then
>+		local host=$3

Ditto.

The rest LGTM.

Thanks,
Stefano

>+		local cid=$4
>+		local port=$5
>+
>+		${cmd} \
>+			--mode="${mode}" \
>+			--peer-cid="${cid}" \
>+			--control-host="${host}" \
>+			--control-port="${port}" 2>&1 | log_host
>+		rc=$?
>+	else
>+		local cid=$3
>+		local port=$4
>+
>+		${cmd} \
>+			--mode="${mode}" \
>+			--peer-cid="${cid}" \
>+			--control-port="${port}" 2>&1 | log_host &
>+		rc=$?
>+
>+		if [[ $rc -ne 0 ]]; then
>+			return $rc
>+		fi
>+
>+		host_wait_for_listener "${ns}" "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
>+		rc=$?
>+	fi
>+	set +o pipefail
>
>+	return $rc
> }
>
> test_vm_server_host_client() {
>+	vm_vsock_test "none" "server" 2 "${TEST_GUEST_PORT}"
>+	host_vsock_test "none" "client" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
>+}
>
>-	vm_ssh -- "${VSOCK_TEST}" \
>-		--mode=server \
>-		--control-port="${TEST_GUEST_PORT}" \
>-		--peer-cid=2 \
>-		2>&1 | log_guest &
>+test_vm_client_host_server() {
>+	host_vsock_test "none" "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"
>+	vm_vsock_test "none" "client" "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"
>+}
>
>-	vm_wait_for_listener "${TEST_GUEST_PORT}"
>+test_vm_loopback() {
>+	vm_vsock_test "none" "server" 1 "${TEST_HOST_PORT_LISTENER}"
>+	vm_vsock_test "none" "client" "127.0.0.1" 1 "${TEST_HOST_PORT_LISTENER}"
>+}
>
>-	${VSOCK_TEST} \
>-		--mode=client \
>-		--control-host=127.0.0.1 \
>-		--peer-cid="${VSOCK_CID}" \
>-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
>
>-	return $?
> }
>
> test_vm_client_host_server() {
>
>-- 
>2.47.3
>


