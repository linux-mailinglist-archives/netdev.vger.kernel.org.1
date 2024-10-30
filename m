Return-Path: <netdev+bounces-140210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF1F9B58B5
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 01:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4111C2289E
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBA01773A;
	Wed, 30 Oct 2024 00:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVWxO6KU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB68D528;
	Wed, 30 Oct 2024 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730248669; cv=none; b=jL/25KNLAWzhWT3evC9hv9Q9ZBkOgxRQEAaNbqvMc9p/iURHdTlWDXx+Lq8YMpzEIkOWs2jgteDjyYe0Tp1ViTNixasrFU4KT/ENKLOrypZ7Hqzoxy97mLlGnx9aWW/735WIpiwM+A2qmrnIz8kmoWSJeVFqrMGcJ4p0TF5szvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730248669; c=relaxed/simple;
	bh=t7HPd+bjO+APwi4tF4eYmR5JLRLD5O64D3qz5RtdMP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqowyOjVKuqXrZ7VTirEmmUoE7exCXuBmF6jKiluF3ShbgFFENSyKD5MHKNoo2dVHME+UQK5AJwfVIfQ0brYSgfW4pEigqiNJa51W5QzVjFjVJ63iiPIsiL8VRJ9Y5BZnCxfcDdsrbpMok/imWY7qjKdKkd7E/el08QUnGCjyh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVWxO6KU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE70C4CECD;
	Wed, 30 Oct 2024 00:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730248668;
	bh=t7HPd+bjO+APwi4tF4eYmR5JLRLD5O64D3qz5RtdMP8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rVWxO6KUfK6LA2LDCxBBi01kFoJvWzgZ6zfZJdD0QVwN2XHOZaF7tBcfNaOBioElX
	 nkK3n/gIST01WnNa5wPQYlkYjm16/yng4/mGlAYiZk65/r1beY0d0dqtmfXiRWvwRk
	 I16UTYq8byhhahSI4HyrQLd1MQ+wp7/yZ/hM6lwFGQCznWK8NVm30gjpheBsHYCYui
	 rAsTg3DH0DYvlV0UFoI2zcE9pvCeU/4bI0Ns7nXRrsf6Upl5l0w8iKC2KOwV9o04AO
	 Uxd6atSGf3nOIAioE0xXQ0llODOzZFt9QzpjWoH1WOxll+y9mrdC8Tpk9/VZCxzS+n
	 Riiw9bBOBGINg==
Date: Tue, 29 Oct 2024 17:37:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Sudarsana Kalluru
 <skalluru@marvell.com>, Manish Chopra <manishc@marvell.com>, Doug Berger
 <opendmb@gmail.com>, Jacob Keller <jacob.e.keller@intel.com>, Sabrina
 Dubroca <sd@queasysnail.net>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: broadcom: use ethtool string helpers
Message-ID: <20241029173747.74596c8c@kernel.org>
In-Reply-To: <CAKxU2N-5rZ3vi-bgkWA5CMorKEOv6+_a0sVDUz15o8Z7+GFLvQ@mail.gmail.com>
References: <20241023012734.766789-1-rosenp@gmail.com>
	<20241029160323.532e573c@kernel.org>
	<CAKxU2N-5rZ3vi-bgkWA5CMorKEOv6+_a0sVDUz15o8Z7+GFLvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 16:43:15 -0700 Rosen Penev wrote:
> > > -             memcpy(buf, bnx2x_tests_str_arr + start,
> > > -                    ETH_GSTRING_LEN * BNX2X_NUM_TESTS(bp));
> > > +             for (i = start; i < BNX2X_NUM_TESTS(bp); i++)
> > > +                     ethtool_puts(&buf, bnx2x_tests_str_arr[i]);  
> >
> > I don't think this is equivalent.  
> What's wrong here?

We used to copy ETH_GSTRING_LEN * BNX2X_NUM_TESTS(bp)
but i will no only go from start to BNX2X_NUM_TESTS(bp)
IOW the copied length is ETH_GSTRING_LEN * (BNX2X_NUM_TESTS(bp) - start)
No?

