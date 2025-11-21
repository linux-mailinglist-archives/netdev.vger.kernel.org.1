Return-Path: <netdev+bounces-240785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 447E1C7A5D5
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 338112F52A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4307E287508;
	Fri, 21 Nov 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yo1QhP+3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRtP+FRY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED3F28F948
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736540; cv=none; b=LpS8102x/j/dXYxbveyJhMMY8M8OPVB/oVrj2Jsv/mNEQLkczHCokN/weoXbu3jA4kYD07FQZJlu/UOo5gdQA+8y13He094oCFB8GQnamFNUbyQCadnUYJ8vVYnowY6iws4NC0uYDf1+xVZb+tt15WsrPj/tsz1lKedJ1i3/K9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736540; c=relaxed/simple;
	bh=9ksRgIEpFArrDBwuWTU+fH3xIEsF+1N4YpMi7lIilCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqsdBVHAI3Z8maEWtrBRNHxkKUjTkm0RlKrScHKG2NHIP5orE5S0YY/RLx+IBc3lOfOIBX2kOPcqteTKcaKsejmev7CWhSwcR5ABvf4tiiEoGeXsNnvmPHbQ6Xkyg2fDNnoWZODLcaBQCGekiuun8CskQrHMuWE+NWeH5rz3sG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yo1QhP+3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GRtP+FRY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763736537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qElSsFo0aW6CHPj9+eW97E36THKCE3lxiDkjHrXDAbA=;
	b=Yo1QhP+3kXxZ+bnRkd7tyvlHuNTMHqNNE/gRsHbrujC8PmTWLDJLrcMU9gkdTLLAqkzg6s
	1S/ioa50hkJaqLqXXfFMDi0VySfJC+1dtpbfNDixkHOE/5Hb7gih35kSqDgg1dYzmH542U
	VBXZgttMXHri9GnI+gt4o73kGMM2uwE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-SvdgwmbLNUiX88ypTCzY7w-1; Fri, 21 Nov 2025 09:48:55 -0500
X-MC-Unique: SvdgwmbLNUiX88ypTCzY7w-1
X-Mimecast-MFC-AGG-ID: SvdgwmbLNUiX88ypTCzY7w_1763736534
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-640ace5f40dso2134116a12.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 06:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763736534; x=1764341334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qElSsFo0aW6CHPj9+eW97E36THKCE3lxiDkjHrXDAbA=;
        b=GRtP+FRYWH+cKEmhFTxSrAp+qgb02DIzaRMXa/S3rumesM16JfDg1+mURMWjyHMJBr
         EaVlXM6palPZApdwQsxzgTF/IoV+As2Rwad0A4WPaGLlqVwpPVzQqqfeOLiUpN9ez84h
         /myMEfm8VQ2Ba5TjEzg29laaoAdWhBA6/B0Vx71PkMvPelIueqRzgkWbPzAdf+Pp9h9t
         2/dI8y6s9Gds8ObQHGoU1MSMSq9zQ/uyqodz21xOs3ffhQR/3ruFUeNGBa1P2nUp8JwO
         EOBcuh0tGv4TXQcx+4iZ/o+yJ3cf+sdTxSIpXFkrhQVri3wTiFyEu9/l+/6eIqB5XNME
         /aAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763736534; x=1764341334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qElSsFo0aW6CHPj9+eW97E36THKCE3lxiDkjHrXDAbA=;
        b=P/UiWQbkjyaJt/XNmCZerpKVRRv2XQ4/GXGl+Y4zw/ujosU01qbj52UFPLRXlsfva/
         5vvj7Gk9EZ/h4hrc9VriLmqXjnMyII9J49bDZ7Tjbu6CDY70ifS3uTOBZM+j7Emj1WC2
         aqTngK/R8XHeg+nlPznxzIEgYx75HGsjAIL9tGmDh3JCGkL7rOBymqU7F7EsMlKskUif
         Gx7Eg7SyyLrBzvfLC9mrxtedfXjiQQMlJ6xFuW7WvkeD6sjoFy1GsEeCET5tWpzSVZx+
         2s/iDSaKKaJuNS743H17GeElskR56MUm3hmD6ld16z3OUm/nWAhTstOoRTc+pJC//4ou
         tRbg==
