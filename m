Return-Path: <netdev+bounces-303535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PaNdLWvNRGqL1AoAu9opvQ
	(envelope-from <netdev+bounces-303535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:18:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D6B6EB059
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:18:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WjDfDP4Z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303535-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303535-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D32E9302D532
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 08:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCD73DB64A;
	Wed,  1 Jul 2026 08:16:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2063BED38
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 08:16:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893772; cv=none; b=ulXDK7l0w7mpIAvtKgtAXLTe62Xby8iKsymL1RTrr/0JKXsuKWwSwXCBIXZZCNQS/s2dutZLyX9SZaXGl4l751PI7JKEGdtz8PSnbZejguQe2exsg8sjqXIC2SzYxH+I0BgRaZ3aEzKxSmZAKRTIRLHTwDyn6NigUeAJukHPql8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893772; c=relaxed/simple;
	bh=pf1QWDXhMYL20UxS/mMqz7jezfCagvi56/5U8+X7tLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cPyUAseh3YsyenbTA5JGUaAv8K91SuylaiNWOMK5O2526W2UIXpxcch/1oIV0jXwqE6ysgVOQ+JYBp3Xvp5RI0P89FB6ixAcPcBa4B0ChaFeHSxFne7WqUa9w1J68ld1zFXBVIBqWHEBeuK6Khwd70zB18yO1v3azkhkRDmsWvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjDfDP4Z; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37ffdc718f8so212039a91.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 01:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782893769; x=1783498569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ngV8Jl8AZDpMYL/oJH4qppFmLhNe0rga/oROjLkaA/U=;
        b=WjDfDP4ZAFmI1uFTaWvCLK0UcLUtQywwHLb/xFBoF6lYEpl+JDWBneZEFDklzxsgBi
         Fs0wtorS05VUgClTCA+uyiKhPMjHtM1Qk3vjPnw1fqB5NvLM/WYvsPub9YkwRXb/f+F6
         m1R/mrgzRPb2x+8Ez0Oyrd/gsBiEHD2G8FsOMqTY6GUxs/+abhw7ioVeCewwpu6LnVfS
         W3wS3y5Dur4cLpC2z9nXHQblBy88Kpz9NQhDB03C55g+Gx1Pp/EOGH2fNMkPbtapLpji
         lTHiMMMOo84k1KpMLir4571COdRpnzIQKYL1tLCSdbylx0qHg4ZBVLOQK+lOMnV5MCTa
         NP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782893769; x=1783498569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngV8Jl8AZDpMYL/oJH4qppFmLhNe0rga/oROjLkaA/U=;
        b=dh+m2/pMpPvvGF1RPWNOjQLvjh5SB32vi/ak9CyfW3iQvM9eTPRk0hAYACIZvENmL4
         zK9ck1X/ivz582tpcBo9XBrVzT2wK6zFFPnt7mTVS/+Qa7ybzgfxIIypCTifNMAHytjG
         Zdc586Xc2M/Rb1rDvEW+97dqS5feIIFyH31S6ar7EuYxxciQdNZYgXS7sZM2P1XS4Usb
         ZJe/Siv32YBukGdWO15bXjqXL2z91irF9ObhPrJa88ci4nr/ZP0fsJjW9wRg50pCdbTB
         kFkUKpjKr1ersmdZQL4Lso+gr4aNL0h+MdAGDQnG3jIW66SR9j+KFxG0CSA7nporwMlr
         C7PQ==
X-Gm-Message-State: AOJu0YwVOnJkp8+k4n2XI+qXYXvWGsMcEOP+j1oPfAVyX0fMGdXJy8R2
	NGaj3L/dc+BKKeCAAMQKwQqWYmED6njjOsC4Yh4GmL1brvLWHGViLyj832MdIA==
X-Gm-Gg: AfdE7cnLj1cJKMQPQ+DlhSy+hHP68pJeqpT34pvfPA0r3543u0SjhW+Fnisc2obnX69
	5REzAtSbwAbasqRBD3JEsbKwll1sQYCkd+gk/6d88EEVhG1fXPFA8iqRqrUypD5iy+xPVqaZ274
	2FoL/bszrXrWldEe29Ax2leYc6Dlvzf4mlL3YZNy7zZNR9nX4pfhOReJA5uZPs0/Y+gGBuRY6vl
	2yHGh9jMYNwckiwdLEOloYkSb9jb+fCQ7rZbDjMYHd2OmhilFy3rMGXSTKZN3FVc8F2w13x/0gl
	QJJkwhU9CcyDwWi/EnPM/1KaflJEiucD2DXwEiuxt6U/EYlxZNELGPfUMzq9s9DqJGx8UrcLQvv
	25/dPfS4I3SCXwbRPRVpcnbXvTQwy/giRE6N1yp1hM+/ZAGclhEcSjSWlnJp3BY3DsEA9HEAVZL
	+5GDBd9Py2M4OibPOV
X-Received: by 2002:a17:90b:35cc:b0:37e:90c8:53ea with SMTP id 98e67ed59e1d1-380aa0dc373mr654609a91.10.1782893769549;
        Wed, 01 Jul 2026 01:16:09 -0700 (PDT)
Received: from amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3809641c894sm1364627a91.11.2026.07.01.01.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 01:16:09 -0700 (PDT)
From: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
X-Google-Original-From: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Paritosh Potukuchi <paritosh.potukuchi@amd.com>
Subject: [PATCH v2 0/2] Add and use neigh_parms_lookup_dev()
Date: Wed,  1 Jul 2026 08:15:58 +0000
Message-ID: <20260701081602.3185086-1-paritosh.potukuchi@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303535-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:paritosh.potukuchi@amd.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[paritoshpotukuchi@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paritoshpotukuchi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15D6B6EB059

This series follows up on a previous submission where it was suggested
that neigh_parms_lookup_dev() be accompanied by its users.

Patch 1 adds neigh_parms_lookup_dev() to expose per-device
neigh_parms lookup outside of the neighbour subsystem.

Patch 2 updates bonding to reuse an existing neigh_setup()
callback from the slave's neigh_parms when available, while
preserving the existing ndo_neigh_setup() fallback path.

v2:
 - Convert the previous submission into a patch series
 - Add bonding user of neigh_parms_lookup_dev() as requested.

Previous post's link:
https://lore.kernel.org/netdev/CAAVpQUBf+asQukcRw7sJz6vS2VdeNO5+Q5ucoCxf4JgK25nZ7g@mail.gmail.com/T/#t


Paritosh Potukuchi (2):
  net: neighbour: add neigh_parms_lookup_dev() helper
  bonding: reuse neigh_setup from slave neigh_parms

 drivers/net/bonding/bond_main.c | 10 +++++++++-
 include/net/neighbour.h         |  2 ++
 net/core/neighbour.c            |  8 ++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.43.0


