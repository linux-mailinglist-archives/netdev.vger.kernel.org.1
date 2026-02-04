Return-Path: <netdev+bounces-256523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNg2DPKxgmn/YAMAu9opvQ
	(envelope-from <netdev+bounces-256523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:41:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C476AE0EF6
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5D1C301B488
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 02:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACF22C3255;
	Wed,  4 Feb 2026 02:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVkCouwv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E15B16CD33
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 02:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770172911; cv=none; b=kF1T3R6Gemx8W6svWE+W347hOe/uGGDLpCGUK8wx4ucGNlg32TV3h3ZWKJf7NJc8oKn7MB5CbtT3S0Z4lOa1HAIDMjVdtoj2daNEqSy2LE+HPvCPKFFp6SIae9k0keOgNxolcZDXp+TKqDoUlrLswSNfwV2oZH+suHb1UBW+Rrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770172911; c=relaxed/simple;
	bh=LG7P9WWS39GmLizb+bvVuuvNilWmmIs1lUnqEX9eW0s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=naUWYEKcVZrsb1lBIzPC9e6NMnMQROuQqY2S0APuvYgcpzLwmsZyEay4sC8sGhpft00vM5kB1DE7KrS/Axv1LFb3GNZhEGx3G/qFTq7Ab+EJQP9hoWT6SgkQcAoWrIkwtsTLjlcmvGSHG4F6b+wr0u9ANcxqzVvPXe8UntOdR4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVkCouwv; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8ca01dc7d40so373762785a.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 18:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770172909; x=1770777709; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fLLVnUeMcHe+anVZJS0e73J9aVhLKDKkhp0vgm9svnU=;
        b=PVkCouwvKGL8MCOS43W9UMC/oh+TmJt92SZzi1c8fZfEwnzodZIMzDkO0pkIqb2n5r
         SziSLzr0CRH8q73XzDgnw4Wtu0nl/iI10f4DRzupIL9U+JNkBa71pR9xu+7iVfwzt/DF
         KRieUd6hjIGQ8Qf+gI/wYYe5GpobeLUAY+XQv9X84Tu8Qm/ky6PNKI1xLoBVehryKpoZ
         cNV8CugXlBU4/XSYNuBVbm25jAhYcyn6r1fscsRsYAsa16aGoXplIXeu3PryFTM7gWOG
         IbOx3taxB1I+yh6rzJPlVD35kJ+20wsBu9eaj2AFLHjEAieCyfZ2teipbYAtzHxzccHl
         mLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770172909; x=1770777709;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLLVnUeMcHe+anVZJS0e73J9aVhLKDKkhp0vgm9svnU=;
        b=eaBbFgJYsL32KuNqnx2XrxX8/Z/3YI1WDBJW4zETt0oJyEfsYLr+4WjBOiWtnVjBX2
         Efg6qKjjFy7XV3Jfje2ZVFw9KplmFUS3ta3147r5D48ktbLTXoUa6SBuBSTXvxsC9pUR
         N25nnVoxUBbPHi2/FV5z80kJfczuypP6YzCCaxT2/83naNbhXGRl/gpkypH1U/OnA9Dj
         YPPLCQGKceaxCnQZcXKDRBbHdWEXhpm9zWmIwkWnSXUtyqkFiKvHQrs6nyzHppUs2mgm
         zgM3PHfBmZd1CIVgR2ig0HHejC+1LM7tSeR94uG7fRqlHdo3D9Ds66DJOmlLbdTKMbwl
         DpRg==
X-Gm-Message-State: AOJu0YzguL+KfAy2HO4XPXtJI/V0JIHLa30ZqyjFhubxZIgWrAzmae5N
	ZhMY9xMk2FWGb/VuOdVaKx/3I41Pi+kjp/k6d9VMM71oAIxxpa5uiJpw
X-Gm-Gg: AZuq6aKbaH6w6iMQ6tCd9eqpsbFaC8VQECDJdb0yab0hBQ1WJe24nEU2i6KmwwLpmhk
	aboH1mPJ/L+S6H0KCInHaeUfdqXoDxnepA8I8n88HvnNnoVCY5PtQP6cacsiNuNTxq6RQ/pqbfT
	uk9vBcg78q/cAMv4zNKnTdWUMfZfXUQTTqLaSbGW6Rz3VGMGiwqYmEsM0tTMoAIPcZyZVqmUIJB
	b5UU5pj44x5WcMIyxSWtmMZlTt11t4ZMjNHHHnPeH1oEenJiCzLMhCeJfAnAvv/1xpfePI4utXx
	i2e3FgbOE63o7SvitauWTUOuqGwo3gJMGdzImkb+hZXyEgVUofWMCb0o7R8ebTu3jv/FRXkgNr3
	HF+AZ5VJwNmzuk13AdbynkuUDlINCScNU7KSJxizYi2DcyfcQYEkvbbs0xw5NYIJRYjyQ3GuVME
	PoUof5X8xFujF0vZzLJQAW
X-Received: by 2002:a05:620a:4450:b0:8c7:e64:3daf with SMTP id af79cd13be357-8ca2fa90031mr205823685a.82.1770172908850;
        Tue, 03 Feb 2026 18:41:48 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd40f9asm94762485a.41.2026.02.03.18.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 18:41:48 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net-next 0/2] net: ti: icssg: Remove dedicated workqueue
 for ndo_set_rx_mode callback
