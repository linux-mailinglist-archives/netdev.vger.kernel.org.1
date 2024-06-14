Return-Path: <netdev+bounces-103450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A389081C5
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 04:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEFCA1C216C2
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 02:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C127183083;
	Fri, 14 Jun 2024 02:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1qQV7c2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8762138495
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332927; cv=none; b=iWEtJiqdiPqTmoDSbKkmmkYoZAbTW6o+DSR5fYuk0SqNELaMQacNqBnCbjXGpYX2jWguWN8Ex9K3mH/mU4IOb1QxQPliWmzG5vdWtpGxR2AEB1lVv7lVotJaudWtQ6kmaV+JbbKElSaO0DFfG1ewSr4X07nZLydSIhcNWGhQm7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332927; c=relaxed/simple;
	bh=eJcfdaMdA07SaswdyNBflb0Ypzy5RD1D/ZaEDlKmL+c=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CKKO66MQVYYQDpb0c86fIV1A6S+9S4m2wVoHiAC68hWhSatGUfdNmQ3wIRowBYzvIMmSapvK/Moge6dPCFAyIFBtpqmVkWxoUSjtHFsOWpLS2718U2g2KOY0/vsxkKnfmx72H+e6aS2a8fkfKy3vDaK/l298+Idu7TlIvs5nF0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1qQV7c2; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c2cb6750fcso282243a91.1
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 19:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718332925; x=1718937725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXcTiESkKmSEI3/A7naH7yCYLW8EORfhzjr241vKkZM=;
        b=F1qQV7c2XarnwV+Hl2WZ8dCezB8MJN4TOOhhlwd3LOU/sX5UZwwNxH1ZWO/CSHO7Wh
         KTfCWTQX758CW5B0TxExRL66y0aqKCU9BLyAwRKGr7u0U5/HsLwLq2F0Ohg+jPC6oNQw
         llsJa88zHbqVJhvKY+8587hGHtU5ZIXjAEIzKSQ+2dUb6i4yVoCgivIAyvliT0XcwCJ9
         I3nv5tR8zQCS+X3h/HHNrRz5rTAcZaogslLs5tjBEeR05W/BxIdk+DBVsNAvSE1Uyz82
         F43JMqfmmjHFJ6bHjJ+Yr5Am9gnbQATRPn3KpTVy/FDn9bmqos0K527qufyvDttMR0Gb
         gGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718332925; x=1718937725;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oXcTiESkKmSEI3/A7naH7yCYLW8EORfhzjr241vKkZM=;
        b=stPmXXi0Yv6Mp0gclZbzzeRJ3ROkQuk6cfKKkcT6K2AgjxsEzBdHVqsECgbljyPTYo
         OUXT43v3AzQVu5aLgWdF7y/i11+rUC+z9Atox1dipZDCT6v2CXmbPcSLugBzEw6GXWFJ
         QqPwGycNMttmwsqeRed0GJ7nrGFlkIHhgUtAcEzLeDfuyqw6uPFDcqmorUdnVzGVGBPB
         omDaTU/wvpK7KelGailPmGFIm/Pgd55VFjKXX+jICqBB6s5Vi0/CKGTW01KUCEz4Jk32
         +p6CJflmPbZwwC55al5SVhnt5pwJ5Hudm6jHyITO+iCqDFdsue99D1cIKb1BsTnCsKX5
         PjWg==
X-Forwarded-Encrypted: i=1; AJvYcCXvJJnkybHCwFIqGLMQcc+UqviOvH1vwDe+wiS8JA639eSQKG1NhaL0kv/JQdrTbr6QqLIFs96NCEOqcP9Nw1ijwxq3qVHA
X-Gm-Message-State: AOJu0Yww3OwS5hnXGlKqvg4KXmUGtl/dmmpqsZsEzkE3eDFWaSO6Ikc5
	VlatYx9SU66akeBI3tp+IRp1A9+Rb74Qe0PDTh88WHn40kKRRTXW
X-Google-Smtp-Source: AGHT+IEICIkQs8A+B34zBHFMD99pHMOb2TmZK0WTgrO65ikjLQU7JZDSy85APcZxDf8met28jTobqw==
X-Received: by 2002:a05:6a20:da9d:b0:1b5:ae2c:c730 with SMTP id adf61e73a8af0-1bae8001712mr1847090637.3.1718332924775;
        Thu, 13 Jun 2024 19:42:04 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f40947sm21189865ad.276.2024.06.13.19.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 19:42:04 -0700 (PDT)
