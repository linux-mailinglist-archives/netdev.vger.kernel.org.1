Return-Path: <netdev+bounces-273436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBWuKwYqy2n8EQYAu9opvQ
	(envelope-from <netdev+bounces-273436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:57:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAE636337E
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA81B3025296
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEB2364948;
	Tue, 31 Mar 2026 01:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpVEg82b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9410244685;
	Tue, 31 Mar 2026 01:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774922243; cv=none; b=YmbPW2P6nAEozgNXZGfzpCvRDf2sZQxsD9mihU7uzGGrxIQxY1291bxkoDfePCpofXd4X82FSPzfdEhjRJW7PqiDkrN2O1ElaCoSM47QCejHAtjYSjWUJEl1HMiM/aVo0EA8rDIpR9Dcnj3WrDt8BZdQssuMN9vW7DAZURDmB8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774922243; c=relaxed/simple;
	bh=f/EwwW6tcN2UvyZZQmwbxNur0FnJEb8ki7XcMTnc4dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjLdDlLC/QE1cBiTTQmV26+bEJi0nIGYswhHc/Xt2G6CG89O36i04GCyfWeJ1JF045t/Sjf/bnMYb+IK9wvldKfnrB/jSsdPu+eRfhYGVQeldYb9NWvYCQ+PqVUHiATNtdoHYz27PS98XkKiWHbrEVRXaPr3BgSjlPKv288YL+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpVEg82b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AE3C4CEF7;
	Tue, 31 Mar 2026 01:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774922243;
	bh=f/EwwW6tcN2UvyZZQmwbxNur0FnJEb8ki7XcMTnc4dQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YpVEg82bro2aUVhZbRspwHh/UoocrDHywMdEDcxO95S/KMWV2ENKq1aZ634vQ2/TR
	 nJbjTHpAI/3aKjD1c3T0h9zlV8xF94Ne7Xwr1wRdgiuintzzklS45x5r7Jx9ptkPbA
	 kVynj5SFj7eJImQ8neDKkM+WgyQhdG/a3thsLACBLRogriz4xzRI0/8Vemxzcj14RE
	 a95Lo8zKsAfReYuRfq58Ik+Iiu7CLv39UFpIkWaec+epsulUkKgBB4qBufzGaMOIc1
	 EsgLzVobIAE+VsJFfjRlX+kz9oBHBqoNdnVSgGBw6dt609OAuBTPW6WtZi5SkA+coy
	 qEO+GQvhAPAcg==
Date: Mon, 30 Mar 2026 18:57:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>, Conor
 Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Ivan Galkin <ivan.galkin@axis.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Michael Klein <michael@fossekall.de>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 devicetree@vger.kernel.org
Subject: Re: [net-next,PATCH v5 3/3] net: phy: realtek: Add property to
 enable SSC
Message-ID: <20260330185721.4b94ed30@kernel.org>
In-Reply-To: <20260326210704.58912-3-marek.vasut@mailbox.org>
References: <20260326210704.58912-1-marek.vasut@mailbox.org>
	<20260326210704.58912-3-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273436-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,wp.pl,lunn.ch,kernel.org,google.com,gmail.com,axis.com,fossekall.de,redhat.com,armlinux.org.uk,nxp.com];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2AAE636337E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 22:06:35 +0100 Marek Vasut wrote:
> +/* RTL8211F SSC settings */
> +#define RTL8211F_SSC_PAGE			0xc44
> +#define RTL8211F_SSC_RXC			0x13
> +#define RTL8211F_SSC_SYSCLK			0x17
> +#define RTL8211F_SSC_CLKOUT			0x19

> +	/* Unnamed registers from EMI improvement parameters application note 1.2 */
> +	ret = phy_write_paged(phydev, 0xd09, 0x10, 0xcf00);
> +	if (ret < 0) {
> +		dev_err(dev, "CLKOUT SSC initialization failed: %pe\n", ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	ret = phy_write(phydev, RTL8211F_SSC_CLKOUT, 0x38c3);
> +	if (ret < 0) {
> +		dev_err(dev, "CLKOUT SSC configuration failed: %pe\n", ERR_PTR(ret));
> +		return ret;
> +	}

AI flags that this, did you mean to write to the SSC_PAGE here?
-- 
pw-bot: cr

