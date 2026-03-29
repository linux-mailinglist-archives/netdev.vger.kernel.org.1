Return-Path: <netdev+bounces-273001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GtoGvKEyWndygUAu9opvQ
	(envelope-from <netdev+bounces-273001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:00:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B55353E36
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46F8430579C1
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0388387596;
	Sun, 29 Mar 2026 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h14tJnyb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B2A387353;
	Sun, 29 Mar 2026 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774814199; cv=none; b=mRsFHqIHFITwCIRcH+g3sQKRXadS7WaicYXzL2AlL6lGlTZfFOmKf27hhahFAm7z+sAD5HPamtYK9fRaO7mdrIs8upU0p1fxNogkqyJFl3FdAo3q4ogIZ7+/24Px4vNTV+B7UNNJ+3JC9MESGuqiQD4GCu7jidT2xhM+YBgIbXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774814199; c=relaxed/simple;
	bh=i4/P7pFEfR2+rqJMHJC+jawntlN2Aq6fboGP5XMGlB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BK0Vrr+/iXxy3RTvmBj/upD2c0S5MSYzP/crgP6M4YuaJzmfQElOGYBK+FqU2zYblI69/z1/tkC33P2vetFOa1QelCYLpgsvJMCvwpogB65ypAi8clPeBnlny7G4MEcPRIdsgON+Y0dYxf4A+t2P/PI3gL/NuiQzexRoNiTGC/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h14tJnyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E996C116C6;
	Sun, 29 Mar 2026 19:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774814197;
	bh=i4/P7pFEfR2+rqJMHJC+jawntlN2Aq6fboGP5XMGlB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h14tJnybuUa0fwOiiKcgUn2eKZojJTXWkkntQOAcvDEfJ/RZLQWZ0fl8K6c09nKUV
	 lZqNq2MdLmhjCBdoMMzlk8yu5U6PBH0f3iJKBUR46pxNYj5c6PGoc0B8IFlU8YaJP6
	 a5SQBlv36FpgrAwNo5kXq/MreYK3juuFSTsnBzJ9fpSXuOOwbkYwUh45ysbyDgw/N5
	 R797uZD9IK1TUBXppEd+KuLZTEcUDLCpqwvSPy2vnJzw3fy+FACFUsLCc9V7qORisd
	 HSpFT4Gb1Pr3lTjHfoZ8mnNo952FgpQSDa8Wk32ka9LwlYNBSLkRSl2yZLbYwTcogA
	 w0KCSZK/WepaQ==
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
Subject: Re: [PATCH net-next v2 7/9] net: dsa: lan9645x: add mac table integration
Date: Sun, 29 Mar 2026 12:56:35 -0700
Message-ID: <20260329195635.2789227-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324-dsa_lan9645x_switch_driver_base-v2-7-f7504e3b0681@microchip.com>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-7-f7504e3b0681@microchip.com>
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
	TAGGED_FROM(0.00)[bounces-273001-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: B7B55353E36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: lan9645x: add mac table integration

Add MAC table support, and dsa fdb callback integration. The mactable is
keyed on (vid,mac) and each bucket has 4 slots. A mac table entry typically
points to a PGID index, the first 9 of which represent a front port.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
> index 000000000000..6335714dca21
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
[ ... ]
> +int lan9645x_mact_entry_add(struct lan9645x *lan9645x, int pgid,
> +			    const unsigned char *mac, u16 vid)
> +{
> +	struct lan9645x_mact_entry *entry;
> +	int err;
> +
> +	mutex_lock(&lan9645x->mact_lock);
> +
> +	/* Users can not move (vid,mac) to a different port, without removing
> +	 * the original entry first. But we overwrite entry in HW, and update
> +	 * software pgid for good measure.
> +	 */
> +	entry = lan9645x_mact_entry_find(lan9645x, mac, vid);
> +	if (entry) {
> +		entry->common.pgid = pgid;
> +		goto mac_learn;
> +	}
> +
> +	entry = lan9645x_mact_entry_alloc(lan9645x, mac, vid, pgid,
> +					  ENTRYTYPE_LOCKED);
> +	if (!entry) {
> +		mutex_unlock(&lan9645x->mact_lock);
> +		return -ENOMEM;
> +	}
> +
> +	list_add_tail(&entry->list, &lan9645x->mac_entries);
> +
> +mac_learn:
> +	err = __lan9645x_mact_learn(lan9645x, pgid, mac, vid, ENTRYTYPE_LOCKED);
> +	if (err)
> +		lan9645x_mact_entry_dealloc(lan9645x, entry);

If a pre-existing entry is updated but the hardware learning command fails,
will this inadvertently delete the valid software entry and cause the hardware
and software tracking to become desynchronized?

> +
> +	mutex_unlock(&lan9645x->mact_lock);
> +	return err;
> +}
> +
> +int lan9645x_mact_entry_del(struct lan9645x *lan9645x, int pgid,
> +			    const unsigned char *mac, u16 vid)
> +{
> +	struct lan9645x_mact_entry *entry;
> +	int err;
> +
> +	mutex_lock(&lan9645x->mact_lock);
> +
> +	entry = lan9645x_mact_entry_find(lan9645x, mac, vid);
> +	if (!entry) {
> +		mutex_unlock(&lan9645x->mact_lock);
> +		return -ENOENT;
> +	}
> +
> +	WARN_ON(entry->common.pgid != pgid);
> +	lan9645x_mact_entry_dealloc(lan9645x, entry);
> +	err = __lan9645x_mact_forget(lan9645x, mac, vid, ENTRYTYPE_LOCKED);

Does this permanently remove the software entry even if the hardware
command to forget the entry fails?

> +
> +	mutex_unlock(&lan9645x->mact_lock);
> +	return err;
> +}
[ ... ]
> +void lan9645x_mac_deinit(struct lan9645x *lan9645x)
> +{
> +	mutex_destroy(&lan9645x->mact_lock);
> +}

Are the static MAC entries in the mac_entries list leaked here during driver
teardown, or are they freed elsewhere?

> +
> +int lan9645x_mact_dsa_dump(struct lan9645x *lan9645x, int port,
> +			   dsa_fdb_dump_cb_t *cb, void *data)
> +{
> +	struct lan9645x_mact_entry entry = {};
> +	u32 mach, macl, maca;
> +	int err = 0;
> +	u32 autoage;
[ ... ]
> +	while (1) {
> +		/* NOTE: we rely on mach, macl and type being set correctly in
> +		 * the registers from previous round, vis a vis the GET_NEXT
> +		 * semantics, so locking entire loop is important.
> +		 */
> +		lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_GET_NEXT) |
> +		       ANA_MACACCESS_ENTRYTYPE_SET(entry.common.type),
> +		       lan9645x, ANA_MACACCESS);
> +
> +		if (lan9645x_mac_wait_for_completion(lan9645x, &maca))
> +			break;

If the hardware completion times out, the loop breaks out and returns the
local err variable which is initialized to 0. Will this suppress the hardware
timeout error code and incorrectly report a successful dump?

> +
> +		if (ANA_MACACCESS_VALID_GET(maca) == 0)
> +			break;
> +
> +		mach = lan_rd(lan9645x, ANA_MACHDATA);
> +		macl = lan_rd(lan9645x, ANA_MACLDATA);
> +
> +		lan9645x_mact_parse(mach, macl, maca, &entry.common);
> +
> +		if (ANA_MACACCESS_DEST_IDX_GET(maca) == port &&
> +		    entry.common.type == ENTRYTYPE_NORMAL) {

Since static FDB entries are programmed with ENTRYTYPE_LOCKED, will this
condition exclude them from the FDB dump, preventing them from showing up
during bridge FDB queries?

> +			if (entry.common.key.vid > VLAN_MAX)
> +				entry.common.key.vid = 0;
> +
> +			err = cb(entry.common.key.mac, entry.common.key.vid,
> +				 false, data);
> +			if (err)
> +				break;
> +		}
> +	}
> +
> +	/* Remove aging filters and restore aging */
> +	lan_wr(0, lan9645x, ANA_ANAGEFIL);
> +	lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(ANA_AUTOAGE_AGE_PERIOD_GET(autoage)),
> +		ANA_AUTOAGE_AGE_PERIOD,
> +		lan9645x, ANA_AUTOAGE);

