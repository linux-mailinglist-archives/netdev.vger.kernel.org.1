Return-Path: <netdev+bounces-143750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB139C3F38
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 14:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B7C1F22C03
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 13:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF6E19F424;
	Mon, 11 Nov 2024 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYyHOQyC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B1819E819
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731330310; cv=none; b=TcWz4P7Ph/VDGIu3rCX52s96UeBq2Q4jiITkvkV69Qm4lw4jODfMGCkdHU0hY4JNPDdyty9VWDeMV2r8JZ4yWcUnZW0MAj/l/jFuFHd65wUOGtoU5DeuEGmHmO5znJDab8yiGmUpp3560RRi67IwB8c1dtLIs1uu6fAtT7ctpXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731330310; c=relaxed/simple;
	bh=G4iSLNBuH1F9ml5HqkPq/q4rv+iKT4vxK2Z2IxqBcRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=mVG/XD9v0PYsvg1m0TZR6r3Yv8v80vLgCHkHVDG4sZ7pBSqq4wD5aySudUxnUOsdndf+R/G+MQZRl+qE9TnEgzWZ9qDG9JyqA2kdW94835AOj1GIiWs2xmZTV+E3JiyXlx0XiQZfZPDv7vBH0rfWNjkmuQ42HU2n89bPKaB8CAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYyHOQyC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731330307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Feq6t5AlgeTlkGAOEGQe9gC1MgRb04gvIeHmj4E26DQ=;
	b=XYyHOQyC3j4NBa4nqKGCw62yy6CoznDT+sCrFttgGo6luFFZPpsu23H7pMH0CgqvsC47TN
	vTnQP+owS8EogA7v+yTD0l+GTkL4x4hU9y3RedwZM1bSTse7it52vzbaOZQ5oGcr2/VIKw
	ZFTghnph7hnILd24C9+ky3dDcDsaoic=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-PiM3pauWOnqMN9pTo-rHDQ-1; Mon,
 11 Nov 2024 08:05:03 -0500
X-MC-Unique: PiM3pauWOnqMN9pTo-rHDQ-1
X-Mimecast-MFC-AGG-ID: PiM3pauWOnqMN9pTo-rHDQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5FCF1955F67;
	Mon, 11 Nov 2024 13:05:00 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.51])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C28781956086;
	Mon, 11 Nov 2024 13:04:57 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jstancek@redhat.com
Subject: [PATCH 0/2] tools: ynl: two patches to ease building with rpmbuild
Date: Mon, 11 Nov 2024 14:04:43 +0100
Message-ID: <cover.1730976866.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

I'm looking to build and package ynl for Fedora and Centos Stream users.
Default rpmbuild has couple hardening options enabled by default [1][2],
which currently prevent ynl from building.

This series contains 2 small patches to address it.

[1] https://fedoraproject.org/wiki/Changes/Harden_All_Packages
[2] https://fedoraproject.org/wiki/Changes/PythonSafePath

Jan Stancek (2):
  tools: ynl: add script dir to sys.path
  tools: ynl: extend CFLAGS to keep options from environment

 tools/net/ynl/cli.py             | 3 +++
 tools/net/ynl/ethtool.py         | 2 ++
 tools/net/ynl/generated/Makefile | 2 +-
 tools/net/ynl/lib/Makefile       | 2 +-
 tools/net/ynl/samples/Makefile   | 2 +-
 tools/net/ynl/ynl-gen-c.py       | 3 +++
 6 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.43.0


