Return-Path: <netdev+bounces-306023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4pnEJPD9TmpVYgIAu9opvQ
	(envelope-from <netdev+bounces-306023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 03:48:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 357D272BC0B
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 03:48:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RZpA6odj;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306023-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306023-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2C843016B78
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 01:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF97B242D7F;
	Thu,  9 Jul 2026 01:48:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D40228CB8
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 01:48:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783561709; cv=none; b=KwVh6qzEcRPFHP+7xMHBG752odUMJUf2c9pTkO8vOui4koIu2YRe7gtW9eOXtjASlud3f+96/tLZVy564BGjbO05QkJSk4zDmIKZs8K5WqQGjiF6hYVKdqGeDDxvYC5RUa/SMMGte9EkilVZ6SpA7ohiU6i0sqQlQJ3el1M3vLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783561709; c=relaxed/simple;
	bh=iEHrD9FjHMVqJqfM/WCkUAP1GryeKRdy6kXTmAiXELY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rEJ8+Ay4A4tQDShOsMuDH9aCEJJIyJ47UwHekHeMLiArTuMM7/ehYv0KZ2gUEZwRV/Mjc0rbOvNQRKQH7zL7xiCuWEVicL3mRD1mKWO62eQ1BNbOXid0txgSRXqJaSAPwoHuxMNrMvLEQEcMK81gQ4lfyP8X02XH1VcvsK6dC1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZpA6odj; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84592b55832so327323b3a.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 18:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783561708; x=1784166508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UuiKXDPAgjQuMH9pMD+TDI3kTjVhNpir/uN1/Fbl0Us=;
        b=RZpA6odjgo6kPxJApxZOR4YVz7mmDV+fFuERcZv6/P2+3uts0IxRWSchDiR12AekQx
         AcBZwclGgVDPPjJ7ZkfLozz5os3VqGJZ4oBaexf9a7k5O3pwNeolUengjjXjl9qSA5Fs
         rZbCw1JvAhxPR5hmRmA0S/eZUTDVD+RBoLiMGGpMFtbVPGGNP1aLfwNfKLHdOTVHA84q
         0/Owvh4k7lskt8/v5rsOxWAIvnIkItpsiXWpSthk2yB8WCN5aXPbh4XDwtgcPlk2SgJa
         J47fdCwqrNcvgQdML3QkADV/BVIR+XO69Uxpkz7kki+xWTGql0N5cYeEUcE0zU51mwiE
         9CMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783561708; x=1784166508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UuiKXDPAgjQuMH9pMD+TDI3kTjVhNpir/uN1/Fbl0Us=;
        b=ObOzHrgP9PsiTPRwyoOPb8TFFm1Krijz8ZWmMPFP3ZsTHZCb410/Id9JqxncdEucaf
         ud4Jb+fGqaAJ+P5KPqE3Ydjwqq3xBIGvr9eFYp2QnF5cVIlTAyFsRjzg0T0qp9EILX3V
         Em+oq8fam/qd9tWHGmjuZMR7WcPg0MquDpW6BgeWbmFqUrQ+6pmd857VDxkdoj8BZkIa
         WK3GU0MKdRHNnm6c/sB+p9aocjnIdR9B5EZmENeWB+RfekISebsNAGaGbz5u0KflglX0
         xjZFkax5TY+mUJPATC1dkUl6BVyecBdoaZg15PVN1UjupV/H0ECP01JlxLk5YprW7K1c
         5gMw==
X-Gm-Message-State: AOJu0YyVi4Av24d4Hr/Wj82K6sD0s2M+nWeioXHW3x+Y5nN3W36nd/7I
	wRQ37D4TFUVhDwAzmRWjcFUt934mDgz3bVbTdvsx2aOnjRNBjtGIn77+AhqZZl8p
X-Gm-Gg: AfdE7cktfj60QHVJAZWWKAW2c7aUq+43N6L2Bsx2dLBKPPo0e0PK5brm82buNDjmD//
	ygFfexldvyK4c7DfW1Fhv5yAAN1Xr/GkAI5wf4p6hFVg+JkQnibIWTa0Sxz0jUnESN+6XZ9DD/e
	Tc4X20mnUzklPcPzgy51Bk8Hl/MCSszmoOV4qiGkhhpFmGUelggIzVCW5n3cRBALMZlsneBns26
	yEgtRI2IXGaYtOl1bGnbpYh2BIwd0JtrTEqkKH3WsIxth3L601/RR637XbZPYemuDjizQbRqnWB
	r8dXV+SSFlgUnsMF8XgXr6+dmy89IDopfDUwBSxcCdA0pJ6kuWVEbbBNN6FyGRch8+9I/3H4n+V
	aQf0JqXKP+8kYCF/Xz0cpY1lqdI5lPALTRzQZKwP63u7kY6LWhle5bTSzFNNS5L1ZTZCOLnL2KE
	RQC3Uj0iAj5dvqWxOXBwZYDUXh3uuR8Hs8zEuvdP4=
X-Received: by 2002:a05:6a00:4191:b0:847:7f3c:b5f5 with SMTP id d2e1a72fcca58-84842ed2020mr4993671b3a.11.1783561707666;
        Wed, 08 Jul 2026 18:48:27 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:3046::4cf:38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b97bbesm8072434b3a.17.2026.07.08.18.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 18:48:26 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 0/3] net: dsa: motorcomm: Add LED support
