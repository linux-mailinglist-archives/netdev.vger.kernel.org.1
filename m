Return-Path: <netdev+bounces-290970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLWBNWLyEGp7fwYAu9opvQ
	(envelope-from <netdev+bounces-290970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:18:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 615755BBC1C
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E94D302F9B6
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212A41D798E;
	Sat, 23 May 2026 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVvO3Wjr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72CC35959
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495380; cv=none; b=qvNshJx9l0bs5xT0l1MCnw9reYO1phRM+F++FZraHMgG/KAmc00kUCs/AU9+g2W0CC/LOhbImfSvtuqadRLAvrhXFnZhKd0qadEtzzf/D9y//bFtiyasLDUtQk++NBN7llmigPM3yNLRBnYrMQ2DG5E94RxWz7MRv1epPY81NYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495380; c=relaxed/simple;
	bh=6dwm8Kl0+m9sopbeuiyySzMtQsHMyc2Rn9NUXq5sVaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLIqjlPGJG2HvLK4/W+nBxvjRQKLWscC56vmPDrIoelJHCa93qsWHTmoIdPDsMWdDw5hQDkygnmP0+VmB1S3m9qyxHCcL7NlvQcPXxdaCmDdYj6ti2o7qBrJUjzlpzcF0KyZp7Z1KvLv5aqrDYTvBdRbcbldrgwPk4yGHb/QkY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVvO3Wjr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA101F00A3D;
	Sat, 23 May 2026 00:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779495379;
	bh=pkNdFmZwMGFpbUu7qOvLEWc1Z9D58x6hQE04EfxIHc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kVvO3WjrZfbpYv4iaZlBY/VudjEGC017v6cP8N6+MxnaFeEqGa+r+uSVy9SsbM1nU
	 qUxnAFUztKsiyYAgfKzj0DGKNBdwqON8GVK6obchekKhsj86Azd0WekNr1KzaNVZke
	 gFfYB123SakPSOc9EVGF/Xc2aeh/Gu9dM6niwllizGFLwd8YUr0Sahp0Lf7kXgFZO+
	 4WEHGxWtYANJrY2CDeGACY0Tfc8cOE3IZ1UXZE3eg4vjfOYgT++ZK09SP5O91dAKbe
	 2o4sP/kQmKotLWb7O5g3A8bDIG6DBT0yqx8DJAttD/840pOIytUIfCQmwR4oPkcgM2
	 mGFRv14fNKB+A==
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
Subject: Re: [PATCH net 2/8] ice: fix stats array overflow when VF requests more queues
Date: Fri, 22 May 2026 17:16:18 -0700
Message-ID: <20260523001618.1757240-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520183501.3360810-3-anthony.l.nguyen@intel.com>
References: <20260520183501.3360810-3-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290970-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 615755BBC1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ice: fix stats array overflow when VF requests more queues

When a VF increases its queue count via VIRTCHNL_OP_REQUEST_QUEUES,
ice_vc_request_qs_msg() sets vf->num_req_qs and triggers a VF reset.
The reset calls ice_vf_reconfig_vsi(), which does ice_vsi_decfg()
followed by ice_vsi_cfg(). This patch fixes a stats array overflow by
calling ice_vsi_realloc_stat_arrays() in ice_vf_reconfig_vsi() before
ice_vsi_decfg().

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 837b71b7b2b7c..fc78176a2a8d0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -3015,7 +3015,7 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
>   * ice_vsi_realloc_stat_arrays - Frees unused stat structures or alloc new ones
>   * @vsi: VSI pointer
>   */
> -static int
> +int
>  ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
>  {

[Severity: High]
This isn't a bug introduced by this patch, but making this function public and
using it in more paths exposes a potential NULL pointer dereference.

Does this code safely handle ADQ channel VSIs?

For ADQ channel VSIs (where vsi->type == ICE_VSI_CHNL),
ice_vsi_alloc_stat_arrays() bypasses stats allocation, leaving
pf->vsi_stats[vsi->idx] as NULL.

During a PF reset (ICE_RESET_PFR), ice_rebuild_channels() iterates over
ICE_VSI_CHNL VSIs and calls ice_vsi_rebuild(), which triggers
ice_vsi_realloc_stat_arrays().

This will unconditionally dereference vsi_stat:

drivers/net/ethernet/intel/ice/ice_lib.c:ice_vsi_realloc_stat_arrays() {
	...
	vsi_stat = pf->vsi_stats[vsi->idx];
	
	if (req_txq < prev_txq) {
		for (i = req_txq; i < prev_txq; i++) {
			if (vsi_stat->tx_ring_stats[i]) {
				...

Can this result in a NULL pointer dereference when rebuilding channel VSIs?

[Severity: High]
This is another pre-existing issue, but the error handling when reallocating
arrays might lead to out-of-bounds reads and memory corruption.

When a VF requests fewer queues (req_txq < prev_txq), the function successfully
shrinks vsi_stat->tx_ring_stats using krealloc_array().

However, if the subsequent reallocation for rx_ring_stats fails (e.g., due to
memory pressure returning -ENOMEM), the function returns an error and aborts
before vsi->alloc_txq is updated to the new smaller size:

drivers/net/ethernet/intel/ice/ice_lib.c:ice_vsi_realloc_stat_arrays() {
	...
	vsi_stat->tx_ring_stats = krealloc_array(...);
	if (!vsi_stat->tx_ring_stats) { ... }

	...
	vsi_stat->rx_ring_stats = krealloc_array(...);
	if (!vsi_stat->rx_ring_stats) {
		vsi_stat->rx_ring_stats = rx_ring_stats;
		return -ENOMEM;
	}
	...
}

Later, during VSI teardown in ice_vsi_free_stats(), ice_for_each_alloc_txq(vsi, i)
iterates up to the stale, larger vsi->alloc_txq value.

Is it possible for this to read past the bounds of the newly shrunk
tx_ring_stats array and pass non-zero garbage to kfree_rcu()?

