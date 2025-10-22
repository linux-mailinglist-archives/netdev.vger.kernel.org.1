Return-Path: <netdev+bounces-231455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B41CBF9538
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E14094F6E55
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952A52EFDA0;
	Tue, 21 Oct 2025 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HszNB7Zm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB712E88B7
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090436; cv=none; b=R8eeFcei0Zj6HGNJyVkvrDsZGRj6lKPIT7wywvOf1ceJk68QGwJNJu4DlggkSovxqIKmNyS6pkr7se7z4l6R3k8pzSFliyo4eqEHy1HHUobYmFctdRh8mBD57pNgpXtInclAxVaSUenXhx44hF9o1EKj0SJ7hmFHZlK9Vx+jpPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090436; c=relaxed/simple;
	bh=Ah75iXsh0T8yhCIpU6zRS0eJQetFgIMRMgUlS91SRJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qjYSWlaCbndNuViG3ueEqokw31EgAPOVBat7vsUSm9rWbQWQxbs9VSxmrIXfXtMKSKUDligjwP/Ds+CWF5xQvTLN+y6Ei3/Mdm5fZXhnUS8+2T8KBYsBY2eqlLJL/t9CCg/x0QlqTm8sNfRmeVnrIeMUwP9NUFR7yjTY+MUG+jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HszNB7Zm; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-78118e163e5so388582b3a.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090431; x=1761695231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnzs2zs6t5aqxB+IKVfd3RCQCLiGKiLLTWmUAKIpb/I=;
        b=HszNB7ZmWL1j0OpgxNRQ8G5r/LEmWqQPTqK/vSouCT3KFep+YG5xltDqXPiMH/E8xQ
         Wivc7hlRjGXZwwWu0MPONn0MTOV7qtYbeTaK5JyETTZULIPJUIDLwLaI/PUsUH3zlRqQ
         v5yN2FH5/bN/XN7IMV2mNwIvFmZNKFYAHPXGFEBQFUtb4LOKNZ0VS590DPlmSXtjszy0
         hSQWxOvH6di4vL2oWH8m/T5v04ylrdNiGHexQNgWEcjNgn81rH/kemiXZd5G2WSyLXdC
         Xt4aEmQ5EVEKJnOHcXbUASObth3aqKhmxlfCudv+D4jOhZDRGJZ5Il5G5RIevnAir6qf
         KDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090431; x=1761695231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnzs2zs6t5aqxB+IKVfd3RCQCLiGKiLLTWmUAKIpb/I=;
        b=cUViTgUbI1WNNBWUmkCGQF2Ya4FnXupid/y1y4WtgLMJVMKSpnPZBxxBSQx+5/JEh4
         oBMpsnRt/OLZ6KF51A3+f/q176l6nE+QY9u2um/nWQI/Hc086JYyHFSzCBhSKOwPTzbO
         9tBgCfm45U+PoahYCLFXypxh154F6tG0Ayr+KVLI8UIkyiF3QrO9k4lbfdlPoo/q7pMC
         yZZoxkg2I+B1OBYn0bocaEelFJ3ysZY1J00mKrnEGzV4uexBlBH+nkwMdBcaFRHqSRIH
         FHow/P/wW6/I5m8STB1IfzcWGuhaTu5JRzgtFeNe17sE9yQMT/tABn6bZ2f1TSU4uQnc
         Z8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYMqJwsMrIwl6knAo/kNw1pS27YT8S+5TZ7PPbgVXm6l5aJaImojPpuZBBO7T+twySFmlCmwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI6XZaVuSOc32ImXkCf2KGMi9R+4mHxO7e+PQhTjLm3Gw4oCcr
	r1uQy3CHDkEorArj7ONaGKCSSM/bgTMIPvZQfkOv783+XxxZek2u+H3q
X-Gm-Gg: ASbGncszugwpPQ2kOV2dZprMYRIZPo41DwZJCnlohMXoWxNbNYSKQDfIVlf8lYygmGk
	SzE9qz1I/2jEZ9t73NDlv3mEkQtgbx3HKnUM5tTsVXZiMbhI8iOBZuYRjHKEhArAlwOIv+ejBP8
	nZDmVd3UH8Kb8ahFNrWIt8bguVhZL3gbda585XpdygJtWlv4ehxuc/IlKYp0X+q6bEA3tBx/eNF
	yXgWC0MkFaaBDvKsKhoXerKPdW/T83gWDSwcR0/gwvEXHtrMGym/qWLc0MErTMA+wPpeDfxecv+
	xHMtp48OQze1XsYwhPjcT7tgFPsgi6YLDIaSEvPWEp7VMjsgwDT7aQlrkYiyM/qCyhaGkNluyR+
	hTZdnDWHaAr1L2/HrQ5lnxxitRpWlrqQ73Yla8RQyX1Erjmnb6UMdPw9oJW1DUMvu3tFhpfsvSt
	6ey8nKnf4B
X-Google-Smtp-Source: AGHT+IFbTUe9F4h1LyVbUwgCQ1C/DV9vJaiYH1suq6bPPsdLXWTdUfcRVma8kaGj52ddQduYiLM0Cg==
X-Received: by 2002:a05:6a20:6a1e:b0:339:7f7c:bce5 with SMTP id adf61e73a8af0-33a9fb9f872mr2206937637.9.1761090431314;
        Tue, 21 Oct 2025 16:47:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7664b30dsm11118178a12.7.2025.10.21.16.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:11 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:56 -0700
Subject: [PATCH net-next v7 13/26] selftests/vsock: speed up tests by
 reducing the QEMU pidfile timeout
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-13-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reduce the time waiting for the QEMU pidfile from three minutes to five
seconds. The three minute time window was chosen to make sure QEMU had
enough time to fully boot up. This, however, is an unreasonably long
delay for QEMU to write the pidfile, which happens earlier when the QEMU
process starts (not after VM boot). The three minute delay becomes
noticeably wasteful in future tests that expect QEMU to fail and wait a
full three minutes for a pidfile that will never exist.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index d53dd25f5b48..020796e1c31a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -22,7 +22,7 @@ readonly SSH_HOST_PORT=2222
 readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
+readonly WAIT_QEMU=5
 readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
@@ -221,7 +221,7 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	timeout "${WAIT_TOTAL}" \
+	timeout "${WAIT_QEMU}" \
 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 

-- 
2.47.3


