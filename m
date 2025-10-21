Return-Path: <netdev+bounces-231459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F34BF9589
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58CED4FECFB
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144F52F3C1D;
	Tue, 21 Oct 2025 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+gt5wjc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F3F2E9EAA
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 23:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090441; cv=none; b=EPJFeZQ0YMcUaMJwFDSo0XFpnNwRCQo0oov4Mob6ig6FpAzjmOhY9rv4XsRTcXtsbrPo3J1InNRSa0oZggY4zrUuYiBNBUCKp34RmkfTLrKVSsfkhRC9F6peorg5JYgBvxPwDEXt6OHTBfLbHzphneLG6kD7mXPZaZgzcSpuxxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090441; c=relaxed/simple;
	bh=MF/czfrq9R+gzUXq3nakRInrzOwnmvgXgQyREpFMOsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HsKlfQVvMvSn1J8CNx0l5z28VhOdqan4aw/aGZ5Rak44Si4ADryiUnMc1wU933iOE0keB4q60vha/cCvV+5p4Rel/tJKjy7/XvUhZZALbJlmpQtCrsphQ9Skzf8uzho0qP05uCaKsq8vpWOJrtaQi91KKBeBDkt/HtSH4YRZfv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+gt5wjc; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33bb1701ca5so5349992a91.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090435; x=1761695235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6mUZMq9SVTZCVxtIiXitg02c6DGfDqdmAO69aX2eA4=;
        b=Q+gt5wjcUAWtZ1+Pa+QKWygd7P0u+N4yhjAijbU6jC2CCxufGapnDsR1Ijcr3Oi3SD
         ojh9jDqGB0Xnt1ExxkM7bqyKm9mi+xF830Wz1EgVDCSL/rsy/RoTL0qnEis2Y8ls1rO/
         pmqxqOPscZTQEs7Z942VDGmhNBd7iw2TDBokfXWzl2kPtB1n9Es0dK2F/TxAZj72N2e+
         68M+2YfrBnwaKrYKxcwcrHHhkg9gnxyf+9GvkRuJRAoXYObbpqbFd44a3bGVhfVsfsTe
         AaOiI5dmeI2ucyLa0eKl9kyned47owzg3NkYy1ZHB+n3PvC0Jdy2kd/kuntVANcluzAy
         udrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090435; x=1761695235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6mUZMq9SVTZCVxtIiXitg02c6DGfDqdmAO69aX2eA4=;
        b=e+UAOXoTodW7yXWAsphxrHQ6Mip2R5n6oxburk78ld/DMGdX2EWLLMDT93Pe1bKOFA
         n7gBZXUn84c3W7OX3E4TLZr+BYWRIjrUvOEjQYV7Er7JxI4ta4ACEhg7ApAC1WaJb358
         1qkjrQ3+vqQ9v35dBoV2Mvjsj93oLmy5Z6FsxKZ/kWt4RvXAMQgv1joBD/SJcL+1fzUq
         xIm2qW09tiL+UM52/qLBOTOfLw1IJ4cOLDOjRAPWzoD2ViVa5ooklT0XeyATN2nCOtxx
         n+DtwwBqccSn+uF6fPjTpQm+rLO8twIzYiCZcOPnpnFeQ/rG4tfM9gcX6yErZE5nnfIv
         Mnwg==
X-Forwarded-Encrypted: i=1; AJvYcCWc++lknCXTrK6l9c95cDXgWvctBmK9RrJx+pxllWUWVSE590U8IWbAImZrBdjsHNE1BIUUwbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2nA2IoR+N9EL3rswtITX5NIJaEjecKPTwhT0EbqqqK4CxXXll
	0YCd2QXe2DgC5hkh7q2nzELXMEIlmFMCeGgzQc8Jhg3AVpDObrfi2+Rb
X-Gm-Gg: ASbGncuU9h0+q7e7bq1H31GpC6F4HCbb2x7cHtwxwo2t5YzTWa+AIe7FOxjp/uCJQ1A
	merMeEWRWzTBDvw+PyTdZJ4xexO9JyRSWXqqKwe+XxSg/f+69F9Lb3O7K8FodFi4m+uP4amAmeA
	0MJg+WR0ytkChKAKn/kuWPKSwD7ttwBxUypzSwEMRLHCGj495D62ZvuLDkD7eUsMEVC2GUOIHkZ
	OBD35Agma8lq05CObFVHZGxHGI0wEeYYvZ/jMm9EKgL0YovRjDR10IeHbLLi9M60g4lotrBnS6u
	YVDKzCQYSdU8RVKvoCzACXXpP7YTxEnB5oTL2O5+dMM5SsDI+YL2eIVHdwW3J9x1UTcpbjaOABW
	xpyt2dQRjKiXMvi2Nd+BuEwWOy04OJPrMMQXZZlR0UsjV81p69lZBkrPBx+In8nRsfEgMV+p+
X-Google-Smtp-Source: AGHT+IFVbMkOuOiBDnCJEvlMwLaZ7DlmhKs/V/NW1acHbQ/gNGtWZNBni32L0tz8fkkeIan2KaLV9w==
X-Received: by 2002:a17:90a:d60f:b0:32e:d600:4fdb with SMTP id 98e67ed59e1d1-33bcf8e61b8mr21858888a91.18.1761090435179;
        Tue, 21 Oct 2025 16:47:15 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223e223esm711430a91.7.2025.10.21.16.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:14 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:00 -0700
Subject: [PATCH net-next v7 17/26] selftests/vsock: remove namespaces in
 cleanup()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-17-0661b7b6f081@meta.com>
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

Remove the namespaces upon exiting the program in cleanup().  This is
unlikely to be needed for a healthy run, but it is useful for tests that
are manually killed mid-test. In that case, this patch prevents the
subsequent test run from finding stale namespaces with
already-write-once-locked vsock ns modes.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 914d7c873ad9..49b3dd78efad 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -145,6 +145,9 @@ vm_ssh() {
 	return $?
 }
 
+cleanup() {
+	del_namespaces
+}
 
 check_args() {
 	local found

-- 
2.47.3


