Return-Path: <netdev+bounces-111314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AE1930812
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 01:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 163E3B20AEF
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 23:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DBB1487CC;
	Sat, 13 Jul 2024 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZVK73jC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4DC1CFB6;
	Sat, 13 Jul 2024 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720913852; cv=none; b=cc6rdIdoL7KuM8UbkT9hbGih+mjWPSs5A05mEfhzYjXllVzgXOGm+jfVmqgK6fOJj+C1cPEkm+f3pjq5kSTVtWd4vQwSqoMMvjfWVCGnyq4hRDIELmeoEeaEBYX2Q8TaVAagcLFhPS5hSHILG7TgrFac+vt8nMOgW9rH4a2gh68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720913852; c=relaxed/simple;
	bh=1MKxAWYwekOaP2fx1r0IX5frF/qFcCGEptjnVO3Gg9s=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=LNeHvNUbh5TVw0/szaZyi1lH8hWbsbXF+qD5mI83VmVIBSwbrunzHAVA7mDuPSESOfI9JNUJSxPNo81g5YkV6YdHtDcjBwGn5Gj1/fzmPWfq+/UTpbWBzgojEa2s2j3vFgx60b3dZgGfcCcVuDwvLq6m98J8Ipcp2HVKy2S9MOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZVK73jC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101D6C32781;
	Sat, 13 Jul 2024 23:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720913851;
	bh=1MKxAWYwekOaP2fx1r0IX5frF/qFcCGEptjnVO3Gg9s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=CZVK73jCSuzWb30m9mu0yZbd8+rqCqBXF8zwLg36U2uuXLUckq2rh0Fg19VyhdmdM
	 qGm264HTLM9JjcMrD8M8ZCKVeJFFycPtBnPsQPNoWxdy4SnOxnnOL2fc3hZQhjJFMY
	 +T8LqZSu9bF5YfNoPEbPmINfW3Ntdo6t09gCmEfCDExxpxxLHKbBiBcpl2hQvA0G/e
	 1ynZicnLJWjk5Ye8gV+nd/Up/nWY7878TrArmmSr8dtTVJSLayq21TqPt20TL1MzrC
	 6jPR5JCTjmzE1xhT85vaezu3AcWRch2pvgX6Y6fq8au+mKKziET+bR6MgINxxsZVhK
	 LpqxOqCBrULTg==
Date: Sat, 13 Jul 2024 17:37:29 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Drew Fustini <drew@pdp7.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Jisheng Zhang <jszhang@kernel.org>, devicetree@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Paolo Abeni <pabeni@redhat.com>, Jose Abreu <joabreu@synopsys.com>, 
 Fu Wei <wefu@redhat.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org, 
 Jakub Kicinski <kuba@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, Guo Ren <guoren@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240713-thead-dwmac-v1-2-81f04480cd31@tenstorrent.com>
References: <20240713-thead-dwmac-v1-0-81f04480cd31@tenstorrent.com>
 <20240713-thead-dwmac-v1-2-81f04480cd31@tenstorrent.com>
Message-Id: <172091384997.169230.1017177117936828717.robh@kernel.org>
Subject: Re: [PATCH RFC net-next 2/4] dt-bindings: net: add T-HEAD dwmac
 support


On Sat, 13 Jul 2024 15:35:11 -0700, Drew Fustini wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> Add documentation to describe T-HEAD dwmac.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Link: https://lore.kernel.org/r/20230827091710.1483-3-jszhang@kernel.org
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> [drew: change apb registers from syscon to second reg of gmac node]
> Signed-off-by: Drew Fustini <drew@pdp7.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml        |  1 +
>  .../devicetree/bindings/net/thead,dwmac.yaml       | 81 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  3 files changed, 83 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,dwmac.yaml: properties:reg: {'minItems': 2, 'maxItems': 2, 'items': [{'description': 'DesignWare GMAC IP core registers'}, {'description': 'GMAC APB registers'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,dwmac.yaml: properties:reg: 'oneOf' conditional failed, one must be fixed:
	[{'description': 'DesignWare GMAC IP core registers'}, {'description': 'GMAC APB registers'}] is too long
	[{'description': 'DesignWare GMAC IP core registers'}, {'description': 'GMAC APB registers'}] is too short
	False schema does not allow 2
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,dwmac.yaml: properties:reg-names: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 'dwmac'}, {'const': 'apb'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,dwmac.yaml: properties:reg-names: 'oneOf' conditional failed, one must be fixed:
	[{'const': 'dwmac'}, {'const': 'apb'}] is too long
	[{'const': 'dwmac'}, {'const': 'apb'}] is too short
	False schema does not allow 2
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,dwmac.example.dtb: ethernet@e7070000: snps,pbl: [32] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,dwmac.example.dtb: ethernet@e7070000: snps,pbl: [32] is not one of [1, 2, 4, 8, 16, 32]
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,dwmac.example.dtb: ethernet@e7070000: snps,pbl: [32] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/thead,dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,dwmac.example.dtb: ethernet@e7070000: snps,pbl: [32] is not one of [1, 2, 4, 8, 16, 32]
	from schema $id: http://devicetree.org/schemas/net/thead,dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,dwmac.example.dtb: ethernet@e7070000: Unevaluated properties are not allowed ('clock-names', 'clocks', 'interrupt-names', 'interrupts', 'mdio', 'phy-handle', 'phy-mode', 'snps,axi-config', 'snps,fixed-burst', 'snps,pbl' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/thead,dwmac.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240713-thead-dwmac-v1-2-81f04480cd31@tenstorrent.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


