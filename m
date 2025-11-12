Return-Path: <netdev+bounces-237953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FBBC51F85
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 12:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A024189DB67
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF1E30DD0C;
	Wed, 12 Nov 2025 11:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erB/u80q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CS6O0bCC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D091130AD17
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946706; cv=none; b=ASgB7iHE3jF4n1govILvVAxI3cDuoVzYP5RhvHs9JwO3rUrIJlbJ63xU7n5yiJ/JgfGXpaUhdMfAgpnxIYCwX7L6Vvw47pxFVCkRgunCHrnMJ7i8JKbTmlXdDAdF3VrjKb/rqcxa5OTfXoER/tM280R0TTB/LWGMk0CYtl7GSQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946706; c=relaxed/simple;
	bh=7Pu0o2x/O51dsOpfT3kiDBb6OdNE43A6rRDatL6h080=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUyn5d32doJ9T7OncIQEWhE4JRQ/g926FAsN1WcikoORp1trpjwA0FoqO3D3+czKQbhYZxxUkK+x0aGIUxbB2PS4BIBfrutwqOQjK0s3E9RCWDaYz0rnemG/gLj5JVE/jmebkgvBGJn65quWwjACR649T53M6QR/P0NQQCxxvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erB/u80q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CS6O0bCC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+7K4dIhyJN2R790pmm2/Yh3kYrLGArEUHflkSvPh5s=;
	b=erB/u80qQewkebEGUT1RoMVYcCQUe4HiZh1868zN1K7ISkCddHpXjKqu/PwK5ZN70xv5yZ
	BFi6WLFBIKgq/YoDiaoyiFp2/LCbsFnFWP9pL73Wemu8ZnhUFQARXKd5Lj9Bfk5pceyfeY
	OUnB/qiXZaDiEJL+nXcKDfKj6+fmbSM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-aJzBKAZdMji0sP7tHTRceA-1; Wed, 12 Nov 2025 06:24:59 -0500
X-MC-Unique: aJzBKAZdMji0sP7tHTRceA-1
X-Mimecast-MFC-AGG-ID: aJzBKAZdMji0sP7tHTRceA_1762946699
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-882376d91beso21253886d6.3
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 03:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946698; x=1763551498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m+7K4dIhyJN2R790pmm2/Yh3kYrLGArEUHflkSvPh5s=;
        b=CS6O0bCCGIyzstZHWQso3CaY2SZlNzvT12Csfr2FoQLqb8UNiEYCgEgFff2Xfd2ak4
         LF6nwUvq7TZfqEP6TU3MvLmPuBLI5+HPbaE1qGO6ZbxpixjO2GQLEMQ6XSzAk2Kkj8a6
         cSnblLmWyxj2eXY7Nn+o4OAvIhzsMWLj8RgsXh8sykPYzioLl3VBYw2cSZNwlOedsZ/U
         1xaDJ7cT/gLPb2CYmo+0rw1hE+v65Wds34wF1NCIqsMKHJ7zEDDJt/+FOhPb6m3c4cDE
         ubsazwaK8EQAzRpab9VBSKdMI/Ax09U+jh+pTvp7r1SEtBomx2pmpSuK2USsvQqjAg9q
         SlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946698; x=1763551498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+7K4dIhyJN2R790pmm2/Yh3kYrLGArEUHflkSvPh5s=;
        b=oultCcyWeEmiFYZTmF1C2AFajS/2SkuaTiJtBd2f6kEEGM7W+Jn0Vt9JpmxGDClYWr
         vvc8MTKjpyiICPOT83KaCDp0axNAp3KVapDFHZWkIrUHhNNZQi74l4SKvefR9q2QqTD7
         Okzt8poyRt8BTjY386EA35bCodCDDm63xLt5ycWj9z4x7cVYam+G+R5UQV2nOjlKlZ86
         HKn89p3fsqiCwc8M4kQtDdzs64+8o7zFvZEqwMhdtQInWwv49yZGTSstSUZpmsB4Nhtx
         BrhBn2S84W1r+77jXWLw7n8/yseZOR9Z1vycdGZFa8E+Kuj6g/feb/8q3+Y7iFtDw6ib
         U5Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVEVUOt5uhiErXA0We0yOn9B86Ujt1WMJ8rNSc8S6ppDLhlBAzCMKhloUMThgjgp18yg0tCEtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAm89zwhm4jhVuKyLwWb2IUIrwnHUPjg6LgJ26aAVP3I0iRFMx
	ak8oLYPibFB+PlA4F4N884z6U+ORB5/qlcBxyLNz8CjJpMdI6TZ5z98jQLKakZrAaZRWkfRuMpM
	w1SHT76iVT3/hUHR5GAznWgYyiVVRQGebiA4clb2xn81W9rozkh1ZMn1ckQ==
