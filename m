Return-Path: <netdev+bounces-235456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 420C9C30DC6
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 13:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7D5423CF6
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 12:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087442EB87E;
	Tue,  4 Nov 2025 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="eCdprgzY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4B02ECEAC
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257801; cv=none; b=rhsCRL3f6P/WL0gCEV5L/1y3eAknLX1g7e3Eqi1ouo6Acw1B+YLIrlIVfIjEFmaYB6pVYcqECDZn3CVpThK9Wzd/iV8CGXabowy4E6wSXVEp0FD4tMab7dg+hLlOM3ZWebQ9GLIHVl2pWNk7WVbauRjMxuq2qHCQIgA5jhXv9KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257801; c=relaxed/simple;
	bh=r/A1fEgxd7CLHCCecKoxs1s58LlXAFQLXZW7PU/nfNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X9kCnFX/+mWe7e7ys3mKVT69xRRn4bQNz0OT9UW6Atv8q/Upnd60pUf5bEl96TPV5JrMreGVNqG9dUuAh7M91SOcLge5/z/Wbmk17gtRWh4GNxx5D/vvpvl1Lf16H2RgKx7HIlDGefi4eCMVIKaQrZH3y4AshDinBy9zxcuSNJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=eCdprgzY; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3b27b50090so841860966b.0
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 04:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762257798; x=1762862598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d+nlqde12JvrajErEGkMt8OTpsJbP6JIY2MTLZXG730=;
        b=eCdprgzYqZb0++XPKCLP6hAoxG8dxyr8UP0lGZwt8hdUulOGCJ9RVBRcCqfZJcISq7
         Q9YeU1OY40u9rKr/9LqPUhOF8Kv/pdltxCQuWde80tqD6XkDnxKOIECvpTB7vzX34dJ3
         pRCvSNPWCoivQJ6uMEBo4bkd7nslFUDzCVKauJD4JVYmb3xfhvk2Q4V8KG+4s5dGw+c4
         Dq3ZO2uDrSoREoMntwDhqnFkeZRdf7qjybQ/9WaM2fM/hChJUQB5VgzTqyxpOj+TIhHC
         f2pSVpkhbS5nTdijt0P21lZmphFJukOTAYmC6+cr3fP2VjQxrM88g34DCvB0Qu54UV4B
         WcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257798; x=1762862598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+nlqde12JvrajErEGkMt8OTpsJbP6JIY2MTLZXG730=;
        b=JgZEerzgKjlXYnPjkXsd0BygJaq10p0CkxWeaJOauNvCrcqR+nBcvtUEYlx5PvCeje
         x5A32F7rz4eCU3t6kUxgO2JD6StL6AJs/VNb6XHOxjb6kJ0KFvIVXVX4712OoFjGNRVL
         CGh4n6zkWjpn2msb3iARaYVIS+roIeIi/Fnutz/kQXswxhbUnqOHG0T4pSGFr5Hd8XAa
         fLeTC/W72CKKCnHhVHBSU+OZ94Zwz9SrfFKJSkPs71nC20/ciabwFBvGBycKloMsPcDa
         X8B0J/5L9O9jL2DonQIRCDocZC2mlpY/Tnk17BROGEIjRou42gCfbABE7QYjyZ6hIQ7g
         ysqg==
X-Gm-Message-State: AOJu0Yxd4wucdWgR+gjYKbeGHEJN0K0w5QAIMaUBwYsDOvJnDILifdmO
	Yjo94ybW3xggqjLzrlGCLLw/j2jTRwrObPFEceqJ4FQMivqWekwgtLo4ZU0EI6HHeNuRPEZIV0k
	fnlhyvRE=
X-Gm-Gg: ASbGncuJn+BGPCdvtsIE7aKU4QzEWBt/G5tHskoyxlS/mMqNidSksPZsL5fcVPEd0pv
	2X/Da4ucGUFDiysoG2RLyyLoVT3lB0PJUBR9An4XeTIExxPDBgrBC0g+Npa3rq9NOmXk9eRoOkj
	CdMDZ5fk60+92kspci5/nyVKiojHI+NJbt+YZqLGUQ6EoDgfJGE8rQjJVU1hdBm+L5daWk6QRf1
	QSwQhULhdIzOUXgURh8j/o8x2dKGBbT+HI6V3EIWklyyVf3Y4/4WX69NrTZVYg+LxQJuxYHIYBd
	vemTvhWijWQaQN2d/hWFgKF15oDjPltYG6tSWd0dmaHsyddBQyO+NJqKuDdpLqDTFtjgWYhFf4s
	8U+BscP8U4MAcfXn2Dhj/UBiXxjV/2TD9pp3zwI4cxm3MLMgV64aP77aSvhfMrVHP33xX1FM3XF
	3Wvg58VwvurFBUjAkYxyiUExTxt42uzYdxIA==
X-Google-Smtp-Source: AGHT+IF8WOhdpwiTQR+BceMSuOGIT8IEumRExm7hI7+Yf6DfRqnzF9lS4wTtkLhrejzbcQOrOYF63A==
X-Received: by 2002:a17:907:1c93:b0:b6d:608c:838b with SMTP id a640c23a62f3a-b707063e284mr1699931866b.45.1762257797028;
        Tue, 04 Nov 2025 04:03:17 -0800 (PST)
Received: from debil.nvidia.com (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d3a3082sm195032166b.11.2025.11.04.04.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:03:16 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com,
	idosch@nvidia.com,
	kuba@kernel.org,
	davem@davemloft.net,
	bridge@lists.linux.dev,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 0/2] net: bridge: fix use-after-free due to MST port state bypass
Date: Tue,  4 Nov 2025 14:03:11 +0200
Message-ID: <20251104120313.1306566-1-razor@blackwall.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Patch 01 fixes a race condition that exists between expired fdb deletion
and port deletion when MST is enabled. Learning can happen after the
port's state has been changed to disabled which could lead to that
port's memory being used after it's been freed. The issue was reported
by syzbot, more information in patch 01. Patch 02 adds a selftest to
make sure port state bypass doesn't happen when we have VLAN filtering
disabled, regardless of MST state.

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: fix use-after-free due to MST port state bypass
  selftests: forwarding: bridge: add a state bypass with disabled VLAN
    filtering test

 net/bridge/br_mst.c                           | 18 +++++++---
 net/bridge/br_private.h                       |  5 +++
 net/bridge/br_vlan.c                          |  1 +
 .../net/forwarding/bridge_vlan_unaware.sh     | 35 ++++++++++++++++++-
 4 files changed, 53 insertions(+), 6 deletions(-)

-- 
2.51.0


