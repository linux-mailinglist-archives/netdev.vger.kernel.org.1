Return-Path: <netdev+bounces-108587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9C7924741
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 20:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A17B1C22B9D
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 18:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D201BE849;
	Tue,  2 Jul 2024 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7R3Samg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA9C1DFFC;
	Tue,  2 Jul 2024 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719944696; cv=none; b=Oscs/Pn2z/JpfDYQfs09vdSeGaP71Uxse/hpkq2HUhvcegXaQUF5vmQSOoza4Q77jBoXwLHnK+67lqZzdRlVoUGh/4ZswsL/G3BzBSOmUOuFWEiveLPufGJxQusQ/ujURYvArSSJS3Ecrz5nNQ1gPcYWEMcPyE8sbt/2IBMST3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719944696; c=relaxed/simple;
	bh=FJQ3lZqtw652OWICIXnNWRgnwvihqoWvwkWMQQbYgSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZrGrYo08oyc0unQ/plrWKe4EdCsUAi23LfUbdnjiWGcF3+zho6o31v0zISWj2LZ/PCeRoWD71a47YULecVej+jfLb7YZaygJ1XwQAdUHM1Ig+teOnzo/cL8mTMXFApQ2sBWM/SQg47IZF9u0lmsmf3O6hbYc3iypegY/Xr1zP50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7R3Samg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B602C116B1;
	Tue,  2 Jul 2024 18:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719944696;
	bh=FJQ3lZqtw652OWICIXnNWRgnwvihqoWvwkWMQQbYgSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f7R3Samgpsbh/EjNVZP6Wzi0JS8JnZj/1VHmeFlJMxwnDpg8SOsQv9csJdvcQtFpA
	 Wmmp06Duyp1Jm5gULYiGPz4ViGeZ5UiHcnGPEfXXdHapxl0SkDMNfVhS4XBVJNeqYu
	 kII2PYa6b4kItcvgr5SCglTexXMMaKTtQcXMv2TBvHa5pIEYgWzAv2lpk02sXeZepn
	 YuvVrhoarbEMecgpdsVUVgn8wEuqgFmbXIvMu4/Xc4ma6wEIY0hnWfEkxzwm5dMWHY
	 ppZBIWjQRnBFqg5XF6xAJSNZzlqfLe/e69OWVTCIj2WmsuHb4iU0cWP7d9FwvOqSlF
	 iYayGeQ22tGww==
Date: Tue, 2 Jul 2024 11:24:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Simon Horman <horms@kernel.org>, =?UTF-8?B?QWRyacOhbg==?= Moreno
 <amorenoz@redhat.com>, Aaron Conole <aconole@redhat.com>,
 netdev@vger.kernel.org, echaudro@redhat.com, dev@openvswitch.org, Donald
 Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Pravin
 B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 05/10] net: openvswitch: add psample action
Message-ID: <20240702112454.408757f7@kernel.org>
In-Reply-To: <a6728234-b453-4404-8d4f-eed64293a5f6@ovn.org>
References: <20240630195740.1469727-1-amorenoz@redhat.com>
	<20240630195740.1469727-6-amorenoz@redhat.com>
	<f7to77hvunj.fsf@redhat.com>
	<CAG=2xmOaMy2DVNfTOkh1sK+NR_gz+bXvKLg9YSp1t_K+sEUzJg@mail.gmail.com>
	<20240702093726.GD598357@kernel.org>
	<447c0d2a-f7cf-4c34-b5d5-96ca6fffa6b0@ovn.org>
	<20240702110645.1c6b5b1a@kernel.org>
	<a6728234-b453-4404-8d4f-eed64293a5f6@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 20:16:51 +0200 Ilya Maximets wrote:
> On 7/2/24 20:06, Jakub Kicinski wrote:
> > On Tue, 2 Jul 2024 11:53:01 +0200 Ilya Maximets wrote:  
> >> Or create a simple static function and mark all the arguments as unused,
> >> which kind of compliant to the coding style, but the least pretty.  
> > 
> > To be clear - kernel explicitly disables warnings about unused
> > arguments. Unused arguments are not a concern.  
> 
> OK.  Good to know.
> 
> Though I think, the '12) Macros, Enums and RTL' section of the
> coding style document needs some rephrasing in that case.

Do you mean something like:

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 7e768c65aa92..0516b7009688 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -828,7 +828,7 @@ Generally, inline functions are preferable to macros resembling functions.
 		} while (0)
 
 Function-like macros with unused parameters should be replaced by static
-inline functions to avoid the issue of unused variables:
+inline functions to avoid the issue of unused variables in the caller:
 
 .. code-block:: c
 
?

