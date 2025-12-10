Return-Path: <netdev+bounces-244213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90657CB288D
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 10:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEC3730CFA87
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 09:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D0F3054DF;
	Wed, 10 Dec 2025 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck7jynYc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D547302159;
	Wed, 10 Dec 2025 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765358587; cv=none; b=a2qXtTD7TGPfYrWGB1k0jjiyx4F3zsSppJVRomjpXUIpiSLtCywZMFRqLRKdx1Z/NsJPsfLZ/ur4Ddhwqfn5CufJ1mwjWzrZr/SpauAulrvccs33A2grqyp4S599GrFHkueI0hQyN4lGcznE9wucsMbpcxP2nc2M40U4YJ1IAxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765358587; c=relaxed/simple;
	bh=Wqbff4s4GyZOnqiHaxwSXqM1T/Tp1LWJaVCaUfT7reQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQkdNGgeAc8HnEdCEyyy0p58wlpVp1qDwSUypywggLfSpL/q+Z4pMeXd0LFD5k6IQAKDk2a7iX0lZn7AZ6xbjregwSJQNmlIG6dioX69MOjqicAmj1JXGNQ3HsRdzkC5hnEZ+HVJJsF6/QuBSthLwAzv+HTSFSpojGDy4HgClYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck7jynYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55B4C4CEF1;
	Wed, 10 Dec 2025 09:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765358586;
	bh=Wqbff4s4GyZOnqiHaxwSXqM1T/Tp1LWJaVCaUfT7reQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ck7jynYcQnyLWZLEUD7PNgZSw+bdu4ssH7dPDXD9ir5pfJluO7RCNsfgN1R0lrrAY
	 Hyhg73btUHUGRRKOozSob3Mvd3ss/VDtiwcXDQOtbWsK5rNBaBTQkOy91DCx9as0Fg
	 CLuYoYgPJATtrxasLJmiVLqCvLT4Kh9FiDzcu8xkvQNVI+MiKCQI2R8wWsJBx8CjJt
	 Rc7b6EziLpa4SIUuzDbRDq8BIHgoY3TPhN2DKzEXkRm1G/tT3mVyQNad1KpLGdym1b
	 yLahrKDfelNf7P1yzt8kVt6ZU2OmLzpB0sTFXpOXBZFHziQGkddQwCOYgTF1OgsNxn
	 WcReObqryMZaQ==
Date: Wed, 10 Dec 2025 18:23:00 +0900
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
 <davem@davemloft.net>, Simon Horman <simon.horman@netronome.com>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Andreas Noever
 <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 8/9] bitfield: Add comment block for the host/fixed
 endian functions
Message-ID: <20251210182300.3fabcf74@kernel.org>
In-Reply-To: <20251209100313.2867-9-david.laight.linux@gmail.com>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
	<20251209100313.2867-9-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Dec 2025 10:03:12 +0000 david.laight.linux@gmail.com wrote:
> + * * u32 le32_get_bits(__le32 val, u32 field) extracts the contents of the
> + *   bitfield specified by @field in little-endian 32bit object @val and
> + *   converts it to host-endian.

possibly also add declarations for these? So that ctags and co. sees
them?

