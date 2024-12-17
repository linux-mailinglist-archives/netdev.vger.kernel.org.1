Return-Path: <netdev+bounces-152527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6362B9F4794
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96FFF162561
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F1A1494DC;
	Tue, 17 Dec 2024 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK2JkzSy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7213D69
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 09:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734427847; cv=none; b=PPgmjf7xaSP7mOsXdORRH0APpRolr5yyQpHhHGWPe+3q6Y/0uQDnmy0PfhIYS9bolX6SnLoyEi2ea0IgWyhh1KU9d9Rk8HjgV1XVSuczrfHUS+WKggFcfmkjxyCnBx2PvzDvCW7FBinBk/ZmR0pLGZ0GvdxcKDk+P7gpDZ14AgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734427847; c=relaxed/simple;
	bh=XSkRo3hiGToEqltUuJ7FBjXUV/B6IZSOPsDrUTy1x+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk4sWgjDWRocfeIrzpvc4T+fo+ba/ylGQGOTxNZZlVp5OyLV4qg9chPT6j2NeiKDkHaumH3lH/7YhiGjZFhcQtnHYGdu3Xavo+Dvr1EbJUM7/AIFiuqP9uNcyk8lpybNS7rpdcit+S2/jj6tve8bznfRTc1lVLkYDBZTTmSExrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GK2JkzSy; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385e0d47720so480718f8f.0
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 01:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734427844; x=1735032644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kT2aG6PUTKYok44cCfXioFP8JbHd4uAXkijvnn6q9eA=;
        b=GK2JkzSyfYCGvlG+qwerm266RIYAPB2QWaqz8ysnLtE7dGDYGRc4tOOCR8spUYJmkK
         SuZW8z/o4oBBSEqz1vDEkRWa2MZwgdyUPh3zgd+5xAylxJPqnhJ9PB4NR4+fB8Rk6vet
         1zx/V4QwEf0OpJP07wDMamvWuS/LEqzZZ3waNXoA9DMbjIQSbIJQSvqYvgw9ZdeKkn1g
         3MerwZyUtj3vB8Ylv13xwBCja3/t/jC07eBahoSoOeOfP9qPDNjaxj1jgjwtz611Zkuw
         17Ym+/KKaCZ4zhT7eSi6wAmm4yl56AD7xDVS/g6urAAkQQJdfV3+hDLgtcyGZ2sijm+i
         jKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734427844; x=1735032644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kT2aG6PUTKYok44cCfXioFP8JbHd4uAXkijvnn6q9eA=;
        b=oipsehcJ/aWSzeJnFYy/stQfM7iLpnFY4EdETgO6JyoMyv76F7FdfzDGG7IcLudpFZ
         gQVibsqKvkaDPpp14tE2I3Q1YMCZdOhOxAJac9lfNC1LhfoTqIg32Fsy1JaqVOctKaVJ
         AtySW/dhY7QZL40aFjGaom4FlmpmkNsMl2o24Aikp1Blhw4DjrHBII0jQ3QlIGSHatSD
         HGZtGNwTQoUYzUu0GsXdI2ce29mXdl6wnDOv9oz8uTEA5t160xZ/Y6TxAzv5p3Dm22I4
         KZfXzjTcHImk0A8DwlvScinPn9nQZwQ5lHH6tzMuf55pLz4f9hCJOalH25nkvlpuAS9C
         P3Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVkOdfe7mF/vgWRwFazYYIv0ltMkOhm81OMQfzbht2ICpqhdSdTu+aPxsWn0FX+PDj5ARhdprI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpYDh41HGWddfCMNegGOqDTdEbuY1EDl8beG5cfV/NFpWMyzjj
	SEBGW8FHbOzd32tCKkl6VK5hjqzO0ydjJuZbvNofJxYTMyKCGt5X
X-Gm-Gg: ASbGnctkcwNVr7ib5Iy/SnC6GumZhTT9UbAKOKJN8nOuDFFu0oxPCjwHt4hsGghEs8v
	9DYX04jUMdLS+s+UndCEmFTCSFMAd/PveR73IBDCPuuXtOQgGqVAih84WKYeJLOM5dxXdlgz13W
	aGTjDfBfl4lDjhyNqTPr0H22bFLyT5ov5gNMRbpqmEHT54S8ocpZjBsrKRaNWJNQNo5Dc0cCY+J
	n4YdzsOdKqLTF/sQw1SmH/xxVYjCUXiKTGxbfs/nO58
