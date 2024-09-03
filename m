Return-Path: <netdev+bounces-124600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4DE96A217
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E7F1F2314B
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B77194C65;
	Tue,  3 Sep 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZheLtAB4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F5C194A70
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376643; cv=none; b=PE6mxAnfo9UUi/GMEuziovyObtOEdkRgpNiVzMZr298SKGH6L231KtZZYIU2C9EFh5AdkIWCXzgY1PJpFiRiLguWntfA8/R6/vYhi33svGVRkSXO3D8LEM/wyssAwUmPD1vzEYM9Hzs4DRT6arEcxn2OmhbL1zToiNhn/iPDtyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376643; c=relaxed/simple;
	bh=R8+edpDYmwagWQeVrQgHze28rY4S+z2xfHY1rxB0XaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=utOFV0J9NUiDqeU2dErzuXfquiKvZTagoDCiQNFBm5dNw17ChyW1yobiKj9yAVR7aBFbM/C3RbY2j0Qp6LFMWxpARj0mLfllkk1qBzN75K1sFmRt7z+0qB09jInr9SF083MtIXoHTQ+d1dBlfek6jXASJfWCFIVx2Gy/itZBYlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZheLtAB4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725376640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ef13J77In0Oy1yANLOn5v0kFF4ZIhYD4pbTv7MvX0/Q=;
	b=ZheLtAB4r4me7CzCN0hhpOGWbQOFvr1FFuKw+hmFDDmdTvaFTKEFTm/v+mudjin5RHSlNh
	Vah5+qDbYBH3ij0Zlrws9qCObV+DnWGFKw+X3lZfiaP3TrNmqdX5+KjusMLOsPUx9qHUeZ
	ofMxQm9zr9lbT9kxwHQ/KC2VnA9fahs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-jpyz-WQHMaOMYGn0qxWY4Q-1; Tue, 03 Sep 2024 11:17:19 -0400
X-MC-Unique: jpyz-WQHMaOMYGn0qxWY4Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42bbf928882so36378515e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 08:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376637; x=1725981437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ef13J77In0Oy1yANLOn5v0kFF4ZIhYD4pbTv7MvX0/Q=;
        b=Hn98VqK3FDu+GGRC1xKKxfyo/yzieA9/WgIOmZXM7hqMTL/1Hxsoyoi1vhDUVzYBmu
         xtQunNe2mp3YSRLueYPf/ILMTioH+3OtdRn4x+KHT/NazS+1ChVAueYRaWXcQ9fOCg00
         LTjWYw/TJQsIEUMg5s3/9vThcMRC1wsHPoMIheSi+pgGMrmhMlkSacn7pGoWvmkq14gw
         f6RQ2YZK+bmq2tSESUBU5Z37Uues+rtWHNilznIKON7S/z2Ix83X7kBI9+4pRf/rZL/2
         xzC9rvnAKUCF2Xl/UO6p2bGXnhEQdfl3a+Jbn5OIBOd8MMmThzmG0YyfZqvFQW9MN0Y3
         8ACw==
X-Gm-Message-State: AOJu0YyPLcsuxd41HrRerTnbQriehxnKqUxYCvTZFTZQx5EzrwJp0L0q
	tomKjFJzEg8AEtOF8Av2L6c7rP2+z2AOOf1OdGoYOvYEzGrEPJ1ezRiELMewdp/8eRM04j5prev
	M+pX8Owbazgr54onL7fn2j6Ityx7TnFa4YwHn53IUb/6yd3tlWJTJEhIq+psrxuAErNU2eA0xcd
	HewYMet+1BuAbur+/7dbb4i0gogaFJbXtUkpo2Bg==
X-Received: by 2002:a05:600c:4e8f:b0:427:ffa4:32d0 with SMTP id 5b1f17b1804b1-42c8de9de03mr8644005e9.28.1725376637372;
        Tue, 03 Sep 2024 08:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsjQZleJpbc0dFnwMLWnHJdAjIr55X0Ahhnozx1XLzBLAiD9C9dSvcS/aSOR7fPLSXW7Dukw==
X-Received: by 2002:a05:600c:4e8f:b0:427:ffa4:32d0 with SMTP id 5b1f17b1804b1-42c8de9de03mr8643645e9.28.1725376636613;
        Tue, 03 Sep 2024 08:17:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:a105:b900:d44e:f792:896b:1223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bbc87773fsm136202295e9.0.2024.09.03.08.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:17:16 -0700 (PDT)
From: Ales Nezbeda <anezbeda@redhat.com>
To: netdev@vger.kernel.org
Cc: sd@queasysnail.net,
	davem@davemloft.net,
	Ales Nezbeda <anezbeda@redhat.com>
Subject: [PATCH net] selftests: rtnetlink: add 'ethtool' as a dependency
Date: Tue,  3 Sep 2024 17:15:24 +0200
Message-ID: <20240903151524.586614-1-anezbeda@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduction of `kci_test_macsec_offload()` in `rtnetlink.sh` created
a new dependency `ethtool` for the test suite. This dependency is not
reflected in checks that run before all the tests, so if the `ethtool`
is not present, all tests will start, but `macsec_offload` test will
fail with a misleading message. Message would say that MACsec offload is
not supported, yet it never actually managed to check this, since it
needs the `ethtool` to do so.

Fixes: 3b5222e2ac57 ("selftests: rtnetlink: add MACsec offload tests")
Signed-off-by: Ales Nezbeda <anezbeda@redhat.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index bdf6f10d0558..fdd116458222 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -1306,6 +1306,7 @@ if [ "$(id -u)" -ne 0 ];then
 	exit $ksft_skip
 fi
 
+#check for dependencies
 for x in ip tc;do
 	$x -Version 2>/dev/null >/dev/null
 	if [ $? -ne 0 ];then
@@ -1313,6 +1314,11 @@ for x in ip tc;do
 		exit $ksft_skip
 	fi
 done
+ethtool --version 2>/dev/null >/dev/null
+if [ $? -ne 0 ];then
+	end_test "SKIP: Could not run test without the ethtool tool"
+	exit $ksft_skip
+fi
 
 while getopts t:hvpP o; do
 	case $o in
-- 
2.46.0


