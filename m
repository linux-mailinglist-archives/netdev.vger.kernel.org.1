Return-Path: <netdev+bounces-284659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAIkOPmd+mk8QQMAu9opvQ
	(envelope-from <netdev+bounces-284659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:48:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D814D56C9
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87692304A7BF
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68796270552;
	Wed,  6 May 2026 01:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2z/wFuz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445FB258EFF;
	Wed,  6 May 2026 01:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032095; cv=none; b=WW+lVDfrBT5YWbgi2QKNR+lfnMBcY+TrQRI9dvhGTdtWmjQ2RrfmSK78NEaapeVnNvTkeqipsOtOe4VpyaBWjhzAwc10EMlNGO0eH7wUc+g0r8GRK0GJ39O9C9uLG87DD94MSg2fYoWWPg8eOnRqngudbHDtJA05MDE4pKeP/BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032095; c=relaxed/simple;
	bh=x76vxbmWDjAy8fq9ldzyLVAE10hUc0pSJJ+tjWhR50E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJEw7wVDmLivQQXGJ5/feTOrIzq+/K2CKv9LXwEYyUdgmIjE1kcIkZ5owT9Cscc7tWFlLSPrjaiElodJYHrj+fbqRvhxXCCwUvT/FjMp81JtmHCvJXyIyyhr13vkUx4HCtZrAdGnKCq1GxF8f9h5Xe2yEemUJ8ErCIlSwlSeBog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2z/wFuz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346F3C2BCB4;
	Wed,  6 May 2026 01:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778032094;
	bh=x76vxbmWDjAy8fq9ldzyLVAE10hUc0pSJJ+tjWhR50E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n2z/wFuzcVRRK+8j+7JO+PrsEnBw8RUliZUkfvFBT0HQebF0pjhWCdGOUheUsQGKw
	 H26F2Wah1/wzqfgC/f8Vord79L0OplCLdzribQXibgP+UxoBf0Ep41M8M7IyGfpeK0
	 4gO2H3EqewbmNCmVRtOFlldMCH3xfUGhcoxQgmwSVdj2eelviRYnh0IsW4xtCXFEKr
	 M8wbuFq+lDTRxQH3X0nWMlzvNkZBAk8C9DpfIwJl3s/FT6V3TKMqNpzhSy9VY7aY1Z
	 pJftu36ZJgfdO3SnDpN3o2Ppo7gJKverWVnmWeF8A4BrwJaNam4/QS+XqgVzjrpgdt
	 pj55Rex+zEDXw==
Date: Tue, 5 May 2026 18:48:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: jensemil.schulzostergaard@microchip.com
Cc: UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 woojung.huh@microchip.com, linux@armlinux.org.uk,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 9/9] net: dsa: lan9645x: add port statistics
Message-ID: <20260505184813.09e384dc@kernel.org>
In-Reply-To: <20260506014618.1616861-1-kuba@kernel.org>
References: <20260430-dsa_lan9645x_switch_driver_base-v4-9-f1b6005fa8b7@microchip.com>
	<20260506014618.1616861-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A4D814D56C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284659-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue,  5 May 2026 18:46:18 -0700 Jakub Kicinski wrote:
> > +static const struct lan9645x_ethtool_stat lan9645x_port_ethtool_stats[] = {
> > +	{ "rx_cat_drop",        SCNT_RX_CAT_DROP },
> > +	{ "rx_red_prio_0",      SCNT_RX_RED_PRIO_0 },  
> 
> Per Documentation/networking/statistics.rst and the netdev stats hierarchy,
> counters that have a standard uAPI must not be duplicated in ethtool -S.
> 
> The rx_cat_drop counter is summed into stats->rx_dropped in
> lan9645x_stats_get_stats64():
> 
>     stats->rx_dropped = c[SCNT_RX_LONG] +
>                         c[SCNT_DR_LOCAL] +
>                         c[SCNT_DR_TAIL] +
>                         c[SCNT_RX_CAT_DROP] +
>                         ...
> 
> Since rtnl_link_stats64.rx_dropped is reachable via "ip -s link show",
> does exposing rx_cat_drop here duplicate a value already covered by the
> standard uAPI?
> 
> [ ... ]
> 
> > +	{ "tx_drop",            SCNT_TX_DROP },  
> 
> Similarly, tx_drop feeds stats->tx_dropped:
> 
>     stats->tx_dropped = c[SCNT_TX_DROP] + c[SCNT_TX_AGED];
> 
> Should tx_drop be dropped from the ethtool -S list for the same reason?

Ignore this part, I need to update the AI prompts..

