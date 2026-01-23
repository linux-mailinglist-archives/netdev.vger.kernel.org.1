Return-Path: <netdev+bounces-252675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIDOFmUqc2l7swAAu9opvQ
	(envelope-from <netdev+bounces-252675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:59:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEDC72197
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E6053018BCD
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C722344DA3;
	Fri, 23 Jan 2026 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="jDPtIjzf"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142151B81CA;
	Fri, 23 Jan 2026 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155164; cv=none; b=V/nL3JgDih/EuVHi4JEEqXr3vNQc7uqoz++MyvgdXnYD4zpDDzgTF/C4veF0Gq3Ere8Lv6hZs5IRwSRuXLEp0Y2uFqjyDCwfyNtaO1WkcfS+V7EnpYgecnj2klf1cHR1NOCExKybgow2hwtfWNCOeuNiJycI7ssVYqFp36NzLwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155164; c=relaxed/simple;
	bh=SsQgRVrALIEbimguf13cUqs0gI1w1LmHdJZ04aIQ3CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=odRKPmKLJB4O5AvSAncqwCMW1aF0nET8vZ5V0RRzEXG5ZT+BRI2fmdkIr/C8prARrSdgW0hy25mrBfNksbdrtA5fIlETr5MM0y3o3TxPPgXEo2hqzpqrOGb44iWxPccJaOYypSqIyBh7zcY8ayka03qMC8Ua4yufQSCal3+bapo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=jDPtIjzf; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=jDPtIjzf;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 60N7wTJe1303105
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 07:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1769155109; bh=IyTEWleDrSZIoXhyMc9DAYmo3+9uVHcoYrCCzjQ0PUI=;
	h=From:To:Cc:Subject:Date:Message-ID:From;
	b=jDPtIjzfVF8GnE1ObzPsTfoDgz5oaxjqNGMMnPFJamuSLrK8RWfY85XME0SPKHFDt
	 PhmltuZgUOsKbLfwNbnCBeAX1s/Rq2lFa36LgJXt/xIs+TtTd0sGwo1416WZnAa5to
	 +RKi9TbBYLWIvq7k994OdlXu1QYw1fK2GFHT+t7k=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 60N7wTG33568526
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 08:58:29 +0100
Received: (nullmailer pid 1162087 invoked by uid 1000);
	Fri, 23 Jan 2026 07:58:28 -0000
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
Subject: [PATCH net-next v2 0/3] Airoha AN8811HB 2.5 Gbps phy support
Date: Fri, 23 Jan 2026 08:58:14 +0100
Message-ID: <20260123075817.1162068-1-bjorn@mork.no>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mork.no,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mork.no:s=b];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,makrotopia.org,nxp.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no];
	TAGGED_FROM(0.00)[bounces-252675-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@mork.no,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mork.no:+];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mork.no:mid,mork.no:dkim]
X-Rspamd-Queue-Id: EEEDC72197
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

RFC: https://lore.kernel.org/20251202102222.1681522-1-bjorn@mork.no/
v1:  https://lore.kernel.org/20260122071601.1057083-1-bjorn@mork.no/

Changes since v1:
- moved AIR_AUX_CTRL_STATUS_SPEED_10 reference from patch 1 to 2, where
  it is defined, fixing intermediate build error
- rearranged an8811hb_check_crc loop to improve readability for AI and
  other intelligent beings

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

 drivers/net/phy/air_en8811h.c | 511 ++++++++++++++++++++++++++++++----
 1 file changed, 461 insertions(+), 50 deletions(-)

-- 
2.47.3


