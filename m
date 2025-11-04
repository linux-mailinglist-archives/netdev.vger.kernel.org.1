Return-Path: <netdev+bounces-235392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C237EC2FB74
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 08:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75ABF3B4F13
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 07:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6A230F93E;
	Tue,  4 Nov 2025 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7+mUFFi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4530F548;
	Tue,  4 Nov 2025 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762242525; cv=none; b=EJEX/+cCQM0793oAA0FDqZEZkHbVzAh7/w9L3yLEA+xhPG1AYKV9/D/db1V7cenAdYnbxKyBy9L67YzqIArPyYFTosDmOJRiD8/AYhKo+l6IM0s7gpZYhR7WZljG41juJJhJBq/1Ifwy7iFYjBaE3TR+LcCK46ucuZCIXNw0/nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762242525; c=relaxed/simple;
	bh=j2BD1/13KQrkg2lt9kfG0AaMG8gstt3qGbVDlQ44mHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qw3waZfYfy4nCfUpMLgzcn0XCz80bZoGS6cmbEkF6hKvM5ov4i97ORRIbHjxd4QbSjxUPuLl+zWf2k5eYXp5TW0GPRUY52xHArP4mwvmrH94qelr3p7rO8wH2bwUYyn60TIqYZnh61NiFV6PiUydZlnD9Mo9y3bEk0fj4xmkByc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7+mUFFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FE8C4CEF8;
	Tue,  4 Nov 2025 07:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762242525;
	bh=j2BD1/13KQrkg2lt9kfG0AaMG8gstt3qGbVDlQ44mHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7+mUFFin7fum4L/NPHnqTu2vH81vcAnjqjJqhd/tM3JyiM1pnNDUs30Aw6ELXVX8
	 1ZnPWpoWsATSQ2p+OJH/N3bOIODwegXmx/WWt/EJWpdTvBJZDke0PFLv8xxVe145cw
	 kZIxe2HBzEzhH6w/pkLBzMn3KhoSPOadse5csTdAXhDN+sx2NOpa1p1AmjzuKY+OtC
	 dfP9/AG0vhTee95sNryx97ItoWuE2HRHYUU9MympnaS0fYojfYubrLs/qunH8OYjyW
	 okWKiXzfE4mpc+MSIIwDR1EEwECCj4pACdEWu1vIjb4Srgw7ZuxiyKPJ/bg0ry9fhW
	 ml3ZG7xk7KNQA==
Date: Tue, 4 Nov 2025 08:48:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andreas Schirm <andreas.schirm@siemens.com>, Lukas Stockmann <lukas.stockmann@siemens.com>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Peter Christen <peter.christen@siemens.com>, 
	Avinash Jayaraman <ajayaraman@maxlinear.com>, Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>, 
	Juraj Povazanec <jpovazanec@maxlinear.com>, "Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>, 
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>, "Livia M. Rosu" <lrosu@maxlinear.com>, 
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v7 10/12] dt-bindings: net: dsa: lantiq,gswip:
 add support for MaxLinear GSW1xx switches
Message-ID: <20251104-humongous-shaggy-dormouse-3edab9@kuoka>
References: <cover.1762170107.git.daniel@makrotopia.org>
 <fc96f1dedb2b418a63e69960356dde7f6eb86424.1762170107.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc96f1dedb2b418a63e69960356dde7f6eb86424.1762170107.git.daniel@makrotopia.org>

On Mon, Nov 03, 2025 at 12:20:12PM +0000, Daniel Golle wrote:
> Extend the Lantiq GSWIP device tree binding to also cover MaxLinear
> GSW1xx switches which are based on the same hardware IP but connected
> via MDIO instead of being memory-mapped.
> 
> Add compatible strings for MaxLinear GSW120, GSW125, GSW140, GSW141,
> and GSW145 switches and adjust the schema to handle the different
> connection methods with conditional properties.
> 
> Add MaxLinear GSW125 example showing MDIO-connected configuration.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v7:
>  * drop the addition of 'reg-names' to the list of required properties
>    and also don't add it to the existing example

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


