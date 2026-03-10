Return-Path: <netdev+bounces-266251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH7YF2dQsGmBiAIAu9opvQ
	(envelope-from <netdev+bounces-266251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:09:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C30642554E1
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86469303525D
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D644B3BF66E;
	Tue, 10 Mar 2026 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+Hx265b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DEE32ED39;
	Tue, 10 Mar 2026 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162477; cv=none; b=s4VeqmLAW4jUDrWSYaZvmmNwFstX4yPCOX7ZCKUcs0h0wNThhE49W9nW+gpHmQkWBPPnVlrGV5SY+ItVTyV7RwsLticaRlpFBV4jbgaev1VB45XHfAKingceis1AXj1n60lRgSC6jKAEdqysq1JQb9wRQyngiXx3/60duwmaEq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162477; c=relaxed/simple;
	bh=+g1/ElvErcOafWKoSRaH2lOSraOgCa+U5fAhEL5DSzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3JV07a1ah6DtMY3j8auSEmaS+cYbmATD4Ftn1IUj4j1Nvje/QFqrkG0SwAenxSqm1duzb3tFLV0VC3bLcNuUKkOQGK1wkHhLV/HIb9kRIkQQbdkAxRvW1HAnJ1A8Tei3D6mnYQK58kFD2Qt8ELv1frDW0JWkGQ1VfdNgOD6vD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+Hx265b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21FCC19423;
	Tue, 10 Mar 2026 17:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773162477;
	bh=+g1/ElvErcOafWKoSRaH2lOSraOgCa+U5fAhEL5DSzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+Hx265bZ1gpSbNsKmQPNa4fMVqozvDcjAVcR+E8dC3IyBSG9vrT0HVvrVE5fxwk1
	 gH+ime8g4QHk9iUZijQAX1k8p6iPmYjKH3K6Y3I7UlpyuN7TAsBCFe93iPefxz2oUB
	 xjn9cMVB+o9vgeA4n8WX5GglrJjGLbztqQ/V5RuaiZxZvtFKLOnzCLf9SCzcBYHh4t
	 VuD+PWG1u9Vzo6B5Hk9rDnI3efwktqB9Z1B+Q9gqMb0A3TyjA1usndjxOpfI+BqRtF
	 N14WWcmlFzuDiLyLmMRCo17WdY0mSZgMmN2inJ/f1WTty39SCVpR88P/Wq4SiJYbeP
	 tjdw7BKUbm4JA==
Date: Tue, 10 Mar 2026 17:07:52 +0000
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	Frank.Li@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 net] net: enetc: safely reinitialize TX BD ring when
 it has unsent frames
