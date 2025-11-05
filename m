Return-Path: <netdev+bounces-235879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6346C36B06
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 17:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD8B85017C9
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A07332ED1;
	Wed,  5 Nov 2025 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGiEhwta";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8aOGak9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8465F32D0E3
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359398; cv=none; b=r2NoYin0AgZtfRUDdcIjzJIVrOs9rBhQkN7ghbcOuTP3l0sPpG3nZPv/m+8nE5WWLZK9sJJymBVVQLMLecdSoi5dUray1JWeCkc5cmG0yYzvqeDiWZ/oJ6yPULWb30lcNlTk+q1khVpLJdCGNQxhNl9D5PMbZHugZWDQe0jRiQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359398; c=relaxed/simple;
	bh=Z7eZPun2oefAkSM3+F0++XPUVNTkIWBrwjzNYiRkZK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H17f6XkLFzaAt6zlzdUde1gUgfQsB6qFsmebDVWv8ioS2kR8ra5OzSv5Fz4MPDTvK6BjVuE2sxvY3bdBeK07vM0N+E7pt5YxiX0SOLKexpZuGzQpcM1CEN/aLbJL97CNWUMSzUMj0Dc6Zmdf7tAr/ZBcmbl7o0IoISrXDPD+T8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGiEhwta; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d8aOGak9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762359395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Du/r5ksOWZtDfSJI4YOsWmAPKYTxSvBd3w3sn3Syt2A=;
	b=OGiEhwta/SVUOFStPYurh0GkafrhS9FdNMbzoBBcD36fi8J/NDiHHc6VRGdygkd4lwwAIG
	IZMk2gRtolOwliCV8JE/1zTBjLTnwzxo/Wr4thnG71tEHK0r0DqkGqL7myB8ZfEpYisJ9a
	zFR44943wJdmW0Q+GuEGro88qE0qXlQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-XnO6scQXNkq8Bh5WeFEPtQ-1; Wed, 05 Nov 2025 11:16:34 -0500
X-MC-Unique: XnO6scQXNkq8Bh5WeFEPtQ-1
X-Mimecast-MFC-AGG-ID: XnO6scQXNkq8Bh5WeFEPtQ_1762359393
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477563e531cso21459005e9.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 08:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762359393; x=1762964193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Du/r5ksOWZtDfSJI4YOsWmAPKYTxSvBd3w3sn3Syt2A=;
        b=d8aOGak9u1t2OiNCqVmiW5WUQk/pefp2soSF1/PSBHpRnHYPIp6u/1kLlDmR0Ce4/B
         GD60rr1gue63FdJ03HRwTt5GhKYBNbaNI2h8Qh/j8z8lf2taO31ubQjQQszQE3C2lpEP
         A30K1hVwDS2P5XWilErfs6qTMxtW0GV4enyCuLqYMWlnG0zrL7stGJXGMtytfkmCq/XG
         ilbnOPkwq9ga57gD3ozMy3xxDvSjdjG+qVpsHOEiLIqKectvQiLBidjxERsqOlhLPoAm
         Vee7oFIc8AIgIrJHZMgBtEYMIp9W+3eRxzN6lYQjO5FFxWxae947Q3Pg0GEnSDyrjD2G
         cVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762359393; x=1762964193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Du/r5ksOWZtDfSJI4YOsWmAPKYTxSvBd3w3sn3Syt2A=;
        b=czgUAHDn6G5AmTis5d6p/drNBvlti89tgFAocD2LkRYejQCMmjS9I/Y5PPFOnoh1CQ
         qzDM5SL8H3iusjeCYgmD/nHaoUaUJ9KgCP264qDs1hDVC1hwc7PEGN+9TG9KzUdwOLxY
         obo4pXtbuzL/rwLxE4lLSpckRGMz3xpNvyWU57xOfKIynUFIEAi/idhCItNHM6mz9bJ9
         QBRj4Cn3nSamfarwX0LgoPcE8Zh+fmzonXtrLcraePdITkIAjNqM9bAFhBsBRSyToyIZ
         oddNtuH5WflMUwGcnyNx3k/LKzraYYXEJxcGa4YiczReYt4oOkUi4KpB7nOROatE1TKC
         Gl4A==
