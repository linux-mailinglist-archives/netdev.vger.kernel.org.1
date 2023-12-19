Return-Path: <netdev+bounces-58884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9F3818780
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 13:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5973028620D
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 12:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DE418626;
	Tue, 19 Dec 2023 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gihxHhyX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A551418032
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a234139b725so338627366b.3
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 04:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702989019; x=1703593819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uAE5oZxuQF7vsLFo157rr7pOuH+fIC0h765Im6IICOg=;
        b=gihxHhyX1dPYqfElT11xJYEY8rkjTpLUqHY/kL6T/LiZ/zyH8FrRkAOn0YDVlGQK0q
         hVjaAuQKPRuMVwfjuift1o/uPnIyhdUjD8ckw34TuhRcgpznLrmxgL6wFU7GSEE+AZxT
         8rbmeporSztV/Qu7d4jMuHtL3qEYM3FeLvxQ9DbvlvlBl/4wRhHm54u3pveIYovrje2E
         oDnFqoMyi1d5nJwU+TYT1/ZS6+sLoAYw3De9Jzg1CQ1kK8qfuAzD3SeleQfaQtTzaqSx
         5ilTyhfKLhwvsZyDji9/kzTQ1WPpEL507+1nMAKHLqrcE4cpS5/4X+xfOdXo03JdQtGT
         ZDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702989019; x=1703593819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAE5oZxuQF7vsLFo157rr7pOuH+fIC0h765Im6IICOg=;
        b=T8KVfoX6k76pg/vB9NYm10d3+5LvpJCl7amrnKPE8JKP88OuimzA6ULCBcezKO8cMe
         irqMTzI8kzMCttP7v4ZK7MLupvemPdjPDSBrJBNp/T100HnjE28ee6gviKExF4SXywgb
         qV9G6LfeD1n5ZF/MxMRRDKnuXjongNKpGKxLpxoI8gBo1UFjwD0W3hflltkd/cHnUMwX
         VscgfPF+36QeCUv/Sfh+MuSWCLBOUXvLqeWNotmpDxUedb+zbC8hxi+ZJvh1MoViSdyy
         41lXvzzsU2BUoPok94Uaq8DReXUVDmUDXFu4oCOTCHKEp5Fm9u1bAeA525TK27/8nxFJ
         LOnQ==
X-Gm-Message-State: AOJu0YwtC8vzglmiLrG5Zoh9sJVLTtS09e0S80bIVIOTWxr3HfPJuID9
	9huemXKoDMis4Tf4fknAacU=
X-Google-Smtp-Source: AGHT+IFc5N71mVk34rjjafqWNqN0PdEd8VSeSvwch2jdpbByer+h2AyqIB/ZBY2FIKsYDc2IkcIZIQ==
X-Received: by 2002:a17:906:493:b0:a23:5f76:3467 with SMTP id f19-20020a170906049300b00a235f763467mr639744eja.100.1702989018649;
        Tue, 19 Dec 2023 04:30:18 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id x24-20020a170906135800b00a25501f4160sm492406ejb.1.2023.12.19.04.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 04:30:18 -0800 (PST)
Date: Tue, 19 Dec 2023 14:30:16 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Sylvain Girard <sylvain.girard@se.com>,
	Pascal EBERHARD <pascal.eberhard@se.com>,
	Richard Tresidder <rtresidd@electromag.com.au>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net 0/1] Prevent DSA tags from breaking COE
Message-ID: <20231219123016.6xy3gamz4lkr5fdz@skbuf>
References: <20231218162326.173127-1-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218162326.173127-1-romain.gantois@bootlin.com>

On Mon, Dec 18, 2023 at 05:23:22PM +0100, Romain Gantois wrote:
> I've run some iperf3 tests and the TX hotpath performance doesn't seem
> to be degraded by the field added to dma_features.

I don't know what CPU cores you are using, but if the iperf3 performance
was line rate at gigabit before and is line rate at gigabit now, you
haven't effectively measured the impact of the change (and "doesn't seem
to be degraded" is a false conclusion). You need something more CPU
intensive to see the difference, like IP forwarding of 64 byte packets.

A very simplistic way to set up IP forwarding between 2 DSA user ports
is to do this on the router board (DUT):

echo 1 > /proc/sys/net/ipv4/ip_forward
ip link set swp0 up && ip addr add 192.168.100.2/24 dev swp0
ip link set swp1 up && ip addr add 192.168.101.2/24 dev swp1

and this on the system with 2 endpoints:

ip netns add ns0
ip link set $ETH1 netns ns0
ip link set $ETH0 up && ip addr add 192.168.100.1/24 dev $ETH0
ip -n ns0 link set $ETH1 up && ip -n ns0 addr add 192.168.101.1/24 dev $ETH1
ip route add 192.168.101.0/24 via 192.168.100.2
ip -n ns0 route add 192.168.100.0/24 via 192.168.101.2
./net-next/samples/pktgen/pktgen_sample03_burst_single_flow.sh -i $ETH0 -s 64 -m 00:04:9f:05:de:0a -d 192.168.101.1 -t 2 -f 13 -c 0 -p 400 -n 0 -b 4

I compiled the commands from some notes I had lying around, I didn't
retest them.

