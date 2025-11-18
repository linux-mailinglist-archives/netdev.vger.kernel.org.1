Return-Path: <netdev+bounces-239662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B23C6B26A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 0D48F20816
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB0935FF66;
	Tue, 18 Nov 2025 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="huXi8Wts";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FoIB6mbt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8D4326D74
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489666; cv=none; b=IzKPfUKURJX6DfhQt2V2McHCdmv1Jb2vxIK1UYb7N0j0/oNgUVdRO5AYNUV5PqqhOjOj5vIV1gGf2PVi8yoF8vadIOTe9NvderBmwiixy9E2RJBAomMf+IIp/5+hvPwpf99Id4EEhmJsa8KY4a+IyPgydvAlOPKcdjjKYs3gEQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489666; c=relaxed/simple;
	bh=93pZ6dl5lFQD43TapInbMA0s7FqryaSyeA9SjB2/Swk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP6nI/3JgrboOsr1xgh6WITDMuib58I8G+NJoMQUc8dfn8hYpbvlU5g6ywDqrhN4slij6PKdAMQ1z0welfGOsgPJZa+mdVGz4sD4vLQA0iRxGpg6k9/f06z6JjDpp3XeAkg2nj5d3Lx0CJRnZ6EUHAwmvvwYGbAmXShW9icA14s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=huXi8Wts; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FoIB6mbt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ogfCDQuwBr308yi4xavgkU0Sq9YiKn4sM5QwPOHCZ7A=;
	b=huXi8Wtsrh+41DIudf91wF23OvyTCTf6YPisGUXzMZ2drpgDkIzuvLtuknNsfVgVE05Zn9
	m9lLgpnF1DoGDtCBcj4vlL/mPFLKrSSnKdiBMpBq4J2u3fPCnD1P0jCLJKF4CfuJwKsC6b
	xzIEDstm4iiaFQLgDP3DdtFJuA6rosU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-eqY2UbL0NnyP8A-f5_b95g-1; Tue, 18 Nov 2025 13:14:21 -0500
X-MC-Unique: eqY2UbL0NnyP8A-f5_b95g-1
X-Mimecast-MFC-AGG-ID: eqY2UbL0NnyP8A-f5_b95g_1763489660
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429c5f1e9faso4712880f8f.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763489660; x=1764094460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ogfCDQuwBr308yi4xavgkU0Sq9YiKn4sM5QwPOHCZ7A=;
        b=FoIB6mbteb+Uo4T86irp/XzAl6AecdpoiX1D0DT6C3PRR71pDf/bnDxApUzfFSOtIt
         qq4r6VZwppZc2lahK+/F+IPRXCPfu/74Mbxv9dimzrI2PagLTlVw5DGveCMppD1U3DjV
         ziyEC8UTUUYUhs98KFd8xI56blKiIyDJUR8fk2kzm5ZVJZ7Dl9bM4mkJOE26AG/oXjO1
         MNM1o8q2G9KX85fRdGMpVQO3jort4EGrWpWkCbHWVSq3F4cc4NoHqHDhlNdBAJTCkCyF
         FZkZ4fqXExrsJPERHtiMld5kc9VtCqMYu3CswKL8xEFfgahzbZ0hDRQfSCGHgOuQakgp
         1FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489660; x=1764094460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogfCDQuwBr308yi4xavgkU0Sq9YiKn4sM5QwPOHCZ7A=;
        b=xLVD5yYlhrmaGPUZBd2W8kTT8eaee4sQ2Bigac+SPlzRgWyUNv4f5j8MuIuMBT7usK
         8z6dNT/AiTLocb9cRoCIWSVlhlH15WkKAwh8rKUB386Vcn7P0Yxod9dELkKQPSg+/ryU
         gxEyB/lFA1G9p+LSjjuTDJW2Y2XbxIMUUqwH6T2LJuUaX3EV8oONlhUuaZYHvCbXnObg
         YrYsdrcXQiF8o9l089GVHjV/NI16xfqWXgzrcdDBDw8mElo3AHN4KKYT4IN/X+tsWGgq
         G9byZlHpf+4sUnseUhFAxAzYyPkmM4nJR3Upl+l7LQuyNm2xsFhrZtlFrlqqSLgEnoI5
         smJg==
X-Forwarded-Encrypted: i=1; AJvYcCW/oWA4n5R3NxEk7JW/PuuuMw9ySnmb9jGYvWCL5Cqq8u3vMXrXT4MMmE0koDgW1PZzJ+yax9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Ye5cIyp6mnU7ad4LAMmMf6275v2fdlfnqqYjyOcrT+DaJb4E
	r0U1rFWtBv3rKqInWnD64A5cMHmZ99uQEQSE9MQpgCfFwLEdl4DbK8vm5m72Ze3feWnz0VAFOJ3
	JsqDsC2uX5OMsP5HFfCLRc8MYFr1rzaHdt/33/GN8Y0c7Z/6TEioKO+eNuQ==
X-Gm-Gg: ASbGnctpvvQvOMS2/8wx44PsCOFGqvWCCwOwASvjKNHJTeRTziGoPpduKvsEKq7kMcB
	/vReZBBrkaNxee8tXVE9nwTAahEKCeE7ENGcmLWzbXHvaikGgoPMA1J2u6/sPmqYmcKayNvyl9o
	2Mh9Wr1dcRaGGHrIZpBKK4aa4y5SfmTG9aZcQ+PTdyXHofTOmQR2mmoDY2fTe3LItDofexcOozd
	GxE1yS2SEN7y5QudAxC3YVUInikT9UO/UrtowwHL4X9/i1nCPx99Hir7k4TMaTr7XqOVFiMnYmz
	1QIIYtWCYpgS4U6IrjCSNrwdiXL6PPUPQYeTjEUkfbzoUbgtp/UzLwZYgiyw4rBGOXAS4dUzLLL
	X+Xd6BVk+kd92LwKv+/rPwdnZLF917DxXutgBnkRv2WesL8Pe0jXSSgCRIYk=
