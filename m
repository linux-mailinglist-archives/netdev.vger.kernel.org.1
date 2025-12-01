Return-Path: <netdev+bounces-242890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04932C95B91
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 06:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A983A1E69
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 05:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBA31F5858;
	Mon,  1 Dec 2025 05:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="sU57MkhR"
X-Original-To: netdev@vger.kernel.org
Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FEC1F3FE9
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 05:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764567848; cv=pass; b=i1vSqC072F9AZPytR5iLtqNsNjiTXYPgRAZCIeIZHMfMlu4PIRnkDBlHu3VM0aJ2uam2q4UV1raq09abVCQR/AdA5GEHcqiDsECHnjI0HolKGs3ZWZ0MmPOy9C/3S2qC+Q27eMGQBAjM4V3NPEZb6iHYgz8zwVjYM/UjWwLR+Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764567848; c=relaxed/simple;
	bh=zoWi6dHEVV5T/noOsrv1weAPYh2Ex4nIAWtSl3tLx3M=;
	h=Message-ID:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Date; b=D+FGlnTolhYLCAyI1jaA9pjlD/pAI5T+HK41J2w+PhN0WDsmIuGDkC7lupa7liK/+hkXNp+AJ/vwg4SlCFhuTxiu3bFk/UmRXJ0gCVpvD/4t8Q97yAkTTJNEOcyNdy2YUydci4CMvYGorRnZ4WqjW8e14c7JU6WIzCkkinV6BVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=sU57MkhR; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 965F3461538;
	Mon, 01 Dec 2025 05:44:00 +0000 (UTC)
Received: from de-fra-smtpout8.hostinger.io (trex-green-4.trex.outbound.svc.cluster.local [100.99.173.173])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id AE17F461281;
	Mon, 01 Dec 2025 05:43:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1764567839;
	b=lCZpTavjj+QJevt/isT57PbAy3nZjQzq8bSP1JdxmwkSfEVScUnMswpY2nwRDto9FWcoB2
	EPP1f8fJMzDi0CZF6LhnRVfyKhexn65eVGjiaDAIr7N0JgbyalMw/KPixxDa66BzbPbcpl
	R4wm1u8M3BRmn30/kUK7HnwAEuJkrhWDNu2gT6kaZgrA6ai85Q0Mqh4pOVL5R6t7fE9GEr
	mi+bPLM5S0V8IZq7hRzDyKrw43ANeaXevXFPBoyBFMowp+5tpYddoPalA0xRNSBrff+k8Z
	sB+lyxZ3BHp4BFkWX6dHbDVCbm+a1COJ5SHVlBubAhmIMuOWSaX21ejS3vuG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1764567839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=/2/66QBShQM2pf3wt2TUfKNrMoeUzmVAQLpafY28kvE=;
	b=ZZT6B1+mobzBMJhXddyNTdVO1w2+GQQddu94B429TbtYBKRhImynW8N3X6jbZ2TnavE+4z
	eolwxWuYofWmTIqdtmB/+nN47aU3lidgLi9aeX3bwL+RpeRTl2CQ1MUUHqT1Uwq71t8FGy
	GM8ZVvxM3T2oZhH7NAyNTZiUgBq2GzbsRfFWlDh5EGl1TD8Akvelg6dYgH3qznsoJqYa/y
	tnZ7PB3sfRsp3IVTNGHjYG7JyhdBSNQWcVZxNCVVwFEW+/o81mZi7m190wu1fyR9Z3Vkxr
	yaIVtgfa4LiesUlg19W9nl07eeLMQC+ZQ/4lTpQlxDqbjdE2o+oz6MXvSaFUMw==
ARC-Authentication-Results: i=1;
	rspamd-65d9b4cff4-lnp6m;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=chester.a.unal@arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MailChannels-Auth-Id: hostingeremail
