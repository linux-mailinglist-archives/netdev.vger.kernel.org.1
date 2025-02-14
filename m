Return-Path: <netdev+bounces-166582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC5FA367F7
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636F73B1140
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE9D1DC9B1;
	Fri, 14 Feb 2025 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZJpRkR1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FF74A08;
	Fri, 14 Feb 2025 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739570593; cv=none; b=agBX787jpqVJ9rPFKCEo77xOOgEXDh5I94GxKZVcUQhHYSSb6ivM+xVI8ezPXGaTaa8aIbCwSWUJ38YZVZNqovRiuGUhLYnuynwxrOFlXtsTM5cjlulnisWMh67EcTNrsdHLVrfCOx5KxEj5vyk9LqWBh5CY1VPKB/e0I/Nmp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739570593; c=relaxed/simple;
	bh=W0N0vZnTxZ9LxqS354lEdjFrRGF755H50o4JHtYZhAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNXSY/6AexbXLqq9fdIScaLLDBydE5XktAU0JlVUBfNNv8qh287ppRoX+vdQpRCZj7dr1dXfifqilWkKeVxsxGokTcrfHKtLu9bFoPPJaZsMz5SxMC0pYsKVO50HC0wG9za9BUL6eO4V5IiIfugIVmIr7ivKU31dT6i5jPQTG+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZJpRkR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA16CC4CED1;
	Fri, 14 Feb 2025 22:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739570592;
	bh=W0N0vZnTxZ9LxqS354lEdjFrRGF755H50o4JHtYZhAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hZJpRkR1VtZgwi2CSVO2dxlZxalWyrVVY1qyJfBfVAnmO/i3oqg5tHjZUR9f3XOEi
	 DzMg9NWdQkvg0nr1EE9p65CbdRAlQhhTL6PY+542uzKAp6LInkkQ/IPqIUx5ZfWo6t
	 zn2mMRI1O7rFqW/b8FHj4cUZ9ZqxcDZuqC60cnGbQC89E/YnJ7Ne8DQ2aPxwDZ5Ymg
	 IQpbyoIYbKO2XPbrDuStl4QQ3GQng5LtIIwd//b8KFDV+40xkR1OuTh8Ki1Gf6ME8U
	 xH1BL/TqgLKCuWH2k5sQgsHrOZNIddUWwVl7zHc62TP7V3FcGecNYN3Bmh1YCMFvKg
	 DhIZtM5NRdUaw==
Date: Fri, 14 Feb 2025 14:03:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman Long
 <longman@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Hayes Wang <hayeswang@realtek.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, Breno Leitao
 <leitao@debian.org>
Subject: Re: [PATCH 1/2] net: Assert proper context while calling
 napi_schedule()
Message-ID: <20250214140311.43f58050@kernel.org>
In-Reply-To: <Z65Yl2eeui05Cluy@pavilion.home>
References: <20250212174329.53793-1-frederic@kernel.org>
	<20250212174329.53793-2-frederic@kernel.org>
	<20250212194820.059dac6f@kernel.org>
	<Z65Yl2eeui05Cluy@pavilion.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Feb 2025 21:39:51 +0100 Frederic Weisbecker wrote:
> Le Wed, Feb 12, 2025 at 07:48:20PM -0800, Jakub Kicinski a =C3=A9crit :
> > On Wed, 12 Feb 2025 18:43:28 +0100 Frederic Weisbecker wrote:
> > Please post the fixes for net, and then the warning in net-next.
> > So that we have some time to fix the uncovered warnings before
> > users are broadly exposed to them. =20
>=20
> How do I define the patch target? Is it just about patch prefix?

Yes, --subject-prefix=3D"PATCH net" for fixes
     --subject-prefix=3D"PATCH net-next" for -next stuff

But even that isn't really a super hard requirement. My main ask
was to post patch 2, then wait for it to propagate (we merge the=20
trees every Thu afternoon) then post patch 1.

Sorry for the delay.

