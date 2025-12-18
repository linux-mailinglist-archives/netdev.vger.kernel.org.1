Return-Path: <netdev+bounces-245341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B405CCBC5B
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 13:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D95A306450B
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 12:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D29A33031A;
	Thu, 18 Dec 2025 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GEOah9fQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B19E3112B7
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060452; cv=none; b=EeXxzZz1uGfX5H8lExG0WR3IYO62/rYrY6fJ/F5wsiTUAN9sPhQNMa3czHsHJoKPFmmVOD9b9Cd1MWX8LRdF/ovfxIkzECJVMb7z6Pqjg74IomdWlEZFB53b8ZGrFLSh+BL9u0yXiRbQvQvS7OQw4t+k3ny3yKMvXRKQtKPPe1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060452; c=relaxed/simple;
	bh=eqWfnJs5Nkyp4m7IyP9pYSN9uMnPtwxT8RsY0+GP4VY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Gb5ehnma3YB3cEBNkApcNfRs0j3cIZ4davTYUdw8j9YMUR/BzYq6uY4hHKUj4OOdSVFkLwumSA7qLQRZ2+0sFTEggxXP2lMHqf8Y71V7IySgXZBTrKsLipQUP8T/W7p7FBOLKHGzPcmdK8XKdF+mAppSWy82YBCuZ7g4Wup6lKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GEOah9fQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477770019e4so5040985e9.3
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 04:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766060447; x=1766665247; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wuu/9levDPlYSlKVd9Fur7NXuw0gR2L70X+lgum0qic=;
        b=GEOah9fQx6tCczsjmnsRvH6Sq1zevyhdQHPIoQe+H8kMRlbcY4y55Xcm4vvn52vBGJ
         gP74aoZWWtqVtUOTNZa+qzhzWguRX0AuvVy1g4gr9lioyU7sgfmLUT3kVdKEHgI8NfM0
         fCk41sm5nK3XTn734u9Xv3EzQhLVX0YUh702ftfx1h5iF+tPRM1NxG2cd1UmN46oJ/nv
         TAiYRFeoqrD81IRNNpAz8JI3rO9tJjBImLtlaIBQu8vXi8vKVLKgdt7rrzoGlJ7xK95C
         laf3vCVN3HyVhmI4AAAPjxGJ4r9h3orVi+i77x3oqJFq2CQSwmCCrt+ZWQYefIefBJLW
         vB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766060447; x=1766665247;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuu/9levDPlYSlKVd9Fur7NXuw0gR2L70X+lgum0qic=;
        b=drPTngjSMy9g4pwLTWYIZVaL1DEAGvJ0psSwD5UxRtHhnRkev0whTXHYpxawOoJzsK
         zdt9Zz8lOG7bVwE1UlWEEoPTYVsgdmQirrn12/tx07e9XXbVDHyTJ37wM+naZt3olLXR
         4SBDy+JDvgRxKUMQnKc5UC1m9REWNLT0KZgIv27Df5pn5A2QchZ0c9a4VsH+mZIQRAC8
         05202RFa+iXy7/aQFLXElIyBZjRZQKeswEz1VTvBGomH6Qp1/Rw5cnOUFeuWydJNUou3
         sJMM+vmQ0MBAfCMb7SrRlQEo9UaNpvpyppzZCwsj2Y/7dqVGQ+V6cXWXIB/5073AHw/v
         ZLmg==
X-Gm-Message-State: AOJu0Yz+SiSfD4y6OtLKxkN9PVcL0kXHnbVP3NRa6HsDTfdv7hdt68Vm
	4GclGEBqVWXVjvw8K1T0Jf8EVNeCsvOgETVMFwf/5RA+RbhihYKGNnzmWlosUF2hcg8=