X-Belong-Arithmetic: 75b613b749dbd0ff_1764567840527_758012358
X-MC-Loop-Signature: 1764567840527:1272061040
X-MC-Ingress-Time: 1764567840527
Received: from de-fra-smtpout8.hostinger.io (de-fra-smtpout8.hostinger.io
 [148.222.55.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.173.173 (trex/7.1.3);
	Mon, 01 Dec 2025 05:44:00 +0000
Received: from [192.168.65.172] (unknown [155.93.179.162])
	(Authenticated sender: chester.a.unal@arinc9.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4dKXrq2q1Yz3wlw;
	Mon,  1 Dec 2025 05:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com;
	s=hostingermail-a; t=1764567837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2/66QBShQM2pf3wt2TUfKNrMoeUzmVAQLpafY28kvE=;
	b=sU57MkhRRapcQ3GVtRzRIqiiRLy+te0gAE3FYV33QVCpyGkG3EZgU0T4fG0QRfPjDtoQIw
	ZWiQ7/aQ92BbI7b+DSqNtmSUcV+rlfKgn3O7n0BVE89ti9wMBHn8gys50+sZSqiF/qiBGP
	Xa2BYqIpDrpbwgTSrrDQScDUEC3HNKf8fa8GgM8KyNx9kN1VRnsgH8LwEnHusKZDQzJ8mW
	Q4/6XdzxfZhZt1jhHzHnxEMw2TVYhHA7Md/dH39/dP7LfEJOdSqvi6DWN8j3q36ArBJ4IF
	ys/P6/H3BAGMDys368wsrrTswmkhdRL3V+KnUC6GEVa+ge5UO2pCB0dZBWYXDQ==
Message-ID: <3b76ffdf-0206-40e9-9865-a3cbcf6be9d2@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 12/15] net: dsa: mt7530: use simple HSR offload
 helpers
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Daniel Golle
 <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>
References: <20251130131657.65080-1-vladimir.oltean@nxp.com>
 <20251130131657.65080-13-vladimir.oltean@nxp.com>
Content-Language: en-US
From: "Chester A. Unal" <chester.a.unal@arinc9.com>
In-Reply-To: <20251130131657.65080-13-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon,  1 Dec 2025 05:43:55 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=ALriHGRn c=1 sm=1 tr=0 ts=692d2b1c a=M86+Nsf21j+Nx4MJSknohA==:117 a=M86+Nsf21j+Nx4MJSknohA==:17 a=IkcTkHD0fZMA:10 a=GvHEsTVZAAAA:8 a=VT4XjZGOAAAA:8 a=pGLkceISAAAA:8 a=mpaa-ttXAAAA:8 a=8AirrxEcAAAA:8 a=Vsywyeh8_Elo_W9EtLAA:9 a=QEXdDO2ut3YA:10 a=aajZ2D0djhd3YR65f-bR:22 a=6CpsfURP9XNmmWg3j1mJ:22 a=ST-jHhOKWsTCqRlWije3:22
X-CM-Envelope: MS4xfB0SvOOIRuDQETLGQitZ8Ry2wTgnrVfPDTm5Zb29fXV8iukT8mUvK5QPOtUgDsPGiWxOX9nWiaQoHf8OXO46ovuzhshaUTxR65NUkw6XZ3zuiETm6d/R qc10FpM95b9vSGntxqYXIniF6Q+mgE1FTS9mafvwGW2efZgadkb0acDLBU/iiQHgrBvvfZEG/77q8EIIrU3IPHs1cBc762fWbqbACxi+7JYmodIAu7nNsx1K J0VZ027qWQO01Hb+6uSPdwxv1ar1qEK44QKrc65a+cL3DrWSdrTecF1MOSH37GQ/fHp8Nb6EHhUWucixEgB06A7m3TAIbG44sv056Dcl7Ch8jBA1gOHS3PaN wqNssr4p1RKDnjwEmkNv4QvF0wFZSA==
X-AuthUser: chester.a.unal@arinc9.com

On 30/11/2025 13:16, Vladimir Oltean wrote:
> The "mtk" tagging protocol uses dsa_xmit_port_mask(), which means we can
> offload HSR packet duplication on transmit. Enable that feature.
> 
> Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>
> Cc: Daniel Golle <daniel@makrotopia.org>
> Cc: DENG Qingfang <dqfext@gmail.com>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Acked-by: Chester A. Unal <chester.a.unal@arinc9.com>

Cheers.
Chester A.