Does restoring the ANA_AUTOAGE register using the autoage value saved at the
start of the function race with other operations setting the aging time?

If the aging time is updated concurrently without taking mact_lock, its newly
configured aging period might be overwritten here.

> +
> +	mutex_unlock(&lan9645x->mact_lock);
> +
> +	return err;
> +}
> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> index 046c95a72242..32c0301030a4 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
[ ... ]
> +static int lan9645x_fdb_del(struct dsa_switch *ds, int port,
> +			    const unsigned char *addr, u16 vid,
> +			    struct dsa_db db)
> +{
> +	struct net_device *br = lan9645x_db2bridge(db);
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct lan9645x *lan9645x = ds->priv;
> +	int err;
> +
> +	if (IS_ERR(br))
> +		return PTR_ERR(br);
> +
> +	if (dsa_port_is_cpu(dp) && !br &&
> +	    dsa_fdb_present_in_other_db(ds, port, addr, vid, db))
> +		return 0;
> +
> +	if (!vid)
> +		vid = lan9645x_vlan_unaware_pvid(!!br);
> +
> +	if (dsa_port_is_cpu(dp))
> +		return lan9645x_mact_forget(lan9645x, addr, vid,
> +					    ENTRYTYPE_LOCKED);
> +
> +	err = lan9645x_mact_entry_del(lan9645x, port, addr, vid);
> +	if (err == -ENOENT) {
> +		dev_dbg(lan9645x->dev,
> +			"fdb not found port=%d addr=%pM vid=%u\n", port, addr,
> +			vid);
> +		return 0;
> +	}
> +
> +	return err;
> +}

Since lan9645x_mact_entry_del returns -ENOENT when a MAC address is not found
in the software tracking list, and the software list only contains statically
added entries, won't this intercept attempts to manually delete dynamically
learned MAC addresses and return success without actually removing them from
the hardware table?

