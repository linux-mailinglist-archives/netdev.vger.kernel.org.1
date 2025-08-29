Return-Path: <netdev+bounces-218132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6EDB3B3A5
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 08:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7088A00C1A
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 06:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A61925F79A;
	Fri, 29 Aug 2025 06:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="s0fRgIW+"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C49E24E4D4;
	Fri, 29 Aug 2025 06:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756450156; cv=none; b=hBs+6zG3QlTZcXh4X2SiDTyRFhAXOKcGs9mxoacY0l7PR5PdFqq7yMog0DmO3pNXW2ObphKeCnNSjTL2qipSIZH7S4YZvPdMTROC1FxUZ+NQJ6ef0Ph2bJU0oC9f01UHWixfKF45SVUiVo0jgZU4oNepIIpJF3qX4w6odkpC2A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756450156; c=relaxed/simple;
	bh=VTLfNEzk7IYni4+wltBaBQeLdSmKG1ABqEoPm0WZVkc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E+r7TI3Rn1iYwzzOLN/5i19mA5GI7WfvliL2ltiwhb+eVJ0b3hDnFMLraOlNuviyvIgEfoVGDrI03rVkHsQsAKnj4dEaZ4iOmOMd+h9x1h5eBkkNMIZUNjXN0LpVk/QhcgX9Bc4oZURONSz+5XkyjiGWv4xZHG+1rf4rZZ3xuIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=s0fRgIW+; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756450154; x=1787986154;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DY15o/R+geg7FhYyIfjWajEde5HmsOirgnXwSC02qUI=;
  b=s0fRgIW+j0W/ECTxxNNjcO1rQfXEhV1gvFCLbczi4pM+RVjzz1gxqwyS
   KeXl/4MnnKIDqOrVCA9JOV2UVSunQzbsw9+Dyqp+g5vqnzQhs4P7QJDwW
   Zfow0aTFgNKgSgtyE94yHIIqr+fH6S00gY/qNkqw88dqN0zKKSqyHrZU3
   TAgShpXI1eQf20o3u7OfBCEHA+m9iXh2y7eUzEcpaL8YsvA3C8iCOloW8
   X1IEqbCs563lb800SvQbN5AvKVN83M5E1ZmerYJanysAxn1hL6Brwsgn1
   60hM0dGyPbxQCvPHfHLCpXvOhm37vit2qaWEqtlpt+7cG4H0WJND3hlOV
   g==;
X-CSE-ConnectionGUID: WxyxqBNFQaSIKYnYtig/xA==
X-CSE-MsgGUID: PqSohy3IRW2LFYDxHXVRdg==
X-IronPort-AV: E=Sophos;i="6.18,221,1751241600"; 
   d="scan'208";a="2027109"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:49:13 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:55340]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.106:2525] with esmtp (Farcaster)
 id 547d1bc3-e8ae-45d7-9166-48b6d21e49c6; Fri, 29 Aug 2025 06:49:12 +0000 (UTC)
X-Farcaster-Flow-ID: 547d1bc3-e8ae-45d7-9166-48b6d21e49c6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 06:49:12 +0000
Received: from b0be8375a521.amazon.com (10.37.244.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 06:49:10 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Kohei Enju <enjuk@amazon.com>, Samiullah Khawaja
	<skhawaja@google.com>
Subject: [PATCH v1 net-next] docs: remove obsolete description about threaded NAPI
Date: Fri, 29 Aug 2025 15:48:42 +0900
Message-ID: <20250829064857.51503-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Commit 2677010e7793 ("Add support to set NAPI threaded for individual
NAPI") introduced threaded NAPI configuration per individual NAPI
instance, however obsolete description that threaded NAPI is per device
has remained.

Remove the old description and clarify that only NAPI instances running
in threaded mode spawn kernel threads by changing "Each NAPI instance"
to "Each threaded NAPI instance".

Cc: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 Documentation/networking/napi.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index a15754adb041..7dd60366f4ff 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -433,9 +433,8 @@ Threaded NAPI
 
 Threaded NAPI is an operating mode that uses dedicated kernel
 threads rather than software IRQ context for NAPI processing.
-The configuration is per netdevice and will affect all
-NAPI instances of that device. Each NAPI instance will spawn a separate
-thread (called ``napi/${ifc-name}-${napi-id}``).
+Each threaded NAPI instance will spawn a separate thread
+(called ``napi/${ifc-name}-${napi-id}``).
 
 It is recommended to pin each kernel thread to a single CPU, the same
 CPU as the CPU which services the interrupt. Note that the mapping
-- 
2.48.1


