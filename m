Return-Path: <netdev+bounces-78505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294DC87564F
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 19:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA601F21F10
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 18:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609D5134CDB;
	Thu,  7 Mar 2024 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QgArt0a/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666A61332AA;
	Thu,  7 Mar 2024 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837275; cv=none; b=Q3vvb3l/YaWIDrXXkwlR7rTe7WcE46oG5edsey7iVpZje8UckQp/R2s4bPVYkOE8jPhdRZPLKv+UVCdyYNR2UNWlqc2nrcmo9Wlvj3le7/5V58Fjx6A81zpQfo7+q4iuGJxgym/wOz/hfiH8n9y1/s+739miWkjEuEzhwsd2pFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837275; c=relaxed/simple;
	bh=2yTk4g8eRLfVAwCV2yoGYOLXIl+/IN6DOIjhwdFiC5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9OFC4zCqZ8TrMdM4VwZsQkCnx1oS/mXTtFfwAonMUWPJN1+GNVxpx4J1+ksZH6NvgCGIuBIxSYPTZJRqorh/Qc4bzxy37v5P4UK7Hfi2jIGZYkCnQ27EeMMRce3cFDuwY67q90brpVm+vp7a4VQ0n9QIhJbffCnfbilAGiYowA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QgArt0a/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5BupWcwfKnG1ptOMxMq4ELMjK/fS1Lj61MqffJweP2Y=; b=QgArt0a/X7mUfaO4eTf0hOnqak
	QLKBytPQv1YOu9SODCXv+IoCXbbFjC7bX0F1UzhdyPIbO1uaN/a+WNVJ4qDSAPSb80Pwtxmns576r
	N0LJPfeJzMJ++4Rn8puST4aAZOge965zk4PmdKbl9j/oXyltnXa9iOn6csJMr5kXtfzo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1riIma-009btP-Of; Thu, 07 Mar 2024 19:47:56 +0100
Date: Thu, 7 Mar 2024 19:47:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
Message-ID: <4d6dfb91-93bc-49a1-bbfb-675ce9e3673c@lunn.ch>
References: <20240302183835.136036-1-ericwouds@gmail.com>
 <20240302183835.136036-3-ericwouds@gmail.com>
 <89f237e0-75d4-4690-9d43-903e087e4f46@lunn.ch>
 <b27e44db-d9c5-49f0-8b81-2f55cfaacb4d@gmail.com>
 <99541533-625e-4ffb-b980-b2bcd016cfeb@lunn.ch>
 <6e6e408d-3dbb-4e80-ae27-d3aaafb34b06@gmail.com>
 <Zen7-M2uAaXH8ucj@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zen7-M2uAaXH8ucj@makrotopia.org>

> > So far, I only know of the BananaPi-R3mini, which I am using. It has 2GB
> > of ram. It should be ok.
> 
> Most normal consumer devices don't have 2 GiB like the R3 mini.
> However, it's safe to assume that boards which come with EN8811H will
> also come with 256 MiB of RAM or more, and keeping 144kiB in RAM
> doesn't hurt too much imho.

Agreed.

	Andrew