X-Gm-Gg: ASbGncuRZSh9LHMjfx1bE6oGzYRmgzskpuHc59IgOfOKmGyFGYC9OEGnGvD8B5dcA/3
	b1/dHKd0zLkbQGM5IEvbwD/V5+93sUN3DWWUrVcB8x0L44T7Pq0GsbxXeCdP/5TauQryA2NkCv0
	iwz4MiXTa5UESD68tXoiNXyqmoisjwmG30s3Lx9bno8bqq0LUETvBA1tK/bWu5LcRih4sTO6B2U
	c9LExJIv84b5EKj0kFCLu0TqT69jXEC9pN534i/ryEMEi61qmZF1EaAotuHdMDNczp16bpCCP7S
	jUdC72vbmgzfKAVgb4ETkx8x2KkNIchMk2Cv7xgIYAbeOOCng4qaAl9WdnBN/E+qxOrRfdj333m
	tmmozOBNlZyfmLA/2QfNiZWGVUvOI705zT92a7EUqKasMqPaiUJo=
X-Received: by 2002:ad4:5f07:0:b0:814:2a4e:efbb with SMTP id 6a1803df08f44-88271a3ca3emr36868286d6.53.1762946698665;
        Wed, 12 Nov 2025 03:24:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg23TSNoDmt+ZtfObVKbv3IEADZ/iTaXYGqZ7/Rp75tiUGAUlZRDyDCgloNS0C23doS3gbzg==
X-Received: by 2002:ad4:5f07:0:b0:814:2a4e:efbb with SMTP id 6a1803df08f44-88271a3ca3emr36868006d6.53.1762946698263;
        Wed, 12 Nov 2025 03:24:58 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b91b22sm90041186d6.53.2025.11.12.03.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:24:57 -0800 (PST)
Date: Wed, 12 Nov 2025 12:24:51 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 07/12] selftests/vsock: add check_result()
 for pass/fail counting
Message-ID: <2ujds4l5ji7pdm7lczttukisjdoo5z5ufufw4kd3qyls26o64o@43yt3nkohsm6>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-7-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-7-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:00:58AM -0800, Bobby Eshleman wrote:
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
>Changes in v4:
>- fix botched rebase
>- use more consistent ${VAR} style
>
>Changes in v3:
>- increment cnt_total directly (no intermediary var) (Stefano)
>- pass arg to check_result() from caller, dont incidentally rely on
>  global (Stefano)
>- use new create_pidfile() introduce in v3 of earlier patch
>- continue with more disciplined variable quoting style
>---
> tools/testing/selftests/vsock/vmtest.sh | 32 +++++++++++++++++++++-----------
> 1 file changed, 21 insertions(+), 11 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index bd231467c66b..2dd9bbb8c4a9 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -79,6 +79,26 @@ die() {
> 	exit "${KSFT_FAIL}"
> }
>
>+check_result() {
>+	local rc arg
>+
>+	rc=$1
>+	arg=$2
>+
>+	cnt_total=$(( cnt_total + 1 ))
>+
>+	if [[ ${rc} -eq ${KSFT_PASS} ]]; then
>+		cnt_pass=$(( cnt_pass + 1 ))
>+		echo "ok ${cnt_total} ${arg}"
>+	elif [[ ${rc} -eq ${KSFT_SKIP} ]]; then
>+		cnt_skip=$(( cnt_skip + 1 ))
>+		echo "ok ${cnt_total} ${arg} # SKIP"
>+	elif [[ ${rc} -eq ${KSFT_FAIL} ]]; then
>+		cnt_fail=$(( cnt_fail + 1 ))
>+		echo "not ok ${cnt_total} ${arg} # exit=${rc}"
>+	fi
>+}
>+
> vm_ssh() {
> 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
> 	return $?
>@@ -530,17 +550,7 @@ cnt_total=0
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
>+	check_result "${rc}" "${arg}"
> done
>
> terminate_pidfiles "${pidfile}"
>
>-- 
>2.47.3
>


