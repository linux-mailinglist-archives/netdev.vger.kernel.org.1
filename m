Return-Path: <netdev+bounces-236570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56869C3E07D
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 01:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2FE44E9F67
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 00:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F582F6195;
	Fri,  7 Nov 2025 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqJyFPpc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311E62F12BB
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476600; cv=none; b=UbGSS13GKpiu2FTXMyO3huQ1qoPXF5XKXHfhZsYDZ5Xe/QDLdVHEwnZTR8kxTt1kJr9ySaWh4nSn2QwFTuCSzCfks+QbTIknWcq+qJV6ZEeRooTeLLm2sL1wK8ttN2HphGHjkGm+yDP1EI59iG0XmQxsvdzxTD5khv/Ki4vWCEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476600; c=relaxed/simple;
	bh=NjhEgtu5medwkPvG2Enm9tK5HgLlZ3KE8dn38aGAOtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d1G3AZcWBfzFYEN3sHGvJyhzcCiv0xA8FTAM/ZTwNhQ/mB4GK1TT757hWIeNJMxNvNWMVfXJ9rgzloELCwo8b1kUq28YdpEnqc/nwNnQ4jMg9FyXOo2GTq48DtNgPXizgMLa9e8wmPiCnYrQAxphzmGf2GGkxU4p33WrIDflBE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqJyFPpc; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a9c64dfa6eso161757b3a.3
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 16:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476597; x=1763081397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cB0jrnxyKvtVXOL0SkOCiQy/hsJ1kDvUYjzNG1+oTMw=;
        b=AqJyFPpciT/XLz8cnmY9iVvQF+xWs1lXU4cw5fA26gNRVpFdfzYOC2wmBDX3ja6Lj0
         HUhHkZ9Tnn9R4kFrARXJGdqLMM3jC9a6iKvub0+vejhA7e0nd93dAqXjvY292BF/DGhb
         U+jNYQ7tS/wN6ZTcw/ELQLJVZV8b169Juifisa/jflY88RFwY4R48FBFd1UcGC4f30wk
         k9XszumA63tne7hLyrImUp8p5g/Jy+xi+P2j9/OYS/b8LMBrFz6G3Y90pDDrRbHIXYKx
         esIbELi671CdkhCbkNg8YNc7ipg4Q1tLW0jFKbTpJHW2RFVe0ZCvMfxpJAjcIq2yM6r2
         x6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476597; x=1763081397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cB0jrnxyKvtVXOL0SkOCiQy/hsJ1kDvUYjzNG1+oTMw=;
        b=B/dRW7z2P5SMOLoQcORUvL4jU+gzt0R+0tHc9CTtuNM1kzxD1SUTF/drKANYHroIfb
         NTqJLgCZPdtGmscaChwfDF4m3gxp7C/P4+KTI73KabRhMebvfrLn1apaHjZgmyAMi8fP
         WkM3+Z0Hml1UsO7FzOjMpvUUwcr9/uYSCjixzr+IUO1svQH3z+7CCetPxuqfkDTN0MQE
         J72P1Vyg5kV8vLX3W3hJuIgao8ptS76mMra3l0QTrQlyXuia8vPFyWvY6ZP0ZEbHhZvW
         bk5JnCn6ug1egj7v2VFCVwdYifFmFi2YUQ/Scz+ndEN+smwsTuqDPa7lDSzXKkkWirUg
         UFoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh7laEGc1XfWkSHawcSO8Xf0tAF7d0NXGD/EQWJYU5Y0SKEwUfCsyosqNqcOoR6HMo9Xy6/GM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhcTSS348Ers3KVUUDNwjemnbTLvaQpM4BmquUnfgCJk+bqeY9
	2Us9QrSoA1ceu/N+osLdoNCECLjAqr22HTKJDldWZ72sRVUoUU+h/m1vC5OMbA==
X-Gm-Gg: ASbGncsiwF0flSCh+xnbyZDXjjzlzP7uz8y1uCS40EpDWEAHJPJapbd33qPbqyrdQTj
	hkIPMA1Qbf8hHQ+Gv/+jUPl9YhdTSo7RcHeODezi/VkFkmUfAwlsjlXCTZwLZibi6AVEDCuyxZF
	U0xP/8/uV41lTxQZIsAVBhvCGW8d99TVw2mDY+h6sCXTnecvZIFA6vtz6YN2eqZSuPyICcznYK2
	0ul+f1sjpcygs5eB+1xZupZEmYeyZDSEH8HON+JBlZ//OJ+VYLtMMK9OSU1Y+6nbVFmIV9CKF5s
	pLH0LdxiM1t/cxS6HNG5x1xr7meNm3SAQJgnnhWw5H8asmy4FuxDUcVBMLWo1/Xwtb14eA1L1YV
	/qo9wRpRmBLH6SCS1Y1JcrTyzU+yzyEaz5DJcoKbpp413ynn9kotuT/KNZq1HDO+7EzU4RS91
X-Google-Smtp-Source: AGHT+IHEjR+tD3f5onmBvKNAdZ43ttTdSjninDQiFysSI8E3D14rKPjUX1v0eti1pW9Okz7YIsxP6w==
X-Received: by 2002:a05:6a20:e291:b0:33e:6d4b:609a with SMTP id adf61e73a8af0-3522806bf44mr1924302637.6.1762476597267;
        Thu, 06 Nov 2025 16:49:57 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9635007sm875993b3a.2.2025.11.06.16.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:56 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:50 -0800
Subject: [PATCH net-next v3 06/11] selftests/vsock: speed up tests by
 reducing the QEMU pidfile timeout
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-6-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
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
index ede74add070a..557f9a99a306 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -22,7 +22,7 @@ readonly SSH_HOST_PORT=2222
 readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
+readonly WAIT_QEMU=5
 readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 declare -a PIDFILES
 
@@ -246,7 +246,7 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	timeout "${WAIT_TOTAL}" \
+	timeout "${WAIT_QEMU}" \
 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 

-- 
2.47.3


