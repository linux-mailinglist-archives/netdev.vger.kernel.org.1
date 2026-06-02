Return-Path: <netdev+bounces-294085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GOtH9SXHmoAlQkAu9opvQ
	(envelope-from <netdev+bounces-294085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 10:44:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0292462AC8C
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 10:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8864305F143
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 08:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248D53C7691;
	Tue,  2 Jun 2026 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzzJK7l1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2577737AA87
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389506; cv=none; b=XbHayfmeUpVhsbHde7bYP70MhuNcKY+zSvLo0zM1W6orwWIt6Dmpo3EqMgXFvvCpk2IY3UgQumvuSPlPMiaHXrbT7OnpZCPj+cTgI2kkx4/IKJIrF16++YwQdsHb1n8G+RbpLC2sFWpuRvx6NYje7IZAmtiSc4jjwq38UAJ32tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389506; c=relaxed/simple;
	bh=w+yMBZpwyyXUq9jqY5NkdSAjFXSFxVkrStfj5v55WYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CE2lighoGASzjPTAINXfa134KG8PdXOhC9hA6KG7hbx/V5J5CJStZivBLGogCLKHAHTGhr/19e3ONMICJ7HPiT9lraIaLplQijicv5k301FgU5j2is7czSOet+Jvm2poQ1D4wH9yLJlIXQB9APDNTLUf8DEIajHgvM8x8X7txGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzzJK7l1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf55c39e16so11585315ad.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 01:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780389503; x=1780994303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nIRC05EQPZvFLqMOEmD9O5/sDJwRmx49DkVzc2KEVlQ=;
        b=QzzJK7l1UiCsj2Dd12cwUx9eZGFmgBPSPJD7qu8b3djSNl3b9EH7L3aUlZyUJg168T
         2MgnWPq6++dvIASFhY1mx9aVCLxtfC1LFKzyNXKXA6nWaNI5V5iHIt9xAcJjphysJ7ad
         HQ2/6rMzDW1iHThdeSIeCARsuSkatqKib6Md9ZX+H3pD+Hio57tBhmO8G9qJe3WK1Rrg
         F9tOvJSuRDVtWppHmG7+vAvB06+MiQfed0aqs9Vdt7ZDtRM/XLE670quOwa60YjS5eeg
         kAw5CNVnh44zF9FRQfxVhLIj/dvRA9HX1d5jV7L3XBEerNpJE4R54huA25btFtdeeb8Y
         sc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780389503; x=1780994303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIRC05EQPZvFLqMOEmD9O5/sDJwRmx49DkVzc2KEVlQ=;
        b=SOMiZsYt7waYlCrMV5AtNrFEItnOVjFGpGGGjl16NgpoGqDueN0mhGDuKGQFTLGFQ1
         XGbWa5sAswnTmdiaHYiPUxiwOhRT4TcvpRP6N7LBNxAQn9STNbuWHh9J8xys1sEIpl8W
         /nXA9eIku0M5M5B96TRx+DdPlrC8+COqaCg1/9rz8KyaJYUnB+LqFfW4Ov6YDiUtMygk
         PQQSBuD/Ji0FupecA1rt4zis67MEBOAHXac9ybbgfyqod/RcQ3YHgpLrsuoDQT8YXjqd
         U5PTCrgI1Pqz/pzKwIEs9ibmTktxQJWMTsWIVmkh6BPHW5SOkgKkJkv9GZxn3EYsq1Ec
         E+SQ==
X-Gm-Message-State: AOJu0Yw4mkyEMKQJZ7GciVqWLS1WdSBQ/JZypyU3GSbg0psXW9EQzlJ3
	0rdzjAgiF1WpH/rxRJc43vzRiCfyfU/Z3XlOmzRdrF76DM+n8alvy5TngqR2mzP/
X-Gm-Gg: Acq92OFy/x685fsWer0PudF4ZBqXevQqhH9wj0faVNUgWcQaqmMzGmeE8X7NPjnTdLP
	Vxc46DTGMFV5U20QNBHxeofQ8Ia6qgIjBNez0IknKL0O1s6e9Hp9PMV3DcJNmsuc7XWNonBbgcF
	jJ4MS35lYocuuXbbA6DTVk/OUXIpWcPREN0A3c+n32EncpVHPNjWKg8cCNx/tctnAr3uHWgH7V/
	y5Cf4dpo5Yxculo1HaEI5JcgE+YLn06mj9kTShxTFcGoGL36MU7m+y0gn6TTY/Mnj7SxXBQqJej
	XAkdRfg97Bh4+dOKsrE58BhXqSumvMDZgs5aJbd2q7PgA5TIO+opkXrBAsBfJhCYYSsbg0MmHlU
	egL1UvDl9TU5dg5wRtxk2127WiPnsu8z0h+HyFLqyaBu3wQAYfc/jSlBkVXjBP+zeFcuKJ32cG5
	rGk/sBzAf1OBmg0JrzV3xJEts4WHnpe35UqK7dqTzCetQILZyYxlF0zc9rtSE=
X-Received: by 2002:a17:903:1984:b0:2bd:2c3a:2a36 with SMTP id d9443c01a7336-2c10cb37cccmr27132345ad.0.1780389503336;
        Tue, 02 Jun 2026 01:38:23 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a10165sm122804285ad.31.2026.06.02.01.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 01:38:22 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 0/2] net: dsa: yt921x: Add ACL support
Date: Tue,  2 Jun 2026 16:37:51 +0800
Message-ID: <20260602083755.79411-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294085-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0292462AC8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v4: https://lore.kernel.org/r/20260528193726.1893365-1-mmyangfl@gmail.com
  - make use of software fallback
  - guard duplicate POLICE and PRIORITY
v3: https://lore.kernel.org/r/20260523020704.503966-1-mmyangfl@gmail.com
  - handle ACL tag code
  - fix the upper bound for FLOW_DISSECTOR_KEY_PORTS_RANGE
  - extack messages when possible
  - check the redirect target for FLOW_ACTION_REDIRECT
  - fix candidates overrun
  - fix the activation order for rule and action
v2: https://lore.kernel.org/r/20260520022242.120640-1-mmyangfl@gmail.com
  - v1 was mistakenly sent as v2
v1: https://lore.kernel.org/r/20260514192140.3468543-1-mmyangfl@gmail.com
  - fix issue reported by test robot

David Yang (2):
  net: dsa: tag_yt921x: handle ACL tag code
  net: dsa: yt921x: Add ACL support

 drivers/net/dsa/yt921x.c | 1052 +++++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/yt921x.h |  286 +++++++++++
 net/dsa/tag_yt921x.c     |    2 +
 3 files changed, 1337 insertions(+), 3 deletions(-)

-- 
2.53.0


