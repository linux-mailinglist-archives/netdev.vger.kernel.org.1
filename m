Return-Path: <netdev+bounces-143270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 126419C1C43
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 12:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92AC3B21E39
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 11:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA9A1E47A1;
	Fri,  8 Nov 2024 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QUgJbql/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4191E22FA;
	Fri,  8 Nov 2024 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731065838; cv=none; b=NnudPMUky9XQZ5hwnBfJPN8wCi/SwvLlvr5jH6r+usu1UbZB2rRn5bdv24M/wxG0Z5kTVvoz2jZBc3mdpUYV30aH8rtXwYIW7Ur3OshdQbscA4/O1Zvr9qdcHeuNz+qv4dx6/gTLfotiHJtWispZ5fziXJytt0r5+J8Urkq2ZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731065838; c=relaxed/simple;
	bh=9q9uVvLqHBGdEXJFJ+lqyHUhiXg3rvlAytAtHyinnIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Orr3VQrmOwMN7N6P1ciYTyQHmu3xK6QkMYNnSGx4ENOZv9YPZ2bGefPO+0aqSx4jWn8wqo3Q5lIiibaXkIJh0sVo+FGmciJoHpBIAWRoB0jymwZtyjSuAbFTBl1gwqB/8VxcsuST3hTGVs5ydATZbQDUzT5lipzR9CC+9EpOjmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QUgJbql/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EejnXOL6AJ8kMqdm0i2xcZanHtQNUcxhRjUP4k55h+k=; b=QUgJbql/k5OgkEBg8SmAJYS29T
	B6mTbk9y3xIYzklSnufSDRl0yZiHr+R5OIEdtAJm8KNe5foj8vcDyTX/h557sS+7qO1mAU9OU1yR+
	AYjwEZlkYqTwgPrAbko+oLzaPb4AOSGh0wMGjZhgqLOIG0QWqJ/Piq1Y/i0PtHWiUNLSaBYP1MqJG
	GOdYK0cPvk0/jOxShOwMoUIknQuS+sS5W52CY5BrkCWjIM6GQMiAnD+gd6keaTdCx+jwgsvn3+4d3
	DW2ZtnZAW16GnVH+uEOAAg+b5j0P4MGT8A5rIo+VMZrAYYXQoKUO0LyC/atIlemBcbxM5R852Mr4e
	TTDRlM9A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56186)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t9NIW-000533-2q;
	Fri, 08 Nov 2024 11:37:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t9NIU-0002Ez-2Z;
	Fri, 08 Nov 2024 11:37:02 +0000
Date: Fri, 8 Nov 2024 11:37:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Lei Wei <quic_leiwei@quicinc.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com,
	quic_pavir@quicinc.com, quic_linchen@quicinc.com,
	quic_luoj@quicinc.com, srinivas.kandagatla@linaro.org,
	bartosz.golaszewski@linaro.org, vsmuthu@qti.qualcomm.com,
	john@phrozen.org
Subject: Re: [PATCH net-next 3/5] net: pcs: qcom-ipq: Add PCS create and
 phylink operations for IPQ9574
Message-ID: <Zy333s8o77qE5F_-@shell.armlinux.org.uk>
References: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
 <20241101-ipq_pcs_rc1-v1-3-fdef575620cf@quicinc.com>
 <d7782a5e-2f67-4f62-a594-0f52144a368f@lunn.ch>
 <9b3a4f00-59f2-48d1-8916-c7d7d65df063@quicinc.com>
 <a0826aa8-703c-448d-8849-47808f847774@lunn.ch>
 <9b7def00-e900-4c5e-ba95-671bd1ef9240@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b7def00-e900-4c5e-ba95-671bd1ef9240@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 08, 2024 at 07:31:31PM +0800, Lei Wei wrote:
> On 11/6/2024 11:43 AM, Andrew Lunn wrote:
> > On Wed, Nov 06, 2024 at 11:16:37AM +0800, Lei Wei wrote:
> > > On 11/1/2024 9:21 PM, Andrew Lunn wrote:
> > > > How does Qualcomm SGMII AN mode differ from Cisco SGMII AN mode?
> > > 
> > > Qualcomm SGMII AN mode extends Cisco SGMII spec Revision 1.8 by adding pause
> > > bit support in the SGMII word format. It re-uses two of the reserved bits
> > > 1..9 for this purpose. The PCS supports both Qualcomm SGMII AN and Cisco
> > > SGMII AN modes.
> > 
> > Is Qualcomm SGMII AN actually needed? I assume it only works against a
> > Qualcomm PHY? What interoperability testing have you do against
> > non-Qualcomm PHYs?
> 
> I agree that using Cisco SGMII AN mode as default is more appropriate,
> since is more commonly used with PHYs. I will make this change.
> 
> Qualcomm SGMII AN is an extension of top of Cisco SGMII AN (only
> pause bits difference). So it is expected to be compatible with
> non-Qualcomm PHYs which use Cisco SGMII AN.

I believe Marvell have similar extensions.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

