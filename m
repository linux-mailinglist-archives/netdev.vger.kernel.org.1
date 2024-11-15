Return-Path: <netdev+bounces-145473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C22669CF980
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827B928BD73
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 22:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A853206957;
	Fri, 15 Nov 2024 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+mWKm3c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF51204F7F;
	Fri, 15 Nov 2024 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707966; cv=none; b=NOPL8RGmxwxwL0sBl1NVvPa1v/nR5sPHGjgja3koaguIB8Q4Py2xjLYRXsdd98na/qBQHwrXAIW77rPViPvwrLu6trV5gTjxZNTBPG0xE46rsUOOk9k8yWU9y8kExCxaP9HF9581u3G70oYNd1wjbEzecvnE3QKBKZ5H+DgrT2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707966; c=relaxed/simple;
	bh=QJv3yYa/9XiY6vOUaNzuQnetWLi3X7njquUMRtWcv2E=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoPGhfckoRKWS1Pq5S0KAZU4usUopDX4vAogXyRLr3sJIOCtHLzWJrgKZEbmb6k9YSHVqPIxCw5sK+kat+8sO78CniYztWXcWOnGswEFbLLd323qIyYORtauOOjgLDpVHqspGQQtHscey3hrq6PoWKrctroXA1gOuLWVBec+EIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+mWKm3c; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43169902057so18785285e9.0;
        Fri, 15 Nov 2024 13:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731707963; x=1732312763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4KEsDTTAK1pZnid0HCmorMUnwqRgHVrxEO5D+fdsiII=;
        b=R+mWKm3czkWwJPAWP/8O6Ivc/wA0D9yIpXwKxRD0aI832SMCl0vGNI5LvymaewgyPR
         2QSlihrFKNRslAwQwTcLTVAN+FzkEPgBiQtFF7VwiLAxQtRXamvLzTJgot8ZbQ7m9mU9
         U8JTuCLpBmSPvzSOLsjYYrj5S9G+mZBf2QPRsn6CCTOXD7Gyr/XaGbPHqk8byo+lV2du
         rl1qSAM8cr5sTDBQUWgizeb/R3Js/MB7Rsw5jdc007MeF9rj6CpVWzgT4kFvDjyY1Rfw
         syPgkvwWwATBT9CTm6CaP4FagozNSi0U/ElCz/6wKcDFrvqJPnSzCTTunZfYox8dcs0z
         Nb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731707963; x=1732312763;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KEsDTTAK1pZnid0HCmorMUnwqRgHVrxEO5D+fdsiII=;
        b=FEX0mUxnl/wQwLUWL7RkRe2JTkzWtiNO1Yad+feuc0g6kqiGZ/YbOR9NUDTFXdx9a6
         lhMRkawM3yIxl1E1ciSpfAcfLY92xZiTHzxO5iXdJ3htA8CXq+QbzlyyPMaCAXR+9Q/K
         mid/90nofqYTR4EV+tPsDC5SdGGMqMRnW4VVdMWwfPZGj43c8DkhaR4DnxdtMV6OAKnI
         QVVr4XH3tthycCCLmTtYGbyJIqPd2P0Hcrlc2f9YuH11ecyGD/OOWkKR9oHuWDqKGy9r
         Df0EK5ktDL7rOcjJzSxFG7u23N2smT30IdFYLm8nx4CXN+E/6AqGVvXQ3b+tf+QECChV
         WxAA==
X-Forwarded-Encrypted: i=1; AJvYcCUs8gPcMYamecvufDDuniVFQ1hRSqi/HS1WpjzesgH4vD8UxVvHJeX3lhZvyW+OZpx4U3UZZLAO@vger.kernel.org, AJvYcCVjRBpOGgI9ILDkz8uMvjPhzeKvBJ/ZuonFzLpVSoOubdjBMN6gUtLZis0S+1EPiIHrtBQq+EqkWUOl0lUK@vger.kernel.org, AJvYcCWHdIm9YPGFF+NoI6MQ1mvcpn9kHNMvRyjQOPl+DtUZPxP176McPmJCrUhGi16XAe6RMyozDYOg9b8p@vger.kernel.org
X-Gm-Message-State: AOJu0Yxecofys0J/KUOFKbvhTHgggCP+Uqcqcg/PtI71jXqD2uuW8fwW
	XcuMdvotd5oG86VNGQ/T7k2i/J2guuWd1AVm1xSRMPdleGqQefgv
X-Google-Smtp-Source: AGHT+IGlO9LOfsdfExxUPsSllZxIcizIxX7dbevaKMvsvnKdufl+ZPJG+GzOs3jrXwz5HjTMYIpSCA==
X-Received: by 2002:a05:600c:190c:b0:431:55af:a230 with SMTP id 5b1f17b1804b1-432df798ea0mr31583215e9.33.1731707962660;
        Fri, 15 Nov 2024 13:59:22 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adad9cesm5343076f8f.37.2024.11.15.13.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 13:59:21 -0800 (PST)
