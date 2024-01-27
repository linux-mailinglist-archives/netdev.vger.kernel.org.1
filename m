Return-Path: <netdev+bounces-66368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE02883EB08
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 05:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECC0286842
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 04:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F090B677;
	Sat, 27 Jan 2024 04:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUNl/hnT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106E8125A1
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 04:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706330358; cv=none; b=TYzkgXOniNxzT8MnRdtQM/5aCrTM1o3JZRBK8v1wVXqIWhH/Iah0VALWGXiU2ixrTSfNFZlIps6yeOat7QvBXREHWL/lsH+rRQ142hwmZIt53w3iam+bz3IxCLMm4bs8RJaB+1E8fD2KnoFkIAIxkSQ7YEEwJDkzHkvmfcfesOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706330358; c=relaxed/simple;
	bh=4fiw/01Z3QjOocm+IxwZg514WqdmPhoeamFKd+Hs0Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pz8p6EXIEBQNuuixGrwsRghy2Vs1qDoxIEcoasZnYLyrBrFrn5BWmCbg43Bfs56ztL6gC2XLm+RTtRgD/l3ENxGBTAvP+REc9h1wwfNH/jndGsPXMAsARKeWGrc99p/2jIo81qvFzJo6BHSzQirKAH94yrQAkoDvidsGkqsCjz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUNl/hnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575E3C433C7;
	Sat, 27 Jan 2024 04:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706330357;
	bh=4fiw/01Z3QjOocm+IxwZg514WqdmPhoeamFKd+Hs0Ck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QUNl/hnTBQ0UjgYdgq0GETXGDpJbxnquv18MIPpZyIgGAOyfDv7+saeSLOYP/cnZ5
	 mDqU+/lBIOnPh3dgUgVaOxUVMTuNQF5dPbQojL9uS5L1Ddwi6A6kPfT8kz/j7CF5xb
	 3Av0sh7IeEhx2whRnfvuGjh+OeBUo1kGoDkxSc0KxXw1dudIme9hCo6MEpyn+sVmfG
	 BY85Dy9IX2FjEUhnm6mtiiVopFrPTQ4EYO0I25YoBk8PXwYIF/L8nEW9m3vFAvA70S
	 O+q1FfLejFqRaG2v7W04dZdh/I67TF463Sy99Z9YMg/A2DPmMjMJBtjFJ3yySEnj9u
	 +FAFVd85nL7Sw==
Date: Fri, 26 Jan 2024 20:39:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pavel Vazharov <pavel@x3me.net>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind
 a Linux bonding device
Message-ID: <20240126203916.1e5c2eee@kernel.org>
In-Reply-To: <CAJEV1igULtS-e0sBd3G=P1AHr8nqTd3kT+0xc8BL2vAfDM_TuA@mail.gmail.com>
References: <CAJEV1ijxNyPTwASJER1bcZzS9nMoZJqfR86nu_3jFFVXzZQ4NA@mail.gmail.com>
	<87y1cb28tg.fsf@toke.dk>
	<CAJEV1igULtS-e0sBd3G=P1AHr8nqTd3kT+0xc8BL2vAfDM_TuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jan 2024 05:58:55 +0200 Pavel Vazharov wrote:
> > Well, it will be up to your application to ensure that it is not. The
> > XDP program will run before the stack sees the LACP management traffic,
> > so you will have to take some measure to ensure that any such management
> > traffic gets routed to the stack instead of to the DPDK application. My
> > immediate guess would be that this is the cause of those warnings?
>
> Thank you for the response.
> I already checked the XDP program.
> It redirects particular pools of IPv4 (TCP or UDP) traffic to the application.
> Everything else is passed to the Linux kernel.
> However, I'll check it again. Just to be sure.

What device driver are you using, if you don't mind sharing?
The pass thru code path may be much less well tested in AF_XDP
drivers.

