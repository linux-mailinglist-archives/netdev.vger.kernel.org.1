Return-Path: <netdev+bounces-196775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3007AD6559
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 03:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C073ACF5E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 01:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9919A1990C7;
	Thu, 12 Jun 2025 01:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6mX2mVK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220B613A3F2
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 01:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749693508; cv=none; b=CcYh3JuJUi0WZK3+R5GYiuL33Sp3FQQ4nZw/eOa7vCHq4cLVrrkmgebLIJHMU3mjZyPOa1SKxIS20yWa20JJGYd7ki/R2qL7bCQupmD5X4IUHjNwr3tf9Q0lLNwrfXeGvJkfAsHD+KJk/Xm2yCPkHXk61HhGLusEJbljzNLaCjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749693508; c=relaxed/simple;
	bh=Ay5oQohGM+cVjnNWHVNcpUKrCpFL8jgt+c4zZIHKDB0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mPycgPliOmnMXkZWb6yUhkxBybK6pGNXLAvWzthGykHr2DDFO7vZo411O18kJMB0rwO/kSuVfIrvaOAYhR84zRak8P4rKsAg1wuMXXaTC6KDE7Zm+lT6boZvWNHYHyZjsoeuQoExsBKGXNIjUw6vQwKdnBhopyVuytYF77UTds4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R6mX2mVK; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2eeff19115so422887a12.0
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 18:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749693506; x=1750298306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4xOt1jqHtKfWjw2Okk5Lx4VTTX7yg4srSCqsBU9bfdk=;
        b=R6mX2mVKxWB6gmSSW1uaAXjazlZp2mi1s/I5LqGPVVXXVTcZ+sqt8UQq6Ikhdk1QvQ
         SwZVh0ZACS1s9rW1ABjJf9xGeM7wcfCD3fOmtzPmd4RGXYxdz3mHXzMUxnlw2bjXfZyu
         EhlnlgEyD+M5kY40Gv46JXEbqo9f2Run4DDZYzwI8sgLM0TGLMSWOctzkVoUxLjNpElO
         et6fclmNsz1B4hIyh/RTJgbsemdI8tNizQZZEkAcZVvzVxgvtkzmliFWPhzrcj49fsWS
         LJQvIVACfUYpZZyXDJbkXVsfWbZnlwQe8MVZKg8McW3EVkz5sh7Bwz1xNhJ++titvFaq
         wyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749693506; x=1750298306;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xOt1jqHtKfWjw2Okk5Lx4VTTX7yg4srSCqsBU9bfdk=;
        b=Vnw5eCSNi3YSNzHj21oJUA55Kx0Yqxs9KcjAi/N8eeL+dmYmDMRzByNZ3MWlzkPHKP
         +mm2qDrvzxLkLVWZ8e0dtDpbO/5PZJRWYJfwYOVhVQIp8yjXJNsZsyuW62G2yXrbOvTO
         ezEBnrYHdqUZ2d7ZyZKKJFlP2fYz3Mlurn++uKqdrSmO7+Jsi/J9oDp0RzEzZnUOsuog
         8TEFSaZmibMrVCpypKhbEUtXFNEfeaYq2HG6dJ292+QFBMupkIdxR0GlCV7jNe8HyRdD
         HsL0pv4sQe4acdn1sKa6ziOmCC6ksa372d4BC+E3dzIWSocs0owFDsNeomqnLyMzx6zO
         ylGw==
X-Forwarded-Encrypted: i=1; AJvYcCVjMxCzmCjTXg0sV/xizt5vM05Uw5l80MUy1qnh7Gx9ksNbXQ8hzx4vTZGFbIVSxRUW4kehlIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ay87x5AeJSZkb+mhKHn0Db0aebxJRG1hw8IUICDHU4TfMn2C
	c45CySHVaYiCaEm58/aFPlX7F2ePN2M3smMotqz3rprCd4uZ12gkJX+cN2hUqOUR/Vx3xqi1ufA
	qcctGFdqU9hV3K4v+ZXYqOtjmYw==
