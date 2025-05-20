Return-Path: <netdev+bounces-191827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04400ABD768
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E0B4C1229
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206FD276030;
	Tue, 20 May 2025 11:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="jhZ6H4dm"
X-Original-To: netdev@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F096BB5B;
	Tue, 20 May 2025 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742033; cv=none; b=KHHwykfFAqo2XEWhsk6Y3eppLwIb8DGhDz5BiLUwPxxBT2LN4vkxJh4DZfrd3I2d0RUES1t961/HnoDcvc8ZJfmRCqobVMpy1U8VOjgjJfS5wMnFLn3iH/Xfs+e4ueD4bYujZ0E3ylRmv4dCoksVyUnAUOrwCqze4+f2e2daeto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742033; c=relaxed/simple;
	bh=jZpv78M0XLQXvPOauuXS6ONIikwRvvKqi0uQmtH+E88=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=nvgiPrDjd/A9nf3nZZOlql7Kw0/ixfZF6WUn0uRGyIDu4YQwLw1v/SHA1eXjm+hFgCDSI8vJ18uu0l+STCUnSjOWYCEJCty/DkDWy4WntTpnumqj/w3iURZqZRZZ781OUJbtjqiNSIkZTYTp1jgAtlSJWWahK/bOFQMp4860W5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=jhZ6H4dm; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
	by mxout3.routing.net (Postfix) with ESMTP id E4B4B61625;
	Tue, 20 May 2025 11:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1747742023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DWgu5lBfL5XpJjjET0WzNaYSrku+BoCHnp93wZOvIz8=;
	b=jhZ6H4dmH4PqaBbiMtuQINMyJgIfDAivcHRGi8Lw23Mjc4lMh8E5D0hNQqcQC5EmT8afWX
	Mo5cQ5OWOrIJBTK/GhIQXhYxJynUIKDOhuf6ZGuA7+PujHyTbiBhnLIXs60lGNFn3rhk7U
	7mcN+CQ8DR158tEYKD9Cs8l4GWzftLk=
Received: from [IPv6:::1] (unknown [IPv6:2a01:599:a12:a881:7bc8:fcdc:bd77:c992])
	by mxbox4.masterlogin.de (Postfix) with ESMTPSA id 91EC9801A1;
	Tue, 20 May 2025 11:53:41 +0000 (UTC)
Date: Tue, 20 May 2025 13:53:43 +0200
From: Frank Wunderlich <linux@fw-web.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
CC: Frank Wunderlich <frank-w@public-files.de>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 06/14] arm64: dts: mediatek: mt7988: add cci node
User-Agent: K-9 Mail for Android
In-Reply-To: <7a563716-a7c6-446d-b66d-bc71c6207ef6@collabora.com>
References: <20250516180147.10416-1-linux@fw-web.de> <20250516180147.10416-8-linux@fw-web.de> <7a563716-a7c6-446d-b66d-bc71c6207ef6@collabora.com>
Message-ID: <4BEF26F3-957D-4BB4-BF7B-69DCFCC513DC@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: 2d52479b-b83b-47c9-978a-066fc5c63c1d

Am 20=2E Mai 2025 13:27:23 MESZ schrieb AngeloGioacchino Del Regno <angelog=
ioacchino=2Edelregno@collabora=2Ecom>:
>Il 16/05/25 20:01, Frank Wunderlich ha scritto:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Add cci devicetree node for cpu frequency scaling=2E
>>=20
>> Signed-off-by: Daniel Golle <daniel@makrotopia=2Eorg>
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt7988a=2Edtsi | 33 ++++++++++++++++++++=
+++
>>   1 file changed, 33 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a=2Edtsi b/arch/arm64/b=
oot/dts/mediatek/mt7988a=2Edtsi
>> index ab6fc09940b8=2E=2E64466acb0e71 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt7988a=2Edtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt7988a=2Edtsi
>> @@ -12,6 +12,35 @@ / {
>>   	#address-cells =3D <2>;
>>   	#size-cells =3D <2>;
>>   +	cci: cci {
>> +		compatible =3D "mediatek,mt8183-cci";
>
>While you can keep the mediatek,mt8183-cci fallback, this needs its own c=
ompatible
>as "mediatek,mt7988-cci", therefore, I had to drop this patch from the on=
es that I
>picked=2E
>
>Please add the new compatible both here and in the binding=2E

Ok,but you have to drop last one too (add proc-supply) else there are buil=
d-errors=2E

>Cheers,
>Angelo
>


regards Frank

