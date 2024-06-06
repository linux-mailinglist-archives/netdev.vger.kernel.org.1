Return-Path: <netdev+bounces-101219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429B68FDC74
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 04:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25D52867AB
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9222A749A;
	Thu,  6 Jun 2024 02:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngSH/oCh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D971EAF6
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 02:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717639334; cv=none; b=gtDEdg7h2JMIJqRhNtb/2hNGwWpmfWz4cuDWd9EvXdzufLDtV9FGLc/iYMYU5oIJ+tbnsyHwB+farTFbetAuF0hv3uTuDIIFthzyU0paMXV1hz6McCc3joZ1/l/hb4BQXdZXcFc4oNjp4BKJRachMogkqMWtD+a/V6D+1InDf4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717639334; c=relaxed/simple;
	bh=qCUCIGRecLx0W1F7LiIGV5plJ8i42ruvexaLljJA8EI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFdLKUbcN5qr9DSbjY4gLte2dp9IRVDnZjbQRcohGa3w6E0PASNeK0SJ6BTPc+TSIPHWb9iO2zgej9WZznZ9yde4wBr8OyQEKt/y9qDeH4olLnUtdkbXP5eKBIiMCZ5h/2ilv4Gj9UnI457caxG+j3LcFK69RJ4w27StlvLrnmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngSH/oCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9326AC2BD11;
	Thu,  6 Jun 2024 02:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717639333;
	bh=qCUCIGRecLx0W1F7LiIGV5plJ8i42ruvexaLljJA8EI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ngSH/oChJdFDjJqhNfXGKgpL/5Xm3aJF5NTvOhoZxSFzq84VWKzQXwdNAHJZtT0Xb
	 oof0QqH1HPI5ZRHwORYBiRSh6tqoCNfVD41dRsC20QgLbr7ANg/fRNfeGZubDlwFWc
	 bwNsnCuy3n5v1/rUc/MtlY5+VqM3ucv/nzTwYrNmCqXblXoMI23jZrvQA99Y4R7n1E
	 fxIHY0bqnuEIObLRCwLvwUh9pDl/JNIcRQsgv9tXqO+k4dNcZl3Bo+KS1NsCobgVc8
	 dtDEowLRsbtqD5QoyvBi5bJAMxfsPcR9uCVVS4U1BXwc9oPPbJtpxCQlL6RUeEY6kB
	 Mgysus+4AbP6w==
Date: Wed, 5 Jun 2024 19:02:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] net: core: Unify dstats with tstats and
 lstats, add generic collection helper
Message-ID: <20240605190212.7360a27a@kernel.org>
In-Reply-To: <20240605-dstats-v2-0-7fae03f813f3@codeconstruct.com.au>
References: <20240605-dstats-v2-0-7fae03f813f3@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Jun 2024 17:42:56 +0800 Jeremy Kerr wrote:
> This change unifies dstats with the other types, adds a collection
> helper (dev_get_dstats64) for ->ndo_get_stats64, and updates the single
> driver (vrf) to use this helper.

I think you can go further, instead of exporting the helpers and
hooking them in the driver, just add the handling based on
pcpu_stat_type directly in dev_get_stats().

