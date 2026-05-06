Return-Path: <netdev+bounces-284818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELcQIw44+2nUXwMAu9opvQ
	(envelope-from <netdev+bounces-284818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:46:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F8E4DA708
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B229C3083691
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 12:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F96244105E;
	Wed,  6 May 2026 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuQpGZ29"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2F230C62D
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071236; cv=none; b=VCN6ucO6/92sBnIEjHVK7Xl3p6KEtV5aWYfsY4e8UyPBUVTAiWBiiMUfOHEx5crRnY+IjX8Uz8YkhWQsF607gISmF87LGrD8Amm7/FHC27JmSyCKx7GhbQivnJDQIZ1wxyK5FQYDomEbRyvbM0feRYZ1fK4BFRCI0Mt0Klog1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071236; c=relaxed/simple;
	bh=HPJqgvmSRfiKw78LZ5qA65mNKPFtkuVJT9wIyurZU5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hu+NWWoqg9tXfgb01mqjSRrmcRA8pTPmxaVIustygNs4bdcyH9eYZusvz3Kh38N9HP68gopgwMVgJlcn4RBJU9rBZkVfx9hl66gZXai+r0+ySfnapc+NNs5Zj9xfqi2jlzmPoVQLh2MCfc6UGFupveIeiOF6TbjFt3GgBUhmnzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuQpGZ29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0050EC2BCC4;
	Wed,  6 May 2026 12:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778071236;
	bh=HPJqgvmSRfiKw78LZ5qA65mNKPFtkuVJT9wIyurZU5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VuQpGZ29fQWmFDVFMgiCaABL86t7aTqBqCCXFaMk+SdkvuAEXkMUXBOhGGCYbhU1+
	 ok1/bu8AiUY05XqjEpJ1DaSzgqHCl3LLZ+QFVa6gHDDJEU/X2Y0dP9Hb/lIE1XPfhs
	 G0Smo7U3ED2Y3smvGNtTlbApLCtppX2XrpFdMuRzaGjSFL+YdKcVYl0Db5nKYQ6XL7
	 PY0oeEX9Qk3jKb61Rbth1CUyDx8pX5T9GKslFK1QR20OFvvIs5w92WXYX4QgdbatOw
	 nf99+8/tCVxVzVvKbuGYn2zoX2JZH9Ha4NdcRQLOvX0UcnyZvafXvO7chGVoGkxPEk
	 85ANHeZ0EnS2g==
From: Simon Horman <horms@kernel.org>
To: n05ec@lzu.edu.cn
Cc: 'Simon Horman' <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	wangjiexun2025@gmail.com
Subject: Re: [PATCH net 1/1] batman-adv: stop caching unowned originator pointers in BAT IV
Date: Wed,  6 May 2026 13:39:46 +0100
Message-ID: <20260506123952.671718-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <e12a51ee998808be6381780d6aaf32e093dc7d1e.1777692024.git.wangjiexun2025@gmail.com>
References: <e12a51ee998808be6381780d6aaf32e093dc7d1e.1777692024.git.wangjiexun2025@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 16F8E4DA708
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.open-mesh.org,vger.kernel.org,mailbox.org,simonwunderlich.de,mandelbit.com,narfation.org,davemloft.net,google.com,redhat.com,gmail.com,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284818-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,linux.dev:url]

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/

I do have concerns that this review needs to be addressed in
order for this patch to progress.

OTOH, there is another AI-generated review of this patch available at
https://sashiko.dev. In that case, I believe the review relates to
a pre-existing condition, and addressing that (or not) can be treated
as a follow-up.

---
batman-adv: stop caching unowned originator pointers in BAT IV

This patch removes the orig_node back-pointer cached inside each BAT IV
neigh_node and resolves the originator on demand via batadv_orig_hash_find()
from the stored neighbor address. Tagged Fixes: c6c8fea29769 and
Cc: stable@kernel.org.

> diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
> index f28e9cbf8ad5..168b413dd18b 100644
> --- a/net/batman-adv/bat_iv_ogm.c
> +++ b/net/batman-adv/bat_iv_ogm.c

