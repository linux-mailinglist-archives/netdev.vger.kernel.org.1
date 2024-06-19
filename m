Return-Path: <netdev+bounces-104723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD3C90E20A
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 05:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D67E284C0F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 03:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB818224D2;
	Wed, 19 Jun 2024 03:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l99AFQvg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888A855889
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718768675; cv=none; b=pt3msw1MjhILePJ0w7ZlsAWtZ2OLSTJEZtFI1bW8hcJSN74RTCxmOskHW+rgnkEi/GHKr1yga8cYKUeLIS/xDeVTUS+eGyiLDVReezwuwxbk69lhvJ8lIxue/paxXgwNGt9HO1g8DCNsUsHkjMMH1gLtyAXdQO4GpRhgdeYgwUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718768675; c=relaxed/simple;
	bh=RezwEhBG4pY0+3LnrIHXGXZYqD7j3FeHndWI5NRKp2A=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kYL5Giww/mLZlo3sKX9USpn5mEJ8s7ZjgIaBpKA93bgVgP8e/3irv1am9NFvhV//OI8/uh8orsh9xAfVQ7zY13RHStrkyAS4wte5UCrygnXVqUqXgLIHWzr2e8/Qc/lwEP8IAyJ1sX17NgqHQBy/rbkkdAjZdchym/O+yrEwS3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l99AFQvg; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7119502613bso10613a12.2
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 20:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718768674; x=1719373474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6DD/TxmtbY2Z3lb3MnhzUCploT2tpGpOWEq8wxSKHY=;
        b=l99AFQvgiB7ZqRyTPVDyzSSUBExcNbLKkoHDeW/hgCO46IhfBjo0yJ4nBVNnTvh93Y
         R5rqdNSm8kVWkZtiVZZ40zi3URjm82/JdiynY5t0bAUUm1qV+Juxv+xuSd85ksV3b+VN
         B3oNVTgB/bc9o8hi2GB3jG4dBrMGJhcmcIHVXng1neOicmK3qkBP8agJrjhtybtJFA8z
         hufAsG8Fp4N2vavh/UcFMmuAwdYeIg8hw9rJU0lTYNgAioSAcoi4l1kUa97xCo4tTnlt
         rZvOS/Il35eq5ZhpKi/YDccTCwX+sV0E/eguAkTkN/X7/LIKVyZ/xO1J1KAwOqwxN0ta
         M1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718768674; x=1719373474;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b6DD/TxmtbY2Z3lb3MnhzUCploT2tpGpOWEq8wxSKHY=;
        b=JzghuHcHPZCqYUb7mvznfLiezRj9VYIXGKSIAr1SJy8jirZLv6ukZ1m4iCwmbsrK2m
         MoMH4pvPy1i5WQ1zsn+pUofBnidx5vd9F2nzUYV0mEYuiNutPqQvPLGwV1Nk5HsAHgU6
         lZrCBN+RPF30hplCji+jCO/QcsLMxToB4l0Ua03a+wA0lHggiYSTJuZzbz4t/7nnSNtq
         /egfDAoE8eGOpu/AsqDv2l2opm+hfRg8JLz5zLeVXJfrjw1NSe90otMf7SgbTeWYbm1s
         iEW3Wf3lX0iVdCZ1GwCihi7axgKD4RXF8CWTUESNrLK8y0ldwEZKk/ooOTChgzMpPrxM
         Bh8g==
X-Forwarded-Encrypted: i=1; AJvYcCWIbj62sCf9rBPDbzovVfzd0TU1fVxtYygaXe7f11fUV+ez/tG1gBUI/x1Qyz8ANPnl8iHqm3/nUQo6IMvV6h1uhnDBuMBe
X-Gm-Message-State: AOJu0YzioAxEwho7O7hHcA8jwgdSvRPSIXwO+KhlvV0BA9IM9aNACagk
	eYN60cELr8DdkMxiz0YPZVIE3/wphBxj79+DmM26bQ2ipj09U5Ln
X-Google-Smtp-Source: AGHT+IGTmAvw8l+6GNU3YbTgjCBUnv6LhfDesDZrCHGR/8MBXcaOCT0WdQEkrMxsW7MsiFGFumaP7g==
X-Received: by 2002:a05:6a00:1782:b0:704:23c3:5f8a with SMTP id d2e1a72fcca58-70629c13833mr1631243b3a.1.1718768673716;
        Tue, 18 Jun 2024 20:44:33 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3deb4sm9660238b3a.127.2024.06.18.20.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 20:44:33 -0700 (PDT)
Date: Wed, 19 Jun 2024 12:44:22 +0900 (JST)
Message-Id: <20240619.124422.478553760916754787.fujita.tomonori@gmail.com>
To: kuba@kernel.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, hfdevel@gmx.net, naveenm@marvell.com,
 jdamato@fastly.com
Subject: Re: [PATCH net-next v11 4/7] net: tn40xx: add basic Tx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240618185000.1ecc561f@kernel.org>
References: <20240618051608.95208-1-fujita.tomonori@gmail.com>
	<20240618051608.95208-5-fujita.tomonori@gmail.com>
	<20240618185000.1ecc561f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 18:50:00 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 18 Jun 2024 14:16:05 +0900 FUJITA Tomonori wrote:
>> + * As our benchmarks shows, it adds 1.5 Gbit/sec to NIS's throughput.
> 
> nit: NIC's

Oops, fixed.

>> +static int tn40_start_xmit(struct sk_buff *skb, struct net_device *ndev)
> 
> return type should be netdev_tx_t ?

Indeed, fixed.

>> +	netif_trans_update(ndev);
> 
> I don't think you need to call this, core sets the trans time
> all by itself

Got it, removed.

>> +static void tn40_link_changed(struct tn40_priv *priv)
>> +{
>> +	u32 link = tn40_read_reg(priv,
>> +				 TN40_REG_MAC_LNK_STAT) & TN40_MAC_LINK_STAT;
>> +
>> +	netdev_dbg(priv->ndev, "link changed %u\n", link);
> 
> shouldn't this call netif_carrier_on / off?

According to phylink doc, a driver shouldn't call them?

>> +		mdelay(100);
> 
> there are 3 more mdelays in the driver, all seem like candidates for
> being msleep

Removed all the mdelay calls.

Thanks!

