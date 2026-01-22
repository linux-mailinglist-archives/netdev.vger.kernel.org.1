Return-Path: <netdev+bounces-252225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDoeAD7PcWnSMQAAu9opvQ
	(envelope-from <netdev+bounces-252225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:18:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8796C6271F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 92E7B42A141
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 07:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740DB38BF6A;
	Thu, 22 Jan 2026 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="fAFJ1SoV"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544353D3012;
	Thu, 22 Jan 2026 07:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769066243; cv=none; b=ZsIM4T15JyBfY/jSAxTW2K8baE8XcBnl2z3P/o/hYyihz2Gg88IU7+VZsmzH4rAmr+Et4f6RWbUZEYuNt+I9Zh2DN5cMDQPD3/odmM5xZ9bg6fC58X79wROtaH5hvt9wlGiIdO0O17UI2ix6haHDSL8JWKTKyy2/uPASvMRbcwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769066243; c=relaxed/simple;
	bh=lXmX0fssGG7boqMteprFQ3DftHIwc8tC46Ns1HPitH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c57FaUPH/bJsnxFkz0dLs+zdHlT1BKqsVXVSjJSdh+hFeF91XToD9Vqyef9P6acpQmpqYXoZyIIomXFvSXxR12AdTsqtRR+I+8JXWoP7iucbFRXL36wRGW7DXK0CxPEvf2kn7QTxHzbby9qunh9WSOESepOJ2CBaPTpWKHAOM54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=fAFJ1SoV; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=fAFJ1SoV;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 60M7GMlq1239607
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 07:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1769066182; bh=dfoTS0cevGw8oOjXHOU1wkv2LAaTNCCALOMlmg1BUDk=;
	h=From:To:Cc:Subject:Date:Message-ID:From;
	b=fAFJ1SoVC0cu5vySL8C5Zfn8MDhsFfNM9ZxSuVyFZheQ14hZMOJNw9vtqHRfB0NxB
	 5Px1MH2DZDAX7rcC3iL8w606QQmorWCjdhL5mWynhHhkQJPB+f7vT085MbjQXw0n5h
	 GUnVREJqzlNbbWA2INjC+1iohW5QNTTKQphasivo=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 60M7GMtr3217356
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 08:16:22 +0100
Received: (nullmailer pid 1057102 invoked by uid 1000);
	Thu, 22 Jan 2026 07:16:22 -0000
From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
To: netdev@vger.kernel.org
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH net-next 0/3] Airoha AN8811HB 2.5 Gbps phy support
Date: Thu, 22 Jan 2026 08:15:57 +0100
Message-ID: <20260122071601.1057083-1-bjorn@mork.no>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[mork.no:s=b];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,makrotopia.org,nxp.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252225-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[mork.no,reject];
	DKIM_TRACE(0.00)[mork.no:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@mork.no,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mork.no:mid,mork.no:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 8796C6271F
X-Rspamd-Action: no action

The RFC patch posted earlier has been split into a series based on the
feedback received:

 1/3: preparing the EN8811H driver for maximum reuse
 2/3: adding support for the new AN8811HB hardware
 3/3: adding (optional) clock driver for AN8811HB

Patch 3/3 is not required for a functional device. It is included here
for full feature parity between the EN8811H and AN8811HB drivers.

The AN8811HB phy requires new firmware, which is now available with
the 20260110 release of linux-firmware,

RFC patch is at:
https://lore.kernel.org/20251202102222.1681522-1-bjorn@mork.no/

Changes since RFC:
- refactoring of the existing EN8811H code is separated into a patch
  of its own
- ID conditionals are dropped, using separate functions for the two
  hardware variants instead. Some common helpers have been added to
  reduse code duplication
- deprecated serdes polarity properties are not supported for AN8811HB
- the polarity configuration code has proper error handling
- a polarity configuration bug is fixed by using the new simplified
  helper interface
- the clock driver is split out in a separate patch to reduce the size
  of the main AN8811HB driver patch

Bjørn Mork (3):
  net: phy: air_en8811h: factor out shareable code
  net: phy: air_en8811h: add Airoha AN8811HB support
  net: phy: air_en8811h: Add clk provider for an8811hb

 drivers/net/phy/air_en8811h.c | 513 ++++++++++++++++++++++++++++++----
 1 file changed, 463 insertions(+), 50 deletions(-)

-- 
2.47.3