Date: Thu,  9 Jul 2026 09:47:44 +0800
Message-ID: <20260709014812.1158178-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306023-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 357D272BC0B

v5: https://lore.kernel.org/r/20260707064752.1030345-1-mmyangfl@gmail.com
  - improve trigger selection
v4: https://lore.kernel.org/r/20260703165241.542195-1-mmyangfl@gmail.com
  - fix some reg op typos
v3: https://lore.kernel.org/r/20260701155519.273212-1-mmyangfl@gmail.com
  - fix null pointer dereference
  - support polarity auto-configuration
v2: https://lore.kernel.org/r/20260629183137.541341-1-mmyangfl@gmail.com
  - allocate LED structures only
  - eliminate double locking
v1: https://lore.kernel.org/r/20260618202716.2166450-1-mmyangfl@gmail.com
  - set up polarity correctly
  - do not set up .brightness_get() to prevent dead lock

David Yang (3):
  net: dsa: motorcomm: Move to subdirectory
  net: dsa: motorcomm: Split SMI module
  net: dsa: motorcomm: Add LED support

 MAINTAINERS                                   |   2 +-
 drivers/net/dsa/Kconfig                       |  10 +-
 drivers/net/dsa/Makefile                      |   2 +-
 drivers/net/dsa/motorcomm/Kconfig             |  17 +
 drivers/net/dsa/motorcomm/Makefile            |   5 +
 .../net/dsa/{yt921x.c => motorcomm/chip.c}    | 222 +-----
 .../net/dsa/{yt921x.h => motorcomm/chip.h}    |  14 +-
 drivers/net/dsa/motorcomm/leds.c              | 630 ++++++++++++++++++
 drivers/net/dsa/motorcomm/leds.h              | 121 ++++
 drivers/net/dsa/motorcomm/smi.c               | 157 +++++
 drivers/net/dsa/motorcomm/smi.h               |  88 +++
 11 files changed, 1048 insertions(+), 220 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/Kconfig
 create mode 100644 drivers/net/dsa/motorcomm/Makefile
 rename drivers/net/dsa/{yt921x.c => motorcomm/chip.c} (96%)
 rename drivers/net/dsa/{yt921x.h => motorcomm/chip.h} (99%)
 create mode 100644 drivers/net/dsa/motorcomm/leds.c
 create mode 100644 drivers/net/dsa/motorcomm/leds.h
 create mode 100644 drivers/net/dsa/motorcomm/smi.c
 create mode 100644 drivers/net/dsa/motorcomm/smi.h

-- 
2.53.0


