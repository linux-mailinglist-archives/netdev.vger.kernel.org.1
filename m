Return-Path: <netdev+bounces-290969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGTBEkDyEGp7fwYAu9opvQ
	(envelope-from <netdev+bounces-290969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:18:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC855BBBA2
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42ADB30177B2
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C684D135A53;
	Sat, 23 May 2026 00:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aktossk/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8D4883F
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495379; cv=none; b=Fhx+mV2neiUuGIUrKsG4zVLF/JKa3btK4XQ/JTTJIxQtTZtFNa46IAVVSluOZzEtP1+OffKBBl1Xs+0L7gIoKeL3VjSB4eoJanNvjusNEdc4b4QS57BcJwbOsbg9zLgzDUkpBAl6LHzAizBIWWuyVmB3iHiRZHxHjXS8MPGk3Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495379; c=relaxed/simple;
	bh=EikMCulMQ1ZurIFXs2NPd130RpnsSg/xRLmi1xiqtMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7CN3/xADczlO53fmZfsM9oxx6cYVY16la5eFlQKBVtLeTQMB30z0/u2NLC5MrkxwsEdkiMwpLk84gsGoDyIZu7Id5aziVB0V0RkUq/tXZgf/AMgd09/PxKzOxGmsPy3XI6PpU1zHtlD23qPoJULhvG5btpLsTfpOOfI8eLfKgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aktossk/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF9A1F000E9;
	Sat, 23 May 2026 00:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779495378;
	bh=v92D3Wp6yESCcTl7GJ1GdDLhXNB2WnoW6C1zKb/8NKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aktossk/VUq5UaNFpPxCdcU5dBM1WNkSGyG+Ezr9G4ssnsSXoqmCWGHds5X+xq9O8
	 n85mhU5ftCzBh3rotK3cYDGpE/vrSAvnx3EeFn7dsuHHuovDDHg6Ts5fipiP9trESw
	 PA57g14dxVqk/716ZxM25gI9jGBR017pvx/yi9F/8795omuURIuO5HOhnQZEmiciO5
	 Su98jIqiOPmsujT/6zA0tctE8IyK8zuh9e4Ee3Iqk9cOsVEqdPvaRf2N86POx/HrW1
	 os2svdJsIJVqr3kqckjrmMyHzAWLa5uQGvHBkBLXPQ6wqZe2zF9U3j5KtaDGzjUMpn
	 N+uJJBsfEAQhA==
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
Subject: Re: [PATCH net 1/8] ice: fix UAF/NULL deref when VSI rebuild and XDP attach race
Date: Fri, 22 May 2026 17:16:16 -0700
Message-ID: <20260523001616.1757210-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520183501.3360810-2-anthony.l.nguyen@intel.com>
References: <20260520183501.3360810-2-anthony.l.nguyen@intel.com>
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
	TAGGED_FROM(0.00)[bounces-290969-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9FC855BBBA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ice: fix UAF/NULL deref when VSI rebuild and XDP attach race

This commit addresses a race condition between a VSI rebuild and an XDP
attach operation. It prevents rx_ring->xdp_prog from being populated before
rx_ring->xdp_ring is valid by rejecting the XDP attach when a VSI rebuild
is pending. XDP detachment is still permitted during this window to clear
the existing program.

Fixes: 2504b8405768 ("ice: protect XDP configuration with a mutex")

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
[ ... ]
> @@ -2912,12 +2912,21 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
>  	}
>  
>  	/* hot swap progs and avoid toggling link */
> -	if (ice_is_xdp_ena_vsi(vsi) == !!prog ||
> -	    test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
> +	if (ice_is_xdp_ena_vsi(vsi) == !!prog) {
>  		ice_vsi_assign_bpf_prog(vsi, prog);
>  		return 0;
>  	}
>  
> +	if (test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {

[Severity: High]
This is a pre-existing issue, but is the check for ICE_VSI_REBUILD_PENDING
prone to a TOCTOU race because it relies on ad-hoc flag synchronization
instead of proper locking with the device reset path?

The asynchronous reset path (ice_prepare_for_reset()) sets
ICE_VSI_REBUILD_PENDING without holding vsi->xdp_state_lock or rtnl_lock().

If ice_xdp_setup_prog() (which holds both locks) checks the bit before it
is set, it proceeds to configure XDP and sets ICE_VSI_DOWN. If the reset
path then sets the bit and calls ice_pf_dis_all_vsi(), it will skip this
VSI because ICE_VSI_DOWN is already set.

When ice_xdp_setup_prog() finishes, it calls ice_up() which clears
ICE_VSI_DOWN and starts enabling hardware queues while the device is
actively undergoing a hardware reset (ice_do_reset()).

Can writing to hardware registers during an active reset cause hardware
hangs or PCI master aborts?

> +		if (prog) {
> +			NL_SET_ERR_MSG_MOD(extack, "VSI rebuild is pending");
> +			return -EAGAIN;
> +		}
> +
> +		ice_vsi_assign_bpf_prog(vsi, NULL);

[Severity: High]
This is a pre-existing issue, but does detaching an XDP program while a VSI
rebuild has failed lead to a NULL pointer dereference here?

If a VSI rebuild fails, ice_vsi_decfg() frees vsi->rx_rings and sets the
pointer to NULL via ice_vsi_free_arrays(), but leaves vsi->num_rxq
non-zero. The ICE_VSI_REBUILD_PENDING bit remains set because it is only
cleared on the success path in ice_vsi_rebuild().

If a user subsequently detaches XDP, ice_xdp_setup_prog() intercepts it
because ICE_VSI_REBUILD_PENDING is set, and it calls
ice_vsi_assign_bpf_prog(vsi, NULL).

This function loops up to vsi->num_rxq:

ice_vsi_assign_bpf_prog() {
    ...
    ice_for_each_rxq(vsi, i)
        WRITE_ONCE(vsi->rx_rings[i]->xdp_prog, vsi->xdp_prog);
    ...
}

Since vsi->rx_rings is NULL, does this cause a guaranteed NULL pointer
dereference panic?

> +		return 0;
> +	}
> +
>  	if_running = netif_running(vsi->netdev) &&
>  		     !test_and_set_bit(ICE_VSI_DOWN, vsi->state);
-- 
pw-bot: cr

