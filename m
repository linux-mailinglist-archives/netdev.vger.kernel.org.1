Return-Path: <netdev+bounces-244571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9599CBA080
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 00:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 945C130AB2E9
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 23:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A7A30CD91;
	Fri, 12 Dec 2025 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmrWRxXU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D8430BB80;
	Fri, 12 Dec 2025 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765581054; cv=none; b=iaS+9cofXY0yMMN/utjLNllsJi1k7EMI1DlVRIpLIKDpJkNthhU2h8WFdODt8ggzQZm37avHvCMaWnULiidwLorCHNga5qzdSkVxfZVWNISFmGfZ0w0ArI8/j2HXXF4vF4HoQALkPQ7dU3u6RHxw2EGI0SmjmNQKQtg2+fJOHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765581054; c=relaxed/simple;
	bh=I2GwchyBLYQeaD1quSonMsPx3oJUPP9VXkB/HOH6BE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0lex4hi+phoedE/cKQEPMaLXVrii2U+d9JVzkKwGysXwtPMrTix+rQzJ7B5jvvDzwGLnPAGwnYeFBcTt2/RSSp6hBLJLr7HCafMkdancDeLGgJNFlRAQV9cQqsnuvakRK++l++e06dtz55ESgAoPXPg/3E5a6lYRrNHf16kCng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmrWRxXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77268C4CEF1;
	Fri, 12 Dec 2025 23:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765581054;
	bh=I2GwchyBLYQeaD1quSonMsPx3oJUPP9VXkB/HOH6BE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QmrWRxXUMS2xK1XeB6Sc8YOx+wP8/pvRoT3I17IWZpAl5P7d2s8U8x+klrmGy34EV
	 6csWws8hFGjf42fIagDLRQwZNMsEzK5VpcaAkPVqPM3eF7blvGJiCvPuZPwbv7heWW
	 vO1oQsMVPO4j/amS32jZSLjx20KKjJTgSbllMpIwSZwMLO5TRmWigqwyCLR2/+dgSu
	 FAtuVHk2A7zO5zU1ARez4ckzI+edQ+3hx5Pz9IwZs4PMOX9wptCuXdhSlPh2Uu2DNZ
	 ddLiOkV4iaaLSHw1IT4OrEhCXejoT8qSnc1hOeomDp/6SAo3jPxk8byGUQlbXT4BW1
	 k9HELrDfPGlZg==
Date: Sat, 13 Dec 2025 08:10:46 +0900
From: Jakub Kicinski <kuba@kernel.org>
To: david.laight.linux@gmail.com
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Luo Jie <quic_luoj@quicinc.com>, Peter
 Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andreas Noever <andreas.noever@gmail.com>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, Nicolas Frattaroli
 <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v2 01/16] nfp: Call FIELD_PREP() in
 NFP_ETH_SET_BIT_CONFIG() wrapper
Message-ID: <20251213081046.3896be28@kernel.org>
In-Reply-To: <20251212193721.740055-2-david.laight.linux@gmail.com>
References: <20251212193721.740055-1-david.laight.linux@gmail.com>
	<20251212193721.740055-2-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Dec 2025 19:37:06 +0000 david.laight.linux@gmail.com wrote:
> Unchanged for v2.

Again, nak, just keep the macro.

