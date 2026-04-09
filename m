Return-Path: <netdev+bounces-277075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yISFLYPe12klTwgAu9opvQ
	(envelope-from <netdev+bounces-277075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:14:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D763CDFBF
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4413A30136B6
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 17:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38E03E1207;
	Thu,  9 Apr 2026 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoq1MJh8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A0381B1C
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754742; cv=none; b=LlzdVOPheJILXx+2zt2ZQZc4QlmH+SjQ2NrRvB1m6UXLgeY5BOW7rW6Nv9jVq3cjf2Vg4iD7OyXFa8I+mTim2f4kVufU0FXiV02WVUY8PL1iQzjSiCVk6r/lVNrNNKQqRg08HYs9G136Mw7d8qH5x4aMaV1mKdhsuSFs9h/j+4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754742; c=relaxed/simple;
	bh=QF3iY7CqDNgcd1T6WjFSxM1g9tmBRydmmThE8W/HdmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hY9J4GoiYDhZRJNJVPpK3ASRTA3XxVbeDwPyS+0xyluN5oNEk59Y2aouZylsw+UvnOelOc1Nw7YZ381GlKvdKyxCg/F7Wz5juaMRsCgHz1DbEa2HLbN/Ng7licheFT8UiXvcuIcEEXPreLbJcV/Ry4n2X1q7T1Fxq3PMKuz5kEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoq1MJh8; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso519771a12.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775754741; x=1776359541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VaiK4j5XVQDTsUSq1CWhv40S4wl46fj7jEXtZdEh3v4=;
        b=aoq1MJh8aYMcHTy6KRvTJgt5Ep5hph7op+QOnoiT5mDafqsZHCDCeMfglXYnhLYnL6
         zlBgNWAqpTtdNlURHP7lWbGtOQ7CFJoAYWwz0AU257A0ov/HQyZTV3QS7P78lNNVacqb
         8QgataVAoCLvX+B5IIxvc/7rrSGLBWAa09LurD/FqBgak3RLRERNrz+PeGSj5fODaBVS
         SBJd+sUyJyRIINb4GCd9PjiZQBUSiSbz8Kh1/FOK+jvxF998nhud4CYW9cXjixPMaZ5c
         jMGnhSDOb7VW7JL5M9UIto5ioiGFpgQrBJftXIm9Y3P/PcgU7zmB4JlUExcs3MfRcKRo
         YjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775754741; x=1776359541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaiK4j5XVQDTsUSq1CWhv40S4wl46fj7jEXtZdEh3v4=;
        b=FVlqUj4O9rIBVhOyXyBlg1U9BKZpKhNVdKvP3id2nvq7oCBwUQd1ZlKMW0e5SWpXsy
         GbBhOva4vfI0DiGnyhLNY/x2HUBNZpL/COmuIfGQ/mVeSVCNO0pFbDedLKsYxsCWY2hA
         jAG1MngajNfG+QdhNlo+FPjpfHnsIA04z7+GeQLKFAIgzOJBjn72FEzUn22bGPEGnecP
         xsCJt1dxX+q5JgTrhs9v290GnzXpUP/2qNAzXhAAU7+vGGdVUTb7M5HzcmHVFIJ5d6jW
         oEeMW0EsXUnFRpmyd9hmwx68tHRnyDc5eZvu0maYTi8ijxxMAuOZtwCVc9mgbAq7ZjKs
         pNzw==
X-Gm-Message-State: AOJu0Yzqgmu/A1RafKMiNu7XpF3eg2rbdn56bhiqZQU0WEnaLPbstsDV
	YGvhGyDCWqkIkQlthZUCs5U3uuWPjSChLgg1k4LrBXor6n3ZWgq67mASS6lBHYEN
X-Gm-Gg: AeBDiesqhmPHAEK7kqlBhn/kOTrB6obRZ5TctbnPiyYQ6zmN3pz7KsAsAE1BTWbfKhE
	gqkcYcAtHFX4SnHmEDxEULHORl0+IyWRrdBfjnzAvgzcG1sVnmzHs6TWI0y+oHxgJyMqZ8hOH4Q
	heF3KEyVqieZxB7YNbT+42T4s6NaecZpV/qUMvc/NS8yfYaIgoTzdItV3UiEsHXEE1vkArvpWRr
	6pz4IUlzDy9X7ia0mfOzLdJesUtrwFuKAVHfzLdNJbaZRE2Yla7RxDZ6wBs0n2VOhYweaFLv2gr
	zbV0LrjlE9iTosWC4yrTo/riDzhNaGraTt3yAekybtRhOKx0EMjjrRfjDuFmfVj4/ETupMTKr9s
	cwHkFOCAYy6FYwauJMt1q4VtgkAnLj2c8M2sORjNdr1/F3locgd0shVmMVmE/TbWuqokUK8tSbL
	Rl9Rqz2piVy6agRE2djgaUDKrYSyhpJIB5/2Tzi8WMbS38E8qR09sCv3eYsoc=
X-Received: by 2002:a17:902:e549:b0:2b0:afbe:4e14 with SMTP id d9443c01a7336-2b2c744075dmr49108025ad.40.1775754740311;
        Thu, 09 Apr 2026 10:12:20 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f08d1bsm752395ad.54.2026.04.09.10.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 10:12:19 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	UNGLinuxDriver@microchip.com,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v4 0/4] net: dsa: yt921x: Add port police/tbf support
Date: Fri, 10 Apr 2026 01:12:00 +0800
Message-ID: <20260409171209.2575583-1-mmyangfl@gmail.com>
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
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,nxp.com,microchip.com];
	TAGGED_FROM(0.00)[bounces-277075-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 53D763CDFBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v3: https://lore.kernel.org/r/20260407160559.1747616-1-mmyangfl@gmail.com
  - explain long registers more accurately
  - fix missing packet mode flag
  - rearrange function layout, in preparation for further patches
v2: https://lore.kernel.org/r/20260402223437.109097-1-mmyangfl@gmail.com
  - refine commit messages and code styles, no functional changes
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
 drivers/net/dsa/yt921x.c               | 621 ++++++++++++++++++++++---
 drivers/net/dsa/yt921x.h               | 155 +++++-
 include/net/dsa.h                      |   3 +-
 net/dsa/user.c                         |   2 +-
 6 files changed, 712 insertions(+), 75 deletions(-)

-- 
2.53.0


