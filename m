Return-Path: <netdev+bounces-295409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pnDBLS7VIWqLPQEAu9opvQ
	(envelope-from <netdev+bounces-295409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:42:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B19DF642FC1
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:42:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JmmOYboj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295409-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295409-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACEF1300A64D
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 19:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BCC3BB110;
	Thu,  4 Jun 2026 19:42:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9CD3C09FB
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 19:42:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602151; cv=none; b=OsiXepni4El45GMSAhHDHvO/SsI0uHVYdDQwCwWgnecqkxXwykXbz0XXG8M4KNxP3AC8krYdPqyYCyvtS4uLZZVj1citcwvmkIHr08lx9ZJCaToIL2yRGEGU+SizhTwhYAZ+DbDk+xJknWiODJL4AIQUafEE7xYGFE62v2YqoDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602151; c=relaxed/simple;
	bh=2UQ/dxwTLPaSRnLgkeAiraebIrfsHb9cbNcuhJnaMr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YtvWSSDn6I2aLUWzErehYHtSjb0ftdkJDFjGO5JJ6b3ArGgX72bBxCoFc1GWmb6z9A0cPVCmjIs2tYNWoK5eVbSqdrSeE+ntiXq+cXc+tD6EIDld+XmnnRkz9jMgRKlFnUsMEsIP1CkN/FUcQNsrsgnadkHidac8N0bAZUdsezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmmOYboj; arc=none smtp.client-ip=209.85.128.170
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7e1c3f47d78so13267327b3.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 12:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780602150; x=1781206950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a/fEr8pGqXvKG+/WnK0Gaa0OBSpco+6wYcak8JAx028=;
        b=JmmOYboj8sxEokKDCCfEidDPNeRYOEDlaaH5h1GGLbO4js/lw1lJSLDStY8Nz44VJj
         xtsiKdV9FX5m7R9OA+J4cOz/7wZjT2XC8zwcjHVz9Y65KDCR0w8Icdkr0uaZIS/wunF5
         21JB37nxpEY64jxlCL1+mksermCGGeZgBHicVklh3/kFp6a7l3Tkm18X6zt6vA919Em5
         bdLVR94yCWepUgDLpMYh5nl0qA4art19gkd0MjNXo3HP/pMdZ2iB3Jk/9h2iNRywArej
         UagPyZ0qLl/81xg3atJBI9zPqXwMz53+4Cul14XypGpuAo1ZrHctnPjEyTCxP3GzWcZN
         IYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780602150; x=1781206950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/fEr8pGqXvKG+/WnK0Gaa0OBSpco+6wYcak8JAx028=;
        b=czrjYMm8ZfD52KSy6yvvpv+furXY2ZyqHRRDb/U4K888xhOZQhGlKaGetduq32gm5H
         2IM9AbpYXyPzl3VPdIKhXNLn7MY+KRbb8xn1mKyqoeMN35MKHc68Okt2uvLkZuuAw7rT
         gDrrv4nmQhQBf1U30bnWue+IF37ufERkSJELG7bThbb+iRwfc4sReeNQTkCYhpTfIQgk
         fyU1oMrzmqGPLFRPqIye7KSXiQhjAcvV6CtkVhT/8mAw7L0eaE25plzJ0WQWwL3aStOa
         erKY5SH4Aiwsfcom8mjyLiyKEZ5shM+uAnLGVmzBCGYN2BQ5Fc//KDh137grEvbykzqO
         r8uQ==
X-Gm-Message-State: AOJu0Yws4exez8JfP4alZDY2v3lLfCqp+vBSoXIFzERiNmllOvsTcE9Q
	BitWXfeWuiBq4h6GA+JTJoibpUy/WTXMDsbOKwEYsB55cS63qCmcSFoCQN5y2g==
X-Gm-Gg: Acq92OGlX08Nxe0IuVMnusoSqRHz5gedHatupEjmvL44SKHlUHcpgZHrNAUqf5mJOA0
	WLhTFiHWF2OJ8kVo7CEJ3jXOt8HRdxvAjbzQHyOz32HzpTg1LLiT23sLHF/7+Zru3bxvKPyDMhg
	icIrty/JZ/pLpDi7y+18JW9+rX6ZT7xpuIwbi5N9U9g/ITh7A9kkmDdWcEnbT20xzjE+sPh67LJ
	c5AWewjQuEqRcTrewPyF9JiPP51SrBB5ZsKzjCOvr+SzjtvCs53m5Cq5Aqvbbqd8OI8WjrL4inL
	9yUAsuOPVXNE9K+z49k/ARGbQanfiAJztK0zqkAxf0Qrgt6apLCIcnrpX99BEc/4CtICP0XkFRr
	OBXN+Y7WV2YtG7oAu+3TM23mHVBvc2AR7qqIRr661C3WcY4/oWOGkzytcdTT1jVn5KFgC5CjMHD
	eW9HDzmBrnSo3RWN9LEdVsJHsAjpDjSeaQPJvPL2dRqxdxLftQJNSkXUN9EBfZroPNvzqMkxIsL
	HORXSvwbNVdR7By1hHjFA/tZrEbCnNe0b8TI2yN
X-Received: by 2002:a05:690c:e3f1:b0:7c7:5111:5f05 with SMTP id 00721157ae682-7ed0de8a1f2mr3530357b3.48.1780602149787;
        Thu, 04 Jun 2026 12:42:29 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d5f883e2sm4360772d50.6.2026.06.04.12.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:42:29 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 0/3] SO_TXTIME improvements
Date: Thu,  4 Jun 2026 15:41:02 -0400
Message-ID: <20260604194221.3319080-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-295409-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B19DF642FC1

From: Willem de Bruijn <willemb@google.com>

FQ targets monotonic timestamps as generated by the TCP stack.

But SO_TXTIME was later added, which can send skbs with timestamps
against other clocks. It is now possible to detect these through skb
tstamp_type.

Make FQ robust by converting these timestamps for use in FQ (patch 2).

This also requires testing against out-of-bounds values. Prefer to do
this at the source, when parsing SCM_TXTIME (patch 1). But, tests in
the hot path are still needed, to handle BPF sources.

Extend the so_txtime selftest to handle this new case (patch 3).

Changes: see individual patches
Previous versions:
v1: https://lore.kernel.org/netdev/20260603190243.2789335-1-willemdebruijn.kernel@gmail.com/

Willem de Bruijn (3):
  net: ensure SCM_TXTIME delivery time is no older than system boot
  net_sched: sch_fq: convert skb->tstamp if not monotonic
  selftests: drv-net: extend so_txtime with FQ with other clocks

 net/core/sock.c                               | 32 +++++++++++++-
 net/sched/sch_fq.c                            | 43 ++++++++++++++++---
 .../selftests/drivers/net/so_txtime.py        | 18 ++++++--
 3 files changed, 83 insertions(+), 10 deletions(-)

-- 
2.54.0.1032.g2f8565e1d1-goog


