Return-Path: <netdev+bounces-152872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ABC9F61E3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976171712E0
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539AC19C560;
	Wed, 18 Dec 2024 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdL8v795"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AF91993B2;
	Wed, 18 Dec 2024 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514438; cv=none; b=DB9ECyw8Xm+zTIDJr+BK7z4GW0bzI/8LHPzbUJq+FowZRnTX27/tA3boQ1vwLKRs7SVheoCf35pDJHZPPgcV6l65AaJva1BDjq8MtiwRiHimdA79n17rc+/FEj7we7t6BDml1MaPJODW5TTTWQUvd39r5NrKqfKTMc3INN2O6YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514438; c=relaxed/simple;
	bh=FBsSfZA/9GvyeGgfb3Gt8tda2g8YnCPK4uie1Qh7nvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xt+r7lcmQaGTLQ36WbctF99IdqxoyqOAggWvorwewMyEZX5519LUpiKvvCX6QvdB5hHY9j8gZ3Z9X05qCwdG6a07eYzrZ27JnDNcuHTUmhyfMOBPrHmIbiibi1bG9MpRyuPgisRTFOpPruEvFXUQTMa3ck8DLG2g51Ee3qzlg78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdL8v795; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734514437; x=1766050437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FBsSfZA/9GvyeGgfb3Gt8tda2g8YnCPK4uie1Qh7nvc=;
  b=fdL8v795SgN37RDf12TjlH+FFplubcVtolae2v5aa4X9hr0OrnpWcGBc
   X02UFUA8pNayaAroaHzABii5jF2OVXFriJqoIqSsxLf2eCgUyGlXv2JP4
   s7jKtxbAk33h9xvLew7AaDy7d3MUPJNhkun3fhhQptTdDyge5vr5bTVq+
   c/jXU1N3X9TGjUWRYuwIhms3+6Vs48AOhmCl7ZlKaAD8Rp0hSnUDBgotK
   ucca3Gk2EOmVny5OeD2O3iaycJqER3rbGnbmuYjDwxWaJKG/0dKKtJfXJ
   /P6pL6dWcgBm8MoT6Bpm1CSU8pyiCm4GF+9kDnQ7pkAWXHeif6/Gpi8Ja
   A==;
X-CSE-ConnectionGUID: p0yYNpQRTE+E0GeNOyouIw==
X-CSE-MsgGUID: DCd6G56fR7SrB6RSFrGJ9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="45674914"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="45674914"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 01:33:56 -0800
X-CSE-ConnectionGUID: xOYcHQrUSY+UHgdQBhlU3g==
X-CSE-MsgGUID: MKpW+cThS3igUDhici6a/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102807672"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 01:33:52 -0800
Date: Wed, 18 Dec 2024 10:30:46 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND V2 net 7/7] net: hns3: fix kernel crash when 1588
 is sent on HIP08 devices
Message-ID: <Z2KWRsAa7hkdUsWD@mev-dev.igk.intel.com>
References: <20241217010839.1742227-1-shaojijie@huawei.com>
 <20241217010839.1742227-8-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217010839.1742227-8-shaojijie@huawei.com>

