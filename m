Return-Path: <netdev+bounces-162304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45633A2679D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B460B3A5535
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 23:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C96213E86;
	Mon,  3 Feb 2025 23:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gg3cJprL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2922139DC
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 23:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623860; cv=none; b=HzEIKmDTKIzUI4cvzhcjAmvz1FOxzZ/jvnE0vx5io8On6OkHK5v50Fr4YyaQHvOAcXoDFxTjUfoaVMs/E+aaUYWNHAbNcb/rWVGMMCsNLlCnhlN174RSlc2QyYyn4wyEjvFvQxezu0QuiVQyiWlwsDk+Z3loqHciEWLwK2ZFh4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623860; c=relaxed/simple;
	bh=fK3eyCLWlWbo3iwlQ+DuWVHWyEb8u1Cd+uACJiHEJ6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ge5OTE08diEnMUoxRs5HrQgSevkeMCuGIdU74gNY/JSxNJnxA+NAh7U1jYiHkAR9l5sX1AKSGhSsiN/YD9NjCCzZ+6g2CwlwaLJJyDzyx3Lcu3Ksf/u3opLIOEyy+DdWLwh3CYq3zVhml7K7M4LjOjZpvfqltyYKPQfsv1imHgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gg3cJprL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CC8C4CEE8;
	Mon,  3 Feb 2025 23:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738623859;
	bh=fK3eyCLWlWbo3iwlQ+DuWVHWyEb8u1Cd+uACJiHEJ6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gg3cJprLeebzIOUJbT9s0M0P6/iffJYLTvpnGUN+6a2WDdmC2OQexyr2ielosW08U
	 9SG2FlCZQUKHmRgbA5fgPpsxIs+dW2cc09CwEfs1YWHw+h/pNSyLyOSW16nD++qtpt
	 UwVjwbBwh0RpUeZM/NplCli4JlB+WM6/mO8IHI4miPLINmMd1481n7qrpckypaS688
	 mZNxqnpEUyZI94PE+Zzzdh4sxpPW061uEyH+lZRej/tvSw2/MNQYnXXv2L/zIT4zIb
	 lWNTivR2fBYEicyuWEOfUeme9fVNeYxqTZDWtF88u+i2qMuFf1DByaWgBzYtGkYcvD
	 JTyuPxTjHwnAQ==
Date: Mon, 3 Feb 2025 15:04:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <Woojung.Huh@microchip.com>
Cc: <frieder.schrempf@kontron.de>, <lukma@denx.de>, <andrew@lunn.ch>,
 <netdev@vger.kernel.org>, <Tristram.Ha@microchip.com>
Subject: Re: KSZ9477 HSR Offloading
Message-ID: <20250203150418.7f244827@kernel.org>
In-Reply-To: <BL0PR11MB2913B949D05B9BB73108A5FFE7F52@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
	<6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
	<1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
	<6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
	<20250129121733.1e99f29c@wsk>
	<0383e3d9-b229-4218-a931-73185d393177@kontron.de>
	<20250129145845.3988cf04@wsk>
	<42a2f96f-34cd-4d95-99d5-3b4c4af226af@kontron.de>
	<BL0PR11MB2913C7E1AE86A3A0EB12D0D7E7EE2@BL0PR11MB2913.namprd11.prod.outlook.com>
	<1400a748-0de7-4093-a549-f07617e6ac51@kontron.de>
	<BL0PR11MB29130BB177996C437F792106E7E92@BL0PR11MB2913.namprd11.prod.outlook.com>
	<20250203103113.27e3060a@wsk>
	<1edbe1e4-9491-4344-828d-4c3b73954e8a@kontron.de>
	<BL0PR11MB2913B949D05B9BB73108A5FFE7F52@BL0PR11MB2913.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Feb 2025 14:58:12 +0000 Woojung.Huh@microchip.com wrote:
> Hi Lukasz & Frieder,
> 
> Oops! My bad. I confused that Lukasz was filed a case originally. Monday brain-freeze. :(
> 
> Yes, it is not a public link and per-user case. So, only Frieder can see it.
> It may be able for you when Frieder adds you as a team. (Not tested personally though)

Woojung Huh, please make sure the mailing list is informed about 
the outcomes. Taking discussion off list to a closed ticketing 
system is against community rules. See below, thanks.

Quoting documentation:

  Open development
  ----------------
  
  Discussions about user reported issues, and development of new code
  should be conducted in a manner typical for the larger subsystem.
  It is common for development within a single company to be conducted
  behind closed doors. However, development and discussions initiated
  by community members must not be redirected from public to closed forums
  or to private email conversations. Reasonable exceptions to this guidance
  include discussions about security related issues.
  
See: https://www.kernel.org/doc/html/next/maintainer/feature-and-driver-maintainers.html#open-development

