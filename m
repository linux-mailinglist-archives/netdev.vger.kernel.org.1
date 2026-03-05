Return-Path: <netdev+bounces-264136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCpoFI/mqGk3ygAAu9opvQ
	(envelope-from <netdev+bounces-264136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:12:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE21F20A1E5
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E7723013888
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 02:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F7024DD17;
	Thu,  5 Mar 2026 02:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTZ9sFw2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B88241139;
	Thu,  5 Mar 2026 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772676748; cv=none; b=nF1To1+G7668VjAGGbl9TqO+uWtLTjPvQ0omyKEc6c9MwFRZE9nhjztz8brmDPmFNLSWBcH1OJMA5s1Ks4qy1ISoXqD27BukVaHsMtnHLriOLEdWaG8k+Cetzr0T9B5dJJMlkkLxZQi1v5Bfh0ruidck7bfy6Cu+oq57cFUoS0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772676748; c=relaxed/simple;
	bh=Bovj9hcX4wIqh0yIQhm+qC0+K9aexyCEzHE2mS7+hsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2rzEgwEQKh2gGjuyk5BnU54idcde/DYDYvIqG+Ktrq2C1yg2WaTqZN+qTggHG4I14zQ+eOfovsPJEYYDcuYK4HY5GuwIWaqfmGXi20QS1E834SewO0DaeGXWNvd8B2JG+40AY3CdjAOKCYtyQsAdTFgPSC6qRO7Cyk/28Dzeog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTZ9sFw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7624C4CEF7;
	Thu,  5 Mar 2026 02:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772676747;
	bh=Bovj9hcX4wIqh0yIQhm+qC0+K9aexyCEzHE2mS7+hsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XTZ9sFw2H/XS7sPqilbPcgOYj7pE/GP7aAC4Bq1IQFimJnZrOE1vprHlPAicWkp9B
	 gpOyhspfbvXcsICh+JLza6SlgJWIJrwRG8xgI29aKGouOo7Lrx38rF20o7wZUSlCAl
	 ujcgxTPwEbo4HIFxr7gSjoQ2OI6KlC9xUmv54kJyLO7VJFWPNfvM28Ezi8P+pr/jEr
	 KEMT1xAyGhwBFRElzXCVrJzwvA2dmnfAPF8jWnosWYSJ//IywVVckb7FH8bB8lKfwx
	 dLtskoxnLWW1KQHjTVWfQ3JzgKBA2ebKB4wGfeosvYe2iSZrJ2hmhdBVqp5hUC7g1X
	 iQGwsK2J6Neeg==
From: Jakub Kicinski <kuba@kernel.org>
To: cedric.jehasse@luminex.be
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	jhs@mojatatu.com,
	pabeni@redhat.com,
	edumazet@google.com,
	linux@armlinux.org.uk,
	jiri@resnulli.us,
	linux-kernel@vger.kernel.org,
	olteanv@gmail.com,
	horms@kernel.org,
	davem@davemloft.net
Subject: Re: [net-next,v5,2/2] net: dsa: mv88e6xxx: Add partial support for TCAM entries
Date: Wed,  4 Mar 2026 18:12:25 -0800
Message-ID: <20260305021225.3558319-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303-net-next-mv88e6xxx-tcam-v5-2-6f9129687276@luminex.be>
References: <20260303-net-next-mv88e6xxx-tcam-v5-2-6f9129687276@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BE21F20A1E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,vger.kernel.org,mojatatu.com,redhat.com,google.com,armlinux.org.uk,resnulli.us,gmail.com,davemloft.net];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264136-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: mv88e6xxx: Add partial support for TCAM entries

This patch adds partial Ternary Content Addressable Memory (TCAM) for
the mv88e6390 and mv88e6393 family of switches. TCAM entries allow the
switch to match the first 48 or 96 bytes of a frame and take actions on
matched frames. The patch introduces a subset of the available TCAM
functionality for matching on ip addresses/protocol and trapping to the
cpu.

> diff --git a/drivers/net/dsa/mv88e6xxx/Makefile b/drivers/net/dsa/mv88e6xxx/Makefile
> index dd961081d631..b0b08c6f159c 100644
> --- a/drivers/net/dsa/mv88e6xxx/Makefile
> +++ b/drivers/net/dsa/mv88e6xxx/Makefile
> @@ -21,6 +21,8 @@ mv88e6xxx-objs += serdes.o
>  mv88e6xxx-objs += smi.o
>  mv88e6xxx-objs += switchdev.o
>  mv88e6xxx-objs += trace.o
> +mv88e6xxx-objs += tcflower.o
> +mv88e6xxx-objs += tcam.o

[ ... ]

> diff --git a/drivers/net/dsa/mv88e6xxx/tcam.c b/drivers/net/dsa/mv88e6xxx/tcam.c
> new file mode 100644
> index 000000000000..f56cc7e0c00f
> --- /dev/null
> +++ b/drivers/net/dsa/mv88e6xxx/tcam.c
> @@ -0,0 +1,325 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Marvell 88E6xxx Switch TCAM support
> + *
> + * Copyright (c) 2026 Luminex Network Intelligence
> + */

[ ... ]

