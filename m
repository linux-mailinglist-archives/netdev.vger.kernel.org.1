Return-Path: <netdev+bounces-249950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FAAD21884
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 23:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DA7030021F4
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDB53AEF4B;
	Wed, 14 Jan 2026 22:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPpGJjxr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5243AEF2C
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 22:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768429080; cv=none; b=LiKg6OBrEJdEB0tCX8joVUxHnvbrwFaVLpZTZt0b+q+nKki4q4nYoLqTwWLaoW3CcE4kjIjMduvQOUaGzTllO84II2/Uup2mA+/OnazWeMZGn9G7/FajmSf6MASr4j+8K0s8c68e2Zp3fj1tuRLP4sIS4uQU4kgZ/5EXhbrJTuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768429080; c=relaxed/simple;
	bh=Z81lhCkJyU5OgqsjQhSwe+xZ+f9s9magtkxs+412gks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGCI4gH0HpJc7+M2OkzNdJ0Yhhr1Ep089lKg96RfN7lKisSoL/UAdKI+6Pj8g0opDlFQh0bYsbp1DAgQJS98gAScDzvXWP1DGDP2JMJESifpNj+nPGlFz7guV6anYOwjCI5GleHiI2Gq8PLzYGrdmMP0D/urWhkCxXP7x93tGtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPpGJjxr; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b5b22f723so37892a12.2
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 14:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768429068; x=1769033868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3QsmNE/dBOKmZVY75i8Uf1eQVIlPFgA+6+ZN6q48cI0=;
        b=VPpGJjxrdyPDuSFBxOcT2yErVVIF4EbVIlDESjpj3XzHGU+VCuGUzBK0xAR5UaQ89d
         zVor8tzQGbe3MWBgKGoNFbXZo8P91lVIVIh78GabuSmSlmpV6s0yJToSkIR4Uqe+zsPj
         rs42wR+vu7sMDi91ZQPkm/m+vaQS5pdShDMXao8S3e/pKKa/avnKHnlClpqvndO3zqZC
         S6OvUPRtnXOV5yTZOlLzlGPSgM3ZiUXt0e+ONOU34a8q6s1NyiLa6PNbCRwq5+Fq/+54
         hNMPgpAEtCjmE2OY9RAnkip1eKzroApwRZLor9+2HYw2ieBvUCL5oc9OwUOK6gtfenMR
         Maew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768429068; x=1769033868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QsmNE/dBOKmZVY75i8Uf1eQVIlPFgA+6+ZN6q48cI0=;
        b=SMjnSM6Dk8g+h3eDMqBAttI20J0fcxBy+fjMJLM2Qyksq18BhQ9DbROsvNXZkMFRYY
         KhIZEE+uN7Iji7wYQuXcW9ZlzhtlXz6h257F6ZGo6kyU9WisZhwlIeytK3Uz3Ad/6vHw
         lZ0ioxTn1AZnd7V4JEkS5C0nQng70hkEeqn16loxdCrPB9mJyVYY+Mf0Vx6au4vGCGps
         4cLm/G6k12Lo83JYkwmBkiBKNqgMMB5Zkhoz9HmAXMLntzZlHhb4JZTLMlW/zPNsL+o7
         JpAO6Z3HJVSW3wGsa9RR1FtHbvbfusIMC97/83+yeB5LKwEvnh9CSrRaQs3Z4uLZ7mUc
         MB0A==
X-Forwarded-Encrypted: i=1; AJvYcCW9zdydMZ9Q93Rj5c/P3mwJiNDii1nWALLSau3W3dDNKKMdGsBXUGWHEGdCsEjkybonOJ+TjAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzekupsI/K1Un16Pl26AFyujHSWsHrZ1mn55QdJoJ7XzI7IV/Fh
	XNhkHU6FWEapi2DPGBp1KSNnkaNKdDRrtMONxHFL1CLr/3v/OtaRaESY
