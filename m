Return-Path: <netdev+bounces-235772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6ADC35503
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 12:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5C6F4EAB5C
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 11:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CA030F95C;
	Wed,  5 Nov 2025 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFAvteAB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qq/LViCL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B983D30DEDD
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341450; cv=none; b=PsoDkT+IUq4JI6B+2exA/X102Sizwf5Jg1ZiYV620OEnpvIaNqL6DPDP07QBcWqbSEGDRwJukzZH94SlSA8cNa8ZfKcm7XnHIBMOzsEJ9YNQc2KJgCcPbI5GJFUvQvVVXvImott0k9TCTBlXB3FkJh7w7XEkaq4VJ3hnQiYEfhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341450; c=relaxed/simple;
	bh=EIruf+q68s7Apk3JnbRaT8nDbQ4uqSCgVg4dKHFgp3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFDgP+C9cZgu58JU3OP+bwn9ppxO6/5ktDs7dLhVVz2MnxRnAQvUMrq2DHwwDe2Jb7KGHcLfaHEfSVLKs3EXSZSpGWlbEgTuHabAnT4nvN2AaSl+yH1dmTwLtv5nbSfq2tZ2YSNbQj29hk+KscmGjHe7JxBiFl5Ei9QB1f+seWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFAvteAB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qq/LViCL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762341447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oJvv5ndjic3rP/0jjQlvKlNTvtUhgk3xpudTBbq2U1A=;
	b=RFAvteABn/BBV6nIkNb08rw+jdzOHbsMpoDAQAXW2L1ZgeEvjiOullAVxZfRfiOnSTrjyQ
	C77+D2uuiZ1PDgJG9+IMi0Wt18AvCnMHLs09Mdpd2xCe2tHE4LKLFW6pDQIjvnY6IlRMnf
	RRsD0LqqOUPGWPAkaK3ZNQ0xyzbPTZs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-24A2B4i2N02ugH5GY60Umg-1; Wed, 05 Nov 2025 06:17:25 -0500
X-MC-Unique: 24A2B4i2N02ugH5GY60Umg-1
X-Mimecast-MFC-AGG-ID: 24A2B4i2N02ugH5GY60Umg_1762341444
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775e3685cbso2710315e9.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 03:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762341444; x=1762946244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oJvv5ndjic3rP/0jjQlvKlNTvtUhgk3xpudTBbq2U1A=;
        b=Qq/LViCLXgEpV6/U0lNiB38+T1C0AH91AyA+6diE5t0rLt+LO5uloDj5+joYGYvCy0
         pS7hjMtsA4IJXAJ9BGY6OY1D+W/odH2TJaI8nNAXxLylTw1U+y+s553GwVDh+66nKQeG
         vvys8xUwzdPN8/nLD/7bB14GTa78MPz1hVqFfYidHa5GsYl+g6nKnGcPl/PFdabm7qUL
         W2EwGtBYZDAytDCGDmf1aOsr4BgehqrpselKyYp0HGWLp9Yn4M9tIaQ2ce5NMrjEI+Wq
         V7KcLqhmbiV29oGc3AFtRqBLkzPy9iSNH/0H+EqE25FwJU4QWa537G3PrhDE7VwmXGZ5
         rVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762341444; x=1762946244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJvv5ndjic3rP/0jjQlvKlNTvtUhgk3xpudTBbq2U1A=;
        b=pcuplAe7zSs7aMkrnH9KqtVDS++eQoNdHyEIfQ+Eye8KvPeenA0tW9jmlW8oiA8jm7
         3nCHT//RdgFfGhZuEwyeIHDT8Of+Sp7EOmYgOwPaEYKIfNFRhXTL09oT8yk/WzLySXk3
         NENzP/Cwqh7y3qWijd1H/YxpduTo57KjFEufua98fO99Udn0pIxRnOAf0NGZZsmsxoY9
         D1c6ASRBWVRK1OKpxmjMRS8la/fE6B34zmjn+uN0t1FjmQo6GHaTcDoQFYqpc2IJOsS2
         a5umlQTEveID3gjShw9igkA/bgIcjdAK3WkvyS46lTbXrVF6x1dOcomhdbng9KqXel0Q
         iDUA==
