Return-Path: <netdev+bounces-304686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F6kVLPqkSGoCsQAAu9opvQ
	(envelope-from <netdev+bounces-304686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 08:15:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E7A706D98
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 08:15:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mAHM1MtG;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304686-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304686-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C78893012C72
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 06:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C39B388E69;
	Sat,  4 Jul 2026 06:15:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B5E38C2C3
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 06:15:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145719; cv=none; b=GswhDQfRhQvE+7R/nWKgukan1sud8b+D/zwyIeJen6Gev+DD6I05CHXVtdQO2g9ma2AqxKilrQg4aB3QJF8MO3wVz+zouK3PKiuc/o/+D0KttD4OoWNiNrNqipC9UDtEfSEnogRSpR1AoZ0/LWlpNNEX/k5Y5C47Ksft/7mHyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145719; c=relaxed/simple;
	bh=WA2orcqFwjasE4YunpW0wC2ZXMXVQO9Id3jt2BqbbG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hInL4dXWdfhY9TwMzSzGNmwj6fWjifc0pzvIH7422xR3OJzdJEpXzpf7VwLQs1nVp8AsCeo6Vbrhthrw9Ee//Ynko6DtEsPjnEVnYPYZBdA95KHdxvxucIYamRLsFY88v24DDNZ1DhLhU2KiGIvvF9CEHEW9CIl78eD8+1ypPRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAHM1MtG; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38426d04bb4so60258a91.1
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 23:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783145717; x=1783750517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HY4Ay5Nu5ZJl55Ny6GfPN3/o65u/V2603CFmGcLq4yM=;
        b=mAHM1MtG4bmwDi7lNUHdyJ5TX85FYyZb3r/5CZwhxosJxDYfFAsMsXNzwXMbrXGjNd
         lxcs0BC9i069oDgv40BfxJMhzWi6fi/8tQCrR2DmEcKldWLG4H195NSbxoiVaFIac2mG
         g2yj7cUxx/VQ4QpM7DC01q+ZxjDyJQsGOQdAX+GpUcpcTnlmS5Kox4rYhTqwxDF8//p8
         ojjsIRvJhqtLxbr4I+g4+QcI+72h+EZ27iyffn2NRuMcVkPDtXFNHolzeAH+bDM7DmyJ
         4KxD0bcC6w5owbKWbJ0VCaezRi3EbbohBbe+ToWhiUrwW+nXDiqcoME5F7D2OkJhRxMF
         bz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783145717; x=1783750517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY4Ay5Nu5ZJl55Ny6GfPN3/o65u/V2603CFmGcLq4yM=;
        b=A8ENHPqKQFayMIArVZoM+4Um+0qkWuDIDIyGR0YapoBPrLVp3QPnWW06IRpFWas852
         H4bWoir0XZ0uzvA2p+Wuo25UCtMnowpmoNGHeb+oiseIRoc9Vens7PFjybsOpscenzKI
         eW+vhOd4Cg6QZKbnuPL53Z8hnwnKDq0iIYUZiZ8yVsB7akWC4hFw6bBqv2nnphCjfhDs
         lEhEyTWfbhqinI6cNEQiiHtJpHrlmgeIzqIDT5YDim/mGop+mrr5yOONILe1BeItiEeb
         6Y9vJJRfo0XJnFn+qcvUt5DvesAkn4sSObr9UtWy7tq25DcCxurVJk8309cj4dguLoRT
         xmsw==
X-Forwarded-Encrypted: i=1; AHgh+Rp0m3/3sKXdSyTf9wrYBDTTJEOSaVHFOQ40Wgllp+wIiZJpJk95CmJnmOgiVcJQ8le1hqR7zT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1H7mDfD7GXlNnYLrsMQ31OMLd40SaLzNql7XXqT7OyD87DNn0
	T+F8GDHM9FWJfAjnf+/s1vaMuewdN26J5PILTz/P0UIxHLIF/SC1oYLykkwJMg==
X-Gm-Gg: AfdE7cn+Y9bILnEW/mPhBF6ko8Sbw5f2lXURYf4UmR+1M1vtEIxwVT052hG6quWrjVW
	PrZw3NGx2FmCumNv0upPbvx0ktbngVZ1Yatlqv4nHMnV4uGxCkmnbARAr5NIN3/RdTCiLBuItku
	B8MPmgiKI0Y+YjTd+27dqKKLkLs3hzbiAVvRCpgv4MsBGjFq1rrGtYQPOkfqfAnxYYZPFwXCft+
	HR2oIdVxzb9X/FHEwtL8/ImczxqPZldcfD0Dkh8tSK0vqG/wRLLSW/fu+Nlf4fzvqcbrp9DkE5F
	fsLnyU3EEuv9SHAOxEvrE06esQOmpVDrJrVbeLcMoevYGg/637fSqYxRkcEewi7xPWyOvGb2KjY
	8WFOr/tuYzMl9mkgJMl/oNDZWsNutP0e9cPmASD2YhbL9IYFKX8G9UO3GRnIIsjk7U/HYERUpGP
	HdtEsnIXWm958epAO/rWSfLQIyqF6p00rKTdvBxQ==
X-Received: by 2002:a17:90b:50cc:b0:381:2709:545d with SMTP id 98e67ed59e1d1-383394cf58bmr1480889a91.1.1783145717032;
        Fri, 03 Jul 2026 23:15:17 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127ae6e2bsm1983825a91.2.2026.07.03.23.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 23:15:16 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/2] octeon_ep, octeon_ep_vf: fix skb frags overflow in the RX path
Date: Sat,  4 Jul 2026 14:15:09 +0800
Message-Id: <20260704061511.2350737-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304686-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vburru@marvell.com,m:sedara@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09E7A706D98

Both octeon_ep and octeon_ep_vf build an skb for a multi-buffer RX packet
by adding one fragment per buffer_size chunk of a device-reported length.
Neither bounds the count against MAX_SKB_FRAGS. A long packet yields about
18 fragments, one past the default MAX_SKB_FRAGS of 17, so
skb_add_rx_frag() writes past shinfo->frags[].

Each driver now checks the fragment count before it builds the skb and
drops a packet that would not fit.

v3:
 - octeon_ep_vf: pull the drop drain into octep_vf_oq_drop_rx().
   The overflow drop and the napi_build_skb failure path both use it.
   Suggested by Maciej Fijalkowski.
 - octeon_ep: add Maciej's Reviewed-by.

v1: https://lore.kernel.org/r/20260701112825.1653044-1-maoyixie.tju@gmail.com
v2: https://lore.kernel.org/r/20260702180518.2013324-1-maoyixie.tju@gmail.com


Maoyi Xie (2):
  octeon_ep: fix skb frags overflow in the RX path
  octeon_ep_vf: fix skb frags overflow in the RX path

 .../net/ethernet/marvell/octeon_ep/octep_rx.c |  9 ++++
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 46 ++++++++++++-------
 2 files changed, 39 insertions(+), 16 deletions(-)

-- 
2.34.1


