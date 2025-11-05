Return-Path: <netdev+bounces-235824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62626C362E3
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 15:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC66B626DCA
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC1B3321A2;
	Wed,  5 Nov 2025 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtyqB8e9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ogqs4TA4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAED331A43
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353703; cv=none; b=MNk75UZuGsUZ4s/Lifwu0c90NsaoRh0u03EVIgzqKydYcEgv4p62LXPF90wxY/KqLxH4qiBajhLUijhAuoThn2LwYJacyeNqTp+QSlwZA5xuFML3M0yqtsK+k2do5OB3KzHVGN7qt2ImP45C/JCGd5h0vwqp+NXQDRBEoCwwWDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353703; c=relaxed/simple;
	bh=Un+S3Mc0QD8v6wfj3eL3xXYh+ndupS7pAvsfKuhFm4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USAeLxzUNDQEH8EqOC7NvKTLLEQPx+TlEHeeftUIQA7SEIShieV612IYQPfsDKQPgLm3TRvRb4KY3jwh4UE9Kcc1bQThXrFZBhkxBdcjSXRVJyne+OFPZnPrUVYPPBlLgDJR4oHhaOUH3dkaj3N7JxgtZA5OMqa7fLevceTka8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DtyqB8e9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ogqs4TA4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762353700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=83D8bblxyw5BuUWQPyxb4QzkQFd3XzPLsRwrCQzA9jQ=;
	b=DtyqB8e9NzTwOO20bYenAXHYNhrsMuhPPsL9uiqSXlzOnuApisjmoCOso6WwqXsKchZKiM
	PFrvwegFOUcyV3M25oOIAlTwaId0TmXyG+ZbcWjVxADH7a8bb6AkyKl34M4KadrbesATqz
	2kmR+NofX1DBO/SOVceiSf8cehCDbEQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-P5UEUi3yO06QPDGVAHSpSg-1; Wed, 05 Nov 2025 09:41:37 -0500
X-MC-Unique: P5UEUi3yO06QPDGVAHSpSg-1
X-Mimecast-MFC-AGG-ID: P5UEUi3yO06QPDGVAHSpSg_1762353696
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42814749a6fso4865313f8f.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 06:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762353696; x=1762958496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=83D8bblxyw5BuUWQPyxb4QzkQFd3XzPLsRwrCQzA9jQ=;
        b=ogqs4TA4j3DjXybCnMBUFnNFyVmbxlBQF2CJdj7xhm/0hN1rSUywZsZpThzYYfLoYt
         JX9xMggCkPcX/i1inK+yg6tbcJIOPbRe4H4tAcBbzL/FoH38wpg5To+etsnbJStKJ71F
         9fhFebhgqcUGY1QUP1oRpscft+R2S+UW3ArcTFEqwzZsgQlOYxIpoS79Id2ozEUuwXcu
         4yMAUXh2Bn9icQnmCq3LfuhQyrBEKvdhAXimAc/57jwoQ6Iw4oP4oqvIcLNL+1UZzzn/
         Z59mwzSBYhz/wGHe2jNJRD8sDk7PAEGEW8bM7yLnuMTgFgnu6++/m/B3tuAQaBC3hsIx
         pm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353696; x=1762958496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83D8bblxyw5BuUWQPyxb4QzkQFd3XzPLsRwrCQzA9jQ=;
        b=oXGYudjWuSMMqLDRqh38OkZIcXNDZHATl0VWCM8KcnTRps4t9JizM46RdqbOYZHKgs
         jhN/xbTPQ6QP6lMzXjh1DH8Vir/KABcuj3eJYw3cZsUhgDW/+f0+8kSq+ZDm5BNN1fQc
         lO7AaRFy7ydpzpPozXKP1m5d5xpVFktwcETq/CI5Nzb5mpI4ZAOxzhGP5d5lmggclCp5
         YrvnRK1bGAsTV9R9+JoULXK/KfZApjSLSnIfiyr4wGdtJYHr3hf727CyCR4X2x1UR2n6
         zfGX7o1032hhfpzZYGr3EBP5sxP0GjtMSnD4fgeWMtVJgGB8fvrfwYNUtD2zv09m4o0q
         IAHw==
X-Forwarded-Encrypted: i=1; AJvYcCUffCI+tPSaPvxnoZ5ueQozYbm4kJi81auyGezAnp+EqKo/CB2U84uYNwX4Smf1AGBPw2+Bv6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+JbLdKXfKfI4m23ZiZgxlzJcwwhB0zOX2OgMh7WykgN6RFC9
	sDwuGNvr40Otz/9uTcnR9izHRw+KcwAWCnHOaXUScbQ/3u7GcMHnd19uFsf84l/C1BM0gpCpg30
	g3SS5StWR4tpGmjFJwpUqbFkgM4v4NhZF/flmPEnfTcdO5jQ+UY+Whfu8LQ==
