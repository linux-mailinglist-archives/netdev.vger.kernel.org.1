Return-Path: <netdev+bounces-140636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4EE9B7523
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 08:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7046D1C20C6B
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 07:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB003145A19;
	Thu, 31 Oct 2024 07:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="NRoo+kQ7"
X-Original-To: netdev@vger.kernel.org
Received: from bisque.elm.relay.mailchannels.net (bisque.elm.relay.mailchannels.net [23.83.212.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED06D1E51D
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359004; cv=pass; b=ID937hRHeObgaSBGDA84SC5VAnkDf5v6qnaW6aCninOcsflGa0GoD6J2MuHvQJaa9zmG1jlL/RqTvwoH29kg51EFZ+qdMl7noAdKFbWkTgR+ZAbSOn5vkzMNCcEiNm126JmUqLMg1YKlkvl08uHPnHzwg6fVL9dVDmvbH8pQuuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359004; c=relaxed/simple;
	bh=lZlmnnd6VY4iWOEJN3fR2oAOuKekDnzf7D9Hkfh3i4s=;
	h=Message-ID:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Date; b=LDY4/eL4zyzuTcBRTQQwNC/hdGkShXwhBaSA6TECgbVltSh5yEh1EO5+4D9tqNqPcgWLlnxwii9Jdim/UYvt497jxXamtXM0f8dbRJX2+oBerwMmmPp+GaoUD7mLsPcoGhpyFGhOCIQ75T4+iH7mo3TFsEjwzo0Bh2xZy3hOqxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=NRoo+kQ7; arc=pass smtp.client-ip=23.83.212.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
X-Sender-Id: hostingeremail|x-authuser|arinc.unal@arinc9.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 616488A4705
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 07:10:37 +0000 (UTC)
Received: from nl-srv-smtpout9.hostinger.io (trex-8.trex.outbound.svc.cluster.local [100.103.220.31])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id CD7AD8A2D02
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 07:10:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1730358637; a=rsa-sha256;
	cv=none;
	b=6JbtyXMpup8CPhqsmiiK8pVJS9Xfef7oMld/6+MoXo9jAdV13YX3DpR1enGifE8cEZqjBz
	k+0UK4Bt9s+3NQnJQt9RDK5Bjm1XhA0JsL9AjyXH/e1B7GeRHMVJZqvLf9M4Qo75m76SKt
	IP4xCqB7GWLOs9d9fdStCHcG4aPHA6hdZchOcP43laDrmlpjkA9hko8IoXyhWLR78o3MMq
	qKf++VaF+1DR7WGvmwA+hiEkGZ92l7gjNee4uB4bi6NpTcxwcbakxCUq0JvhE376sLiZd3
	cPHUkCUq+7UYzml1iz4Kwwry2yzCP/Qnohz38inFAtbTdJdrq85cLm6X5bCDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1730358637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lZlmnnd6VY4iWOEJN3fR2oAOuKekDnzf7D9Hkfh3i4s=;
	b=sGtRrh1TmkhvP9ZlLKMhQ0lZ0FXZ8/sfgFIA4BgdLlylKgpzgkuo9/SC9HdmX33eO26bBo
	68BW2DAoGgxwWv6yBlFwkTYU4NS2ynRTwoEHRWucHiToEm0PGbI/c2LLdQdO8+mHuZG0N9
	6FBpq3dHwslQiM3r9W0Ul9YIpFYfwQDyRnX27d82bqP6yfD21rxKu8QJz3/PsqPobWjkpi
	ZScoQn7/qG0qi/2VsHZqP0UbtzGu0UpV3dlhcrNLa8zE1QUSo+tRU+YBkSB0u6Z+UVG4PU
	myeN1/qB0zPYzDLHyHKI869mcTpJLR6MZsx2ELfwSleamUsOaZR/emoTTquvIA==
ARC-Authentication-Results: i=1;
	rspamd-65cf4487d9-7gscz;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=arinc.unal@arinc9.com
X-Sender-Id: hostingeremail|x-authuser|arinc.unal@arinc9.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|arinc.unal@arinc9.com
X-MailChannels-Auth-Id: hostingeremail
X-Quick-Robust: 1419273d5740c10e_1730358637300_1131769421
X-MC-Loop-Signature: 1730358637300:1398205219
X-MC-Ingress-Time: 1730358637299
Received: from nl-srv-smtpout9.hostinger.io (nl-srv-smtpout9.hostinger.io
 [45.87.82.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.220.31 (trex/7.0.2);
	Thu, 31 Oct 2024 07:10:37 +0000
Message-ID: <a66528bd-37cb-46b2-90e5-37b10dfa9c78@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com;
	s=hostingermail-a; t=1730358634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZlmnnd6VY4iWOEJN3fR2oAOuKekDnzf7D9Hkfh3i4s=;
	b=NRoo+kQ7pFbuPT6z5Cb6S84fbfJOOj5qAwFha52OFrJ0JExn7Ku/fTJnZajCq05w9LZP8e
	ZLYX0yKjmNbdDVHUMzA3vuRhsyB4Bl3ghIiolEItiM2nEx7ufCGnuGKkBOtrpSDtV0jJhS
	gJMAYQwb/16d3o2JYOnr5GDD529wd194SZBEXJNL/baBcZr10Wj1AsSaSJCRjbtySuiwCq
	iNOW34RKx+CkvPABdc6xFqXjI0sGc7kVAsy+3/VZOWW0IgUv/SDgT9BnhDFLYyN+NHyCGq
	7nl8LYDpOdFTBZoyU8jjJdDPMvdxqD0UOcYlCOPU3k1yuvsnXZ/6RjZgj1OOzA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: mt7530: Add TBF qdisc offload support
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241030-mt7530-tc-offload-v1-1-f7eeffaf3d9e@kernel.org>
Content-Language: en-GB
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20241030-mt7530-tc-offload-v1-1-f7eeffaf3d9e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Date: Thu, 31 Oct 2024 07:10:32 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=OKJ13jaB c=1 sm=1 tr=0 ts=67232d6a a=aGj/nXfi4qz2iMxz7h0kJQ==:117 a=aGj/nXfi4qz2iMxz7h0kJQ==:17 a=IkcTkHD0fZMA:10 a=M51BFTxLslgA:10 a=9B2793jWSBC_Fij88T4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-CM-Envelope: MS4xfJ/GJC6qZKiYCkaiLF9+RV7BmCKM+DnqGuxt3BbelWGFn+juo5V5ssnDAaI+gp5DQHingWLNsB0HgKjnqdqhTgjkwp4qIyLGG/wdcqJ4BQRi7RjE1ymL lOcInGjafAnmffS0+G4chgWYc66e1U4H7UzEzNUKqECwBBY3NMfJ1ChNB5ycVPZnlpswfylUf5lRSNLso1zbtFSQHJZXc1Z0ZlKpAn0HCoWUwWOz70ogd2WD wOr6NVCO23sJdZ9TB4CusHjf+LtX/l3OK6WrDLJCpwD97SlAJ3LssZTVGAH+Uc99M+X5Z43IrCh6YTXESUO+/rjOv1RF/iAQCKRmdELy4h9AYTI5C1j+PhaT Hzo9oY7tEWiDKave1F8Z6sVLxT0m2EcLLIbH/5QGdRLOmqf1RUQ0kMahrobTAsqrgQjrhQhCCMIesvNsriv/ngI3FTy/YVAYfgE1x2lxDDgeIMfMbB1nl19Y WLa5MyppkVUF9KwmytVWGtbe5Jm7UjJvpRKTj+EagFqHR3fLULdGSR4p8MVAqc/bU3JoF/i23WlSynRTDb6ivQYgDBzXPXMPSqEW44iyxS+qcxSnhFVlCZiU B/LfTiwwYS4CQVvPKuC9EIX5Ax1t9Vhkdcd83JXnUi07BbOy8S2WW6+m87wZWll6D83OvkG66K0MfFLg4zsk5Gqb2FnDDLJIGNJVwVIfRUhZoaT42TdpzlgC FtXE4thUHvE=
X-AuthUser: arinc.unal@arinc9.com

On 30/10/2024 22:29, Lorenzo Bianconi wrote:
> Introduce port_setup_tc callback in mt7530 dsa driver in order to enable
> dsa ports rate shaping via hw Token Bucket Filter (TBF) for hw switched
> traffic. Enable hw TBF just for EN7581 SoC for the moment.

Is this because you didn't test it on the other models? Let me know if
that's the case and I'll test it.

Arınç

