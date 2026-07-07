Return-Path: <netdev+bounces-305580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FoSRIYhUTWroyQEAu9opvQ
	(envelope-from <netdev+bounces-305580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:33:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D3E71F411
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:33:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JEnv3Wmq;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305580-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305580-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56E81300CF1F
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 19:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015FB3A7595;
	Tue,  7 Jul 2026 19:32:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915DD346A1D
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 19:32:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452778; cv=none; b=A/BaIHrkW/ciiCpZOGCZtdRF9Zmrc4e0NKu7BnRogtuuZbB/3quMzH4Ek/cTHf86almOogRKTVNMjqMdEftX4nRhiwxjSRll7H/3w/i23p07+GvwubfedQ3XVK7RCLAOgSnWD4+DhoRs0eRzFlBS4T9/+LZTf0cw7t2sjU1nsMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452778; c=relaxed/simple;
	bh=IFBa435MYaaMvTaZWLFDX7oNMr81k1RDEV+zPP3pf2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m/YzkEdxNGndYtA/tJhtSNC9kgeMkjFQpZ2xiPY5px3YMu/AzlOHWxIGF1T7xMj/wqqCPlLhhCLDWzSda3PH6NWZq6Ge47Ewx2Ad5ctnAp5usWOyBnAQnysBV9o9Fk8sv1bOrq0vYRgxDz4k50vz8PGMwAQs8Cgk44maqxT7/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEnv3Wmq; arc=none smtp.client-ip=209.85.222.177
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e52c9fddfso216489585a.3
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 12:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783452776; x=1784057576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PLn7G06J/yx3oS6rwfchY9PUvns0p3h3goaRA6STEhk=;
        b=JEnv3WmqnoJa+aty9W6PpiNFHpRJl6Br+6+2CR3mHVimAo+27h0bIcuhz4/hwTy6RK
         uH3XPS1oGmMW7hd/RFtfGZm1Q/qH9Nqb3h35AuscU7e9XTy5fQHanqKDWzLfwx2XdA4q
         MnTv0EOdB6fOveDXGqUvweOquQmrrvC2VKwbtFkYvTgqi4p2yxQtqJjMYuEaxKBjULIU
         6/8y+V7C03Vw8FupbHpxvzr+ellSMFoQTVy1vHEHEsGyB2QWwiH8pIjC7gwk0mrnDle5
         0qiedFJ3hD68otzIL4kDjV/yT65NGFEgh3kMPOstDlgBC1jtK7HY8TR8fLuvO2iymtJ0
         xb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783452776; x=1784057576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PLn7G06J/yx3oS6rwfchY9PUvns0p3h3goaRA6STEhk=;
        b=tXLXIA/f5zW9UzjMxxHaUJp9Soo6/mP29+paG7PvNPtNGc8P8kyZbNIpEfWeugRbUG
         7zapWF6O153ky+iZwoJ3tQEl3mS9OIlxtZDh67CY4YrfH0FSlT6lMoh00gqR+8aL/rJ5
         6pSsKaxrmtY4N5DPLmn0FUIuT7CdKowFce4oIVikyG2VmcVOx1pge6G3eTLTXATJbkGm
         DLx6dK0mNdrgTGaAJ3CoVa7X5j6b7wM+rtplGouC3yBx0ch0ZVDomj+Umqj2ZDzlG1gJ
         JATtB1x5odEorwgr5t/DJPMVmJuiwWo6ZOdPEUYRRY12z+CfPY0vN67tSoY+Ne9V4JN2
         7j+Q==
X-Gm-Message-State: AOJu0Yx73LZHEg/UmDJMrkA/9KavHHEIplQHOmpFF7fUpJLma1TRGtJu
	q5kLYwOWb2Y7bjhIN5JtdYWGnztGRsGETVYsmRRiL/i5YafvvPuZEXME
X-Gm-Gg: AfdE7ckNZiKVo44DmUmTOWCqz/uVO+LfZ15FexasoMYB27rKolULW/wwdxLWPLXmBD6
	rBl1vr+wISS6x6+2lrtc6ANMcTBPDzgigIA82NrLMeGvja3DYVeA9LdLrS98vyQNEDSUEJb6Wfx
	RxK32mSNCcMXhOUGt+5dcgbG5k51qQv4J9Yb8mQnb5uvrqcgfXe50x66sm2YkDkcx8iqcBua83X
	Rvqp/tPVHVpVYZnnFx7pBEUfIcqbvOAQJOzp8kW/8LEWdZtcPVRpcxQtbLMuK/mcjujpWB7gcrX
	U/NjaKbtFKhuHymCcaQEOY3+YLb4N33W1PWR6KnkoO2R7SKGhniSUHz62JVsoDxR++Y4qb4ppvr
	ru2L7hL8I6IaOrovhgO+SYyx+GUyjnZP/xmGZ4PN880JPCNpLbMNDkENqUKwd8EqtS/O9tUMhJq
	7UDMLvuTcwDWpngBq0+wtSlhBUXz1fNyheKp7Kkc0C0R8dBA/Da23uWKK9nkump9HF2tBrLvrD8
	6haa6UDjNMCJJHmDj+tijhxxNcIPVU+jG6Olah3akc=
X-Received: by 2002:a05:620a:4515:b0:92b:67e6:8ac4 with SMTP id af79cd13be357-92ebb70e907mr789546985a.62.1783452775458;
        Tue, 07 Jul 2026 12:32:55 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724bab15sm167767906d6.43.2026.07.07.12.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 12:32:54 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 0/2] amt: fix use-after-free of the skb head across pulls