X-Gm-Gg: ASbGncvVGsWeDgBpB9GbcJjb0/tsuRc2qC3b+8PuWvqfBbfNCZn3muoe/t8nEZ+p3pS
	Ri6OzlOmc4OdQCfPifSlDBY+qs3B/ayIpUhZIEHerjkx/A1KTuX3LnFeRgtbMxk/Nzb/5/xOBSF
	wJpVOB7n8p0Ju5G4jqQ9eBwBO5IUrUcksGRDWUTK71zBSJaznvew+Z0xJ2QIWcGL+RI/AkP5hS9
	eGvoLr/hoIj96SnJ62xLEa90MiF2BViLdnYxF9sUpf2BRy/A4nyX/v/im5cRWMR++5sFR+se9G6
	izXsY7F6ITXBz49nZXCWk/Cunpb7BQoVnZCGUkSfMVT63LnlG2naZpskJKT8cHeJcBEwTHliImg
	=
X-Received: by 2002:a05:6000:615:b0:425:7cf6:5b9e with SMTP id ffacd0b85a97d-429e32c831amr3305572f8f.3.1762353696173;
        Wed, 05 Nov 2025 06:41:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdNjVd77s4VsvkrZ4AU/ubU7KMUlzm/N0GSTkO1qZtkX4KqpOh8zmlKt0hs1ExVKOK4eMg2Q==
X-Received: by 2002:a05:6000:615:b0:425:7cf6:5b9e with SMTP id ffacd0b85a97d-429e32c831amr3305546f8f.3.1762353695682;
        Wed, 05 Nov 2025 06:41:35 -0800 (PST)
Received: from sgarzare-redhat ([5.77.88.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18efb3sm12058326f8f.3.2025.11.05.06.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:41:34 -0800 (PST)
Date: Wed, 5 Nov 2025 15:41:25 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 07/12] selftests/vsock: add check_result()
 for pass/fail counting
Message-ID: <fodit6zue6iwtqgk54qy6fvmegklnsgh5437h6ofopzhc77i4q@u76zkisp4wie>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-7-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-7-ca2070fd1601@meta.com>

On Tue, Nov 04, 2025 at 02:38:57PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add check_result() function to reuse logic for incrementing the
>pass/fail counters. This function will get used by different callers as
>we add different types of tests in future patches (namely, namespace and
>non-namespace tests will be called at different places, and re-use this
>function).
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 32 +++++++++++++++++++++-----------
> 1 file changed, 21 insertions(+), 11 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 940e1260de28..4ce93cef32e9 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -78,6 +78,26 @@ die() {
> 	exit "${KSFT_FAIL}"
> }
>
>+check_result() {
>+	local rc num
>+
>+	rc=$1
>+	num=$(( cnt_total + 1 ))

Can we just increment `cnt_total` here and avoid `num` at all?

>+
>+	if [[ ${rc} -eq $KSFT_PASS ]]; then
>+		cnt_pass=$(( cnt_pass + 1 ))
>+		echo "ok ${num} ${arg}"

Where `${arg}` is assigned?

>+	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
>+		cnt_skip=$(( cnt_skip + 1 ))
>+		echo "ok ${num} ${arg} # SKIP"
>+	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
>+		cnt_fail=$(( cnt_fail + 1 ))
>+		echo "not ok ${num} ${arg} # exit=$rc"
>+	fi
>+
>+	cnt_total=$(( cnt_total + 1 ))
>+}
>+
> vm_ssh() {
> 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} 
> 	localhost "$@"
> 	return $?
>@@ -510,17 +530,7 @@ cnt_total=0
> for arg in "${ARGS[@]}"; do
> 	run_test "${arg}"
> 	rc=$?
>-	if [[ ${rc} -eq $KSFT_PASS ]]; then
>-		cnt_pass=$(( cnt_pass + 1 ))
>-		echo "ok ${cnt_total} ${arg}"
>-	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
>-		cnt_skip=$(( cnt_skip + 1 ))
>-		echo "ok ${cnt_total} ${arg} # SKIP"
>-	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
>-		cnt_fail=$(( cnt_fail + 1 ))
>-		echo "not ok ${cnt_total} ${arg} # exit=$rc"
>-	fi
>-	cnt_total=$(( cnt_total + 1 ))
>+	check_result ${rc}

Oh, so the arg is in this scope. mmm, can we pass it as parameter?

Stefano

> done
>
> terminate_pidfiles "${pidfile}"
>
>-- 
>2.47.3
>