On Tue, Dec 17, 2024 at 09:08:39AM +0800, Jijie Shao wrote:
> From: Jie Wang <wangjie125@huawei.com>
> 
> Currently, HIP08 devices does not register the ptp devices, so the
> hdev->ptp is NULL. But the tx process would still try to set hardware time
> stamp info with SKBTX_HW_TSTAMP flag and cause a kernel crash.
> 
> [  128.087798] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
> ...
> [  128.280251] pc : hclge_ptp_set_tx_info+0x2c/0x140 [hclge]
> [  128.286600] lr : hclge_ptp_set_tx_info+0x20/0x140 [hclge]
> [  128.292938] sp : ffff800059b93140
> [  128.297200] x29: ffff800059b93140 x28: 0000000000003280
> [  128.303455] x27: ffff800020d48280 x26: ffff0cb9dc814080
> [  128.309715] x25: ffff0cb9cde93fa0 x24: 0000000000000001
> [  128.315969] x23: 0000000000000000 x22: 0000000000000194
> [  128.322219] x21: ffff0cd94f986000 x20: 0000000000000000
> [  128.328462] x19: ffff0cb9d2a166c0 x18: 0000000000000000
> [  128.334698] x17: 0000000000000000 x16: ffffcf1fc523ed24
> [  128.340934] x15: 0000ffffd530a518 x14: 0000000000000000
> [  128.347162] x13: ffff0cd6bdb31310 x12: 0000000000000368
> [  128.353388] x11: ffff0cb9cfbc7070 x10: ffff2cf55dd11e02
> [  128.359606] x9 : ffffcf1f85a212b4 x8 : ffff0cd7cf27dab0
> [  128.365831] x7 : 0000000000000a20 x6 : ffff0cd7cf27d000
> [  128.372040] x5 : 0000000000000000 x4 : 000000000000ffff
> [  128.378243] x3 : 0000000000000400 x2 : ffffcf1f85a21294
> [  128.384437] x1 : ffff0cb9db520080 x0 : ffff0cb9db500080
> [  128.390626] Call trace:
> [  128.393964]  hclge_ptp_set_tx_info+0x2c/0x140 [hclge]
> [  128.399893]  hns3_nic_net_xmit+0x39c/0x4c4 [hns3]
> [  128.405468]  xmit_one.constprop.0+0xc4/0x200
> [  128.410600]  dev_hard_start_xmit+0x54/0xf0
> [  128.415556]  sch_direct_xmit+0xe8/0x634
> [  128.420246]  __dev_queue_xmit+0x224/0xc70
> [  128.425101]  dev_queue_xmit+0x1c/0x40
> [  128.429608]  ovs_vport_send+0xac/0x1a0 [openvswitch]
> [  128.435409]  do_output+0x60/0x17c [openvswitch]
> [  128.440770]  do_execute_actions+0x898/0x8c4 [openvswitch]
> [  128.446993]  ovs_execute_actions+0x64/0xf0 [openvswitch]
> [  128.453129]  ovs_dp_process_packet+0xa0/0x224 [openvswitch]
> [  128.459530]  ovs_vport_receive+0x7c/0xfc [openvswitch]
> [  128.465497]  internal_dev_xmit+0x34/0xb0 [openvswitch]
> [  128.471460]  xmit_one.constprop.0+0xc4/0x200
> [  128.476561]  dev_hard_start_xmit+0x54/0xf0
> [  128.481489]  __dev_queue_xmit+0x968/0xc70
> [  128.486330]  dev_queue_xmit+0x1c/0x40
> [  128.490856]  ip_finish_output2+0x250/0x570
> [  128.495810]  __ip_finish_output+0x170/0x1e0
> [  128.500832]  ip_finish_output+0x3c/0xf0
> [  128.505504]  ip_output+0xbc/0x160
> [  128.509654]  ip_send_skb+0x58/0xd4
> [  128.513892]  udp_send_skb+0x12c/0x354
> [  128.518387]  udp_sendmsg+0x7a8/0x9c0
> [  128.522793]  inet_sendmsg+0x4c/0x8c
> [  128.527116]  __sock_sendmsg+0x48/0x80
> [  128.531609]  __sys_sendto+0x124/0x164
> [  128.536099]  __arm64_sys_sendto+0x30/0x5c
> [  128.540935]  invoke_syscall+0x50/0x130
> [  128.545508]  el0_svc_common.constprop.0+0x10c/0x124
> [  128.551205]  do_el0_svc+0x34/0xdc
> [  128.555347]  el0_svc+0x20/0x30
> [  128.559227]  el0_sync_handler+0xb8/0xc0
> [  128.563883]  el0_sync+0x160/0x180
> 
> Fixes: 0bf5eb788512 ("net: hns3: add support for PTP")
> Signed-off-by: Jie Wang <wangjie125@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
> index 5505caea88e9..bab16c2191b2 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
> @@ -58,6 +58,9 @@ bool hclge_ptp_set_tx_info(struct hnae3_handle *handle, struct sk_buff *skb)
>  	struct hclge_dev *hdev = vport->back;
>  	struct hclge_ptp *ptp = hdev->ptp;
>  
> +	if (!ptp)
> +		return false;
> +
>  	if (!test_bit(HCLGE_PTP_FLAG_TX_EN, &ptp->flags) ||
>  	    test_and_set_bit(HCLGE_STATE_PTP_TX_HANDLING, &hdev->state)) {
>  		ptp->tx_skipped++;

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Thanks

> -- 
> 2.33.0

