Return-Path: <netdev+bounces-74285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D30860BEC
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 09:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAEDF1F24DBD
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96770171B8;
	Fri, 23 Feb 2024 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKYUTNvJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069C71756F
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676042; cv=none; b=OeeVU5lJPdDATsZJjqfz8wEXiyq58zVwMtLAX598g3cILFCDuf//VN/br83KUFU4eeFTuhzHDWnj/3wLK62mRWj3VJszE57eJ5+qaLNjHViT6mWfcu5fRmz8fmT+ZpaUIi0GEDiby1GQa5PxqStScbRLUT9E6KBKwq/5fpLlfgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676042; c=relaxed/simple;
	bh=QUX8DqWeykjcfg31FvgotCT2oYSrtBYqxl3/DdWJckM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QBTKlW/O1yAk6oIvVgC9n7Vy8q3i2KOQiwuWdEpLJU3g8DCsL41p247anCFofvZtfEfqBKGhuPiBr3rFSOTkih6khyXgIohjWHWBUDLZSlhFZvjvavT8qqUTF/y97ZD0shZ/CmoAgFCiweYn6gvrmVXrBMDILQIZ8X5Q38z/RME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKYUTNvJ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc745927098so499880276.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 00:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708676040; x=1709280840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aG2etNPNi+Cimvi72rKDNoK5WNXlkodRkWP3+rJcOfs=;
        b=eKYUTNvJLZaEOuIWiFi3kO1EalZO/lgzSkQ9FZl78rbdy4m9V7E8K4LzXjtK+jIR+6
         JQM4YkPvYE0s5cEngNdkNrhLOuphk8WV/CE4/Df6HSdx0gBk2MzNhszhkMIhs2lN24BE
         pxrJFjm/Jha9vN3FCPGGEFu+yproHOX/b4gEg4suW6JmN3CoZfPnP/zsTGvb3dh7CPmg
         qmz5xbv4/ErE27woyt5FYe6O3EA6sgqmMIc6rboRB2BK9PRXJpjPYtxEvFjtMvKvd7Ya
         uJExX2dWs2BIXe9586WmSfLHKZdnB0ZnGqB+2S45S/rS4ZBip/HR8Gf/+ESH2dbNHUg5
         xUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708676040; x=1709280840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aG2etNPNi+Cimvi72rKDNoK5WNXlkodRkWP3+rJcOfs=;
        b=NcVoAP9gEl3IzugpErNC+3xq6N9e9nN1sybqBiew3TJWlhxtE+U758ngt/pjrqJ4xc
         iac9ztJtp1slZFoi5by6aF81BAvCGow8AQ7wWzWmkVYOAGVb+0PfxvaNaNfwik6iiOLy
         pv1fQ7TBcBYrH3OruNYVHilicqLKbewwXkuor9l7fNeZ8aut2MuVP/bulcbrHu8weGFT
         QcFW951KflqMqlLiQjb8R4yadnIfFNoGZqIgNxacUmJ6AVa+lWsmvwL6q5gs1ecjO5BO
         bntrFDi6MbwN58X0w8A0ZF9vRhAKwlWGNf0GqYvTsvTDgXpVYNOkC9Up1ZAVARrbagzU
         q+4w==
X-Gm-Message-State: AOJu0Yyo6mGyj5f6+6uKkGInwFzCVE6lZSVnIJBC9vV8NQXQad9blz+Y
	w1gq8N+xoTBiUIZzGFCyPnK8j+II58K2wmFCp4RP5V9kdRlEhduW7QsUXLc3
X-Google-Smtp-Source: AGHT+IHXrkQTIRFRjhT65qW2sWG9r0GQoEkcf4OIaL3vsbEtyNrgG4FHayx/isL0MlF2S5ddGZs0/A==
X-Received: by 2002:a25:8190:0:b0:dcc:1814:ace9 with SMTP id p16-20020a258190000000b00dcc1814ace9mr1205307ybk.28.1708676039580;
        Fri, 23 Feb 2024 00:13:59 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ed33:997d:2a31:1f4])
        by smtp.gmail.com with ESMTPSA id 2-20020a251502000000b00dc2310abe8bsm3250461ybv.38.2024.02.23.00.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:13:59 -0800 (PST)
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
Subject: [PATCH net-next] selftests/net: force synchronized GC for a test.
Date: Fri, 23 Feb 2024 00:13:46 -0800
Message-Id: <20240223081346.2052267-1-thinker.li@gmail.com>
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


