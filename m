Return-Path: <netdev+bounces-304619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AkKYGGXpR2rjhQAAu9opvQ
	(envelope-from <netdev+bounces-304619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:55:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A37A47046F5
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:55:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="nILP/pnH";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304619-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304619-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2BE43028F28
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 16:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B3430674D;
	Fri,  3 Jul 2026 16:52:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420FE3033FD
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 16:52:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097569; cv=none; b=fi58opU5jjCIAMp8FE4mM2i0lAOwWQUsliOkK2MxeWSN3OOKulpKJODzFsa6Yz3A68CXH0lmR5gPWLjHBRQBJtELN3YvIKAp4nSF1BBcjArWsxtrOBzGafyizhi1jdSkXt9NS5rJmI1dVZpRJBGa9g4IBabuFYCHuUjVKpU3hMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097569; c=relaxed/simple;
	bh=yTOFnikBdd9UnFaFWVUU9YImMgdALU3lu1EsNONvjuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqfGxPstLzn6+G9eX3xPxyoGPc23cGKnwGNgdhZnBZJzOxX07wCouSXjL32vWzQlmiSrjn9Ff4Eu+yIdz2KLjwrTl4STnhA3Fyoul8MKyhgbi2N00Zj8JCbDYf91+uLV2EFXPdMYi/K2UGv4N5D3R70TcHa6SKPkSfyi05upNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nILP/pnH; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84347ad88edso901300b3a.1
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 09:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783097567; x=1783702367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Q8IAKfvHr6s1GZm4Yq7xrIA9ocrkE3Ph3Y/JG4nBpI=;
        b=nILP/pnH2gL4C6BoOe7jnr42cjHHUmC0ycvYQElSgClnyrSw6HqZG7o7ucXGKZLUWm
         t43w89mWF9WDaZpr+BFevW7WCJ5Lt4x8feZOnsCrP8aLp9nxWf3DiHR6StTVCLx0cyMf
         Ie7NVmRYSxtRNlwOfpeCg1wItDIEFvslAw76o3Cu2lDGOk0MTcreqhd8BBYm87YuzHKv
         zKDMGPbyifpIwrowKjpkfOpH4SeoLEavwg5Y1QI9oeIk3x5eaMZ8//IcKHtdrfhb56C2
         4IL1nov42eICaaTLuF/sCtfmIyuWX8y9foIBHfBqr2yRU3wcKBpSeg1LpVVMSjw4ht/O
         jd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783097567; x=1783702367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Q8IAKfvHr6s1GZm4Yq7xrIA9ocrkE3Ph3Y/JG4nBpI=;
        b=bH23otJWiVmeefaGP2TDmtjEQcYbYW8PAJkWnreFo55aBo9tEFOxLFu0kbAaAH/I2+
         blnOu8A1h2RGOWc0c9NiFlUhMdLO3EvNWsAFUxD4tRg9V8e7GaF7kNxvwQtBgv7DCZcS
         PMwDYm/COPgHK5o+4g2D7Mum/7FQFgEnWF2YR721jecW66NokkBdejzZsT/+aH0dv+Q7
         3qtxPcuF9tK+6oxRcffUfr7ySRCPJBtQ1JEIvnUWS9TISccIKNZtXZ5r2ioICRwXPjY3
         0BUPLfBlx3BznNM3UlceJ3ULOkxgmfkeES4iSgphM8C+3R4Cq/wSkbRSWlRqBgit7rX9
         BO0Q==
X-Gm-Message-State: AOJu0YzLNnX/Q2DDhQYIAor2yw2e6rG3mN8v50BXiX6xUUbvXzSFB5fH
	5lMvk5OpzTsRknl1NOy2cM6ZVqBqIcQ5HMF1VnNyQpJGd0gFGesSPyqUNsMAtNzI
X-Gm-Gg: AfdE7clU6rWI1on9zbhHDhkjETIi5MH6pONzO6TfIKRkAbfYY5jfNTaUIJdcS8YGX99
	jc9b4xRCWBUGvOzS8o0s80kQBD73NnYcaAiSbEmZTTT3K/ytKJAvZCmVVL6iNn2a6jiXFxoh4aU
	G14ArtcTcKme83RwgIwjEOeT3xeYWQ1mZCBWYK7vFLkx8MSH8EQYWBTVnR1kcVLEqNbK2GHSDPk
	tfMBAFXZSpeWr11cEvKdpUi4xhKE4H5YE40I2oS+g09lZYV83VkAig/wafY8/eVvbxvQRvVbf1R
	b/HqTpe27HfGk/Xn7IgvXneC9t3vQcg9nDODiuh845letXish8/EM5Y/e8pUR2pC5iD16jGFWA9
	fj28rCTUuE+2bABTiWScJslyKCcS7jR2/Q8ISoWx+xxIVgL38owB68TrrOq7nh/4d1e3tBI8DeH
	0Y/68C5enWTljkM0Lr+PVdShL0feiKEWS1gGYciZE3KAFAXiDKZ0NDT7ox11TAww==
X-Received: by 2002:a05:6a00:3cd6:b0:847:4b4d:61c0 with SMTP id d2e1a72fcca58-847f6d59fc1mr323602b3a.11.1783097567118;
        Fri, 03 Jul 2026 09:52:47 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.215.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b609b8sm98267b3a.5.2026.07.03.09.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 09:52:46 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/3] net: dsa: motorcomm: Add LED support
Date: Sat,  4 Jul 2026 00:51:44 +0800
Message-ID: <20260703165241.542195-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304619-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A37A47046F5

v3: https://lore.kernel.org/r/20260701155519.273212-1-mmyangfl@gmail.com
  - fix null pointer dereference
  - support polarity auto-configuration
v2: https://lore.kernel.org/r/20260629183137.541341-1-mmyangfl@gmail.com
  - allocate LED structures only
  - eliminate double locking
v1: https://lore.kernel.org/r/20260618202716.2166450-1-mmyangfl@gmail.com
  - set up polarity correctly
  - do not set up .brightness_get() to prevent dead lock

David Yang (3):
  net: dsa: motorcomm: Move to subdirectory
  net: dsa: motorcomm: Split SMI module
  net: dsa: motorcomm: Add LED support

 MAINTAINERS                                   |   2 +-
 drivers/net/dsa/Kconfig                       |  10 +-
 drivers/net/dsa/Makefile                      |   2 +-
 drivers/net/dsa/motorcomm/Kconfig             |  17 +
 drivers/net/dsa/motorcomm/Makefile            |   5 +
 .../net/dsa/{yt921x.c => motorcomm/chip.c}    | 218 +------
 .../net/dsa/{yt921x.h => motorcomm/chip.h}    |  14 +-
 drivers/net/dsa/motorcomm/leds.c              | 607 ++++++++++++++++++
 drivers/net/dsa/motorcomm/leds.h              | 118 ++++
 drivers/net/dsa/motorcomm/smi.c               | 157 +++++
 drivers/net/dsa/motorcomm/smi.h               |  88 +++
 11 files changed, 1018 insertions(+), 220 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/Kconfig
 create mode 100644 drivers/net/dsa/motorcomm/Makefile
 rename drivers/net/dsa/{yt921x.c => motorcomm/chip.c} (96%)
 rename drivers/net/dsa/{yt921x.h => motorcomm/chip.h} (99%)
 create mode 100644 drivers/net/dsa/motorcomm/leds.c
 create mode 100644 drivers/net/dsa/motorcomm/leds.h
 create mode 100644 drivers/net/dsa/motorcomm/smi.c
 create mode 100644 drivers/net/dsa/motorcomm/smi.h

-- 
2.53.0


