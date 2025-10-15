Return-Path: <netdev+bounces-229530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F15BDD9AC
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 11:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED2E24FD2B0
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDB030648C;
	Wed, 15 Oct 2025 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="KCbe4+6a"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8279C30B51C;
	Wed, 15 Oct 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519236; cv=none; b=m4aA8isODFeCsn6kwXRgEnK/ZG9AxTFT12RyMUbyt4uXHlRr60vqgd++RJ4OJXVV3aw6WB+tt9bet1dU0k2PYgSfS6hHHkANfFFbbbseBiima5cRgUrprU9E3UHdt9aRf2Lls+PtjXPH+/pYy9lAg6mveJjko5amBoENPi4EQwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519236; c=relaxed/simple;
	bh=NCFnMBWLauQR2xMYWWI8vdjV+DkNXQXZjIrUpco/y0o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E275eTj50bIZNqqeyifBWozDSO5u/HRFyiBclIK0o8UVuV581GrtO634YjtUfJ7TlHZimlQYTL3vqR2lBg2nMR5Zl2GUnHs9+MDaSa19JoKn6od1jOsZVMghpS5VU47Meje/rf1B7O+Zuvc8T8SyoldtTjepvnVr2NLCrrp2ixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=KCbe4+6a; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 39693A06F3;
	Wed, 15 Oct 2025 11:07:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-type:content-type:date:from:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=mail; bh=jAfNhsVyf6LpNsHnnq4sFD4oX2T6dYNqq0rI5BbRCk8=; b=
	KCbe4+6arJ03OkeQdd2gfGVKCpViPJBzGDDW+WlSLKRJJmRO8GXeOJUrh5CZkKNh
	dQap9RdG4o4R/VPsnrWUbhwtJvarnbAoGR9cnuW1VBYX2KDxQECT0ITAi/iGRdEy
	SUtd9ZcfFdfBS5uLv8IiJNxQuxI8NQo9mTEw9dADk8KfQeyUw/aSS8xb7vWfHUdp
	rwIDHdLaKFa7O6TixjRBo/yMWvAMuwXe/l/S6vRgwUM4+aNLC935HkbyxdC8iqsZ
	zzmKKFEAgWyw8hpA5gIuYnx4MtF3BQuD6pzpk4aX3tVLunwxCLclUJhDzPA8G9n4
	IGLSyNVYI8HjIk2oaiB5EntLqJ8hvlIPn36pHrxKllyWNUMNlQGuEXPFP4jAMMuZ
	NLz5VGxIWIWIlEJviQnynzjFeLBkrLf299ROlzZmFQ/29b77DjQbxpmkzNiT2qeV
	DwU446NtcfzSViZoBJZymcvhaftbjG8egF0WXardE5ILIgm3ziU3KjOgx8O/Mb1Q
	kQ1p10R9F6MtsWrb7J/0dBY6vXxae7fa3IrExiI4kf5gZzSnsfPIpBm7M7EqquJ0
	/DAIrmj9cGb6IuY9DZ/2vpHZegW+32OsOxoCgz1i1LbhJsKJCn0C3PAW2kCizn/L
	BxfE+1d5UIgboJ0/jYqp5BNJ7+uRQeEOU1UUKjjVcT8=
Date: Wed, 15 Oct 2025 11:07:03 +0200
From: Buday Csaba <buday.csaba@prolan.hu>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] net: mdio: reset PHY before attempting to access
 registers in fwnode_mdiobus_register_phy
Message-ID: <aO9kN_UgU6RpOYn2@debianbuilder>
References: <20251013135557.62949-1-buday.csaba@prolan.hu>
 <20251013135557.62949-2-buday.csaba@prolan.hu>
 <e4dbb9e0-4447-485a-8b64-911c6a3d0a29@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e4dbb9e0-4447-485a-8b64-911c6a3d0a29@bootlin.com>
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1760519223;VERSION=8000;MC=2749234066;ID=552009;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F647566

On Mon, Oct 13, 2025 at 04:31:10PM +0200, Maxime Chevallier wrote:
> Hi,
> 
> On 13/10/2025 15:55, Buday Csaba wrote:
> > When the ID of an ethernet PHY is not provided by the 'compatible'
> > string in the device tree, its actual ID is read via the MDIO bus.
> > For some PHYs this could be unsafe, since a hard reset may be
> > necessary to safely access the MDIO registers.
> > This patch makes it possible to hard-reset an ethernet PHY before
> > attempting to read the ID, via a new device tree property, called:
> > `reset-phy-before-probe`.
> > 
> > There were previous attempts to implement such functionality, I
> > tried to collect a few of these (see links).
> > 
> > Link: https://lore.kernel.org/lkml/1499346330-12166-2-git-send-email-richard.leitner@skidata.com/
> > Link: https://lore.kernel.org/all/20230405-net-next-topic-net-phy-reset-v1-0-7e5329f08002@pengutronix.de/
> > Link: https://lore.kernel.org/netdev/20250709133222.48802-4-buday.csaba@prolan.hu/
> > Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> 
> This should probably be accompanied by a DT binding update,
> with some justification that this is indeed HW description
> and not OS confguration.
> 

I have the corresponding patch ready, I just wanted this to be accepted
first. My description was to be:
  "When the PHY ID is not provided with the 'compatible' string,
   reset the PHY before attempting to read its ID over MDIO."

> At least the use of the term "probe" in the property makes this
> sound like OS configuration, maybe something like :
>  "phy-id-needs-reset" ?
> 
> Maxime
> 
> 

Okay, I will change that accordingly. Maybe "phy-id-read-needs-reset"?
A bit longer, but more self-explaining.

Best regards,
Csaba


