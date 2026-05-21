Return-Path: <netdev+bounces-290158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKgZDBhPDmrL9gUAu9opvQ
	(envelope-from <netdev+bounces-290158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:17:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C964459D3AE
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A47A43010670
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE8D1EE7B7;
	Thu, 21 May 2026 00:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiHLZ/Cj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6101E5B88
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 00:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779322642; cv=none; b=Jiaanas1R7mv12s/W2sUS/LouPgwTWqdgiqpvJF4UC0fOwPN3+uZspOrDJ+dyr/+opYFFlOt7va9bX2V/ARTzi1zhSKd4ArSlGCzF8coRcQM5OutpnPjtT1ssRxFNbfDk9tHwi6MFhh+zpe0EF2FOupCa1brt5XeL6n0SlCFJmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779322642; c=relaxed/simple;
	bh=6CP3txsMOcZo7lGWNRP9w+dLh7fFhvffIWPmcVzLECo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ftvWIk3ek7tGx6OMfoTYvt6a4o8j9zpDhhxPat4GhC1/4YfhqS+eY+EijpDSszOcWFVDzgaoTQSHlxdIdeVN/pJiOe2sgOpd3sn+OelxFpDxQULDd8M9asrBuFXPGZoB4MVXh8eQXD1cw+PJxxum+kEv80wdcx5zkY7DCgSykug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiHLZ/Cj; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1357c851a48so6145237c88.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779322640; x=1779927440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5joTIW2YWVTTwLEs9xeVQ4o/GQ/fh1Y8l2P7szIzdtg=;
        b=LiHLZ/CjI/Brk4ja9XY8SXHeozKq+jtLJI6Ii2tHPXYOAViuGwetxX+bOt9MHGkPLn
         lyVLgq2DVkuxP2ySPwbhK9+N3fszDHX8vGqdTYCGA749jjQiVifsUD5j1lBky5W44/B+
         fIqI8JmvpQqBxXr66nq90p10ycf6BBgz0QET3PYIGO2l6Zgt0Bh9YQkSDyJ+RRT0yIVr
         8sc/EV6l6B9qqftVtMtV4wriTaDuDMisVqHA54i+olWz7wKlgEp3tEa/8LxOlMP0hRjg
         IrSgsnDKau5hJPW4Mvrs8pbEDhRwZLzhCMn4WBmoVjffzCljuMeeOc2MZ0fYcvRkpi8f
         +yMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779322640; x=1779927440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5joTIW2YWVTTwLEs9xeVQ4o/GQ/fh1Y8l2P7szIzdtg=;
        b=nVG0OKsIxS4UMfJn2eb+tk+FJwBMGAIj0h5dnj9bfmmdDM4ubbXl3yzCb+hTwOBCZa
         6Zm1cqBXiB0yE6GmVey+yd6tayHd4+/1k/tIlIf2wA6JZbJ+xLgug+6q6Wm5DM6Cf+0u
         ymOOOFCBSEYWQ9unjO8BYwbe7J4u65yc1KR2mo4Gpei6wGGaTKTYksvROHGuy0gAeGF+
         wzNDHZ/W27Wi+PgpFcclyn8t1DTXClrVBrEPx70V891dahDf+jWyM6DgOaY+XMcgZwlP
         LH4MbCQHu3vKJn9yfYvBVyaHawMGSvzdO5xSAoiTkJH7+rj5jB7bPbQRkFoDfGtcJ2EE
         p1pA==
X-Gm-Message-State: AOJu0YyK3Z8DS4xEnkfhCrOuDWZe9NvOYMl4vC2yOzYyK3h0oVUubHPn
	hx8ryzAmtR2r8umtHfHp2VFD9B/ISOXPdKslpp374jKCasCgSI3A1AkokDAc1LP05E0=
X-Gm-Gg: Acq92OEB5QCt9WugZrFAtL8LeV4ki1Nne1x3mqmAIPnVjidr6pFiCjhCbEtsvc6dxyb
	Y8pAdjLQV4wtyfZuNiAWXPdLb4tRZ/kMKWF/yMGlMAwiJk6AumnHil+jjEsvHFtBLesfgZtfREo
	ikuXUs0kVYZac1/E99sx98vBVuP75u+Y4yRWItgW/+lLxpURqDMPrCaVIkyUZYLcPXlvZpzOiTN
	ChpDwl4FCAz5fWb3/c8nqrwKZ8NcLLSveqG/Q9AzuXL0dT+EDuMo4uD8Z0qdpN51sq4I8QLOUff
	P3fPQMDeeBz8dpzUQ8UbzIwT6yoRTFARonpM3edImshn4u3yIKmnVaj/5vsJYUB53m3LQwnWfDM
	tJ2hD8ylO+Jvtq+Uz7g42pVQ/nObEmj+AdpelQIVkE9JzoLiychBm9qzRo4SHtmyLTLvW5OmUOp
	wO/CRD4UxnL7vAg7gDhHrepTYDtE3l89/JOeVAHxPS/OJDifxMw4htNcOcJ8pOsV77ToVuXTdCJ
	gVj2L8DhXihjRn5lNeOVfhzyIkpHZcNZ7EWab/BHKhufdQkbMu0sWqM7Sf7daQLsLeyZ7dSndxj
	r7GncLOwLsT4U8c+4A==
X-Received: by 2002:a05:701b:428c:10b0:12d:de3f:f3dc with SMTP id a92af1059eb24-13632d36421mr287567c88.38.1779322640356;
        Wed, 20 May 2026 17:17:20 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ed3sm28444410c88.1.2026.05.20.17.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 17:17:20 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH v2 0/7] ARCnet: remove outdated drivers and information and unused code; small cleanups and documentation improvements
