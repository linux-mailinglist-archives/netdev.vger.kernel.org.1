Return-Path: <netdev+bounces-119865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2146A95749A
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 21:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C042D1F21992
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 19:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282531DC47D;
	Mon, 19 Aug 2024 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XulFbR3m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC22B1DB45F;
	Mon, 19 Aug 2024 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096383; cv=none; b=AYlQkfGLv80VEQM/iGU8p6FmlSVxof7BHUROyworHiH0jj2W9rF0ZJWDZVMse3QyyFvWjbzSQ1jrzOh7riabGVxaUVaGb9XoixlunU2cHOq3AgnyvSDcitG9LjYO+ZYdAOU6418lrb4FvZ4+EJLWcqzcG3P/HnkMBn/f9CG+gS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096383; c=relaxed/simple;
	bh=Nvm/PgOp1CtTfrld3rrYgbfJrfZpStaSgqLXHx2UqMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaIZDzdSsGyr4T4EkfMkiQi7ZjV1lLFjC5jqFfz9zQi9m1xcWDLXSidqcFO02Nr0ZWkdDioQCW+wXa+v7Xd2pJtm2FWhDMz1+d7GJaIunrkxLpp49HiXZL6mxXn6yIqrARu7xaRyNbbcCJx8xrNgRwvW4gnRFuhTergGxBXFbeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XulFbR3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358B3C32782;
	Mon, 19 Aug 2024 19:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724096381;
	bh=Nvm/PgOp1CtTfrld3rrYgbfJrfZpStaSgqLXHx2UqMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XulFbR3mkxtGByoAg3Xfj7XL2pAwdpy2gCjkwHZFO8EEGXB5xgy9bXxOunlwGwL4D
	 3jxGeLaFosIAb5xYnILDYZLVVG3kxe/5L87/Wthx05mI9AjGSaHik2ahGHPLQq3dLE
	 hH0MqB+5i51jpELdJ2ETl/ALiTqrSRkFSNsCO0bMG5urroZQ50EELBsTFdZ4J6CfL+
	 oPvD6rntWuXnGO3MLQuGodHpuyCavK+wfHo+LU5J0M6uMY4VPsqAlI/8qPODQosGtT
	 0X2Vy+nf9uMlgDvRtvEV0FPeWKGMBI8P4AeqocgHiU1vjIfHzzh3Lwsao6ESA91O+f
	 9R9t9PAlShLww==
Date: Mon, 19 Aug 2024 14:39:39 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Johan Hovold <johan@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Daniel Kaehn <kaehndan@gmail.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 0/6] dt-bindings: add serial-peripheral-props.yaml
Message-ID: <20240819193939.GA2371766-robh@kernel.org>
References: <20240811-dt-bindings-serial-peripheral-props-v1-0-1dba258b7492@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811-dt-bindings-serial-peripheral-props-v1-0-1dba258b7492@linaro.org>

On Sun, Aug 11, 2024 at 08:17:03PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Add serial-peripheral-props.yaml for devices being connected over
> serial/UART.
> 
> Maybe the schema should be rather called serial-common-props.yaml? Or
> serial-device-common-props.yaml?
> 
> Dependencies/merging - Devicetree tree?
> =======================================
> Entire patchset should be taken via one tree, preferably Rob's
> Devicetree because of context/hunk dependencies and dependency on
> introduced serial-peripheral-props.yaml file.
> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (6):
>       dt-bindings: serial: add missing "additionalProperties" on child nodes
>       dt-bindings: serial: add common properties schema for UART children
>       dt-bindings: bluetooth: move Bluetooth bindings to dedicated directory
>       dt-bindings: gnss: reference serial-peripheral-props.yaml
>       dt-bindings: bluetooth: reference serial-peripheral-props.yaml
>       ASoC: dt-bindings: serial-midi: reference serial-peripheral-props.yaml
> 
>  .../devicetree/bindings/gnss/brcm,bcm4751.yaml     |  1 +
>  .../devicetree/bindings/gnss/gnss-common.yaml      |  5 ---
>  .../devicetree/bindings/gnss/mediatek.yaml         |  1 +
>  .../devicetree/bindings/gnss/sirfstar.yaml         |  1 +
>  .../devicetree/bindings/gnss/u-blox,neo-6m.yaml    |  1 +
>  .../brcm,bluetooth.yaml}                           | 33 +++++++++--------
>  .../marvell,88w8897.yaml}                          |  6 ++--
>  .../mediatek,bluetooth.txt}                        |  0
>  .../nokia,h4p-bluetooth.txt}                       |  0
>  .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |  4 +--
>  .../realtek,bluetooth.yaml}                        |  5 ++-
>  .../bindings/net/{ => bluetooth}/ti,bluetooth.yaml |  5 ++-
>  .../bindings/serial/serial-peripheral-props.yaml   | 41 ++++++++++++++++++++++
>  .../devicetree/bindings/serial/serial.yaml         | 24 ++-----------
>  .../devicetree/bindings/sound/serial-midi.yaml     |  3 ++
>  MAINTAINERS                                        |  2 +-
>  16 files changed, 80 insertions(+), 52 deletions(-)

Series applied, thanks.

Rob

