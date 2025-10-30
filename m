Return-Path: <netdev+bounces-234233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9222EC1E020
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1700F4E4176
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4611261B77;
	Thu, 30 Oct 2025 01:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpOJ22qo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D7625F784;
	Thu, 30 Oct 2025 01:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761787186; cv=none; b=Ftj8AOswnWgQBYAzuc3N96x70w02+e1IoPyBLvJylzFrBAj+F1Db+KoOmU47WJk6Kii6rfsuTwFaA3pdV9z/XKXSiOzFlQmx98wzSas83TO29UaoY1J5Uv9fBBRk6MqZldbHMHuoSNDWKAKNPw6CcjIRP9fHBu+kXucjfErxI1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761787186; c=relaxed/simple;
	bh=RXueJPrKlnP44RO/ULEHFku8UVsM8H5sO2YSFmrK8qs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=BHyItDFsw3M9l0Xit8fwf9MhP4joViAFde5/LRYuQLXuoiJDIaIf2U/IJaH0qmD/T5x8PBuW4syZrMt+SiSIiULULOvo5/AJAqsmKyGiEaGBvahPWWm1bfDf9tkmpm5fO9nep1iD4aJqGRvbOO/G6YXaA+bP5tkfkxPcsCeRiIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpOJ22qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE19C4CEF7;
	Thu, 30 Oct 2025 01:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761787186;
	bh=RXueJPrKlnP44RO/ULEHFku8UVsM8H5sO2YSFmrK8qs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=gpOJ22qo2Ovt+mTglodFIsNSV3wf+QglAlJ9x7UEiV+4s3dFDamCXN6Ms/+k5hccu
	 7WLZoOYNAm4M0V1LcgQK0zh/1SL6cNFY0XTL3W45t3NnCz4F4WAFTHm6acSMOy+BsK
	 iIPIzu4gdJKm4WVWWRBDeciDyUQmtAm7F9rD5B/G9JNBVhInmQOJ28ocUAq9sFRyFg
	 TXjVV30hd0IXAM3WIr3LnPUHaAqraLC3f0EfzbJ5Uz3imcghSIU/Zx0yV2u4WpBP8Z
	 ul8k2874s938tZJXMxweX60Kjmkyorl5DfTlc8tw3jY58Q3W9oy2AHrIeOlchVw8Fx
	 ilu09FADCyGhg==
Date: Wed, 29 Oct 2025 20:19:37 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Peter Christen <peter.christen@siemens.com>, 
 Hauke Mehrtens <hauke@hauke-m.de>, linux-kernel@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
 Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, 
 devicetree@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
 Liang Xu <lxu@maxlinear.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 "Livia M. Rosu" <lrosu@maxlinear.com>, Bing tao Xu <bxu@maxlinear.com>, 
 John Crispin <john@phrozen.org>, 
 Lukas Stockmann <lukas.stockmann@siemens.com>, 
 "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>, 
 Juraj Povazanec <jpovazanec@maxlinear.com>, 
 Avinash Jayaraman <ajayaraman@maxlinear.com>, 
 Andreas Schirm <andreas.schirm@siemens.com>, 
 "Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>
To: Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <02272a098447ab0de6d2e9d686469fc6ce355c7d.1761693288.git.daniel@makrotopia.org>
References: <cover.1761693288.git.daniel@makrotopia.org>
 <02272a098447ab0de6d2e9d686469fc6ce355c7d.1761693288.git.daniel@makrotopia.org>
Message-Id: <176178717757.3193497.18178330899747787205.robh@kernel.org>
Subject: Re: [PATCH net-next v4 10/12] dt-bindings: net: dsa: lantiq,gswip:
 add support for MaxLinear GSW1xx switches


On Wed, 29 Oct 2025 00:18:30 +0000, Daniel Golle wrote:
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
> v4:
>  * drop maxlinear,rx-inverted and maxlinear,tx-inverted properties for
>    now in favor of upcoming generic properties
> 
> v3:
>  * add maxlinear,rx-inverted and maxlinear,tx-inverted properties
> 
> v2:
>  * remove git conflict left-overs which somehow creeped in
>  * indent example with 4 spaces instead of tabs
> 
>  .../bindings/net/dsa/lantiq,gswip.yaml        | 267 +++++++++++++-----
>  1 file changed, 194 insertions(+), 73 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.example.dtb: switch@1f (maxlinear,gsw125): ports:port@4: Unevaluated properties are not allowed ('maxlinear,rx-inverted' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/dsa/lantiq,gswip.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/02272a098447ab0de6d2e9d686469fc6ce355c7d.1761693288.git.daniel@makrotopia.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


