Return-Path: <netdev+bounces-136160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5449A0A1A
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 14:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 395D8B257C2
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 12:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5E12076B9;
	Wed, 16 Oct 2024 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ymxi+A97"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86321E492;
	Wed, 16 Oct 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082378; cv=none; b=ATmUNSWLbDW0RL9IJ7oz6UnvmPTyMq2u+Blhjd9dvSJgKIb5KoHUnkpiCY+kMVJdFNIti4ALmKfanIovNGKD82fIAPOEfIPG2R+spCiuSeOdARVy382m3ZDSfBqVlXK558XCypQnVf+eCc4We7fwDEXiB+MDwOeJFByXy4hpRk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082378; c=relaxed/simple;
	bh=ugoRsDfMVyo4E8ISN3DMv8gYM7ZDPD/EG+fXcBwdtBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+iMaa2bgpkbt9nMoee8qHYD4talsRViLpDQ5asnBPAVb7PkVrVcqWCAuySP50zpx1Znn4ebxLQyymgLr80O+n3GUmhA4ImPHO6itD45Grq2sI9T3S76B864EsRlqiATNAE6CX/XxGH2yTIa7tCMEo4A9LdwddWpVJHs7e9KnJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ymxi+A97; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=EGuL05E5OgX9qJAVFH4riiM8Kfnnqg10KB5wvTH+BpY=; b=Ym
	xi+A97BfqvN8zlIWrNL+86QjYbn76zG3KhIbO77aY8t8/ONnjQGG9yL4+aWfXXD03iZIcpG4b2Zyx
	TODWgkg9B+01eqpIfKZBKMrEAaeU0oFcqQn1p+H5cbgSKA45QN6oIE8+m9D5JCHzT6pKvqUnN2/JS
	foHQaqOaheQ5k+Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t13JJ-00A9Qc-LY; Wed, 16 Oct 2024 14:39:29 +0200
Date: Wed, 16 Oct 2024 14:39:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Richard Cochran <richardcochran@gmail.com>, kernel@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Jianguo Zhang <jianguo.zhang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Hsuan-Yu Lin <shane.lin@canonical.com>,
	Pablo Sun <pablo.sun@mediatek.com>,
	fanyi zhang <fanyi.zhang@mediatek.com>
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8390-genio-700-evk: Enable
 ethernet
Message-ID: <f7fb240c-064c-4ca9-9126-73937aca4705@lunn.ch>
References: <20241015-genio700-eth-v1-0-16a1c9738cf4@collabora.com>
 <20241015-genio700-eth-v1-2-16a1c9738cf4@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241015-genio700-eth-v1-2-16a1c9738cf4@collabora.com>

On Tue, Oct 15, 2024 at 02:15:02PM -0400, Nícolas F. R. A. Prado wrote:
> Enable ethernet on the Genio 700 EVK board. It has been tested to work
> with speeds up to 1000Gbps.

1000Gbps? NVIDIA needs to watch out.

	Andrew

