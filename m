Return-Path: <netdev+bounces-293466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rHFxOZ1/HGpzOgkAu9opvQ
	(envelope-from <netdev+bounces-293466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 20:36:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 799A8617829
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 20:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D29F43002300
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 18:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8288F306767;
	Sun, 31 May 2026 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrF0q++b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCCA1E5201
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780252570; cv=none; b=C5rgm4tsijjGnMJjcep10AwjlstkAuATkdoxfSEeigoumHZXFmIphUjrfB3lDH1AqNiGjO2S52m4ppNUixsj9iJoQ2w3KIYcg9QtKuk2ehTrOUOHtrJ+gWBApZllIhQ0U5uAxHp/wSz1JeebZN9fDoyUJ4i3JTd5EKdfwUTB5WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780252570; c=relaxed/simple;
	bh=sYf5vJUcg8gDiXjElyV7YBcl5qfNddlg3jPvyxZ55Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L9Q93WYrNTf1fnerU/HMqSh0J9Kc+PUQdJSCS/YMcBTfZMuzs5Aau745lDGsmfA0f4J3rHAFa8GkOPXhEaDfWlWYSan4dlbP9VWfgbF3VBTEDX/WzM5FI1elreZmYa+3z40VMJ9h7avDArF448nuTpF0flDyCnnLCbNoMS80x5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrF0q++b; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7e3069c43f9so490297b3.3
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 11:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780252568; x=1780857368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=62LyM5KiJ0Nft9Ein3YHp4ZfhIkk8aALTP4Ss5xGs4k=;
        b=UrF0q++bDKwWTpAQnBJkDt6eO5lr6KgjoP+joMjuXlgUtYe0gUOpE85z3MpiKhVhpM
         7ARBO92JYG9GmraUPvMVUvpiPc4V46rZ78jtKUtDJ0j3IscSY8xNZjxNMrcJ3g5rzhgC
         tzWzsjFNuFNHd8HMFiV7XcuINgoCTbwFOgwN2Z+jYtRL6YWN4FmOhJviQIplRefCUDCH
         uN3B0SXGUfV6g6JHa+F05O9OXHEOJjoW8FSoVpeIkgxkmS8Z67NJaXtUSsdMaKhhm3+q
         auKz8tuxfnZ3r1oyp1X3OxrdPM7wdMenlVAJjdU/M9d0C17uwOvWrNaxhr1tz2DZPcwI
         Lwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780252568; x=1780857368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62LyM5KiJ0Nft9Ein3YHp4ZfhIkk8aALTP4Ss5xGs4k=;
        b=LUHAbEx/QpWZaPPMswEJWsNYlOZm/83YciLUSy21Q3hWogRR2Z8cL+cwpdBHf9zews
         s/Qqe5av9+rou0IBctYe2ZA0lVEgOquSI7swiya+st1RObZdcgGE1KYJSz/vrtvTIVyR
         CZEIm4tkrT5ZaB4shTERTPioTEQG3bYZpImILPkPtkHH0DPt93kg6MNm9qufXrZk5oui
         xxIFDHR6Ub7MuaOhzdtWq2x0KDTHucNEEQXEMnE8XagMDpdy5w1ou8ZT6P3mNxSd5BOd
         DSYVXWyHORq+Cx7FmfifjpE8p88f+az/Y50GvkIen0MIGSBT2JWWE9kTYbh1mkrXeHRf
         kMCg==
X-Gm-Message-State: AOJu0YwEKEgjLTHzzq1x0W0CHdOQomRsVVDBYV7rf6UmGcmbD4DWDE+z
	3WoEMnLNR8GO8LRE9lSUefwWJJt6BByW6o/9LnjKZXtcp3fRuAzztutc
X-Gm-Gg: Acq92OEfcPOiLrlFNh+0hvi/k3i8jJHVAbg05Dg/T5zuE8YMPAl6dWUc1NlpRWV/5lH
	5ygzL86wtNTC8loKETSEz6NgDFhIWasYhj44q5Oen7kYgYv/wOC4vQUzVCs5zAbkEhKFejeggad
	8zRfWLy4njp7qKqenA44zqMuDBnCotiUXn4OBtIF+noNLLNMjnR1mIwQqTlbjsBk5meRyGNwXHJ
	PL48DQC+7p4UenfKszEr6QL+IUQHshoYeDcxB2aHnNuuPQSYXzlcX+0wCkdSOKEltJdh+maZv3c
	whU6pLAhfCSYyjzZm3BFd57+EUfFgIlxIYqCefdG1AQFOiPw8RcKUVfsjxFQ+L2i4lALNN6UogJ
	bf3NzSYt8z7xdAwYiHabCjen68uu6T9Y10cmlLrL5iCS4+w4nFTeckKOPKKfDYvwM+iUkdX0SXU
	KH67NIIstde8Rm/f24X771a+196tM2QvYymDiPRL6AusuvUgkBQe7ik1m3Q5IKNfRd3rai56W7F
	OJd9nSMmBmYvgMbyRHTfQw=
X-Received: by 2002:a05:690e:4089:b0:660:6971:db5a with SMTP id 956f58d0204a3-6606971ef16mr3137146d50.2.1780252568237;
        Sun, 31 May 2026 11:36:08 -0700 (PDT)
Received: from yes.c.googlers.com.com (232.252.236.35.bc.googleusercontent.com. [35.236.252.232])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660699a02a0sm2341170d50.16.2026.05.31.11.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 11:36:07 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	Van Jacobson <vanj@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Tim Bird <tim.bird@sony.com>
Subject: [PATCH net-next] tcp_bbr: fix SPDX-License-Identifier to be GPL-2.0 OR BSD-3-Clause
Date: Sun, 31 May 2026 11:35:57 -0700
Message-ID: <20260531183558.2337381-1-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293466-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwellsw@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sony.com:email]
X-Rspamd-Queue-Id: 799A8617829
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Neal Cardwell <ncardwell@google.com>

Since TCP BBR congestion control was introduced in
commit 0f8782ea1497 ("tcp_bbr: add BBR congestion control")
it has always been offered as "Dual BSD/GPL":

  MODULE_LICENSE("Dual BSD/GPL");

A GPL-2.0-only SPDX header was erroneously added in the recent
commit 2ed4b46b4fc7 ("net: Add SPDX ids to some source files").

This commit revises the tcp_bbr.c SPDX-License-Identifier to note that
this file is licensed as "GPL-2.0 OR BSD-3-Clause".

Fixes: 2ed4b46b4fc7 ("net: Add SPDX ids to some source files")
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Cc: Yuchung Cheng <ycheng@google.com>
Cc: Van Jacobson <vanj@google.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>
Cc: Tim Bird <tim.bird@sony.com>
---
 net/ipv4/tcp_bbr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index aec7805b1d376..82378a2bfd1e1 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /* Bottleneck Bandwidth and RTT (BBR) congestion control
  *
  * BBR congestion control computes the sending rate based on the delivery
-- 
2.54.0.929.g9b7fa37559-goog


