Return-Path: <netdev+bounces-214968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1E2B2C56B
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45184244FAF
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3BF3431EE;
	Tue, 19 Aug 2025 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SM5ikWLv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3226E340D90;
	Tue, 19 Aug 2025 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609474; cv=none; b=ed4ADLNypW7/Dh1LW2G93FFBrZMGDsPOrSzpUxX0IUdKeabAN5zbRy4jtKqQ662LUImvoEcMpiqpu0uugf0MFVoxXS5c3b+PKRRYaowxoxBw260ekbIikmb+l8kPdtSZvjcXNdr4PURMN4yhr6xdu4Q1QAhm+ptZhsGBGUayGyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609474; c=relaxed/simple;
	bh=QGTfgyFbnf204gc7MV6xdgfCByjtZ0IjT1uVmSv4jxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSgfDdJRWxrUxchIsqGcgHWSkDdCYeBkkrdJvvg5Jp9Pko4TdzLd6qldjgGoNyg60CzhC8VTQ1PRNvfhap4iZ+zpuZZhobxi91dE5SKtlRax6P7aTGyoTXcvgNI1q38yFZKBrqxIChLsJvCWUk9x1mR2wfGcud4GVeUqKBNgfh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SM5ikWLv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vxJf67II3FxlJSmZdeE18uzEgiaeHoKYvt1KyyAKTTw=; b=SM5ikWLvxOBLS10jN6/VZwETho
	/wr8IsNEZhDh/wtKbOx18GpiZdjq8kpwYnazbEbS0uK7ny0rWPH9WD6hrB8c45UeksBEydGJqqKoz
	6c6CZoeJl4cNWPC6agxkU/tlBFljHL7Mqzf3WZmPAl0UN9YSo03iIHmbubGnk2lL2MRQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uoMDT-005C1y-BX; Tue, 19 Aug 2025 15:17:31 +0200
Date: Tue, 19 Aug 2025 15:17:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 06/23] net: dsa: lantiq_gswip: load
 model-specific microcode
Message-ID: <5cabea37-2a10-4664-b02b-c803641aff1f@lunn.ch>
References: <aKDhZ9LQi63Qadvh@pidgin.makrotopia.org>
 <c8128783-6eac-4362-ae31-f2ae28122803@lunn.ch>
 <aKI_t6F0zzLq2AMw@pidgin.makrotopia.org>
 <aKPI6xMIgIeBzqy7@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKPI6xMIgIeBzqy7@pidgin.makrotopia.org>

> I didn't consider that the size of the array elements needs to be known
> when defining struct gswip_hw_info in lantiq_gswip.h.
> So the only reasonable solution is to make also the definition of
> struct gswip_pce_microcode into lantiq_gswip.h, so lantiq_pce.h won't
> have to be included before or by lantiq_gswip.h itself.

What i've done in the past is define a structure which describes the
firmware. Two members, a pointer to the list of values, and a length
of the list of values. You can construct this structure using
ARRAY_SIZE(), and export it. You should then be able to put the odd
val4, val3, val2, val1 structure, and the macro together in one header
file, and use it in two places to define the firmware blobs for the
different devices.

	  Andrew

