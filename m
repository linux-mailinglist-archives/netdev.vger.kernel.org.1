Return-Path: <netdev+bounces-265842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPXmKed1r2msZgIAu9opvQ
	(envelope-from <netdev+bounces-265842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:37:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2F2243AD5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C6F9300846F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DA226FDAC;
	Tue, 10 Mar 2026 01:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ug6ORLvw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E995238150
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 01:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773106658; cv=none; b=MyesRAM/ZYiVoM/2MZ3FEYSzLJfZX3FG0dpHXpUjjOAdpNFtOruiEnCEKRUptiIBgcMN4RY4JTvkDTKUIYkZawAmj0PhhFbPDl8SC+tvXe+n4yWSwDEmWMGRA6Paf7I+EnSsi7/p3R+9m0yFrA1zvXnFaklQOO1GjNwGUyLll9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773106658; c=relaxed/simple;
	bh=KEk2PR3tyC/l66cUEg+TXaFkhWyEjTUySb1oXd6oDQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjvqSD1bcB1JZfrMnxV+f7OF7rvSQuOIhlZ1zJQDrDh8gEbU2OgOr2M77M0F0tjYA12t1qSmvzD0SytDgvGsly5wxFYEot6PtReaVJLHSwYlvZg2RdiujRicWDOS+eB1gUMtZz/jg24+eN6AiK0BdEibr4Sbk0wQIk6gGUi4OEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ug6ORLvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362F7C4CEF7;
	Tue, 10 Mar 2026 01:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773106657;
	bh=KEk2PR3tyC/l66cUEg+TXaFkhWyEjTUySb1oXd6oDQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ug6ORLvwpYAR7eMpRdLBspV+8IbY87wr2/Ma3Trq1L/afN/ME3C5HUE6u70mE04Ig
	 rW6wH+tkUHLAGoFOBbjgdKBsMe7c6vraIsSpUlHWZz2uWk/Vrm9NuJE3/tMlIL5/I/
	 XNErf8qAFNAUBs9S2oJZSa0SePeIbM0YpVIMVBVtWdqKQmZhMVYBmAqhgrAQr9+zph
	 II0Ep/J9reEOG0V3JcQsZg7Ilk604h7aIg9Qt1mI1vECLXnXjVt/93EgCTjgvzHeD7
	 U65JOANdgLts+isA0eo939fDeAsBKnu1nYFRaFWktUwqMu04bU99ce5LhqlDAkC4j+
	 kWEOBCijGBnAg==
Date: Mon, 9 Mar 2026 18:37:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, o.rempel@pengutronix.de, rmk+kernel@armlinux.org.uk,
 Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net] net: bcmgenet: fix broken EEE by converting to
 phylib-managed state
Message-ID: <20260309183736.1c9b8496@kernel.org>
In-Reply-To: <20260306083120.1076104-1-nb@tipi-net.de>
References: <20260306083120.1076104-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0C2F2243AD5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265842-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,pengutronix.de,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri,  6 Mar 2026 09:31:19 +0100 Nicolai Buchwitz wrote:
> @@ -1397,17 +1393,23 @@ static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_keee *e)
>  	if (!dev->phydev)
>  		return -ENODEV;
>  
> -	e->tx_lpi_enabled = p->tx_lpi_enabled;
> +	int ret;
> +
> +	ret = phy_ethtool_get_eee(dev->phydev, e);
> +	if (ret)
> +		return ret;

no variable declarations mid-function please.
-- 
pw-bot: cr