Date: Tue,  7 Jul 2026 15:32:41 -0400
Message-ID: <20260707193243.3448201-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305580-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ap420073@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2D3E71F411

Several AMT receive and transmit paths cache a pointer into the skb head
and then call a helper that can reallocate that head before the cached
pointer is used again, so the later access reads or writes freed memory.

v3 addressed only the source-address reads in a subset of the handlers
and described amt_membership_query_handler() and
amt_multicast_data_handler() as unaffected.  As the review pointed out,
that was incomplete: those handlers keep stale eth_hdr() and AMT-header
pointers across later pulls, the record loops in the IGMPv3 and MLDv2
report handlers read the record count and the group record across the
*_mc_may_pull() calls, and amt_update_handler() and amt_dev_xmit() read
the destination address after further pulls.

Patch 1 walks every AMT path and, for each pointer used after a
reallocating call, either snapshots the value before the first pull or
re-derives the pointer after the last one.  This uses the re-derive
approach rather than the per-value snapshot of v3, because the write
sites cannot be expressed as a snapshot and re-derivation is already the
idiom used elsewhere in the file.

Patch 2 is a smaller, separable hardening change: the three handlers
that rewrite the ethernet header do so in place without making the head
private, which corrupts a cloned skb (for example one held by a packet
tap).  It adds skb_cow_head() before the rewrite, split out so the
use-after-free fix is not held up by discussion of the clone case.

Both patches build cleanly (x86_64, CONFIG_AMT=m, W=1) and are
checkpatch --strict clean.

Changes since v3:
 - Rework from the per-value source-address snapshot to re-deriving the
   header pointers after the last reallocating pull, and cover every
   affected handler (amt_dev_xmit, amt_multicast_data_handler,
   amt_membership_query_handler, the IGMPv3 and MLDv2 record loops, and
   the remaining reads in amt_update_handler), not just the
   source-address reads.
 - Correct the v3 commit-message claim that the query and multicast-data
   handlers were unaffected.
 - Add patch 2 (skb_cow_head() before the L2 rewrite).
 - Drop the v2 Acked-by from Taehee Yoo: this series is materially larger
   than what was acked.

v3: https://lore.kernel.org/all/20260626111917.802243-1-michael.bommarito@gmail.com/
v2: https://lore.kernel.org/all/20260617123443.3586930-1-michael.bommarito@gmail.com/

Michael Bommarito (2):
  amt: re-read skb header pointers after every pull
  amt: make the head writable before rewriting the L2 header

 drivers/net/amt.c | 117 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 96 insertions(+), 21 deletions(-)


base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0


