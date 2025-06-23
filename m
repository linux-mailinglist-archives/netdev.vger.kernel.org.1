Return-Path: <netdev+bounces-200145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5379AE3628
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 08:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973A81706E0
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 06:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E701E0DE8;
	Mon, 23 Jun 2025 06:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=murena.io header.i=@murena.io header.b="ip5sLEiB"
X-Original-To: netdev@vger.kernel.org
Received: from mail2.ecloud.global (mail2.ecloud.global [135.181.6.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D26B78F51;
	Mon, 23 Jun 2025 06:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=135.181.6.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661284; cv=pass; b=A8KeBfuCxWxBsQl/I/srW7LKkIKzHI53dSxPrwjV27Yu26KttPYGvsdhiCygylLqAtnyVgsJtKyMP2DrmdFzqz0WPo67IDIScQiRxfWDe7wFMCGb5iBHlP3hZideHh8DtVAI/JOmO+D2i6NfzTz72D+P9x78c0j6pSEZDFT25dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661284; c=relaxed/simple;
	bh=0j/Z5yh5tbFiw8rk0QBBfNVRu8U4mrVCE94WwPQ4NYw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=te/wElwKpboR7v6KYX/hZ1V1+sK3yTVJSSg6puyeq5J6QiEBjWjr/u4516UrbXBaHhlo3A6ISTZyqzWa/u1rdVOw5Y4QzVZv4aG6atT6oZDvCxZCDmhJRECG6ozkKurCJ8xpn/kz0gbVmOq+ygWmPeBsqFjc8UWUmnSdm5kXtfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=murena.io; spf=pass smtp.mailfrom=murena.io; dkim=pass (1024-bit key) header.d=murena.io header.i=@murena.io header.b=ip5sLEiB; arc=pass smtp.client-ip=135.181.6.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=murena.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murena.io
Received: from authenticated-user (mail2.ecloud.global [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail2.ecloud.global (Postfix) with ESMTPSA id 297857209A4;
	Mon, 23 Jun 2025 06:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io; s=mail2;
	t=1750660838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLgpNtx/boIApBv5pSWc//bswQhEsFbXQypbXTIeykY=;
	b=ip5sLEiBUhLNEb7dQe1Iz9dBtnXg4R38RsViRxUSbeXJzoioSdD6Ex6VQv3l53AKvBcBCU
	iMetLjvnRLSXxbczpkWTZwWfYOyL5JO/pn0M+AVhtOZg20Ac8ba/9F6BfFK3HA7Xl+AOTm
	1E5k+po1T1Qm5/VSUdFSXQiZz8nJhoc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io;
	s=mail2; t=1750660838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLgpNtx/boIApBv5pSWc//bswQhEsFbXQypbXTIeykY=;
	b=c+kjGhqvGy47p2nqRb2Oa1q399S8ukOiSgu404gkJiJ7WFTR0x8CSs0fryDoQau4WJXwUN
	2iN4ZIGS7GOs+OZ+4AFADlWJGlC5DpAsPVjiJbQhVJ/VSn5h0Rh2rslNkcVTHFavdV+1rB
	TfJ6y4Bb+mbirIcm1c80LbSVeIRCgxU=
ARC-Authentication-Results: i=1;
	mail2.ecloud.global;
	auth=pass smtp.mailfrom=maud_spierings@murena.io
ARC-Seal: i=1; s=mail2; d=murena.io; t=1750660838; a=rsa-sha256; cv=none;
	b=FAuKfniINvB77wTngpcUPVsI6Eq1dqhr/efasdsLnGMRsweZEfFWLJz4ihNJrR8nJAP11F
	S/5Bgx/b4h2VcGTBtywDSPcOe90me7Ir0KrcC5tLMGPcqTnipQmzFAcYbA2x5Nn9JLHZk6
	9R88Q3nWaOQwKdhiBihu5KjMB8KVp7Q=
Message-ID: <4cb09d05-d1f2-4d34-b3f7-be523b900a9e@murena.io>
Date: Mon, 23 Jun 2025 08:40:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: inochiama@gmail.com
Cc: alex@ghiti.fr, alexander.sverdlin@gmail.com, andrew+netdev@lunn.ch,
 aou@eecs.berkeley.edu, conor+dt@kernel.org, conor.dooley@microchip.com,
 davem@davemloft.net, devicetree@vger.kernel.org, dlan@gentoo.org,
 edumazet@google.com, huangze@whut.edu.cn, krzk+dt@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, looong.bin@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, palmer@dabbelt.com,
 paul.walmsley@sifive.com, richardcochran@gmail.com, robh@kernel.org,
 sophgo@lists.linux.dev, thomas.bonnefille@bootlin.com,
 unicorn_wang@outlook.com, yu.yuan@sjtu.edu.cn
References: <20250623003049.574821-2-inochiama@gmail.com>
Subject: Re: [PATCH net-next RFC v2 1/4] dt-bindings: net: Add support for
 Sophgo CV1800 dwmac
Content-Language: en-US
From: Maud Spierings <maud_spierings@murena.io>
In-Reply-To: <20250623003049.574821-2-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Inochi sent:> The GMAC IP on CV1800 series SoC is a standard Synopsys
> DesignWare MAC (version 3.70a).
> 
> Add necessary compatible string for this device.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/net/sophgo,cv1800b-dwmac.yaml    | 113 ++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml
> new file mode 100644
> index 000000000000..2821cca26487
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/sophgo,cv1800b-dwmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SG2044 DWMAC glue layer

This looks like a copy paste error

kind regards,
Maud


