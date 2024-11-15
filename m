Return-Path: <netdev+bounces-145498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00C59CFACF
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A629728236B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0063192B6D;
	Fri, 15 Nov 2024 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXF9cys5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A541922ED;
	Fri, 15 Nov 2024 23:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731711843; cv=none; b=QRYwMVdhvE/+FGtmfI4kMkbV6HAktX6ZqYscsL81R1v/PAjB10ys0p93ustM/6iUSCgB/TNiyIpRxsU3tbcggp+TTLbKkRoc7aYnp7Q6jYmXDu8og89Dqu5sfpmlC3a1jHa5CH2hTTkWNoVOwsMZm/6Udxwf1TVMn3gZRCpeha4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731711843; c=relaxed/simple;
	bh=+fFs5hj5s9umuTTamJt7Ul6y5pkJ5NFGPVuYByYU3oM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdowqpEaZt2HBGM4HSjld3R7X3w9KYIGeKfdbRPauXZbstMD8tWR7garVWVBsJuwuintK6ol1lfdjtddjuyf0cUecxF5Y4Ac5rmgXeRIjyEhXC4o8Sk80M2BnX+ZcZ/ystiWtFfBFkOEtoibfIU+XgGx6XXnWYhghx1u4ssfIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXF9cys5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-432d9bb168cso14111395e9.1;
        Fri, 15 Nov 2024 15:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731711840; x=1732316640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+kL+cS5EvQ3n9arZXmohSwmGYBlKGAKyqHLz8twlVd4=;
        b=WXF9cys5+rkrsM3nu1GYFUjrJFWpRcFrNzyrkYxY3f8glzbIZmu3ZFWySX1cQtvYsl
         TYIeqdwROiOYWm78BZ4hOXflvn4fZDdLTO4ClyXmTG3iHv44xvrjgkKjMS+UTrVti7gK
         N/KnAZz9Y7/JxATjLSQr9Y1iHMlSYLPMNUNZer1gFctUdK8/C6TkUpGj2jmvzB6CcGSP
         pHIPJxflZ568TFuK/EygUYp1ZL6lgCBDttZUJSbTdp+q9fznjN/uarbWZ7N0+pfXBZPQ
         yOjpQ3uMUaDTdFgxnD2Cr7yDE1L5K72WXaMnz8sb5Ha4PpDtBoCEtaeXwZtYRxat2CfV
         kYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731711840; x=1732316640;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kL+cS5EvQ3n9arZXmohSwmGYBlKGAKyqHLz8twlVd4=;
        b=RpFtK9O1gufuyBMK7sC3K1h9ZQPCB2MGYEQSf+9WHv4DX9RjQ2qgBSMNJxRpRegBNb
         KCmtyaIXh0pTyyxQl+j5Sov1RIgLmo3OXDY3I+QCiUI8+4aSsYJiLd17+ecVDNZuAt0Z
         UxvdJnnyGrBZfWJzDZuYPkMTXgm++YYzcihoLL1jKPrtxRARZGk4dld23LYrTyi0JRXV
         TzNG6CCXi1aM/Oq6F1w+Pc/XND0tMLK4mIm4eBKftys+d64PHL1NUe8kFpERWr52fLeJ
         PcLguVvA1LZAmIHKNxJA2YMA6uUREzR+/JvznRZCd7B9h4ImiQVDJfInM4epnfJ97WfC
         d3gA==
X-Forwarded-Encrypted: i=1; AJvYcCV8qM+0FouO9iu7vSo8rEh0rSzTBS4UKb8pEhoY9q8MtuWhN2bNC0uN1riXP2uvlskoYdbwuZH0Ier2@vger.kernel.org, AJvYcCVIxI0trApUX8M5nUVUQlz9K/xIwHc9LZ/kbiOUnVa1EKkClVnuXsQ5Nh5cyQecpfJfHCKK32Et@vger.kernel.org, AJvYcCVz6qxngL2TC/75HuV4kPIwAFAituTtxXBUTNzTKvC6Rp/9gaMK4OSjfnzOP0epVBPgmxKTVut6qBCYO0jy@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi5Bi3BWlHMZmhVV7QhE7WpE+0Zc94VNLQvbDKvAkxD0YETheR
	bgyBM0LPGtLPH3HPhwBTB0lBtWnFynyx5BkJ1aX0NT1e7vXE2rza
X-Google-Smtp-Source: AGHT+IFn0fKVGf6BpBp5O3iANa0DxDXJALEgYAxM1KyvBAcvk7mElBpZceoItdzxTC/3s5Ak5XOV3A==
X-Received: by 2002:a05:600c:3516:b0:431:5226:1633 with SMTP id 5b1f17b1804b1-432defd2589mr40395195e9.6.1731711840247;
        Fri, 15 Nov 2024 15:04:00 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da24498csm72756525e9.1.2024.11.15.15.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 15:03:59 -0800 (PST)
Message-ID: <6737d35f.050a0220.3d6fb4.8d89@mx.google.com>
X-Google-Original-Message-ID: <ZzfTW_cjJrGqLUff@Ansuel-XPS.>
Date: Sat, 16 Nov 2024 00:03:55 +0100
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
 <6737c439.5d0a0220.d7fe0.2221@mx.google.com>
 <20241115145918.5ed4d5ec@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115145918.5ed4d5ec@kernel.org>

On Fri, Nov 15, 2024 at 02:59:18PM -0800, Jakub Kicinski wrote:
> On Fri, 15 Nov 2024 22:59:18 +0100 Christian Marangi wrote:
> > On Thu, Nov 14, 2024 at 07:22:02PM -0800, Jakub Kicinski wrote:
> > > On Tue, 12 Nov 2024 21:47:26 +0100 Christian Marangi wrote:  
> > > > +	MIB_DESC(1, 0x00, "TxDrop"),
> > > > +	MIB_DESC(1, 0x04, "TxCrcErr"),  
> > > 
> > > What is a CRC Tx error :o 
> > > Just out of curiosity, not saying its worng.
> > >  
> > 
> > From Documentation, FCS error frame due to TX FIFO underrun.
> 
> Interesting
>

Seems it's even supported in stats.

> > > > +	MIB_DESC(1, 0x08, "TxUnicast"),
> > > > +	MIB_DESC(1, 0x0c, "TxMulticast"),
> > > > +	MIB_DESC(1, 0x10, "TxBroadcast"),
> > > > +	MIB_DESC(1, 0x14, "TxCollision"),  
> > > 
> > > Why can't these be rtnl stats, please keep in mind that we ask that
> > > people don't duplicate in ethtool -S what can be exposed via standard
> > > stats
> > >   
> > 
> > Ok I will search for this but it does sounds like something new and not
> > used by other DSA driver, any hint on where to look for examples?
> 
> It's relatively recent but I think the ops are plumbed thru to DSA.
> Take a look at all the *_stats members of struct dsa_switch_ops, most
> of them take a fixed format struct to fill in and the struct has some
> extra kdoc on which field is what.

Thanks for the follow-up, they are the get_stats64 I assume, quite
different to the ethtools one as we need a poll logic. Ok I will check
what to drop and rework it.

-- 
	Ansuel

