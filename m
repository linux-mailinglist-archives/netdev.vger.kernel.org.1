Return-Path: <netdev+bounces-241373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 363CBC8333D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F9DC34C6F7
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 03:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F7D1E22E9;
	Tue, 25 Nov 2025 03:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S66o8ECL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CB51487E9;
	Tue, 25 Nov 2025 03:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764040587; cv=none; b=qJ+vAQAeoXjaoFEQesLxxVkaydqMVSfEizsdhI3MQv4RJRf5TQ9aaS5RqdRd1XcfAS8Wm12EzuyQ4p/VZ9yKmby7P7ZPM13nnrka4LbfAkpq2ul0+gc69VmNzwEh+MfPRp2e9wnaeShh0o0ttAtEAYspjj7+6KwTWWugnBA20f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764040587; c=relaxed/simple;
	bh=a8WIsxzYY5ccmQyP+xYCHnbss37O6M18Ac1MmX2Sqbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eh+0yTilCXhgtqcY2QynHlLC68A1/ZzhxkXpJ61atkIQFmrJTW92bDYE2EBI/chdUyviy7AKDMs1HY+6R1ZlMGElwGATJOkxIX4/8xUmjDLKjjHYCtQipNqgQFI5CWJAxh7tNt7vC1p23VwmJGefp4+esEjADjMXYRBqlb6fzhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S66o8ECL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5CCC4CEF1;
	Tue, 25 Nov 2025 03:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764040586;
	bh=a8WIsxzYY5ccmQyP+xYCHnbss37O6M18Ac1MmX2Sqbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S66o8ECLlpMsBW5iFuTSVMEyKGepdGQuY8HLDciQmA34E5icSYQFWsBN3Z3bNclZF
	 RNul8lTlRnQXqLvTfMixlKasWDObwxLRn9E8Mxo6DlZ01shftDzM4q8Uc5Sbi7S6/8
	 tJea8sR0h3hPigPTWSgkHVRa10nK7184GJDF7rcSFbTgaSH56yDOXBjHUltBaysviv
	 AdIYpORwKdcVj7Q+s13SKCP9MOALC4AA260mCSLqoF3h/zKenmDxA5apk2U+jGzHhk
	 nZmVe9SkDGokV1a36j+Z+oNjP1wzJzjLNMB5eOMi2+osoq7fC9gaBkGYjR9ROgSQV3
	 pI1juiu92Oe/A==
Date: Mon, 24 Nov 2025 19:16:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 will@willsroot.io, jschung2@proton.me, savy@syst3mfailure.io
Subject: Re: [Bug 220774] New: netem is broken in 6.18
Message-ID: <20251124191625.74569868@kernel.org>
In-Reply-To: <aSH9mvol/++40XT0@pop-os.localdomain>
References: <20251110123807.07ff5d89@phoenix>
	<aR/qwlyEWm/pFAfM@pop-os.localdomain>
	<CAM0EoMkPdyqEMa0f4msEveGJxxd9oYaV4f3NatVXR9Fb=iCTcw@mail.gmail.com>
	<aSDdYoK7Vhw9ONzN@pop-os.localdomain>
	<20251121161322.1eb61823@phoenix.local>
	<20251121175556.26843d75@kernel.org>
	<aSH9mvol/++40XT0@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Nov 2025 10:14:50 -0800 Cong Wang wrote:
> > I guess we forgot about mq.. IIRC mq doesn't come into play in
> > duplication, we should be able to just adjust the check to allow   
> 
> This is not true, I warned you and Jamal with precisely the mq+netem
> combination before applying the patch, both of you chose to ignore.

I'm curious why we did.. Link?

