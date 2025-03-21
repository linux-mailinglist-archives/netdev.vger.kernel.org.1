Return-Path: <netdev+bounces-176726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F39A6BA5F
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 13:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552D61B60147
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 12:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5E9225797;
	Fri, 21 Mar 2025 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ChM0ba5h"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D7022577C
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559154; cv=none; b=iY3+YgKXWYvj272+ZniuT9lJwTsKk456pfXkhMPsL99ueFL5I7V1vZYAscdUvnX3Lc5wRC50Y5mw+iMT7bjyTOomKVLkz32AZpFYg/M6oVs8Seqzuctvc+iRV69et1lXWZ01Nlu4bl0yxS96MlwdTlF751rrtKxcdqKLy10G/dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559154; c=relaxed/simple;
	bh=SHPfNFoZ8/JNAQ6RwicuNBHCxwhblWS+se3iqdFOWOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ef+fmiPWjFHPonj++Yho/upBDtEp9HQSu4+PPwOk/dAMgjn9g1m9/zVXfXNbMoCMtxdujMB22+H7aflYDF3Mc+/Aurn9AAE3T1/gmlzaegfOhJVVklFkVs9knyclak0n57HCYWE2sU+bi8gnc463BmCe7C0WSCSTfkhlicoxadM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ChM0ba5h; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XXh3scEMJyAf6AyxxdJ+/uOwG0ISdhdGYd05tR7C3A0=; b=ChM0ba5h86tPsy8qitTYOXIyTu
	/LO1N+LwXdAeNK1IvNRldG1dnOiR++cM1bEBCM4oFTB52ccwD6L2HP6mBVqxMfzPKev2y0qe7U7Xu
	5nSLitcyEZpzUZ0BjBkI6WF+Ztbm/9LSv0/I1Cj8DypdH3VSx9ZopWQ/D0BD8SPIYhm4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tvbEZ-006ZO9-VQ; Fri, 21 Mar 2025 13:12:19 +0100
Date: Fri, 21 Mar 2025 13:12:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, maxime.chevallier@bootlin.com,
	marcin.s.wojtas@gmail.com, linux@armlinux.org.uk,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] net: mvpp2: Prevent parser TCAM memory corruption
Message-ID: <3f2f66ae-b1ac-4c87-9215-c1b6949d62c4@lunn.ch>
References: <20250321090510.2914252-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321090510.2914252-1-tobias@waldekranz.com>

> +static int mvpp2_prs_init_from_hw_unlocked(struct mvpp2 *priv,
> +					   struct mvpp2_prs_entry *pe, int tid)
>  {
>  	int i;
>  

This is called from quite a few places, and the locking is not always
obvious. Maybe add

__must_hold(&priv->prs_spinlock)

so sparse can verify the call paths ?

	Andrew