Message-ID: <6737c439.5d0a0220.d7fe0.2221@mx.google.com>
X-Google-Original-Message-ID: <ZzfENklUN81HdO4f@Ansuel-XPS.>
Date: Fri, 15 Nov 2024 22:59:18 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v5 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
References: <20241112204743.6710-1-ansuelsmth@gmail.com>
 <20241112204743.6710-4-ansuelsmth@gmail.com>
 <20241114192202.215869ed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114192202.215869ed@kernel.org>

On Thu, Nov 14, 2024 at 07:22:02PM -0800, Jakub Kicinski wrote:
> On Tue, 12 Nov 2024 21:47:26 +0100 Christian Marangi wrote:
> > +	MIB_DESC(1, 0x00, "TxDrop"),
> > +	MIB_DESC(1, 0x04, "TxCrcErr"),
> 
> What is a CRC Tx error :o 
> Just out of curiosity, not saying its worng.
>

From Documentation, FCS error frame due to TX FIFO underrun.

> > +	MIB_DESC(1, 0x08, "TxUnicast"),
> > +	MIB_DESC(1, 0x0c, "TxMulticast"),
> > +	MIB_DESC(1, 0x10, "TxBroadcast"),
> > +	MIB_DESC(1, 0x14, "TxCollision"),
> 
> Why can't these be rtnl stats, please keep in mind that we ask that
> people don't duplicate in ethtool -S what can be exposed via standard
> stats
> 

Ok I will search for this but it does sounds like something new and not
used by other DSA driver, any hint on where to look for examples?

> > +	MIB_DESC(1, 0x18, "TxSingleCollision"),
> > +	MIB_DESC(1, 0x1c, "TxMultipleCollision"),
> > +	MIB_DESC(1, 0x20, "TxDeferred"),
> > +	MIB_DESC(1, 0x24, "TxLateCollision"),
> > +	MIB_DESC(1, 0x28, "TxExcessiveCollistion"),
> > +	MIB_DESC(1, 0x2c, "TxPause"),
> > +	MIB_DESC(1, 0x30, "TxPktSz64"),
> > +	MIB_DESC(1, 0x34, "TxPktSz65To127"),
> > +	MIB_DESC(1, 0x38, "TxPktSz128To255"),
> > +	MIB_DESC(1, 0x3c, "TxPktSz256To511"),
> > +	MIB_DESC(1, 0x40, "TxPktSz512To1023"),
> > +	MIB_DESC(1, 0x44, "TxPktSz1024To1518"),
> > +	MIB_DESC(1, 0x48, "TxPktSz1519ToMax"),
> 
> we have standard stats for rmon, too
> 
> > +	MIB_DESC(2, 0x4c, "TxBytes"),
> > +	MIB_DESC(1, 0x54, "TxOversizeDrop"),
> > +	MIB_DESC(2, 0x58, "TxBadPktBytes"),
> > +	MIB_DESC(1, 0x80, "RxDrop"),
> > +	MIB_DESC(1, 0x84, "RxFiltering"),
> > +	MIB_DESC(1, 0x88, "RxUnicast"),
> > +	MIB_DESC(1, 0x8c, "RxMulticast"),
> > +	MIB_DESC(1, 0x90, "RxBroadcast"),
> > +	MIB_DESC(1, 0x94, "RxAlignErr"),
> > +	MIB_DESC(1, 0x98, "RxCrcErr"),
> > +	MIB_DESC(1, 0x9c, "RxUnderSizeErr"),
> > +	MIB_DESC(1, 0xa0, "RxFragErr"),
> > +	MIB_DESC(1, 0xa4, "RxOverSzErr"),
> > +	MIB_DESC(1, 0xa8, "RxJabberErr"),
> > +	MIB_DESC(1, 0xac, "RxPause"),
> > +	MIB_DESC(1, 0xb0, "RxPktSz64"),
> > +	MIB_DESC(1, 0xb4, "RxPktSz65To127"),
> > +	MIB_DESC(1, 0xb8, "RxPktSz128To255"),
> > +	MIB_DESC(1, 0xbc, "RxPktSz256To511"),
> > +	MIB_DESC(1, 0xc0, "RxPktSz512To1023"),
> > +	MIB_DESC(1, 0xc4, "RxPktSz1024To1518"),
> > +	MIB_DESC(1, 0xc8, "RxPktSz1519ToMax"),
> > +	MIB_DESC(2, 0xcc, "RxBytes"),
> > +	MIB_DESC(1, 0xd4, "RxCtrlDrop"),
> > +	MIB_DESC(1, 0xd8, "RxIngressDrop"),
> > +	MIB_DESC(1, 0xdc, "RxArlDrop"),
> > +	MIB_DESC(1, 0xe0, "FlowControlDrop"),
> > +	MIB_DESC(1, 0xe4, "WredDrop"),
> > +	MIB_DESC(1, 0xe8, "MirrorDrop"),
> > +	MIB_DESC(2, 0xec, "RxBadPktBytes"),
> > +	MIB_DESC(1, 0xf4, "RxsFlowSamplingPktDrop"),
> > +	MIB_DESC(1, 0xf8, "RxsFlowTotalPktDrop"),
> > +	MIB_DESC(1, 0xfc, "PortControlDrop"),
> -- 
> pw-bot: cr

-- 
	Ansuel

