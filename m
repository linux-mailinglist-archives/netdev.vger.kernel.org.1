Return-Path: <netdev+bounces-68752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2015847E67
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 03:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B1F1F25566
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 02:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165C063B1;
	Sat,  3 Feb 2024 02:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uV9QJEID"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B55613A;
	Sat,  3 Feb 2024 02:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706927226; cv=none; b=WyDmQL64mSYAE/ajRX4ZyrztGGsSoNWNNWGm6bXsbgathqz1qRCgSubx/dO3WUC4LA9X+4p0RkYbGkVVV/kCtNwRxDbuz1bjyjNRQuUiqK5Sgzd467JKkXxMCtHwFLGwXRdle3LExxvvPD7l8kc/fMiQscmPCjoqN43tZlSRaYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706927226; c=relaxed/simple;
	bh=wcohJZJwNvRpnH901uXYR1H44HXBsqUJEqExbi3CV3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgF0DKlOz8/uB1w6MQhdw8OKsAT5oHUjfgt9OuTFoYJGJea68gZh0vfODONPYWCRjzMdnkhv0YSt2Prrzpk0IR2xphA66KQ730rDjmazhxOwZwFpv3L/PLynuNNDrSOUbniUpjXhnPAB9sbJ6gEjOXbh4wRT1SK7ZkEZUibyFmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uV9QJEID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CE9C433C7;
	Sat,  3 Feb 2024 02:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706927225;
	bh=wcohJZJwNvRpnH901uXYR1H44HXBsqUJEqExbi3CV3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uV9QJEIDFBMvw+i+LkVUKbonEe36Vi1f9pY6PTb+6ANH0ow8ROnEELbf2ldtUC6TY
	 PAG9Qmg48A0KqU3J7wqp5ma7ijWr5DzeAdfS5OTSraJ0j91M13EI8bgHgfUEV8ynJu
	 JfdqMvYykndxTJ9b1655QGJ8hG9KqlElCrt5esRsSghkaN3zDe7VCUi4k/iP9J8Osm
	 iUATRl9IFr9Qv32+G9cly0q1BoKWzvi3p9EGOGSuEam0tfJV9q7O7AY3whTDhgb/aU
	 3LQaIc4COmFQoo5SD5hFtkEXt8QP/GEXYz/M2Y0ahWJNwJAPFM3CB/LqRRtCzTmBCc
	 GtDwHgDYnrmUA==
Date: Fri, 2 Feb 2024 18:27:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: Persistent problem with handshake unit tests
Message-ID: <20240202182704.5950d631@kernel.org>
In-Reply-To: <2ad1ff9f-bf42-4a36-855f-8ae62931dd84@roeck-us.net>
References: <b22d1b62-a6b1-4dd6-9ccb-827442846f3c@roeck-us.net>
	<20240202112248.7df97993@kernel.org>
	<f76d66dd-5920-4bf1-95f5-dd64f19826d4@roeck-us.net>
	<39a8176f-7c22-41ac-a027-dac10e349c51@roeck-us.net>
	<20240202164705.6813edf2@kernel.org>
	<2ad1ff9f-bf42-4a36-855f-8ae62931dd84@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Feb 2024 17:45:55 -0800 Guenter Roeck wrote:
> > I was wondering how do you discover the options. Periodically grep for
> > new possible KUNIT options added to the kernel? Have some script that
> > does it.
> 
> "Periodically grep for > new possible KUNIT options added to the kernel"
> 
> Exactly, and see what happens if I enable them to determine if they run
> fast and if they are stable enough to be enabled in a qemu test. I can not
> enable tests automatically because some just take too long to run...

Ugh, we have such a long way to go with kernel testing :(
At least I know I'm not missing an obvious trick, thanks for explaining!