[ ... ]

> @@ -1372,8 +1380,8 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
>  
>  	router = batadv_orig_router_get(orig_node, if_outgoing);
>  	if (router) {
> -		router_router = batadv_orig_router_get(router->orig_node,
> -						       if_outgoing);
> +		router_router = batadv_orig_to_router(bat_priv, router->addr,
> +						      if_outgoing);
>  		router_ifinfo = batadv_neigh_ifinfo_get(router, if_outgoing);
>  	}

Is this replacement semantically equivalent to the original call?

The previous code used batadv_orig_router_get() on the cached orig_node to
fetch router_router. The new code calls batadv_orig_to_router(), which
internally runs batadv_find_router():

    net/batman-adv/originator.c:batadv_orig_to_router() {
        orig_node = batadv_orig_hash_find(bat_priv, orig_addr);
        ...
        neigh_node = batadv_find_router(bat_priv, orig_node, if_outgoing);
        ...
    }

batadv_find_router() has a bonding path that is taken when
recv_if == BATADV_IF_DEFAULT and bonding is enabled:

    net/batman-adv/routing.c:batadv_find_router() {
        ...
        if (!(recv_if == BATADV_IF_DEFAULT &&
              atomic_read(&bat_priv->bonding)))
            return router;

        /* bonding: loop through the list of possible routers ... */
        ...
        if (next_candidate) {
            ...
            batadv_last_bonding_replace(orig_node, next_candidate);
        } else if (first_candidate) {
            ...
            batadv_last_bonding_replace(orig_node, first_candidate);
        } else {
            batadv_last_bonding_replace(orig_node, NULL);
        }
        ...
    }

batadv_iv_ogm_process() invokes batadv_iv_ogm_process_per_outif() once with
BATADV_IF_DEFAULT per received OGM:

    net/batman-adv/bat_iv_ogm.c:batadv_iv_ogm_process() {
        ...
        batadv_iv_ogm_process_per_outif(skb, ogm_offset, orig_node,
                                        if_incoming, BATADV_IF_DEFAULT);
        ...
    }

With bonding enabled, does every received OGM now rotate
orig_node->last_bonding_candidate on the last-hop neighbor's originator via
batadv_last_bonding_replace(), where previously that state was advanced only
from forwarding paths?

And can the bonding candidate selection return a different router_router than
batadv_orig_router_get() would have, which then feeds the subsequent
loop-avoidance check?

    if (router && router_router &&
        (batadv_compare_eth(router->addr, prev_sender)) &&
        !(batadv_compare_eth(ogm_packet->orig, prev_sender)) &&
        (batadv_compare_eth(router->addr, router_router->addr))) {
        ...
        goto out;
    }

The sister helper added by this same patch, batadv_iv_ogm_neigh_ifinfo_sum(),
uses batadv_orig_hash_find() followed by batadv_iv_orig_ifinfo_sum() rather
than batadv_orig_to_router():

> +static u8 batadv_iv_ogm_neigh_ifinfo_sum(struct batadv_priv *bat_priv,
> +					 const struct batadv_neigh_node *neigh_node)
> +{
> +	struct batadv_orig_node *orig_neigh;
> +	u8 sum;
> +
> +	orig_neigh = batadv_orig_hash_find(bat_priv, neigh_node->addr);
> +	if (!orig_neigh)
> +		return 0;
> +
> +	sum = batadv_iv_orig_ifinfo_sum(orig_neigh, neigh_node->if_incoming);
> +	batadv_orig_node_put(orig_neigh);
> +
> +	return sum;
> +}

Would a similar pattern work here, something like:

    orig = batadv_orig_hash_find(bat_priv, router->addr);
    router_router = batadv_orig_router_get(orig, if_outgoing);
    batadv_orig_node_put(orig);

so that the lookup avoids invoking the bonding candidate machinery from the
OGM processing path?

The commit message describes only removing an unowned cached originator
pointer and does not mention a routing or bonding behavior change. Is the
change in router_router resolution intentional, and if so could the commit
message call it out?

