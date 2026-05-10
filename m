Return-Path: <netdev+bounces-286257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CknMJpIAGqnFwEAu9opvQ
	(envelope-from <netdev+bounces-286257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 10:58:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 226535033E8
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 10:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62A22300D6B8
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 08:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0152136A033;
	Sun, 10 May 2026 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJU25zPk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D92308F32;
	Sun, 10 May 2026 08:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778403479; cv=none; b=uyUUeOPn5ZQSTopUuFmCenwGb19uZmdQLw2tN6IdQSPXmV+srTw6r5RHBpDalOhXaOqHLsXyjOr9VmPLN645yBbgRALYhKnEc9rDOYNNIhL5EsjFWryR7x+/2NA12HMzm0MSkcISpBVa4Su4E2V8tF5/NuzGKTTGn+cFBNtbs58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778403479; c=relaxed/simple;
	bh=FNDuC7oCPX7tr3C9D3AUsfZHOsDaY4QftAvCxL6a95g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+7+m0beneS8VU7ceOpIaRoUT2A3x5+sJ18099e9MwW2gx+NhyoaS3Dj2D9WCnZ5LPnNLFKhXeHoAjXhaQ7ga2JOicipEvB2Z3sajjgtWQVDCHvHez+/rP54CChf7J/ZoGusW24hbXARg8AeoqnRIcutbcBRGr8uAXHeq6MTj0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJU25zPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DF3C2BCB8;
	Sun, 10 May 2026 08:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778403479;
	bh=FNDuC7oCPX7tr3C9D3AUsfZHOsDaY4QftAvCxL6a95g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJU25zPkezZNxxAKPS1UvRg+V7DIGwXfisFOCqjmw/qj1GeoYKUn6rxhHw1/S6u1D
	 az8zl5uJ7f1q9lsoXL0k37wZTz1ClmGlNb32ouyushLCOGNCmCyvQhRg50QTKv8Tfe
	 jQpHysclDUYd+s0RGHhFzLqdVUbDDqHoFJuyqBs+WzIfe01lghkRhy5Q4IIMyHjc/S
	 89XYsukKapzYhYw9Z8U+wV2ZAQGebMJKNMXHZuEPZgI2EUExzq+ojjEz8bGiiyzuco
	 iDABmf2ooHrQgARfZ7wheBHg0TUuS7amjZPtQUaPkzxaCENFJ55JbwvCGKFgZclNWR
	 z33jWLBdN8m8w==
Date: Sun, 10 May 2026 09:57:54 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kohei@enjuk.jp, jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	nxne.cnse.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next v5 3/5] ice: migrate to netdev ops lock
Message-ID: <20260510085754.GT15617@horms.kernel.org>
References: <20260505152923.1040589-4-aleksander.lobakin@intel.com>
 <20260508132827.1183079-3-horms@kernel.org>
 <5eab9525-6fbd-46ae-8464-12ca9472bea1@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5eab9525-6fbd-46ae-8464-12ca9472bea1@intel.com>
X-Rspamd-Queue-Id: 226535033E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286257-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 03:57:25PM +0200, Alexander Lobakin wrote:
> From: Simon Horman <horms@kernel.org>
> Date: Fri,  8 May 2026 14:28:29 +0100
> 
> > From: 'Simon Horman' <horms@kernel.org>
> > 
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> > ---
> >     ice: migrate to netdev ops lock
> > 
> > This commit migrates queue management operations to use netdev locking.
> > It updates several NAPI and VSI configuration functions to use their
> > _locked variants to avoid deadlocks, taking the lock manually where needed.
> > 
> >> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> >> index 16aa255351523..7d89c0acc5d8d 100644
> >> --- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> >> +++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> > [ ... ]
> >> @@ -1107,7 +1106,7 @@ ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
> >>  
> >>  	rtnl_lock();
> >>  	/* disable VSIs affected by DCB changes */
> >> -	ice_dcb_ena_dis_vsi(pf, false, true);
> >> +	ice_dcb_ena_dis_vsi(pf, false);
> >>  
> >>  	ret = ice_query_port_ets(pi, &buf, sizeof(buf), NULL);
> >>  	if (ret) {
> >> @@ -1119,7 +1118,7 @@ ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
> >>  	ice_pf_dcb_recfg(pf, false);
> >>  
> >>  	/* enable previously downed VSIs */
> >> -	ice_dcb_ena_dis_vsi(pf, true, true);
> >> +	ice_dcb_ena_dis_vsi(pf, true);
> >>  unlock_rtnl:
> >>  	rtnl_unlock();
> >>  out:
> > 
> > This wasn't introduced by this patch, but does this error path leave VSIs
> > permanently disabled?
> > 
> > If ice_query_port_ets() fails, the code jumps to unlock_rtnl, bypassing the
> > call to ice_dcb_ena_dis_vsi(pf, true). This seems to leave the affected VSIs
> > (including the main PF interface) in a disabled state (ICE_VSI_DOWN) with
> > ICE_VSI_NEEDS_RESTART set, which could result in a denial of service.
> > 
> >> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> >> index 2e4f0969035f7..af0cc77fbf718 100644
> >> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> >> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> >> @@ -23,10 +23,16 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
> >>  	struct net_device *netdev = uplink_vsi->netdev;
> >>  	bool if_running = netif_running(netdev);
> >>  	struct ice_vsi_vlan_ops *vlan_ops;
> >> +	int ret;
> >> +
> >> +	if (if_running && !test_and_set_bit(ICE_VSI_DOWN, uplink_vsi->state)) {
> >> +		netdev_lock(netdev);
> >> +		ret = ice_down(uplink_vsi);
> >> +		netdev_unlock(netdev);
> >>  
> >> -	if (if_running && !test_and_set_bit(ICE_VSI_DOWN, uplink_vsi->state))
> >> -		if (ice_down(uplink_vsi))
> >> +		if (ret)
> >>  			return -ENODEV;
> >> +	}
> > 
> > Simon says: It seems that the topic of locks in this patch has come up
> >             again ¯\_(ツ)_/¯
> > 
> > Does manipulating the state bit outside of netdev_lock create a race
> > condition with interface teardown?
> > 
> > If the interface is concurrently brought down, ndo_stop (which holds
> > netdev_lock) would call ice_vsi_close(). Because ICE_VSI_DOWN is already
> > set by the test_and_set_bit() call above, ice_vsi_close() would skip calling
> > ice_down() and immediately proceed to free the Tx/Rx rings.
> > 
> > This would leave the hardware queues active and performing DMA operations into
> > freed memory, potentially causing a use-after-free.
> 
> I ran Sashiko internally a couple times and it hasn't found these =\
> 
> Anyway, now that I anyway need to adjust the series after
> .ndo_set_rx_mode_asyn() landed, I'll take a look at this, too.
> 
> (I hate this series already. I feel like if Sashiko was alive when other
>  vendors were switching to the netdev lock, they'd have the same drama)

Life is certainly different with Sashiko.
No question about it.

> 
> (I was planning to add devmem/io_uring support to idpf after this lands,
>  but given that idpf is way more confusing and inconsistent in locking,
>  I'm not sure I'll have enough patience :D)
> 
> Thanks,
> Olek

