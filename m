Return-Path: <netdev+bounces-72408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5F6857F32
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 15:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9814B21A52
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FF412CD9A;
	Fri, 16 Feb 2024 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuJoMt6k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DF2129A98
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093386; cv=none; b=RJSueli1/quWvVTKWgqfQjpPZwSlM1RxdhPt/vcmrM6YTBuNpJKDKGj0fo8QRbE0Z7jZcqTEwjoJskxnRIsPMdXM12mRMZdH/m+kKaHfi3bnII9IFgO1xVTcpdj+EdjogTPTt9GixbFicksTcNyPYooVBHc20Z672fXs2Bkfkxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093386; c=relaxed/simple;
	bh=43WCqBhdRA6zo4LNP7kqS2yxm+KtQr+uHeTnhRLMFOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZyl9LW6xQKpUGm9Krjl5VCdUT9Br6VoS13JZGPQl5k2gyjGOW4WjU7MjPTYda/jHPfst3uwhBQAE3jcWh4j00SwZX+uNr9sfUG2e4XVAmLX3rgPna6kivnkaWyrdTWTqeg04AYlCg7V0g83Yb8pTJmjvPrFjxXiz5sgoar7zgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuJoMt6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C05DC433F1;
	Fri, 16 Feb 2024 14:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708093385;
	bh=43WCqBhdRA6zo4LNP7kqS2yxm+KtQr+uHeTnhRLMFOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AuJoMt6knDajRdBbYcQd1zXRI02RWeOKpd6HRNuxZRLVENP4S4wLB343LqtRmdLiE
	 Gomr7+fXy3fT+aRXiIqI+hWH4aQ+0yvWF5+M7KFarLEOWMs1RpsLUvnyZdVFYJIi28
	 Gs8Sn/uSe6a4hvBm5vFTFIHfuWkTsjBkv0+Z/ffbV40i8gKXtpBrRwNTjagDpiIfpb
	 EaP+sK6Zl5IuyNKBCmHizAiqMu3cKLRe1oBUaIk2VtDCEdqFQR+aXqwWV9gYIMjr6K
	 dpcTaniECSF2R/6Thk8itJ4LAGiAjF6c7XCbPuPODWAtHKzHRCUE0I37xcSKZX+CKh
	 VLwJ0ib5ID1xg==
Date: Fri, 16 Feb 2024 06:23:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Howells <dhowells@redhat.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Liang Chen <liangchen.linux@gmail.com>,
 Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH net-next 10/11] net: mctp: tests: Test that outgoing
 skbs have flow data populated
Message-ID: <20240216062304.2c3428d9@kernel.org>
In-Reply-To: <73b3194049ea75649cc22c17f7d11fa6f9487894.1708071380.git.jk@codeconstruct.com.au>
References: <cover.1708071380.git.jk@codeconstruct.com.au>
	<73b3194049ea75649cc22c17f7d11fa6f9487894.1708071380.git.jk@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 16:19:20 +0800 Jeremy Kerr wrote:
> +static void mctp_test_packet_flow(struct kunit *test)
> +{
> +	kunit_skip(test, "Requires CONFIG_MCTP_FLOWS=y");
> +}
> +
> +static void mctp_test_fragment_flow(struct kunit *test)
> +{
> +	kunit_skip(test, "Requires CONFIG_MCTP_FLOWS=y");
> +}

These two get skipped when running:

./tools/testing/kunit/kunit.py run --alltests

Is it possible to make all-test include the right config option
automatically, so they can run?