> +/* TCAM keys register 1 */
> +#define MV88E6XXX_TCAM_KEYS1			0x02
> +#define MV88E6XXX_TCAM_KEYS1_FT_MASK		0xC000
> +#define MV88E6XXX_TCAM_KEYS1_SPV_MASK		0x0007
> +
> +/* TCAM keys register 1 */
> +#define MV88E6XXX_TCAM_KEYS2			0x03

This isn't a bug, but there's a copy-paste error in the comment. The
comment says "/* TCAM keys register 1 */" but the define is KEYS2 for
register 0x03.

> +#define MV88E6XXX_TCAM_KEYS2_SPV_MASK		0x00ff

[ ... ]

> +/* insert tcam entry in ordered list and move existing entries if necessary */
> +static int mv88e6xxx_tcam_insert_entry(struct mv88e6xxx_chip *chip,
> +				       struct mv88e6xxx_tcam_entry *entry)
> +{
> +	struct mv88e6xxx_tcam_entry *elem;
> +	struct list_head *hpos;
> +	int err;
> +
> +	list_for_each_prev(hpos, &chip->tcam.entries) {
> +		u8 move_idx;
> +
> +		elem = list_entry(hpos, struct mv88e6xxx_tcam_entry, list);
> +		if (entry->prio >= elem->prio)
> +			break;
> +
> +		move_idx = elem->hw_idx + 1;
> +
> +		err = mv88e6xxx_tcam_flush_entry(chip, move_idx);
> +		if (err)
> +			return err;
> +
> +		err = chip->info->ops->tcam_ops->entry_add(chip, elem,
> +							   move_idx);
> +		if (err)
> +			return err;
> +
> +		elem->hw_idx = move_idx;
> +	}

Can hw_idx overflow when the TCAM is full? The hw_idx field in
struct mv88e6xxx_tcam_entry is u8, and the code computes move_idx as
elem->hw_idx + 1 without checking if it will wrap from 255 to 0.

When a user repeatedly adds tc filters beyond the hardware TCAM capacity
(typically 256 entries for mv88e6390/mv88e6393), the index could wrap and
cause mv88e6xxx_tcam_flush_entry() and entry_add() to overwrite existing
entries at index 0.

Looking at the add path, there's no entry count limit:

mv88e6xxx_cls_flower_add() in tcflower.c
  -> mv88e6xxx_tcam_entry_add() here in tcam.c
    -> mv88e6xxx_tcam_insert_entry()

The struct mv88e6xxx_info has no num_tcam_entries field, and no -ENOSPC
is returned when the table is full. This is reachable from userspace via
repeated 'tc filter add' commands.

> +
> +	if (list_is_head(hpos, &chip->tcam.entries)) {
> +		entry->hw_idx = 0;
> +	} else {
> +		elem = list_entry(hpos, struct mv88e6xxx_tcam_entry, list);
> +		entry->hw_idx = elem->hw_idx + 1;
> +	}
> +	list_add(&entry->list, hpos);
> +	return 0;
> +}

[ ... ]

> diff --git a/drivers/net/dsa/mv88e6xxx/tcflower.c b/drivers/net/dsa/mv88e6xxx/tcflower.c
> new file mode 100644
> index 000000000000..dcbfe0beb5cb
> --- /dev/null
> +++ b/drivers/net/dsa/mv88e6xxx/tcflower.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Marvell 88E6xxx Switch flower support
> + *
> + * Copyright (c) 2026 Luminex Network Intelligence
> + */

[ ... ]

> +int mv88e6xxx_cls_flower_del(struct dsa_switch *ds, int port,
> +			     struct flow_cls_offload *cls, bool ingress)
> +{
> +	struct mv88e6xxx_chip *chip = ds->priv;
> +	struct mv88e6xxx_tcam_entry *entry;
> +	int err = 0;
> +
> +	mv88e6xxx_reg_lock(chip);
> +	entry = mv88e6xxx_tcam_entry_find(chip, cls->cookie);
> +
> +	if (entry) {
> +		err = mv88e6xxx_tcam_entry_del(chip, entry);
> +		kfree(entry);
> +	}

Does this create a use-after-free when mv88e6xxx_tcam_entry_del() fails?

Looking at mv88e6xxx_tcam_entry_del() in tcam.c, it only calls
list_del(&entry->list) at the END of the function. If the initial
mv88e6xxx_tcam_flush_entry() call fails, the function returns early
WITHOUT removing the entry from chip->tcam.entries:

drivers/net/dsa/mv88e6xxx/tcam.c:mv88e6xxx_tcam_entry_del() {
	...
	err = mv88e6xxx_tcam_flush_entry(chip, entry->hw_idx);
	if (err)
		return err;  // early return without list_del

	/* move entries that come after the deleted entry forward */
	list_for_each_entry_continue(elem, &chip->tcam.entries, list) {
		...
	}

	list_del(&entry->list);
	return err;
}

The caller then unconditionally calls kfree(entry), leaving a dangling
pointer in the linked list. Any subsequent traversal of chip->tcam.entries
(e.g., via mv88e6xxx_tcam_entry_find or mv88e6xxx_tcam_insert_entry) will
dereference freed memory.

The fix should either not kfree the entry when mv88e6xxx_tcam_entry_del
fails, or ensure mv88e6xxx_tcam_entry_del always calls list_del before
returning, even on error.

> +	mv88e6xxx_reg_unlock(chip);
> +	return  err;
> +}
-- 
pw-bot: cr

