Return-Path: <netdev+bounces-150880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E459EBF0E
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 00:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42B2161718
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 23:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB6B1EE7DC;
	Tue, 10 Dec 2024 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="prcz+Ngt"
X-Original-To: netdev@vger.kernel.org
Received: from cichlid.cherry.relay.mailchannels.net (cichlid.cherry.relay.mailchannels.net [23.83.223.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B232451EF
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 23:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733872283; cv=pass; b=G5BDxiLeXJWQfez/184IrY6i+uPT0+12D/wDyhfG+8TtVMKi6i1y6jiSl9T0KxvZH6y+n/YPMpEcaCgk+aCI5qkkHq02CRqvEPDclW1yf4q15uNklg7ZTRg6wS3ED42hoB82fe3KFu45y7RX7i4r0UrOKjLsyH5+EaLRjYLUcJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733872283; c=relaxed/simple;
	bh=UQxE7ji1mP5BOJmwh6dh2HbYyWlR+Kk4E6wyTh56mHg=;
	h=MIME-Version:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:Date; b=Eic4PpRjNRXPxguBTKWZGOwhFP2AKWWd8+X1xKqiMIRPUutx4HBCEoGlxtpaMjXf9W/DzQS52jnUhNHwJWms/Qj4lQd5ZqYleev7dZ8n2OK9/2r2ChllFADGuh53ZkUi/6t0wgas1ZARWykn4pE+s8DP7tpMgtdDBKBUy74pKFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=prcz+Ngt; arc=pass smtp.client-ip=23.83.223.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
X-Sender-Id: hostingeremail|x-authuser|arinc.unal@arinc9.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 81F3124832;
	Tue, 10 Dec 2024 21:45:20 +0000 (UTC)
Received: from nl-srv-smtpout7.hostinger.io (trex-5.trex.outbound.svc.cluster.local [100.98.0.247])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8AF5A24823;
	Tue, 10 Dec 2024 21:45:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1733867120; a=rsa-sha256;
	cv=none;
	b=hFP3QZjCni3Ip+98MFP1SXKWHbM3jP5XOrotbnnYkdE47JEO2yqpYuKMt1LMFHicSvTFc5
	+carobUQ/Wv063VPCooN79SBt6oRVu5edzaQG6YIhCnNhttSKo0Z47l1zh3NyieycbRx2E
	dIASUPOWQBl7AKdPMuJj9QvDo2Pu9ryiJ7RBdCAGrsHI845q3kv4JKzK3L65e5ecDzyfS0
	C7TI2LiyFBK89i6nE57o8UI18UWCddYL5R7Vdc1m1UETHppllY9rWTzu/3kU7HJ4YylTJ0
	XweUIWINlwQ8PvXeJcXACJbg3pE0Peof2I1C+sV7/KkUH/O0g8f0oVg3PIfNdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1733867120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=SYdwHkJmBU/pcv/d+DYNr7WpOGo7tnfs2VifDPdDAhg=;
	b=QrfbnH6L3CMm5LbRWznkqoqMitue4u8NE2ndpjiIs4Iv/dPhPlGvgv0tAeMUfp/OFBQfk8
	r9YryQB8GS9wfrHTexiw9AYoLEXJcUCcXcPgmDSPtU/4H0sxHHfDOQDJdfxFuPmAU6GOWx
	8a3GLlwTL5DyhHbxvG0hq1kB/l+XadMSf0lIC2Ex13Yi7KOXuNRwfcAvLA3puavPtz5v8q
	nOrTj7cX5+fe1cXh9t0yu+2U+HYbwQs6laMOjC2n35quNOeOMiy6YDB45KogRsHXdZSAku
	soxx0UkocrrBpCqE7K/csxr2eFjRq5rzx2ExEr1gZaHxqXqTKdFKIqKtcXOtxg==
ARC-Authentication-Results: i=1;
	rspamd-5d9d86ff64-sqxlh;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=arinc.unal@arinc9.com
X-Sender-Id: hostingeremail|x-authuser|arinc.unal@arinc9.com
X-MC-Relay: Bad
X-MailChannels-SenderId: hostingeremail|x-authuser|arinc.unal@arinc9.com
X-MailChannels-Auth-Id: hostingeremail
X-Bottle-Coil: 2fbcd1441e3f7124_1733867120287_3536260936
X-MC-Loop-Signature: 1733867120287:1317792024
X-MC-Ingress-Time: 1733867120287
Received: from nl-srv-smtpout7.hostinger.io (nl-srv-smtpout7.hostinger.io
 [45.87.82.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.0.247 (trex/7.0.2);
	Tue, 10 Dec 2024 21:45:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com;
	s=hostingermail-a; t=1733867114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYdwHkJmBU/pcv/d+DYNr7WpOGo7tnfs2VifDPdDAhg=;
	b=prcz+Ngt+NRtMI52vtGLN3OQLVWpkPxinr5+LleVEp1gSCl76tsRj8xQ7XMI9r4BWoJ1xM
	a2LMV9zA8QPElKEHFbxaDsBLNzSFQ+jG0bFKlspi6XSW0rSwZf6/zPwI1miR1+p7Km2IrR
	dl8X72ZDAiAPAqK8wH3oJNFJMU15lTl5vUV9wniFiOQLW7zyBh097h/yy95tcJHBrk2MW7
	1jIrQUeXMaObWB1szYeWs3toHC00bBayYWcI+F7VOqw2Gw/veTUxD7Ua9JydTcPNJYRTLh
	maAd6RhXWFD9cyWuQkDE2eQ0bCgSoJJTk81w+KdzjPr7hbjNz+nacY2KL5q0JQ==
From: arinc.unal@arinc9.com
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Daniel
 Golle <daniel@makrotopia.org>, "David S. Miller" <davem@davemloft.net>, DENG
 Qingfang <dqfext@gmail.com>, Eric Dumazet <edumazet@google.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>, Simon Horman
 <horms@kernel.org>, UNGLinuxDriver@microchip.com, Vladimir Oltean
 <olteanv@gmail.com>, Woojung Huh <woojung.huh@microchip.com>
Subject: Re: [PATCH net-next 5/9] net: dsa: mt753x: implement .support_eee()
 method
In-Reply-To: <E1tL14J-006cZa-Rh@rmk-PC.armlinux.org.uk>
References: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
 <E1tL14J-006cZa-Rh@rmk-PC.armlinux.org.uk>
Message-ID: <3b9218282c34a1a0e10c4bc80a588082@arinc9.com>
X-Sender: arinc.unal@arinc9.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Tue, 10 Dec 2024 21:45:13 +0000 (UTC)
X-CM-Envelope: MS4xfJuZft709FxizpinMKGWhJhNuVkZgkBg+qc3Jglod8if95nnLuGy8biWUCFr5kuQapCfrsMBJit/W+EQFp9ExfhFRsMgaChMRyoVpzk96i1nf1hMBm0t rugRkpC2iB2Rhx0oVFDS0z98PC5IEggSkuZi1yGBZZrGG6QaW0lPwJw3+/TPoJBjnPN8FJIiWbFYzpqr6zvZOCZaK2NJ1ice5ZWKcEYuL2dPJP0it+tbzpph RLws0KOZfe7K6l2c0fCG/AmRGk6a8tpWJPX9mYEDRyArrhSB54NgYsmkl358i/wk38tMGVjqZeQIqIVFQhGUPIkP1LC1vfQ7M/zzRUIfPH7eziiUHLPn5kxg esfFq2hvhZp4mvqTHBnZTAf6SIw+4gt46hj2v0GGnhj0rHEMkFeYzDLGTL/Rwn5CKE7w3FYyrLzmTiG7dwJVt+QHVPNrl2e1y0TuKAfxlrSRkvuoT2swX5/R /2NMOPKxL9K11wsaSyml7zlKsITYEAd3AFagiW22SJoHX7sId2VkShlIZ5W+SxrBqDtGcGuVGR15bq3SW5Vm0XSS3s/Z2gYJ8FIOx6c9xZK49JWpGMg4zMS6 sap06jaGyY5vfJ3H4/Z4k2753n/XA0KWv24Fco4jgykckekYj3KbZ11QscrsAjiNCu/2UDmzx+pUxNyh0xxUt9uwTLkT2W7pa5mz/FaW4Z2LObtLEyb5z+/B vbZk8/Bc7qfud57FqoYsdIfA1QPV7fPZ/9KfEynUMNA+qTdmoYEUQp3XuyG6m8SaS4tzzu77sGtlBDcHUx/7/WaodcYWan1mZq2AtoznQ+Lj19n29yHcl6qS wD9NPfzszGRKDim4sx2h1A80/sWxdKlw19iv3smG3G2N42iXzypaYyqZ8qoyVw==
X-CM-Analysis: v=2.4 cv=K9lwHDWI c=1 sm=1 tr=0 ts=6758b66a a=5MOetqiP25nozuSVG0c2+A==:117 a=5MOetqiP25nozuSVG0c2+A==:17 a=IkcTkHD0fZMA:10 a=PHq6YzTAAAAA:8 a=GvHEsTVZAAAA:8 a=1IKdRoJznwPGE5zMZgQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=THfFRngN91AA:10 a=ZKzU8r6zoKMcqsNulkmm:22 a=aajZ2D0djhd3YR65f-bR:22
X-AuthUser: arinc.unal@arinc9.com

On 2024-12-10 16:18, Russell King (Oracle) wrote:
> Implement the .support_eee() method by using the generic helper as all
> user ports support EEE.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Much love.

Arınç

