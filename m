Return-Path: <netdev+bounces-273002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOJfE/WEyWndygUAu9opvQ
	(envelope-from <netdev+bounces-273002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:00:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA507353E48
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83C6C305855A
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7948388E59;
	Sun, 29 Mar 2026 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8oHoM/O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AB1386C0F;
	Sun, 29 Mar 2026 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774814199; cv=none; b=PjACDKSWY/NXff0ZdWDl6cZxKBBFn+tbuDCC+gdKtOrR8z0zv1l64BCKuM8ZbPseKiptDT5dAQrSDBMfcqJnDFoyPtDaKX+eV14iYs3OYLMLc2PkRIfhF+EZWX04g+G+Uxmgp/6/gnkvBy9ibSBqBoQYdT0CsAyu148JVV7U4ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774814199; c=relaxed/simple;
	bh=nKA4PIbn0qBg4rZzYU2LVtGM5eKsIWH8hGqOFaVIngI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oz/C8EA5DKDyhJp32Sh9DdtSy9hRcxHI2o9WvOLXDZqnmgwDn19C/pW4WLOPjSkyQAc4DxK0OwShuqq7bBh0Xd3ld3Tkj9RQ+J/gxCriMVMwfNdmFD/j2we3DC+2A/9r0UN3F//MiG25j1blw78+u0svys6Lz2PbSTIFQzNZ8ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8oHoM/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B11FC19423;
	Sun, 29 Mar 2026 19:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774814199;
	bh=nKA4PIbn0qBg4rZzYU2LVtGM5eKsIWH8hGqOFaVIngI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B8oHoM/OXjrQMgo6KYQ6tvClbPr03d2LYJn/hOVQZwFnxqeNogfJYCbocznHhv09H
	 Sl29v5vRHghw+EaR555VPJ8A9pNmeTI8zSBsg7d5VKr2NnAd4bFGv7A9DRajssigNN
	 V0aGcEOQVBCyrEC5xxoLcRSp1IptX2FhYaSvC4SLZ2Mpc17/msZLqReSlbKfblgR/K
	 qcyIB7PCbhhCEds4luyDq26j25KJbyU/Ygu4kdDltCCzRe/VCsnSDak+quO7beqqyQ
	 XsPvd43vmHT8dXvgx4rdm6nYc1cog9aX18y87diZlqWpa4TPKQRvjz//7gi+nsoTIr
	 GYupf+CMNkK2w==
From: Jakub Kicinski <kuba@kernel.org>
To: jensemil.schulzostergaard@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	woojung.huh@microchip.com,
	linux@armlinux.org.uk,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 8/9] net: dsa: lan9645x: add mdb management
Date: Sun, 29 Mar 2026 12:56:37 -0700
Message-ID: <20260329195637.2789256-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324-dsa_lan9645x_switch_driver_base-v2-8-f7504e3b0681@microchip.com>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-8-f7504e3b0681@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-273002-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA507353E48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: dsa: lan9645x: add mdb management

Add support for dsa mdb callbacks. L2 multicast and IP multicast is
handled differently. IP multicast stores the port group mask inline in
the mac table. L2 multicast points to a PGID index, which encodes the
port group mask.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c
> new file mode 100644
> index 000000000000..4cf92887a4eb
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c
> @@ -0,0 +1,391 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2026 Microchip Technology Inc.
> + */
> +
> +#include "lan9645x_main.h"

[ ... ]

