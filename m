Return-Path: <netdev+bounces-285310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBvWFE2G/GkaRAAAu9opvQ
	(envelope-from <netdev+bounces-285310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:32:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B631B4E83A5
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28906302DE19
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 12:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453ED3F0A9F;
	Thu,  7 May 2026 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Wva/me34"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375A03EE1FD;
	Thu,  7 May 2026 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157100; cv=none; b=t777SRi2fR9hCZgPhUh7SmDhCCRomr0Vkbn7ClbiWcBQz74b0R0mATFkHb2vsBCLKr61yE7dFwZ0fLr+0cFkcn7GlyvlMsKnxjWtiJpLQsKXGTIQdrieGFfgYiwqNfWTtZuIMzQDgpBjPDvMstYlKXRke1aqwKBan+Gji/kOuVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157100; c=relaxed/simple;
	bh=3Yt6JhHzchpAW4Vh99X8/iK/VL8KAYS7pJqOoMyR7Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXA2bUl3gwj6gTgF/k8DPerTd6F5fgU619OONi/teZ7cS+GL8O5n+TNR8tyG/pzUuo/Evm4a9ktR3tX4aqueNsx6zNJrX+7GrvkeIMt3jH40EHXodmWzaoit5CZ97XbxxhyqaFyLAqdeJHknem0Tb4JPvBxq6Fr7uWzSdXqq2Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Wva/me34; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g8iedydIV97eBrioDXzPHVBkEBfHLmzG2Io0Mm7NzC0=; b=Wva/me34PHMLuDTp7KeapU9q9+
	/PQGq1PrUQgsCX84K14I9WF0zM4SL3O0hQJ3Rg7/n7CtdguPvQPzOBH1qc/VGwzF43XqYxiPLjRPL
	3cDYtnxcH64FJQylmq5jz9/DbOs5J2W0WsZwHmtdXBG/PM1/QzmjmnW2fj/XdUsixnQA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKxsx-001oIF-Ue; Thu, 07 May 2026 14:31:23 +0200
Date: Thu, 7 May 2026 14:31:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [net-next v3 0/5] Add StarFive jhb100 soc SGMII GMAC support
Message-ID: <dcbb2e54-34b6-4257-90d9-a9223d1c4a70@lunn.ch>
References: <20260507094115.8355-1-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507094115.8355-1-minda.chen@starfivetech.com>
X-Rspamd-Queue-Id: B631B4E83A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org,st-md-mailman.stormreply.com];
	TAGGED_FROM(0.00)[bounces-285310-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 05:41:10PM +0800, Minda Chen wrote:
> jhb100 is a Starfive new RISC-V SoC for datacenter BMC (BaseBoard
> Managent Controller). Similar with Aspeed 27x0.
> 
> The jhb100 minimal system upstream is in progress:
> https://patchwork.kernel.org/project/linux-riscv/cover/20260403054945.467700-1-changhuang.liang@starfivetech.com/
> 
> jhb100 GMAC still using designware GMAC core like JH7100 and JH7110,
> and contains 2 SGMII interfaces, 1 RGMII/RMII interface, 1 RMII
> interface. In JH7100/JH7110 dwmac-starfive.c have supported RGMII/RMII
> interface. So require to add SGMII support to dwmac-starfive.c for JHB100.
> 
> SGMII serdes PHY has been integrated in JHB100 and do not have driver
> setting.
> 
> In JHB100 EVB board, SGMII connect with motorcomm YT8531s external PHY
> and support RJ45 ethernet port.
> 
> The patch base in 7.1-rc2

For networking, please base on net-next/main.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

