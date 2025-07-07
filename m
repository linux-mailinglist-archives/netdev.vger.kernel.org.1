Return-Path: <netdev+bounces-204705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB232AFBD78
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADB74A78A2
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592D7287252;
	Mon,  7 Jul 2025 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfAJyzdv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C7426F461
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751923579; cv=none; b=eXyVVP/WDuM5tGKJtXSWUv5s7uTpEvsgoqyBZmViArksSU3qYN5LUy2GSz+//QD54PgSfFy4UycCAwmql22QwugL7thtfSIXugrCdlnqzzNL+QwWKDtCo0uXJHjx5xsBYguGjtltA7LOu35SYFglaR3M01mOA/UD/ton1bxXOjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751923579; c=relaxed/simple;
	bh=YmIRIq0CkNnKyz3DQuyvT2tYy86lfsokLxFOprqeX/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJeToMhQtALN/v56caoy9SOhUcJg2GkO87UWZim3IIm4MnVfhGKySEuv3Iss4SxvkMAmxqKsSYAbxP3Ql8jWg8d0GSEDkelTfRK3WPX0FdBjiQX9cw8hjk2eQ1FrvkDOXGUdGK/hiDAtEWSXpzPPDrObhA9aVDkMWaK6hW2srrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfAJyzdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954DBC4CEE3;
	Mon,  7 Jul 2025 21:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751923578;
	bh=YmIRIq0CkNnKyz3DQuyvT2tYy86lfsokLxFOprqeX/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VfAJyzdvQ36RSZKqK84q+2TKb1j+BiV5Wq+qdDdOOssdMJTerD2yVlYEQP8e/waqE
	 BNdB+zwNY9wGIKDB6aB8GNziIF8MlKQhi2NhG89yrZGN3dzKKqNPF8611H+dVrhuzq
	 RlO7uTcf98EVTUGLyH7oFdBmAxhitCO84cidwaQbTQiv6V74oFIVaNWe9RfMWvaTt0
	 SEVhjTtENO9H7YUeLJllNoAMr+IpgRJDMSE6PZdzrHMx6gpw2+EDjrqP2ehiTxTRW7
	 Ee0jtmixKYqVBiY/eaqlUqoUUptJfrwzDrEudtdHh0bDWIKo3+iI2YE2JQ/vycVHLU
	 lwtB/K9uPUuQA==
Date: Mon, 7 Jul 2025 14:26:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: William Liu <will@willsroot.io>, Cong Wang <xiyou.wangcong@gmail.com>,
 netdev@vger.kernel.org, stephen@networkplumber.org, Savino Dicanosa
 <savy@syst3mfailure.io>
Subject: Re: [Patch net 1/2] netem: Fix skb duplication logic to prevent
 infinite loops
Message-ID: <20250707142617.10849b9e@kernel.org>
In-Reply-To: <CAM0EoM=SPbm6VdjPTTPRjtm7-gXzTvShrG=EdBiO7nCz=uJw0w@mail.gmail.com>
References: <20250701231306.376762-1-xiyou.wangcong@gmail.com>
	<20250701231306.376762-2-xiyou.wangcong@gmail.com>
	<aGSSF7K/M81Pjbyz@pop-os.localdomain>
	<CAM0EoMmDj9TOafynkjVPaBw-9s7UDuS5DoQ_K3kAtioEdJa1-g@mail.gmail.com>
	<CAM0EoMmBdZBzfUAms5-0hH5qF5ODvxWfgqrbHaGT6p3-uOD6vg@mail.gmail.com>
	<aGh2TKCthenJ2xS2@pop-os.localdomain>
	<CAM0EoM=99ufQSzbYZU=wz8fbYOQ2v+cMa7BX1EM6OHk+dBrE0Q@mail.gmail.com>
	<lhR3z8brE3wSKO4PDITIAGXGGW8vnrt1zIPo7C10g2rH0zdQ1lA8zFOuUBklLOTAgMcw4Z6N5YnqRXRzWnkHO-unr5g62msCAUHow-NmY7k=@willsroot.io>
	<CAM0EoM=SPbm6VdjPTTPRjtm7-gXzTvShrG=EdBiO7nCz=uJw0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Jul 2025 16:49:46 -0400 Jamal Hadi Salim wrote:
> > The tc_skb_ext approach has a problem... the config option that
> > enables it is NET_TC_SKB_EXT. I assumed this is a generic name for
> > skb extensions in the tc subsystem, but unfortunately this is
> > hardcoded for NET_CLS_ACT recirculation support.
> >
> > So what this means is we have the following choices:
> > 1. Make SCH_NETEM depend on NET_CLS_ACT and NET_TC_SKB_EXT
> > 2. Add "|| IS_ENABLED(CONFIG_SCH_NETEM)" next to
> > "IS_ENABLED(CONFIG_NET_TC_SKB_EXT)" 3. Separate NET_TC_SKB_EXT and
> > the idea of recirculation support. But I'm not sure how people feel
> > about renaming config options. And this would require a small
> > change to the Mellanox driver subsystem.
> >
> > None of these sound too nice to do, and I'm not sure which approach
> > to take. In an ideal world, 3 would be best, but I'm not sure how
> > others would feel about all that just to account for a netem edge
> > case. 
> 
> I think you should just create a new field/type, add it here:
> include/linux/skbuff.h around line 4814 and make netem just select
> CONFIG_SKB_EXTENSIONS kconfig
> It's not the best solution but we are grasping for straws at this
> point.

Did someone report a real user of nested duplication?

Let's go ahead with the patch preventing such configurations and worry
about supporting them IIF someone actually asks.

