Return-Path: <netdev+bounces-287591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA1HAm57BGrMKgIAu9opvQ
	(envelope-from <netdev+bounces-287591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:23:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B17533FE6
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7172D30BBB10
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C2B40FD98;
	Wed, 13 May 2026 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZriZhLcI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE03402435
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677181; cv=none; b=kx208qx7fH5mpEHmHM5LAWkqdbn3ZWYNY6RYWAIxopQPDu1OkAgqTM+iutkos9KqNXJAKLFfDmwt2xYEgg8pzSBv7ALtdcztyF+nZ8CU6nUkYqj0dOYUlUm17JAxINgeB92RDWm5xQYI4WRbL0yTrm9sDydAfUN2RjWNpSibRWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677181; c=relaxed/simple;
	bh=3GHf4gGhPQHAzrVbrpqKAAbiqxGaZAXyufLzRwNh1bI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mjkiZTVBy9lxb/honbC0ZI5NkcypI+ss6Or+on3LB1Bfg7AuujAGsvcRuUPlmn8uLAXDIovq1FqETuQq90HylJuMTfgnfiit+2ajOiiCTqF8fS9S0DzNjWBLhwmvtdFUDMhlTlY5UCU71y9vBVtDi3Vp5gNd445+BG0p0u70r5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZriZhLcI; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-439c00ed7e0so1134222fac.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778677179; x=1779281979; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp0hmi2FX4WFeO9HzqQLz/P4JN28AawTbKwf34QgtCY=;
        b=ZriZhLcInhwTugtfd4fKG52Ygi0Pq8C0gVsGFojrqQccsJZLPMhEyWHaM2KjNVkcr5
         2lAjcs/Zo0ZaDY7KPX1EQQ6ONGwu7cqnUZUYs0vkK/Vq4dJpmUZkQ9fb/lfFTHOGzJJ3
         gcJuoAXr8hIAcsbd+l/1bbUlalrqm+rMNYUx5V1T8K8/pnX9rfTAWA8APiGWAnc97QPN
         7Mn9j0v2jSjx1Cdy8rHJUPVD/CATJt18GjhYC06oE95+3S4rWJFVqGTYPaZbN63vKYfg
         cKY0cukxd/jxO1HjePxCWirv4X2m79zqyKiQEvIhZO9afzwhEC59HikvHn4IValhyoBL
         AypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677179; x=1779281979;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fp0hmi2FX4WFeO9HzqQLz/P4JN28AawTbKwf34QgtCY=;
        b=Jnpx+KQjMtpxtcTmUshGLEpmNBY8mcsSQlTJ9kq3Lp4EqcNz0BwXH8+3EjomcN1S92
         NJ26OoOysQFhgO0vGrPNLLZSsxNPcqYDqkAWvkH0JwbS7mR1qJHy2YHgbaaFOZ48fYyQ
         fviYYeIc0gTeygD0j0xDXnxBj51H37l2FUJ5nGF2svVDyPHe6DH7O6R8R2/jyPnYvzq1
         w03R7Ib4pWTuZPJtvBR2fuDL2RKRX3Zw+Kap+PEbBT3nfckdrsVvzmDjBnQCwluUn7QO
         nECl6p9kOBoy5a8yXGbRdVmK++KJx9O//BYsJDG0y0OsQyzi23Px7lavS9fMeTbl8dk1
         cAnw==
X-Gm-Message-State: AOJu0YwR8qd5J4CohggjurW6CXbcpAlmEzmStFZJQwwRODVU/45Q2yVg
	ZVcSuPyEhuTnfZtwTNBHxw99Q5ESDeMn6JQRok9FomlG/bpy00ua7GYG
X-Gm-Gg: Acq92OFbsAN57g6YQi8fh2d/oWUEh1txG0hcz3a2Crd1oGpJZczJiUhebVoz9wlUB9O
	tUccipCemE0D6REONQKJTo8KJM4B49ODHLzB+/BfmzqvQDUFAi5An+z3QshkbBwf5U4ENrm4ayi
	mj26QAzSVNHDxpTeOt82x8zZikrwn2Fg+i6LjhPcvCRJjtXRpMfrIULOMOs8DRHvPIsIlUXiNyQ
	V3JB81Ogwv3y1xTuNBRWCe4pG5zmoYEO0TuHy+k87h4YYETbqcUk1XqBvnkl9fqzWkcr+6wTbNN
	MQKBuDU5UUZvg0wRgjCHuFoR2BWFT934MHMal8B2voAM5QuZfM6tVVOV2AtjwuDP1toII3WAUaG
	uG3oKz4RzlK2OwB21OYNRiuMYcWLVYGJ+iwyT9Nft9/b0m+mfP1WGdsVjWQgpx1qTbMwRqMv2VW
	i+R5R3798NXwOp2BVllVw=
X-Received: by 2002:a05:6871:7516:b0:42d:c200:420c with SMTP id 586e51a60fabf-439d2f5c7e4mr1309088fac.23.1778677179432;
        Wed, 13 May 2026 05:59:39 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43557109b7dsm14328254fac.5.2026.05.13.05.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:59:38 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH net 0/3] netdevsim: psp: fix issues with stats collection
Date: Wed, 13 May 2026 05:59:35 -0700
Message-Id: <20260513-fix-psp-stats-v1-0-cdb3174f252f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALd1BGoC/x2MQQqAIBAAvyJ7bkGFBPtKdJDcai8mrkQg/j3pO
 DAzDYQKk8CiGhR6WPhOA8ykYL9COgk5DgarrdOzsXjwi1kySg1VkLzbXdTOR21gNLnQEP7fCok
 qbL1/TiHqV2QAAAA=
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 75B17533FE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287591-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

It has come to my attention via a sashiko review of my net-next series
for aes-gcm in netdevsim [1] that there were preexisting issues with
netdevsim's implementation of psp statistics.

API usage issues:
1. not calling u64_stats_init() on the u64_stats_sync object during
   init
2. not serializing usage of the writer side API during stats update

Logical Bugs:
1. We were incrementing rx stats on the sending devices stats
   counters.

[1]: https://sashiko.dev/#/patchset/20260508-nsim-psp-crypto-v1-0-4b50ed09b794%40gmail.com

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Daniel Zahka (3):
      netdevsim: psp: initialize stats syncp before use
      netdevsim: psp: update rx stats on the peer netdevsim
      netdevsim: psp: serialize psp stats writers

 drivers/net/netdevsim/netdevsim.h |  1 +
 drivers/net/netdevsim/psp.c       | 26 ++++++++++++++++++--------
 2 files changed, 19 insertions(+), 8 deletions(-)
---
base-commit: f5b2772d14884f4be9e718644f1203d4d0e6f0d6
change-id: 20260512-fix-psp-stats-e96c6d069d01

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>


