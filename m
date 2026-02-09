Return-Path: <netdev+bounces-257943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOZaLTHgiWnGCwAAu9opvQ
	(envelope-from <netdev+bounces-257943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 14:25:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5796610FA34
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 14:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37FB2302BA41
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 13:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EA03783D8;
	Mon,  9 Feb 2026 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xFmpSaJe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ACD2040B6;
	Mon,  9 Feb 2026 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770643310; cv=none; b=pnC7GlORjVxQ9C5GLv2UxQm52V1ySN4GVvYSa/9f/1rzS3Qw2tEVPL3RGunOoe6RgrpEV4rutFBJYw7BgcimJoaWcym1YNpMsbyjAJ8L8hqvoAicvWVWBh5M3eBDerZc60ohcwudcduSpf8yFFZSuODjvfzizDcEWet8C/GlmrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770643310; c=relaxed/simple;
	bh=fsdQ4h2kGKzUTTTJ7upWQ+6ugDvCXOWUIT1OEiSXP+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzjfAZjwbCCpCvhy0j66YBiHNomZbH0YxLsR5E+99H8Ql499I4KodEBDzwp4QQ4oDMtfiRuus/jb7H7cOcMomcTbZiGBa4ghGSo+iFIpAWjSA4waWqgCRhl5An4WT/QgiZURpJuCXGUrQ4PfmqCUPc8MvtJJcEBzlbCQCw2cl5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xFmpSaJe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7c5Iz36nXiOUw2znVHTn8jamtOl0QUFsP43IKfvjzog=; b=xFmpSaJetZJzlzNkKcOMeOkfXO
	eXy91aPdFUZaE5lcIgjeONKcpRewpATzW8QU4rzHOiAiN75s+BepQBxInCSLBT2onPedGfcJOBrhG
	NpaSBIM86Jo5MED9Up9RbTEdf+aRkG1atB+NX7RvPMSS5maYvrTa0+n+B3bopD9nkzfM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vpRCn-006iwq-BF; Mon, 09 Feb 2026 14:21:33 +0100
Date: Mon, 9 Feb 2026 14:21:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: lizhi2@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: [PATCH v2 1/2] dt-bindings: ethernet: eswin: add clock sampling
 control
Message-ID: <7e593ede-59eb-4316-ab72-949a51c008c6@lunn.ch>
References: <20260209094628.886-1-lizhi2@eswincomputing.com>
 <20260209094801.909-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209094801.909-1-lizhi2@eswincomputing.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257943-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,st-md-mailman.stormreply.com,lists.infradead.org,eswincomputing.com,einfochips.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	RCPT_COUNT_TWELVE(0.00)[21];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 5796610FA34
X-Rspamd-Action: no action

> The rx-internal-delay-ps and tx-internal-delay-ps properties now use
> minimum and maximum constraints to reflect the actual hardware delay
> range (0-2400 ps) applied in 20 ps steps.


>    rx-internal-delay-ps:
> -    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
> +    minimum: 0
> +    maximum: 2400

       multipleOf: 20

Also, 2400 / 20 = 120. Is the real maximum 127 * 20 = 2540?

> @@ -111,17 +129,44 @@ examples:
>          interrupts = <61>;
>          interrupt-names = "macirq";
>          phy-mode = "rgmii-id";
> -        phy-handle = <&phy0>;
> +        phy-handle = <&gmac0_phy0>;
>          resets = <&reset 95>;
>          reset-names = "stmmaceth";
> +        rx-internal-delay-ps = <20>;
> +        tx-internal-delay-ps = <100>;

I would not include them in the example. You are going to get
developers blindly copying this into real DT. A well designed board
should not need delays.

	Andrew

