Return-Path: <netdev+bounces-298278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qx3HI+/+Kmpw0wMAu9opvQ
	(envelope-from <netdev+bounces-298278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:31:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D06E674700
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:31:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SdWNcfsn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298278-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298278-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7242730065DD
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE76D359A6B;
	Thu, 11 Jun 2026 18:31:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723E54BCAA3
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:31:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781202667; cv=none; b=hCDFFOnumvN7CM7k5/BG27TLOg1dsDcxPkZa04JZHU9/5RPoWkxt8/Ex4EOQgXyO5qYac8DMlR9+UixMRp5FDJKAiShAk09R7YO9pnuqK9MVU10MdSpcA7eUaW1N5J3tObrN1I2MN0kUGVvyO6RpGplb1u0Lxr54wcTTwtDAZa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781202667; c=relaxed/simple;
	bh=58vXmtF2lzicipP5LlQaKmvZlFOwA3slT+9W/ZQY1MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDrMhTKXaYy7uCiYoXT1eeAxm/+u6tpKpqBDiprMdXL4zv3V34jBKEdg2O3eXRCQROHEleUJC0o4SB349bQ2l5Sva6JocYrzGdHRTTH6LWCx42xt45c+QHtglY7gETAtOtZM/O+DHH3vVrhxpWZn0NYvefSJqT3B3If8IP13tbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdWNcfsn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068321F000E9;
	Thu, 11 Jun 2026 18:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781202666;
	bh=cw+gvJeW4O+PbKWJ50KkCaa3nQqeDbxWg9+0qLwuF9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SdWNcfsngv6XQuFX+W/BqtYmhFwj9K3398RPQiJPP048CEftVZssbT9kNfQV8JTjs
	 FoxjjOGD0GyBQ4PfGx2n8S0Vh++R+WX3eEbR42lm/mt2/uxVIUcK7N2owrYn8na/PC
	 hn6iW6kqtxANtqi+5guuxsPwJ0pLWiUQlMinDc0KLS/sT3DfVhyXWNB0gbwGyRVmQW
	 Rw5PBsIAed0XnTHpJwg99lIGbyY6MnHK4c5f8NE8bIA/+L7tbeeelpxUINHcUv2Brw
	 vCJrnmShLMsdAs2Aq05i4Dk1sjKI/V39dV30mwJBErUhpKnDedOjC/GRpr5U/MFGq0
	 Gs7PCECpnTYWg==
From: Jakub Kicinski <kuba@kernel.org>
To: razor@blackwall.org,
	idosch@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 2/5] bridge: use atomic ops to read/change p->flags in br_netlink.c
Date: Thu, 11 Jun 2026 11:30:38 -0700
Message-ID: <20260611183037.1948556-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610161836.1275531-3-edumazet@google.com>
References: <20260610161836.1275531-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,google.com,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-298278-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:razor@blackwall.org,m:idosch@nvidia.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D06E674700

Ido, Nik, do we care about this?

---
bridge: use atomic ops to read/change p->flags in br_netlink.c

The change converts net/bridge/br_netlink.c reads of p->flags to
test_bit()/READ_ONCE() and rewrites br_setport() to compute a new
flags value in a local variable, then commit it with a cmpxchg()
retry loop.

> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 7cb24de9c77d..12850f60bfcb 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c

[ ... ]

> @@ -934,58 +934,64 @@ static int br_set_port_state(struct net_bridge_port *p, u8 state)
>  }
>  
>  /* Set/clear or port flags based on attribute */

[ ... ]