X-Forwarded-Encrypted: i=1; AJvYcCU7jaHHYxT5nXnxCjFKYxw+EIrkz592ASJfJeoKanSQXLkL019qZOrMOfQMrfL5QED0ix0KfdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhn+a/yLrPO++jjymcjCXhvTp+sGxGUTSOttBDettDoCCS94+z
	L4I40tnjm5Gh7D6kX2QFL2QZ6+FABzHPax+q8665kbh5mY+PQuzc2JYOa50lVXtPFNe5SzlNS8/
	Twy1qIX5Ml3TDuTZD9YxXnzqFl8VsRsBNEpYOuK2Ze0Xwf5TGrDknRlJA6A==
X-Gm-Gg: ASbGncutU1/bQ2l0nIzYOfRKagKMV+5HWcJjxGqMPpoZyliUdZEVEbQzlQhZ9np5oBz
	GG34erjAN6Dg9rMCAmFXRgvIRksYHYSDFE0DDZ27dsIn5djbFtZdzv879M/psiwJwnT2rKUIMD6
	w9lZbgyiGpub3rsNjIrPmwsLIDj9YTsk+7wMzCesjuD6TVsy7xbkP2chr1YUMovDBuAhYYN3cEE
	thNTXMrD7yTAp2W3fd6TkkDbXl59eFEB85hnE9ebwpFOePF7llov2LyeltUOjprTS/UZ/yis2Mi
	qSqBzn9ARqfO/NuObGtXmfr/COmKvxY6oS/nhDiXFAJNw0WNXokVYJ5VeJK7Q6OCTlGzMRaYlcC
	4CNon
X-Received: by 2002:a05:600c:1c18:b0:471:1702:f41c with SMTP id 5b1f17b1804b1-4775ce26b5bmr35419275e9.35.1762341444075;
        Wed, 05 Nov 2025 03:17:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNzHvCUGAag3+wrnkfdKLHqAtmgiZqn0Kpfqlpb4QSMfUNSwUxHezyd0VrzCOLaf/mXC1/LA==
X-Received: by 2002:a05:600c:1c18:b0:471:1702:f41c with SMTP id 5b1f17b1804b1-4775ce26b5bmr35418935e9.35.1762341443637;
        Wed, 05 Nov 2025 03:17:23 -0800 (PST)
Received: from sgarzare-redhat ([78.211.197.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755942772sm42323005e9.5.2025.11.05.03.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:17:22 -0800 (PST)
Date: Wed, 5 Nov 2025 12:16:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] selftests/vsock: avoid false-positives when checking
 dmesg
Message-ID: <oqglacowaadnhai4ts4pn4khaumxyoedqb5pieiwsvkqtk7cpr@ltjbthajbxyq>
References: <20251104-vsock-vmtest-dmesg-fix-v1-1-80c8db3f5dfe@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251104-vsock-vmtest-dmesg-fix-v1-1-80c8db3f5dfe@meta.com>

On Tue, Nov 04, 2025 at 01:50:50PM -0800, Bobby Eshleman wrote:
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
> tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index edacebfc1632..e1732f236d14 100755
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
>+	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i vsock)

In the previous hunk we quoted 'vsock', but here and in the next we did
not. Can we be consistent at least in the same patch ?

The rest LGTM.

Stefano

> 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
> 		echo "FAIL: kernel warning detected on host" | log_host "${name}"
> 		rc=$KSFT_FAIL
>@@ -415,7 +415,7 @@ run_test() {
> 		rc=$KSFT_FAIL
> 	fi
>
>-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
>+	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i vsock)
> 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
> 		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
> 		rc=$KSFT_FAIL
>
>---
>base-commit: 255d75ef029f33f75fcf5015052b7302486f7ad2
>change-id: 20251104-vsock-vmtest-dmesg-fix-b2c59e1d9c38
>
>Best regards,
>-- 
>Bobby Eshleman <bobbyeshleman@meta.com>
>