X-Forwarded-Encrypted: i=1; AJvYcCXXzoe5oxwH2VzdMjEvw2qHhbm8PIzPQFKRxzyj5a2G+hwEY39epRq3bCGUevmF650ozu+Wkko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6wrLw9mBQbFHZO5t/huE53p4XOvbtkbohHH0Scox/SV7rD/Xq
	TsqEx0AHh6ugVfg1n48bjNyR7LURqBrHMrHx4TA7HJSldXox6T6kkYIIsKJPOr0/VuAgXQInyL3
	6ZY+3cgbvMdeRHyVTy+iyQnKMQcCzBtcf10KefDNkIxWU1lervDiZhN/PLw==
X-Gm-Gg: ASbGncvp22WvoHeP/WCWfER17R5SH8sdYZEC9RtG86o9OyFxpSv7DCG4O+wOMBQcINN
	+PnDRLMxYzYB/d8KwHEtGqq6vHz1RyO+YGQc7ocj4IvurAP9z73CGAVYReuvtzwe/X18WJGacRE
	i+ZoWovU0h2sXbuDW4yGANWvZJwyUdc7x3qFtVd7ZrcTagWg4eOxtNoO3aBRe/lxhunNrfG6GvZ
	QYUYIVl+Lh3gimmicT/f5eTJU6bLkf+5AP07nDooMx01HMzXGINp5hy9cZi4LIwNljyTWI2msVh
	G7805mi3g/D1uz742poPVscHfTd2LyM7B2rbv6pSpUX5WY8eSoS+hPKKCC/lEqWvedhqXtVfZDq
	Fg7s8nh8u2/Q/W+32BEjBxd9jmjw0hzzg+53yAIEbQuh04co9MH7MDnDYSujokw==
X-Received: by 2002:a05:6402:50d0:b0:643:804a:fb54 with SMTP id 4fb4d7f45d1cf-64554335d3emr2541664a12.13.1763736534231;
        Fri, 21 Nov 2025 06:48:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYJ6NYmSLizuNfGJGB7tJ5ZuOQzhRvgxOwNrAKBcDD7p9ENJ1FC64SfddE4bzlIpGVmVbelg==
X-Received: by 2002:a05:6402:50d0:b0:643:804a:fb54 with SMTP id 4fb4d7f45d1cf-64554335d3emr2541631a12.13.1763736533716;
        Fri, 21 Nov 2025 06:48:53 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453645f2easm4585052a12.33.2025.11.21.06.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:48:53 -0800 (PST)
Date: Fri, 21 Nov 2025 15:48:41 +0100
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
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v11 11/13] selftests/vsock: add namespace tests
 for CID collisions
Message-ID: <zpfacrsl6dxmo3ltwiovrcj4rtbqgnms4z6rwnw7o2jncgjw5c@hrorb4elx6mm>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-11-55cbc80249a7@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251120-vsock-vmtest-v11-11-55cbc80249a7@meta.com>

On Thu, Nov 20, 2025 at 09:44:43PM -0800, Bobby Eshleman wrote:
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
>Changes in v11:
>- check vm_start() rc in namespaces_can_boot_same_cid() (Stefano)
>- fix ns_local_same_cid_ok() to use local0 and local1 instead of reusing
>  local0 twice. This check should pass, ensuring local namespaces do not
>  collide (Stefano)
>---
> tools/testing/selftests/vsock/vmtest.sh | 78 +++++++++++++++++++++++++++++++++
> 1 file changed, 78 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 2e077e8a1777..f84da1e8ad14 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -51,6 +51,10 @@ readonly TEST_NAMES=(
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
>@@ -70,6 +74,18 @@ readonly TEST_DESCS=(
>
> 	# ns_vm_local_mode_rejected
> 	"Test that guest VM with G2H transport cannot set namespace mode to 'local'"
>+
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
>@@ -581,6 +597,68 @@ test_ns_host_vsock_ns_mode_ok() {
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
>+
>+	# The first VM should be able to start. If it can't then we have
>+	# problems and need to return non-zero.
>+	if ! vm_start "${pidfile1}" "${ns0}"; then
>+		return 1
>+	fi
>+
>+	pidfile2="$(create_pidfile)"
>+	vm_start "${pidfile2}" "${ns1}"
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
>+	init_namespaces
>+
>+	if namespaces_can_boot_same_cid "local0" "local1"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
> test_ns_host_vsock_ns_mode_write_once_ok() {
> 	for mode in "${NS_MODES[@]}"; do
> 		local ns="${mode}0"
>
>-- 
>2.47.3
>


