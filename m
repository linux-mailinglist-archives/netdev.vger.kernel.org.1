Return-Path: <netdev+bounces-203242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A08AF0E85
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 10:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4241793CA
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF5623C511;
	Wed,  2 Jul 2025 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qhtu8P+K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF14D1EDA12
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446589; cv=none; b=N+0pDP+1Gy27LbU4PDV8mkUtcTdsxSQFD/J7ZpE4+pE2E7mAxgWzZ1hA/dAfZyiz6/8HcPMDYpWqLaNbAw+EBolOxujgxbIBLPWueWH96/VHttq37y0q4/fNCOizMub3Y38j88ugJ19Wszv6P9SHv+jcUPv6yc1A6UAB5WCgg/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446589; c=relaxed/simple;
	bh=ZGqbWJb6Ef6qwVsnW4m+O5Zl2ysSK9pTSNpwgAMK8C0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gYe5T2lanGyLzPxF1b5jOV3IZ5fV5BWAQk6l+lEvw5q9OJIc4vpX5i2Fo7NiunwON4+Fm4GrMdyrTuBoj335dnDxU/QU5Hc9YO4M7YUxYR8GQLpBvsCZx9h0ePtOmVYpsQBHbMKRQ6lMIGNDXMcOkUStPtFG9FMQ7SntylJvc68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qhtu8P+K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751446586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hd9V4j3xvd+KXkH5BH+0b/cE/jDyVGMILUqMFuZ2a9k=;
	b=Qhtu8P+KWA91FOVH2TLxJoMaRFf5Cgv2TtVNBriGKUKWx9fZnrYNCzWSY6NF2K8fF6t3fb
	S43vrzr8PMHvA/RsTOyfux5GGluyhVXvYcYh1ocvafa1b1f9bHWLsz/Vz3Igei0AXsLW+J
	3qZ/BNm3NXSIDoAD6gPRLpDfvwVtaQU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-Ig9iqzAENNadvtlnMHUQfA-1; Wed, 02 Jul 2025 04:56:25 -0400
X-MC-Unique: Ig9iqzAENNadvtlnMHUQfA-1
X-Mimecast-MFC-AGG-ID: Ig9iqzAENNadvtlnMHUQfA_1751446584
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae354979e7aso292014766b.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 01:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751446584; x=1752051384;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hd9V4j3xvd+KXkH5BH+0b/cE/jDyVGMILUqMFuZ2a9k=;
        b=RBdoEccpWI0rfoP/ok/zhG7m7xcn8+6Vs5cbxD8lWaLa22TbJK9vGl8iUvmtXK+TN1
         4xh3HyCzPhpViRNIMT5rQfGE2Bg3XyWOwkziAZR0ob9y60ddWw+p0XLhQor1F+kNlKlT
         y6IkkDnNREXSDn2mKrGypemLJABRSkWHK556fZzqW/GcFHBpKtVsLllR6DtAJNLKNSAU
         oK1Wxhooc7xbz7/QyE+X9gxF2wIJnl7CecFw6YiWAap4E2CVawRvNN/UOAC0wiR5hjqv
         PSYILguQ8sAl2xDJlucUxZcYhgkvz5ninz+MU8TaVYc5o5qYoOPDnuBLstEfiVA74UAn
         KKGA==
X-Gm-Message-State: AOJu0YzH6+b1QAIMudJ5VDxU60vCGBgTB0oOwsaS7vRLLo/4QdrHvpbu
	rU7c5wCOAOddD/Snyr5v2uDcGC+FNiWglkJ75CdLscD6jvpR4x9Kn3OFhUfAtU1OakgUHlU1rVm
	/ZAg9BmQuXyNBoo3aHbDlPsqzVKE7T9XuqGBowmsVTyHUu1RYeraSGHJ93g==
