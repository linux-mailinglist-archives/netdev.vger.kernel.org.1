Return-Path: <netdev+bounces-161528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79170A2213A
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 17:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFDD16592C
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B554192B60;
	Wed, 29 Jan 2025 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho3vG5xo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A0928EB;
	Wed, 29 Jan 2025 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738166818; cv=none; b=omTbE+HU0+sXM4SW8fxUzZ1HwvBr8CLl77dRyyHUEoC5ZScqdUCH+YMejeb5f+vibFAnsqwKQsZYqx8Xs2eDdM1nlsmjpHd/14nAPgKiGZbZGCSAYIA2wmswL9N8CzqEm/zf/2bT6Pu7IOfco+t2snKj2XBU3kNCiZFo2Ngu23g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738166818; c=relaxed/simple;
	bh=Ecivcz2EpmTYtj0aLmMLV4QXgigozns71zMzNZMsAOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K3z3ac51pTaGHUxhf3iRrcoivByKdQAOUmoBiGqET+fxPBgM3wLGBWgIQIx2JvuAKbYmIcSxuCGBD41GOr7mWhCj8s/xQXDcTLq0oPTN0fbXLtc9NHVx2mHK8zqClbUVRDX4H6G4fnhbN4PcvZwmh2AgMpivMtPVHJNzJ1ww5Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho3vG5xo; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d89a727a19so9097906d6.0;
        Wed, 29 Jan 2025 08:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738166814; x=1738771614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AgHT85OlqmMPdqV+gRIR6NwYAZDBMUnVc2fvUkRzod8=;
        b=ho3vG5xoYm0VdRXfLSV406S9mu/K54P9Hmtj3/pRGccS7pcb4q8QuIGFlc2uVW0N2g
         OPhQtKaDrWpSgIhJ9l4Y0d5Lqry2HxtxkZ773ucE0+B8a4fPAynBsSMM/dxAq34LlW5M
         3xfG9PtMbFFI4UU7yHUSurf/tu84IZh6InFz3NlG+R6vHMwu1vLjgwrhcMRVWzislE6P
         uThdjoCWo/k56HP3ptT804l0/V800pLS5dkFwGiG9WMdh9uM7w+6RxlBhy1tdrrlWbCi
         +VYCJaeIBrIB0TaA5tT7x7Yajz8qC8xk+wob/eI8RFKTTQXlSYlcz3arA3GQOdJmswMk
         kwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738166814; x=1738771614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgHT85OlqmMPdqV+gRIR6NwYAZDBMUnVc2fvUkRzod8=;
        b=to9+EokPrIdraLBwNxRGCOl3Fdr80ZhXAXuzhi499kt43bTaLug8Hz+LlLMZs1QH45
         XPv/7Y4ywNAehzIROhxcs2LZqgsj6n3KJZeXKLb0+yj6NnyPHyUJJmcjluxGK98O4cm8
         Z6lUbqetxwx9JTsciJcAewJyj1yIAnzkW7n7CWzohkwrA+l1608Ujfgtlp+gpgG6qVMc
         Rfzkq3g631P8dq5bqFM1kH3T56vqYN9HwM+3ToiVSmc5FjydpWhz5tbC1LWWjYDT2klU
         Q5MT8Vhhdsy5/yN/f6WeZKsvguh2XCN25h5xS1qAnZiWhFGlW3gOFA/4jrmNYw2Xt8Wp
         Zlbw==
X-Forwarded-Encrypted: i=1; AJvYcCUD6c7iiZnSL1P7VCg0UWyCswehDxdrHT3flgtYKV5juoJBt+kaAYQ8Jkym3HYEhLc2hds+DlAAHRoIMik=@vger.kernel.org, AJvYcCVTtN4d1cjeJ+GupnTsQmlVzi1nunvNLlOuIBxf0L1fM6NcLwesz9S+fQqea60vd9IcS8RcwpNd@vger.kernel.org
X-Gm-Message-State: AOJu0YwnrrymFS5jxKGHaqFR+2IIwpCjx+txp1oX3yPMMnSpF2sTav1K
	k2Ht89pklgBQE2dT5SHll1aZHU5GH6zqZh1vem0ylkLn2VmkyLGm+wocgZSH
X-Gm-Gg: ASbGncuw30R/7peqJFH0Q2CCrj6o3zdDaj5SjYYf46/8nciJ2G6pH+5O26702M8cwHe
	pr1gC42wjFY82ObWX9JffYpGerInN1zFcSFTSHluLk46rWs/NE9aFxiyVeH03uucF7r1xP0F6rF
	ZG9q2YdvCJw0VZ6LEXpv0aI+yRoVrgS+mshsI3/ULFuZTZyf5vpDF19gBwgYgFy3XdsEif/vGtm
	T9isVbYV6s8ptLnUROwGWJQFhr/nqZle4+8b8gW52ax7AfSoA98rzcLYcb0dOyV7lm9UwgRCU64
	6YzhMCgTp/KfHV/tmP/TUolr++4=
X-Google-Smtp-Source: AGHT+IGueeSh0TNlqU5a5NaxxtENZTa+bqdb2MKkY2+cx5MGE39WXQJ1wuXSKGsj7szUhmimdiQThA==
X-Received: by 2002:a05:620a:258a:b0:7b6:dd11:5e5f with SMTP id af79cd13be357-7bff3f81dbcmr1216204885a.13.1738166814430;
        Wed, 29 Jan 2025 08:06:54 -0800 (PST)
Received: from workstation.redhat.com ([90.168.92.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae992e7sm635748085a.61.2025.01.29.08.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 08:06:53 -0800 (PST)
From: Andreas Karis <ak.karis@gmail.com>
To: linux-doc@vger.kernel.org
Cc: ak.karis@gmail.com,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	corbet@lwn.net
Subject: [PATCH] docs: networking: Remove VLAN_TAG_PRESENT from openvswitch doc
Date: Wed, 29 Jan 2025 17:06:25 +0100
Message-ID: <20250129160625.97979-1-ak.karis@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 0c4b2d370514cb4f3454dd3b18f031d2651fab73
("net: remove VLAN_TAG_PRESENT"), the kernel no longer sets the DEI/CFI
bit in __vlan_hwaccel_put_tag to indicate the presence of a VLAN tag.
Update the openvswitch documentation which still contained an outdated
reference to this mechanism.

Signed-off-by: Andreas Karis <ak.karis@gmail.com>
---
 Documentation/networking/openvswitch.rst | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/openvswitch.rst b/Documentation/networking/openvswitch.rst
index 1a8353dbf1b6..5699bbadea47 100644
--- a/Documentation/networking/openvswitch.rst
+++ b/Documentation/networking/openvswitch.rst
@@ -230,11 +230,9 @@ an all-zero-bits vlan and an empty encap attribute, like this::
     eth(...), eth_type(0x8100), vlan(0), encap()
 
 Unlike a TCP packet with source and destination ports 0, an
-all-zero-bits VLAN TCI is not that rare, so the CFI bit (aka
-VLAN_TAG_PRESENT inside the kernel) is ordinarily set in a vlan
-attribute expressly to allow this situation to be distinguished.
-Thus, the flow key in this second example unambiguously indicates a
-missing or malformed VLAN TCI.
+all-zero-bits VLAN TCI is not that rare and the flow key in
+this second example cannot indicate a missing or malformed
+VLAN TCI.
 
 Other rules
 -----------
-- 
2.48.1


