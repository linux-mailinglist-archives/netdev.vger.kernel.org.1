Return-Path: <netdev+bounces-303114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yfSsCkOoQ2qYeQoAu9opvQ
	(envelope-from <netdev+bounces-303114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:28:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 869666E395A
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:28:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KEyR6CQu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303114-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303114-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1E1B30583CC
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F4E3FC5B9;
	Tue, 30 Jun 2026 11:19:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7313EA962
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:19:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818390; cv=none; b=EiyXTl2yBzTk6DDJJLZjlwy4F69Nh0x2kwE+mCqWFKpS+MNiV55PDSaSBi0RAZCobBOuEpe65GgoK/qsZE2maTFmygQ0lKonkzuGxSsJgfwDlXMqCeM1axsDkkwxuwPtkld2UbdDh/Rtpp596YP194naqaiaTyHMzqM/KBGui18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818390; c=relaxed/simple;
	bh=ijrQtH/J/+QU/Q7uhbxgKn/lrQe0GR1Pj7ac0J8UYbg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EYcMEYmydml8KQKKfsycnwn49GxM0eKhFn4MS/AyYECygG+Bi6AbJzAIg3ZlsQejvNUQyAQvtzebBU59e1PI4qjJuz4gA+KxMdOPsM4FtDUvDP92VLi77J3wEw6o+EExtW8+sxc5m4VJgcbKiHSgk8SvzdUOSYi1qZ9tIicZ66o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEyR6CQu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606581F000E9;
	Tue, 30 Jun 2026 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818389;
	bh=SiW+8LV11SJo42nmFzjtEE72TMoUV2Ahtx3cTWNie7w=;
	h=From:Subject:Date:To:Cc;
	b=KEyR6CQuRjN7HsXVk4pygSB03kM6wLcNixl6c70lCfgc0QrQ8AbgarkYokGpTvJtV
	 KVjuwEBViA2aRbjeCl+r/bgMvv7wkP9GAhf4foDZWx+Dn6hPV3X1ynZ0KXj39xOGEU
	 NEziyoPRPeDf4XW8WXU0zvxgJmXl9fGUzLV/tzs8gbukBge+4C9iCKS1bnpQPJ3atR
	 wt2p4a+GKj11NLnGA8egyITSygnrBAISgJfO8zmrpBnB86KQwQUB+EmE4QXUNmdTJj
	 O235mVjBFx/uDZ77xc2VgBFGnUcVG8MMk+LyOe9KSd5xEqaPvZhwZGoVbK9vJJhsml
	 /tOHQ4DRf2oig==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next v2 0/5] net: dsa: realtek: rtl8366rb: Use generic
 RTL83xx code
Date: Tue, 30 Jun 2026 13:19:40 +0200
Message-Id: <20260630-rtl8366rb-improvements-v2-0-05eb9d6a37f5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOwQ6CMBBEf4Xs2Zp20QY8+R+Gg8ACVWjJtjYYw
 r8L6NXjZObNzAye2JCHSzIDUzTeOLsKPCRQdXfbkjD1qgElaqmVEhz6LNWaS2GGkV2kgWzwotZ
 5g+p0RpXXsMIjU2OmvfgGloKwNAUovo5/lQ+qwta7ZTvjg+P3/iGqnfjN4b+5qIQUOaaImW4ql
 NX1SWypPzpuoViW5QM1kMaY2QAAAA==
X-Change-ID: 20260611-rtl8366rb-improvements-d69f2145219d
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:luizluca@gmail.com,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linusw@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,bang-olufsen.dk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303114-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 869666E395A

As a follow-up to Luiz's and Alvin's series improvining the
generic handling of the Realtek DSA switches, this small
series brings the RTL8366RB closer to the way things are done
in the RTL8365MB driver.

This patch series switches over to using the generic helpers
for:

- Bridge joining and leaving (isolation)
- STP handling
- Learning enable/disable

It would be appreciated if this doesn't lead to AI-automated
request to fix the entire universe (hi Sashiko, I'm looking
at you but I bet you will do you compulsive C3P0-style review
anyway) since I'm just moving code around so some helper
functions come before their new users. The code itself is
pretty straight-forward.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v2:
- Rebase on v7.2-rc1
- Prepend a patch making the learning callbacks optional so we can add
  functionality one patch at a time.
- Link to v1: https://patch.msgid.link/20260612-rtl8366rb-improvements-v1-0-9232286fc20c@kernel.org

---
Linus Walleij (5):
      net: dsa: realtek: rtl83xx: Make learning optional in join/leave
      net: dsa: realtek: rtl8366rb: Switch to generic port_bridge* handlers
      net: dsa: realtek: rtl8366rb: Use DSA port iterators
      net: dsa: realtek: rtl8366rb: Disable STP learning on all ports in setup
      net: dsa: realtek: rtl8366rb: Switch to generic learning enablement

 drivers/net/dsa/realtek/rtl8366rb.c | 268 ++++++++++++++++++------------------
 drivers/net/dsa/realtek/rtl83xx.c   |  26 ++--
 2 files changed, 143 insertions(+), 151 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260611-rtl8366rb-improvements-d69f2145219d

Best regards,
--  
Linus Walleij <linusw@kernel.org>