X-Gm-Gg: ASbGnctpDW8LEEMEqj7WiklHGn7Ov33ePO3IWPQQhSKLT1jiYCIFaAkGyHy3jHXYbUA
	fP+Fwzae/hFZHX2gkztifpEtFKao2baAqRxrZAqhmAAGT7lsSUBJe4Leufv5DNuSuPxxcHfhNpV
	xTX7XnhwIKIgS3Gtb4HPDj1dnubFwPEBpx7KzVQFbrtj0ZICsJXDZ8lv2t5Tgww99EEi/Nh/5aP
	Xv0dgnKZDpXTCvKM5BARxEzR4m8p2R6hOkl4ymT3vutuso4AUWI0NylrPstuy11oD63L/fxmSHz
	UHCaw9VxQyDWHEdc6WA=
X-Received: by 2002:a17:907:d846:b0:ada:abf7:d0e1 with SMTP id a640c23a62f3a-ae3c2d5639fmr167606766b.37.1751446583919;
        Wed, 02 Jul 2025 01:56:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETz2cUbjohiDgMCeB5AGjP6DLRA0j8ue6TXaco20VrP3jVIARjRWImi3fvYB/VhYDunEYdrw==
X-Received: by 2002:a17:907:d846:b0:ada:abf7:d0e1 with SMTP id a640c23a62f3a-ae3c2d5639fmr167604466b.37.1751446583485;
        Wed, 02 Jul 2025 01:56:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c01506sm1049603266b.109.2025.07.02.01.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 01:56:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A73441B3802E; Wed, 02 Jul 2025 10:56:19 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v2 0/2] netdevsim: support setting a permanent
 address
Date: Wed, 02 Jul 2025 10:55:55 +0200
Message-Id: <20250702-netdevsim-perm_addr-v2-0-66359a6288f0@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABv0ZGgC/22NzQrDIBCEXyXsuRY1hqQ99T1KKFY3zR7yg4qkB
 N+9i+cyp2H4vjkhYiCMcG9OCJgp0rZy0ZcG3GzXDwry3EFL3UmlB7Fi8pgjLWLHsLys90F0k7O
 mt3JQXQ9M7gEnOqr1CQwwdCQYeZkppi18611Wda9mLdu/5qwER8rBvN2tlcY8AvrZpqvbFhhLK
 T8SQztBwQAAAA==
X-Change-ID: 20250128-netdevsim-perm_addr-5fca47a08157
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

Network management daemons that match on the device permanent address
currently have no virtual interface types to test against.
NetworkManager, in particular, has carried an out of tree patch to set
the permanent address on netdevsim devices to use in its CI for this
purpose.

This series adds support to netdevsim to set a permanent address on port
creation, and adds a test script to test setting and getting of the
different L2 address types.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
Changes in v2:
- Set the permanent address on port creation instead of through debugfs
- Add test script for testing L2 address setting and getting
- Link to v1: https://lore.kernel.org/r/20250203-netdevsim-perm_addr-v1-1-10084bc93044@redhat.com

---
Toke Høiland-Jørgensen (2):
      net: netdevsim: Support setting dev->perm_addr on port creation
      selftests: net: add netdev-l2addr.sh for testing L2 address functionality

 drivers/net/netdevsim/bus.c                  | 22 +++++++--
 drivers/net/netdevsim/dev.c                  | 14 +++---
 drivers/net/netdevsim/netdev.c               |  9 ++--
 drivers/net/netdevsim/netdevsim.h            |  9 ++--
 tools/testing/selftests/net/Makefile         |  1 +
 tools/testing/selftests/net/lib.sh           | 17 +++++++
 tools/testing/selftests/net/netdev-l2addr.sh | 68 ++++++++++++++++++++++++++++
 7 files changed, 122 insertions(+), 18 deletions(-)
---
base-commit: e96ee511c906c59b7c4e6efd9d9b33917730e000
change-id: 20250128-netdevsim-perm_addr-5fca47a08157


