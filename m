Return-Path: <netdev+bounces-291002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJZvCVYEEWr5gQYAu9opvQ
	(envelope-from <netdev+bounces-291002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:35:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 981825BC576
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A77C3019FF4
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12B722068D;
	Sat, 23 May 2026 01:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJndRksY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCA85FDA7;
	Sat, 23 May 2026 01:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779500113; cv=none; b=JoMgWD08TboZDZg98B+bM5IznJ4/CELHKGrZ9pkzifmOHiNrhWBdwjMcyguH8v0bTnS3tjv4G+4f25f0BlrAkpJz8Wt6rUMYSycCiS9gqY4lzmxZIDRItUDszsD2izdUS3mv7MWDmONHf3a49IDAd8x6W94CVVD/iutYjNmG0RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779500113; c=relaxed/simple;
	bh=+6Z+kdA8mx8gD6p28j/5jFlh3XNbpoiq73AY1J4CM7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bg833GBGvWMt3PE2TbKY1iGBZTWYwffYmTJwPLH6fdJJu/xENmOBy+n8a6Bz22quUfHvIEiFOL3tTUWDiXqQKVIgtmJHhhSbL05z2AVW7ffd1smeBxABcZGGeP4lLY1Mud9Wjr5t7Hr2VZsNRWLrQYzgWVNMUnFbVrl+6jshllc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJndRksY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68ED01F000E9;
	Sat, 23 May 2026 01:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779500112;
	bh=PAKrKck5Ixl7bQHAijAhhVv3mJp7q8krGMUuSu3O494=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lJndRksY8Rd2HZh1lJgN64h7h4SCuW5ZTbyK0i+erzNMWlFkCj2a6DXCzXeZV+TTm
	 aYwJlv9AoS9qH3EL/5p20SFIc/1f1hZ1HcW4+VQCFah3VlUkFeWPBOe+Hb9K1pMIvn
	 ZMtppdkmyz7mHs9mJdxKyskah9SrSE/u7AK91aLKXGwZCbVIf8uroeAlQ6/otGDEh9
	 Tr03cO8A8+f9zIG7AK5NXuEn3n6dif1TsdIvoSSSqYxQE6bNuRSFPzMSOh1rDOnMaq
	 tLH/6qMqtSyj3rA+OTSZDNBS5ClszovRIoHxBYv7xh8llHrQCXzEk8CPI7FAK2SO9l
	 /1bZLPZ9nBF7Q==
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
	linux-kernel@vger.kernel.org,
	namiltd@yahoo.com
Subject: Re: [net-next PATCH v5 7/8] net: dsa: realtek: rtl8365mb: add FDB support
Date: Fri, 22 May 2026 18:35:10 -0700
Message-ID: <20260523013510.1831298-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519-realtek_forward-v5-7-cb9f702c1782@gmail.com>
References: <20260519-realtek_forward-v5-7-cb9f702c1782@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291002-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org,yahoo.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 981825BC576
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: realtek: rtl8365mb: add FDB support

This patch implements FDB and MDB management for the RTL8365MB switch
family, adds an l2_lock mutex to serialize L2 table access, and wires
up port_fdb_*, port_mdb_*, and port_fast_age DSA ops. It also sets the
assisted_learning_on_cpu_port and fdb_isolation switch flags.

A few questions inline below.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_l2.c b/drivers/net/dsa/realtek/rtl8365mb_l2.c
> new file mode 100644
> index 000000000000..6d99fb59d3c8
> --- /dev/null
> +++ b/drivers/net/dsa/realtek/rtl8365mb_l2.c

[ ... ]

> +int rtl8365mb_l2_add_uc(struct realtek_priv *priv, int port,
> +			const unsigned char mac_addr[static ETH_ALEN],
> +			u16 efid, u16 vid)
> +{
> +	u16 data[RTL8365MB_L2_ENTRY_SIZE] = { 0 };
> +	struct rtl8365mb_l2_uc uc = { 0 };
> +	u16 addr;
> +	int ret;
> +
> +	memcpy(uc.key.mac_addr, mac_addr, ETH_ALEN);
> +	uc.key.efid = efid;
> +	uc.key.fid = 0;
> +	uc.key.ivl = true;
> +	uc.key.vid = vid;
> +
> +	uc.port = port;
> +	/* do not let HW decrease age */
> +	uc.is_static = true;
> +	/* age greater than 0 adds/updates entries */
> +	uc.age = 1;
> +	rtl8365mb_l2_uc_to_data(&uc, data);
> +
> +	/* add the new entry or update an existing one */
> +	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
> +				    RTL8365MB_TABLE_OP_WRITE, &addr,
> +				    0, 0,
> +				    data, RTL8365MB_L2_ENTRY_SIZE);
> +	/* addr will hold the table index, but it is not used here */
> +	if (ret == -ENOENT) {
> +		/* -ENOENT means the just added entry was not found (and @addr
> +		 * does not hold the table index. Although any error will be
> +		 * treated equally by the caller, assume that the missing entry
> +		 * means the table is full (tested in real HW).
> +		 */
> +		return -ENOSPC;
> +	}
> +	return ret;
> +}

