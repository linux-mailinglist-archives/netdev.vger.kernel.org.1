Return-Path: <netdev+bounces-219461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDDFB41622
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0BCC548694
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 07:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E162D94BC;
	Wed,  3 Sep 2025 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfQ/aKQR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1962D7DF1;
	Wed,  3 Sep 2025 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883940; cv=none; b=TB0y3cxfXPgzEQzAivMBFztzyu27puIpkBsXwpRAelpk4nfpycIZiz7b8B+BS1GjDO/o/ITmZ1NAOFnL3b8Ee5LOQrgbIQuJ6oqTFvN0DUU9rOQ5JVp/4uUZVrkAVhtAKvSk9Fx72Q+euBah2gQTC+SkgKbPKX9QMOPSQ5UjHjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883940; c=relaxed/simple;
	bh=ZIuFqgAiUGNMdLEb14nhjqW/5x7OSbzlYnguRxrnXtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oa9ZTIP7+X+PX/K0U6nOvUKNsW/JmRb5FB0BsqkX0lbUJo/2zkSe6mbkHARs/XBUd8ZpL2BBOHKEQQEjeJ4x2AuK+kHufNJutxmLstt5HZEG8AG0PsIaF7oniKmGH8cdigqpMjAKxPuHVFYIlQXXOjqnLOt9wo9oDP0W2kxOCRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfQ/aKQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB547C4CEF0;
	Wed,  3 Sep 2025 07:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756883939;
	bh=ZIuFqgAiUGNMdLEb14nhjqW/5x7OSbzlYnguRxrnXtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FfQ/aKQRPHWLa2/xC6SOkrUTiSOmO2665c0RuiJmNm//8eUnqCAtOypxhPc+q4ilx
	 jJ6JpROOVvtkogaWrZdCZNb9usGXQMtmENumkgNTjX9/A61z9Vsie0majUkdxSVEos
	 hLjKhz2eLeQppAZn65yVNmwoXBr6Ttyp9VyXEX8DIM/10sIePjPEZMQeitHi38kVIc
	 0/GCj9G9aVymPwg+9ujDC4IWnoyl4BKjLxVBTu24MXFGfeGA2tenyhGx+ZXLm646ZI
	 4y2Rcgx4dHiT+PMNxdvu8NKaqYgtrX1k5v/hPmOy8VhRn0JA4eKu77L0qjtQd65hJ3
	 /HvDxSMOWHKxw==
Date: Wed, 3 Sep 2025 09:18:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Xin Guo <guoxin09@huawei.com>, Lei Wei <quic_leiwei@quicinc.com>, Lee Trager <lee@trager.us>, 
	Michael Ellerman <mpe@ellerman.id.au>, Fan Gong <gongfan1@huawei.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Lukas Bulwahn <lukas.bulwahn@redhat.com>, Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
	Suman Anna <s-anna@ti.com>, Tero Kristo <kristo@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com, 
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2 1/8] dt-bindings: net: ti,rpmsg-eth: Add DT
 binding for RPMSG ETH
Message-ID: <20250903-vehement-outrageous-corgi-ddcc6b@kuoka>
References: <20250902090746.3221225-1-danishanwar@ti.com>
 <20250902090746.3221225-2-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902090746.3221225-2-danishanwar@ti.com>

On Tue, Sep 02, 2025 at 02:37:39PM +0530, MD Danish Anwar wrote:
> Add device tree binding documentation for Texas Instruments RPMsg Ethernet
> channels. This binding describes the shared memory communication interface
> between host processor and a remote processor for Ethernet packet exchange.
> 
> The binding defines the required 'memory-region' property that references

Describe the hardware, not "this binding".

A nit, subject: drop second/last, redundant "DT binding". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Best regards,
Krzysztof


