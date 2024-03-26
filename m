Return-Path: <netdev+bounces-82226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D86688CC21
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 19:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D450F1F8053E
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 18:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD8A127B65;
	Tue, 26 Mar 2024 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0ZdcOjmX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936101AAD3;
	Tue, 26 Mar 2024 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478250; cv=none; b=bW6I5TXHxHyrKbHlzLTZUJMYCx1tmhs9twqAMHrjVdwcgIYNyVObL9d4MxMc0qr2qn+sRIlHPTjV6fQwdhrCnG+YMcE6cJTx8C7TwExu1WHzt4tF3t/CVPiLMXM0eMKcmOPS6P6Is4W7ztzTK7NdGOj0qtsSJnyPfdKFKYW81xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478250; c=relaxed/simple;
	bh=jNcu09PwbpgDUfxSX3KWA/q7a2HQ9bVBGdbsLOmf3as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvdWRbqbZeFDjhtTu4L9MHAveNuJC1pR1gka4IjbmZpJWDYoiO7tLhTPzVrxdcd2m1wXH9dmxVjaVl2sX1oC+bGUWPPbD/k2ofXDc4XOU2SzUUn9x+73BY7xytlhkceM9HqnQxPePMdXRXSyh8XdXJOl3gszoqDDUfbqzV77uQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0ZdcOjmX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5CWKw5nw52Kwv72yE55VlkLBHkrzgJglbFq0H0xGydk=; b=0ZdcOjmXPnPJJ3N8XWJb+DGaAY
	1dNrhiqjnWADCBCHUVSvFcu89kCTkBB0HT8wngdFziG9WaUsb1BCOqo5nDu99/203kIm4ycFZT7Gf
	kvpOdyQJslqeycJY8CSbqWegSakTjmyes7DDmOIxsKAbu1rO9tToDXFeQpMEPO/NYZZM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rpBfS-00BJkD-RM; Tue, 26 Mar 2024 19:37:02 +0100
Date: Tue, 26 Mar 2024 19:37:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
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
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 net-next 1/2] dt-bindings: net: airoha,en8811h: Add
 en8811h
Message-ID: <09b42035-2aec-47db-9a94-123bfb946d30@lunn.ch>
References: <20240326162305.303598-1-ericwouds@gmail.com>
 <20240326162305.303598-2-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326162305.303598-2-ericwouds@gmail.com>

On Tue, Mar 26, 2024 at 05:23:04PM +0100, Eric Woudstra wrote:
> Add the Airoha EN8811H 2.5 Gigabit PHY.
> 
> The en8811h phy can be set with serdes polarity reversed on rx and/or tx.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

