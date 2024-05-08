Return-Path: <netdev+bounces-94381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867588BF4C0
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1C22B21970
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B01111BB;
	Wed,  8 May 2024 02:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcxHJ531"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797DF5228
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 02:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715136919; cv=none; b=SwvlgapAmx+rj0E4/tiIOMpqOK/txPeC8E3ucZ6Oqj+apJqgUz8T7ssXBRj6ALaMuwkJVP6/I1PMVQTtocHvctV7QzbhW6nZu34T88a+/Fq1JhEJ8PHSNNI08GFxOzfTBYxIgLXYcSUb36Le3ruIeKnR0AnWbgCsJhOVUdhOGbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715136919; c=relaxed/simple;
	bh=5HEYYnOx1rWvC8JxzgzyEOTUtmwuiuPjtOp0/3u9fh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GkGa3lvAin1sDpL84MNC8gHTZ9Q9HOZL3XkFrxS0B+cbAndRk7ooxeQzCeyD2qxQpl0jVHVgywspQ+uTl69zZRI0GgCkfdcXDXvssSargeZEQuZOWqttzf6Cg3rnBgZsP+SDJvjMKEgVKkT49K7YzubXR/0WoTeGxDGkK8BSr8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcxHJ531; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-23f29557e5dso2332138fac.3
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 19:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715136917; x=1715741717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Xz2ciojS2zCeEDcr+RfkdWWn5EoVDXXV3EssijC9cw=;
        b=EcxHJ531ynAjSWtImzvRDLJ22mFBiIuSdFCVb/GOs71e1T3dY16YdtG4Stcz4ikOsF
         wz5kp/pNs9z/RVW1lR0av6MMU0GgTSPYmz4FpFhcHHx6WOy5jtB8kkitzgwZ1pI+3dHI
         LcUuw4CgFla3KJzGNYiSEAPzofMU17TN8vKmf1h6BrXEexNCT1laF6lV/8jxUcUSQFUp
         NWbnp2fkmKIF6F9hkzvA9XeVMG/3Y/uhEgjAtAojQXWDi5D072deOcE+/jBRx4VSOLxG
         j6ni955wCL/KXlN2elbqp4yiQRHCbbC6N4GQAm2bnOaGhl9aRhiw9FcVYzrSEzEAW79Q
         P0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715136917; x=1715741717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Xz2ciojS2zCeEDcr+RfkdWWn5EoVDXXV3EssijC9cw=;
        b=Yzgpl5270QPmHCUpLEVAg5LZA4NHqYsWnpnZtOLxTN4quNY9gX7H7X19Qfor1XRGK5
         iP+r0stxfnTuSKP8uR7MB74DfMmxPG87G8HWEKu8T2BvM3NlpyTO6D+DBQga+DuilvmT
         +qz/TQhtzzrkWr/Ky220u+WQVIJg6sS22l+vswwQxHE3uryEMyKTrGprN31R4oFF+Ph6
         9Q7NUqSxDlO8YBTq3kjpRQ2eM8Y5ihajvIJ3qX4ix8/UOa9qBZN+y1XYYKuTbE+yEa+w
         GJQgpvCW2bZ2AoaF7klmrzNUSzB3MITqBG7H5XlTqccfFv6tcv6nV+nqpTVKcx5QmNup
         3H/A==
X-Gm-Message-State: AOJu0YxP29YBxnG9o1siWPWmLTgi5cu2Qb1ULBubVTf9a/tE8a9J6DPb
	DtsZVhBPnaXd+a2vwE+I90f3IyOLx3THw+cGrX1URXXkeeJQuEDCPqOlTb/CR0E=
X-Google-Smtp-Source: AGHT+IHe2n+O9bbWJSQDZP+ohMuYPPwVhzy02kGlimTAJnzNkz+5cI5rIMSrHPNJhibRvVdpxmXD3A==
X-Received: by 2002:a05:6870:d189:b0:239:49cf:d294 with SMTP id 586e51a60fabf-24098c92a9fmr1572559fac.35.1715136917066;
        Tue, 07 May 2024 19:55:17 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id gp9-20020a056a003b8900b006e681769ee0sm10449925pfb.145.2024.05.07.19.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 19:55:16 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Guillaume Nault <gnault@redhat.com>
Subject: [PATCHv2 net] ipv6: sr: fix invalid unregister error path
Date: Wed,  8 May 2024 10:55:02 +0800
Message-ID: <20240508025502.3928296-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error path of seg6_init() is wrong in case CONFIG_IPV6_SEG6_LWTUNNEL
is not defined. In that case if seg6_hmac_init() fails, the
genl_unregister_family() isn't called.

At the same time, add seg6_local_exit() and fix the genl unregister order
in seg6_exit().

Fixes: 5559cea2d5aa ("ipv6: sr: fix possible use-after-free and null-ptr-deref")
Reported-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2: define label out_unregister_genl in CONFIG_IPV6_SEG6_LWTUNNEL(Sabrina Dubroca)
---
 net/ipv6/seg6.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 35508abd76f4..6a80d93399ce 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -551,8 +551,8 @@ int __init seg6_init(void)
 #endif
 #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
 out_unregister_genl:
-	genl_unregister_family(&seg6_genl_family);
 #endif
+	genl_unregister_family(&seg6_genl_family);
 out_unregister_pernet:
 	unregister_pernet_subsys(&ip6_segments_ops);
 	goto out;
@@ -564,8 +564,9 @@ void seg6_exit(void)
 	seg6_hmac_exit();
 #endif
 #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
+	seg6_local_exit();
 	seg6_iptunnel_exit();
 #endif
-	unregister_pernet_subsys(&ip6_segments_ops);
 	genl_unregister_family(&seg6_genl_family);
+	unregister_pernet_subsys(&ip6_segments_ops);
 }
-- 
2.43.0