[Low]
Is the -ENOENT check here ever reached for an OP_WRITE?

Looking at rtl8365mb_table_query() in rtl8365mb_table.c, the L2 status
handling explicitly maps a miss for OP_WRITE to -ENOSPC and only returns
-ENOENT for reads:

	if (!hit) {
		if (op == RTL8365MB_TABLE_OP_WRITE)
			ret = -ENOSPC;
		else
			ret = -ENOENT;
		goto out;
	}

If that mapping is the contract, the conditional and the comment
("-ENOENT means the just added entry was not found") look like dead
code. Would it be clearer to either drop the check entirely, or rewrite
it as if (ret == -ENOSPC) so the intent matches the table layer?

[ ... ]

> +int rtl8365mb_l2_flush(struct realtek_priv *priv, int port, u16 vid)
> +{
> +	int mode = vid ? RTL8365MB_L2_FLUSH_CTRL2_MODE_PORT_VID :
> +			 RTL8365MB_L2_FLUSH_CTRL2_MODE_PORT;
> +	u32 val, mask;
> +	int ret;
[ ... ]
> +	if (port < 8) {
> +		val = FIELD_PREP(RTL8365MB_L2_FLUSH_PORT_MSK_MSK,
> +				 BIT(port) & 0xFF);
> +		ret = regmap_write(priv->map_nolock,
> +				   RTL8365MB_L2_FLUSH_PORT_REG, val);
> +		if (ret)
> +			goto out;
> +
> +		mask = FIELD_PREP(RTL8365MB_L2_FLUSH_PORT_BUSY_MSK,
> +				  BIT(port) & 0xFF);
> +		ret = regmap_read_poll_timeout(priv->map_nolock,
> +					       RTL8365MB_L2_FLUSH_PORT_REG,
> +					       val, !(val & mask), 10, 100);
> +		if (ret)
> +			goto out;
> +	} else {
> +		val = FIELD_PREP(RTL8365MB_L2_FLUSH_PORT_EXT_MSK_MSK,
> +				 BIT(port) >> 8);
> +		ret = regmap_write(priv->map_nolock,
> +				   RTL8365MB_L2_FLUSH_PORT_EXT_REG, val);
> +		if (ret)
> +			goto out;
> +
> +		mask = FIELD_PREP(RTL8365MB_L2_FLUSH_PORT_EXT_BUSY_MSK,
> +				  BIT(port) >> 8);
> +		ret = regmap_read_poll_timeout(priv->map_nolock,
> +					       RTL8365MB_L2_FLUSH_PORT_EXT_REG,
> +					       val, !(val & mask), 10, 100);
> +		if (ret)
> +			goto out;
> +	}

[Medium]
Is the 100us timeout on regmap_read_poll_timeout() long enough for a
port flush to complete?

The arguments are sleep_us=10, timeout_us=100, giving roughly 100us
total to walk a LUT that, per RTL8365MB_LEARN_LIMIT_MAX, holds up to
2112 entries. The same driver's rtl8365mb_table_poll_busy() uses 10000
(10 ms) for L2 table operations.

If the hardware has not finished within 100us, the function returns
-ETIMEDOUT and rtl83xx_port_fast_age() only logs the error and
continues, leaving dynamic entries that an STP transition expected to
be flushed. Was 100us intentional, or should this match the 10 ms used
elsewhere in the driver?

[ ... ]

> +int rtl8365mb_l2_add_mc(struct realtek_priv *priv, int port,
> +			const unsigned char mac_addr[static ETH_ALEN],
> +			u16 vid)
> +{
> +	u16 data[RTL8365MB_L2_ENTRY_SIZE] = { 0 };
> +	struct rtl8365mb_l2_mc mc = { 0 };
> +	u16 addr;
> +	int ret;
> +
> +	memcpy(mc.key.mac_addr, mac_addr, ETH_ALEN);
> +	mc.key.vid = vid;
> +	mc.key.ivl = true;
> +	/* Already set the port and is_static, although not used in OP_READ,
> +	 * data will be ready for OP_WRITE if it is a new entry.
> +	 */
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
> +		dev_dbg(priv->dev, "l2_add_mc: found existing addr=%d member=0x%x igmpidx=0x%x static=%d\n",
> +			addr, mc.member, mc.igmpidx, mc.is_static);
> +		/* the port must be added as a member */
> +		mc.member |= BIT(port);
> +		rtl8365mb_l2_mc_to_data(&mc, data);

[Medium]
Can this path silently demote a bridge mdb entry to non-static?

When a matching entry already exists, rtl8365mb_l2_data_to_mc() parses
every field from hardware into mc, including is_static:

	mc->is_static = FIELD_GET(RTL8365MB_L2_MC_D5_STATIC_MSK, data[5]);

After that, only mc.member is updated before the OP_WRITE. If the
existing hardware entry has is_static = 0 (for instance, an entry left
behind by l2_del_mc that did not reclaim the slot, or an entry created
by IGMP snooping), the rewritten entry stays non-static, so the
hardware can age it out even though the bridge requested a static MDB
entry.

Would it make sense to force mc.is_static = 1 (and also clear the
non-key fields you do not want to inherit) before the OP_WRITE on the
hit path?

> +	} else if (ret == -ENOENT) {
[ ... ]
> +	} else {
> +		return ret;
> +	}
> +
> +	/* add the new entry or update an existing one */
> +	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
> +				    RTL8365MB_TABLE_OP_WRITE, &addr,
> +				    0, 0,
> +				    data, RTL8365MB_L2_ENTRY_SIZE);
> +	/* addr will hold the table index, but it is not used here */
> +	if (ret == -ENOENT) {
> +		/* -ENOENT means the just added entry was not found (and @addr
> +		 * does not hold the table index. Although any error will be
> +		 * treated equally by the caller, assume that the missing entry
> +		 * means the table is full (tested in real HW).
> +		 */
> +		return -ENOSPC;
> +	}
> +
> +	return ret;
> +}

