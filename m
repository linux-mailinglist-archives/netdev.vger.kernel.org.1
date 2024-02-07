Return-Path: <netdev+bounces-69937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E808884D156
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7852CB2513F
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 18:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C2A82D97;
	Wed,  7 Feb 2024 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OSa5Fmkr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9D641C91;
	Wed,  7 Feb 2024 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331269; cv=none; b=HBUKsfMdIoP9xp9/JVqV4bkz/CNPR5uL+KmcddW+Qs0i0sqg7ayepAlDA3x0/cMolNt7bh2rDxnHGP//EDNPQ98qRyg+DKuquuKbSXGv5o1HgqkZECFDWgj4QWDPm+9If6ToprNA0ZzmEmT0aFla6VO/JZjhmqOcApgcPPy4oPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331269; c=relaxed/simple;
	bh=0Bcre0rC2pTtwW82tC2xqrqvK6yDzJC3IMXWhaGhheA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fy1P3paC4b5w4JoWEQFUoGBUL4utJxMFVGbaIJt/7aB3OolDaEF1MjojOOB/b1pocwa5FEbrIKi8ckcQJsUOq4hTIrOP3NSRe2iDK4kuswAcFHEV9HF43KnsVpdMl1Cjluj3oWweYJVFj19n+7Iok9ghjLlbhfWIPRKGaXa5Y9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OSa5Fmkr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NM96PRgp7Go5/u5ErschDZoCtLvUhRM5ifc/fsNb7PY=; b=OSa5FmkrdKlgn3giyTHmOti/ER
	oz0XB0MPja3MiuiEIGEGolz1YVKiNpeQ0jBICRFEznTxklusZOcJ10QRnaUDZYO6JOrSUe7AxE4G7
	FEDJeMOjohRUEkAhpbLzJSEKvFqazNq2kx8vqrKU6iE3VCss23XJ25+HyPWbDaY9w65M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXmqo-007FCD-Hj; Wed, 07 Feb 2024 19:40:50 +0100
Date: Wed, 7 Feb 2024 19:40:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: airoha,en8811h: Add
 en8811h serdes polarity
Message-ID: <dcfe74e4-6846-404c-b57c-d4ca34c75c26@lunn.ch>
References: <20240206194751.1901802-1-ericwouds@gmail.com>
 <20240206194751.1901802-2-ericwouds@gmail.com>
 <76f9aeed-9c8c-4bbf-98b5-98e9ee7dfff8@linaro.org>
 <f2b4009a-c5c3-4f86-9085-61ada4f2ab1e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2b4009a-c5c3-4f86-9085-61ada4f2ab1e@gmail.com>

> As for the compatible string, the PHY reports it's c45-id okay and
> phylink can find the driver with this id. Therefore I have left the
> compatible string out of the devicetree node of the phy and not
> specified it in the binding (also same as realtek,rtl82xx.yaml).

As you pointed out, the kernel does not require a compatible. So in
your board DT blob, you don't need it.

In the binding document, you can indicate a compatible can optionally
be used, and in the example its a good idea it actually use it, so
that the example gets checked by the tools.

     Andrew

