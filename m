Return-Path: <netdev+bounces-236575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB8FC3E0C2
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 01:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAC404EB8E0
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 00:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7601D301498;
	Fri,  7 Nov 2025 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtWXk78j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647972FD7A3
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476605; cv=none; b=bgsAtgAzm+fiN1qhzJpWYgNfCa4icIABSwDTnya2PJRrCt7XEIqISpi+dVDv2o0UFEfhv7l4Bl2Gy76vK0YaoQ+V5iD2aq0mKO9v3mimnN8qVNVLZVZgP2uEYtBCNixdGcwwrUVZl/5fRE9u/mCPtcOegJ2ZNPpNcttssHKFSt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476605; c=relaxed/simple;
	bh=iMU473kfbxLIfx41vDd7YtatXvonwJ3nvGqIOn/zk5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kssXzk0kYXa4/NnfM8VNYoSR4VfraYb7744qJ6RIWtpQ1ZcWGaTB8Be2SX8qKIoE9JYZoR8ncqzw8UmARxSn3ZqdJ9rANlaYQaNlGfz42caKvbS4fmohzl18ZB1+byUf7ABM+nd1niaBOBa3ABwACHn9Wu+UG3AsnN6kwgbT/j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtWXk78j; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b593def09e3so131986a12.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 16:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476602; x=1763081402; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uegf6nxs6P81Dwl5DQm2UBLSV3f9YHB+8bNv996m32s=;
        b=RtWXk78j34yrafHbvKJq76DRJx2KD3ljRmGfybDyf+nVnQLpDf/QfXoN0MEDTd+JMo
         h2AFksiRxOdEIZTL3VpL+fGzwjiCtJAWWjLhEFR3L88neL+bgN/9cYVkCMGmMe8AD7JK
         S+0eg+k6M3LshYM5/m+i5PL1Zo4+XiYE+kiSiyruhmjnhEYiNaK882XAVfX3LG6cpzyA
         gZP3uaRSMs1fV9s6QrGD0byqN+7YKIl8ruouw9CI4eo8CTVSmGcgueaL9Cut6m13ZKC1
         Gynp7APdpH/+ZxqvpPeLoPQWy1+DdcXfqTXj8HiN5mqxPvtPL0XHxfYbLheOvBJs/Mtv
         sr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476602; x=1763081402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uegf6nxs6P81Dwl5DQm2UBLSV3f9YHB+8bNv996m32s=;
        b=jW/glgadB9uYa06szxfTy64/v/nv+J94T6ozYiH1hnd3xXTjHb/SNCCOd3abK3l2y5
         6xIJxcq8fFnjfSVk7zsC0sMcPqogwFd4aIsbLuUYfm7eJWjm6UUlA7L0ubtomtH5h1P8
         Z+xWGOxPU0/B9bwVllj+RZT2gad2OfE1OiQXq+aUCZvUAWXlW/n54uQLdpuGGTrBrq8T
         zoJSrBqoyiyEtyBAFhn+v4npLulnsPIITgsMDpa49TgqEUinoGi9e+PeHmjU6wCaq6/P
         lHThGNTi+I7uO1gJ1Bgxa2wCDT9F3UBkVJsDW2QCSN/Avi1jlST1ht2mrzLop5BuJWlt
         6O2g==
X-Forwarded-Encrypted: i=1; AJvYcCVtHe9OqGuS1MizXzIvl77a1AgMlKuZibWgC+VTVL1fzT7kiEQ+3LvSaADu44hm0qqkepuXWZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRKoeqL5ch2KdTC4Rjhxs3nmhO86yu8YNQ6Ua+27A2dTdYYJ9w
	eveoxsGGnKoVS+qdHNGR//Sx6kj1i1MW1aYboahk1IolSFNO9Ugh9ntOylFqGw==
X-Gm-Gg: ASbGnct6MBg7sY47mr95EIk0iZOQwxS89Pgrin/uAhfqcW2n/grL+nLw8Nptczbst4g
	hqCXEj9OPttzS3yY1UdGQuOogqFP6r4rw/Hhnlq7sUo41ypglAk8UuLxxkSUYF7xH+HTZanNe7b
	1oIWMEfjjcImQSgtWA9l8OJx5fgAS/qF2CoJLqMU6kXfgZ2woAJ5MGvW7zrC9TKH3EpGQCuYm7Q
	9BkZxrbAQBuqH4GspyzkWZJAKgPxt6/W0wmVbB3sv/RSLaXKzo+9UG1HrLmKHoZUp2IT6ZD0hYN
	cZJStQgRotdTFu3NEvjdt4jQH16uBhetU+zWUz+UZrWoGcivpYVy9lZ5GiJdSyCLOBypyo5wXoT
	QHLfb2R1GdncEmTMXZLZsK+pqhyxlQxOOHNdN2PIqlpesYMzihC0D1k6kxQKkPB4lzW4vE5rV
X-Google-Smtp-Source: AGHT+IEn4ofaJtpDiBFAzxzfLcnblypBsnuT/tfNp8v2pmgiedvOY3KtH3CWotZWmHCTlxnnmEILUA==
X-Received: by 2002:a17:902:ecca:b0:295:a1a5:baee with SMTP id d9443c01a7336-297c03d28dfmr16719935ad.4.1762476602405;
        Thu, 06 Nov 2025 16:50:02 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c778a5sm41166315ad.73.2025.11.06.16.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:50:02 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:55 -0800
Subject: [PATCH net-next v3 11/11] selftests/vsock: disable shellcheck
 SC2317 and SC2119
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-11-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Disable shellcheck rules SC2317 an SC2119. These rules are being
triggered due to false positives. For SC2317, many `return
"${KSFT_PASS}"` lines are reported as unreachable, even though they are
executed during normal runs. For SC2119, the fact that
log_guest/log_host accept either stdin or arguments triggers SC2119,
despite being valid.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index cde048bd7fe6..bda1ad173ad1 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -7,6 +7,8 @@
 #		* virtme-ng
 #		* busybox-static (used by virtme-ng)
 #		* qemu	(used by virtme-ng)
+#
+# shellcheck disable=SC2317,SC2119
 
 readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
 readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)

-- 
2.47.3


