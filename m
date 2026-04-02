Return-Path: <netdev+bounces-274716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DmUKV3vzmktsAYAu9opvQ
	(envelope-from <netdev+bounces-274716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:36:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0A138ED3D
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE0B43017C3F
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 22:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9745D3612F1;
	Thu,  2 Apr 2026 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoS4Fc7n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE7B31B803
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775169296; cv=none; b=FiSF+6/TbW1RE46co/qxJaNCzsOBM2axJPqjU0bzwsbuZC2h1vqdD+CcUa7E2bDsDeDhjPicUlnr404xtKmeWTmL2L3cGSIHFzTlM6ByTyGnpMkrsxVMP/4jczWzPI0LS/BpKJJKs+WD+TJkNKcSfoaRzdNro+EO6jOLH0asS/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775169296; c=relaxed/simple;
	bh=ytqHoewpDoWprWOJpWMpDdykjHZyX71yM69kwZz0v1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mMM28ujI5eHtGL1ErmXLgGLZ/HLh+nDYyMd6WGAqVCM4SD47Pm5v2rJmRUtu8S9hk3VMM92Cka3z971yjxcZpeR8pSchuuxlo/3UCVivwHLSwzjeDFUu+dG0EfqXxsMMD3lRtQsFal0tzY6F8Fytu1zluOZao1qzPxFbjhQx9Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoS4Fc7n; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-823c56765fdso709903b3a.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 15:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775169295; x=1775774095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JcBmJfLfAWelbwpRC3O8F3eUowagx0t5Nc0LW1uzwP4=;
        b=WoS4Fc7nplgOM/yxd97CFRUxaR3KiKYHlBO4Y9+aERFsir97CoJs6w2ah9xAfLHRfz
         S1eDv/Q293ngeSQVsd3EPCjRLuMkLplZVi7PBsZeAAQUJ2pXvM0fJwwf0uCCT0sFZjGb
         l0FrjvuuONc6CZkUSmrcf577MVQGEWRk0Ct6nlMZ6G7Mr7KFVXbkN1W9rNHBhNR2G4uc
         PZp5dNJl4cik3cGD7IfNuMmHDMyAJq4Z/SGpqrl7ZRgBvovHSQeY//zvR71POafAwaXr
         BuHQxa49FQGlqS9CdIJoOHhJekpQNrj5rVWaiNLNydJAYNpJERIgQUTa511ujt17bu6G
         dZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775169295; x=1775774095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcBmJfLfAWelbwpRC3O8F3eUowagx0t5Nc0LW1uzwP4=;
        b=YJI/wsPQXq2nCsP9L2pfjH1emp0NPJVfzO7RauMMyFYVNP/pIat8cppQj/xCv7iIl2
         dBkU44Kjg8BfVBGkLDggFh/m9vGmrF+GbdFy3kfRpG/IMXHtuxP2RQpMtqovdS5Ubah2
         HkFQ7PdxB00CQSFzDXFSn2wgXbt5RyZoHnzPJn7WmzIeNbpZcWQDgYU38m8JmcdkHQ+2
         0wAtOL+hasr525hOcP7ZYKWRL13h+XZaBzo0u3h3YI+f8dwqhhAMnJglL1ImXWkNUX/P
         Clud7PEzqnkfOE3vwx5/v9XU1Z/34lZiEB5tV9juXB/xVU0t/YpIMfDUHrBLdHvD+MQV
         549w==
X-Gm-Message-State: AOJu0Ywizi6AIk0RJqECWgXUuJQIfsK5roGLDdUeSM3wLVYSapru2TNr
	ywlcg9Y0NAZ4hUyQ8CN0kWPFK85PNF3bJ65IaqpQ6+kRkkkqs0i5kdymWLEe9w==
X-Gm-Gg: ATEYQzznySQXTRGa1jy3M+RnTh2Y/YnvSj+BHYzwxxJjuONG2XEC6vDP/HUojljRcX6
	pIX/THAGnq8F1sVmVf4PYhiGx4zG85NVY3QziiPAbGOYS0ybi43l758sJ6it4vP3g295xJzQSDP
	cVe2xiV7yuknnWmE0iWW5NGxG9JHY7RFokr/wY2iaZ4YxUnRiwofkNC4q9VLG9TGAaM9ICla4KE
	LpumvwA9uX8Stx+eBPFGilVDsQq5sh5HiswQfxa0tDf12OXLESiXfN0nZhkzEqIbfn9wNUJf38o
	Uj0xBMxsPZgWYrOgrjzpFJpcgZPLwqguWx/wH9IjBDCUL5lrmE8P0E5JpfMYQbmYmrUJw8AE6Dq
	TgmAsss4pHe7wst33uEX+OIMrx3L65ahalfE2+ZLP63Z/UAPA7KUH6/DCjZpraBUrDOzCPwqNbJ
	xXxotTMispvR8iePl+o/69gKqSY4pU76ckB5itqk9ct1F+wdXOzlc80fZ0U/xX
X-Received: by 2002:a05:6a00:3e15:b0:81d:dd3a:b8f5 with SMTP id d2e1a72fcca58-82d0db9ca66mr766617b3a.38.1775169294653;
        Thu, 02 Apr 2026 15:34:54 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661f:3046::4cf:90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca1f28sm4294291b3a.57.2026.04.02.15.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 15:34:54 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v2 0/4] net: dsa: yt921x: Add port police/tbf support
Date: Fri,  3 Apr 2026 06:34:28 +0800
Message-ID: <20260402223437.109097-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274716-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D0A138ED3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v1: https://lore.kernel.org/r/20260225090853.2021140-1-mmyangfl@gmail.com
  - pass extack to user tc policers
  - keep reg64 helpers along with reg96
  - avoid macros in favor of functions
  - adjust log messages

David Yang (4):
  net: dsa: pass extack to user tc policers
  net: dsa: yt921x: Refactor long register helpers
  net: dsa: yt921x: Add port police support
  net: dsa: yt921x: Add port qdisc tbf support

 drivers/net/dsa/ocelot/felix.c         |   3 +-
 drivers/net/dsa/sja1105/sja1105_main.c |   3 +-
 drivers/net/dsa/yt921x.c               | 569 ++++++++++++++++++++++---
 drivers/net/dsa/yt921x.h               | 155 ++++++-
 include/net/dsa.h                      |   3 +-
 net/dsa/user.c                         |   2 +-
 6 files changed, 660 insertions(+), 75 deletions(-)

-- 
2.53.0


