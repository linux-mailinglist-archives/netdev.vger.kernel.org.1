Return-Path: <netdev+bounces-114215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2347F941830
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22451F24C41
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722F018B46A;
	Tue, 30 Jul 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OV/dWEam"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E750189502
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356299; cv=none; b=EVOaqZCQe+/daidM6Ikem3r/uiDavKBbJ+krz7yJQS16Q2WRcL+icmdxPRaLhtMV2uXeQmx/1QcL/lQVE27rO8TFHFOOD/MJ61jY40WcR/hV9CJ8xmTbYJZnyOHsdLj70eqaDfM4+nZYeNop9rp+wSaA320hwNM1LQl7yFdzGNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356299; c=relaxed/simple;
	bh=GPiczYBJ3Z+pTVjQ8qSRIvCESPTDoFPmAj5IoCxFtEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0hRv32QFpnS0Dp9gfRsXe+E+vazBCGOglBpL/JCphYtJ0BChDDue7iXJAMAVo7iT3FwQgGMh515ioxQXfifBL+CjEjvoQ8EruE+umb6uqPsWt+ZxkPX83gXjsXSjd7eGker/95zAwZfcspeJJUaMStWHbRx3hWQFWiuO058kOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OV/dWEam; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2AE060005;
	Tue, 30 Jul 2024 16:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722356295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AnQldXWFOHsFfVryyM8HJdri588IlmaG525O54nS2IA=;
	b=OV/dWEamiGo0KWBw1DUNPpf/0kji/4Na3t0r53wYA27WAOiq/fUcQOuI79odQe08EMHZf4
	B8mItXC9IjVMvMG0iVKQbOZIf1j4xUfKIfxOHVxY3PRIfK8a4vJ99F+VyF4BiLs8yGtJ6z
	B155D0SnSwauNxoO/WtSM5TigT2wXAVlwcrUlAmDsifL3QXKlODdI+3zvuCtusV8sOgRho
	JLU51sDPDiS8BRgiihCZbEZbUJCPiOEaFgI2Iu2mhCTCM06NGgV2E7QH/ZLWWRu86dtOdm
	kxQpgt1CqqUiGv6am425/hX6Uk4Jk2HHqwJodcEDt57r60zWVU2ch2Fdy2BPEA==
Date: Tue, 30 Jul 2024 18:18:12 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Kyle Swenson <kyle.swenson@est.tech>
Cc: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
 "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: pse-pd: tps23881: Fix the device ID check
Message-ID: <20240730181812.5fc002fb@windsurf>
In-Reply-To: <20240730161032.3616000-1-kyle.swenson@est.tech>
References: <20240730161032.3616000-1-kyle.swenson@est.tech>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.petazzoni@bootlin.com

Hello Kyle,

On Tue, 30 Jul 2024 16:11:08 +0000
Kyle Swenson <kyle.swenson@est.tech> wrote:

> The DEVID register contains two pieces of information: the device ID in
> the upper nibble, and the silicon revision number in the lower nibble.
> The driver should work fine with any silicon revision, so let's mask
> that out in the device ID check.
> 
> Fixes: 20e6d190ffe1 ("net: pse-pd: Add TI TPS23881 PSE controller driver")
> Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
> ---
>  drivers/net/pse-pd/tps23881.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
> index 61f6ad9c1934..bff8402fb382 100644
> --- a/drivers/net/pse-pd/tps23881.c
> +++ b/drivers/net/pse-pd/tps23881.c
> @@ -748,11 +748,11 @@ static int tps23881_i2c_probe(struct i2c_client *client)
>  
>  	ret = i2c_smbus_read_byte_data(client, TPS23881_REG_DEVID);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (ret != 0x22) {
> +	if ((ret & 0xF0) != 0x20) {

Thanks for the patch! I believe it would make sense to use defines
here. At least for 0xF0, and perhaps for 0x20 as well.

Maybe:

#define TPS23881_REG_DEVID      		0x43
#define TPS23881_REG_DEVID_DEVID_MASK		0xF0
#define TPS23881_REG_DEVID_DEVID_VAL		0x2

and then:

	if (FIELD_GET(TPS23881_REG_DEVID_DEVID_MASK, ret) != 
            TPS23881_REG_DEVID_DEVID_VAL)

(totally untested, of course)

Best regards,

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com

