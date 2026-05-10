Return-Path: <netdev+bounces-286360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMlFB23CAGqJMQEAu9opvQ
	(envelope-from <netdev+bounces-286360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:37:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8497D50575D
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B7B2303D716
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C833B47DC;
	Sun, 10 May 2026 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vR3kLkvS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E023B47CD;
	Sun, 10 May 2026 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778434499; cv=none; b=sFmITqFYodUQHtMcTN+5rPyD0mgbPwm6EeCvERjbTPDm+CnfPeCaYnf6nk8GQtuV0CGKrmyLZXtTNewgrV9DeoB5tKtZSAFtE72YXOA4uqQRJHPsF0JVEB38rXiKibnE1GYeQcc4GexfdcKrA6SECDaxxiCuh4JymfMLaCf4kUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778434499; c=relaxed/simple;
	bh=ojbX5EnxnJGWHryZmttZfR2PBqoTL4+GJupVj3oGp60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1ya+lODnUl28coX3gmpzuVHKx0GWyPdorfx/RRMFh7la1LCumVGfL7LdKqVPxiIaFvfvOJ+yO5+cQXDKTlpgiDB1iVwOq7A5DRHeBQaYD+lSAieUj5Op9Bd0lt9Agw0/8CYN3BACjR9bJe+NBDBqpJRtFD76fxShbpv8NXRbU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vR3kLkvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B78C2BCB8;
	Sun, 10 May 2026 17:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778434498;
	bh=ojbX5EnxnJGWHryZmttZfR2PBqoTL4+GJupVj3oGp60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vR3kLkvSydqYB25kDHTg/54+k3aBNbhcVYGUic3fQTvLAGVHSNU3f7Y7jrSHCUFw/
	 ooRJvqbnAAmD3np2txGg3KxJm4d3CMJipmQRGHyb7WQqYIcrcWXxIdQnR14p6sfYEB
	 cwdAr5G40TpstTTER0RBl1fkn5MkKzBnNQc/O5FC2vQCPhiyePKG9vm7W1CNHeUh4o
	 cN/VayQvGsuW17LPkBO1gO0oBGWn7RB81t8yxeSeZSigEKIpiBnot9y2a8lxOUHsnu
	 pWdIREiIL8BFv8ZVsyJhmAmPrL/BMPDCSjGIWmadWkM3X2NtoAyfZfMz2woamw8mG6
	 Ol07GlZm9599Q==
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
Date: Sun, 10 May 2026 10:34:52 -0700
Message-ID: <20260510173456.3919886-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506-realtek_forward-v3-7-1d87c5f85a3b@gmail.com>
References: <20260506-realtek_forward-v3-7-1d87c5f85a3b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8497D50575D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286360-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: dsa: realtek: rtl8365mb: add FDB support

This patch adds unicast/multicast FDB offload to the rtl8365mb DSA driver,
introduces a new l2_lock mutex and realtek_ops entry points for L2 table
access, and wires up the DSA fdb/mdb/fast_age callbacks via shared
rtl83xx_port_* helpers.

A few questions below, inline with the diff.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_l2.c b/drivers/net/dsa/realtek/rtl8365mb_l2.c
> new file mode 100644
> index 000000000000..400e21dd4d03
> --- /dev/null
> +++ b/drivers/net/dsa/realtek/rtl8365mb_l2.c

[ ... ]

> +#define RTL8365MB_L2_FLUSH_CTRL2_REG		0x0A38
> +#define   RTL8365MB_L2_FLUSH_CTRL2_MODE_MASK	GENMASK(1, 0)
> +#define   RTL8365MB_L2_FLUSH_CTRL2_MODE_PORT	0
> +#define   RTL8365MB_L2_FLUSH_CTRL2_MODE_PORT_VID 1
> +#define   RTL8365MB_L2_FLUSH_CTRL2_MODE_PORT_FID 2
> +#define   RTL8365MB_L2_FLUSH_CTRL2_TYPE_MASK	GENMASK(2, 2)
> +#define   RTL8365MB_L2_FLUSH_CTRL2_TYPE_DYNAMIC	0
> +#define   RTL8365MB_L2_FLUSH_CTRL2_TYPE_BOTH	0

[Low]
Is RTL8365MB_L2_FLUSH_CTRL2_TYPE_BOTH correct here?  The TYPE field is
GENMASK(2, 2), a single bit, so it admits exactly two values: 0 and 1.
TYPE_DYNAMIC is 0 and TYPE_BOTH is also 0.  Should TYPE_BOTH be 1?  The
symbol is not used today (l2_flush hardcodes TYPE_DYNAMIC), but a future
user would silently program dynamic-only flushing.

[ ... ]

> +static void rtl8365mb_l2_data_to_mc(const u16 *data, struct rtl8365mb_l2_mc *mc)
> +{
[ ... ]
> +	mc->member = FIELD_GET(RTL8365MB_L2_MC_MBR_MASK, data[4]) |
> +		     (FIELD_GET(RTL8365MB_L2_MC_MBR_EXT1_MASK, data[3]) << 8) |
> +		     (FIELD_GET(RTL8365MB_L2_MC_MBR_EXT2_MASK, data[5]) << 8);
[ ... ]
> +}
> +
> +static void rtl8365mb_l2_mc_to_data(const struct rtl8365mb_l2_mc *mc, u16 *data)
> +{
[ ... ]
> +	data[3] |= FIELD_PREP(RTL8365MB_L2_MC_MBR_EXT1_MASK, mc->member >> 8);
> +	data[4] |= FIELD_PREP(RTL8365MB_L2_MC_MBR_MASK, mc->member);
[ ... ]
> +	data[5] |= FIELD_PREP(RTL8365MB_L2_MC_MBR_EXT2_MASK, mc->member >> 10);
> +}

[High]
Do the encode and decode paths for MBR_EXT2 agree?

In rtl8365mb_l2_mc_to_data() EXT2 is written from bit 10 of mc->member:

    data[5] |= FIELD_PREP(RTL8365MB_L2_MC_MBR_EXT2_MASK, mc->member >> 10);

In rtl8365mb_l2_data_to_mc() the same EXT2 field is read back into bit 8:

    mc->member = FIELD_GET(RTL8365MB_L2_MC_MBR_MASK, data[4]) |
                 (FIELD_GET(RTL8365MB_L2_MC_MBR_EXT1_MASK, data[3]) << 8) |
                 (FIELD_GET(RTL8365MB_L2_MC_MBR_EXT2_MASK, data[5]) << 8);

RTL8365MB_MAX_NUM_PORTS is 11 and l2_flush() has an explicit port >= 8
path, so port 10 is a real value.  If an MDB entry has port 10 in its
member mask, won't the following read-modify-write in
rtl8365mb_l2_add_mc()/rtl8365mb_l2_del_mc() lose membership of port 10
and spuriously add port 8?  Should both sides use a consistent shift
(either >> 10 / << 10, or >> 8 / << 8 for the matching bit)?

[ ... ]

> +int rtl8365mb_l2_del_mc(struct realtek_priv *priv, int port,
> +			const unsigned char mac_addr[static ETH_ALEN],
> +			u16 vid)
> +{
[ ... ]
> +	rtl8365mb_l2_data_to_mc(data, &mc);
> +	/* the port must be removed as a member */
> +	mc.member &= ~BIT(port);
> +	if (!mc.member) {
> +		/* With no members, zero all non-key fields to delete the
> +		 * entry. However is_static is everything else we wrote.
> +		 * (and probably all that is needed by the HW)
> +		 */
> +		mc.is_static = 0;
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
Does this actually remove the entry from the hardware when the last port
leaves the group?  The unicast path uses age=0 as the documented delete
signal; here the code writes the entry back with member=0 and
is_static=0 based on the comment "probably all that is needed by the HW".

If the HW keeps the slot occupied with the same {MAC, VID, IVL} key, will
the next add_mc() for the same group hit the OP_READ path and update in
place on a stale entry?  And can zero-member entries accumulate until the
table returns -ENOSPC under MDB churn?

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
[ ... ]
> @@ -2314,6 +2318,8 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
>  	if (ret)
>  		goto out_teardown_irq;
>  
> +	ds->assisted_learning_on_cpu_port = true;
> +	ds->fdb_isolation = true;
>  	/* The EFID is 3 bits, but EFID 0 is reserved for standalone ports */
>  	ds->max_num_bridges = FIELD_MAX(RTL8365MB_EFID_MASK);
>  	ds->configure_vlan_while_not_filtering = true;

[Low, Medium]
Could the commit message mention that this patch also unconditionally
turns on ds->assisted_learning_on_cpu_port?  The log describes FDB/MDB
offload and l2_lock, but the CPU-port auto-programming behavior change
is not called out.

Regarding ds->fdb_isolation = true: include/net/dsa.h documents that
this affects both .port_fdb_{add,del} and .port_mdb_{add,del}.  The
unicast path encodes db.bridge.num as EFID, but the MDB path
(rtl83xx_port_mdb_add/del -> rtl8365mb_l2_add_mc/del_mc) does not pass
db down, and rtl8365mb_l2_mc_to_data() has no EFID field — the MC key
is only {MAC, VID, IVL}.  If two bridges try to install the same
(MAC, VID) group, won't they collide on one HW slot with OR'd member
masks, breaking bridge-scoped MDB reference counting and conflict
detection?

> diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
[ ... ]
> +int rtl83xx_port_fdb_add(struct dsa_switch *ds, int port,
> +			 const unsigned char *addr, u16 vid,
> +			 struct dsa_db db)
> +{
> +	struct realtek_priv *priv = ds->priv;
> +	int efid;
> +	int ret;
> +
> +	if (!priv->ops->l2_add_uc)
> +		return -EOPNOTSUPP;
> +
> +	if (db.type != DSA_DB_PORT && db.type != DSA_DB_BRIDGE)
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * DSA_DB_BRIDGE ports use bridge number [1..N] as EFID, while
> +	 * DSA_DB_PORT use the default EFID (0), not used by any bridge.
> +	 */
> +	efid = db.type == DSA_DB_BRIDGE ? db.bridge.num : 0;

[Low]
When db.type is DSA_DB_PORT, every standalone port ends up sharing EFID
0, so the HW key collapses to {VID, MAC} across all standalone ports.
If DSA requests the same (MAC, VID) on two different standalone ports,
won't rtl8365mb_l2_add_uc() silently rebind the existing entry to the
last-added port (uc.port = port), without any collision detection?

[ ... ]

> +int rtl83xx_port_fdb_dump(struct dsa_switch *ds, int port,
> +			  dsa_fdb_dump_cb_t *cb, void *data)
> +{
> +	struct realtek_priv *priv = ds->priv;
> +	struct realtek_fdb_entry entry;
> +	u16 l2_table_size = priv->variant->l2_table_size;
> +	u16 start_addr, addr = 0;
> +	int ret = 0;
> +
> +	if (!priv->ops->l2_get_next_uc)
> +		return -EOPNOTSUPP;
> +	if (!l2_table_size) {
> +		dev_warn_once(priv->dev, "l2_table_size not defined\n");
> +		return -EOPNOTSUPP;
> +	}
> +
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

[Low]
Should this dev_dbg() happen before ret is checked?  entry is declared
on the stack without initialization, and rtl8365mb_l2_get_next_uc()
only writes to *entry on the success path.  On the very first iteration
when the walk returns -ENOENT (no FDB entries on this port), won't this
print uninitialized stack contents via %pM / entry.vid / entry.is_static
when dynamic debug is enabled?

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

[Medium]
Should cb's return value be checked and propagated here?
dsa_user_port_fdb_do_dump() returns -EMSGSIZE when the netlink skb is
full, and rtnl_fdb_dump() in net/core/rtnetlink.c relies on the driver
bubbling that up:

    err = ...->port_fdb_dump(...);
    if (err == -EMSGSIZE)
        break;

Other DSA drivers (mv88e6xxx, qca8k, mt7530, ksz9477, sja1105, ...)
stop immediately when cb returns non-zero.  As written, the loop keeps
calling cb() for every remaining HW entry, silently discarding
-EMSGSIZE, and terminates with 0 or -ENOENT.

> +
> +		addr++;
> +
> +		/* Avoid querying beyond the valid L2 table range. */
> +		if (addr > l2_table_size)
> +			break;

[Low]
Should this be addr >= l2_table_size?  With l2_table_size = 2112, valid
indices are 0..2111, so the current test allows one extra
l2_get_next_uc() call at addr = 2112.

> +	}
> +	mutex_unlock(&priv->l2_lock);
> +
> +	return ret;
> +}

[Low]
On a normal end-of-walk, l2_get_next_uc() returns -ENOENT (the HIT bit
cleared in rtl8365mb_table_query()) and the loop breaks with ret still
set to -ENOENT.  Shouldn't the successful-completion case return 0,
matching the convention used by other DSA drivers?  The kerneldoc above
also states -ENOENT is returned at end-of-walk, which seems to describe
the current (non-idiomatic) behavior rather than the intended one.

