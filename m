Return-Path: <netdev+bounces-290968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPD7IB3yEGp7fwYAu9opvQ
	(envelope-from <netdev+bounces-290968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:17:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E10435BBB99
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45DE4300D860
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDF6823DD;
	Sat, 23 May 2026 00:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/WG9zmD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F98E883F
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495370; cv=none; b=db41rytEorLSXqm/jcNFGCrjiZeqYkF4vXv6WjtesPArpBJ6Mvhy2wLolc893fHjxe5CIbrG9Zg+83LNsmdhtzle2O1sjk+7PEgWbKQnCWiVee86lNjIbzbdew/PUL61BObtnMKGtcHSOnUaCF2/oohCCYG/aYxvb/2ojk2sUAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495370; c=relaxed/simple;
	bh=pqANEDQq6zDCS4CgMqK+OjNETcQPXePEXauzPxRjM7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBqlkX6VZ/+G2Y8W5UouD1DXnfMth5Fu+RABqsvIahfeQUQ5kYZ8PlFZxVksc6mz9ig6jwzMBnKrUu46LXEq+pkRsdl98bPZvJ4RBNqdFeWvciAlEHwz1B7i4KzHCP4U8ZCzlYJ5sMat7yK5QKnph9oz6TK9nC/CAl3dG05L6Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/WG9zmD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB641F000E9;
	Sat, 23 May 2026 00:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779495368;
	bh=QAchjD30N80ZHHDySttwPLfyZnIFsWgmlxS4j0SO9PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O/WG9zmDBY5TCGlTXkmI2ImA+1Fl9D9Tv02cN36wbfEEiUiBMn6jc+W2/W3ocetf5
	 vP1ZXoiipeVJzqAnryhVOrrWATQe9lcw1cnXe1u3euk0l0p61YO9n1oU8vMZ9wPpo6
	 UpruCybCMLBEsnUII2TIuWPAfDLR7914583LNL/3/vxsRhqoczU5PGOtz/VB47Mz+Y
	 gJrvw1pnmuNammVs9brCCGhG8RJRyXCan/mANb5WFcGGgSHP8aSFSJMNqMTWY9N5UK
	 tPyNYRV1ujamHUFT4x3n16rbRLCQ2zKaXmNvLcX1gEgcS26u0HEFiFvwXfk+RvbRsq
	 uxbOCKL2CMKNQ==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	vinschen@redhat.com,
	alexander.nowlin@intel.com
Subject: Re: [PATCH net 8/8] ixgbe: only access vfinfo and mv_list under RCU lock
Date: Fri, 22 May 2026 17:16:05 -0700
Message-ID: <20260523001605.1757032-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520183501.3360810-9-anthony.l.nguyen@intel.com>
References: <20260520183501.3360810-9-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290968-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E10435BBB99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ixgbe: only access vfinfo and mv_list under RCU lock

This change drops the vfs_lock spinlock in favour of RCU protection
for adapter->vfinfo and adapter->mv_list, marking them __rcu and
converting readers to rcu_dereference()/rcu_read_lock() and writers
to rcu_replace_pointer()/kfree_rcu(). The goal is to address a
crash observed when ixgbe_disable_sriov() races with
ixgbe_service_task() / ixgbe_msg_task() readers.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> index 9b8217523fd2..8849b9f42bf6 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> @@ -808,10 +810,10 @@ struct ixgbe_adapter {
>  	/* SR-IOV */
>  	DECLARE_BITMAP(active_vfs, IXGBE_MAX_VF_FUNCTIONS);
>  	unsigned int num_vfs;
> -	struct vf_data_storage *vfinfo;
> +	struct vf_data_storage __rcu *vfinfo;
>  	int vf_rate_link_speed;
>  	struct vf_macvlans vf_mvs;
> -	struct vf_macvlans *mv_list;
> +	struct vf_macvlans __rcu *mv_list;

[Medium]
After this conversion, is ixgbe_handle_mdd_event() in
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c still consistent
with the new annotations? It contains:

    if (adapter->vfinfo && ixgbe_check_mdd_event(adapter)) {

That bare load of an __rcu pointer is not wrapped in
rcu_read_lock() and does not use rcu_access_pointer() or
rcu_dereference(), so sparse will flag it and the access
bypasses the RCU discipline used elsewhere in the file. The
commit message says RCU is used "throughout the driver" — was
this site simply missed during the conversion?

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 2646ee6f295f..d82c7dfc6580 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

[ ... ]

> @@ -8267,22 +8293,27 @@ static void ixgbe_watchdog_flush_tx(struct ixgbe_adapter *adapter)
> @@ -8309,9 +8340,15 @@ static void ixgbe_check_for_bad_vf(struct ixgbe_adapter *adapter)
>  
>  	/* check status reg for all VFs owned by this PF */
>  	for (vf = 0; vf < adapter->num_vfs; ++vf) {
> -		struct pci_dev *vfdev = adapter->vfinfo[vf].vfdev;
> +		struct vf_data_storage *vfinfo;
> +		struct pci_dev *vfdev = NULL;
>  		u16 status_reg;
>  
> +		rcu_read_lock();
> +		vfinfo = rcu_dereference(adapter->vfinfo);
> +		if (vfinfo)
> +			vfdev = vfinfo[vf].vfdev;
> +		rcu_read_unlock();
>  		if (!vfdev)
>  			continue;
>  		pci_read_config_word(vfdev, PCI_STATUS, &status_reg);

[High]
Can vfdev still be used safely after rcu_read_unlock() here?

The RCU section only protects the lifetime of the vfinfo array,
not the lifetime of the pci_dev whose pointer was stored in it.
ixgbe_disable_sriov() drops the reference taken by
ixgbe_get_vfs() with pci_dev_put(vfdev) and then proceeds to
pci_disable_sriov(), either of which can free the pci_dev
concurrently with the subsequent pci_read_config_word() and the
pcie_flr(vfdev) reached through ixgbe_bad_vf_abort().

Should this path take pci_dev_get(vfdev) before dropping the
rcu_read_unlock(), and pci_dev_put() after the config-space
access and FLR are complete?

This appears to predate this patch (the prior code dereferenced
vfdev outside any lifetime-extending section as well), but the
RCU conversion seems like a natural opportunity to address it.

[ ... ]

> @@ -10071,20 +10114,26 @@ static int handle_redirect_action(struct ixgbe_adapter *adapter, int ifindex,
>  {
>  	struct ixgbe_ring_feature *vmdq = &adapter->ring_feature[RING_F_VMDQ];
>  	unsigned int num_vfs = adapter->num_vfs, vf;
> +	struct vf_data_storage *vfinfo;
>  	struct netdev_nested_priv priv;
>  	struct upper_walk_data data;
>  	struct net_device *upper;
>  
>  	/* redirect to a SRIOV VF */
> -	for (vf = 0; vf < num_vfs; ++vf) {
> -		upper = pci_get_drvdata(adapter->vfinfo[vf].vfdev);
> -		if (upper->ifindex == ifindex) {
> -			*queue = vf * __ALIGN_MASK(1, ~vmdq->mask);
> -			*action = vf + 1;
> -			*action <<= ETHTOOL_RX_FLOW_SPEC_RING_VF_OFF;
> -			return 0;
> +	rcu_read_lock();
> +	vfinfo = rcu_dereference(adapter->vfinfo);
> +	if (vfinfo)
> +		for (vf = 0; vf < num_vfs; ++vf) {
> +			upper = pci_get_drvdata(vfinfo[vf].vfdev);

[High]
Can the captured num_vfs and the freshly-dereferenced vfinfo
disagree in size here?

num_vfs is sampled from adapter->num_vfs before rcu_read_lock(),
while vfinfo is observed inside the RCU section. ixgbe_disable_sriov()
runs under PCI device_lock (not rtnl), sets adapter->num_vfs = 0,
and rcu_replace_pointer()s vfinfo. A subsequent
__ixgbe_enable_sriov(N2) can publish a smaller vfinfo array of
size N2 < num_vfs before the loop runs. The access vfinfo[vf]
for vf >= N2 is then a heap out-of-bounds read.

Should num_vfs be sampled inside the rcu_read_lock() and bounded
by the actual size of the published vfinfo, or should
adapter->num_vfs be updated as part of the same rcu_assign_pointer
publication so readers can rely on a consistent pair?

[ ... ]

> @@ -9744,15 +9781,21 @@ static int ixgbe_ndo_get_vf_stats(struct net_device *netdev, int vf,
>  				  struct ifla_vf_stats *vf_stats)
>  {
>  	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
> +	struct vf_data_storage *vfinfo;
>  
>  	if (vf < 0 || vf >= adapter->num_vfs)
>  		return -EINVAL;
>  
> -	vf_stats->rx_packets = adapter->vfinfo[vf].vfstats.gprc;
> -	vf_stats->rx_bytes   = adapter->vfinfo[vf].vfstats.gorc;
> -	vf_stats->tx_packets = adapter->vfinfo[vf].vfstats.gptc;
> -	vf_stats->tx_bytes   = adapter->vfinfo[vf].vfstats.gotc;
> -	vf_stats->multicast  = adapter->vfinfo[vf].vfstats.mprc;
> +	rcu_read_lock();
> +	vfinfo = rcu_dereference(adapter->vfinfo);
> +	if (vfinfo) {
> +		vf_stats->rx_packets = vfinfo[vf].vfstats.gprc;
> +		vf_stats->rx_bytes   = vfinfo[vf].vfstats.gorc;
> +		vf_stats->tx_packets = vfinfo[vf].vfstats.gptc;
> +		vf_stats->tx_bytes   = vfinfo[vf].vfstats.gotc;
> +		vf_stats->multicast  = vfinfo[vf].vfstats.mprc;
> +	}
> +	rcu_read_unlock();

[High]
This pattern recurs in many of the rtnl ndo handlers (set_vf_mac,
set_vf_spoofchk, set_vf_rss_query_en, set_vf_trust, set_vf_vlan,
set_vf_bw, get_vf_config, get_vf_stats): the bound check

    if (vf >= adapter->num_vfs)
        return -EINVAL;

is performed before rcu_read_lock(). Between that check and the
later rcu_dereference, ixgbe_disable_sriov() (under PCI device_lock,
not rtnl) can set num_vfs = 0 and __ixgbe_enable_sriov() can
republish vfinfo at a smaller size N2.

For ixgbe_ndo_get_vf_config() the resulting OOB read is then
memcpy'd into struct ifla_vf_info and returned to userspace via
netlink, which would expose adjacent kernel heap. For the setter
ndos and the mailbox-driven setters, this is an out-of-bounds
write.

Should the vf range check be repeated against the size of the
freshly observed vfinfo, ideally with num_vfs and vfinfo
published together so the pair is self-consistent?

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> index 431d77da15a5..80f22a8e7af4 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c

[ ... ]

> @@ -206,31 +214,28 @@ int ixgbe_disable_sriov(struct ixgbe_adapter *adapter)
>  {
>  	unsigned int num_vfs = adapter->num_vfs, vf;
>  	struct ixgbe_hw *hw = &adapter->hw;
> -	unsigned long flags;
> +	struct vf_data_storage *vfinfo;
> +	struct vf_macvlans *mv_list;
>  	int rss;
>  
> -	spin_lock_irqsave(&adapter->vfs_lock, flags);
> -	/* set num VFs to 0 to prevent access to vfinfo */
> +	/* set num VFs to 0 so readers bail out early */
>  	adapter->num_vfs = 0;
> -	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
> +
> +	vfinfo = rcu_replace_pointer(adapter->vfinfo, NULL, 1);
> +	mv_list = rcu_replace_pointer(adapter->mv_list, NULL, 1);

[Low]
The lockdep predicate passed to rcu_replace_pointer() is the
literal 1, which makes the writer-side assertion always succeed
and provides no verification. The patch simultaneously removes
vfs_lock and shifts to an implicit (undocumented) reliance on
some caller serialization for the writer.

Could lockdep_is_held() of the actual writer-side lock (for
example the PCI device_lock or rtnl_lock, whichever is intended)
be used here so a future regression that calls
ixgbe_disable_sriov() outside that context is caught by lockdep?

[ ... ]

> @@ -643,10 +668,16 @@ static void ixgbe_clear_vf_vlans(struct ixgbe_adapter *adapter, u32 vf)
>  static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
>  				int vf, int index, unsigned char *mac_addr)
>  {
> -	struct vf_macvlans *entry;
> +	struct vf_macvlans *mv_list, *entry;
>  	bool found = false;
>  	int retval = 0;
>  
> +	lockdep_assert_in_rcu_read_lock();
> +	/* vf_mvs entries point into the mv_list array */
> +	mv_list = rcu_dereference(adapter->mv_list);
> +	if (!mv_list)
> +		return 0;
> +
>  	if (index <= 1) {
>  		list_for_each_entry(entry, &adapter->vf_mvs.l, l) {

[High]
Is non-RCU list iteration safe here while only rcu_read_lock()
is held?

The list head &adapter->vf_mvs.l is mutated by the writer side
without RCU-aware primitives. ixgbe_alloc_vf_macvlans() does:

    INIT_LIST_HEAD(&adapter->vf_mvs.l);
    ...
    list_add(&mv_list[i].l, &adapter->vf_mvs.l);

and ixgbe_disable_sriov() kfree_rcu()s mv_list but never
reinitialises &adapter->vf_mvs.l, so on a subsequent
re-enable the writer concurrently zeros and re-links the head
while a reader walks it.

Should list_for_each_entry() be list_for_each_entry_rcu(), and
the writer use INIT_LIST_HEAD_RCU() / list_add_rcu()? Otherwise
the reader can observe torn next/prev loads or follow into
freed/re-used entries.

[ ... ]

> @@ -780,16 +816,25 @@ static void ixgbe_vf_clear_mbx(struct ixgbe_adapter *adapter, u32 vf)
>  static int ixgbe_set_vf_mac(struct ixgbe_adapter *adapter,
>  			    int vf, unsigned char *mac_addr)
>  {
> +	struct vf_data_storage *vfinfo;
>  	int retval;
>  
> -	ixgbe_del_mac_filter(adapter, adapter->vfinfo[vf].vf_mac_addresses, vf);
> +	rcu_read_lock();
> +	vfinfo = rcu_dereference(adapter->vfinfo);
> +	if (!vfinfo) {
> +		rcu_read_unlock();
> +		return -EINVAL;
> +	}
> +
> +	ixgbe_del_mac_filter(adapter, vfinfo[vf].vf_mac_addresses, vf);
>  	retval = ixgbe_add_mac_filter(adapter, mac_addr, vf);
>  	if (retval >= 0)
> -		memcpy(adapter->vfinfo[vf].vf_mac_addresses, mac_addr,
> +		memcpy(vfinfo[vf].vf_mac_addresses, mac_addr,
>  		       ETH_ALEN);

[ ... ]

> @@ -1537,21 +1677,34 @@ void ixgbe_ping_all_vfs(struct ixgbe_adapter *adapter)
>  int ixgbe_ndo_set_vf_mac(struct net_device *netdev, int vf, u8 *mac)
>  {
>  	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
> +	struct vf_data_storage *vfinfo;
>  	int retval;
>  
>  	if (vf >= adapter->num_vfs)
>  		return -EINVAL;
>  
> +	rcu_read_lock();
> +	vfinfo = rcu_dereference(adapter->vfinfo);
> +	if (!vfinfo) {
> +		rcu_read_unlock();
> +		return 0;
> +	}
> +
>  	if (is_valid_ether_addr(mac)) {
>  		dev_info(&adapter->pdev->dev, "setting MAC %pM on VF %d\n",
>  			 mac, vf);
>  		dev_info(&adapter->pdev->dev, "Reload the VF driver to make this change effective.");
>  
>  		retval = ixgbe_set_vf_mac(adapter, vf, mac);
>  		if (retval >= 0) {
> -			adapter->vfinfo[vf].pf_set_mac = true;
> +			vfinfo[vf].pf_set_mac = true;

[High]
Can vfinfo here and the vfinfo observed inside ixgbe_set_vf_mac()
end up pointing at different objects?

ixgbe_ndo_set_vf_mac() captures vfinfo via its own rcu_dereference,
then calls ixgbe_set_vf_mac() which independently does:

    rcu_read_lock();
    vfinfo = rcu_dereference(adapter->vfinfo);
    ...
    memcpy(vfinfo[vf].vf_mac_addresses, mac_addr, ETH_ALEN);

Nesting rcu_read_lock() is fine, but each rcu_dereference()
observes whatever pointer is currently published. If
ixgbe_disable_sriov() followed by __ixgbe_enable_sriov() races
between the two dereferences, the inner copy lands in the new
array while the outer pf_set_mac = true write lands in the old
array. The two pieces of state then disagree, which seems to
break the "attempted to override administratively set MAC"
enforcement on subsequent VF mailbox messages. If the new
vfinfo is shorter than vf, the inner memcpy is also a heap
out-of-bounds write.

Should ixgbe_ndo_set_vf_mac() pass its already-captured vfinfo
into ixgbe_set_vf_mac() so both writes go to the same object,
or otherwise structure the call so a single rcu_dereference
covers all writes for one operation?