[Low]
Same question as in rtl8365mb_l2_add_uc(): the table layer already maps
an OP_WRITE miss to -ENOSPC, so the -ENOENT branch and its comment
appear to be dead code here too. Would if (ret == -ENOSPC) better match
the contract of rtl8365mb_table_query()?

> +int rtl8365mb_l2_del_mc(struct realtek_priv *priv, int port,
> +			const unsigned char mac_addr[static ETH_ALEN],
> +			u16 vid)
> +{
[ ... ]
> +	rtl8365mb_l2_data_to_mc(data, &mc);
> +	dev_dbg(priv->dev, "l2_del_mc: found existing addr=%d member=0x%x igmpidx=0x%x static=%d\n",
> +		addr, mc.member, mc.igmpidx, mc.is_static);
> +	/* the port must be removed as a member */
> +	mc.member &= ~BIT(port);
> +	if (!mc.member) {
> +		/* With no members, zero all non-key fields to delete the
> +		 * entry. However, setting is_static = 0 might be enough to
> +		 * signal the HW to release the slot.
> +		 */
> +		mc.is_static = 0;
> +		mc.igmpidx = 0;
> +		mc.priority = 0;
> +		mc.fwd_pri = 0;
> +		mc.igmp_asic = 0;
> +	}
> +	rtl8365mb_l2_mc_to_data(&mc, data);
> +
> +	/* update the existing entry. */
> +	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
> +				    RTL8365MB_TABLE_OP_WRITE, &addr,
> +				    0, 0,
> +				    data, RTL8365MB_L2_ENTRY_SIZE);
> +	return ret;
> +}

[Medium]
Does this path actually reclaim the L2 slot when the last member is
removed?

The unicast delete in rtl8365mb_l2_del_uc() uses age = 0, which the
in-tree comment describes as the documented delete signal. The
multicast path here only zeros is_static and the other non-key fields,
and the comment itself notes uncertainty:

	/* With no members, zero all non-key fields to delete the
	 * entry. However, setting is_static = 0 might be enough to
	 * signal the HW to release the slot.
	 */

If the hardware does not auto-reclaim a row when is_static becomes 0
with an empty member mask, the LUT (RTL8365MB_LEARN_LIMIT_MAX = 2112)
will accumulate dead rows for previously used MAC+VID multicast keys
and eventually fail subsequent adds with -ENOSPC.

Has this been confirmed against the vendor documentation, and is there
a more explicit delete primitive analogous to age = 0 for the multicast
case?

