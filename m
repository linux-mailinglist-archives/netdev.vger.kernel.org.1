Return-Path: <netdev+bounces-191986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED816ABE18F
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 19:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB967A4CC8
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 17:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BEE27A927;
	Tue, 20 May 2025 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="tn1Bihvj"
X-Original-To: netdev@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B70625C6E7;
	Tue, 20 May 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760902; cv=none; b=WV/BbDFTRnMq0jZxDjCcVgsAfbbhs/9JmgYzoY5FG8deZfsyqDOpUXE3LPfMtfV7KGz17b9nxHTAvr80H6aBlpiy1VFWLAbsbpcjIf7/PAV++KZjMtTQzxxu8GhN/4bf3XbjF/MaXRsNaqEF8U1dgONJWj64nhhAE0YRdA7Nd7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760902; c=relaxed/simple;
	bh=8RiLrstNlF9EuHrKrNRoWiTfcgsyhx9U5b/zvg9hWG8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mpIfjO8CqiMvM8OAHuYiVjfBVEnmdjcsE6AjEUJ2lWd2M5KWXmZvPjxwieRFnAMWasO1Ab2bRJ/qzuu33hwItULOcv3oZl/ukNTvyv4Joe+Z90bAOoUr+riQCWCb/ppjYuW1VsgqebpnHJ1w6llOsw7lI/ynmZqUu8dQoLCKk3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=tn1Bihvj; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout2.routing.net (Postfix) with ESMTP id B507E60201;
	Tue, 20 May 2025 17:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1747760889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1atJoeJZpQi4iXcinOZPKw7W7XsZAF/nspMP+bzqfBE=;
	b=tn1Bihvj0KwV8hHaE37t3Vohm7jwgCgsfyOBKhhM64BV6mMF/uSfwvpDZOzV9Zd927FjDp
	ib0UEXhYcEnzEi8tYnH92766++nlm16whVN09VOVY30MPcDVElsWjeFk9P0mifh80ZunPC
	wrjFBJfjm9W2bBtdd4KkbouGffuy3kc=
Received: from webmail.hosting.de (unknown [134.0.26.148])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id BEBF83601DF;
	Tue, 20 May 2025 17:08:08 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 20 May 2025 19:08:08 +0200
From: "Frank Wunderlich (linux)" <linux@fw-web.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>, =?UTF-8?Q?Ar=C4=B1n=C3=A7_?=
 =?UTF-8?Q?=C3=9CNAL?= <arinc.unal@arinc9.com>, Landen Chao
 <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Sean Wang
 <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 06/14] arm64: dts: mediatek: mt7988: add cci node
In-Reply-To: <7a563716-a7c6-446d-b66d-bc71c6207ef6@collabora.com>
References: <20250516180147.10416-1-linux@fw-web.de>
 <20250516180147.10416-8-linux@fw-web.de>
 <7a563716-a7c6-446d-b66d-bc71c6207ef6@collabora.com>
Message-ID: <6c0dd946bdebd8461307a3e08e60a27f@fw-web.de>
X-Sender: linux@fw-web.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mail-ID: 1e75dd63-5eea-4a06-acca-51b6c01efd9c

Am 2025-05-20 13:27, schrieb AngeloGioacchino Del Regno:
> Il 16/05/25 20:01, Frank Wunderlich ha scritto:
>> From: Frank Wunderlich <frank-w@public-files.de>
>> 
>> Add cci devicetree node for cpu frequency scaling.
>> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
>> @@ -12,6 +12,35 @@ / {
>>   	#address-cells = <2>;
>>   	#size-cells = <2>;
>>   +	cci: cci {
>> +		compatible = "mediatek,mt8183-cci";
> 
> While you can keep the mediatek,mt8183-cci fallback, this needs its own 
> compatible
> as "mediatek,mt7988-cci", therefore, I had to drop this patch from the 
> ones that I
> picked.
> 
> Please add the new compatible both here and in the binding.

Hi,

should i add the binding with 2 const (like the bpi-r4-2g5 compatible) 
or first as enum
to allow easier addition of further SoC bindings with same fallback?

currently i changed binding like this (2nd variant):

properties:
   compatible:
     oneOf:
       - items:
           - enum:
               - mediatek,mt8183-cci
               - mediatek,mt8186-cci
       - items:
           - enum:
               - mediatek,mt7988-cci
           - const: mediatek,mt8183-cci

but noticed that these boards are missing the required proc-supply:

   DTC [C] arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dtb
arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dtb: cci: 'proc-supply' is a 
required property
	from schema $id: 
http://devicetree.org/schemas/interconnect/mediatek,cci.yaml#
   DTC [C] arch/arm64/boot/dts/mediatek/mt8186-evb.dtb
arch/arm64/boot/dts/mediatek/mt8186-evb.dtb: cci: 'proc-supply' is a 
required property
	from schema $id: 
http://devicetree.org/schemas/interconnect/mediatek,cci.yaml#

the others are clean so far. But because i do not have these boards i 
cannot fix this without
anyone telling me the proc-supply for them.

In mt7988a.dtsi i can put both compatible on 1 line as there are only 75 
chars, or should i
add linebreak here for better readability?

> Cheers,
> Angelo

regards Frank