>  /* Process bridge protocol info on port */
>  static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
>  		      struct netlink_ext_ack *extack)
>  {
> -	unsigned long old_flags, changed_mask;
> +	unsigned long old_flags, flags, changed_mask;
>  	bool br_vlan_tunnel_old;
>  	int err;
>  
> -	old_flags = p->flags;
> +retry:
> +	flags = old_flags = READ_ONCE(p->flags);
>  	br_vlan_tunnel_old = (old_flags & BR_VLAN_TUNNEL) ? true : false;

[ ... ]

> +	if (!(flags & BR_PORT_MAB) && (old_flags & BR_PORT_MAB)) {
>  		struct net_bridge_fdb_flush_desc desc = {
>  			.flags = BIT(BR_FDB_LOCKED),
>  			.flags_mask = BIT(BR_FDB_LOCKED),
> @@ -995,15 +1001,16 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
>  		br_fdb_flush(p->br, &desc);
>  	}
>  
> -	changed_mask = old_flags ^ p->flags;
> +	changed_mask = old_flags ^ flags;
>  
> -	err = br_switchdev_set_port_flag(p, p->flags, changed_mask, extack);
> -	if (err) {
> -		p->flags = old_flags;
> +	err = br_switchdev_set_port_flag(p, flags, changed_mask, extack);
> +	if (err)
>  		return err;
> -	}
>  
> -	if (br_vlan_tunnel_old && !(p->flags & BR_VLAN_TUNNEL))
> +	if (cmpxchg(&p->flags, old_flags, flags) != old_flags)
> +		goto retry;
> +

[High]

Are the side effects in this loop safe to re-execute on a cmpxchg retry?

The retry path now wraps br_fdb_flush() and br_switchdev_set_port_flag()
inside the loop body:

	retry:
		flags = old_flags = READ_ONCE(p->flags);
		...
		if (!(flags & BR_PORT_MAB) && (old_flags & BR_PORT_MAB))
			br_fdb_flush(p->br, &desc);
		changed_mask = old_flags ^ flags;
		err = br_switchdev_set_port_flag(p, flags, changed_mask, extack);
		if (err)
			return err;
		if (cmpxchg(&p->flags, old_flags, flags) != old_flags)
			goto retry;
		...
		br_port_flags_change(p, changed_mask);

Can this retry actually be taken?  br_setport() runs under RTNL, but
several other writers modify p->flags without RTNL via set_bit() and
clear_bit(), for example BR_MRP_LOST_CONT_BIT and BR_MRP_LOST_IN_CONT_BIT
toggled from work-queue and softirq context in net/bridge/br_mrp_netlink.c
(br_mrp_ring_port_open() and br_mrp_in_port_open(), called from
br_mrp_test_work_expired() and br_mrp_mrm_process()).

Because cmpxchg compares the entire word, a concurrent set_bit() or
clear_bit() on any unrelated bit (such as the MRP bits above) makes the
cmpxchg fail and trigger goto retry.

When that happens, what is the effect on switchdev?

	err = br_switchdev_set_port_flag(p, flags, changed_mask, extack);

br_switchdev_set_port_flag() first calls call_switchdev_notifiers() with
SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS, then queues a SWITCHDEV_F_DEFER
attribute set for SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:

	attr.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS;
	attr.flags = SWITCHDEV_F_DEFER;
	err = switchdev_port_attr_set(p->dev, &attr, extack);

The deferred update from a first iteration is already queued and cannot
be cancelled when the retry loop queues a second one with a different
(val, mask) pair.  Drivers will see notifier callbacks for both
iterations.

For br_fdb_flush(), the BR_PORT_MAB transition

	if (!(flags & BR_PORT_MAB) && (old_flags & BR_PORT_MAB))
		br_fdb_flush(p->br, &desc);

can re-evaluate to true on a retry and flush FDB entries again.

Finally, br_port_flags_change() runs only once after the loop, with the
final iteration's changed_mask:

	br_port_flags_change(p, changed_mask);

If a bit such as BR_AUTO_MASK or BR_NEIGH_SUPPRESS was set in an
earlier iteration's changed_mask but not in the last one (because a
concurrent writer altered an unrelated bit between iterations), would
the switchdev driver have already been told about that transition while
the bridge software-side recompute in br_port_flags_change() is skipped?

The original code performed each of these side effects exactly once per
br_setport() call.  Should the side effects be moved outside the cmpxchg
loop so only the pure flags computation is retried?

>  	if (br_vlan_tunnel_old && !(flags & BR_VLAN_TUNNEL))
>  		nbp_vlan_tunnel_info_flush(p);
>  
>  	br_port_flags_change(p, changed_mask);
-- 
pw-bot: cr

