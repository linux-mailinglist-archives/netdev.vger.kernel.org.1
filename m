Return-Path: <netdev+bounces-297539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yrreHfYjKWqRRQMAu9opvQ
	(envelope-from <netdev+bounces-297539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:44:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4C96675A1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:44:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=c127.dev header.s=resend header.b=SSJw5Z6H;
	dkim=pass header.d=amazonses.com header.s=224i4yxa5dv7c2xz3womw6peuasteono header.b="YMn8znt/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297539-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297539-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 260D530F1859
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB453B27EE;
	Wed, 10 Jun 2026 08:41:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from a9-25.smtp-out.amazonses.com (a9-25.smtp-out.amazonses.com [54.240.9.25])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2420D3B19A9;
	Wed, 10 Jun 2026 08:41:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080886; cv=none; b=rSBi5As1gDnv7quz71g3KuSCIKJwOGqhOG11+si3r2O2uaqASmAg4XJcrZihlB8SoaVe80qAlB7cJ6b2rBCRnIN+DUhjS5DEI3fT6UEhKZ5SivSSL2hFhTUrDspzyOm77QkouTBQE0lh6RqjknRghFThLpubQxG6rChlvbZuXMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080886; c=relaxed/simple;
	bh=mK3nrvsi7feMTvtPODs1gZ8VpHN+s4738hCZ/Exe8P4=;
	h=From:To:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type; b=OTmEC/UsFf5s0CNeIM1fqrCZquC9wbpYi/WKuMu63mVPg7lqyoaQXhpSsmESs1OHVHuYtuLJ2gsbwdLRDdBE0w86vCmChNvfsDj926pufhJyG9UFFffrMax6vPen6dUqMcij1/4XFVKs74zHnOwZWKck7hRD5tHAemNpwiZkcpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=SSJw5Z6H; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=YMn8znt/; arc=none smtp.client-ip=54.240.9.25
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1781080884;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=mK3nrvsi7feMTvtPODs1gZ8VpHN+s4738hCZ/Exe8P4=;
	b=SSJw5Z6HIUL7WSqB6dxqpSTUn1fqiAB5qw+9p92699OQE9XcdKn3YQcRauYw2vZX
	hL7wOu7rfNBYhUxMxr5L5HHG/STPpvgM9FyCmA+61GYoZyaro+du1GcvKEl1rtonHBn
	oqkdAwwNRM/VtdBRz7RLCGRsyAxfzNgL2n6MsXjE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1781080884;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=mK3nrvsi7feMTvtPODs1gZ8VpHN+s4738hCZ/Exe8P4=;
	b=YMn8znt/4EGarH9it/GIluPOqnrfFxW8DHxt3R4ddx2xd7YSR/eR3tOcJE97Khrg
	ocP4MtPh+7uRf1EIpqRR0QeUMuPr2BZuveXsXOmHprPV9wpPBdjw8hxYyyittOoPOXe
	x2vUzTkzFbiN/lS/WXomFw1bcp96vSMbwpxjXUYw=
X-Mailer: git-send-email 2.54.0
From: Johan Alvarado <contact@c127.dev>
To: netdev@vger.kernel.org
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, contact@c127.dev
Subject: [PATCH net-next v2 0/2] net: dsa: realtek: rtl8365mb: add
 SGMII/HSGMII support for RTL8367S
Message-ID: <0100019eb0b1822e-ffc5626c-1b9f-4c8a-8a1a-759a9e665f4f-000000@email.amazonses.com>
Content-Transfer-Encoding: 7bit
Date: Wed, 10 Jun 2026 08:41:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.06.10-54.240.9.25
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[c127.dev:s=resend,amazonses.com:s=224i4yxa5dv7c2xz3womw6peuasteono];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:linux-kernel@vger.kernel.org,m:contact@c127.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[c127.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297539-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org,c127.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[c127.dev:+,amazonses.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,email.amazonses.com:mid,amazonses.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE4C96675A1

The RTL8367S is a 5+2 port switch from the same family as the
RTL8365MB-VC already supported by this driver. Its chip info table
entry declares SGMII and HSGMII on external interface 1, but the
driver so far only implements RGMII, leaving boards that wire the
switch to the CPU over the SerDes without a working CPU port.

This series implements both modes. The configuration sequence and the
SerDes tuning parameters are derived from the GPL-licensed Realtek
rtl8367c vendor driver, as distributed in the Mercusys MR80X GPL code
drop. The SerDes bring-up requires firmware running on the switch's
embedded DW8051 microcontroller; the firmware blob from the vendor
driver will be submitted to linux-firmware separately as
realtek/rtl8367s-sgmii.bin, and is loaded via the firmware API.

Patch 1 adds the SerDes indirect access helpers, the DW8051 firmware
loading and SGMII (1 Gbps) support. Patch 2 extends this to HSGMII
(2.5 Gbps), which phylink represents as 2500base-x.

Tested on a Mercusys MR80X v2.20 (RTL8367S connected to the SoC via
the SerDes), in both SGMII and HSGMII modes, with a fixed-link device
tree description.

v2: no code changes. Resending the entire series because the SMTP
provider used for v1 corrupted the mails and patch 1/2 never reached
the list, leaving an incomplete series. Apologies for the noise.

Johan Alvarado (2):
  net: dsa: realtek: rtl8365mb: add SGMII support for RTL8367S
  net: dsa: realtek: rtl8365mb: add HSGMII support for RTL8367S

 drivers/net/dsa/realtek/rtl8365mb.c | 394 +++++++++++++++++++++++++++-
 1 file changed, 390 insertions(+), 4 deletions(-)

-- 
2.54.0