> +static void lan9645x_mdb_encode_mac(unsigned char *mac,
> +				    struct lan9645x_mdb_entry *mdb_entry,
> +				    enum macaccess_entry_type type)
> +{
> +	ether_addr_copy(mac, mdb_entry->mac);
> +
> +	/* The HW encodes the portmask in the high bits of the mac for ip
> +	 * multicast entries, to save on the limited PGID resources.
> +	 *
> +	 * IPv4 Multicast DMAC: 0x01005Exxxxxx
> +	 * IPv6 Multicast DMAC: 0x3333xxxxxxxx
> +	 *
> +	 * which gives us 24 or 16 bits to encode the portmask.
> +	 */
> +	if (type == ENTRYTYPE_MACV4) {
> +		mac[0] = 0;
> +		mac[1] = mdb_entry->ports >> 8;
> +		mac[2] = mdb_entry->ports & 0xff;
> +	} else if (type == ENTRYTYPE_MACV6) {
> +		mac[0] = mdb_entry->ports >> 8;
> +		mac[1] = mdb_entry->ports & 0xff;
> +	}
> +}

Does this code need to mask out BIT(CPU_PORT) from mdb_entry->ports?

For L2 multicast, the CPU port is explicitly stripped from the PGID portmask
to avoid conflicting instructions, since CPU_PORT forwarding is handled by the
cpu_copy flag. Here, the IP multicast portmask is encoded directly into the
MAC address using the full mdb_entry->ports. Could this cause hardware to
receive conflicting instructions (forwarding to port 9 and copying to the CPU
extraction queue), leading to duplicate multicast packets for the CPU?

[ ... ]

> +static struct lan9645x_pgid_entry *
> +lan9645x_mdb_pgid_entry_create(struct lan9645x *lan9645x, u16 ports)
> +{
> +	struct lan9645x_pgid_entry *pgid_entry = NULL;
> +	int index;
> +
> +	for (index = PGID_GP_START; index < PGID_GP_END; index++) {

Is it safe to start the search at PGID_GP_START (defined as CPU_PORT)?

Hardware uses ANA_PGID(DEST_IDX) to forward unicast traffic, and MAC table
entries for the CPU have DEST_IDX = 9. When the first L2 multicast group is
added, it appears this loop will allocate PGID index 9, overwriting the
unicast portmask for the CPU port. Could this cause all unicast traffic
destined for the CPU to be flooded to the external physical ports in the
multicast group instead?

> +		bool used = false;
> +
> +		list_for_each_entry(pgid_entry, &lan9645x->pgid_entries, list) {
> +			if (pgid_entry->index == index) {
> +				used = true;
> +				break;
> +			}
> +		}
> +
> +		if (!used)
> +			return lan9645x_pgid_entry_alloc(lan9645x, index,
> +							 ports);
> +	}
> +
> +	return ERR_PTR(-ENOSPC);
> +}

[ ... ]

> +static int __lan9645x_mdb_add(struct lan9645x *lan9645x, int chip_port,
> +			      const unsigned char addr[ETH_ALEN], u16 vid,
> +			      enum macaccess_entry_type type)
> +{
> +	struct lan9645x_pgid_entry *old_pgid, *new_pgid;
> +	struct lan9645x_mdb_entry *mdb_entry;
> +	unsigned char mac[ETH_ALEN];
> +	int err, pgid_index;
> +	bool cpu_copy;
> +
> +	mdb_entry = lan9645x_mdb_entry_lookup(lan9645x, addr, vid);
> +	if (!mdb_entry) {
> +		mdb_entry = lan9645x_mdb_entry_alloc(lan9645x, addr, vid);
> +		if (IS_ERR(mdb_entry))
> +			return PTR_ERR(mdb_entry);
> +	}
> +
> +	if (mdb_entry->ports & BIT(chip_port))
> +		return 0;
> +
> +	mdb_entry->ports |= BIT(chip_port);
> +
> +	/* Encode mac for IP mc */
> +	lan9645x_mdb_encode_mac(mac, mdb_entry, type);
> +
> +	/* Update PGID ptr for non-IP entries (L2 multicast) */
> +	old_pgid = mdb_entry->pgid;
> +	new_pgid = lan9645x_mdb_pgid_entry_get(lan9645x, mdb_entry, type);
> +	if (IS_ERR(new_pgid)) {
> +		/* Out of PGIDs or mem. Continue forwarding to old port
> +		 * group, or remove if fresh mdb_entry.
> +		 */
> +		mdb_entry->ports &= ~BIT(chip_port);
> +		if (!mdb_entry->ports)
> +			lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);
> +
> +		return PTR_ERR(new_pgid);
> +	}
> +	mdb_entry->pgid = new_pgid;
> +
> +	cpu_copy = !!(mdb_entry->ports & BIT(CPU_PORT));
> +	pgid_index = lan9645x_mdb_pgid_index(mdb_entry, type);
> +
> +	/* Make sure to write on top of existing entry, so we do not disrupt
> +	 * flowing traffic.
> +	 */
> +	err = lan9645x_mact_learn_cpu_copy(lan9645x, pgid_index, mac,
> +					   mdb_entry->vid, type, cpu_copy);
> +	lan9645x_pgid_entry_put(lan9645x, old_pgid);
> +	return err;
> +}

