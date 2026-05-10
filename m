Return-Path: <netdev+bounces-286363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAxEIunCAGqJMQEAu9opvQ
	(envelope-from <netdev+bounces-286363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:39:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D9F505774
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E515D3055EA0
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997D23B3BF2;
	Sun, 10 May 2026 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYW7WpRb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638A63B38B7;
	Sun, 10 May 2026 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778434514; cv=none; b=CRSfjsl+Mg/abwdyyBUFRaxc/qi/4u398wlBp7Q47f6/C45RcytDChDTAWt1FVmxzdNAdmPgY++xxJa5T5n7pgYTvAhfVzYA/Cemv1RUc/fOm51XF4k5UYbXLW0SVUITLlfD4BJulmOxgytpOoElMzvPhAktQ9zFusDpGmBguEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778434514; c=relaxed/simple;
	bh=GvcEUICdvsRfe1chuCoMC+vwZuvsIxMiIEL1Lsnas+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnV6ArQ7/gnOa9xYyyuzCTo9qewG2uw08cicT2G73d6D32yMtD57lERI5GG6YVVCp/EFqLTN2fW54jlay8Y+rgOqUrkt1XNt4aN12vqhFkoSPQkLsQe9euvi9dMl9PfvCSOKStc2nwRlrtr66/6qbXqvLX4FBUl9wlBDdOBXpAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYW7WpRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D63EC2BCB8;
	Sun, 10 May 2026 17:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778434514;
	bh=GvcEUICdvsRfe1chuCoMC+vwZuvsIxMiIEL1Lsnas+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JYW7WpRbhGGklXBNTgI+wM1ZDVxlL8bhtjA9ApHLHZA4ImLoI/w+MTPYBpsPET0fD
	 XIkBh34U3ml1L2kiV2EY+7u1v6DHjeSvMZ3CbkcnXMXRV1lwzuV16aTa411BtlZxSL
	 UKoZFDXFCTrkhg/6DQGI9CBmIc7L4n7dIjSLRvSzST2W5ofm8HWmS1wuNGHlQ571kZ
	 oet0gboTYloRXIA8rVdRP/FFyeWXB4nRyL/8biX2odjMLgG84vugVDveQf5+0tsjFo
	 ArdoIeIUdqMvITzDf5JmOGg2ikN/WEXPSXTuV6bvyAaX4sG3wGzPagrMVecvpI/tyf
	 49g7gSPHqtqIQ==
From: Jakub Kicinski <kuba@kernel.org>
To: luizluca@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linusw@kernel.org,
	alsi@bang-olufsen.dk,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3 5/8] net: dsa: realtek: rtl8365mb: add VLAN support
Date: Sun, 10 May 2026 10:35:12 -0700
Message-ID: <20260510173512.3920005-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506-realtek_forward-v3-5-1d87c5f85a3b@gmail.com>
References: <20260506-realtek_forward-v3-5-1d87c5f85a3b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E1D9F505774
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286363-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bang-olufsen.dk:email]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Note: The format of this review has been altered to use a free-form summary of the findings rather than inline code quotes due to recitation restrictions.

commit 2401182ef461b16c2b0ffe98288b5a310381d0f7
Author: Alvin Šipraga <alsi@bang-olufsen.dk>
Subject: net: dsa: realtek: rtl8365mb: add VLAN support

This commit adds VLAN support for the RTL8365MB switch family. It implements a dynamic allocation scheme to manage both the full 4096-entry VLAN4K table and the smaller 32-entry VLANMC table, keeping them synchronized and allocating VLANMC entries primarily for PVID assignment.

When configuring a port's PVID, rtl8365mb_vlan_pvid_port_add() allocates a new VLANMC entry. However, if a user changes a port's PVID, does the driver leak the old PVID's hardware slot? In rtl8365mb_vlan_pvid_port_del(), the driver reads the port's current PVID and returns early if it no longer matches the deleted VLAN. Since the hardware is strictly limited to 31 VLANMC entries, it seems repeatedly changing PVIDs could permanently exhaust the table and result in -E2BIG errors.

In rtl8365mb_vlan_mc_read(), the driver extracts the member, fid, priority, and evid fields, but appears to leave meteridx, policing_en, and priority_en uninitialized. When modifying an existing entry, rtl8365mb_vlan_mc_port_set() passes a partially zero-initialized stack structure to rtl8365mb_vlan_mc_write(). Does this unintentionally clear those fields in the hardware register during write-back?

The commit message states that the driver keeps membership configurations in sync when a corresponding entry exists in VLANMC. However, rtl8365mb_port_vlan_add() only calls the PVID add function if the pvid flag is true. If a port is added as a non-PVID member to a VLAN that already has an active MC entry, it seems the port is only added to the VLAN4K table. Does this leave the VLANMC member mask permanently desynchronized from the actual VLAN membership?

In rtl8365mb_port_vlan_filtering(), the driver iterates through available ports to set the transparent mode. If rtl8365mb_port_set_transparent() fails midway, the function returns immediately. A similar pattern exists in rtl8365mb_vlan_pvid_port_del(), where it modifies the port frame filter and PVID before calling rtl8365mb_vlan_mc_port_set(). Could these early returns leave the switch in an inconsistent state? It looks like they might benefit from proper error unwinding to revert the successful register modifications.

When searching for an empty VLANMC slot, rtl8365mb_vlan_mc_find() checks if the evid is 0x0. If a port is explicitly configured to use VLAN 0, perhaps for 802.1p priority tagging, could this active configuration be mistakenly identified as an empty slot? It seems this might cause a newly configured PVID to silently overwrite the active VLAN 0 configuration. Would checking the member mask alongside the evid help prevent this?

This isn't a bug, but in rtl8365mb_vlan_port_set_framefilter(), the accepted_frame argument is typed as an enum rtl8365mb_frame_ingress, but it is bit-shifted and reassigned to itself. Could this trigger static analyzer warnings about assigning a shifted integer back into an enum variable? Using a separate u32 variable for the shifted mask might be safer.

