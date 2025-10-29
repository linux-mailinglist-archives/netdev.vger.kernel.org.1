Return-Path: <netdev+bounces-234139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60839C1D1C8
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 21:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 563D84E25B3
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C8935A924;
	Wed, 29 Oct 2025 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b="dKs5o5Wn"
X-Original-To: netdev@vger.kernel.org
Received: from out13.tophost.ch (out13.tophost.ch [46.232.182.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF0219CD03;
	Wed, 29 Oct 2025 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767893; cv=none; b=aKwW8tpf68kGd0+Ax+pSI08g0mmludjaT+nZCGL1njqMKSL8MPlHSJhl/VwOoWzNBoBDENf6GaWMYjQT+XbhJIk6fd+mfvfcfDM70rl0kGWKnR+WRND/KdLf2PgJYKcjOB6HU2GqXOy9VLh7TC96WP55/hOa3dRfhSjizIAmLkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767893; c=relaxed/simple;
	bh=ltjoMQkM6SW1fXX8TY/fSWlebanil7DV1Oj2nqP5S98=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdGKMRE3LZklp92vPgIfkcJUJvAsaJVQ7YKMhB+NJ29dniCufwT9F3NmEHj9o8cCRAtY2a6Pij1J5gxnxL87q0CuIejznj/PaGzsR4VOwk4tT6yuuqqr0DRNW81LKkBnk+fO3hjSceKN8DO3J2yA9mtCQX4SZT7XmbU/cVZylZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz; spf=pass smtp.mailfrom=wismer.xyz; dkim=pass (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b=dKs5o5Wn; arc=none smtp.client-ip=46.232.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wismer.xyz
Received: from srv125.tophost.ch ([194.150.248.5])
	by filter3.tophost.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1vEBxo-002P6Z-FH; Wed, 29 Oct 2025 20:36:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wismer.xyz;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gIY+isczuoHXgBvOO+aoOxjAT4sGIWT15/l+osGBmmE=; b=dKs5o5WnlSo2lhNafdHUX0Xl6h
	DaklvUrlmbdf06XPj3PLVp63TZXh4e3HwXGeOW8hfih11euPqG2t6stTMZTQ4gdc1o9H1L3OSstTH
	//L6ujyHIlT28R+BOv5200Lh1VaGJz7XPMSMo2g2s+Em2anPyuKClcYiu0kxgqsVnb2RNCZ3bdetw
	4IQNs69hhrxewP+aVZTrJ+Cn0Dk2RFpHIKRCjnbocspM4IujOz1dHv7dSW7oSOdPkROJ6j/lPVOV9
	Y/N3Co7FxHGstGC9thLeC7ZHZmfMf01rmwr6kvC9vRfWxDGHux0Dw9XZgI7+cVdI8+LEqpRG+TBvI
	nApxKXKw==;
Received: from [2001:1680:4957:0:9918:f56f:598b:c8cf] (port=44690 helo=pavilion)
	by srv125.tophost.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1vEBxk-0000000BFPq-3rRt;
	Wed, 29 Oct 2025 20:36:03 +0100
Date: Wed, 29 Oct 2025 20:35:57 +0100
From: Thomas Wismer <thomas@wismer.xyz>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thomas
 Wismer <thomas.wismer@scs.ch>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: pse-pd: tps23881: Add support for
 TPS23881B
Message-ID: <20251029203557.286adaec@pavilion>
In-Reply-To: <aPtZ1jE7D7JI2wic@pengutronix.de>
References: <20251022220519.11252-2-thomas@wismer.xyz>
 <20251022220519.11252-4-thomas@wismer.xyz>
 <aPtZ1jE7D7JI2wic@pengutronix.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Get-Message-Sender-Via: srv125.tophost.ch: authenticated_id: thomas@wismer.xyz
X-Authenticated-Sender: srv125.tophost.ch: thomas@wismer.xyz
X-Spampanel-Domain: smtpout.tophost.ch
X-Spampanel-Username: 194.150.248.5
Authentication-Results: tophost.ch; auth=pass smtp.auth=194.150.248.5@smtpout.tophost.ch
X-Spampanel-Outgoing-Class: unsure
X-Spampanel-Outgoing-Evidence: Combined (0.50)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuV5syPzpWv16mXo6WqDDpKEChjzQ3JIZVFF
 8HV60IETFiu2SmbhJN1U9FKs8X3+Nt208ASTx3o2OZ4zYnDmkLm5Mv/tafLC72ko3Lqe/Da7zAy+
 i6SmItLXxqJRd5s9GHEhfeXMyWnUQjjMD4JK3Wq2CtmoQhY2xrBb8C+tWUvqrqBKsSdhvd/J5sX5
 daZjkYv0hq6Ot6Cbd9hg3807OZKQzthz0vNkOX8Em4cj6D/wddIY3ooDH3xmALJ0KCcsszI9W7vD
 6C469DIPe8wH3iOJ3xyMg3et4b3PQUopDmbZCssYHNuxAmlPRpR5yzngsxCROUzReCS8EpKh0It9
 L25JS816nuiE0t5pG6MLXGczoanVmeCF7bI0BP7dENKtPTBPq+vGO3Vx+SwwWschmkdvs376y2A4
 OBi1/UyqO7jQnnICeA+KlS7G8xqewTcs6w6HLg3eq1lKkYVFbZT99AeINpdbOTIWFiLv1jhppNXa
 xS6MN8xFxlxHZge6OlcoYA//qN5p5dmu6xjQN9nmCfj7VmpmZJyx9iy0UVkVD75IgLollI+8fg4q
 Ktu8I/h2Z0dHZM6qE0STp2v0JiRE8jha5ZR/nf5efcITxrfNKzy0W9Bd37g8M9SCqD8uOq9nJ+Mm
 AyVp7BgHET6y8CCeFlQ7QPOIjlkSAfAYMUguLL/iJ9vYqKPILmSoZcvfXhdPMA/OB6L3DS5gd1SE
 E3USj80Z55NePwA7jxwlhcjVdk/mr85ytrd63MVeviF0i7IZfcqGEigUra+zu74YMVqBb/nqBf/o
 O9ENx2nriip8WhgYbnEnhEbOEzk5yB9ZHNSFnOUf5Q/AoIx5sTYq7iOI4vCrDScUfr46OzpJNOSz
 cdwyiT3dKxLhoxcmaInYbR5vlqGvSe+dDtUIqP45C5A7LqP3b1xqO73zx9HsLZFTQ55zlz9aPc+7
 R744868L+j9WjFdaiDCoaRMMLJurWmXEnoYHaIfVaCHpEB6cFH6WJxE4ZpdasxsGznVQ8gQCuamI
 BuSMQbm8EO3yB6VDgSYBI/flWeVLIyRMJwJzjdCk/1Dnf1QSo1zEvYJi0O+7gv2MANPskD2hG/WB
 q49TQI4s7Zk25QzEh4fdO1UVosIGSxnPvA8wgBLtVZogJpSXh3l1gykJmv2lNIo4lDSAwCBIOnEB
 yG0AYw9A3oZxIE5agCoT+OGQMyqZyz7BkGrhC6ClamPcYkOphAAFfgHXTJlYrv1wUec8VPZi63hI
 VDdSxAySkA2y1dwxX/fOLxBYDd5BmItKTzNBSIyW/mb8GD9YbxmVCZr9pTSKOJQ0gMAgSDpxAXyp
 F5LUwHZNY/+yVAGZIWgbevr4I2GfjWs7NecHzbPrZnM57PQ4Zhz+lPAiIO8rB9tRBN1MQm1SbNQ8
 mfig9wuAva9NlDz7O8ptuOziYJtS9jihx+Za/cV70jOJzN2r4A==
X-Report-Abuse-To: spam@filter1.tophost.ch
X-Complaints-To: abuse@filter1.tophost.ch

Hi Oleksij,

Many thanks for the review.

On Fri, Oct 24, 2025 at 12:49:58 +0200, Oleksij Rempel wrote:
> > +		/* skip SRAM load, ROM firmware already
> > IEEE802.3bt compliant */  
> 
> TL;DR:
> 
> A more accurate comment would be:
> /* skip SRAM load, ROM provides Clause 145 hardware-level support */
> 
> Longer version:
> 
> Please reference IEEE 802.3-2022 (Clause 145) instead of the "IEEE
> 802.3bt" amendment:
> - The IEEE 802.3-2022 standard is free for everyone with the IEEE
> Xplore program.
> - The "bt" amendment costs money.
> - Using the free standard helps all community members review this
> driver.
[...]

Good to know that the IEEE 802.3-2022 standard is available free of charge.
I'm happy to adopt your accurate wording.

> [...]
> > @@ -1422,6 +1442,10 @@ static int tps23881_i2c_probe(struct
> > i2c_client *client)  
> [...]
> >  
> > -	dev_info(&client->dev, "Firmware revision 0x%x\n", ret);
> > +	if (ret == 0xFF)
> > +		dev_warn(&client->dev, "Device entered safe
> > mode\n");  
> 
>                 return -ENODEV; /* Or another appropriate error */
> 
> The datasheet states this happens on an "un-recoverable firmware
> fault." According to the datasheet, when in "Safe Mode," all ports
> are shut down. The device is not in a functional state to act as a PSE
> controller.

The datasheets (TPS23881 from May 2023 / TPS23881B from May 2025) state that,
regarding entering "safe mode", "any channels that are currently powered will
remain powered, but the majority of the operation will be disabled". Because the
rest of the driver code assumes the device to be in a functional state, bailing
out here makes perfect sense.

> > static const struct i2c_device_id tps23881_id[] = {
> >  	{ "tps23881" },
> > 	{ }
> > };
> > MODULE_DEVICE_TABLE(i2c, tps23881_id);
> 
> I guess tps23881_id should be updated too.

Agreed. I will fix this.

Best regards,
Thomas


