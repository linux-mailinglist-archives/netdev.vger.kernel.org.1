Return-Path: <netdev+bounces-303577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ITVZC87oRGrW2woAu9opvQ
	(envelope-from <netdev+bounces-303577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:15:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDC86EBFF0
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:15:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=OKRGvegX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303577-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303577-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DDA930104A4
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9D6407570;
	Wed,  1 Jul 2026 10:15:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE796406820
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:15:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900920; cv=none; b=q/pTlWi0/m1sx5daGdQgWqL4ZlkDG2uh2CZa9G4ixbfse3NFGWDwjh1f5hzhAkxnGW9ZXBRPjyI5NjTvbm/UEDw9CwyToz7H39gXojrcgLQGvi6w73biJJTyc3fslEoQPJqi7DS/eClunh/YDXMArw2NjvW4HziRXrd+gSO96vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900920; c=relaxed/simple;
	bh=O/7Z68xV7tllGDDJJ2CeaYWUyrbroeooiuTHo4jVzcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9s+n4rZXpPBpHG4ungJRsNtSTlrxJEnGbG2IfuFeMpZ3HEVpKbtYnDCQq2M9yMbxhsgASFSMMVpw+Nbey25UV30aOGB1/XeIVanVHgbYZKPNsFENausXoLy/CowvhrjkUMOs7omjIqV/1AG4Z7IDV7DurqYaFePanBdyYgx4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKRGvegX; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782900918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ro5CohXgZOu47BCkyRpFGH3iMoYcFEBtZCEdjbkmWBQ=;
	b=OKRGvegXIRjIFwrrKLaUYFT1QxO/6PxRDQgBK+hth7LwHFXXwwdOy4255ZVBU+vNIsnipZ
	XK0a+daqF+TBU956+i75FD+/GodDd6HCyjd7n5/gCVTfliEjxpoM/Xz3o0HaERAjvfXIwX
	DzIHw/gdkWhfPcRw9ipXdnF7Of9DoKA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-JKbyFjJLOY2h27Plc0texQ-1; Wed,
 01 Jul 2026 06:15:14 -0400
X-MC-Unique: JKbyFjJLOY2h27Plc0texQ-1
X-Mimecast-MFC-AGG-ID: JKbyFjJLOY2h27Plc0texQ_1782900911
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A295196C409;
	Wed,  1 Jul 2026 10:15:08 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.44.32.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 661C83000C28;
	Wed,  1 Jul 2026 10:15:07 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C3A90A80BFE; Wed, 01 Jul 2026 12:15:04 +0200 (CEST)
Date: Wed, 1 Jul 2026 12:15:04 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	alexander.nowlin@intel.com, Corinna Vinschen <vinschen@redhat.com>
Subject: Re: [PATCH net 8/8] ixgbe: only access vfinfo and mv_list under RCU
 lock
Message-ID: <akToqN09okrqTA73@calimero.vinschen.de>
Mail-Followup-To: Jakub Kicinski <kuba@kernel.org>,
	anthony.l.nguyen@intel.com, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	alexander.nowlin@intel.com
References: <20260520183501.3360810-9-anthony.l.nguyen@intel.com>
 <20260523001605.1757032-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260523001605.1757032-1-kuba@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303577-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[vinschen@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:alexander.nowlin@intel.com,m:vinschen@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinschen@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8CDC86EBFF0

Hi Jakub, hi others,

sorry for the late reply, I was AFK for two months.

I scanned the review points and most of them raise important questions.

This mail is only to let you know that I started looking into them
and I will follow up with a new patch in the next few weeks.


Thanks,
Corinna


On May 22 17:16, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ixgbe: only access vfinfo and mv_list under RCU lock
> 
> This change drops the vfs_lock spinlock in favour of RCU protection
> for adapter->vfinfo and adapter->mv_list, marking them __rcu and
> converting readers to rcu_dereference()/rcu_read_lock() and writers
> to rcu_replace_pointer()/kfree_rcu(). The goal is to address a
> crash observed when ixgbe_disable_sriov() races with
> ixgbe_service_task() / ixgbe_msg_task() readers.
> 
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> > index 9b8217523fd2..8849b9f42bf6 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> > @@ -808,10 +810,10 @@ struct ixgbe_adapter {
> >  	/* SR-IOV */
> >  	DECLARE_BITMAP(active_vfs, IXGBE_MAX_VF_FUNCTIONS);
> >  	unsigned int num_vfs;
> > -	struct vf_data_storage *vfinfo;
> > +	struct vf_data_storage __rcu *vfinfo;
> >  	int vf_rate_link_speed;
> >  	struct vf_macvlans vf_mvs;
> > -	struct vf_macvlans *mv_list;
> > +	struct vf_macvlans __rcu *mv_list;
> 
> [Medium]
> After this conversion, is ixgbe_handle_mdd_event() in
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c still consistent
> with the new annotations? It contains:
> 
>     if (adapter->vfinfo && ixgbe_check_mdd_event(adapter)) {
> 
> That bare load of an __rcu pointer is not wrapped in
> rcu_read_lock() and does not use rcu_access_pointer() or
> rcu_dereference(), so sparse will flag it and the access
> bypasses the RCU discipline used elsewhere in the file. The
> commit message says RCU is used "throughout the driver" — was
> this site simply missed during the conversion?
> 
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > index 2646ee6f295f..d82c7dfc6580 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> 
> [ ... ]
> 
> > @@ -8267,22 +8293,27 @@ static void ixgbe_watchdog_flush_tx(struct ixgbe_adapter *adapter)
> > @@ -8309,9 +8340,15 @@ static void ixgbe_check_for_bad_vf(struct ixgbe_adapter *adapter)
> >  
> >  	/* check status reg for all VFs owned by this PF */
> >  	for (vf = 0; vf < adapter->num_vfs; ++vf) {
> > -		struct pci_dev *vfdev = adapter->vfinfo[vf].vfdev;
> > +		struct vf_data_storage *vfinfo;
> > +		struct pci_dev *vfdev = NULL;
> >  		u16 status_reg;
> >  
> > +		rcu_read_lock();
> > +		vfinfo = rcu_dereference(adapter->vfinfo);
> > +		if (vfinfo)
> > +			vfdev = vfinfo[vf].vfdev;
> > +		rcu_read_unlock();
> >  		if (!vfdev)
> >  			continue;
> >  		pci_read_config_word(vfdev, PCI_STATUS, &status_reg);
> 
> [High]
> Can vfdev still be used safely after rcu_read_unlock() here?
> 
> The RCU section only protects the lifetime of the vfinfo array,
> not the lifetime of the pci_dev whose pointer was stored in it.
> ixgbe_disable_sriov() drops the reference taken by
> ixgbe_get_vfs() with pci_dev_put(vfdev) and then proceeds to
> pci_disable_sriov(), either of which can free the pci_dev
> concurrently with the subsequent pci_read_config_word() and the
> pcie_flr(vfdev) reached through ixgbe_bad_vf_abort().
> 
> Should this path take pci_dev_get(vfdev) before dropping the
> rcu_read_unlock(), and pci_dev_put() after the config-space
> access and FLR are complete?
> 
> This appears to predate this patch (the prior code dereferenced
> vfdev outside any lifetime-extending section as well), but the
> RCU conversion seems like a natural opportunity to address it.
> 
> [ ... ]
> 
> > @@ -10071,20 +10114,26 @@ static int handle_redirect_action(struct ixgbe_adapter *adapter, int ifindex,
> >  {
> >  	struct ixgbe_ring_feature *vmdq = &adapter->ring_feature[RING_F_VMDQ];
> >  	unsigned int num_vfs = adapter->num_vfs, vf;
> > +	struct vf_data_storage *vfinfo;
> >  	struct netdev_nested_priv priv;
> >  	struct upper_walk_data data;
> >  	struct net_device *upper;
> >  
> >  	/* redirect to a SRIOV VF */
> > -	for (vf = 0; vf < num_vfs; ++vf) {
> > -		upper = pci_get_drvdata(adapter->vfinfo[vf].vfdev);
> > -		if (upper->ifindex == ifindex) {
> > -			*queue = vf * __ALIGN_MASK(1, ~vmdq->mask);
> > -			*action = vf + 1;
> > -			*action <<= ETHTOOL_RX_FLOW_SPEC_RING_VF_OFF;
> > -			return 0;
> > +	rcu_read_lock();
> > +	vfinfo = rcu_dereference(adapter->vfinfo);
> > +	if (vfinfo)
> > +		for (vf = 0; vf < num_vfs; ++vf) {
> > +			upper = pci_get_drvdata(vfinfo[vf].vfdev);
> 
> [High]
> Can the captured num_vfs and the freshly-dereferenced vfinfo
> disagree in size here?
> 
> num_vfs is sampled from adapter->num_vfs before rcu_read_lock(),
> while vfinfo is observed inside the RCU section. ixgbe_disable_sriov()
> runs under PCI device_lock (not rtnl), sets adapter->num_vfs = 0,
> and rcu_replace_pointer()s vfinfo. A subsequent
> __ixgbe_enable_sriov(N2) can publish a smaller vfinfo array of
> size N2 < num_vfs before the loop runs. The access vfinfo[vf]
> for vf >= N2 is then a heap out-of-bounds read.
> 
> Should num_vfs be sampled inside the rcu_read_lock() and bounded
> by the actual size of the published vfinfo, or should
> adapter->num_vfs be updated as part of the same rcu_assign_pointer
> publication so readers can rely on a consistent pair?
> 
> [ ... ]
> 
> > @@ -9744,15 +9781,21 @@ static int ixgbe_ndo_get_vf_stats(struct net_device *netdev, int vf,
> >  				  struct ifla_vf_stats *vf_stats)
> >  {
> >  	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
> > +	struct vf_data_storage *vfinfo;
> >  
> >  	if (vf < 0 || vf >= adapter->num_vfs)
> >  		return -EINVAL;
> >  
> > -	vf_stats->rx_packets = adapter->vfinfo[vf].vfstats.gprc;
> > -	vf_stats->rx_bytes   = adapter->vfinfo[vf].vfstats.gorc;
> > -	vf_stats->tx_packets = adapter->vfinfo[vf].vfstats.gptc;
> > -	vf_stats->tx_bytes   = adapter->vfinfo[vf].vfstats.gotc;
> > -	vf_stats->multicast  = adapter->vfinfo[vf].vfstats.mprc;
> > +	rcu_read_lock();
> > +	vfinfo = rcu_dereference(adapter->vfinfo);
> > +	if (vfinfo) {
> > +		vf_stats->rx_packets = vfinfo[vf].vfstats.gprc;
> > +		vf_stats->rx_bytes   = vfinfo[vf].vfstats.gorc;
> > +		vf_stats->tx_packets = vfinfo[vf].vfstats.gptc;
> > +		vf_stats->tx_bytes   = vfinfo[vf].vfstats.gotc;
> > +		vf_stats->multicast  = vfinfo[vf].vfstats.mprc;
> > +	}
> > +	rcu_read_unlock();
> 
> [High]
> This pattern recurs in many of the rtnl ndo handlers (set_vf_mac,
> set_vf_spoofchk, set_vf_rss_query_en, set_vf_trust, set_vf_vlan,
> set_vf_bw, get_vf_config, get_vf_stats): the bound check
> 
>     if (vf >= adapter->num_vfs)
>         return -EINVAL;
> 
> is performed before rcu_read_lock(). Between that check and the
> later rcu_dereference, ixgbe_disable_sriov() (under PCI device_lock,
> not rtnl) can set num_vfs = 0 and __ixgbe_enable_sriov() can
> republish vfinfo at a smaller size N2.
> 
> For ixgbe_ndo_get_vf_config() the resulting OOB read is then
> memcpy'd into struct ifla_vf_info and returned to userspace via
> netlink, which would expose adjacent kernel heap. For the setter
> ndos and the mailbox-driven setters, this is an out-of-bounds
> write.
> 
> Should the vf range check be repeated against the size of the
> freshly observed vfinfo, ideally with num_vfs and vfinfo
> published together so the pair is self-consistent?
> 
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > index 431d77da15a5..80f22a8e7af4 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> 
> [ ... ]
> 
> > @@ -206,31 +214,28 @@ int ixgbe_disable_sriov(struct ixgbe_adapter *adapter)
> >  {
> >  	unsigned int num_vfs = adapter->num_vfs, vf;
> >  	struct ixgbe_hw *hw = &adapter->hw;
> > -	unsigned long flags;
> > +	struct vf_data_storage *vfinfo;
> > +	struct vf_macvlans *mv_list;
> >  	int rss;
> >  
> > -	spin_lock_irqsave(&adapter->vfs_lock, flags);
> > -	/* set num VFs to 0 to prevent access to vfinfo */
> > +	/* set num VFs to 0 so readers bail out early */
> >  	adapter->num_vfs = 0;
> > -	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
> > +
> > +	vfinfo = rcu_replace_pointer(adapter->vfinfo, NULL, 1);
> > +	mv_list = rcu_replace_pointer(adapter->mv_list, NULL, 1);
> 
> [Low]
> The lockdep predicate passed to rcu_replace_pointer() is the
> literal 1, which makes the writer-side assertion always succeed
> and provides no verification. The patch simultaneously removes
> vfs_lock and shifts to an implicit (undocumented) reliance on
> some caller serialization for the writer.
> 
> Could lockdep_is_held() of the actual writer-side lock (for
> example the PCI device_lock or rtnl_lock, whichever is intended)
> be used here so a future regression that calls
> ixgbe_disable_sriov() outside that context is caught by lockdep?
> 
> [ ... ]
> 
> > @@ -643,10 +668,16 @@ static void ixgbe_clear_vf_vlans(struct ixgbe_adapter *adapter, u32 vf)
> >  static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
> >  				int vf, int index, unsigned char *mac_addr)
> >  {
> > -	struct vf_macvlans *entry;
> > +	struct vf_macvlans *mv_list, *entry;
> >  	bool found = false;
> >  	int retval = 0;
> >  
> > +	lockdep_assert_in_rcu_read_lock();
> > +	/* vf_mvs entries point into the mv_list array */
> > +	mv_list = rcu_dereference(adapter->mv_list);
> > +	if (!mv_list)
> > +		return 0;
> > +
> >  	if (index <= 1) {
> >  		list_for_each_entry(entry, &adapter->vf_mvs.l, l) {
> 
> [High]
> Is non-RCU list iteration safe here while only rcu_read_lock()
> is held?
> 
> The list head &adapter->vf_mvs.l is mutated by the writer side
> without RCU-aware primitives. ixgbe_alloc_vf_macvlans() does:
> 
>     INIT_LIST_HEAD(&adapter->vf_mvs.l);
>     ...
>     list_add(&mv_list[i].l, &adapter->vf_mvs.l);
> 
> and ixgbe_disable_sriov() kfree_rcu()s mv_list but never
> reinitialises &adapter->vf_mvs.l, so on a subsequent
> re-enable the writer concurrently zeros and re-links the head
> while a reader walks it.
> 
> Should list_for_each_entry() be list_for_each_entry_rcu(), and
> the writer use INIT_LIST_HEAD_RCU() / list_add_rcu()? Otherwise
> the reader can observe torn next/prev loads or follow into
> freed/re-used entries.
> 
> [ ... ]
> 
> > @@ -780,16 +816,25 @@ static void ixgbe_vf_clear_mbx(struct ixgbe_adapter *adapter, u32 vf)
> >  static int ixgbe_set_vf_mac(struct ixgbe_adapter *adapter,
> >  			    int vf, unsigned char *mac_addr)
> >  {
> > +	struct vf_data_storage *vfinfo;
> >  	int retval;
> >  
> > -	ixgbe_del_mac_filter(adapter, adapter->vfinfo[vf].vf_mac_addresses, vf);
> > +	rcu_read_lock();
> > +	vfinfo = rcu_dereference(adapter->vfinfo);
> > +	if (!vfinfo) {
> > +		rcu_read_unlock();
> > +		return -EINVAL;
> > +	}
> > +
> > +	ixgbe_del_mac_filter(adapter, vfinfo[vf].vf_mac_addresses, vf);
> >  	retval = ixgbe_add_mac_filter(adapter, mac_addr, vf);
> >  	if (retval >= 0)
> > -		memcpy(adapter->vfinfo[vf].vf_mac_addresses, mac_addr,
> > +		memcpy(vfinfo[vf].vf_mac_addresses, mac_addr,
> >  		       ETH_ALEN);
> 
> [ ... ]
> 
> > @@ -1537,21 +1677,34 @@ void ixgbe_ping_all_vfs(struct ixgbe_adapter *adapter)
> >  int ixgbe_ndo_set_vf_mac(struct net_device *netdev, int vf, u8 *mac)
> >  {
> >  	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
> > +	struct vf_data_storage *vfinfo;
> >  	int retval;
> >  
> >  	if (vf >= adapter->num_vfs)
> >  		return -EINVAL;
> >  
> > +	rcu_read_lock();
> > +	vfinfo = rcu_dereference(adapter->vfinfo);
> > +	if (!vfinfo) {
> > +		rcu_read_unlock();
> > +		return 0;
> > +	}
> > +
> >  	if (is_valid_ether_addr(mac)) {
> >  		dev_info(&adapter->pdev->dev, "setting MAC %pM on VF %d\n",
> >  			 mac, vf);
> >  		dev_info(&adapter->pdev->dev, "Reload the VF driver to make this change effective.");
> >  
> >  		retval = ixgbe_set_vf_mac(adapter, vf, mac);
> >  		if (retval >= 0) {
> > -			adapter->vfinfo[vf].pf_set_mac = true;
> > +			vfinfo[vf].pf_set_mac = true;
> 
> [High]
> Can vfinfo here and the vfinfo observed inside ixgbe_set_vf_mac()
> end up pointing at different objects?
> 
> ixgbe_ndo_set_vf_mac() captures vfinfo via its own rcu_dereference,
> then calls ixgbe_set_vf_mac() which independently does:
> 
>     rcu_read_lock();
>     vfinfo = rcu_dereference(adapter->vfinfo);
>     ...
>     memcpy(vfinfo[vf].vf_mac_addresses, mac_addr, ETH_ALEN);
> 
> Nesting rcu_read_lock() is fine, but each rcu_dereference()
> observes whatever pointer is currently published. If
> ixgbe_disable_sriov() followed by __ixgbe_enable_sriov() races
> between the two dereferences, the inner copy lands in the new
> array while the outer pf_set_mac = true write lands in the old
> array. The two pieces of state then disagree, which seems to
> break the "attempted to override administratively set MAC"
> enforcement on subsequent VF mailbox messages. If the new
> vfinfo is shorter than vf, the inner memcpy is also a heap
> out-of-bounds write.
> 
> Should ixgbe_ndo_set_vf_mac() pass its already-captured vfinfo
> into ixgbe_set_vf_mac() so both writes go to the same object,
> or otherwise structure the call so a single rcu_dereference
> covers all writes for one operation?


