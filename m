Return-Path: <netdev+bounces-100602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AD58FB4DA
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 257A3B2C4D1
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEF01758E;
	Tue,  4 Jun 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa9mgycG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374216FD5
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510123; cv=none; b=DgdkJAUzz4LFJ9472zpeBt/soJuiZBtfXFVBrizqt/B/Oic8NdmMn6SUpQ6uc5Fmv2CwnNxvMHtAboHlBxgWc0beM7wY3Qjge31eP4jVx4YT1j2ss11JJkTTPKCjlbQ06Ac8d1f5tsW5UkBOAHZgptY2w44m6JYM1UwSRDYGc5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510123; c=relaxed/simple;
	bh=T1Ev1/d2rEvhfr3l0LA8s22vj2Zl3EFQTCMj4skJvYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfUFbFBzFFu93JIj4FU8LGUioMHT7eo5zP0b+uN1IEIXqudUMyodtgVKNa2Y60F5P6mvGgXUCo5iDyPZodx4iWEnJgrsN6zCU3sW9hilrHBj++2Wndc0sULTliuu1djKtFx7K05fURxp9gDZoFOZRkIdd9D3O3y1WrlFe4Xddxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa9mgycG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76440C32786;
	Tue,  4 Jun 2024 14:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717510122;
	bh=T1Ev1/d2rEvhfr3l0LA8s22vj2Zl3EFQTCMj4skJvYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oa9mgycGGVSYlMsZmJ/8hFAfR3G0zDAWZnZ7vSt9D7+Hkg0HXRy/LsVBXkGaF3TBU
	 twyA8krhVhMThE4/2tO96hsZ+iFMKhlntLazYbIkpUoWA+uzn7YeCHXJLuupglvlm/
	 c0OBhUpEJZN/t3CUcg8XzgNzmEuKLqsF+u9j1TPMZE7rQuFLbnZpjzjXfIgbrnI5z8
	 h6e+3obntEaNK3PVqu3A4Chcbr1SXWUvsuK1Lc5PIT1aYUJn+D+dfPL72DSofKc3yv
	 49vLCLnYVlYa3OAt+t/q2+mJpdXipRRxCYY3/iUpeZk9ASk1qR0YnXebO8A8V1Z0yG
	 mEn9+eLrh/dBw==
Date: Tue, 4 Jun 2024 07:08:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Subject: Re: [PATCH net v3] rtnetlink: make the "split" NLM_DONE handling
 generic
Message-ID: <20240604070841.438eba41@kernel.org>
In-Reply-To: <6861ace8-febe-43b8-b75a-751af0506c4d@kernel.org>
References: <20240603184826.1087245-1-kuba@kernel.org>
	<6861ace8-febe-43b8-b75a-751af0506c4d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 20:33:50 -0600 David Ahern wrote:
> You are using the legacy way for route, link and address dumps with the
> option to quickly add the others as needed (meaning when a regression is
> reported). If those 3 need the workaround, I think there are high odds
> all of the other rtnl_register users will need it. So, if there is not
> going to be a per-app opt-in to a new way, you might as well make this
> the default for all rtnl families - sadly.

I prefer the default (for new code) to be "modern".

