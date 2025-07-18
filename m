Return-Path: <netdev+bounces-208080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033CEB09A25
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 05:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A41087A4C85
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 03:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07D1198A2F;
	Fri, 18 Jul 2025 03:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="c85Ein5m"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763AA2E36F7;
	Fri, 18 Jul 2025 03:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752809102; cv=none; b=RPvzVSUS2R91rUW3KaARip1tSYYbo0GRuxDjl2+ivnBXWgeEqH4j9LcIA/WNM4NChPaDk+BGUZk3ZXVB/veszMQ7c0aQ/OCU2svTG04EIDp56B1sYTTPs4r4KgLDOkKbjyz7nLkoKFhBFBRJ7ukTUqfemH7HeO07cgkVwbYg6JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752809102; c=relaxed/simple;
	bh=lRv3sKv38vRAvQzWbRpV+TJqci+sx5IbWt9hWqkf14E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HTDyAkzb2qh6EMYXpwT8im5H9eitqujfbPhI7I+yTM6T+KNgfA5BycX7tN57NX92cq4aLlIHGKGrIoQtbu9nmjXOSiw4nSYioC4C4v+wunPQTLqB5/FcnhePv4hlBXyzY9zef4iMY+mQtju+3kXiEAF9ehDWL+8j+aubfB2VOtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=c85Ein5m; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752809096;
	bh=lRv3sKv38vRAvQzWbRpV+TJqci+sx5IbWt9hWqkf14E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c85Ein5mWQlmYNdnjOzQ5rVqUzhMlv4o8lX842YuspRHe2eRXX5+Y2VeVPl8BpaVg
	 dtolCYSahfQMhPNIiRPxCna4Tbfgle7ef+j99Ba6jGPALN+1T7ElVlcckjnvTxoraB
	 KUSjzFu+XKZT0cOuybwp69PN0th/ua735Sd0CD02hELUVbes/wf67YSg56f130bzgh
	 mKJr+j0B+uC3CRc7OUhiTC0CU6EfQ5AMM2J5fQylIlYXXBrh1VDYrrEuHoX/LW+5n3
	 AzwkpDPOcNYpF6m+akA5kH9yxWZFbgaA1J1q8BVix/t+qLOX6prh0A4F9Q3zImmLHF
	 s7QzUzqi6uhjw==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7B41A69703;
	Fri, 18 Jul 2025 11:24:55 +0800 (AWST)
Message-ID: <05aa941118f1dee000a05a9eeccb7a33e3e14d23.camel@codeconstruct.com.au>
Subject: Re: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: YH Chung <yh_chung@aspeedtech.com>, "matt@codeconstruct.com.au"
 <matt@codeconstruct.com.au>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>,  "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,  "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, BMC-SW
 <BMC-SW@aspeedtech.com>
Cc: Khang D Nguyen <khangng@amperemail.onmicrosoft.com>
Date: Fri, 18 Jul 2025 11:24:55 +0800
In-Reply-To: <SEZPR06MB57634C3876BF0DF92174CDFA9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
References: <20250714062544.2612693-1-yh_chung@aspeedtech.com>
	 <a01f2ed55c69fc22dac9c8e5c2e84b557346aa4d.camel@codeconstruct.com.au>
	 <SEZPR06MB57635C8B59C4B0C6053BC1C99054A@SEZPR06MB5763.apcprd06.prod.outlook.com>
	 <27c18b26e7de5e184245e610b456a497e717365d.camel@codeconstruct.com.au>
	 <SEZPR06MB5763AD0FC90DD6AF334555DA9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
	 <7e8f741b24b1426ae71171dff253921315668bf1.camel@codeconstruct.com.au>
	 <SEZPR06MB5763125EBCAAA4F0C14C939E9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
	 <2fbeb73a21dc9d9f7cffdb956c712ad28ecf1a7f.camel@codeconstruct.com.au>
	 <SEZPR06MB57634C3876BF0DF92174CDFA9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi YH,

> We're planning to split the MCTP controller driver into two separate
> drivers for AST2600 and AST2700, removing the AST2600-specific
> workarounds in the process for improving long-term maintainability.
> And it's part of the reason we want to decouple the binding protocol
> logic into its own layer.

The split is entirely up to you (and sounds reasonable), but the
"binding protocol logic" is really minimal. I would think a couple of
shared helper functions should be sufficient?

> Would it be preferable to create a directory such as net/mctp/aspeed/
> to host the abstraction layer alongside the hardware-specific
> drivers?

Just put them in the top-level at drivers/net/mctp/ for now. There's not
much in there at present, so will be simple to keep organised. If you
end up with two drivers and a common set of utils between the two,
that's a total of four files, which I think we can manage.

Cheers,


Jeremy

