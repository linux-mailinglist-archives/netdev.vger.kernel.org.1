Return-Path: <netdev+bounces-69242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F7C84A7D3
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F0E2933A6
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 21:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCCA12FF9E;
	Mon,  5 Feb 2024 20:12:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from torres.zugschlus.de (torres.zugschlus.de [85.214.160.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1902812FF91
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.160.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163975; cv=none; b=okCGEb/UGVG0PNxnqis38tYp49R0GWSLYGStzDDi25NONQROuWmmhkWUVfLZuKVc9JS8kiMLmQq5wUL9MPAm367bntyEoXvBWmmrfcSF3q1JJldGBlDyZJTUmT9JGzs7CRC5EBKnWKI6tZYusuHih94I0jUlrAM1YWHFCJgRAhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163975; c=relaxed/simple;
	bh=c4c56hATIFyU/q9suSjf/xwzt+ZUzsBg46puy31HwaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZakWsiUIeq2A22VbCZ6NNt/fJQ1P/b5EovbDFP+ibVtJ7oKyk3fnv6Qy6dPaJKkRuyzB8xJR8cJMppEYSEsgSy9LFo/Osjm6vI4F/TApAx+jnoxZikXtcbK4W6YESISbWNTQDkQaCt+2t+/NJNsBKakN/82d8pEQea/dk64gppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de; spf=none smtp.mailfrom=zugschlus.de; arc=none smtp.client-ip=85.214.160.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=zugschlus.de
Received: from mh by torres.zugschlus.de with local (Exim 4.96)
	(envelope-from <mh+netdev@zugschlus.de>)
	id 1rX5KR-001dyW-20;
	Mon, 05 Feb 2024 21:12:31 +0100
Date: Mon, 5 Feb 2024 21:12:31 +0100
From: Marc Haber <mh+netdev@zugschlus.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	alexandre.torgue@foss.st.com, Jose Abreu <joabreu@synopsys.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jisheng Zhang <jszhang@kernel.org>, netdev@vger.kernel.org
Subject: Re: stmmac on Banana PI CPU stalls since Linux 6.6
Message-ID: <ZcFBL6tCPMtmcc7c@torres.zugschlus.de>
References: <Za173PhviYg-1qIn@torres.zugschlus.de>
 <8efb36c2-a696-4de7-b3d7-2238d4ab5ebb@lunn.ch>
 <ZbKiBKj7Ljkx6NCO@torres.zugschlus.de>
 <229642a6-3bbb-4ec8-9240-7b8e3dc57345@lunn.ch>
 <99682651-06b4-4c69-b693-a0a06947b2ca@gmail.com>
 <20240126085122.21e0a8a2@meshulam.tesarici.cz>
 <ZbOPXAFfWujlk20q@torres.zugschlus.de>
 <20240126121028.2463aa68@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240126121028.2463aa68@meshulam.tesarici.cz>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Fri, Jan 26, 2024 at 12:10:28PM +0100, Petr Tesařík wrote:
> Then you may want to start by verifying that it is indeed the same
> issue. Try the linked patch.

The linked patch seemed to help for 6.7.2, the test machine ran for five
days without problems. After going to unpatched 6.7.2, the issue was
back in six hours.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421

