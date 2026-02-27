Return-Path: <netdev+bounces-261718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBAiLL0VoWnoqAQAu9opvQ
	(envelope-from <netdev+bounces-261718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:55:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 110C31B26EE
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9535B30E14DD
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE5F33BBD4;
	Fri, 27 Feb 2026 03:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLOFEB20"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D66D33B962;
	Fri, 27 Feb 2026 03:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772164539; cv=none; b=GCbrA7pO3X93TIwNyrrrJcsjxpxzOI78iF5Fxgrz2zoxZh1WlJ0ZkIvuiTgVx0NQcPgDrYfwfnfIJJIImutga3N3yciEfufVmrUlTYBQ8RYX20lWugO/wQud1q1nh4BpbrH2hVAfiun0UomszlIFLH7q3mjiRBAb2vTffnK0cb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772164539; c=relaxed/simple;
	bh=vCJxghyfT798EInsE9LvMJSZ9J9gpFJ+AVfK86WiR1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITK2nIkiq1dSTT1mHzKAaKF9/I5lgQBClB0p7Rl9ojRFka6FCr08lzWywr4+K196PRfPhslM/xuc+4TJ4Af83GIWfzn5vF7YOkrnYE2v85121o9EQAIGlgfaU0jJlWWgHZ9o1ulFlqfTjH3vGav5c0PLd9XM7vNQn37LmzSNSDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLOFEB20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AA3C19421;
	Fri, 27 Feb 2026 03:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772164539;
	bh=vCJxghyfT798EInsE9LvMJSZ9J9gpFJ+AVfK86WiR1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oLOFEB20CcQfYtHS2Z0NLb3jh2DzxgriOVUZovDTKgpMyiEj0Sx1Tn+qTAHsUjR6I
	 tySv7g4I/UBu5gkIUQk0DPJoLj+0+s4o6IWzcPd6GKINfcqQJFWs7Nn8iTlSWr79Mz
	 kr3yFZFVxE5bzTkS1JMiyFql5AKVmbJjXFXG3Z9Antc1Y7BfmKdq8Qbb+m/1YHcs6y
	 esq/lrpzaKDvEPgR6AbARpb0DK4b6SflBPjDPhhxlPoT22pQ0NeQHIb/nAfp9ov4te
	 o+VQiVxA/QNYsGSOdiZAKMe7k2hvStpoqh3cRJ/wSFwJYvctPZIJOSpLdVZezPU4Oy
	 6JLWpj6sZKfAg==
From: Jakub Kicinski <kuba@kernel.org>
To: cedric.jehasse@luminex.be
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,v4] net: dsa: mv88e6xxx: Add partial support for TCAM entries
Date: Thu, 26 Feb 2026 19:55:37 -0800
Message-ID: <20260227035537.2630823-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225-net-next-mv88e6xxx-tcam-v4-1-117f600e41d7@luminex.be>
References: <20260225-net-next-mv88e6xxx-tcam-v4-1-117f600e41d7@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lunn.ch,gmail.com,google.com,davemloft.net,redhat.com,armlinux.org.uk];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261718-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 110C31B26EE
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: mv88e6xxx: Add partial support for TCAM entries

This patch adds partial Ternary Content Addressable Memory (TCAM)
support for the mv88e6390 and mv88e6393 family of switches. The
implementation introduces matching on IP addresses/protocol with the
ability to trap matched frames to the CPU.

> diff --git a/drivers/net/dsa/mv88e6xxx/tcam.c b/drivers/net/dsa/mv88e6xxx/tcam.c
> new file mode 100644
> index 000000000000..f56cc7e0c00f
> --- /dev/null
> +++ b/drivers/net/dsa/mv88e6xxx/tcam.c

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

If entry_add() fails after some entries have already been moved to new
hardware positions with their hw_idx updated, doesn't the function return
without rolling back those partial moves?

The software list would then have some entries pointing to their new
positions while the gap for the new entry is only partially created.
This could leave the TCAM in an inconsistent state for subsequent
operations.

Is there error handling to ensure the TCAM state remains consistent when
insertion partially succeeds?

[ ... ]

> diff --git a/drivers/net/dsa/mv88e6xxx/tcflower.c b/drivers/net/dsa/mv88e6xxx/tcflower.c
> new file mode 100644
> index 000000000000..05b289463834
> --- /dev/null
> +++ b/drivers/net/dsa/mv88e6xxx/tcflower.c
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Marvell 88E6xxx Switch flower support
> + *
> + * Copyright (c) 2026 Luminex Network Intelligence
> + */
> +
> +#include "chip.h"
> +#include "tcflower.h"
> +#include "tcam.h"
> +
> +#define MV88E6XXX_ETHTYPE_OFFSET 16
> +#define MV88E6XXX_IP_PROTO_OFFSET 27
> +#define MV88E6XXX_IPV4_SRC_OFFSET 30
> +#define MV88E6XXX_IPV4_DST_OFFSET 34
> +
> +static int mv88e6xx_flower_parse_key(struct mv88e6xxx_chip *chip,
> +				     struct netlink_ext_ack *extack,
> +				     struct flow_cls_offload *cls,
> +				     struct mv88e6xxx_tcam_key *key)
> +{
> +	struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
> +	struct flow_dissector *dissector = rule->match.dissector;
> +	u16 addr_type = 0;
> +
> +	if (dissector->used_keys &
> +	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
> +	      BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
> +	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
> +	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS))) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Unsupported keys used");
> +		return -EOPNOTSUPP;
> +	}

FLOW_DISSECTOR_KEY_IPV6_ADDRS is included in the allowed keys bitmask,
but there is no code below to parse IPv6 addresses into the TCAM key.

If a user creates a tc flower rule with IPv6 addresses, the rule passes
this validation check but the addresses are never programmed into the
TCAM. This would cause the hardware entry to match broader traffic than
intended.

Looking at the code further down:

> +	if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
> +		struct flow_match_ipv4_addrs match;
> +
> +		flow_rule_match_ipv4_addrs(cls->rule, &match);
> +		mv88e6xxx_tcam_match_set(key, MV88E6XXX_IPV4_SRC_OFFSET,
> +					 match.key->src,
> +					 match.mask->src);
> +		mv88e6xxx_tcam_match_set(key, MV88E6XXX_IPV4_DST_OFFSET,
> +					 match.key->dst,
> +					 match.mask->dst);
> +	} else {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Unsupported address type");
> +		return -EOPNOTSUPP;
> +	}

The check at line 68-72 rejects non-IPv4 address types, but the IPv6 key
is still in the allowed keys bitmask at line 30. This creates a confusing
situation where IPv6 is both 'allowed' and 'unsupported'.

Should FLOW_DISSECTOR_KEY_IPV6_ADDRS be removed from the allowed keys
until IPv6 parsing is implemented?
-- 
pw-bot: cr