What happens if lan9645x_mact_learn_cpu_copy() fails and returns an error?

The software MDB state (mdb_entry->ports and mdb_entry->pgid) is updated and
the old PGID reference is dropped via lan9645x_pgid_entry_put() before
verifying if the hardware MAC table update succeeds.

If the hardware update fails, the software state isn't rolled back, leaving
them out of sync. Furthermore, the dropped old_pgid reference could allow the
index to be reallocated to a new multicast group while the hardware still
points to the old PGID index, potentially causing silent traffic cross-talk.

> +
> +static int __lan9645x_mdb_del(struct lan9645x *lan9645x, int chip_port,
> +			      const unsigned char addr[ETH_ALEN], u16 vid,
> +			      enum macaccess_entry_type type)
> +{
> +	struct lan9645x_pgid_entry *old_pgid, *new_pgid;
> +	struct lan9645x_mdb_entry *mdb_entry;
> +	unsigned char mac[ETH_ALEN];
> +	int err, pgid_index;
> +	bool cpu_copy;
> +
> +	mdb_entry = lan9645x_mdb_entry_lookup(lan9645x, addr, vid);
> +	if (!mdb_entry)
> +		return -ENOENT;
> +
> +	if (!(mdb_entry->ports & BIT(chip_port)))
> +		return 0;
> +
> +	mdb_entry->ports &= ~BIT(chip_port);
> +
> +	/* Encode mac for IP mc */
> +	lan9645x_mdb_encode_mac(mac, mdb_entry, type);
> +
> +	/* Update PGID ptr for non-IP entries (L2 multicast) */
> +	old_pgid = mdb_entry->pgid;
> +	new_pgid = lan9645x_mdb_pgid_entry_get(lan9645x, mdb_entry, type);
> +	if (IS_ERR(new_pgid)) {
> +		/* Continue forwarding to old port group. */
> +		mdb_entry->ports |= BIT(chip_port);
> +		return PTR_ERR(new_pgid);
> +	}
> +	mdb_entry->pgid = new_pgid;
> +
> +	if (!mdb_entry->ports) {
> +		lan9645x_mact_forget(lan9645x, mac, mdb_entry->vid, type);
> +		lan9645x_pgid_entry_put(lan9645x, old_pgid);
> +		lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);
> +		return 0;
> +	}

Similar to the addition path above, if lan9645x_mact_forget() fails, its
return value is ignored, and the software MDB entry and PGID are freed
anyway. This could also lead to hardware/software state desynchronization.

> +
> +	cpu_copy = !!(mdb_entry->ports & BIT(CPU_PORT));
> +	pgid_index = lan9645x_mdb_pgid_index(mdb_entry, type);
> +
> +	err = lan9645x_mact_learn_cpu_copy(lan9645x, pgid_index, mac,
> +					   mdb_entry->vid, type, cpu_copy);
> +	lan9645x_pgid_entry_put(lan9645x, old_pgid);
> +	return err;
> +}