X-Gm-Gg: AY/fxX6r/Wg7Nj5qQdVqTBHzBNi36SWkAtWID+QZEV0pL8PcyO2k49e+RF0VZpC/Xet
	Cl7Lz3NTLxynOADAjF/9NLPUqojz4FUJnVZ3piEE/B+hKJNcvGz+3lm+OnT0e/YUjyATy2x13Lb
	dLNNyTuxZ9W6XeebB1r5o4MtLiwxGzIke0mwwnqWHuK05DbE0BGZMUx67ZRRFy4R6LXtyJytTQ0
	Lj0plMzt40XOmhd8wqxnQig/oBw+EjVz1Hd4No/pdsUITNDRRxfKDxZIu75E/K/it1vyAw9eZCH
	HhigeXMB5d9qRslpfVUEJPwmw1HO1+BRNDcr7K7YY+Co/XyiRSeesuaiEx6t0WSjVzyUFVibNzX
	auzj51AtgAw7pZ4z7TJP2lQnRhREKADZArHuXfJRXbgg+AYnFguTqau7TFS8cz9BkRswgcQXKfz
	clkQ==
X-Received: by 2002:a05:6402:5186:b0:64b:a1e6:8013 with SMTP id 4fb4d7f45d1cf-653ec46689fmr1892486a12.6.1768429067635;
        Wed, 14 Jan 2026 14:17:47 -0800 (PST)
Received: from skbuf ([2a02:2f04:d703:5400:d5b0:b41:b5b3:8c4d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65412084155sm650905a12.29.2026.01.14.14.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:17:47 -0800 (PST)
Date: Thu, 15 Jan 2026 00:17:43 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Golle <daniel@makrotopia.org>, Felix Fietkau <nbd@nbd.name>,
	John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
	Rex Lu <rex.lu@mediatek.com>,
	Mason-cw Chang <Mason-cw.Chang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next RFC] net: ethernet: mtk_eth_soc: support using
 non-MediaTek DSA switches
Message-ID: <20260114221743.tb56lxfi6eqoh2rw@skbuf>
References: <34647edacab660b4cabed9733d2d3ef22bc041ac.1768273593.git.daniel@makrotopia.org>
 <252d6877-d966-4d19-a38c-cc83ba908494@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <252d6877-d966-4d19-a38c-cc83ba908494@lunn.ch>

On Tue, Jan 13, 2026 at 03:00:18PM +0100, Andrew Lunn wrote:
> On Tue, Jan 13, 2026 at 03:11:54AM +0000, Daniel Golle wrote:
> > MediaTek's Ethernet Frame Engine is tailored for use with their
> > switches. This broke checksum and VLAN offloading when attaching a
> > DSA switch which does not use MediaTek special tag format.
> 
> This has been seen before. The Freescale FEC has similar problems when
> combined with a Marvell switch, it cannot find the IP header, and so
> checksum offloading does not work.
> 
> I thought we solved this be modifying the ndev->feature of the conduit
> interface to disable such offloads. But i don't see such code. So i
> must be remembering wrongly.
> 
> This is assuming the frame engine respects these flags:
> 
> /usr/sbin/ethtool -k enp2s0
> Features for enp2s0:
> rx-checksumming: on
> tx-checksumming: on
> 	tx-checksum-ipv4: on
> 	tx-checksum-ip-generic: off [fixed]
> 	tx-checksum-ipv6: on
> 	tx-checksum-fcoe-crc: off [fixed]
> 	tx-checksum-sctp: off [fixed]
> 
> When you combine a Marvell Ethernet interface with a Marvell switch
> offloading works of course. So it probably does require some logic in
> the MAC driver to determine if the switch is of the same vendor or
> not.

I don't know about FEC, but we did end up documenting this:

If the DSA conduit driver still uses the legacy NETIF_F_IP_CSUM
or NETIF_F_IPV6_CSUM in vlan_features, the offload might only work if the
offload hardware already expects that specific tag (perhaps due to matching
vendors). DSA user ports inherit those flags from the conduit, and it is up to
the driver to correctly fall back to software checksum when the IP header is not
where the hardware expects.

I would suggest searching for skb_checksum_help() in xmit() implementations.
For example c2945c435c99 ("net: stmmac: Prevent DSA tags from breaking COE").

This is just at a first glance having read the commit message and the
discussion, not necessarily the code.