Message-ID: <20260310170752.GL461701@kernel.org>
References: <20260309030412.2716984-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309030412.2716984-1-wei.fang@nxp.com>
X-Rspamd-Queue-Id: C30642554E1
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
	TAGGED_FROM(0.00)[bounces-266251-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:04:12AM +0800, Wei Fang wrote:
> Currently the driver does not reset the producer index register (PIR) and
> consumer index register (CIR) when initializing a TX BD ring. The driver
> only reads the PIR and CIR and initializes the software indexes. If the
> TX BD ring is reinitialized when it still contains unsent frames, its PIR
> and CIR will not be equal after the reinitialization. However, the BDs
> between CIR and PIR have been freed and become invalid and this can lead
> to a hardware malfunction, causing the TX BD ring will not work perperly.
> 
> Since the PIR and CIR are sofeware-configurable on ENETC v4. Therefore,
> the driver must reset them if they are not equal when reinitializing
> the TX BD ring.
> 
> However, resetting the PIR and CIR alone is insufficient, it cannot
> completely solve the problem. When a link-down event occurs while the
> the TX BD ring is transmitting frames, subsequent reinitialization of
> the TX BD ring may cause it to malfunction. For example, the following
> steps may reproduce the problem (not 100% reproducible).
> 
> 1. Unplug the cable when the TX BD ring is busy transmitting frames.
> 2. Disable the network interface (ifconfig eth0 down).
> 3. Re-enable the network interface (ifconfig eth0 up).
> 4. Plug in the cable, the TX BD ring may fail to transmit packets.
> 
> When the link-down event occurs, enetc4_pl_mac_link_down() only clears
> PMa_COMMAND_CONFIG[TX_EN] to disable MAC transmit data path. It doesn't
> set PORT[TXDIS] to 1 to flush the TX BD ring. Therefore, reinitializing
> the TX BD ring at this point is unsafe. To safely reinitialize the TX BD
> ring after a link-down event, we checked with the NETC IP team, a proper
> Ethernet MAC graceful stop is necessary. Therefore, add the Ethernet MAC
> graceful stop to the link-down event handler enetc4_pl_mac_link_down().
> 
> Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2:
> 1. Remove unused register macros (ENETC_SISR and SISR_TX_BUSY)
> 2. Remove spurious semicolon from enetc4_mac_wait_rx_empty()
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c  |   9 ++
>  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  11 ++
>  .../net/ethernet/freescale/enetc/enetc4_pf.c  | 126 ++++++++++++++++--
>  3 files changed, 132 insertions(+), 14 deletions(-)

Hi,

This is a not a small patch for a fix.
Could you consider splitting it up a bit?
Say one patch for the ENETC_TBPIR/ENETC_TBCIR
portion and another for the graceful stop?

> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 70768392912c..825a5d1f2965 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -2578,6 +2578,7 @@ EXPORT_SYMBOL_GPL(enetc_free_si_resources);
>  
>  static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
>  {
> +	struct enetc_si *si = container_of(hw, struct enetc_si, hw);
>  	int idx = tx_ring->index;
>  	u32 tbmr;
>  
> @@ -2595,6 +2596,14 @@ static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)

The line above this hunk is:

	/* clearing PI/CI registers for Tx not supported, adjust sw indexes */

And the AI generated review reports:

  This isn't a bug, but the comment now contradicts the code. The comment
  says "clearing PI/CI registers for Tx not supported" but the code
  immediately below clears TBPIR and TBCIR for ENETC v4 hardware.

  Should the comment be updated to clarify that clearing is only
  unsupported on ENETC rev1?

>  	tx_ring->next_to_use = enetc_txbdr_rd(hw, idx, ENETC_TBPIR);
>  	tx_ring->next_to_clean = enetc_txbdr_rd(hw, idx, ENETC_TBCIR);
>  
> +	if (tx_ring->next_to_use != tx_ring->next_to_clean &&
> +	    !is_enetc_rev1(si)) {
> +		tx_ring->next_to_use = 0;
> +		tx_ring->next_to_clean = 0;
> +		enetc_txbdr_wr(hw, idx, ENETC_TBPIR, 0);
> +		enetc_txbdr_wr(hw, idx, ENETC_TBCIR, 0);
> +	}
> +
>  	/* enable Tx ints by setting pkt thr to 1 */
>  	enetc_txbdr_wr(hw, idx, ENETC_TBICR0, ENETC_TBICR0_ICEN | 0x1);
>  

...

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c

...

> @@ -801,15 +792,120 @@ static void enetc4_set_tx_pause(struct enetc_pf *pf, int num_rxbdr, bool tx_paus
>  	enetc_port_wr(hw, ENETC4_PPAUOFFTR, pause_off_thresh);
>  }
>  
> -static void enetc4_enable_mac(struct enetc_pf *pf, bool en)
> +static void enetc4_mac_wait_tx_empty(struct enetc_si *si, int mac)
> +{
> +	u32 timeout = 0;
> +
> +	while (!(enetc_port_rd(&si->hw, ENETC4_PM_IEVENT(mac)) &
> +		 PM_IEVENT_TX_EMPTY)) {
> +		if (timeout >= 100) {
> +			dev_warn(&si->pdev->dev,
> +				 "MAC %d TX is not empty\n", mac);
> +			break;
> +		}
> +
> +		usleep_range(100, 110);
> +		timeout++;
> +	}
> +}

Can this be implemented using poll_timeout_us() ?

...

> +static void enetc4_mac_wait_rx_empty(struct enetc_si *si, int mac)
> +{
> +	u32 timeout = 0;
> +
> +	while (!(enetc_port_rd(&si->hw, ENETC4_PM_IEVENT(mac)) &
> +		 PM_IEVENT_RX_EMPTY)) {
> +		if (timeout >= 100) {
> +			dev_warn(&si->pdev->dev,
> +				 "MAC %d RX is not empty\n", mac);
> +			break;
> +		}
> +
> +		usleep_range(100, 110);
> +		timeout++;
> +	}
> +}

Likewise, here.

...

