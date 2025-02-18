Return-Path: <netdev+bounces-167524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257AEA3AABD
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29D816A349
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6026B1C8636;
	Tue, 18 Feb 2025 21:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5ZmJSRM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B96B1C861A
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913684; cv=none; b=pn8cm4WrR2wyBRL0sqm/femX5oeGnuqwN3Z7zfTh/vcEN/N4fjH39NmJjHtVrETu/XuTjqe8kGoDU3yahUjFzvxgiLJRUs1qrkFVJh0Zbn0OoDjG2Mo7UF1yyudeDtEEymcwpGqpuTdvvTaUJpa5nCw3lMfqWYQ/XPDFwGJ0SrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913684; c=relaxed/simple;
	bh=hCunBuzHMKs43XRRVfKAsyPpbCRFOpyYSCG4VEaajAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFpkH8mKE2f6EJF2WlTiJWrBvonx57KUf6pqImiXkb3/GGhNAVBxEkgcvxzj0675N5jBYxs6qqNjBmeCtjPcZ9pgjX4XsKunG2MaFPzAh5QzFH/cGvrTeUcmGGPo+EqiaTTPRtCpTWnHi0XoANEXdfudGbNlrKea4ztoyURg15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5ZmJSRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5117EC4CEEB;
	Tue, 18 Feb 2025 21:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739913683;
	bh=hCunBuzHMKs43XRRVfKAsyPpbCRFOpyYSCG4VEaajAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X5ZmJSRM51OJzgTT7puzovUI37Ad8yK1WOPUMqFD/9dy+FFNUsZnN+VWWQWF/g4cT
	 hzUTvOCj2eiUIiLIzHJG9PhkqsV9D4cNyAnLGUek5cWDGvJ4EyuX9Aly5Z7Xc9me4v
	 jKqtG/WS7EN8XNNTt+eAXM/+DF10bjs2bvdxA2vWEzMfW26M97qN/oEbwJLmHybIXP
	 FnbE9BaL80R/Vr+wMOLO0/EMEZ1bN1DVBCbyA/joBNj7lPGO7eXeZRAwl98T6wHuHt
	 26DwSFmAMgNExN8B8YwcmQupEoWQUEl8kjxI59MTucmYKstTFyqF3hlJI08fkAD9aK
	 N/EYe9NAfjNKA==
Date: Tue, 18 Feb 2025 13:21:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, hawk@kernel.org, petrm@nvidia.com, jdamato@fastly.com,
 willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 2/4] selftests: drv-net: add a way to wait for
 a local process
Message-ID: <20250218132122.278a9b00@kernel.org>
In-Reply-To: <Z7T3NqZtfCA5C53W@mini-arch>
References: <20250218195048.74692-1-kuba@kernel.org>
	<20250218195048.74692-3-kuba@kernel.org>
	<Z7T3NqZtfCA5C53W@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 13:10:14 -0800 Stanislav Fomichev wrote:
> > +	env_str = getenv("KSFT_READY_FD");
> > +	if (!env_str)
> > +		return;
> > +
> > +	fd = atoi(env_str);
> > +	if (!fd)
> > +		return;  
> 
> optional nit: should these fail with error() instead of silent return?
> Should guarantee that the caller is doing everything correctly.
> (passing wait_init vs waiting for a port)

My thinking was that you may want to run the helper manually during
development and then the env variable won't be set.

Given that we currently don't expose the stdout/stderr if wait fails
adding a print seemed a little performative..  We need to go back
and provide better support for debug (/verbose output) at some stage.

