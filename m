Return-Path: <netdev+bounces-290862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGAWNdJrEGqgXAYAu9opvQ
	(envelope-from <netdev+bounces-290862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:44:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5187B5B667A
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A256302733D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAD04534A9;
	Fri, 22 May 2026 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5RMHl5p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D03428822
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779460530; cv=none; b=TVP7WRgXaCsEXz5WH7qLfmFpRLcscSErXFLOQ6DsbLkB5J6oTiiUt0AnJ4q4onsVv5W8Dlg2IocrVay+oQb6k5lgG9pZgpNPNBewofAXszAeea4CW4TCTh6CnRV0Xs3hVdFd/u5iloc7hYj2g12GBL2HWUwJjshxmvgeH5AIHB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779460530; c=relaxed/simple;
	bh=0pZys+wSoBiXyitprUTSmHYjxXUAnEro2EUqhD9ujBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sqeK6kJ7zhg3ubdfzSxpmG7o7iUz7WSusFmnMq1ifDo7jM8gudhQLLbLIiEEsv1Dit80ozYIXRKenXNcz+bUgduNBgK3ZCr4p3U4I0cfpfvrONJDBf10akIWDL41P8Gq3QZuHbtdcZ/MD3tpKLs9TS2fZ7vWqCtBm55sVuJvC2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5RMHl5p; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b458ca2296so53121555ad.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779460527; x=1780065327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jKonkuXrYPfMqzp1yI15CcQn2/09bEE1ZzQIuyKgdNk=;
        b=C5RMHl5pzIPD5LgoIxP0yOiPl0Rq/hQjxNaXPgMkng3yzxTuN4p2gJGYnxhLJ0rZGL
         n4uHQsUFkbaiJnJCX3q2IaSqs4AQtQO8LC9HG3OPNdRZtFYKrb8I7JMRrma09jztRvo5
         7BImYjwC/V0qZ3CiV6Zbb00gMTj51eP+woMOzk4pYeKXsq7S7qImvLbcvXcKDEo+WZ41
         fwc6Egsvbj5NxdZRCti0IUwqUKLAo1M0GIs6Qah1x+E2RbqptESIjrS/7WUTGowuuikw
         A3InsNbPIjs/3O2NoHWKeeTEkRiNN4fl03uxUQdfH+bGNhVa5rk+9nRZf9txWoqNEr7y
         dWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779460527; x=1780065327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKonkuXrYPfMqzp1yI15CcQn2/09bEE1ZzQIuyKgdNk=;
        b=X/JbQob4nv65V+11Ld/R/hx+2LIqxfrsLMNouVLGEc43Mpd4HkZDbczmynqt1u9jUb
         8i5u9IeHfyePFQEMNh9T0p/sCMJLZ5b7JYg8lOtk27KxhRyYKs9dY0uFsPogKdI86ess
         yzFSQPp/2ID+sfG/RCEqlcSw1745RC6tZpFJCa8lBUbBSJWkFLbJxfIpgn8HI794XhXx
         ztE6CLF0vdCLoMVUfyY462j8qG0sLGg6WURTytMzlaen5C4Vfgk94eFM9jD+FMVAYw81
         ljtI61NgtP1Ikr0QDSenHVkNtmmS25I3srtMjGYLw9FNSI7H6QQsTsxkiRyh5C5qDZ6A
         8WnA==
X-Forwarded-Encrypted: i=1; AFNElJ+iEN0KvUvCctsqpl6ATlTLlT5qq8JH/77vHH6XGGK3Lfsfgl9xXk86Rtg3hxY7aSbsbpgHZ7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAtryPgddlnWGGfgELZCQg3w6scS13FU/+VOCDjPcdiseljbOe
	8+b2SPGekdqw5RpbjZZ11Uro1FpLLBF6yISybTfc0HhHrmF6umFShngl
X-Gm-Gg: Acq92OE2oDEm4TBhJkVbRKWb24/aaxTbR+2Dg4lIIh2HX8CqCgVAurRp1x1qXO39wnw
	RNvqkOkFiU9ahLTJlMUoyjImcEo7hRwgvTkrtj/+fuSe8x9XiKXJmCGfKPmLe+2pdxPPyGSuMpe
	rCMDihiSwvi3e7Z6HLT3FkigXXbeK3DvngbL14Zckkw1nmmKQM1oB5eQZxkRRJ+bz5df4prCvRB
	tw8OPHDdoF9gUbokjVEL4G2X9cEaaVZPfnHBqdUjdQ501gA3QuFbtdBminKTGGv8b9zV6rL0v5P
	D5NOrSXTPPfUd9JMCh30Xy5BxlT3xGrNxPNxd6VLIqAHGtu8BYCT53oI/mpMoeim17bi6IJr59e
	b5xG+013q/Gz4cWgvI2H5zpQGH2vXtiDyHadq4Q13T9VpdV0txvkq1wpzNaGg0yHpXWMhKYDiNg
	DqSl9n4IDtHzp+xX1uwFJeblYAOqgnmXmlMm9dzmjFDsqOyhe/5e+JnspF2Aw=
X-Received: by 2002:a17:903:1a70:b0:2b9:ec37:2977 with SMTP id d9443c01a7336-2beb06bf9d7mr41912025ad.38.1779460526938;
        Fri, 22 May 2026 07:35:26 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b2cd6sm20600225ad.52.2026.05.22.07.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:35:26 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Nishanth Menon <nm@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: List iterator used after loop in netcp_register_{tx,rx}hook?
Date: Fri, 22 May 2026 22:35:22 +0800
Message-Id: <20260522143522.83473-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail,usenix.org:server fail,maoyixie.com:server fail];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290862-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[ti.com,kernel.org,gmail.com,lunn.ch,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[maoyixie.com:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5187B5B667A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

I came across what looks like an iterator used after the loop
ends in drivers/net/ethernet/ti/netcp_core.c (linux-7.1-rc1),
in both netcp_register_txhook() and netcp_register_rxhook().
I would appreciate your input on whether this is worth fixing
or whether I am misreading the pattern.

  list_for_each_entry(next, &netcp_priv->txhook_list_head, list) {
      if (next->order > order)
          break;
  }
  __list_add(&entry->list, next->list.prev, &next->list);

When the loop walks the whole list without break (every existing
hook has order <= the new one), `next` walks past the end of the
list and `&next->list` aliases the list head via container_of()
offset cancellation, so __list_add() resolves to inserting at
the tail. That is the intended behaviour for the case where the
loop falls through. The dereference of the iterator after the
loop ends is the part I am unsure about. Same shape as the
Koschel cleanups from 2022 (99d8ae4ec8a tracing, 2966a9918df
clockevents, dc1acd5c946 dlm, and others) and the "controlled
container confusion" pattern described in [1].

I drafted a candidate fix that initialises an explicit
`insert_before` pointer to the list head and overwrites it to
&next->list only on early break, then passes insert_before to
__list_add(). The iterator is no longer dereferenced after the
loop and the diff is 12+/4-, symmetric across tx and rx.

I built netcp_core.o for ARM with keystone_defconfig at W=1 and
the object compiles clean for our change. The W=1 warnings that
remain are in netcp_ndo_open() at lines 1601-1662 (snprintf
truncation) and are already present in the file, unrelated to
this. I also ran a small userspace mock of the two versions
across five scenarios: empty list, single entry above the new
order, single entry below the new order, multiple entries with
the new order in the middle, and multiple entries where the new
order falls through to the tail. The final list ordering matches
in every case.

Does this look like something worth a [PATCH]? Happy to send one
if so, or to drop it if the shape here is fine.

Thanks,
Maoyi
https://maoyixie.com/

[1] Jakob Koschel et al., "UNCONTAINED: Uncovering Container
    Confusion in the Linux Kernel", USENIX Security 2023.
    https://www.usenix.org/conference/usenixsecurity23/presentation/koschel

