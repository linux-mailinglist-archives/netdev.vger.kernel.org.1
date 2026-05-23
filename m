Return-Path: <netdev+bounces-290975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKrQCfDxEGp7fwYAu9opvQ
	(envelope-from <netdev+bounces-290975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:16:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C51F05BBB8A
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C49C03006683
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C18613B7AE;
	Sat, 23 May 2026 00:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkQJ7vE2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF261A7264
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495405; cv=none; b=AKpCnL4cA7Hr08UnichgaBPlJ3OaomdsscZkOyrtw8sx00SL5kMWsV3cZpo+dLxmLNov/0QukH/3jsT/lX4q4QL9nhufBJX78JVG0DDnnExG+rkFGKE09g/PD5sFHJDydO6FejpIQPi+TSsEfqFXoE396bYixwjygZFUfptuHp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495405; c=relaxed/simple;
	bh=7xld6dKWRJ7RHnX+D7yLww0lZHyYEBuXHAFtZ1hSYIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwcCzcdRTkmGC0flevQ6rIc6DE5pExG+756GY2vVJ4Sr/9eOxmvMsQDxpOGRBNP0oKDjvUGFfBiNlP+iXBEyk1K8tSHpN2peKF/uN2kMaBq9QllMpyoeJNOPjs5EtHcA1V/V665qQVzQDvLS3RN98ElNzll+KBcKPO3IAXx+etk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkQJ7vE2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615E41F000E9;
	Sat, 23 May 2026 00:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779495403;
	bh=UPbF7rCHXS7gA8xsC32cNmwQBDN3MoGWzE3ExNZn7ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TkQJ7vE24wLj6fPWeV6Tv4Rr2V8m4+2ICA4WVNz0SkdUJ6xKfm0rCxQGIUuwoXgUM
	 tqkwaDVeX9ZkOc0/up2dm5Boaa5H6fgHTTV9NATnfPaiHaFgTJTFD8iRAltEdcacIA
	 XG7+HJivwoCW1y2Gtk/dWNp06XCrFZBpfkEaAvpHLdoGIJhxEPIBsNofd2LYU3TTcj
	 ngLW0adzOtUmNpqTzL56Nmioiv8ZtVa545oxP9EQbl5dI07427xxJjroaJ8B6tCKg6
	 GJeKqC0KPkZzOh3Jf1ONRrCPxo6EdBy77MEK81TrABtOFNnf8uSHaNawArl91ansdP
	 e5MQPNPmx3/sA==
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
Date: Fri, 22 May 2026 17:16:42 -0700
Message-ID: <20260523001642.1758535-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520183501.3360810-9-anthony.l.nguyen@intel.com>
References: <20260520183501.3360810-9-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290975-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C51F05BBB8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: ixgbe: only access vfinfo and mv_list under RCU lock

This patch drops the spinlock protecting the adapter info in favor of RCU to
avoid lock contention and crashes when setting sriov_numvfs to zero. It
modifies the accesses to vfinfo and mv_list across the driver to use RCU
primitives.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 2646ee6f295f0..d82c7dfc6580a 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
[ ... ]
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

[Severity: High]
Is it safe to dereference vfdev outside the RCU read-side critical
section? By dropping the RCU read lock before calling pci_read_config_word(),
the grace period can expire and a concurrent execution of
ixgbe_disable_sriov() could free the pci_dev object, resulting in a
use-after-free.

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

[Severity: High]
Does reading adapter->num_vfs outside the RCU lock create a time-of-check to
time-of-use (TOCTOU) race? If SR-IOV is disabled and rapidly re-enabled, a
reader can cache an older, larger num_vfs value before acquiring the RCU
lock, but then fetch the newer, smaller vfinfo array. Iterating up to the old
num_vfs would then cause an out-of-bounds memory access.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> index 431d77da15a5f..80f22a8e7af43 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
[ ... ]
> @@ -123,6 +125,7 @@ static int __ixgbe_enable_sriov(struct ixgbe_adapter *adapter,
>  static void ixgbe_get_vfs(struct ixgbe_adapter *adapter)
>  {
>  	struct pci_dev *pdev = adapter->pdev;
> +	struct vf_data_storage *vfinfo;
>  	u16 vendor = pdev->vendor;
>  	struct pci_dev *vfdev;
>  	int vf = 0;
> @@ -134,18 +137,23 @@ static void ixgbe_get_vfs(struct ixgbe_adapter *adapter)
>  		return;
>  	pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID, &vf_id);
>  
> -	vfdev = pci_get_device(vendor, vf_id, NULL);
> -	for (; vfdev; vfdev = pci_get_device(vendor, vf_id, vfdev)) {
> -		if (!vfdev->is_virtfn)
> -			continue;
> -		if (vfdev->physfn != pdev)
> -			continue;
> -		if (vf >= adapter->num_vfs)
> -			continue;
> -		pci_dev_get(vfdev);
> -		adapter->vfinfo[vf].vfdev = vfdev;
> -		++vf;
> +	rcu_read_lock();
> +	vfinfo = rcu_dereference(adapter->vfinfo);
> +	if (vfinfo) {
> +		vfdev = pci_get_device(vendor, vf_id, NULL);
> +		for (; vfdev; vfdev = pci_get_device(vendor, vf_id, vfdev)) {

[Severity: High]
Does this code call a sleeping function inside an RCU read-side critical
section? pci_get_device() internally acquires the pci_bus_sem read-write
semaphore, which can sleep. Sleeping inside an RCU read section will
trigger a 'scheduling while atomic' BUG.

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
>  
>  	/* put the reference to all of the vf devices */
>  	for (vf = 0; vf < num_vfs; ++vf) {
> -		struct pci_dev *vfdev = adapter->vfinfo[vf].vfdev;
> +		struct pci_dev *vfdev = vfinfo[vf].vfdev;
>  
>  		if (!vfdev)
>  			continue;
> -		adapter->vfinfo[vf].vfdev = NULL;
> +		vfinfo[vf].vfdev = NULL;
>  		pci_dev_put(vfdev);
>  	}

[Severity: High]
Can RCU readers observe these synchronous mutations before the grace
period ends? The vfinfo array is modified in-place and pci_dev_put() is
called on the devices synchronously. If the final reference is dropped,
the pci_dev could be freed while an RCU reader (like
handle_redirect_action()) is concurrently accessing it, leading to a
use-after-free.

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

[Severity: High]
Are standard list operations safe here under RCU? The adapter->vf_mvs.l
list is traversed using list_for_each_entry() under rcu_read_lock().
Concurrently, ixgbe_alloc_vf_macvlans() can re-initialize the list head
and add entries using list_add(). Without the appropriate RCU list
primitives, concurrent list modifications can cause data races and
corrupted pointers.

[ ... ]
> @@ -952,14 +1013,20 @@ static int ixgbe_set_vf_mac_addr(struct ixgbe_adapter *adapter,
>  				 u32 *msgbuf, u32 vf)
>  {
>  	u8 *new_mac = ((u8 *)(&msgbuf[1]));
> +	struct vf_data_storage *vfinfo;
>  
>  	if (!is_valid_ether_addr(new_mac)) {
>  		e_warn(drv, "VF %d attempted to set invalid mac\n", vf);
>  		return -1;
>  	}
>  
> -	if (adapter->vfinfo[vf].pf_set_mac && !adapter->vfinfo[vf].trusted &&
> -	    !ether_addr_equal(adapter->vfinfo[vf].vf_mac_addresses, new_mac)) {
> +	lockdep_assert_in_rcu_read_lock();
> +	vfinfo = rcu_dereference(adapter->vfinfo);
> +	if (!vfinfo)
> +		return 0;

[Severity: Medium]
Will this send false ACKs to the VF when vfinfo is NULL? The caller,
ixgbe_rcv_msg_from_vf(), interprets a return value of 0 as success and
sends an ACK (IXGBE_VT_MSGTYPE_ACK) to the VF. Returning 0 here means
the operation is silently ignored but acknowledged as successful. Could
this return an error like -EINVAL instead?

