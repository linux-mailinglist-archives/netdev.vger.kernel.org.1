Return-Path: <netdev+bounces-212124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA3EB1E14B
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 06:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E78B721C6B
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 04:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6F31BFE00;
	Fri,  8 Aug 2025 04:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RfvXPaiZ"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1089518871F;
	Fri,  8 Aug 2025 04:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754627627; cv=none; b=YNukdSCXS1sSwAMVQcZXO6EPZbRd2ENb5p2PxN+wMwor4ryeVOp5L7rTaCJPUGRs4ilTar9FM6GR+b7WsyhyxDZC8hoOOPig0yVyxbuBW9+WMc6nDtGtA/GSvdBCTNST3/gGvzgxhjHWRV0mZsqnzx73d6HkbLk13N9lBUNo6JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754627627; c=relaxed/simple;
	bh=kWlEhWdLOrYDJ1X86o4wm35G+zFoVf4ET3NJoJ54JO4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f/SdtUzss/Rw+iqLnWk5Se+NJ/OZpPFXfn/IH4lpSeZxNq9m0Wt5QzSyBGqy1NxkILQHCTZLgzF60U69bpLjCvqOj00Vs9n8fmEBum8tvnWJhx3MEI00QM9unLVIfPVmUFHxBIUoGib8lARp+VQ373fFmg1V6CHvDA84HU2YOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RfvXPaiZ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Dj
	b6Chler+ln/bkVbm2E9enQGH6GzlOR6UeF6NyNwLA=; b=RfvXPaiZcfklMoZCqQ
	u6Z0GtfLtmxmfeFLW/ISMnWw7K+66MQMpBaaoQSATpo/I/ILkaJHS0WKRaCW9Gws
	2cC+B2kdCo+Jvuf0AkAtUzFM/sTIpPbKd6/OyQuKdww9+ZwwUhVFMZ1Gx9o2T3te
	aS4o9z9o+Y3JItiFQy/kW5Vvw=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3XwP8fZVoLMwHAg--.3601S2;
	Fri, 08 Aug 2025 12:33:01 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	ferenc@fejes.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: af_packet: add af_packet hrtimer mode
Date: Fri,  8 Aug 2025 12:33:00 +0800
Message-Id: <20250808043300.77995-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3XwP8fZVoLMwHAg--.3601S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr43Jr13GF1UXrW8WF1kuFg_yoW8uw1kpF
	W3A3yxAr1kJF4xJa18Cr15WasYkrWkAFy8ta48ua1fArs5ur9Igr1IkF1F9FWUXFW2ya1a
	qa97trn8twsrWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UFXdbUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbioxOjCmiVdO3ArQAAsQ

On Wed, 2025-08-06 at 15:25 +0800, Ferenc wrote:

> Do you have performance numbers? It would be nice to see the test environment,
> measurements carried out and some latency/jitter numbers.

Dear Ferenc,

We test it on 6.1.134 rt-linux version, we set 2ms as the retire timeout, the
following test result describe the packet details including cur_ts_us(time when
the sample code handle the packet) and cur_pk_ts_us(time when the packet send)
and delay(time unit is us, the gap between cur_ts_us and cur_pk_ts_us).
Test result before change to hrtimer:
--------num_pkts:54--------
pack_size_:902, atx_udp_seq:86152515, cur_ts_us:[1749707679501254], cur_pkg_ts_us:[1749707679492443], delay:8811
pack_size_:902, atx_udp_seq:86152516, cur_ts_us:[1749707679501260], cur_pkg_ts_us:[1749707679492590], delay:8670
pack_size_:902, atx_udp_seq:86152517, cur_ts_us:[1749707679501266], cur_pkg_ts_us:[1749707679492737], delay:8529
pack_size_:902, atx_udp_seq:86152518, cur_ts_us:[1749707679501274], cur_pkg_ts_us:[1749707679492884], delay:8391
...
Test result after change to hrtimer:
--------num_pkts:14--------
pack_size_:902, atx_udp_seq:42679600, cur_ts_us:[1750220805104634], cur_pkg_ts_us:[1750220805101776], delay:2858
pack_size_:902, atx_udp_seq:42679601, cur_ts_us:[1750220805104635], cur_pkg_ts_us:[1750220805101923], delay:2712
pack_size_:902, atx_udp_seq:42679602, cur_ts_us:[1750220805104636], cur_pkg_ts_us:[1750220805102074], delay:2562
pack_size_:902, atx_udp_seq:42679603, cur_ts_us:[1750220805104638], cur_pkg_ts_us:[1750220805102223], delay:2415
...
In our system, we care about the delay value, cpu usage and context switches.
Use af_packet the cpu usage of the lidar process change from about 16.91% to 
12.92%, the context switches change from about 900+ per second to 400+ per
second. The benefits of using AF_PACKET are significant enough that we need
to adopt it. After using hrtimer instead of timer, the impact of the delay
has also been controlled, which is what we hoped for.

Thanks
Xin Zhao


