Return-Path: <netdev+bounces-134049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB6C997B95
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 06:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B321C2165C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E368319413B;
	Thu, 10 Oct 2024 04:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INH+9RrC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E3419AA5A;
	Thu, 10 Oct 2024 04:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728532858; cv=none; b=mPfDW6MfRwiMQZ2sLgicRN1eplkFvA0UGHs8Vbmv+ZGdVJlsDz20+DvDyAHMCpNOvtalBfbu0ZuCNCJX1eFDh6ebcsDOykQPXyoB8GuLNJY8h2zD7M64KiCipVXv9S7XMPswlMdczkwc+CiTvvG0MYNFlTXFB0bdWnUh2niEuqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728532858; c=relaxed/simple;
	bh=POE/ZNcaKi7AQv6OZbHnFeOggVcp+v2NoAF/IV3rDUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHDzcju+XO+9vWxFjeO6nKqKbSRL+8+Sw0gQVswtwHEy91HRXVtRcmtn7Keq2wUmiU8cxPG1nW+RSzd+gDcz1x9PoKsbk/MpPThX6r6//nEgpSGKPb1lRDztr5aRAd26NR4ynjTwakT2UlCyHhgCt86AT2USTOqI+28TMyNpl34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INH+9RrC; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71dfc78d6ddso474508b3a.0;
        Wed, 09 Oct 2024 21:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728532857; x=1729137657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWIzD1VrGPIJLaJktHrn5QN9bD3hbWPe2noYoRb587M=;
        b=INH+9RrCjQj7g4i/ojTcYHoujDLkMJHHXsEIaiTQeusbR1lR5U64d5wTvhp9HvDX0C
         0z2RYpXtbSxFAOddbgz8AUCQWUu2VkuJ0wg0dskNO3cGMLBDN3DPSS5VK5qMyP4WOv1v
         8Vp1jxMxZsa4ck7nFKFPzk3tm7dN0h4HCgoBOwmVd2h7+jwiaRn3PsP2RL4jBD8ns3Ee
         j12N8lk/G//0QQXqu1qYbMB0c0BIDvTXJZHT6rJJsXYTI3KbejUC1LZnJcEkigfwVXg/
         t/5kxy3d5Y34jC28BC2xvj0O0OCTdyQ9V/5Lj9j3sV4u0wfHRdWp9nTo480Etp8CGm30
         yX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728532857; x=1729137657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWIzD1VrGPIJLaJktHrn5QN9bD3hbWPe2noYoRb587M=;
        b=YqvfNK31AplZrHUovS1bRY8Zo3zDli94lebhRGdkZ4m2wOs4LBHA0o0+WpLkvj5QR8
         H5rGTusNvEf+sWYqPCvqwX+oKyV+9HECDWM65xh40F2eJZNNavfoYWeBMe61XBkfPK/J
         qj4s7Lph7ujo8/ua1WWpLB2lfY/ZCgLmP2rXzu1akUw8C/8Ng2cf/auv6Cf4OieghA8w
         JCapdR3+QknEiYJuJXYgXWaZzEqfbczpBB+lT5UMIEFkFSaGK3yvS/O0Vmg2CblIHcZw
         QT7uv++IlCUbIYsso+yYKHwVOgi5+3pr45IaF/gDkgtRVatBgQ4D1CFh2v6lLPNDlsDg
         EOnw==
X-Forwarded-Encrypted: i=1; AJvYcCV5sxvq9AoFviTjGnQBZxgeAWjBqN2hUWwhQsPBNSbL0PY5uDS+zRlLYrvXwHOaTivcBOFigk7IRrZuewA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxpPOJVCyIaW3sWZC9v0I1a3ZPyBuFy5733awuZU02cMxKnQ7m
	NnSLBXdO5z6MgG0BQERMCfs9uTSkWD6GuqLEUybKmR4tGdplFgLxwXFSqoMkdBo=
X-Google-Smtp-Source: AGHT+IGkmQd4R7OrAKgMbsmxf9TKyVa+0fEVtU5rGk4FYzaiCL27kzbb0L0y4auO7WQOjj6QX3ib4w==
X-Received: by 2002:a05:6a00:18a8:b0:71e:30d:f448 with SMTP id d2e1a72fcca58-71e1dbc2126mr8580632b3a.22.1728532856615;
        Wed, 09 Oct 2024 21:00:56 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab0b5dfsm187638b3a.199.2024.10.09.21.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 21:00:56 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 3/3] selftests: rtnetlink: update netdevsim ipsec output format
Date: Thu, 10 Oct 2024 04:00:27 +0000
Message-ID: <20241010040027.21440-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241010040027.21440-1-liuhangbin@gmail.com>
References: <20241010040027.21440-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the netdevsim update to use human-readable IP address formats for
IPsec, we can now use the source and destination IPs directly in testing.
Here is the result:
  # ./rtnetlink.sh -t kci_test_ipsec_offload
  PASS: ipsec_offload

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index bdf6f10d0558..87dce3efe31e 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -809,10 +809,10 @@ kci_test_ipsec_offload()
 	# does driver have correct offload info
 	run_cmd diff $sysfsf - << EOF
 SA count=2 tx=3
-sa[0] tx ipaddr=0x00000000 00000000 00000000 00000000
+sa[0] tx ipaddr=$dstip
 sa[0]    spi=0x00000009 proto=0x32 salt=0x61626364 crypt=1
 sa[0]    key=0x34333231 38373635 32313039 36353433
-sa[1] rx ipaddr=0x00000000 00000000 00000000 037ba8c0
+sa[1] rx ipaddr=$srcip
 sa[1]    spi=0x00000009 proto=0x32 salt=0x61626364 crypt=1
 sa[1]    key=0x34333231 38373635 32313039 36353433
 EOF
-- 
2.39.5 (Apple Git-154)