Date: Wed, 20 May 2026 17:16:12 -0700
Message-ID: <20260521001631.45434-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290158-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C964459D3AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v2 of this series is identical to v1, but with the patches reordered to
resolve a transient build failure. The description from v1 follows.

This patch series mainly removes the ISA and PCMCIA ARCnet drivers and
documentation for them and hardware they supported. While ARCnet is still used
in industrial environments, and cards are still manufactured, it is unlikely
anyone is still using it with ISA and PCMCIA cards. Removing these drivers
reduces future maintenance burden.

While updating the ARCnet documentation to remove references to the removed
drivers, I noticed that it contained thousands of lines of outdated and
irrelevant information (much of it so outdated that it would not even work on
modern kernels). I took the opportunity to remove this information and improve
the writing style slightly.

I noticed that the BUS_ALIGN macro was always defined to 1, which meant that the
custom arcnet_in/out/read/write* I/O macros were unnecessary. I expanded and
removed them to make the code more straightforwards.

I also corrected some typos and comments.

The first three patches are the same as those I posted on February 8th:
https://lore.kernel.org/all/20260209030649.54779-1-enelsonmoore@gmail.com/
https://lore.kernel.org/all/20260209033604.60033-1-enelsonmoore@gmail.com/
https://lore.kernel.org/all/20260209025442.50987-1-enelsonmoore@gmail.com/

Ethan Nelson-Moore (7):
  net: arcnet: com20020: remove misleading references to multicast
  net: arcnet: fix typos in comments
  net: arcnet: remove ISA and PCMCIA support; modernize documentation
  net: arcnet: remove code depending on nonexistent config option
  net: arcnet: expand unnecessary I/O abstraction macros
  docs: net: arcnet: remove outdated/irrelevant information; improve
    style
  net: arcnet: com20020-pci: avoid -Wformat-truncation warning

 .../admin-guide/kernel-parameters.txt         |   14 -
 Documentation/networking/arcnet-hardware.rst  | 2979 +----------------
 Documentation/networking/arcnet.rst           |  235 +-
 arch/mips/configs/mtx1_defconfig              |    4 -
 drivers/net/arcnet/Kconfig                    |   52 +-
 drivers/net/arcnet/Makefile                   |    5 -
 drivers/net/arcnet/arc-rimi.c                 |  386 ---
 drivers/net/arcnet/arcdevice.h                |   36 +-
 drivers/net/arcnet/com20020-isa.c             |  230 --
 drivers/net/arcnet/com20020-pci.c             |    9 +-
 drivers/net/arcnet/com20020.c                 |  107 +-
 drivers/net/arcnet/com20020.h                 |    6 +-
 drivers/net/arcnet/com20020_cs.c              |  330 --
 drivers/net/arcnet/com90io.c                  |  427 ---
 drivers/net/arcnet/com90xx.c                  |  716 ----
 drivers/net/arcnet/rfc1201.c                  |    2 +-
 16 files changed, 125 insertions(+), 5413 deletions(-)
 delete mode 100644 drivers/net/arcnet/arc-rimi.c
 delete mode 100644 drivers/net/arcnet/com20020-isa.c
 delete mode 100644 drivers/net/arcnet/com20020_cs.c
 delete mode 100644 drivers/net/arcnet/com90io.c
 delete mode 100644 drivers/net/arcnet/com90xx.c

-- 
2.43.0


