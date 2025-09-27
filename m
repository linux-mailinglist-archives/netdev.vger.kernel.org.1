Return-Path: <netdev+bounces-226827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA2BBA577B
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 03:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC7324E2F37
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 01:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51CA1E5B64;
	Sat, 27 Sep 2025 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Od8pgFLn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4E31E3DF2;
	Sat, 27 Sep 2025 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758935187; cv=none; b=eGelJJsop9OcCxHLLOR/xs4CEU5AcbdADdsFu5M0BtJeszurRJj6JFr5SZAYTmYJOmoABtMVL/gaWdiOjep4SwHqHJfR/SGR33pUiw38/eVkHffPgEWfpzA/CaVICxnEvFKIE75LAmjjCTgy8wrktrE4f/a2o4owrjCxsoLrokg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758935187; c=relaxed/simple;
	bh=H2GJrnTOrevgJPdRHNBR6jcZogKmW0KlavU/7wtl3A0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLptO47z3iEL8O6cNkjqTSZUxZtEyCWetpV//L5kO/LJcZuXbWK8gS2XaMqeEsNGyD/752KZyVmQh280CQ5m8tDArWhH55bRr9+zB+fZ6EX1ctO75M9c+gFeirz/cvTN5FcVObH/wCqO75Vx1whUwi6UIshCq581tQgBR5ccQZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Od8pgFLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C996C4CEF4;
	Sat, 27 Sep 2025 01:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758935187;
	bh=H2GJrnTOrevgJPdRHNBR6jcZogKmW0KlavU/7wtl3A0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Od8pgFLnJJskOUgIl0OT/3IJ00u3Ku2qOvsgLuLoKKhUcSgRrTiveAsim35fUTYeZ
	 /aDka2rCZukYcGKpZhocvsJhwN6E/sLDpbobysWieM5Glj/gVDioEmuKg5UTAwLK3g
	 n52h2kpoIx9kwBgHy2nAOB8/oXuVGFTU4aRMaouN0oV5rZkcNSL2oQkn1uCCQ3dzIr
	 s3q8LKbOMYoBCGWBrQVI1PATjd2wYW/3s+cT/DGPIDWN80Wlw2QXWB2Y5oJ+MWh99B
	 fcI77F6YLOVfJH5BR4+3mLbTkzEwj9MEoOq12tyWqac85HgS+KKrWabWmiTzcNHJm5
	 zobI8YN0TQjLA==
Date: Fri, 26 Sep 2025 18:06:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Harini Katakam
 <harini.katakam@xilinx.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Sean Anderson
 <sean.anderson@linux.dev>
Subject: Re: [PATCH net v6 0/5] net: macb: various fixes
Message-ID: <20250926180625.14d51c69@kernel.org>
In-Reply-To: <20250923-macb-fixes-v6-0-772d655cdeb6@bootlin.com>
References: <20250923-macb-fixes-v6-0-772d655cdeb6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Sep 2025 18:00:22 +0200 Th=C3=A9o Lebrun wrote:
> Pending series on MACB are: (1) many cleanup patches, (2) patches for
> EyeQ5 support and (3) XDP work. Those will be sent targeting
> net-next/main once this series lands there, aiming to minimise merge
> conflicts. Old version of(1) and (2) are visible in the V2 revision [0].

Slightly worried this will regress some platforms with less memory.
I suppose this device is mostly used on systems with <4GB of DRAM
so the upper 32b register thing doesn't matter at all. But less DRAM
the more problematic it may be to perform the large allocations.

I guess we'll find out..

