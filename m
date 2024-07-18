Return-Path: <netdev+bounces-111981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D5D9345DC
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 03:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905641F23803
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 01:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD86110A;
	Thu, 18 Jul 2024 01:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CFFBfeqh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE1310F2;
	Thu, 18 Jul 2024 01:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721266594; cv=none; b=T8zXrZc8RdhsXUzuWWg74fDFyIF1jFavLoQB18oy4RjpvpTDsgjY+a4ekAbOGfI/gFLjVzCeXNCXQTRC+g+flCvyHF3mn1d7szeN2tREZVFfDkS9QxqYPiWAA1jKtoRBBeSYxKIGoOllD3LDrx93Dq9sTVTnscZN77SBjBS3Dd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721266594; c=relaxed/simple;
	bh=rAsWtQXS+qM9uvcRnh/reBRB7lEyG2hOSWFEc4blHqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kp0nx1DT+WBvPdG5ZnsCNZR/+8uDovAcjiq6TByMaENZRHF1QkM5C69Ba9Jp/7eUkzwXuAEmlmlnghA3NE0LKFhhTzk72mSkVi2VQuB+goZla36k7FZYrlPtSPIas5GmMDYOIMcnalgJoCQ1Aow5pgriERkOs89dFQBTC1Nd4tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CFFBfeqh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XocxSTpJ25YAEjXThF5g485FEKCzEW3wFCztsb0eDJE=; b=CFFBfeqh7TRrHPA96GQx05dodn
	njXJ/n5uCjkecfWLZMSOCW46eO/Yw+iO+7W9sJktZBp711zw6wCG3pBSVdgvcHxOxuzOqkxVy+ZXT
	cZTBMG9uLUKE5WGLApDw67MibudQKlSG6q6cldYGGIaG0oD+mTIXUJX/6FlFtonI7m7I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sUG4I-002kVG-1J; Thu, 18 Jul 2024 03:36:26 +0200
Date: Thu, 18 Jul 2024 03:36:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] dt-bindings: net: dsa: vsc73xx: add
 {rx,tx}-internal-delay-ps
Message-ID: <e2de19f9-f565-41e3-b277-8d2b3f4d3984@lunn.ch>
References: <20240717212732.1775267-1-paweldembicki@gmail.com>
 <20240717212732.1775267-2-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717212732.1775267-2-paweldembicki@gmail.com>

On Wed, Jul 17, 2024 at 11:27:33PM +0200, Pawel Dembicki wrote:
> Add a schema validator to vitesse,vsc73xx.yaml for MAC-level RGMII delays
> in the CPU port. Additionally, valid values for VSC73XX were defined,
> and a common definition for the RX and TX valid range was created.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

