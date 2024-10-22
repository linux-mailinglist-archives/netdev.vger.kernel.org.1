Return-Path: <netdev+bounces-137691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FBE9A955F
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 03:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 571D3B212C2
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 01:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C8C84D0D;
	Tue, 22 Oct 2024 01:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgCOkLf+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3893326281;
	Tue, 22 Oct 2024 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729559945; cv=none; b=GUlzbvCPh5BP6AJAOjjHtgM8F87ydgGI2be109B/Xx2pSMePQlqlNBr/kOZ8V3rLYBqKDR+BOefxJfozh2tdrcUCWG/g49+GfQdmqMRrVx8y+xDl65TKOApEnUpJLIHmgr/dvlkZMjesD/wdJH2X4htMMBrQy9MeiKk/y2P0gcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729559945; c=relaxed/simple;
	bh=yEDPlRP4Zj2HkaRjjpu9urRnnUFC3BzEpEjII9ko2Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEJKwIi0+n2C5l16QQSG1eTlZfdGr8FAq6yuzmHB7VeLrxVqahK7kHDFrO+Y5Bxd/CJ4e1utxT+jrutnlaJkLmjSUw/3PVkk+qzru/vLeK3f7aAq+dxvS0WBgdEKojYAyAluiUZ+7PjVRoKMgoRMdUwa8lU1fMQ7LPUqzjSzooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgCOkLf+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cceb8d8b4so28817135ad.1;
        Mon, 21 Oct 2024 18:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729559943; x=1730164743; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Udq7Pu1p+Owher5kcrl4GtXAZn/1l1iX1dmy+iMLMoM=;
        b=HgCOkLf+wAarOjxWUE3NsBM57mfFZXBMDFmmS7RUqEmgblRLmUSdWRVs2a3bMM7eOI
         HnCPFYZg9Bah1bYMxQ5ch3eQb20rE4bDnkNJMl4xu4JbO2qQPW/duVcIHMF5OnmdsPm9
         bQhZTqkuVej3nYNgTMUIarbR/oTYMWmJht0sdOH8w+A8k6XxeWXuNv9aY00c4L0Xu3m/
         zMrEz19PkABhBvQyjx1Rb0xHyL6iU4UQU4hb+V7wRTdljNMfLonWzz+uHKP0L33xLeUR
         7liWitIML0pRBCzPHUGKF6B/IqIg15IpXuxe9bbT7SZkRzEZGXhynq91YjlOv7sU9WCp
         8TWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729559943; x=1730164743;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Udq7Pu1p+Owher5kcrl4GtXAZn/1l1iX1dmy+iMLMoM=;
        b=rGERJPQYkt8rvtDN/swlsCjnFRllcaEwYy+WxvYUnHqrLB8rPM4UujLkxrlZEULp5A
         qHFmvIW8Z2RkJU3SnJGd3eMm2/bLdPSnwmxBccXTfBGhBHRrExTsFMADbfTsfqzSDHue
         svaY8XMgngP2mAj2nXw8dX/JsdBM0cqSTgtb3YgWwzWqcOWLzkc7oVVLEGPPFA/m60iN
         t3NHCglgdwPd9W3ATM80AHrsGgPFp6R4i6RhmDmVjpHGKUNydKsnVixYC6+9TE7lM4JD
         rypB64R5d7ezlWkYpoKdRKhCxlBhcr4x/d9VjMiyJ1/zwMiGHnN2OST1dPkIpK4aKmnk
         s3MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxxIBOYqqp1EDGbL3PrAfGH3UyKBiNNCd6Rpw3MVY/6nu9m8+BtUtIShn0tvvZN7n8MX50WmNKR6dFc60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw/EfXmXF/rId7nt2uwrLpa3OoB7oBdEmnNpbRaVlLFTGAKK1/
	0G2sda50JCqlZ7uyoeBl1vNTecINHfl2FCOhav090W2LSSiWumGy
X-Google-Smtp-Source: AGHT+IGvblNQVsQOPVgmT1x2wm7zqYjNUuoqztt7cfO8OQ+0Fg+y5/stRxfdy1AblmI2Ld1bmpRAfQ==
X-Received: by 2002:a17:902:d2d1:b0:205:5d71:561e with SMTP id d9443c01a7336-20e970d57e0mr22078415ad.26.1729559943396;
        Mon, 21 Oct 2024 18:19:03 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f12ea2csm32077375ad.62.2024.10.21.18.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 18:19:02 -0700 (PDT)
Date: Tue, 22 Oct 2024 01:18:56 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: add ns target multicast address to slave
 device
Message-ID: <Zxb9gD7bc9v4OPE1@fedora>
References: <20241021083052.2865-1-liuhangbin@gmail.com>
 <58777.1729526711@vermin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58777.1729526711@vermin>

On Mon, Oct 21, 2024 at 06:05:11PM +0200, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> >Commit 4598380f9c54 ("bonding: fix ns validation on backup slaves")
> >tried to resolve the issue where backup slaves couldn't be brought up when
> >receiving IPv6 Neighbor Solicitation (NS) messages. However, this fix only
> >worked for drivers that receive all multicast messages, such as the veth
> >interface.
> >
> >For standard drivers, the NS multicast message is silently dropped because
> >the slave device is not a member of the NS target multicast group.
> >
> >To address this, we need to make the slave device join the NS target
> >multicast group, ensuring it can receive these IPv6 NS messages to validate
> >the slave’s status properly.
> >
> >Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
> >Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> 	This seems fairly involved; would it be simpler to have
> bond_hw_addr_swap() and/or bond_change_active_slave() insure that the
> MAC multicast list is configured in the backup interface if arp_validate
> is set appropriately and there's a NS target configured?  That will make
> the MAC multicast list more inclusive than necessary, but I think the
> implementation will be much less involved.

You are right. Limit the mcast list only on backup salve would be less
involved.

So I will do:

1. Add mcast list to all backup salves when setting NS targets.
2. Add mcast to new backup slave, remove the list on new active slave on
   bond_hw_addr_swap()
3. Remove all mcast list when release slave
4. All the changed need to be with arp_validate and NS targets configured.

Thanks
Hangbin

