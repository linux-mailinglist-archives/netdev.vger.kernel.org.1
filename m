Return-Path: <netdev+bounces-92710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E445E8B85A4
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 08:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133C11C21846
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 06:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61E229CF7;
	Wed,  1 May 2024 06:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRTMETOg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5232628C
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714545698; cv=none; b=gNutH0nRdzRVKGAjKa1mOUSIhxxmxhHPinejoe3qs8n/aiF+bqcu4UjcQC1MGcCqyFSh+A+HWmpGSlp9/9LujfW2Q/29cNV0TCkpBvdwQuGNvsVyrAf3j9EaG6qF71x9yvwgkY1/X+v+IB7Z49NYwnQ9gnX0ETUCTwCvBvh1/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714545698; c=relaxed/simple;
	bh=PlnMElZK6br76oHvMwqt7GLHJvIxgKorT1eqTKID5a0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=id+oAn5et+yW12j/fDDE6uk4GLUTbQ+q+aFD3QUj/EQkh8MzRZF9NWBU+ZGLP4URZyFMLl/wl08DN0g9DFKeCmfJlUQjxvZjXJibqjtUIbM7N5UP01kvorSfpoVdVK1+6cUZKV1p6YMVId6GeDCMDtaL4WXbs2Neju75UtpHKdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRTMETOg; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c73b33383bso587531b6e.2
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714545696; x=1715150496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T47aoYAIR7f92gk4QGHd2b5qSxJv1DPgAn45LG/w9gA=;
        b=ZRTMETOge8RxnkusmzdkBHx3fpa1iVgs5BSTST2rHtDSLLiXJnsPA2Bq3+2zS4Y7Fd
         HldIDf0L7BASdQ31zNzN6sxkpjxhDFY5EEDjzMKSVyFn1nUWvECBPuOC29Ui5DOFP65M
         KhIL3o6KEX3Iq+uYRFzLUEndaQcAGok8EMz7HNHiBCr+KTuK7efWilByopqFPb+DL1jA
         uPluwFaTAj+Pavuw/VTh0dO+GUk8L/ohyfrpn/eK7OOWR6yFhw67bR1OzKXhdX/tcK8P
         5lLUz18URjUlHlwC83pDAMwMfwxuuhPCNZuu3mnivQ1jCNICo3bAZhBGN16X6PBxhKXL
         d+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714545696; x=1715150496;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T47aoYAIR7f92gk4QGHd2b5qSxJv1DPgAn45LG/w9gA=;
        b=hvWbY59Z7VFJeOQzXfrhdGQV2qGYPEa+AMEUQIOKyNRZk7zRycl4Meao2HARD7eOA8
         o1finVeMMMf0i1SJZvaJ3qPdlulGXjs28jB1hmImH5VQpV769mR3pk+fyqA2ta0804Nl
         b3s9ya1zCo4l1pX4aPiKAXNhYw4jSxmS8z3aFNJ3oJyBRvkra+5vu66kb9caxu9dOaxP
         40Ldy1Q28gIe1tlL9ZnrEb/NADCjxB8kgwUpLfuHwoTNCdRV7eKd0LOOlOgGRqgFTgE6
         ont1tarw7U11d4wR8Mv2LF/lBrGXmj3yGQnPBKuGChefxrZ9G/A17RjhMmKcadAfqjaq
         hCzg==
X-Forwarded-Encrypted: i=1; AJvYcCU+7tajXa3gJFJiMQFI/MvKlxZUTFdgNFyt1lTfPPgynkifX73EQo+tcVcPi40ioYJTChXei4SGryAm1suS2DgO1IjVKLfB
X-Gm-Message-State: AOJu0Yw4Gks/zFDokee/nl9HSP6+Njt2mwPOkU/lKGYZfnFElWvDtRzb
	c0/Jom0cuBpbppWYahJXneR67NYY0fgF5VT+JHQUIOXR3HKL0mxa
X-Google-Smtp-Source: AGHT+IEqP50rxqgoSogInMjScCUMTP6TG9acgIMeU3KJQ3wVG6EPSRPhCdofEFdds7EWIF+tJRujXA==
X-Received: by 2002:a05:6808:200d:b0:3c8:4de7:6736 with SMTP id q13-20020a056808200d00b003c84de76736mr1991319oiw.4.1714545696335;
        Tue, 30 Apr 2024 23:41:36 -0700 (PDT)
