Return-Path: <netdev+bounces-306147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uag5HcxwT2oUgwIAu9opvQ
	(envelope-from <netdev+bounces-306147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:58:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 097A872F39F
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:58:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=LCTGvwdn;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306147-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306147-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7933E3066569
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A34403AE1;
	Thu,  9 Jul 2026 09:56:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D40405C3B
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:56:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590998; cv=none; b=PPPcEdROVRQIGiCO2RiymVzLZQGc5C7H+/H2XiGki27pr6NqOshNiy5kk0pr7nsuQ+JGxjI8iFOqcS8SGNMbpyvcZFwi+lNMAhHxbWWp6jpGHExmbU8pGNlpKeClL5IOTRzipWZnkGjmz2J9u6qAHDQrG2dDETGxxOV4adkQVyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590998; c=relaxed/simple;
	bh=rfqg0J2uyuRQEO0v7oNsbz9k7bQ9h2gGd/vVQrTiMYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9cIquk7mG5X/e0oyaALu7+lXZYEatHpO2dlWS7VEh8WQpZ5Ui3pvc27vFl4G4XAGyk7tdFwf6Gr65KbcR31l8fevHesPQM9BY1tz42W3i3XhJxWfjx7JGoL3XdH4hTSFVrI9dNTTcYabzWH0yU0dORFXiVNOCBwdG97r/+3Q6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LCTGvwdn; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783590995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+V8ynIrTb/cwkSxXq5I+xnIBPuFzwDshiHvu6B7KTw=;
	b=LCTGvwdngJwsAmOAdCXOR5CDmL5lsNRr922Qr6YOUO4J2GF0syX9fqvAu53i+PiAbZQAMv
	KJwkeIpficqGkfG/CO6jxqvibPFvtIpC9yTLEWqCeEPaZcwNIi8Qjw7fgIrBA4d7HPSYLE
	EUBiVJ9NtyqdpvsGAzeO/MqlDtamG+g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-QJzhCcKkNYCPyjt9GKl8vA-1; Thu,
 09 Jul 2026 05:56:32 -0400
X-MC-Unique: QJzhCcKkNYCPyjt9GKl8vA-1
X-Mimecast-MFC-AGG-ID: QJzhCcKkNYCPyjt9GKl8vA_1783590991
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A70718052D7;
	Thu,  9 Jul 2026 09:56:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6677B180059E;
	Thu,  9 Jul 2026 09:56:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sgoutham@marvell.com
Subject: Re: [PATCH v2 net-next 6/9] octeontx2-pf: register switch notifiers for eswitch offload
Date: Thu,  9 Jul 2026 11:56:25 +0200
Message-ID: <20260709095625.117367-1-pabeni@redhat.com>
In-Reply-To: <20260702045026.2914748-7-rkannoth@marvell.com>
References: <20260702045026.2914748-7-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306147-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 097A872F39F

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
octeontx2-pf: register switch notifiers for eswitch offload

This change registers switchdev, FIB, netevent, inetaddr, inet6addr,
and netdevice notifiers when devlink switch mode is enabled, adds
sw_nb_v4.c/sw_nb_v6.c for family-specific handlers, and extends
sw_nb.c with device filtering for Cavium ports behind bridges and
VLANs.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> index 257a2ae6a53e..e4c01ac87477 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> @@ -399,6 +400,9 @@ static void rvu_rep_get_stats64(struct net_device *dev,
>  
>  static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
>  {
> +#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
> +	struct net_device *netdev = priv->netdev;
> +#endif
>  	struct devlink_port_attrs attrs = {};
>  	struct esw_cfg_req *req;
>  
> @@ -414,6 +418,11 @@ static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
>  	memcpy(req->switch_id, attrs.switch_id.id, attrs.switch_id.id_len);
>  	otx2_sync_mbox_msg(&priv->mbox);
>  	mutex_unlock(&priv->mbox.lock);
> +
> +#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
> +	ena ? sw_nb_register(netdev) : sw_nb_unregister(netdev);
> +#endif
> +
>  	return 0;
>  }

[Medium]
Is the return value from sw_nb_register() and sw_nb_unregister()
intentionally discarded here?

sw_nb_register() has six register_*_notifier() calls and a full
err1..err5 unwind path, but the ternary drops any error and the caller
returns 0.  The mbox esw_cfg_req has already been committed to the AF
before this line runs, so on notifier registration failure the AF sees
switch mode enabled while the PF has no observation infrastructure,
and devlink still reports success.

[Medium]
The notifier_block instances (sw_nb_fdb, sw_nb_fib, sw_nb_netevent,
sw_nb_v4_inetaddr, sw_nb_v6_inetaddr, sw_nb_netdev) and sw_nb_pf_netdev
are file-scope singletons in sw_nb.c.  When devlink switch mode is
enabled on a second octeontx2 PF (multi-port CN10K parts have a devlink
instance per PF), sw_nb_register() re-registers the same static
notifier_block pointers.

For notifier chains that keep a single linked list of nodes, adding the
same node twice either fails with -EEXIST (silently, per the previous
comment) or corrupts the chain.  sw_nb_pf_netdev is also unconditionally
overwritten so any netdev_info/netdev_dbg(sw_nb_pf_netdev, ...) is
attributed to the wrong PF, and once the first PF's netdev is freed
the pointer becomes a use-after-free for any callback that still
dereferences it.

Should these notifier_blocks live in a per-PF structure instead?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
> index 2d14a0590c5d..fb183265a9aa 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c

[ ... ]

> +bool sw_nb_is_valid_dev(struct net_device *netdev)
> +{
> +	struct netdev_nested_priv priv;
> +	struct net_device *br;
> +	int cnt = 0;
> +
> +	priv.flags = true;
> +	priv.data = &cnt;
> +
> +	if (netif_is_bridge_master(netdev) || is_vlan_dev(netdev)) {
> +		/* sw_nb_is_valid_dev() is invoked in notifier callback context, so
> +		 * rtnl_lcok is already acquired
> +		 */
> +		netdev_walk_all_lower_dev(netdev, sw_nb_check_slaves, &priv);
> +		return priv.flags && !!*(int *)priv.data;
> +	}
> +
> +	if (netif_is_bridge_port(netdev)) {
> +		br = netdev_master_upper_dev_get_rcu(netdev);
> +		if (!br)
> +			return false;
> +
> +		netdev_walk_all_lower_dev(br, sw_nb_check_slaves, &priv);
> +		return priv.flags && !!*(int *)priv.data;
> +	}
> +
> +	return sw_nb_is_cavium_dev(netdev);
> +}

[High]
Is the assumption in the comment ("rtnl_lcok is already acquired")
correct for all callers?

sw_nb_is_valid_dev() is invoked from:

  sw_nb_net_event()      - netevent chain, atomic_notifier
  sw_nb_v4_fib_event()   - FIB chain, atomic_notifier
  sw_nb_v6_fib_event()   - FIB chain, atomic_notifier
  sw_nb_fdb_event()      - switchdev, atomic
  sw_nb_netdev_event()   - netdevice chain, rtnl-held

register_netevent_notifier() and register_fib_notifier() install into
atomic notifier chains (see net/core/netevent.c and
net/core/fib_notifier.c), so those callbacks are not guaranteed to run
with rtnl held.

netdev_walk_all_lower_dev() (the non-RCU variant) walks
dev->adj_list.lower without rcu_dereference, and
netdev_master_upper_dev_get_rcu() dereferences adj_list.upper without
an outer rcu_read_lock.  Concurrent adjacency changes under rtnl can
then race the walk.  Also, note the typo "rtnl_lcok" in the comment.

[ ... ]

> +static int sw_nb_netdev_event(struct notifier_block *unused,
> +			      unsigned long event, void *ptr)
> +{
[ ... ]
> +}
> +
> +static struct notifier_block sw_nb_netdev = {
> +	.notifier_call = sw_nb_netdev_event,
> +};
> +
> +int sw_nb_unregister(struct net_device *netdev)
> +{
[ ... ]
> +}
> +EXPORT_SYMBOL(sw_nb_unregister);
> +
> +int sw_nb_register(struct net_device *netdev)
> +{
[ ... ]
> +}
> +EXPORT_SYMBOL(sw_nb_register);

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
> new file mode 100644
> index 000000000000..947dafe586a0
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c

[ ... ]

> +int sw_nb_v4_inetaddr_event(struct notifier_block *nb,
> +			    unsigned long event, void *ptr)
> +{
> +	struct in_ifaddr *ifa = (struct in_ifaddr *)ptr;
> +	struct net_device *dev = ifa->ifa_dev->dev;
> +	struct net_device *lower, *pf_dev;
> +	struct netdev_hw_addr *dev_addr;
> +	struct fib_entry *entry;
> +	struct in_device *idev;
> +	struct list_head *iter;
> +	struct otx2_nic *pf;
> +
> +	if (event != NETDEV_CHANGE &&
> +	    event != NETDEV_UP &&
> +	    event != NETDEV_DOWN) {
> +		return NOTIFY_DONE;
> +	}
> +
> +	idev = __in_dev_get_rtnl(dev);
> +	if (!idev || !idev->ifa_list)
> +		return NOTIFY_DONE;
> +
> +	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
> +	entry->cmd = sw_nb_inetaddr_event_to_otx2_event(event, dev);

[High]
Can kcalloc() return NULL here?  The very next line dereferences entry
without a NULL check.  The same pattern is present in
sw_nb_net_v4_neigh_update(), sw_nb_v6_netdev_event(),
sw_nb_v6_inetaddr_event(), and sw_nb_net_v6_neigh_update().  Two other
handlers in this same patch (sw_nb_v4_netdev_event and
sw_nb_v4_fib_event) do have the NULL check.

These callbacks run from atomic notifier chains (netevent, inet6addr)
during frequent events such as ARP/ND updates and address changes,
which are triggerable by an unprivileged party sending traffic on the
interface.

[Medium]
For the bridge-master branch below:

> +	pf_dev = dev;
> +	if (netif_is_bridge_master(dev))  {
> +		entry->bridge = 1;
> +		netdev_for_each_lower_dev(dev, lower, iter) {
> +			pf_dev = lower;
> +			break;
> +		}
> +	} else if (is_vlan_dev(dev)) {
> +		entry->vlan_valid = 1;
> +		pf_dev = vlan_dev_real_dev(dev);
> +		entry->vlan_tag = vlan_dev_vlan_id(dev);
> +	}
> +
> +	pf = netdev_priv(pf_dev);
> +	entry->port_id = pf->pcifunc;

What happens when the bridge has zero slaves?  pf_dev stays equal to
the bridge netdev itself, and netdev_priv(bridge) returns
struct net_bridge, not struct otx2_nic.  Reading pcifunc off that
pointer produces an out-of-type read.

Unlike sw_nb_v4_fib_event() and sw_nb_net_v4_neigh_update(), this
handler is not gated by sw_nb_is_valid_dev(), so an empty bridge with
no ports still reaches this code.

[ ... ]

> +int sw_nb_v4_fib_event(struct notifier_block *nb,
> +		       unsigned long event, void *ptr)
> +{
[ ... ]
> +	entries = kcalloc(fi->fib_nhs, sizeof(*entries), GFP_ATOMIC);
> +	if (!entries)
> +		return NOTIFY_DONE;
> +
> +	haddr = kcalloc(fi->fib_nhs, sizeof(u32), GFP_ATOMIC);
> +	if (!haddr) {
> +		kfree(entries);
> +		return NOTIFY_DONE;
> +	}
[ ... ]
> +	cnt = iter - entries;
> +	if (!cnt)
> +		return NOTIFY_DONE;
> +
> +	netdev_dbg(pf_dev, "pf_dev is %s cnt=%d\n", pf_dev->name, cnt);
> +	kfree(entries);
> +
> +	if (!hcnt)
> +		return NOTIFY_DONE;
> +
> +	entries = kcalloc(hcnt, sizeof(*entries), GFP_ATOMIC);
> +	if (!entries)
> +		return NOTIFY_DONE;

[High]
Does this leak entries and haddr on the early-return paths?

The if (!cnt) return path returns before freeing entries or haddr.

The if (!hcnt) return path frees entries just above but then returns
without freeing haddr.

The second kcalloc failure path returns having freed only the first
entries allocation, leaving haddr allocated.

FIB events fire on every route change; a system where
sw_nb_is_valid_dev() rejects every nexthop will leak on every event.
This appears to be addressed in the follow-up commit
7f7c9aba2d92 ("octeontx2: offload host FIB updates to switch via AF
mailbox") which adds kfree() calls on each branch, but the leak is
present in this commit as-is.

[ ... ]

> +int sw_nb_net_v4_neigh_update(struct notifier_block *nb,
> +			      unsigned long event, void *ptr)
> +{
[ ... ]
> +	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
> +	entry->cmd = OTX2_NEIGH_UPDATE;
> +	entry->dst = (__force u32)htonl(*(u32 *)n->primary_key);
> +	entry->dst_len = n->tbl->key_len * 8;
> +	entry->mac_valid = 1;
> +	entry->nud_state = n->nud_state;
> +	neigh_ha_snapshot(entry->mac, n, n->dev);
> +	ether_addr_copy(entry->mac, n->ha);

[Medium]
Why does this call neigh_ha_snapshot() followed immediately by a
plain ether_addr_copy() on n->ha?

neigh_ha_snapshot() uses read_seqbegin/read_seqretry against
n->ha_lock precisely because n->ha updates from neigh_update() take
write_seqlock(&n->ha_lock) and are not atomic word-writes on all
architectures.  The subsequent ether_addr_copy() is an unsynchronized
read of the same field and overwrites the snapshot with a possibly
torn value.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
> new file mode 100644
> index 000000000000..cc908f565d24
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c

[ ... ]

> +int sw_nb_v6_netdev_event(struct notifier_block *unused,
> +			  unsigned long event, void *ptr)
> +{
[ ... ]
> +	i6dev = __in6_dev_get(dev);
> +
> +	rcu_read_lock();
> +	ifp = list_first_entry_or_null(&i6dev->addr_list,
> +				       struct inet6_ifaddr,  if_list);
> +	if (!ifp) {
> +		rcu_read_unlock();
> +		return NOTIFY_DONE;
> +	}
> +
> +	if (ipv6_addr_type(&ifp->addr) & IPV6_ADDR_LINKLOCAL) {
> +		rcu_read_unlock();
> +		return NOTIFY_DONE;
> +	}
> +
> +	pf = netdev_priv(dev);
> +
> +	entry = kcalloc(1, sizeof(*entry), GFP_KERNEL);
> +	entry->cmd = sw_nb_inetaddr_event_to_otx2_event(event, dev);

[High]
Is GFP_KERNEL safe under rcu_read_lock()?  GFP_KERNEL implies
__GFP_DIRECT_RECLAIM and may sleep, which is illegal inside an RCU
read-side critical section and will trip
"BUG: sleeping function called from invalid context" with
CONFIG_DEBUG_ATOMIC_SLEEP.

Would GFP_ATOMIC, or moving the allocation outside the
rcu_read_lock() region, be more appropriate?

[High]
Is there a missing NULL check on this kcalloc()?  The next statement
dereferences entry unconditionally.

[ ... ]

> +int sw_nb_v6_inetaddr_event(struct notifier_block *nb,
> +			    unsigned long event, void *ptr)
> +{
[ ... ]
> +	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
> +	entry->cmd = sw_nb_inetaddr_event_to_otx2_event(event, dev);

[High]
Same pattern as noted above - can this dereference NULL when kcalloc()
fails under memory pressure?

> +int sw_nb_net_v6_neigh_update(struct notifier_block *nb,
> +			      unsigned long event, void *ptr)
> +{
[ ... ]
> +	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
> +	entry->cmd = OTX2_NEIGH_UPDATE;

[High]
Same as above - is a NULL check missing before dereferencing entry?
-- 
This is an AI-generated review.