X-Received: by 2002:a05:6000:4210:b0:42b:3bd2:b2f8 with SMTP id ffacd0b85a97d-42b593849ffmr16260465f8f.46.1763489660371;
        Tue, 18 Nov 2025 10:14:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS8o+OnlcCO7Yj6XaGWOD+hRu7PmlcNwfKGvJu2ycvTutZuUYYNXih4+y5NlFSoF//9qYsmQ==
X-Received: by 2002:a05:6000:4210:b0:42b:3bd2:b2f8 with SMTP id ffacd0b85a97d-42b593849ffmr16260434f8f.46.1763489659913;
        Tue, 18 Nov 2025 10:14:19 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f19aa0sm33992549f8f.37.2025.11.18.10.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:14:19 -0800 (PST)
Date: Tue, 18 Nov 2025 19:14:10 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 09/11] selftests/vsock: add namespace tests
 for CID collisions
Message-ID: <iyn62b6uwxgoz5r3rk3huca3ehwvh6zv4rx37hliqrkh3bknkt@qfmfnrwdd3ks>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-9-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251117-vsock-vmtest-v10-9-df08f165bf3e@meta.com>

On Mon, Nov 17, 2025 at 06:00:32PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add tests to verify CID collision rules across different vsock namespace
>modes.
>
>1. Two VMs with the same CID cannot start in different global namespaces
>   (ns_global_same_cid_fails)
>2. Two VMs with the same CID can start in different local namespaces
>   (ns_local_same_cid_ok)
>3. VMs with the same CID can coexist when one is in a global namespace
>   and another is in a local namespace (ns_global_local_same_cid_ok and
>   ns_local_global_same_cid_ok)
>
>The tests ns_global_local_same_cid_ok and ns_local_global_same_cid_ok
>make sure that ordering does not matter.
>
>The tests use a shared helper function namespaces_can_boot_same_cid()
>that attempts to start two VMs with identical CIDs in the specified
>namespaces and verifies whether VM initialization failed or succeeded.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 73 +++++++++++++++++++++++++++++++++
> 1 file changed, 73 insertions(+)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 86483249f490..a8bf78a5075d 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -48,6 +48,10 @@ readonly TEST_NAMES=(
> 	ns_host_vsock_ns_mode_ok
> 	ns_host_vsock_ns_mode_write_once_ok
> 	ns_vm_local_mode_rejected
>+	ns_global_same_cid_fails
>+	ns_local_same_cid_ok
>+	ns_global_local_same_cid_ok
>+	ns_local_global_same_cid_ok
> )
> readonly TEST_DESCS=(
> 	# vm_server_host_client
>@@ -67,6 +71,17 @@ readonly TEST_DESCS=(
>
> 	# ns_vm_local_mode_rejected
> 	"Test that guest VM with G2H transport cannot set namespace mode to 'local'"
>+	# ns_global_same_cid_fails
>+	"Check QEMU fails to start two VMs with same CID in two different global namespaces."
>+
>+	# ns_local_same_cid_ok
>+	"Check QEMU successfully starts two VMs with same CID in two different local namespaces."
>+
>+	# ns_global_local_same_cid_ok
>+	"Check QEMU successfully starts one VM in a global ns and then another VM in a local ns with the same CID."
>+
>+	# ns_local_global_same_cid_ok
>+	"Check QEMU successfully starts one VM in a local ns and then another VM in a global ns with the same CID."
> )
>
> readonly USE_SHARED_VM=(
>@@ -553,6 +568,64 @@ test_ns_host_vsock_ns_mode_ok() {
> 	return "${KSFT_PASS}"
> }
>
>+namespaces_can_boot_same_cid() {
>+	local ns0=$1
>+	local ns1=$2
>+	local pidfile1 pidfile2
>+	local rc
>+
>+	pidfile1="$(create_pidfile)"
>+	vm_start "${pidfile1}" "${ns0}"

Should we check also this return value or return an AND of both?

>+
>+	pidfile2="$(create_pidfile)"
>+	vm_start "${pidfile2}" "${ns1}"
>+
>+	rc=$?
>+	terminate_pidfiles "${pidfile1}" "${pidfile2}"
>+
>+	return "${rc}"
>+}
>+
>+test_ns_global_same_cid_fails() {
>+	init_namespaces
>+
>+	if namespaces_can_boot_same_cid "global0" "global1"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_ns_local_global_same_cid_ok() {
>+	init_namespaces
>+
>+	if namespaces_can_boot_same_cid "local0" "global0"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_global_local_same_cid_ok() {
>+	init_namespaces
>+
>+	if namespaces_can_boot_same_cid "global0" "local0"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_local_same_cid_ok() {

IIUC the naming convention, should this be with _fails() suffix?

Thanks,
Stefano

>+	init_namespaces
>+
>+	if namespaces_can_boot_same_cid "local0" "local0"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
> test_ns_host_vsock_ns_mode_write_once_ok() {
> 	for mode in "${NS_MODES[@]}"; do
> 		local ns="${mode}0"
>
>-- 
>2.47.3
>


