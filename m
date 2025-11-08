Return-Path: <netdev+bounces-236999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FF9C42F6B
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 17:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DDF3B47E0
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 16:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80B724EF8C;
	Sat,  8 Nov 2025 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVTEjkGv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BDE23C8AE
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617720; cv=none; b=RlL+Yz6WwHRe+abfTtYEy7IMrFDuPEtUT9mGXLg28ynsGljnpxCITHoxyJvIetTv45zGbQJKfODGTv5nIV3tOP6mlSTXhZigxCmIqoKty8NBubKRauLQH+TaiKA9i5xIP4nbIXdjqoZJwDgBAeBAPORu+g25ScfX9BDdJQCZrRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617720; c=relaxed/simple;
	bh=o4MlQeDS6auM9P4kHNQ3k9pmc0q9lYi9e4vGWiCOtnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q6KzSqnSDsWcYbP4LbW1aKwgSZ6XL1U74QwiL0tQV36seae6wlZZ6RYTFdx9WufqSGR2ogm4qY07c9jpAQBzQ3rLnKdnpcXDAJySv7go9yydP+FNrIPl4CP7FyGptomF2EO70BUhtc4Qj6bdUhx9kQF2HSPE7gpGyV5cqTUjH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVTEjkGv; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34101107cc8so1350961a91.0
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 08:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617717; x=1763222517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAjRw7PTsJ0iELJkuhd3H4m56at8173dELtud6Xr4j4=;
        b=hVTEjkGvapsKmGpxS5+PsTRLGx9RFWSF2NeCVEcJo3kTsjGYY6aasCcUCtaLSC1ArU
         jUBY5iS7mzudJ2YK0bwCWUVvNr8+n2LrMM34xoYoOVMAlB+OXBDV34ou5b8cLT9RIFPr
         vzQM0EHWB2MKfePDZKXZCoqLmltzC6chlG6+vNvhzAqBNiQfK6r9wSG0wqpN21pX3WFx
         vPoAgEGN+PsTmgLGmR1sML7KMpwHkVmAKhx+tWY0abW9eAxIZrmnkFyjLZHc0I/zABt3
         3hJbseaYCIVJIUN+U6hHcqMSErDe+e/DfIkJaX+k9sywSU4AZ1nbQTs0fyyP3sWLhssQ
         Tkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617717; x=1763222517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WAjRw7PTsJ0iELJkuhd3H4m56at8173dELtud6Xr4j4=;
        b=l2+D4IWdnnobs98dumPif5+5yRI7qt99Qkp5Mhp/ok2CL+h1CvL09FCtC1Bn3mWRkE
         yghi+ck3g9dQZVHj8P99jpt+xiKr8RDQgG5Gdch6u77981d+GJJE1I2Oe4VolFoqGWRj
         md1rNh/Zkvp3P5qhei4XGojMIpR3zolWFA+dU96xYy1H8zFnrUsvAWYanHvq8fkMSsuL
         S4DJhlzDxiaW6lmKurqbD9ynF+pwNF16DL/cIDmpvmhkmJwUye8cwvqbLYXOCgQ/r+F7
         9PPN67FpuhvdCl07X8TCEUAQ+oHPqWJU4wdfoqZj1QkaIj38KBriYF7zAzySOWbg8mkv
         CVww==
X-Forwarded-Encrypted: i=1; AJvYcCVIyntcckw13MFmTZem/KIEB4hDrpao03NeG6M5yywWP+BfCT4Ht6XfKtSDQWC5v6TZt3IOIgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUhTovPTF2VS5gQFyT1liNZk1aEbyqzHtIBv1w9dlZDjNVlC9O
	VvDH+r2wqDWNJmFG6SMbXJqAfApr6+ghFbwlmafmhc8ekXjgm4zJuezK
X-Gm-Gg: ASbGncsLEP6+A9EelgGRWOO8qRYUuCQCHxFGsEzk/6eU/4qZnmE6dsewrgOdwCaSNyr
	V3p/3kbI8wQybUVnRxi5pRXn2lKeOxrVaes9/sZ71rfM21ife8iVsdod/E4jw2qLfl+BQss9ng7
	9JE/PjZR93TGlmt0rtt9AEFsX0Vcgqo1lC9/vj1nz6YsARqVqMLd385rAcbF53L8j3FVvPWdm7X
	H8frtsdPaqZbX4RIVcUHBzskf9seVp0+74L+SVrxCARY9y0ArC+sK+rau82ptmumSw94r9XA1+G
	kN53cCOWK+fOgISGQdicdcNzlttOaLYdAFyWAveP8MjBJQFqfZBCjbAGPOJTP2Q7xevvRysl9yt
	4ti64rfZ/+ujsntXkH1vlF1403fvpUJqZlrmshWU1277wsGXOqCRkk8hIgqX+8flUo8MoGk5KfQ
	==
X-Google-Smtp-Source: AGHT+IFJMiSDPJLEVgezSpGbFJbQVVjV01QEtUzeI+pmHkqds9NcgUya4c0r1u1o+ppTnMUl7FVAsQ==
X-Received: by 2002:a17:90a:dfd0:b0:33f:ebc2:634 with SMTP id 98e67ed59e1d1-3436cb3d256mr4326835a91.9.1762617716780;
        Sat, 08 Nov 2025 08:01:56 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c3357bbsm5935730a91.12.2025.11.08.08.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:56 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:57 -0800
Subject: [PATCH net-next v4 06/12] selftests/vsock: speed up tests by
 reducing the QEMU pidfile timeout
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-6-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reduce the time waiting for the QEMU pidfile from three minutes to five
seconds. The three minute time window was chosen to make sure QEMU had
enough time to fully boot up. This, however, is an unreasonably long
delay for QEMU to write the pidfile, which happens earlier when the QEMU
process starts (not after VM boot). The three minute delay becomes
noticeably wasteful in future tests that expect QEMU to fail and wait a
full three minutes for a pidfile that will never exist.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 6889bdb8a31c..bd231467c66b 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -22,7 +22,7 @@ readonly SSH_HOST_PORT=2222
 readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
+readonly WAIT_QEMU=5
 readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 declare -A PIDFILES
 
@@ -236,7 +236,7 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	timeout "${WAIT_TOTAL}" \
+	timeout "${WAIT_QEMU}" \
 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 

-- 
2.47.3


