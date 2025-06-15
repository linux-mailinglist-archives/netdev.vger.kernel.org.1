Return-Path: <netdev+bounces-197872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D29ADA1B6
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 14:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9D53AD5F2
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 12:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD9F1FCFF1;
	Sun, 15 Jun 2025 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="FlBhO5D2"
X-Original-To: netdev@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECF11EEE6;
	Sun, 15 Jun 2025 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749988952; cv=none; b=sC4ejhYer+IiXqufAptJrNf7EVQZAHRlaQ+Dg1enRlDKIybDu+QuXqEzjAhFhBq+ZknaUQ6ulB0NRD/nVnNDI4N6KTFoiRWHfvP497d9LMgql8uM+mVHFPjbwvZlUEQQi+XPivwqr28wP7KbzbTUBeWGbYAldYoVOhICsL2hs2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749988952; c=relaxed/simple;
	bh=+Wo241f5iLEF9A9MW15cxNuSp/Ymag6/MqvwK180/Eo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pxABRioUFFhuX5ivdNSm1mig9EmDEUVt4SAx5hWGI8LeHpR3y5AsqHcbTtnGIcJ89wGxoa6iWn0dKi2nX+PMANH/z0P4xQYshvLHd4BJiv/cTfddF7Q6/bLxgDO6zqC0JKCTPWfmGhXlqFz+Yesvc0hogIdWVODSLC7WS/SoNCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=FlBhO5D2; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout3.routing.net (Postfix) with ESMTP id D1E5F6028B;
	Sun, 15 Jun 2025 12:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1749988942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRcdvBt0CthVJmnj/dbaqQtXhJV7sGdCW7ml88MPC1U=;
	b=FlBhO5D2z9tg6W1gK4eedfxgObCDzADaUVoNpqI4mUbuJo2B9TDQMwJHp5qyUby+9IaLjC
	7CqRrCj/VLERiAuYikxrK8EwdtpC7gdJu+ZGVSZ+EsTQKM+CKTRd1KNvrH+aEqrbvr2AgO
	EwwRI18V5VA9KByMltAqfQujCGs6WMU=
Received: from webmail.hosting.de (unknown [134.0.26.148])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id EDB97100506;
	Sun, 15 Jun 2025 12:02:20 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 15 Jun 2025 14:02:20 +0200
From: "Frank Wunderlich (linux)" <linux@fw-web.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, Felix Fietkau <nbd@nbd.name>, Sean
 Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Frank Wunderlich
 <frank-w@public-files.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2] net: ethernet: mtk_eth_soc: support named IRQs
In-Reply-To: <aE6cyHC39IV27PcF@lore-desk>
References: <20250615084521.32329-1-linux@fw-web.de>
 <aE6K-d0ttAnBzcNg@lore-desk> <d4781d559e3f72b0bcde88e6b04ed8e5@fw-web.de>
 <aE6cyHC39IV27PcF@lore-desk>
Message-ID: <ed6cd7a2e489e89352322f77af1ddd89@fw-web.de>
X-Sender: linux@fw-web.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mail-ID: 982a129f-54e7-4806-9863-06e9150fd816

Am 2025-06-15 12:13, schrieb Lorenzo Bianconi:
>> Am 2025-06-15 10:57, schrieb Lorenzo Bianconi:
>> > > From: Frank Wunderlich <frank-w@public-files.de>
>> > >
>> > Hi Frank,
>> >
>> > I guess my comments on v1 apply even in v2. Can you please take a look?
> 
> sure

:)

>> Am 2025-06-15 10:57, schrieb Lorenzo Bianconi:
>> > > From: Frank Wunderlich <frank-w@public-files.de>

> I am fine to have it in a separate patch but I would prefer to have 
> this patch
> in the same series, I think it is more clear.

I added changes for your and daniels comments to my repo (top 2 
commits):

https://github.com/frank-w/BPI-Router-Linux/commits/6.16-mt7988upstream/

i would squash daniels suggestions in this patch here (MAX without __ 
and fixed
value of 3 to use for the loop - i guess this was intended for this 
purpose) and
then the change for index in second patch.

>> > Same here, if you are not listing them in the device tree, you can
>> > remove them
>> > in the driver too (and adjust the code to keep the backward
>> > compatibility).

i plan to use named IRQs on mt7988 without the reserved ones (only rx+tx 
+ RSS IRQs),
and loading not index based.

>> afaik i have no SHARED_INT board (only mt7621, mt7628) so changing the
>> index-logic will require testing on such boards too.
> 
> I think the change will not heavily impact SHARED_INT devices.

I hope so ;)

> Regards,
> Lorenzo

regards Frank

