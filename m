Return-Path: <netdev+bounces-158897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 287AEA13AFC
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CDC61889444
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EF31DED43;
	Thu, 16 Jan 2025 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPlrxfa4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313D6DCE1
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737034582; cv=none; b=FwgWtzjAtEK/2jnFTDXrqVH5XyxYK+jgoeLjhmoutgpO721um+FrZha9pJBojvGMznN1ZJDVW91w+qM/HY+u2ie903Oh4NQW1jdjwEltS0LqcRNUNofi+lwpXlcChbniYFW5YmMddn+/KcD07R+WeGDYB1rylZSo6XCZbUt8ovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737034582; c=relaxed/simple;
	bh=8AWG891KPdTSF4EtaCWCLoRSugVy32+E9d3bsbl2a6g=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=paBA2U4Em28TxTqN1PQpfAU9iAMJnwKAZXUU8HfHOEQCtRW8dyFYNh6uxFeyuXoPjl/K/X/R4VOablcnIoWd9pc0cp7sRN99I7hTxL/t3VVkKFWC/xucMxPLYqEeN38+hET6fAd6ncyjz8A8u904fIoBAMeoWCWZjWUpg1/YmH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPlrxfa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1C6C4CED6;
	Thu, 16 Jan 2025 13:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737034581;
	bh=8AWG891KPdTSF4EtaCWCLoRSugVy32+E9d3bsbl2a6g=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=oPlrxfa442enHA4YdFQJRVETIh4KQ4+Zwh6nJZVkUL0i9E7vV68+GNQ46Uo008PdI
	 zVfECJfBtHdOmr7jYwPsAA+9CV2bP89Kitvr6WPWZd2sTQ1HWuNO/dmjbAv402DYKA
	 1LdjHji7SLuT7jvsaUJTygVSpWdnHWH8L8FSRAHrfpVIc9l+cp8VvU68Wnca/WQO1r
	 J4gdP5kEb8OebrfUywXueSHLynR5uvtEXjymCgtsKUv8N2d1vAat/V08FbvTzefh5u
	 279p5lYQJaWxryGKU6HbHDdhzumlmI0kpDeuE8v3BA1aYH3rwBwj4zgMPnIKx1gsgc
	 P3nDOwGg2srNg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250107090641.39d70828@kernel.org>
References: <20231018154804.420823-1-atenart@kernel.org> <20231018154804.420823-2-atenart@kernel.org> <20250102143647.7963cbfd@kernel.org> <173626740387.3685.11436966751545966054@kwain> <20250107090641.39d70828@kernel.org>
Subject: Re: [RFC PATCH net-next 1/4] net-sysfs: remove rtnl_trylock from device attributes
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org, gregkh@linuxfoundation.org, mhocko@suse.com, stephen@networkplumber.org
To: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 16 Jan 2025 14:36:17 +0100
Message-ID: <173703457791.6390.1011724914365700977@kwain>

Hi Jakub,

Quoting Jakub Kicinski (2025-01-07 18:06:41)
> On Tue, 07 Jan 2025 17:30:03 +0100 Antoine Tenart wrote:
> > Quoting Jakub Kicinski (2025-01-02 23:36:47)
> > > My version, FWIW:
> > > https://github.com/kuba-moo/linux/commit/2724bb7275496a254b001fe06fe2=
0ccc5addc9d2 =20
> >=20
> > I might take a few of your changes in there, eg. I see you used an
> > interruptible lock. With this and the few minors comments this RFC got I
> > can prepare a new series.
>=20
> Perfect.

While refreshing the series, especially after adding the dev_isalive()
check, I found out we actually do not need to drop the sysfs protection
and hold a reference to the net device during the whole rtnl locking
section. This is because after getting the rtnl lock and once we know
the net device dismantle hasn't started yet, we're sure dismantle won't
start (and the device won't be freed) until we give back the rtnl lock.

This makes the new helpers easier to use, does not require to expose
the kernfs node to users, making the code more contained; but the
locking order is not as perfect.

We would go from (version 1),

1. unlocking sysfs
2. locking rtnl
3. unlocking rtnl
4. locking sysfs

to (version 2),

1. unlocking sysfs
2. locking rtnl
3. locking sysfs
4. unlocking rtnl

This is actually fine because the "sysfs lock" isn't a lock but a
refcnt, with the only deadlock situation being when draining it.

Version 1: https://github.com/atenart/linux/commit/596c5d9895ccdb75057978ab=
d6be1a42ee4b448e
Version 2: https://github.com/atenart/linux/commit/c6659bb26f564f1fd63d1c27=
9616f57141e9f2bf

Thoughts? Apart from that question, either series is ready for
submission.

Thanks,
Antoine

