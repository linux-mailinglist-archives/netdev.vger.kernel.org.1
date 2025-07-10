Return-Path: <netdev+bounces-205753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB9EB00067
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 13:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059FB1C85FCA
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EFD2DAFDE;
	Thu, 10 Jul 2025 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLO7Mi21"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82136243954
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146330; cv=none; b=FUPxcSYTqJCrMjuphNpJsDhV91wWWO7e7HPE53JnvYtDvxGWZp7Loa7FcmafsBkyeMXvjohvJTaognOpYtx8v0vi3WAmezKlTDcYnpui0evLEjiWi3yOWG25WG3Zd4QLY6DKwWdqzLasKpqOCU5UTYrysoTH8yy+9HjAMhR8LEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146330; c=relaxed/simple;
	bh=yvXMzVaEUAEaQ+QwmsWsIWflnIobHjov6sm4dK3YQWY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QnarmHsStPAR4HWWIr4U8Fo+0mt11lvju9nRtBDat2ipLTDi5vb4cVDu8Ykig6V9ycKxeCsP/7aZcqA2FqD73biXDLJRKc2drhuBex5GNq3t5GezIGt3qVLpFYkmzR8ha5gpyGrLyl9YMx6OaUqvnHjbulcA2rb78Mo/MCbSLPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLO7Mi21; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752146327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nb9BcfvP4RQqClfQj6kwpdoGeGnUAyK4W/bW+bllRDM=;
	b=QLO7Mi21GQlb8x2TgkvYIv4NIUPQDH515gvnxKkdihFuf5Wz89o5lPYmaeaQgmABl+pN94
	dR2Pqdj9kjKGQxcBarr7yPe1tllhBQnI3tnavQlIwGA14dP7Gqrw2bxqEOz7PAc9k0DFnz
	qPx4bcxbwTqqyXhytq6tXvIbtgVXnVI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-vkXLKqf2ONGyDXHw1tpwVg-1; Thu, 10 Jul 2025 07:18:46 -0400
X-MC-Unique: vkXLKqf2ONGyDXHw1tpwVg-1
X-Mimecast-MFC-AGG-ID: vkXLKqf2ONGyDXHw1tpwVg_1752146325
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-553b5a75372so534697e87.3
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 04:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752146324; x=1752751124;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nb9BcfvP4RQqClfQj6kwpdoGeGnUAyK4W/bW+bllRDM=;
        b=ENXgAze8sOUkOJuoEjjGoSAlRsEZ7FydsRhpIrU8/s4Vkz54uLcOKN5ZgrNdv95oOL
         Y6eC8PCPne9500HoFaWGC6AzcVQtHBiA1AWhO/29noexnM1J7X0KFxweiFFibDHdyXga
         OxvnNjYpFc6nvAJid+D66x9GU6I6njOM2K5kVSam3DJCuc8E5UTOzf6p1wvj5KwlYG+V
         tdSw/7ALYo6gkHG0I68UtERQZ29qfj6u89AsTkiv14FW+8PCi02C33jdP7Uj2aGk0bfV
         k6P/jw+rhaXRCXZ5Ypbz79Lb33gcdION8OwRb67Puy9wXzp/Q2rYygQ1CC+r5iMx8lmh
         1wfQ==
X-Gm-Message-State: AOJu0YwJL1qgNrvfHJ1Ah/MxeigyNI7tdpQrYMo5cwJ38zfCDRo0JlHy
	vBmJEomWCD6Vevx+xAWPrBj1V/Pi0TutaUd/gEvHtCcErhFKA1qsUq+ODmSbgCoGtYv19YeN/JA
	lpsKZaovrLFrNTzYYDpQ3Ft9dH4FnCMJInwf8hGI4b3elKHYXVt5UJxWfQKYinW4jiQ==
X-Gm-Gg: ASbGncvvJkiOknyYZH+o54O6u7eJO03HSCa3CBmQ0Xo3Wxf1GAmxD3xaHfwlum0vBVh
	rAgUBo95+0QHOnQAAqTFOpX2NWLU3BB/KbW+WkR9JS3UDL/KXNdxtugqsd1Pmx6tCvvwR5gu4Pv
	Br5fbMWbIc9NcEDHiyINro1Qhhe6VJ0W6pzfHUG96z/CCPwZ2Xekt7UpiGehKbVk9m4nzFmEtS7
	qjlvvkSEp4zVwih9ZoJ3E7GfN/YOuRsqxfdMV1oAjpFGP4vAR0F/cuAVU/mrMkeqxBvk4zjiPnt
	wBoGSx9d2xnkAtlkYpAs
X-Received: by 2002:a05:6512:1392:b0:553:a490:fee0 with SMTP id 2adb3069b0e04-5590002eeeemr1082204e87.10.1752146324254;
        Thu, 10 Jul 2025 04:18:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn6UYBxsuXMXVPpU2ziz8eNZ/zZnu75oqhq0nyzjKYPyzf9PTrICF1adNNCqyxgVabK7MRSg==
X-Received: by 2002:a05:6512:1392:b0:553:a490:fee0 with SMTP id 2adb3069b0e04-5590002eeeemr1082189e87.10.1752146323732;
        Thu, 10 Jul 2025 04:18:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bbb16sm335375e87.11.2025.07.10.04.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:18:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EE4AB1B8A3D6; Thu, 10 Jul 2025 13:18:41 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v4 0/2] netdevsim: support setting a permanent
 address
Date: Thu, 10 Jul 2025 13:18:32 +0200
Message-Id: <20250710-netdevsim-perm_addr-v4-0-c9db2fecf3bf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIihb2gC/23NwQrCMAwG4FeRnq2kabdVT76HiNQ1cz1sk3YUR
 fbuhl5UHDn9JP+Xl0gUAyVx2LxEpBxSmEYOZrsRbe/GG8ngOQsErEChlSPNnnIKg7xTHC7O+yi
 rrnWmcWBV1Qhu3iN14VHUk+AClx6zOPOmD2me4rO8y6rsi4ygV+WsJA+ANdd2r8GYYyTfu3nXT
 kMBM36QBnAdQQmyrnW1dzVa28Efor+Reh3RjFirUBNe+bL5QZZleQNBEAVYSwEAAA==
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
Changes in v4:
- Check permaddr with is_valid_ether_addr() before setting
- Use ip -j and jq to parse address output
- Add a test that setting an invalid perm_addr fails
- Link to v3: https://lore.kernel.org/r/20250706-netdevsim-perm_addr-v3-0-88123e2b2027@redhat.com

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

 drivers/net/netdevsim/bus.c                  | 26 ++++++++++--
 drivers/net/netdevsim/dev.c                  | 14 +++----
 drivers/net/netdevsim/netdev.c               |  9 +++--
 drivers/net/netdevsim/netdevsim.h            |  9 +++--
 tools/testing/selftests/net/Makefile         |  1 +
 tools/testing/selftests/net/lib.sh           | 23 +++++++++++
 tools/testing/selftests/net/netdev-l2addr.sh | 59 ++++++++++++++++++++++++++++
 7 files changed, 123 insertions(+), 18 deletions(-)
---
base-commit: e96ee511c906c59b7c4e6efd9d9b33917730e000
change-id: 20250128-netdevsim-perm_addr-5fca47a08157