X-Gm-Gg: AY/fxX5aPXQ8YViPJO14UJR484wVJiv3GZo0VVM2U5M680fIOc6gTC1+0bF4+YHTVJe
	NfOg5f8HN3VaF1BU14se++m0V4XD6mxtckxjIvlWc/ZHlOsThYtfK76CN4kFIII6QB5/ubkh9dQ
	CT10HDeCM7xOuMY4f4SkIWlBEgM9M+07RrSrIuSgn6bzxOf3bf8NpMbcAMjkdLJvLkr3dAuyqKJ
	SBGkndP+DgSbHdAeLWZRp2rZ9RtYPm341tVjbYYcJ9aIfMK7gX3UEB/jsBIHexhfijjVNgwsfGZ
	d/dA7a9W9DdTs5k2+HQRRkPFRhA0tC5Bfvl3n/rBPFwS7iVIILofesNAo2nJ7s+UJ3/P4x75/vx
	b0156htVdrZgFmP8Cv87IDby5ZasGuM+d/v2J+V5YLdrArOD96tgw6m1c9o8uUEGfAgKvq6upRx
	LBWJpQPyVk
X-Google-Smtp-Source: AGHT+IEr/bRmp5KcFfglYPWmyPlODyDNlJSQrqglf/bIH/Z29sdsWPV0Yl2SsVXM067fiAB8ptvMVw==
X-Received: by 2002:a05:600c:8119:b0:477:98f7:2aec with SMTP id 5b1f17b1804b1-47a8f8a7170mr204341295e9.3.1766060446631;
        Thu, 18 Dec 2025 04:20:46 -0800 (PST)
Received: from localhost ([177.94.145.206])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d1926bbbsm23985425ad.84.2025.12.18.04.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 04:20:46 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Date: Thu, 18 Dec 2025 09:20:38 -0300
Subject: [PATCH] selftests: net: fib-onlink-tests: Set high metric for
 default IPv6 route
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251218-rbm-selftests-net-fib-onlink-v1-1-96302a5555c3@suse.com>
X-B4-Tracking: v=1; b=H4sIAJXxQ2kC/x3MwQ6CMAwA0F8hPduETdTFXzEcNuikEYppF2NC+
 HeHx3d5Gxgpk8G92UDpw8arVLhTA8MU5UnIYzX41l+cdwE1LWg050JWDIUKZk64yszywnA7x7F
 1dA2hg1q8lTJ///2jr07RCJNGGaYjXaIVUtj3H7stk+GHAAAA
X-Change-ID: 20251218-rbm-selftests-net-fib-onlink-873ad01e6884
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1766060438; l=1249;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=eqWfnJs5Nkyp4m7IyP9pYSN9uMnPtwxT8RsY0+GP4VY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPIVTvi1oLN0+E1MRxeTxkrwrHq7Xr8Kao+vd5IEiitItPC9ZFQi3BWwYS3/2bE+X96wdK8Hgvj
 RdKAgndcd3w4=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Currently, the test breaks if the SUT already has a default route
configured for IPv6. Fix by adding "metric 9999" to the `ip -6 ro add`
command, so that multiple default routes can coexist.

Fixes: 4ed591c8ab44 ("net/ipv6: Allow onlink routes to have a device mismatch if it is the default route")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/net/fib-onlink-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib-onlink-tests.sh b/tools/testing/selftests/net/fib-onlink-tests.sh
index ec2d6ceb1f08..acf6b0617373 100755
--- a/tools/testing/selftests/net/fib-onlink-tests.sh
+++ b/tools/testing/selftests/net/fib-onlink-tests.sh
@@ -207,7 +207,7 @@ setup()
 		ip -netns ${PEER_NS} addr add ${V6ADDRS[p${n}]}/64 dev ${NETIFS[p${n}]} nodad
 	done
 
-	ip -6 ro add default via ${V6ADDRS[p3]/::[0-9]/::64}
+	ip -6 ro add default via ${V6ADDRS[p3]/::[0-9]/::64} metric 9999
 	ip -6 ro add table ${VRF_TABLE} default via ${V6ADDRS[p7]/::[0-9]/::64}
 
 	set +e

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251218-rbm-selftests-net-fib-onlink-873ad01e6884

Best regards,
-- 
Ricardo B. Marlière <rbm@suse.com>


