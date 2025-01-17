Return-Path: <netdev+bounces-159188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B520A14B19
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 09:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7806E188B8A9
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 08:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D12E1F8905;
	Fri, 17 Jan 2025 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMPV19Xo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300921F8AC6
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737102409; cv=none; b=Xg09xyHCH3NznEazHBMslj8lbWxKkRR5HC4OXpaUELS0jvJOZIx3TutNYNbngpNka430+8Ldi3fSzhjBLIQQO281nsuPMLy/WR3ynrCsDPcKsxcEOxsfr8UiV+j1bC8jGg0HSFwx1iQdVnSi/ZFvGQSZZNdv3qX9LvbIHPEjxr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737102409; c=relaxed/simple;
	bh=aL8HuHlTQpR8z77LLZMzi+to33OSHnjmSv4tQoYHbac=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=QcAIczEXWFXv/nkp+vm8I/H1wwXnm9vkOAWjDWFccOIb/orOnPcQgkvFsgM4O63BfrbYBI4bEPmLyG+bDfa8CMw+6viYnqkvTMKEEIFOJTsm0SGHswiza0WEdmqhD4IqdOatco4HctTIkRj/nvCnKZpWLOqzvEK4gC6i03vGMmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMPV19Xo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE21C4CEDD;
	Fri, 17 Jan 2025 08:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737102408;
	bh=aL8HuHlTQpR8z77LLZMzi+to33OSHnjmSv4tQoYHbac=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=AMPV19XoDYgT41PePpAvma7+V35frsW6T7N1VjadubDYEOA3+qmyYmmmrQPrhxMgN
	 vjVl5R0tYDmKh7mUTvIS7MyokKg/eDUk6haXDh1mS1bMYYslJAEnLYF04vQE4xBHCk
	 1uRlZttGaEpAvPUBuFgJCTLHpqAi7gl/78btECIaNjTDBksXqnTO5hCRXfCF93PFld
	 jWnEYN9e9axub+rbSixPDd95MOwU4c2eCp0qK9uBEalwl5LdvPvIZjJpkfMpoGI9qu
	 q1X12U1ydlDaM1KHLj3YhEX8VFIkCsDzWaSmvLwj3PvyAWFZSR0y81FQpSMh5vADnD
	 LCBCt7NqNGwYw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250116154319.7ed5a545@kernel.org>
References: <20231018154804.420823-1-atenart@kernel.org> <20231018154804.420823-2-atenart@kernel.org> <20250102143647.7963cbfd@kernel.org> <173626740387.3685.11436966751545966054@kwain> <20250107090641.39d70828@kernel.org> <173703457791.6390.1011724914365700977@kwain> <20250116154241.5e495e24@kernel.org> <20250116154319.7ed5a545@kernel.org>
Subject: Re: [RFC PATCH net-next 1/4] net-sysfs: remove rtnl_trylock from device attributes
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org, gregkh@linuxfoundation.org, mhocko@suse.com, stephen@networkplumber.org
To: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 17 Jan 2025 09:26:44 +0100
Message-ID: <173710240479.5144.11769826495170395041@kwain>

Quoting Jakub Kicinski (2025-01-17 00:43:19)
> On Thu, 16 Jan 2025 15:42:41 -0800 Jakub Kicinski wrote:
> > On Thu, 16 Jan 2025 14:36:17 +0100 Antoine Tenart wrote:
> > > While refreshing the series, especially after adding the dev_isalive()
> > > check, I found out we actually do not need to drop the sysfs protecti=
on
> > > and hold a reference to the net device during the whole rtnl locking
> > > section. This is because after getting the rtnl lock and once we know
> > > the net device dismantle hasn't started yet, we're sure dismantle won=
't
> > > start (and the device won't be freed) until we give back the rtnl loc=
k.
> > >=20
> > > This makes the new helpers easier to use, does not require to expose
> > > the kernfs node to users, making the code more contained; but the
> > > locking order is not as perfect.
> > >=20
> > > We would go from (version 1),
> > >=20
> > > 1. unlocking sysfs
> > > 2. locking rtnl
> > > 3. unlocking rtnl
> > > 4. locking sysfs
> > >=20
> > > to (version 2),
> > >=20
> > > 1. unlocking sysfs
> > > 2. locking rtnl
> > > 3. locking sysfs
> > > 4. unlocking rtnl
> > >=20
> > > This is actually fine because the "sysfs lock" isn't a lock but a
> > > refcnt, with the only deadlock situation being when draining it.
> > >=20
> > > Version 1: https://github.com/atenart/linux/commit/596c5d9895ccdb7505=
7978abd6be1a42ee4b448e
> > > Version 2: https://github.com/atenart/linux/commit/c6659bb26f564f1fd6=
3d1c279616f57141e9f2bf
> > >=20
> > > Thoughts? Apart from that question, either series is ready for
> > > submission. =20
> >=20
> > Nice, yes, I think that works!
>=20
> To be clear - by "that" I mean version 2 :)

Thanks! Will send version 2 then.