X-Google-Smtp-Source: AGHT+IH9Yiteklmu9Ax1kOvdbRwjr7gS0sNu4eaLzDsqmSZSKlkEKOTEoMapHnCIzt3uoDGHpnaWxg==
X-Received: by 2002:a05:6000:2a8:b0:374:ca43:ac00 with SMTP id ffacd0b85a97d-38880ad8faemr4357996f8f.4.1734427843778;
        Tue, 17 Dec 2024 01:30:43 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436362b6981sm112707855e9.31.2024.12.17.01.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 01:30:43 -0800 (PST)
Date: Tue, 17 Dec 2024 11:30:40 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <20241217093040.x4yangwss2xa5lbz@skbuf>
References: <20241212150613.zhi3vbxuwsc3blui@skbuf>
 <Z1sXTPeekJ5See_u@lore-desk>
 <20241212184647.t5n7t2yynh6ro2mz@skbuf>
 <Z2AYXRy-LjohbxfL@lore-desk>
 <20241216154947.fms254oqcjj72jmx@skbuf>
 <Z2B5DW70Wq1tOIhM@lore-desk>
 <20241216194641.b7altsgtjjuloslx@skbuf>
 <Z2CpgqpIR5_MXTO7@lore-desk>
 <20241216231311.odozs4eki7bbagwp@skbuf>
 <Z2FAUuOh4jrA0uGu@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2FAUuOh4jrA0uGu@lore-desk>

On Tue, Dec 17, 2024 at 10:11:46AM +0100, Lorenzo Bianconi wrote:
> > When you add an offloaded Qdisc to the egress of lan1, the expectation
> > is that packets from lan2 obey it too (offloaded tc goes hand in hand
> > with offloaded bridge). Whereas, by using GDM1/QDMA resources, you are
> > breaking that expectation, because packets from lan2 bridged by MT7530
> > don't go to GDM1 (the "x").
> 
> ack, I got your point. I was assuming to cover this case (traffic from lan2 to
> lan1) maintaining the port_setup_tc() callback in dsa_user_setup_qdisc() (this
> traffic is not managed by ndo_setup_tc_conduit() callback). If this approach is
> not ok, I guess we will need to revisit the approach.

To offload QoS on the egress of a DSA user port:

port_setup_tc() is:
(a) necessary
(b) sufficient

ndo_setup_tc_conduit() is:
(a) unnecessary
(b) insufficient

> > But you call it a MAC chip because between the GDM1 and the MT7530 there's
> > an in-chip Ethernet MAC (GMII netlist), with a fixed packet rate, right?
> 
> With "mac chip" I mean the set of PSE/PPE and QDMA blocks in the diagram
> (what is managed by airoha_eth driver). There is no other chip in between
> of GDM1 and MT7530 switch (sorry for the confusion).

The MT7530 is also on the same chip as the GDM1, correct?

> > I'm asking again, are the channels completely independent of one another,
> > or are they consuming shared bandwidth in a way that with your proposal
> > is just not visible? If there is a GMII between the GDM1 and the MT7530,
> > how come the bandwidth between the channels is not shared in any way?
> 
> Channels are logically independent.

"Logically independent" does not mean "does not share resources", which
is what I asked.

> GDM1 is connected to the MT7530 switch via a fixed speed link (10Gbps, similar
> to what we have for other MediaTek chipset, like MT7988 [0]). The fixed link speed
> is higher than the sum of DSA port link speeds (on my development boards I have
> 4 DSA ports @ 1Gbps);

And this fixed connection is a pair of internal Ethernet MACs, correct?
I see on MT7988 we do have the "pause" property, which would suggest so,
since flow control is a MAC level feature. I assume 10 Gbps in the
device tree means it is an XGMII really limited at that speed, and that
speed is not just for phylink compliance, right?

What if we push your example to the extreme, and say that the DSA user
ports also have 10 Gbps links? How independent are the QDMA channels in
this case? What arbitration algorithm will be used for QoS among user
ports, when the combined bandwidth exceeds the CPU port capacity?