Date: Fri, 14 Jun 2024 11:41:52 +0900 (JST)
Message-Id: <20240614.114152.1787364292761357690.fujita.tomonori@gmail.com>
To: kuba@kernel.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, hfdevel@gmx.net, naveenm@marvell.com,
 jdamato@fastly.com
Subject: Re: [PATCH net-next v10 4/7] net: tn40xx: add basic Tx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240613174808.67eb994c@kernel.org>
References: <20240611045217.78529-1-fujita.tomonori@gmail.com>
	<20240611045217.78529-5-fujita.tomonori@gmail.com>
	<20240613174808.67eb994c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 17:48:08 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 11 Jun 2024 13:52:14 +0900 FUJITA Tomonori wrote:
>> +	/* 1. load MAC (obsolete) */
>> +	/* 2. disable Rx (and Tx) */
>> +	tn40_write_reg(priv, TN40_REG_GMAC_RXF_A, 0);
>> +	mdelay(100);
> 
> Why mdelay()? 100ms of CPU spinning in a loop is not great.
> I only see calls to tn40_sw_reset() from open and close, both
> of which can sleep so you should be able to use msleep().

Yes, msleep() works here. Will fix.

>> +	/* 3. Disable port */
>> +	tn40_write_reg(priv, TN40_REG_DIS_PORT, 1);
>> +	/* 4. Disable queue */
>> +	tn40_write_reg(priv, TN40_REG_DIS_QU, 1);
>> +	/* 5. Wait until hw is disabled */
>> +	for (i = 0; i < 50; i++) {
>> +		if (tn40_read_reg(priv, TN40_REG_RST_PORT) & 1)
>> +			break;
>> +		mdelay(10);
> 
> read_poll_timeout() ?

Will fix.

>> +	}
>> +	if (i == 50)
>> +		netdev_err(priv->ndev, "SW reset timeout. continuing anyway\n");
> 
> 
>> +	if (unlikely(vid >= 4096)) {
> 
> can the core actually call with an invalid vid? I don't thinks so..

Will remove.

>> +	struct tn40_priv *priv = netdev_priv(ndev);
>> +
>> +	u32 rxf_val = TN40_GMAC_RX_FILTER_AM | TN40_GMAC_RX_FILTER_AB |
>> +		TN40_GMAC_RX_FILTER_OSEN | TN40_GMAC_RX_FILTER_TXFC;
>> +	int i;
>> +
> 
> nit: no empty lines between variable declarations

Oops, will fix.

>> +		u8 hash;
>> +		struct netdev_hw_addr *mclist;
>> +		u32 reg, val;
> 
> nit: declaration lines longest to shortest within a block

Sorry, I thought that xmastree tool can find this but it can't. Will fix.

>> +static void tn40_get_stats(struct net_device *ndev,
>> +			   struct rtnl_link_stats64 *stats)
>> +{
>> +	struct tn40_priv *priv = netdev_priv(ndev);
>> +
>> +	netdev_stats_to_stats64(stats, &priv->net_stats);
> 
> You should hold the stats in driver priv, probably:
> 
> from struct net_device:
> 
> 	struct net_device_stats	stats; /* not used by modern drivers */
>

Currently, net_device_stats struct is in tn40_priv struct. You meant
the driver shouldn't use net_device_stats struct?

Note that some TX40xx chips support HW statistics. Seems that my NIC
supports the feature so I plan to send a patch for that after the
initial driver is merged.

>> +static int tn40_priv_init(struct tn40_priv *priv)
>> +{
>> +	int ret;
>> +
>> +	tn40_set_link_speed(priv, 0);
>> +
>> +	ret = tn40_hw_reset(priv);
>> +	if (ret)
>> +		return ret;
> 
> But probe already called reset, is there a reason to reset multiple
> times? Would be good to add some reason why in a comment (if you know)

I didn't know why the original driver does this. Seems the NIC works
without the above hw reset. Will remove.

>> +	/* Set GPIO[9:0] to output 0 */
>> +	tn40_write_reg(priv, 0x51E0, 0x30010006);	/* GPIO_OE_ WR CMD */
>> +	tn40_write_reg(priv, 0x51F0, 0x0);	/* GPIO_OE_ DATA */
>> +	tn40_write_reg(priv, TN40_REG_MDIO_CMD_STAT, 0x3ec8);
>> +
>> +	// we use tx descriptors to load a firmware.
> 
> nit: stick to a single style of comments? ;)

Oops, will fix.


Thanks a lot!