Received: from localhost (p4300206-ipxg22801hodogaya.kanagawa.ocn.ne.jp. [153.172.224.206])
        by smtp.gmail.com with ESMTPSA id ga23-20020a056a00621700b006e7243bbd35sm22818795pfb.172.2024.04.30.23.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 23:41:36 -0700 (PDT)
Date: Wed, 01 May 2024 15:41:32 +0900 (JST)
Message-Id: <20240501.154132.1306102883120815828.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, jiri@resnulli.us,
 horms@kernel.org
Subject: Re: [PATCH net-next v3 6/6] net: tn40xx: add PHYLIB support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <9ec24d8f-62c4-4894-866a-b4ac448aaa9b@lunn.ch>
References: <20240429043827.44407-1-fujita.tomonori@gmail.com>
	<20240429043827.44407-7-fujita.tomonori@gmail.com>
	<9ec24d8f-62c4-4894-866a-b4ac448aaa9b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Tue, 30 Apr 2024 22:58:17 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Mon, Apr 29, 2024 at 01:38:27PM +0900, FUJITA Tomonori wrote:
>> This patch adds supports for multiple PHY hardware with PHYLIB. The
>> adapters with TN40xx chips use multiple PHY hardware; AMCC QT2025, TI
>> TLK10232, Aqrate AQR105, and Marvell 88X3120, 88X3310, and MV88E2010.
>> 
>> For now, the PCI ID table of this driver enables adapters using only
>> QT2025 PHY. I've tested this driver and the QT2025 PHY driver with
>> Edimax EN-9320 10G adapter.
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> ---
>>  drivers/net/ethernet/tehuti/Kconfig    |  2 +
>>  drivers/net/ethernet/tehuti/Makefile   |  2 +-
>>  drivers/net/ethernet/tehuti/tn40.c     | 34 +++++++++++---
>>  drivers/net/ethernet/tehuti/tn40.h     |  7 +++
>>  drivers/net/ethernet/tehuti/tn40_phy.c | 61 ++++++++++++++++++++++++++
>>  5 files changed, 99 insertions(+), 7 deletions(-)
>>  create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c
>> 
>> diff --git a/drivers/net/ethernet/tehuti/Kconfig b/drivers/net/ethernet/tehuti/Kconfig
>> index 4198fd59e42e..94fda9fd4cc0 100644
>> --- a/drivers/net/ethernet/tehuti/Kconfig
>> +++ b/drivers/net/ethernet/tehuti/Kconfig
>> @@ -27,6 +27,8 @@ config TEHUTI_TN40
>>  	tristate "Tehuti Networks TN40xx 10G Ethernet adapters"
>>  	depends on PCI
>>  	select FW_LOADER
>> +	select PHYLIB
>> +	select PHYLINK
> 
> You don't need both. PHYLINK will pull in PHYLIB.

Fixed.

>> @@ -1179,21 +1179,25 @@ static void tn40_link_changed(struct tn40_priv *priv)
>>  	u32 link = tn40_read_reg(priv,
>>  				 TN40_REG_MAC_LNK_STAT) & TN40_MAC_LINK_STAT;
>>  	if (!link) {
>> -		if (netif_carrier_ok(priv->ndev) && priv->link)
>> +		if (netif_carrier_ok(priv->ndev) && priv->link) {
>>  			netif_stop_queue(priv->ndev);
>> +			phylink_mac_change(priv->phylink, false);
>> +		}
>>  
>>  		priv->link = 0;
>>  		if (priv->link_loop_cnt++ > TN40_LINK_LOOP_MAX) {
>>  			/* MAC reset */
>>  			tn40_set_link_speed(priv, 0);
>> +			tn40_set_link_speed(priv, priv->phydev->speed);
> 
> You should not be references priv->phydev if you are using
> phylink. When phylink is managing an SFP, there might not be a phydev.
> phylink will tell you the speed when it calls your tn40_mac_config()
> callback.
> 
> I suggest you read the documentation in include/linux/phylink.h
> because this is very wrong.

Understood. I fixed the code not to use priv->phydev (except for
phylink_connect_phy).

Looks like phylink.h recommends using mac_link_up() over mac_config()
to get the link speed. So tn40_link_up() stores the speed in tn40_priv
for tn40_link_changed(). I also tried mac_config() but state->speed
isn't initialized properly.

