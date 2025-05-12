Return-Path: <netdev+bounces-189842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E77AAB3E1F
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F03AB7A7204
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D41253F1C;
	Mon, 12 May 2025 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="M5CVNodR"
X-Original-To: netdev@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914BB248F7C;
	Mon, 12 May 2025 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068865; cv=none; b=pLAurHB9rNK5luYV8osZa1XPXog2n+LKoPrrVLfmja3o2/OmgdTNwjIh4+0NiGpj64ZOdciVuCOlukjL2d4oRnUqppQ1E8r3lsVxVRNRMuiyt+P8l9b88lHHQ6avOGSqaFtadokJ3PsAhiJLISMs9o0oX/rpS3zASNen+M9nCBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068865; c=relaxed/simple;
	bh=2KmBHCbmJKX38taSww0MS32+kkvzaKJjLbRW42CGLAs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=SwZg7okANNto0moFrvEzzALXjMA217QzXCdt3De7gZmpbwoA+7JvCHnF7QXM/r9TOiBxKR5GB8F0+YOvrwKXkduSGf4K1VIV3MBvce9X26+qFzurAltvT5VmCKiMAGEV6ofdYSb+V+Twsf42H+G8E8n5fBgy7gdZ6Mih20ZVIZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=M5CVNodR; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout4.routing.net (Postfix) with ESMTP id 0890510086D;
	Mon, 12 May 2025 16:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1747068855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qaUgv+JLZay3Y2F+/Ogkx8/sFTrHyxh+hSqyOgzPIyM=;
	b=M5CVNodRKZjir1J12a/+f4bPxrmlXKe+6XYTWLKNXH5uS1JBs6n50QRnLG3JXxJkWmz80B
	2u2qGbDAMEYv/GIm9WD2mBhqQdAddXdqycGfZfZQii9rsyURYsDYJG2yvJchoXa47CMjhu
	+FPtCj4pyNJBeIqwSAAQGyEYQ1ibYOA=
Received: from webmail.hosting.de (unknown [134.0.26.148])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id CE4D51005DA;
	Mon, 12 May 2025 16:54:13 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 May 2025 18:54:13 +0200
From: "Frank Wunderlich (linux)" <linux@fw-web.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Frank
 Wunderlich <frank-w@public-files.de>, =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9C?=
 =?UTF-8?Q?NAL?= <arinc.unal@arinc9.com>, Landen Chao
 <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Sean Wang
 <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 08/14] arm64: dts: mediatek: mt7988: add basic
 ethernet-nodes
In-Reply-To: <78abbdb9-70d8-4e53-8593-91735cde73ec@lunn.ch>
References: <20250511141942.10284-1-linux@fw-web.de>
 <20250511141942.10284-9-linux@fw-web.de>
 <78abbdb9-70d8-4e53-8593-91735cde73ec@lunn.ch>
Message-ID: <acc9ca84eadb1f78308f0c3e2b527406@fw-web.de>
X-Sender: linux@fw-web.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mail-ID: 59e01210-9a66-4032-a58d-f1ce7445dcb7

Am 2025-05-11 18:38, schrieb Andrew Lunn:
>> +			gmac0: mac@0 {
>> +				compatible = "mediatek,eth-mac";
>> +				reg = <0>;
>> +				phy-mode = "internal";
>> +
>> +				fixed-link {
>> +					speed = <10000>;
>> +					full-duplex;
>> +					pause;
>> +				};
> 
> Does phy-mode internal and fixed-link used together make any sense?
> Please could you explain this.

Hi,

the fixed link is used to bring up the mac and switch cpu port up with 
the right settings.
Of course we can hardcode it in driver for mt7988, but driver already 
supports the generic
definition via devicetree. So imho adding driver code for whats already 
supported via devicetree
does not make sense for me and devicetree shows the right settings 
(speed,duplex,flow control) without digging in the driver code.

e.g. we could disable flow-control there (but it causes retransmitts) 
without changing driver.

Imho this is the cleanest way without adding unnecessary driver code and 
SoC conditions and
devicetree describes hardware ;).

regards Frank

