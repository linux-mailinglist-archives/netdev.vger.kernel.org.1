Return-Path: <netdev+bounces-165424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69877A31F71
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 07:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAF01606D3
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 06:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2441FCCEC;
	Wed, 12 Feb 2025 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koYdMOi2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3A1FBCBD;
	Wed, 12 Feb 2025 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342988; cv=none; b=Qw9YFptA5DTHXIah5jqdjXWAqTDdTs51+hfpoXg3Yz/tQrQhQW9cjrJiqVD0PZPxIBSzWV0JmiGGscxRrk3k9HG594WGIZp/vccStmGJtixjKCJpomqhgtgKCIliVZUtgfn3ykr3nkCM7sjcaawkZVoGE95c0a+zI5E+Li+HeJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342988; c=relaxed/simple;
	bh=TQTxyc4gErD77Nn6rbZxay/35+TdsfVXIQZ5PlMQYi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srNNbGhwWuBywy66HtyPZeuhIUQpjSV/Yw8zL4UiNNlblCDW4KWE0zrLDcBOa7VPvIhwG5KPdo/7gsR95PePmXiEgxiznjAuzlqwuu4HgvPeCVl0NsLiS4X4yACxx8lwdOtBr4jyX2cgEBmMBesgL4a0EDBKSzErlpgOnBaUmsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koYdMOi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCE9C4CEDF;
	Wed, 12 Feb 2025 06:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739342988;
	bh=TQTxyc4gErD77Nn6rbZxay/35+TdsfVXIQZ5PlMQYi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=koYdMOi2cpNanzXzA9//aq6WOPBLTOr4hW+GWxd16dUFJS2V60pi2NKXVClMzd1jU
	 w4NHASYymVmSATBGYNuRV+EiN/lF4M6b/ZtCtv5MjAgjhsDxDhXx4iuQ5fA8pgGAPC
	 DYaz2xiEsSGj2/JUAQ66vkFr5E116q0ktfO/EGj57RnPZggLfIAtEhajALbnFaoM2h
	 Sadtbz6WQMXHhVGAUwwp9ajCH9evjyEtVvU0IQiBO02cZAbqymTu8NL+coIPCAXIyG
	 o2SzXBbjG/T8zscDSWSDtwBM2Kh9FeJCsHxLhW0F6FIYl1oMaGjTtl0MpgkbBMAjZc
	 Jodb1FEjchpxw==
Date: Wed, 12 Feb 2025 07:49:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@nbd.name>, 
	Sean Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "Chester A. Unal" <chester.a.unal@arinc9.com>, 
	Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH net-next v3 11/16] dt-bindings: arm: airoha: Add the NPU
 node for EN7581 SoC
Message-ID: <20250212-polite-finicky-vulture-b5adc3@krzk-bin>
References: <20250209-airoha-en7581-flowtable-offload-v3-0-dba60e755563@kernel.org>
 <20250209-airoha-en7581-flowtable-offload-v3-11-dba60e755563@kernel.org>
 <20250211-judicious-polite-capuchin-ff8cdf@krzk-bin>
 <Z6t7s0m1xzsnjAsV@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6t7s0m1xzsnjAsV@lore-desk>

On Tue, Feb 11, 2025 at 05:32:51PM +0100, Lorenzo Bianconi wrote:
> On Feb 11, Krzysztof Kozlowski wrote:
> > On Sun, Feb 09, 2025 at 01:09:04PM +0100, Lorenzo Bianconi wrote:
> > > This patch adds the NPU document binding for EN7581 SoC.
> > > The Airoha Network Processor Unit (NPU) provides a configuration interface
> > > to implement wired and wireless hardware flow offloading programming Packet
> > > Processor Engine (PPE) flow table.
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  .../devicetree/bindings/arm/airoha,en7581-npu.yaml | 71 ++++++++++++++++++++++
> > >  1 file changed, 71 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/arm/airoha,en7581-npu.yaml
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..a5bcfa299e7cd54f51e70f7ded113f1efcd3e8b7
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/airoha,en7581-npu.yaml
> > 
> > arm is for top-level nodes, this has to go to proper directory or as
> > last-resort to the soc.
> > 
> > > @@ -0,0 +1,71 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/arm/airoha,en7581-npu.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Airoha Network Processor Unit for EN7581 SoC
> > > +
> > > +maintainers:
> > > +  - Lorenzo Bianconi <lorenzo@kernel.org>
> > > +
> > > +description:
> > > +  The Airoha Network Processor Unit (NPU) provides a configuration interface
> > > +  to implement wired and wireless hardware flow offloading programming Packet
> > > +  Processor Engine (PPE) flow table.
> > 
> > Sounds like network device, so maybe net?
> 
> yes. Do you mean to move it in Documentation/devicetree/bindings/net/ ?


Yes... and no, because after second look at your driver it looks more
like a mailbox. So basically I don't know. I usually hope contributors
know better. :)

If this is onlt mailbox provider, then should be placed in mailbox. If
this is much more (including mailbox) but main function is network, then
could be in net. So it all depends...

Best regards,
Krzysztof


