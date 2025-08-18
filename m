Return-Path: <netdev+bounces-214680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FB4B2ADB3
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D87518A6C8F
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EAF283FC3;
	Mon, 18 Aug 2025 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8aUYaC+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10677221294;
	Mon, 18 Aug 2025 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533121; cv=none; b=ko67t/Uf9XE4VUyMHb09qLPfTLsWrxra33KLyJl6IiAnEiTH3uCwVURUjE4HHB2+d1OQbc8oFPoQedoWr0D2O2ayic8VHPQpqHbLNQ0v2aG51JZ5Di1wODXqoCf99/cCfziCCloTdlWBU5DclkNfe7QDUEXd7BQWCzmCRJd3IBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533121; c=relaxed/simple;
	bh=UHJQ5AOO3NWQGsPJiDOZaBcoavjmPk3YU/SIDGJiLyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUxR7bIDz0IaKrgZVCsUlbAznDzzr8mJJmST1obrS5Ub4jCQy8EwEf16kHv5+65P/clX5fBIzB6V4mUrGEtvfCNQzlspjXNEJaplGDSzEBdclOxUMlOfhGGjXQCATnRYM3+sFKwe9s/Pm4SOoSZls14yaaDURZ79XPS5R99FStY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8aUYaC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5487AC4CEEB;
	Mon, 18 Aug 2025 16:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755533120;
	bh=UHJQ5AOO3NWQGsPJiDOZaBcoavjmPk3YU/SIDGJiLyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X8aUYaC+edxp7UNq2Uhvs74jx45Zzsjskpqa+ccARjEADGRxh5HkkZpEoAWFZxdGw
	 4C2oPWJrA+MBnUD7gCFKYT0ZOVozFiB3uS9yNpfp/uyC5sCpr+mTmRW5eqXQUspRV5
	 AM5ODYjFyyITSI1XTe88efBsrxc0x+OyIMo+GekeZgp5NLUgbJfNQ6rKEqKkaqvFrC
	 0q4FMUBvQkfjvO+ilBVtMWa+y6YqFlVFo6f+f2sqTbW1yHN9x+q0KeUiLWITotNXds
	 KvTMUSO6piihyY0vLVnEt5hvotMh1giMieKoi8aWnl1SGkEC+BEZ6IcTrpZ84cTTaY
	 y+80yAFB6NGRw==
Date: Mon, 18 Aug 2025 09:05:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
 dust.li@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, David
 Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH net-next v4] ptp: add Alibaba CIPU PTP clock driver
Message-ID: <20250818090519.33335d5e@kernel.org>
In-Reply-To: <2a98165b-a353-405d-83e0-ffbca1d41340@linux.alibaba.com>
References: <20250812115321.9179-1-guwen@linux.alibaba.com>
	<20250815113814.5e135318@kernel.org>
	<2a98165b-a353-405d-83e0-ffbca1d41340@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Aug 2025 11:52:18 +0800 Wen Gu wrote:
> > This driver is lacking documentation. You need to describe how the user
> > is expected to interact with the device and document all these sysfs
> > attributes.
> >   
> 
> OK. I will add the description.
> 
> Would you prefer me to create a related .rst file under Documentation/
> (perhaps in a new Documentation/clock/ptp/ directory?), or add the
> description comments directly in this driver source?

It's supposed to be user-facing documentation, so Documentation.

But you ignored David Woodhouse's response, and also skirted around
Andrew's comment on OS kernel being an abstraction layer. So if you
plan to post a v5 -- the documentation better clearly explain why
this is a PTP device, and not a real time clock.