Date: Wed, 04 Feb 2026 10:41:09 +0800
Message-Id: <20260204-icssg-prueth-workqueue-v1-0-9a892f4b293d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMWxgmkC/x3MQQqDQAxG4atI1g2MUSz0KqULa381FEabzLSCe
 HeHLr/Fezs5TOF0q3YyfNV1iQX1paJh7uME1lcxSZAuSGhYB/eJV8tIM/8We38yMnhsu4Bnf5W
 6ESrxahh1+4/vFJE4Ykv0OI4TNitXnXIAAAA=
X-Change-ID: 20260203-icssg-prueth-workqueue-f460eba72132
To: netdev@vger.kernel.org
Cc: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Meghana Malladi <m-malladi@ti.com>, Jacob Keller <jacob.e.keller@intel.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Himanshu Mittal <h-mittal1@ti.com>, Simon Horman <horms@kernel.org>, 
 Byungchul Park <byungchul@sk.com>, 
 Markus Elfring <elfring@users.sourceforge.net>, 
 Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256523-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,intel.com,linux.dev,sk.com,users.sourceforge.net,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,linux.dev:email,lunn.ch:email]
X-Rspamd-Queue-Id: C476AE0EF6
X-Rspamd-Action: no action

While addressing an issue in the cpsw driver, I based my fix on the
implementation of the emac_ndo_set_rx_mode() function in icssg. During review,
Jakub pointed out that the dedicated workqueue for the ndo_set_rx_mode
callback might be unnecessary. I subsequently used the system workqueue for
this purpose in the cpsw driver, and it performed as expected. Therefore,
I believe the same approach can be applied to the icssg driver. These two
patches aim to remove this dedicated workqueue for icssg drivers.

Please note: I do not have access to a board that supports the CSSG PRU
Ethernet controller, so this change has only been build-tested.

---
Cc: MD Danish Anwar <danishanwar@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Meghana Malladi <m-malladi@ti.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Himanshu Mittal <h-mittal1@ti.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Markus Elfring <elfring@users.sourceforge.net>

---
Kevin Hao (2):
      net: ti: icssg-prueth-sr1: Remove unused workqueue
      net: ti: icssg-prueth: Use system default workqueue in ndo_set_rx_mode callback

 drivers/net/ethernet/ti/icssg/icssg_common.c     |  1 -
 drivers/net/ethernet/ti/icssg/icssg_prueth.c     | 13 ++++---------
 drivers/net/ethernet/ti/icssg/icssg_prueth.h     |  1 -
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c |  9 +--------
 4 files changed, 5 insertions(+), 19 deletions(-)
---
base-commit: 5c009020744fe129e4728e71c44a6c7816c9105e
change-id: 20260203-icssg-prueth-workqueue-f460eba72132

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


