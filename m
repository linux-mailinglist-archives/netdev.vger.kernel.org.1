Return-Path: <netdev+bounces-204422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431F8AFA5F9
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1783B43BC
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 14:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C9D2882C6;
	Sun,  6 Jul 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOHaNyse"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20102135AD
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751813163; cv=none; b=qgatxMykd5/RdDlFUwPY4gA47rlxYFupA8/daD4vERAPEw+NnybOYpCG3NPSY+jAS2hHUsEROcXlK+I6O6na6ih5peTMCUFZCoE70IUfd4UVo/GLM9wMZTFZU8drR6mpVVskzodrvHFXTAiCm4YFlbYpH6nRJvv7LEyAODzRHZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751813163; c=relaxed/simple;
	bh=4DbTlb5Y+2nPoZPtuGoDMcpTgssTLkBbLMQtueNDNr4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VZhuls0ibWhr4t7gnblrpGohmcUY/kQ3V4+mxQULJhTKJDVX54CeuS4MTN3h2VzKiRIx2Az/8ZhT4JKM0spxl7Szs3MStkphtNSJ4WQhDbHA95cfL6Gowi/wPWjC9yiYBTaG5hdEBdG3DFFwnTaZWrK/77kbnH/mRcoT36X6RQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JOHaNyse; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751813160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7yfm2/nR8Fm8CG3trRJnXBCO5odY4C5ewI1q0oEUm1A=;
	b=JOHaNysejjI/2xha0L34/dxoxViMBCTiVHZQH0zLVZNR3k2eNgVwwG+YbdaYeAsSYoxrZm
	YJxCJ+RqFVpsE8bIVFLsjuR5kjowVprbAKoxx3mO2TkCpFUhAE6/xfZ8Lxq39XS6r12+FQ
	oL6B1wbDNDiLrWx4RHkT4diI5/DtdwU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-U3k0YnS5M8ySBdV0JbEliA-1; Sun, 06 Jul 2025 10:45:59 -0400
X-MC-Unique: U3k0YnS5M8ySBdV0JbEliA-1
X-Mimecast-MFC-AGG-ID: U3k0YnS5M8ySBdV0JbEliA_1751813157
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-32b40be4525so16337961fa.2
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 07:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751813157; x=1752417957;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yfm2/nR8Fm8CG3trRJnXBCO5odY4C5ewI1q0oEUm1A=;
        b=QcI+aCoRtkSA2INAJrDiU2SlRixE/281vujfbNmftOd59A21/O0QqFWJTksPVkj7iE
         8numKU9PiIdbY2g4wqK8NdSTmhz0J1bjgOFB9zhWMTBKrIah98/jpoq60WyNwPDTDeyz
         7SY0Az3FlceO8TmICemz//X3qe0LzA7IGFy4gVjhtxqSnqVeCPDY5QyzRkSVo43VzI9z
         TFixzT12xxWYcpTAjbwAAbpGJvUK1L3o9w5tCsYmbpIy2qxhREO0s68Qj576rxOjLkZO
         koKGQVndE31Out+7CK9c9v+01WARFgjAFdow4bUBJsCP02Edu738m7zUu4nOBkg5cxqa
         mtCg==
X-Gm-Message-State: AOJu0Yz1YHqKYQU6pxKfWfLGkuuZG5t9RV+A3b8GuKku/w7QEbLfbL2+
	3Omcb+cenJsX8ZPhcezMkcUDUOrr61VXzfqc68jbRYTPGflgzfbwkfq97P9Z++hHPIY3aXPg8GZ
	ge0ODkc4uiNsHocqO+e4XYVjfo7arAd53PJhwqKWQcKE4k5Q8K6rucHGNrW8c+4EqLA==
X-Gm-Gg: ASbGnctuxloxgY2DTk6KMmtJZca8/+9wuK42CKQ4+m3bsiyHiexxEqOtk9LNA+5Bglo
	mszcGYJxZHF2/11IfeXgdLHBZd7psXNZwiRNtVksHTCITjUIkXW030rvByj11pYdWfN4VLcerGj
	z9Jpv936XxG2z1c0L99EhP4DqpsebI1rZYHeQcag4tun2ECBhGRJFWFlFikPUNQkrzo41rA1PwY
	7rD+yk7G7y/GhpTDwv3LliOr9DEsnt68LeggLLuzlUF+boTvBrlPTHHCQRcqzshR6YTkxfbwUAY
	gk5nPRJLb3JohEMUicYfhTZ+xAdwFDPalsiMVu3cNNNETqs=
X-Received: by 2002:a05:651c:2115:b0:32b:7111:95a1 with SMTP id 38308e7fff4ca-32f19b53425mr11731781fa.41.1751813156655;
        Sun, 06 Jul 2025 07:45:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe+nMzSXNfhSd5KCwXb3/NhFkRgP8YzyViTAvLtl8abk+Gx2zjbo8KZNDtSv8g94K6//qw5w==
X-Received: by 2002:a05:651c:2115:b0:32b:7111:95a1 with SMTP id 38308e7fff4ca-32f19b53425mr11731751fa.41.1751813156206;
        Sun, 06 Jul 2025 07:45:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32e1b17aa83sm9128731fa.98.2025.07.06.07.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 07:45:54 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E735F1B89EAB; Sun, 06 Jul 2025 16:45:52 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v3 0/2] netdevsim: support setting a permanent
 address
Date: Sun, 06 Jul 2025 16:45:30 +0200
Message-Id: <20250706-netdevsim-perm_addr-v3-0-88123e2b2027@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAuMamgC/23NywrDIBAF0F8JrmsZX4ntqv9RSrE6aVzkgYqkh
 Px7xU0phFldLvfMRiIGj5Fcm40EzD76eSpBnBpiBzO9kXpXMuHAFTCu6YTJYY5+pAuG8WmcC1T
 11sjOgGaqI2W5BOz9WtU7KYMyWhN5lGbwMc3hU99lVvsqcxCHcma0HICWL3sRIOUtoBtMOtt5r
 GDmP6QDfoxwCrRthbqYlmvdwx+y7/sX0fShrwYBAAA=
X-Change-ID: 20250128-netdevsim-perm_addr-5fca47a08157
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
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
Changes in v3:
- Fix shellcheck warnings in test script
- Link to v2: https://lore.kernel.org/r/20250702-netdevsim-perm_addr-v2-0-66359a6288f0@redhat.com

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
 tools/testing/selftests/net/lib.sh           | 23 ++++++++++
 tools/testing/selftests/net/netdev-l2addr.sh | 69 ++++++++++++++++++++++++++++
 7 files changed, 129 insertions(+), 18 deletions(-)
---
base-commit: e96ee511c906c59b7c4e6efd9d9b33917730e000
change-id: 20250128-netdevsim-perm_addr-5fca47a08157


