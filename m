Return-Path: <netdev+bounces-127423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 461CF975586
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B26B0B2740D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAA0192B88;
	Wed, 11 Sep 2024 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bixKOhF6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A79B1714AC
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065212; cv=none; b=oXSPhAxxEcIobhBUQBgmWtR0Cc5CUXZGQlJB7ZBYtU4xvbfMOsRx1LzUHfuSquDZVPHJhNsSxDTt3FlPFKp9dG8TPpmTZmihExar+Xu6w/9XEdnabgEWwuuwU6fgklAmXhApiZ6/H28ueOuqu3JDy3vl1aaw9MvxJOMSH+Ec1KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065212; c=relaxed/simple;
	bh=P24d+bB5BU7iCUMdqRD4AJf34y/KzQTAqPUUMnlnxFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDlbht5L8hvI8pC1msrK1FdvD61LKROof/+EJDLt4Xr2V9N7wGCrpn6kbShQw0OUBIiD6dVktF1kYugcHmNX0ZfkuCP42rhVo3Sa2HzAMTIx3Z1a3qkb+TA9fCBfN+ha7uSJpDfYjyoGGh+g1xCvj0mWR4e/3orswDubkLTPPps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bixKOhF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AD0C4CEC0;
	Wed, 11 Sep 2024 14:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726065211;
	bh=P24d+bB5BU7iCUMdqRD4AJf34y/KzQTAqPUUMnlnxFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bixKOhF6vR5GNkVFbrVEfbgn5RYeXUF/ZUFOzOcAH7dqAwvmyScy+duRaDY1I2qlM
	 oVNzYjxGRnfPL508Iqv5FwpfK3RunreAPDzq63TUxxhU3Mf4SmXu0cjTSWanWhb7pw
	 B3r6Q+KU4IxHhtbhn7krg3w/AnWEEtTtLofTe2dUxythlkdE1FpF42p8bOH7yJL9z5
	 rkNMhUwu288OI3ZDpLbdoRSZOxHj6LDU93Vs1LO5MVVdZZ2IiAGJeooXcrQ6Dx3vDv
	 D54z4aW2iw1mQn53oGSvd1lLYoQEtz7uzYN8UZJQLyyKKqIMdsPrTYginCVR32XA2J
	 Lpv+QRoJk/JAA==
Date: Wed, 11 Sep 2024 07:33:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net] net: dsa: lan9303: avoid dsa_switch_shutdown()
Message-ID: <20240911073329.155db2d6@kernel.org>
In-Reply-To: <cecf48f4ae26a642125bb06765abda0a952cdf6e.camel@siemens.com>
References: <cecf48f4ae26a642125bb06765abda0a952cdf6e.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Sep 2024 11:07:42 +0200 Alexander Sverdlin wrote:
> dsa_switch_shutdown() doesn't bring down any ports, but only disconnects
> slaves from master. Packets still come afterwards into master port and the
> ports are being polled for link status. This leads to crashes:

Something is wrong with the date on your (email) system, the email
arrived with a date from a week ago. It's not going to get ingested
into our patch handling systems.
-- 
pw-bot: cr