X-Forwarded-Encrypted: i=1; AJvYcCWj9SLuWeMtYy06uclIzn04iLoBgQHNa+ervIBqM09IVgMH00AI79Jml+zlc4wkgA3HR0RHPP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW4AwhLUDWoTaRBU5ClYhNeLZBwRKasZMjL1sgVhoyNggvEDJ3
	LeV6YEJSEMynZwDSzwsVBFiU/UI9Qn2kNOirJfs7lQh2HaahOnbYeppS0OYaHyAmVK2tTQQGTwE
	s2QRHGarDw3uFgonv6dQ0pOz2W6SmMOu2PrrjyjM2tcoU9ZaRlN3I/97kJg==
X-Gm-Gg: ASbGncsSrvseS2mwz68oNHsGmOSCzsFpgMJsZYCJcoUhfmaDolVXIwFJd03pvxRxa3x
	tHsrn+uiplU6gjMb5/iccASitSabrJAj9vPtIvXIAHgGZdWbGpzQwzXloWlr/4BvtXO6RoongQH
	9ISKv4FGAaSaLe9YyN0qFFneQaodR0qIn/mrc4eL9Zo8+UfNNQi9OmaQXITSnm93dUL5HbkY8eb
	kTbXhbSYJnoFjh57f2dIUnTToMIvKhYiZxJUp53LQ2qRTseusTSAY4pu+EaezrhmLPY31o1bJ7G
	zKIcAVt6qD0KB3LwbMAFdIc/+LnB+BnOMHjC8IAMiFB1EGtP53WwVqJyrJoGJqVm6jeg5gIWfIF
	oj9s=
X-Received: by 2002:a05:600c:458d:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-4775ce2b680mr30986295e9.28.1762359392875;
        Wed, 05 Nov 2025 08:16:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1zaF9xjh7lShdpMKxs0x1j37UBOgMCZm7D8elWZkrx4hb3LonHqe/99De4jJ82rRpyZFkSA==
X-Received: by 2002:a05:600c:458d:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-4775ce2b680mr30985775e9.28.1762359392381;
        Wed, 05 Nov 2025 08:16:32 -0800 (PST)
Received: from sgarzare-redhat ([78.209.227.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5af7sm12313106f8f.28.2025.11.05.08.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:16:31 -0800 (PST)
Date: Wed, 5 Nov 2025 17:16:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2] selftests/vsock: avoid false-positives when
 checking dmesg
Message-ID: <5dkiqiatpxuq3wnizyq25c4hmiztglefh5icdcxpkvmej775nn@qw4gmh2bheyf>
References: <20251105-vsock-vmtest-dmesg-fix-v2-1-1a042a14892c@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251105-vsock-vmtest-dmesg-fix-v2-1-1a042a14892c@meta.com>

On Wed, Nov 05, 2025 at 07:59:19AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Sometimes VMs will have some intermittent dmesg warnings that are
>unrelated to vsock. Change the dmesg parsing to filter on strings
>containing 'vsock' to avoid false positive failures that are unrelated
>to vsock. The downside is that it is possible for some vsock related
>warnings to not contain the substring 'vsock', so those will be missed.
>
>Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Previously was part of the series:
>https://lore.kernel.org/all/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com/
>---
>Changes in v2:
>- use consistent quoting for vsock string
>- Link to v1: https://lore.kernel.org/r/20251104-vsock-vmtest-dmesg-fix-v1-1-80c8db3f5dfe@meta.com
>---
> tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index edacebfc1632..8ceeb8a7894f 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -389,9 +389,9 @@ run_test() {
> 	local rc
>
> 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
>-	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
>+	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
> 	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
>-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
>+	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
>
> 	name=$(echo "${1}" | awk '{ print $1 }')
> 	eval test_"${name}"
>@@ -403,7 +403,7 @@ run_test() {
> 		rc=$KSFT_FAIL
> 	fi
>
>-	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
>+	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i 'vsock')
> 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
> 		echo "FAIL: kernel warning detected on host" | log_host "${name}"
> 		rc=$KSFT_FAIL
>@@ -415,7 +415,7 @@ run_test() {
> 		rc=$KSFT_FAIL
> 	fi
>
>-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
>+	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
> 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
> 		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
> 		rc=$KSFT_FAIL
>
>---
>base-commit: 89aec171d9d1ab168e43fcf9754b82e4c0aef9b9
>change-id: 20251104-vsock-vmtest-dmesg-fix-b2c59e1d9c38
>
>Best regards,
>-- 
>Bobby Eshleman <bobbyeshleman@meta.com>
>


