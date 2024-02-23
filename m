Return-Path: <netdev+bounces-74282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A9E860B9B
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 08:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7844CB2187F
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 07:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026B414ABA;
	Fri, 23 Feb 2024 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BukmOH06"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C8414AA5
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708674785; cv=none; b=L4P5aeBnPUidp7jpIAE3bJq0JN3WWImiiRKnYdgY5JHbhhg9CelhmrSbQxlvXlWmiVkY2OBQyDEmTkCP6Buo1GkJN6A1MMqsDo3c5ZfrGi/x8Bd+AoG1QhO42Fj4LZvkqAIJgsJQdrnfJnAnm6Or9yGXU7tyCbtkILR4utsHiWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708674785; c=relaxed/simple;
	bh=QUX8DqWeykjcfg31FvgotCT2oYSrtBYqxl3/DdWJckM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZWUmKPG+uYUEvuuwFObkP2a8m3NbwfeLE6rTwdr5UGYHdCnxePu072FgzZNHMvzZO0/DFp4AU1417cZodwWFvFiMd5WZRLVquudMJe7jfXUndOZNGODTXAMx9kftXF35pVYBQkvzD6fHJxPS1Spmc9XDMzpak80FyoibYtLSmg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BukmOH06; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6089b64f4eeso5617457b3.2
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708674783; x=1709279583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aG2etNPNi+Cimvi72rKDNoK5WNXlkodRkWP3+rJcOfs=;
        b=BukmOH06KuXONhUERO3gj4dnIGMPoJ2kjsq3z3611pnHLIaBl0EDiAhzMsHp2iPLvK
         6n3IsaH4YWM2bZlPpisByg+4L+JjIfwt92UhMVVjpD0gGlQyCGLHhJZljYB1Tnj7eOLS
         RPdU0ZZOroWW0cQGd+6/xcinAeNEB7xToY+aWNyUfc3pLmS9TmXvYC7xdfYnrUraVJBy
         BzO5eZlmv1OFLJ3hgJW97iOrL5q1CK+Xb4Nr4NBdkpupl/sD3KRloF9Swf8cOfK7d1cL
         9z4pV1zEfgObUYXsZKtbqgGIQM8JKQUzuopg4SBZCCuI1cVDr9NPm1PN54VOdP3qwP5G
         PwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708674783; x=1709279583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aG2etNPNi+Cimvi72rKDNoK5WNXlkodRkWP3+rJcOfs=;
        b=vh0ILQS5Z1pyEO5Ky5NlhnhdtI6q/CuC3oPAwRAYbrqNZO66wJQo5v/g3PhPMNFK3U
         IvSSOG5eT4xIQuBcLTG7AkKBJiMExrM75kfDfTuQ6/5xaAWqpTEIWkOxaHcsv+5p02Yz
         tOMWpOYm8Jcbhf2L8GWKYXMjq71zytcAqC2CN47lqMmWJ/LVXyerNg7ZP9iD+/C9uK7N
         ltQ1vtbJGt9FFMBGlZKadNT+WMMjQv3L9BjdYA6lMcN5YAYbfDq2cLDGJG1ljAxezqiM
         J6qVsJoxJrakPo9ZZM+p59cwTJKKXPZ0wQ2xicgt9IgmQbFqQyXaDIVLWaEbbWwo68AD
         YCoQ==
X-Gm-Message-State: AOJu0YzDJeb//Kq1ReongZnPD/D2Hgh+MRE2MF4w1UsFoJwcV8m8VMY0
	uIIdb0ynjIu8sQNWc4aP2H1cbFPap8v7y2W0raCEuzS5rHK/iFJpkShYNVJC
X-Google-Smtp-Source: AGHT+IG7DJNOXLzGDLyXFVM5dr0NijCVM+LwqKObJGrGNWXz95CegM2H9pXNfKcOo8iNmOsxJvfP7w==
X-Received: by 2002:a05:690c:9e:b0:608:20d7:90e3 with SMTP id be30-20020a05690c009e00b0060820d790e3mr1900879ywb.39.1708674782802;
        Thu, 22 Feb 2024 23:53:02 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ed33:997d:2a31:1f4])
        by smtp.gmail.com with ESMTPSA id d85-20020a814f58000000b006088c7c1e2asm987873ywb.59.2024.02.22.23.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 23:53:02 -0800 (PST)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: netdev@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	kuba@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next] selftests/net: force synchronized GC for a test.
Date: Thu, 22 Feb 2024 23:52:51 -0800
Message-Id: <20240223075251.2039008-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the slowness of the test environment, always set off a synchronized
GC after waiting for GC. This can fix the problem that Fib6 garbage
collection test fails occasionally.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/net/fib_tests.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 3ec1050e47a2..0a82c9bc07bb 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -823,7 +823,9 @@ fib6_gc_test()
 	    $IP -6 route add 2001:20::$i \
 		via 2001:10::2 dev dummy_10 expires $EXPIRE
 	done
+	# Wait for GC
 	sleep $(($EXPIRE * 2 + 1))
+	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
 	check_rt_num 0 $($IP -6 route list |grep expires|wc -l)
 	log_test $ret 0 "ipv6 route garbage collection (with permanent routes)"
 
@@ -864,7 +866,7 @@ fib6_gc_test()
 
 	# Wait for GC
 	sleep $(($EXPIRE * 2 + 1))
-
+	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
 	check_rt_num 5 $($IP -6 route list |grep -v expires|grep 2001:20::|wc -l)
 	log_test $ret 0 "ipv6 route garbage collection (replace with permanent)"
 
-- 
2.34.1