X-Google-Smtp-Source: AGHT+IH0xuhQyu7PzeBD2lZe2ItcmrlnVX8CKI5tsgo+GqBtt/K3hLGGc+yQSmUUI1O0fxnFPA7xdeO7SO6ERkuafg==
X-Received: from pfez22.prod.google.com ([2002:aa7:8896:0:b0:746:257b:1d37])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:a60d:b0:21f:8817:f695 with SMTP id adf61e73a8af0-21f8817f6a5mr4714343637.25.1749693506379;
 Wed, 11 Jun 2025 18:58:26 -0700 (PDT)
Date: Thu, 12 Jun 2025 10:58:12 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612015812.2520789-1-yuyanghuang@google.com>
Subject: [PATCH net-next, v2] selftest: Add selftest for multicast address notifications
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This commit adds a new kernel selftest to verify RTNLGRP_IPV4_MCADDR
and RTNLGRP_IPV6_MCADDR notifications. The test works by adding and
removing a dummy interface and then confirming that the system
correctly receives join and removal notifications for the 224.0.0.1
and ff02::1 multicast addresses.

The test relies on the iproute2 version to be 6.13+.

Tested by the following command:
$ vng -v --user root --cpus 16 -- \
make -C tools/testing/selftests TARGETS=3Dnet TEST_PROGS=3Drtnetlink.sh \
TEST_GEN_PROGS=3D"" run_tests

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---

Changelog since v1:
- Skip the test if the iproute2 is too old.

 tools/testing/selftests/net/rtnetlink.sh | 39 ++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selft=
ests/net/rtnetlink.sh
index 2e8243a65b50..74d4afb55d7c 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -21,6 +21,7 @@ ALL_TESTS=3D"
 	kci_test_vrf
 	kci_test_encap
 	kci_test_macsec
+	kci_test_mcast_addr_notification
 	kci_test_ipsec
 	kci_test_ipsec_offload
 	kci_test_fdb_get
@@ -1334,6 +1335,44 @@ kci_test_mngtmpaddr()
 	return $ret
 }
=20
+kci_test_mcast_addr_notification()
+{
+	local tmpfile
+	local monitor_pid
+	local match_result
+
+	tmpfile=3D$(mktemp)
+
+	ip monitor maddr > $tmpfile &
+	monitor_pid=3D$!
+	sleep 1
+	if [ ! -e "/proc/$monitor_pid" ]; then
+		end_test "SKIP: mcast addr notification: iproute2 too old"
+		rm $tmpfile
+		return $ksft_skip
+	fi
+
+	run_cmd ip link add name test-dummy1 type dummy
+	run_cmd ip link set test-dummy1 up
+	run_cmd ip link del dev test-dummy1
+	sleep 1
+
+	match_result=3D$(grep -cE "test-dummy1.*(224.0.0.1|ff02::1)" $tmpfile)
+
+	kill $monitor_pid
+	rm $tmpfile
+	# There should be 4 line matches as follows.
+	# 13: test-dummy1=C2=A0 =C2=A0 inet6 mcast ff02::1 scope global=C2=A0
+	# 13: test-dummy1=C2=A0 =C2=A0 inet mcast 224.0.0.1 scope global=C2=A0
+	# Deleted 13: test-dummy1=C2=A0 =C2=A0 inet mcast 224.0.0.1 scope global=
=C2=A0
+	# Deleted 13: test-dummy1=C2=A0 =C2=A0 inet6 mcast ff02::1 scope global=
=C2=A0
+	if [ $match_result -ne 4 ];then
+		end_test "FAIL: mcast addr notification"
+		return 1
+	fi
+	end_test "PASS: mcast addr notification"
+}
+
 kci_test_rtnl()
 {
 	local current_test
--=20
2.49.0.1204.g71687c7c1d-goog


