Return-Path: <netdev+bounces-254474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK8yIh6Femnx7AEAu9opvQ
	(envelope-from <netdev+bounces-254474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:52:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E548DA9437
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B5C13019815
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E4B33B6CE;
	Wed, 28 Jan 2026 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AInrgvGL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECB6326958
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769637135; cv=none; b=T0BcTl8W30GSP1cGa7YHWnkC8Xpo1ameTx3NGEJJ+dnqTEtEJw2vxQ705IOZIQJ1Suqcn2YRha67CKIOmsKAzomL0QrB4KzK2h+Q6eggmX782sOi18NVlDgcIrUB/XQMn6/Tyz1mL+tE7D5/kNSI7w5lirjalRoThittas1Vpt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769637135; c=relaxed/simple;
	bh=Yd6Ch+v4GZViDs5TkULydV2wlpCqS/XMlsbQ3DO50EM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YFinO2R3Zut6Joy7n2eR7Tztn+N2LE12iuwMxprZc9OtCdYTGiUnn7O/maFz//g2g1tXYOHakjQrMe6Fx0jrhYv2qAi+vDydsUMj+BJnMj1JreBNBJVllg2hRO9XC4ZqjG1UX59rXo+nWNsha6ISFPyxnhB0JmcLVsOLsH4UCwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AInrgvGL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a79ded11a2so1631235ad.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 13:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769637134; x=1770241934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zUHdprwswdWIcMlOfLpGdDZqB9fyK1LwozCf/2fGtLc=;
        b=AInrgvGL41Hv+4VTfZ52ikOsIujN5UK7a+wtNY5rgRd/l+FuQb9ibqBx5FTUzBqMtK
         uF3sV602UodL5/vfo2YyfvshPIfCWBg4lakA6vNAhwqMlcX0bvYg3CqwiCyCVZtr12iY
         CFcpr+4j71oaqNkL6qZG667+lc8zzksZau+tvwDvDQ6kUNfqyaVdB72RPoacUO35fqWW
         Coqh64H5xQYVdDfQSRL0HkJwB/v3g7zKWNicI8/6b1LIHidqb3zA8esmbiAb9/QOjjH/
         eYnfcXGpPKIUdZw4uCUefMBbKjyUhfJ1OYbLPXs8/V/Fe49d9BMvMXxnweuTN/jWu4sh
         chwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769637134; x=1770241934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUHdprwswdWIcMlOfLpGdDZqB9fyK1LwozCf/2fGtLc=;
        b=qoOkJGMMVSr+mnI2ujaSLpRaapZNwx9vX/XZQ6WMn8O3Q85PEeM+qdcz3kBURsiS1c
         XL/g+UXW3lWV4n233ikcBwsmyIhk6RZ1F1ng42/7Eqywf0VwfZJuk5A2qlxalbwEr/Fi
         M0pBoW0o1iBX4MWpxjaitRYLRguuHVu37bb2qZ/h81n2RqUgwv6jvePBzSOXsP34tu1d
         rQT+sYDAODcH75XEZySAU3xW+PtcQYkQni+dXSNjZ8lK7SDyuTekzLvbb5yTw5RgdtIS
         umZd/ctlsbZ8GF3tqKwVW/qvFuEzpQNGBjPu1jKUpRjWp8uWONsSi92ipgLtp4jENCZJ
         hylA==
X-Gm-Message-State: AOJu0YxfQ1h8oYE/K0i5lfBNaRzmswH+FYZl+bLzmDqPU9L+5su3dAnd
	MSqFpV6wTfQZZXiJqkTqv8/yUbLQCdzLTgO4DOikuzGCbqWdQlqNUA9xi7Q0gyhV
X-Gm-Gg: AZuq6aKb1XOI4NGh/H37GoSsTRo5W0JuNIwBoWU8jQJQiYb1GMokt0S4ETm9wZ5SbHE
	y4I6T/IDXQkOQTSeOK8qMdSJbudsGMi095NPbkMxPkpciV3Wf4dXYrV5tQ0xouDNxV3UFZlCNDt
	NwqLe9nkjZCzYXFBrOJMM2VA7WmPV8IbR8u4QdfH5nioq1pB4DsZuKaXo8Sk/knsRDQy+MqtQwb
	mM3n8BGKjRutaEriNpJTzDNHPSBNaNMnwr+IXFRm0fD1nkLK1tCuqmNwQ37hzkWGN65Ma6sZZF5
	hgjKUD8bMLihmXji3CfllHPsf5mICM8I5FInOCq7R6RTf3Cnz/QmQkPeRIKaqEZ2sHuhtb91aYE
	9Cty5no/vIn3peYugCUJKcSJlJh5rg1VbZK4Vd9mu5JZPenDxX9NgKmg7KXuKMW2icyIjysRL+I
	+KVsMTYcJYJ9aww34lqf6Lonr0NiN1C3qhZps=
X-Received: by 2002:a17:903:906:b0:297:d764:9874 with SMTP id d9443c01a7336-2a870d5a24amr58301685ad.21.1769637133859;
        Wed, 28 Jan 2026 13:52:13 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2a09:bac1:7680:d30::4:384])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e4317sm31576155ad.85.2026.01.28.13.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:52:13 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 0/4] net: dsa: yt921x: Add DCB/QoS support
Date: Thu, 29 Jan 2026 05:51:52 +0800
Message-ID: <20260128215202.2244266-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254474-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E548DA9437
X-Rspamd-Action: no action

This series add DCB/QoS support to the driver.

v4: https://lore.kernel.org/r/20260127020847.1482724-1-mmyangfl@gmail.com
  - change the color for DEI bit and add a comment for it
v3: https://lore.kernel.org/r/20260125001328.3784006-1-mmyangfl@gmail.com
  - fix port_del_dscp_prio()
  - split yt921x_chip_setup()
v2: https://lore.kernel.org/r/20260122194233.2777550-1-mmyangfl@gmail.com
  - make DCB support optional
  - refine with enum yt921x_app_selector
  - add missing dscp_prio_mapping_is_global
  - fix pcp support
v1: https://lore.kernel.org/r/20260119185935.2072685-1-mmyangfl@gmail.com
  - rebase

David Yang (4):
  net: dsa: tag_yt921x: fix priority support
  net: dsa: yt921x: Refactor VLAN awareness setting
  net: dsa: yt921x: Refactor yt921x_chip_setup()
  net: dsa: yt921x: Add DCB/QoS support

 drivers/net/dsa/Kconfig  |   1 +
 drivers/net/dsa/yt921x.c | 310 ++++++++++++++++++++++++++++++++++++---
 drivers/net/dsa/yt921x.h |  55 +++++--
 net/dsa/tag_yt921x.c     |   8 +-
 4 files changed, 341 insertions(+), 33 deletions(-)

-- 
2.51.0


