Return-Path: <netdev+bounces-286365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKeDKRTDAGqJMQEAu9opvQ
	(envelope-from <netdev+bounces-286365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:40:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A999505782
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C951305B595
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C4D3B584F;
	Sun, 10 May 2026 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THfxSy19"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB3D3B583E;
	Sun, 10 May 2026 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778434517; cv=none; b=RMZ79na9wQY8MsdCLjtb7Ul9yak6a6E+7iQTU/sp5j4NRzcbQhDPlMOjD9+z3wh4KOZ7apBhYOYuGRTMdIfNEtggRYq4YY4qyi6QHIS/306u22JuXF51sGmchMd/T4vt9ZPIzsKrMhQZhN1AKs62/vfx3lPXGgsFwV6xqrJDMvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778434517; c=relaxed/simple;
	bh=HB3AmcqtaDhCqSsUuOmq+n+OEfZ0V+olniUIZM0nn0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/54Hgh2hnfKYZ5b7l6ni5fc0XfPLljKCyPiYRgsq3n2zlcQkLD5n4nJ/CFqUjvtaow/hTsO6QhIXRNR7FfGhg8KKimU+T4kD4jyVBvcTszZ1lWYki7p0p6s+2hcLFsRcEz5C/X2ULvlbBJA4pMxykoJmMk5n1VKP0u3/XJZcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THfxSy19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A1EC2BCB8;
	Sun, 10 May 2026 17:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778434517;
	bh=HB3AmcqtaDhCqSsUuOmq+n+OEfZ0V+olniUIZM0nn0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=THfxSy19Dhjte3gi47Kvgi9XMYiL00VHUd9nuCYic2og04rfLsL6TMN/+L2CPEREP
	 DD8V6HppXPEhie/K6tL+8DkDGJOgYRTCpJa4h/sL/1Q2gdA14N8gA8SRP/+5Q5Raa1
	 WHLGz8ycOAE7Pdt/1kshfv1F+XwgVuLz73xwjzrKQKWmft/CyNToBmVwJBE0JRWxlt
	 u4AMSPEeCJzCstEUQQYy3PyuE9GGHONSk5kvjWp4Z0hAsW6C9PRyL7XsnrzQc4lBnG
	 CbeXGjG5HKzfsKmZbXirZD8gkus9qZXHaGJ6pWu1UVFJraqC+gH3/8X1YHX31UGJ5F
	 nh850r2jjdtqQ==
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
Subject: Re: [net-next PATCH v3 7/8] net: dsa: realtek: rtl8365mb: add FDB support
Date: Sun, 10 May 2026 10:35:16 -0700
Message-ID: <20260510173516.3920093-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506-realtek_forward-v3-7-1d87c5f85a3b@gmail.com>
References: <20260506-realtek_forward-v3-7-1d87c5f85a3b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0A999505782
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286365-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: realtek: rtl8365mb: add FDB support

Implement support for FDB and MDB management for the RTL8365MB series
switches. Introduce a mutex lock (l2_lock) to protect concurrent L2 table
updates. Add support for forwarding database operations, including unicast
and multicast entry handling as well as fast aging support.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_l2.c b/drivers/net/dsa/realtek/rtl8365mb_l2.c
> --- /dev/null
> +++ b/drivers/net/dsa/realtek/rtl8365mb_l2.c

[ ... ]

> +static void rtl8365mb_l2_data_to_uc(const u16 *data, struct rtl8365mb_l2_uc *uc)
> +{

[ ... ]

> +	uc->key.efid = FIELD_GET(RTL8365MB_L2_UC_D4_EFID_MASK, data[4]);
> +	uc->key.vid = FIELD_GET(RTL8365MB_L2_UC_D3_VID_MASK, data[3]);
> +	uc->key.ivl = FIELD_GET(RTL8365MB_L2_UC_D3_IVL_MASK, data[3]);
> +	uc->key.fid = FIELD_GET(RTL8365MB_L2_UC_D4_FID_MASK, data[4]);

Because vid and fid share the same union memory in struct rtl8365mb_l2_uc_key,
does setting fid immediately after vid overwrite the 12-bit vid value with
the 4-bit fid value?

When rtl83xx_port_fdb_dump() later passes entry.vid to the DSA core, it
appears this sends the corrupted fid value instead, breaking VLAN visibility
in userspace tools like bridge fdb show.

[ ... ]

> +static void rtl8365mb_l2_data_to_mc(const u16 *data, struct rtl8365mb_l2_mc *mc)
> +{

[ ... ]

> +	mc->is_static = FIELD_GET(RTL8365MB_L2_MC_STATIC_MASK, data[5]);
> +	mc->member = FIELD_GET(RTL8365MB_L2_MC_MBR_MASK, data[4]) |
> +		     (FIELD_GET(RTL8365MB_L2_MC_MBR_EXT1_MASK, data[3]) << 8) |
> +		     (FIELD_GET(RTL8365MB_L2_MC_MBR_EXT2_MASK, data[5]) << 8);

Could this shift for MBR_EXT2_MASK be incorrect? 

It seems this shifts MBR_EXT2_MASK by 8 instead of 10. This causes the
extended bit for port 10 to collide with the EXT1 bits (which are correctly
shifted by 8) and leaves bit 10 perpetually unset.

In rtl8365mb_l2_mc_to_data(), the shift used is 10:

data[5] |= FIELD_PREP(RTL8365MB_L2_MC_MBR_EXT2_MASK, mc->member >> 10);

When the driver performs a read-modify-write operation on an existing
multicast entry, this shift mismatch might cause port 10 to be silently
dropped and port 8 to be erroneously altered.

[ ... ]

> +int rtl8365mb_l2_add_mc(struct realtek_priv *priv, int port,
> +			const unsigned char mac_addr[static ETH_ALEN],
> +			u16 vid)
> +{

[ ... ]

> +	mc.member |= BIT(port);
> +	mc.is_static = 1;
> +	rtl8365mb_l2_mc_to_data(&mc, data);
> +
> +	/* First look for an existing entry (to get existing port members) */
> +	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
> +				    RTL8365MB_TABLE_OP_READ, &addr,
> +				    RTL8365MB_TABLE_L2_METHOD_MAC, 0,
> +				    data, RTL8365MB_L2_ENTRY_SIZE);
> +	if (!ret) {
> +		/* There is already an entry... */
> +		rtl8365mb_l2_data_to_mc(data, &mc);
> +		/* the port must be added as a member */
> +		mc.member |= BIT(port);
> +		rtl8365mb_l2_mc_to_data(&mc, data);

If an entry already exists in hardware, rtl8365mb_l2_data_to_mc() overwrites
the mc struct with the hardware state. If the existing hardware entry was 
dynamically learned (e.g., via IGMP snooping), is_static is overwritten to 0.

Would this cause the software-requested static MDB entry to be subject to 
hardware aging?

> diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
> --- a/drivers/net/dsa/realtek/rtl83xx.c
> +++ b/drivers/net/dsa/realtek/rtl83xx.c

[ ... ]

> +int rtl83xx_port_fdb_dump(struct dsa_switch *ds, int port,
> +			  dsa_fdb_dump_cb_t *cb, void *data)
> +{

[ ... ]

> +	mutex_lock(&priv->l2_lock);
> +	while (true) {
> +		start_addr = addr;
> +
> +		dev_dbg(priv->dev, "l2_get_next_uc, addr:%d, port:%d\n",
> +			addr, port);
> +		ret = priv->ops->l2_get_next_uc(priv, &addr, port, &entry);
> +		dev_dbg(priv->dev,
> +			"l2_get_next_uc addr:%d mac:%pM vid:%d static:%d ret:%pe\n",
> +			addr, entry.mac_addr, entry.vid, entry.is_static,
> +			ERR_PTR(ret));
> +
> +		if (ret == -ENOENT)
> +			break;
> +		if (ret)
> +			break;
> +
> +		if (addr < start_addr)
> +			break;
> +
> +		cb(entry.mac_addr, entry.vid, entry.is_static, data);

If the netlink socket buffer fills up, the callback returns -EMSGSIZE.
Since the return value of cb() is ignored here, does the loop fail to abort
and continue iterating the hardware table?

This would result in the netlink subsystem receiving an incorrect success
(or -ENOENT) instead of -EMSGSIZE, preventing it from resuming the dump later
and silently truncating FDB lists.

> +
> +		addr++;
> +
> +		/* Avoid querying beyond the valid L2 table range. */
> +		if (addr > l2_table_size)
> +			break;
> +	}
> +	mutex_unlock(&priv->l2_lock);
> +
> +	return ret;

When l2_get_next_uc() reaches the end of the hardware table, it returns
-ENOENT. 

Because ret is not reset to 0, this returns -ENOENT to the DSA core upon
successful completion. Should this return 0 on success to adhere to the
expected API contract?

